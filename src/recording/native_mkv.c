#include "native_mkv.h"
#include <string.h>
#define EBML_LIMIT UINT64_C(0x00ffffffffffffff)
struct Bytes {uint8_t b[384];uint32_t n;};
static void be(struct Bytes *b,uint64_t n,unsigned k){for(unsigned i=k;i;--i)b->b[b->n++]=(uint8_t)(n>>(8*(i-1)));}
static void le(struct Bytes *b,uint64_t n,unsigned k){for(unsigned i=0;i<k;++i)b->b[b->n++]=(uint8_t)(n>>(8*i));}
static unsigned size_length(uint64_t n){unsigned k=1;while(k<8&&n>=(UINT64_C(1)<<(7*k))-1)++k;return k;}
static void size(struct Bytes *b,uint64_t n,unsigned k){if(!k)k=size_length(n);be(b,n|(UINT64_C(1)<<(7*k)),k);}
static void elem(struct Bytes *b,uint32_t id,unsigned len,const struct Bytes *v){be(b,id,len);size(b,v->n,0);memcpy(b->b+b->n,v->b,v->n);b->n+=v->n;}
static void uint_elem(struct Bytes *b,uint32_t id,unsigned len,uint64_t n,unsigned k){struct Bytes v={{0},0};be(&v,n,k);elem(b,id,len,&v);}
static void str_elem(struct Bytes *b,uint32_t id,unsigned len,const char *p){struct Bytes v={{0},0};while(*p)v.b[v.n++]=(uint8_t)*p++;elem(b,id,len,&v);}
static uint32_t crc(uint32_t c,const uint8_t *p,size_t n){while(n--){c^=*p++;for(unsigned i=0;i<8;++i)c=(c>>1)^((c&1)?0xedb88320u:0);}return c;}
static enum Iq4MkvStatus fail(struct Iq4Mkv *m,enum Iq4MkvStatus why){m->state=IQ4_MKV_FAILED;return why;}
static enum Iq4MkvStatus append(struct Iq4Mkv *m,const uint8_t *p,uint32_t n){
 uint32_t off=0;
 while(off<n){struct F3Io r=m->io.append(m->io.context,p+off,n-off);
  if(r.state!=F3_IO_DONE){m->state=r.state==F3_IO_FAIL?IQ4_MKV_FAILED:IQ4_MKV_UNKNOWN;return r.state==F3_IO_FAIL?IQ4_MKV_IO:IQ4_MKV_HOLD;}
  if(!r.value||r.value>n-off)return fail(m,IQ4_MKV_IO);
  off+=(uint32_t)r.value;m->file_bytes+=r.value;
 }
 return IQ4_MKV_OK;
}
static struct Bytes header(struct Iq4Mkv *m,uint32_t w,uint32_t h){
 struct Bytes b={{0},0},ebml={{0},0},info={{0},0},track={{0},0},video={{0},0},tracks={{0},0};
 uint_elem(&ebml,0x4286,2,1,1);uint_elem(&ebml,0x42f7,2,1,1);
 uint_elem(&ebml,0x42f2,2,4,1);uint_elem(&ebml,0x42f3,2,8,1);
 str_elem(&ebml,0x4282,2,"matroska");uint_elem(&ebml,0x4287,2,4,1);uint_elem(&ebml,0x4285,2,2,1);elem(&b,0x1a45dfa3,4,&ebml);
 be(&b,0x18538067,4);m->segment_size_offset=b.n;be(&b,UINT64_C(0x01ffffffffffffff),8);m->segment_start=b.n;
 uint_elem(&info,0x2ad7b1,3,1,1);str_elem(&info,0x4d80,2,"iq4-mjpeg-native-0.3");str_elem(&info,0x5741,2,"iq4-mjpeg-native-0.3");elem(&b,0x1549a966,4,&info);
 uint_elem(&track,0xd7,1,1,1);uint_elem(&track,0x73c5,2,1,1);uint_elem(&track,0x83,1,1,1);uint_elem(&track,0x9c,1,0,1);str_elem(&track,0x86,1,"V_MJPEG");
 uint_elem(&video,0xb0,1,w,2);uint_elem(&video,0xba,1,h,2);elem(&track,0xe0,1,&video);elem(&tracks,0xae,1,&track);elem(&b,0x1654ae6b,4,&tracks);
 return b;
}
enum Iq4MkvStatus iq4_mkv_begin(struct Iq4Mkv *m,const struct Iq4MkvIo *io,
 uint32_t w,uint32_t h,uint64_t max_file,uint32_t max_packet,uint32_t max_frames){
 if(!m||!io||!io->append||!io->patch||!w||!h||w>65500||h>65500||
    !max_frames||max_frames>1000000||max_packet<16||max_packet>32u*1024u*1024u||
    max_file<4096||max_file>UINT64_C(4294967295))return IQ4_MKV_ARGUMENT;
 if(m->state!=IQ4_MKV_IDLE)return IQ4_MKV_STATE;
 *m=(struct Iq4Mkv){0};m->io=*io;m->width=w;m->height=h;m->max_file_bytes=max_file;
 m->max_packet_bytes=max_packet;m->max_frames=max_frames;m->state=IQ4_MKV_WRITING;
 struct Bytes b=header(m,w,h);return append(m,b.b,b.n);
}
enum Iq4MkvStatus iq4_mkv_packet(struct Iq4Mkv *m,const uint8_t *jpeg,uint32_t n,
 uint64_t ns,uint64_t local){
 if(!m)return IQ4_MKV_ARGUMENT;
 if(m->state==IQ4_MKV_UNKNOWN)return IQ4_MKV_HOLD;
 if(m->state!=IQ4_MKV_WRITING)return IQ4_MKV_STATE;
 if(!jpeg||n<16||n>m->max_packet_bytes||!local)return fail(m,IQ4_MKV_PACKET);
 if(m->frames&&(ns<=m->last_observed_ns||local<=m->last_local_sequence))return fail(m,IQ4_MKV_ORDER);
 if(m->frames>=m->max_frames||m->file_bytes>m->max_file_bytes||
    (uint64_t)n+73>m->max_file_bytes-m->file_bytes)return fail(m,IQ4_MKV_LIMIT);
 struct F3JpegSyntax syntax;f3_jpeg_syntax_init_02(&syntax);
 if(!f3_jpeg_syntax_feed_02(&syntax,jpeg,n)||!f3_jpeg_syntax_done_02(&syntax,m->width,m->height))return fail(m,IQ4_MKV_PACKET);
 uint64_t first=m->frames?m->first_observed_ns:ns;
 struct Bytes prefix={{0},0},timing={{0},0},journal={{0},0};
 be(&prefix,0x1f43b675,4);size(&prefix,(uint64_t)n+61,8);uint_elem(&prefix,0xe7,1,ns-first,8);be(&prefix,0xa3,1);size(&prefix,(uint64_t)n+4,8);be(&prefix,UINT64_C(0x81000080),4);
 memcpy(timing.b,"IQ4T",4);timing.n=4;le(&timing,2,4);le(&timing,ns,8);le(&timing,local,8);
 /* Version2 flag2 means software completion identity, never sensor sequence. */
 le(&timing,2,4);le(&timing,n,4);le(&timing,~crc(crc(0xffffffffu,jpeg,n),timing.b,32),4);elem(&journal,0xec,1,&timing);
 enum Iq4MkvStatus rc=append(m,prefix.b,prefix.n);if(rc!=IQ4_MKV_OK)return rc;
 rc=append(m,jpeg,n);if(rc!=IQ4_MKV_OK)return rc;
 rc=append(m,journal.b,journal.n);if(rc!=IQ4_MKV_OK)return rc;
 m->first_observed_ns=first;m->last_observed_ns=ns;m->last_local_sequence=local;++m->frames;return IQ4_MKV_OK;
}
enum Iq4MkvStatus iq4_mkv_seal(struct Iq4Mkv *m){
 if(!m)return IQ4_MKV_ARGUMENT;
 if(m->state==IQ4_MKV_UNKNOWN)return IQ4_MKV_HOLD;
 if(m->state!=IQ4_MKV_WRITING||!m->frames)return IQ4_MKV_STATE;
 if(m->file_bytes<m->segment_start||m->file_bytes-m->segment_start>=EBML_LIMIT)return fail(m,IQ4_MKV_LIMIT);
 struct Bytes b={{0},0};size(&b,m->file_bytes-m->segment_start,8);
 uint32_t off=0;
 while(off<8){struct F3Io r=m->io.patch(m->io.context,m->segment_size_offset+off,b.b+off,8-off);
  if(r.state!=F3_IO_DONE){m->state=r.state==F3_IO_FAIL?IQ4_MKV_FAILED:IQ4_MKV_UNKNOWN;return r.state==F3_IO_FAIL?IQ4_MKV_IO:IQ4_MKV_HOLD;}
  if(!r.value||r.value>8-off)return fail(m,IQ4_MKV_IO);
  off+=(uint32_t)r.value;
 }
 m->state=IQ4_MKV_SEALED;return IQ4_MKV_OK;
}
static uint64_t read_be(const uint8_t *p,unsigned n){uint64_t v=0;while(n--)v=(v<<8)|*p++;return v;}
static uint64_t read_le(const uint8_t *p,unsigned n){uint64_t v=0;for(unsigned i=0;i<n;++i)v|=(uint64_t)p[i]<<(8*i);return v;}
static enum Iq4MkvScanStatus read_exact(struct Iq4MkvScan *s,uint64_t at,uint8_t *p,uint32_t n){
 if(s->hold)return IQ4_MKV_SCAN_HOLD;
 uint32_t off=0;
 while(off<n){struct F3Io r=s->reader.read_at(s->reader.context,at+off,p+off,n-off);
  if(r.state!=F3_IO_DONE){if(r.state!=F3_IO_FAIL){s->hold=1;return IQ4_MKV_SCAN_HOLD;}return IQ4_MKV_SCAN_IO;}
  if(!r.value||r.value>n-off)return IQ4_MKV_SCAN_IO;
  off+=(uint32_t)r.value;
 }
 return IQ4_MKV_SCAN_PACKET;
}
enum Iq4MkvScanStatus iq4_mkv_scan_begin(struct Iq4MkvScan *s,const struct Iq4MkvReader *r,
 uint64_t bytes,uint32_t w,uint32_t h,uint32_t limit){
 if(!s||!r||!r->read_at||!w||!h||w>65500||h>65500||bytes>UINT64_C(4294967295)||
    limit<16||limit>32u*1024u*1024u||s->offset||s->hold)return IQ4_MKV_SCAN_ARGUMENT;
 *s=(struct Iq4MkvScan){0};s->reader=*r;s->file_bytes=bytes;s->width=w;s->height=h;s->packet_limit=limit;
 struct Iq4Mkv shape={0};struct Bytes expected=header(&shape,w,h);uint8_t actual[384];
 if(bytes<expected.n)return IQ4_MKV_SCAN_FORMAT;
 enum Iq4MkvScanStatus rc=read_exact(s,0,actual,expected.n);if(rc!=IQ4_MKV_SCAN_PACKET)return rc;
 for(uint32_t i=0;i<expected.n;++i)if(i<shape.segment_size_offset||i>=shape.segment_start){if(actual[i]!=expected.b[i])return IQ4_MKV_SCAN_FORMAT;}
 if(actual[shape.segment_size_offset]!=1)return IQ4_MKV_SCAN_FORMAT;
 s->offset=expected.n;return IQ4_MKV_SCAN_PACKET;
}
enum Iq4MkvScanStatus iq4_mkv_scan_next(struct Iq4MkvScan *s,uint8_t *packet,uint32_t cap,
 uint32_t *bytes,uint64_t *ns,uint64_t *local){
 if(!s||!packet||!bytes||!ns||!local||!s->offset)return IQ4_MKV_SCAN_ARGUMENT;
 *bytes=0;*ns=0;*local=0;
 if(s->hold)return IQ4_MKV_SCAN_HOLD;
 if(s->ended)return IQ4_MKV_SCAN_END;
 if(s->offset>s->file_bytes||s->file_bytes-s->offset<35){s->ended=1;return IQ4_MKV_SCAN_END;}
 uint8_t p[35],t[38];enum Iq4MkvScanStatus rc=read_exact(s,s->offset,p,35);if(rc!=IQ4_MKV_SCAN_PACKET)return rc;
 uint64_t cluster=read_be(p+5,7),block=read_be(p+24,7);
 if(read_be(p,4)!=0x1f43b675||p[4]!=1||p[12]!=0xe7||p[13]!=0x88||p[22]!=0xa3||p[23]!=1||
    read_be(p+31,4)!=0x81000080||block<20||block-4>s->packet_limit||cluster!=block-4+61){s->ended=1;return IQ4_MKV_SCAN_END;}
 uint32_t n=(uint32_t)(block-4);
 if(cap<n)return IQ4_MKV_SCAN_ARGUMENT;
 if((uint64_t)n+73>s->file_bytes-s->offset){s->ended=1;return IQ4_MKV_SCAN_END;}
 rc=read_exact(s,s->offset+35,packet,n);if(rc!=IQ4_MKV_SCAN_PACKET)return rc;
 rc=read_exact(s,s->offset+35+n,t,38);if(rc!=IQ4_MKV_SCAN_PACKET)return rc;
 uint64_t stamp=read_le(t+10,8),id=read_le(t+18,8),first=s->frames?s->first_ns:stamp;
 struct F3JpegSyntax syntax;f3_jpeg_syntax_init_02(&syntax);
 if(t[0]!=0xec||t[1]!=0xa4||memcmp(t+2,"IQ4T",4)||read_le(t+6,4)!=2||read_le(t+26,4)!=2||read_le(t+30,4)!=n||
    !id||stamp<first||(s->frames&&(stamp<=s->last_ns||id<=s->last_local_sequence))||
    read_be(p+14,8)!=stamp-first||read_le(t+34,4)!=(uint64_t)~crc(crc(0xffffffffu,packet,n),t+2,32)||
    !f3_jpeg_syntax_feed_02(&syntax,packet,n)||!f3_jpeg_syntax_done_02(&syntax,s->width,s->height)){
  s->ended=1;return IQ4_MKV_SCAN_END;
 }
 s->offset+=(uint64_t)n+73;s->first_ns=first;s->last_ns=stamp;s->last_local_sequence=id;++s->frames;
 *bytes=n;*ns=stamp;*local=id;return IQ4_MKV_SCAN_PACKET;
}
