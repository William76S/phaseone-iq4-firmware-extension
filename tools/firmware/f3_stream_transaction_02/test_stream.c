#include "stream.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
#define SIZE 131073u
static uint8_t input[SIZE],stored[SIZE],scratch[F3_STREAM_SCRATCH];
static const uint8_t header[]={255,216,255,192,0,17,8,0,48,0,64,3,1,17,0,2,17,0,3,17,0,255,218,0,12,3,1,0,2,0,3,0,0,63,0};
struct Mock{unsigned checks,fail_phase,unknown_phase,short_phase,corrupt,swap_inode,swap_size,removed,published,write_open,read_open,unknown,after_unknown,calls;size_t written,read_off;struct F3File file;};
static struct F3Io io(struct Mock*m,unsigned phase,uint64_t n){++m->calls;if(m->unknown)++m->after_unknown;
 if(m->unknown_phase==phase){m->unknown=1;return(struct F3Io){F3_IO_UNKNOWN,0};}
 if(m->fail_phase==phase)return(struct F3Io){F3_IO_FAIL,0};return(struct F3Io){F3_IO_DONE,m->short_phase==phase?n-1:n};}
static struct F3Io raw(void*v,const struct F3Job*j){struct Mock*m=v;assert(j->raw.bytes==1000&&j->raw.task_nonce==9);return io(m,++m->checks==1?1:15,1);}
static struct F3Io openw(void*v,const struct F3Job*j,struct F3File*f){struct Mock*m=v;*f=(struct F3File){11,22,j->raw.card_epoch,j->raw.task_nonce,0};struct F3Io r=io(m,2,1);if(r.state==F3_IO_DONE)m->write_open=1;return r;}
static struct F3Io wr(void*v,const uint8_t*p,uint32_t n){struct Mock*m=v;assert(m->write_open);struct F3Io r=io(m,4,n);
 if(r.state==F3_IO_DONE){assert(m->written+r.value<=SIZE);memcpy(stored+m->written,p,(size_t)r.value);m->written+=(size_t)r.value;}return r;}
static struct F3Io cw(void*v){struct Mock*m=v;assert(m->write_open);struct F3Io r=io(m,6,1);if(r.state!=F3_IO_UNKNOWN)m->write_open=0;return r;}
static struct F3Io openr(void*v,const struct F3File*f,struct F3File*out){struct Mock*m=v;assert(!m->write_open);*out=*f;out->bytes=m->written;if(m->swap_inode)out->inode++;m->file=*out;struct F3Io r=io(m,7,1);if(r.state==F3_IO_DONE)m->read_open=1;return r;}
static struct F3Io rd(void*v,uint8_t*p,uint32_t n){struct Mock*m=v;assert(m->read_open);struct F3Io r=io(m,9,n);
 if(r.state==F3_IO_DONE){assert(m->read_off+r.value<=m->written);memcpy(p,stored+m->read_off,(size_t)r.value);m->read_off+=(size_t)r.value;if(m->corrupt&&m->read_off>40)p[n/2]^=1;}return r;}
static struct F3Io statr(void*v,struct F3File*out){struct Mock*m=v;assert(m->read_open);*out=m->file;if(m->swap_size)out->bytes++;return io(m,11,1);}
static struct F3Io cr(void*v){struct Mock*m=v;assert(m->read_open);struct F3Io r=io(m,13,1);if(r.state!=F3_IO_UNKNOWN)m->read_open=0;return r;}
static struct F3Io pub(void*v,const struct F3File*f){struct Mock*m=v;assert(!m->write_open&&!m->read_open&&f->bytes==SIZE);struct F3Io r=io(m,14,1);if(r.state==F3_IO_DONE)m->published=1;return r;}
static struct F3Io rmraw(void*v,const struct F3Job*j){struct Mock*m=v;assert(m->published&&m->checks==2&&j->purpose==F3_NEW_CAPTURE&&j->newly_created_raw_stage);struct F3Io r=io(m,16,1);if(r.state==F3_IO_DONE)m->removed=1;return r;}
static struct F3Ports ports(struct Mock*m){return(struct F3Ports){m,raw,openw,wr,cw,openr,rd,statr,cr,pub,rmraw};}
static struct F3Job job(void){struct F3Job j={0};j.boot_epoch=1;j.capture_id=2;j.mode=F3_JPEG_ONLY;j.purpose=F3_NEW_CAPTURE;j.newly_created_raw_stage=1;
 j.source_raw_width=14204;j.source_raw_height=10652;j.render_source_kind=1;j.render_width=j.output_width=64;j.render_height=j.output_height=48;
 j.raw=(struct F3File){11,12,13,9,1000};j.render_source=j.raw;return j;}
static const struct F3StreamResult *simulate(struct F3Stream*c,struct F3Session*s,struct Mock*m,struct F3Job*j,size_t chunk){
 struct F3Ports p=ports(m);if(!f3_stream_begin_02(c,s,j,&p,SIZE,scratch,sizeof(scratch)))return &c->result;
 for(size_t off=0;off<SIZE;){size_t n=SIZE-off;if(n>chunk)n=chunk;if(f3_stream_sink_write_02(c,input+off,n)!=n)return f3_stream_abort_02(c);off+=n;}
 struct F3EncoderCompletion e={1,1,1,48,SIZE};return f3_stream_finish_02(c,&e);}
static void sha_check(const void*p,size_t n,size_t chunk,const char*expected){F4Sha s;char out[65];f4_sha_init(&s);for(size_t off=0;off<n;){size_t k=n-off;if(k>chunk)k=chunk;f4_sha_update(&s,(const uint8_t*)p+off,k);off+=k;}f4_sha_end(&s,out);assert(!strcmp(out,expected));}
int main(void){
 unsigned tests=0;sha_check("",0,1,"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");++tests;
 sha_check("abc",3,1,"ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad");++tests;
 static const char longv[]="abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq";
 sha_check(longv,sizeof(longv)-1,7,"248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1");++tests;
 F4Sha hs;char hex[65];uint8_t a[1000];memset(a,'a',sizeof(a));f4_sha_init(&hs);for(unsigned i=0;i<1000;++i)f4_sha_update(&hs,a,sizeof(a));f4_sha_end(&hs,hex);assert(!strcmp(hex,"cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0"));++tests;
 memset(input,2,sizeof(input));memcpy(input,header,sizeof(header));input[SIZE-2]=255;input[SIZE-1]=217;
 struct Mock m={0};struct F3Stream c={0};struct F3Session s={1,0,0};struct F3Job j=job();const struct F3StreamResult*r=simulate(&c,&s,&m,&j,16384);
 assert(r->saved.status==F3_JPEG_ONLY_DONE&&r->saved.raw_removed&&r->saved.published&&r->saved.verified_bytes==SIZE&&r->saved.write_calls==9&&r->saved.read_calls==3&&r->encoder_finish_checked&&r->jpeg_structure_checked&&!strcmp(r->encoded_sha256,r->readback_sha256)&&!s.hold&&!s.in_progress);++tests;
 m=(struct Mock){0};c=(struct F3Stream){0};s=(struct F3Session){1,0,0};j.mode=F3_RAW_JPEG;r=simulate(&c,&s,&m,&j,1);assert(r->saved.status==F3_JPEG_WITH_RAW&&!m.removed&&r->saved.write_calls==SIZE);++tests;
 m=(struct Mock){0};c=(struct F3Stream){0};s=(struct F3Session){1,0,0};j=job();j.purpose=F3_MANUAL_EXISTING_RAW;j.newly_created_raw_stage=0;r=simulate(&c,&s,&m,&j,32768);assert(r->saved.status==F3_JPEG_WITH_RAW&&!m.removed);++tests;
 m=(struct Mock){0};c=(struct F3Stream){0};s=(struct F3Session){1,0,0};j=job();j.mode=F3_RAW;r=simulate(&c,&s,&m,&j,1024);assert(r->saved.status==F3_RAW_RETAINED&&m.calls==1&&!s.in_progress);++tests;
 const unsigned phases[]={1,2,4,6,7,9,11,13,14,15,16};
 for(size_t i=0;i<sizeof(phases)/sizeof(phases[0]);++i){
  m=(struct Mock){0};m.fail_phase=phases[i];c=(struct F3Stream){0};s=(struct F3Session){1,0,0};j=job();r=simulate(&c,&s,&m,&j,16384);
  assert(r->saved.status==F3_FAILED_RAW_RETAINED&&!m.removed&&!m.write_open&&!m.read_open&&!s.hold&&!s.in_progress);++tests;
  m=(struct Mock){0};m.unknown_phase=phases[i];c=(struct F3Stream){0};s=(struct F3Session){1,0,0};r=simulate(&c,&s,&m,&j,16384);
  assert(r->saved.status==F3_UNKNOWN_HOLD&&!m.after_unknown&&!m.removed&&s.hold&&s.in_progress);
  unsigned calls=m.calls;assert(!f3_stream_sink_write_02(&c,input,64));f3_stream_abort_02(&c);struct F3EncoderCompletion e={1,1,1,48,SIZE};f3_stream_finish_02(&c,&e);
  struct F3Stream next={0};struct F3Ports p=ports(&m);assert(!f3_stream_begin_02(&next,&s,&j,&p,SIZE,scratch,sizeof(scratch)));assert(m.calls==calls&&!m.after_unknown);++tests;
 }
 m=(struct Mock){0};m.short_phase=4;c=(struct F3Stream){0};s=(struct F3Session){1,0,0};j=job();r=simulate(&c,&s,&m,&j,16384);assert(r->accepted_prefix_bytes==16383&&!m.published&&!m.removed&&r->saved.close_write_calls==1);++tests;
 m=(struct Mock){0};m.short_phase=9;c=(struct F3Stream){0};s=(struct F3Session){1,0,0};r=simulate(&c,&s,&m,&j,16384);assert(r->saved.status==F3_FAILED_RAW_RETAINED&&!m.published&&!m.removed&&r->saved.close_read_calls==1);++tests;
 m=(struct Mock){0};m.corrupt=1;c=(struct F3Stream){0};s=(struct F3Session){1,0,0};r=simulate(&c,&s,&m,&j,16384);assert(r->saved.status==F3_FAILED_RAW_RETAINED&&strcmp(r->encoded_sha256,r->readback_sha256)&&!m.published&&!m.removed);++tests;
 m=(struct Mock){0};m.swap_inode=1;c=(struct F3Stream){0};s=(struct F3Session){1,0,0};r=simulate(&c,&s,&m,&j,16384);assert(r->saved.failure_step==8&&!m.published&&!m.removed);++tests;
 m=(struct Mock){0};m.swap_size=1;c=(struct F3Stream){0};s=(struct F3Session){1,0,0};r=simulate(&c,&s,&m,&j,16384);assert(r->saved.failure_step==11&&!m.published&&!m.removed);++tests;
 /* Successful prefix/EOI is insufficient unless encoder finish, all rows and normal destroy return. */
 for(unsigned bad=0;bad<5;++bad){m=(struct Mock){0};c=(struct F3Stream){0};s=(struct F3Session){1,0,0};struct F3Ports p=ports(&m);assert(f3_stream_begin_02(&c,&s,&j,&p,SIZE,scratch,sizeof(scratch)));assert(f3_stream_sink_write_02(&c,input,SIZE)==SIZE);struct F3EncoderCompletion e={1,1,1,48,SIZE};if(bad==0)e.succeeded=0;if(bad==1)e.finish_returned=0;if(bad==2)e.cleanup_returned=0;if(bad==3)e.rows_encoded=47;if(bad==4)e.jpeg_bytes=SIZE-1;r=f3_stream_finish_02(&c,&e);assert(r->saved.status==F3_FAILED_RAW_RETAINED&&!m.published&&!m.removed&&!s.in_progress);++tests;}
 m=(struct Mock){0};c=(struct F3Stream){0};s=(struct F3Session){1,0,0};struct F3Ports p=ports(&m);assert(f3_stream_begin_02(&c,&s,&j,&p,SIZE-1,scratch,sizeof(scratch)));assert(!f3_stream_sink_write_02(&c,input,SIZE));r=f3_stream_abort_02(&c);assert(!m.written&&!m.published&&!m.removed);++tests;
 m=(struct Mock){0};c=(struct F3Stream){0};s=(struct F3Session){1,0,0};p=ports(&m);j=job();j.render_source.inode++;assert(!f3_stream_begin_02(&c,&s,&j,&p,SIZE,scratch,sizeof(scratch))&&!m.calls);++tests;
 m=(struct Mock){0};c=(struct F3Stream){0};s=(struct F3Session){2,0,0};j=job();assert(!f3_stream_begin_02(&c,&s,&j,&p,SIZE,scratch,sizeof(scratch))&&!m.calls);++tests;
 struct F3JpegSyntax syn;f3_jpeg_syntax_init_02(&syn);for(size_t i=0;i<SIZE;++i)assert(f3_jpeg_syntax_feed_02(&syn,input+i,1));assert(f3_jpeg_syntax_done_02(&syn,64,48));uint8_t extra=0;assert(!f3_jpeg_syntax_feed_02(&syn,&extra,1));++tests;
 f3_jpeg_syntax_init_02(&syn);assert(f3_jpeg_syntax_feed_02(&syn,input,SIZE-1)&&!f3_jpeg_syntax_done_02(&syn,64,48));++tests;
 f3_jpeg_syntax_init_02(&syn);input[5]=16;assert(!f3_jpeg_syntax_feed_02(&syn,input,SIZE));input[5]=17;++tests;
 f3_jpeg_syntax_init_02(&syn);input[3]=194;assert(!f3_jpeg_syntax_feed_02(&syn,input,SIZE));input[3]=192;++tests;
 f3_jpeg_syntax_init_02(&syn);input[33]=62;assert(!f3_jpeg_syntax_feed_02(&syn,input,SIZE));input[33]=63;++tests;
 f3_jpeg_syntax_init_02(&syn);input[15]=1;assert(!f3_jpeg_syntax_feed_02(&syn,input,SIZE));input[15]=2;++tests;
 f3_jpeg_syntax_init_02(&syn);input[100]=255;input[101]=0;assert(f3_jpeg_syntax_feed_02(&syn,input,101));assert(f3_jpeg_syntax_feed_02(&syn,input+101,SIZE-101)&&f3_jpeg_syntax_done_02(&syn,64,48));input[100]=input[101]=2;++tests;
 printf("{\"owned_stream_fault_groups\":%u,\"passed\":true,\"target_executed\":false,\"native_ports_bound\":false}\n",tests);return 0;
}
