#include "../../../src/recording/native_mkv.h"
#include "../f4_native_source_02/worker.h"
#include "../f3_native_jpeg8_binding_01/native_jpeg82.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

enum {W=64,H=48,CAP=65536,FILECAP=1024*1024};
struct Port {uint8_t *data;size_t n;unsigned calls,short_io,unknown,fail;};
static struct Port port(void){struct Port p={0};p.data=malloc(FILECAP);assert(p.data);return p;}
static void dispose(struct Port *p){free(p->data);memset(p,0,sizeof*p);}
static struct F3Io append(void *ctx,const uint8_t *p,uint32_t n){struct Port *s=ctx;++s->calls;if(s->short_io&&n>17)n=17;assert(s->n+n<=FILECAP);memcpy(s->data+s->n,p,n);s->n+=n;return(struct F3Io){F3_IO_DONE,n};}
static struct F3Io patch(void *ctx,uint64_t at,const uint8_t *p,uint32_t n){struct Port *s=ctx;++s->calls;if(s->short_io&&n>3)n=3;assert(at+n<=s->n);memcpy(s->data+at,p,n);return(struct F3Io){F3_IO_DONE,n};}
static struct F3Io read_at(void *ctx,uint64_t at,uint8_t *p,uint32_t n){struct Port *s=ctx;++s->calls;if(s->unknown)return(struct F3Io){F3_IO_UNKNOWN,0};if(s->fail)return(struct F3Io){F3_IO_FAIL,0};if(s->short_io&&n>11)n=11;assert(at+n<=s->n);memcpy(p,s->data+at,n);return(struct F3Io){F3_IO_DONE,n};}
static struct Iq4Mkv writer(struct Port *p){struct Iq4Mkv m={0};struct Iq4MkvIo io={p,append,patch};assert(iq4_mkv_begin(&m,&io,W,H,FILECAP,CAP,10)==IQ4_MKV_OK);return m;}
static struct Iq4MkvScan scanner(struct Port *p){struct Iq4MkvScan s={0};struct Iq4MkvReader r={p,read_at};assert(iq4_mkv_scan_begin(&s,&r,p->n,W,H,CAP)==IQ4_MKV_SCAN_PACKET);return s;}
static uint32_t crc(uint32_t c,const uint8_t *p,size_t n){while(n--){c^=*p++;for(unsigned i=0;i<8;++i)c=(c>>1)^((c&1)?0xedb88320u:0);}return c;}
static void le(uint8_t *p,uint64_t n,unsigned k){for(unsigned i=0;i<k;++i)p[i]=(uint8_t)(n>>(8*i));}
static void be(uint8_t *p,uint64_t n,unsigned k){for(unsigned i=0;i<k;++i)p[i]=(uint8_t)(n>>(8*(k-1-i)));}
static uint64_t getle(const uint8_t *p,unsigned k){uint64_t n=0;for(unsigned i=0;i<k;++i)n|=(uint64_t)p[i]<<(8*i);return n;}
static void recalc(struct Port *p,size_t offset,uint32_t n){uint8_t *t=p->data+offset+35+n;le(t+34,~crc(crc(0xffffffffu,p->data+offset+35,n),t+2,32),4);}
static void save(const char *p,const struct Port *s){FILE *f=fopen(p,"wb");assert(f&&fwrite(s->data,1,s->n,f)==s->n&&!fclose(f));}
static unsigned char rgb[W*H*3],before[sizeof rgb],packet[CAP];
static uint8_t *jpeg[3];static uint32_t lens[3];
static Iq4JpegApi host_api(void){return(Iq4JpegApi){jpeg_std_error,jpeg_CreateCompress,jpeg_set_defaults,jpeg_set_quality,jpeg_start_compress,jpeg_write_scanlines,jpeg_finish_compress,jpeg_destroy_compress,JPEG_LIB_VERSION,sizeof(struct jpeg_compress_struct),1};}
static void pixels(unsigned index){uint32_t q=0x9abcdeffu+index*0x13457u;for(size_t i=0;i<sizeof rgb;++i){q^=q<<13;q^=q>>17;q^=q<<5;rgb[i]=(uint8_t)q;}memcpy(before,rgb,sizeof rgb);}
static void decode(const uint8_t *p,uint32_t n){struct jpeg_decompress_struct d={0};struct jpeg_error_mgr e;d.err=jpeg_std_error(&e);jpeg_create_decompress(&d);jpeg_mem_src(&d,p,n);assert(jpeg_read_header(&d,TRUE)==JPEG_HEADER_OK);d.out_color_space=JCS_RGB;assert(jpeg_start_decompress(&d)&&d.output_width==W&&d.output_height==H&&d.output_components==3);unsigned char row[W*3];unsigned lines=0;while(d.output_scanline<H){JSAMPROW r=row;assert(jpeg_read_scanlines(&d,&r,1)==1);++lines;}assert(lines==H&&jpeg_finish_decompress(&d));jpeg_destroy_decompress(&d);}
static void fixtures(void){Iq4JpegApi a=host_api();for(unsigned i=0;i<3;++i){pixels(i);Iq4JpegInput in={rgb,sizeof rgb,W,H,W*3,93};Iq4JpegResult r;assert(iq4_jpeg_encode_bounded(&a,&in,packet,CAP,&r)==IQ4_JPEG_OK&&r.jpeg_bytes>1000&&!memcmp(rgb,before,sizeof rgb));lens[i]=(uint32_t)r.jpeg_bytes;jpeg[i]=malloc(lens[i]);assert(jpeg[i]);memcpy(jpeg[i],packet,lens[i]);decode(jpeg[i],lens[i]);}assert(lens[0]!=lens[1]||memcmp(jpeg[0],jpeg[1],lens[0]));}
static const uint64_t times[3]={1000000000,1033333333,1078000000};
static struct Port sequence(const uint64_t id[3],unsigned count){struct Port p=port();p.short_io=1;struct Iq4Mkv m=writer(&p);for(unsigned i=0;i<count;++i)assert(iq4_mkv_packet(&m,jpeg[i],lens[i],times[i],id[i])==IQ4_MKV_OK);assert(iq4_mkv_seal(&m)==IQ4_MKV_OK&&m.frames==count);return p;}
static unsigned scan_exact(struct Port *p,const uint64_t *ids,unsigned count){struct Iq4MkvScan s=scanner(p);unsigned char out[CAP];uint32_t n;uint64_t ns,id;for(unsigned i=0;i<count;++i){assert(iq4_mkv_scan_next(&s,out,CAP,&n,&ns,&id)==IQ4_MKV_SCAN_PACKET&&ns==times[i]&&id==ids[i]&&n);decode(out,n);}assert(iq4_mkv_scan_next(&s,out,CAP,&n,&ns,&id)==IQ4_MKV_SCAN_END&&!n&&!ns&&!id&&s.frames==count);return count;}
static unsigned recover(struct Port *p,struct Port *newfile,const uint64_t *ids,unsigned count){uint8_t *unchanged=malloc(p->n);assert(unchanged);memcpy(unchanged,p->data,p->n);struct Iq4MkvScan s=scanner(p);struct Iq4Mkv m=writer(newfile);unsigned char out[CAP];uint32_t n;uint64_t ns,id;unsigned done=0;for(;;){enum Iq4MkvScanStatus r=iq4_mkv_scan_next(&s,out,CAP,&n,&ns,&id);if(r==IQ4_MKV_SCAN_END)break;assert(r==IQ4_MKV_SCAN_PACKET&&done<count&&id==ids[done]&&ns==times[done]);assert(iq4_mkv_packet(&m,out,n,ns,id)==IQ4_MKV_OK);++done;}assert(done==count&&(!count||iq4_mkv_seal(&m)==IQ4_MKV_OK)&&!memcmp(p->data,unchanged,p->n));free(unchanged);if(count)scan_exact(newfile,ids,count);return done;}
static unsigned source_next,source_count,releases;static uint32_t source_ids[3];
uint64_t iq4_f4_native_tid_02(void){return 2;}
Iq4Jpeg82BindStatus01 iq4_native_jpeg82_bind_01(const uint8_t *b,Iq4Jpeg82ReadExact01 r,void *c,Iq4JpegApi *a){assert(b&&r&&c);*a=host_api();return IQ4_JPEG82_BOUND_STATIC_ABI_01;}
int iq4_f4_source_worker_claim_02(void *s,Iq4F4OwnedFrame02 *f){assert(s==(void*)1);if(source_next==source_count)return IQ4_F4_SRC_EMPTY;pixels(source_next);*f=(Iq4F4OwnedFrame02){rgb,{.width=W,.height=H,.stride=W*3,.bytes=sizeof rgb,.software_id=source_ids[source_next],.observed_completion_ns=times[source_next]},0,1};return IQ4_F4_SRC_OK;}
int iq4_f4_source_worker_release_02(void *s,const Iq4F4OwnedFrame02 *f){assert(s==(void*)1&&f->bytes==rgb&&!memcmp(rgb,before,sizeof rgb));++releases;++source_next;return IQ4_F4_SRC_OK;}
int iq4_f4_source_fence_02(void *s){assert(s==(void*)1&&source_next==source_count);return IQ4_F4_SRC_OK;}
static int selfread(void *c,uintptr_t a,void *p,size_t n){(void)c;(void)a;(void)p;(void)n;return 0;}
static struct Port actual_worker(const uint32_t raw[3],const uint64_t extended[3]){struct Port p=port();struct Iq4Mkv m=writer(&p);Iq4F4Worker02 w;source_next=releases=0;source_count=3;memcpy(source_ids,raw,sizeof source_ids);assert(iq4_f4_worker_init_02(&w,(void*)1,&m,packet,CAP,93,selfread,0)==IQ4_F4_WORKER_PACKET);for(unsigned i=0;i<3;++i)assert(iq4_f4_worker_pump_one_02(&w)==IQ4_F4_WORKER_PACKET&&w.last_extended_id==extended[i]);assert(releases==3&&w.encoded==3&&!w.held_uncertain&&iq4_f4_worker_pump_one_02(&w)==IQ4_F4_WORKER_EMPTY&&iq4_f4_worker_seal_02(&w)==IQ4_F4_WORKER_PACKET);scan_exact(&p,extended,3);for(unsigned i=0;i<3;++i)assert((uint32_t)extended[i]==raw[i]);return p;}
int main(int argc,char **argv){assert(argc==4);fixtures();unsigned groups=0;const uint64_t ids[3]={0,1,3};struct Port p=sequence(ids,3);size_t first=scanner(&p).offset,second=first+lens[0]+73;
 assert(getle(p.data+first+35+lens[0]+18,8)==0&&getle(p.data+first+35+lens[0]+26,4)==2);scan_exact(&p,ids,3);save(argv[1],&p);++groups;
 const uint32_t rawzero[3]={0,1,3};struct Port w=actual_worker(rawzero,ids);dispose(&w);++groups;
 const uint32_t rawwrap[3]={0xffffffffu,0,1};const uint64_t wrap[3]={0xffffffffu,UINT64_C(0x100000000),UINT64_C(0x100000001)};w=actual_worker(rawwrap,wrap);save(argv[2],&w);dispose(&w);++groups;
 struct Port fresh=port();recover(&p,&fresh,ids,3);save(argv[3],&fresh);dispose(&fresh);++groups;
 for(unsigned flag=0;flag<=3;++flag){if(flag==2)continue;uint8_t *t=p.data+first+35+lens[0];le(t+26,flag,4);recalc(&p,first,lens[0]);scan_exact(&p,ids,0);le(t+26,2,4);recalc(&p,first,lens[0]);}++groups;
 uint8_t *t=p.data+first+35+lens[0];le(t+10,0,8);recalc(&p,first,lens[0]);scan_exact(&p,ids,0);le(t+10,times[0],8);recalc(&p,first,lens[0]);++groups;
 t=p.data+second+35+lens[1];le(t+18,0,8);recalc(&p,second,lens[1]);fresh=port();recover(&p,&fresh,ids,1);dispose(&fresh);le(t+18,1,8);recalc(&p,second,lens[1]);++groups;
 t=p.data+second+35+lens[1];le(t+10,times[0],8);be(p.data+second+14,0,8);recalc(&p,second,lens[1]);fresh=port();recover(&p,&fresh,ids,1);dispose(&fresh);le(t+10,times[1],8);be(p.data+second+14,times[1]-times[0],8);recalc(&p,second,lens[1]);++groups;
 p.data[second+35+lens[1]+34]^=1;fresh=port();recover(&p,&fresh,ids,1);dispose(&fresh);p.data[second+35+lens[1]+34]^=1;++groups;
 size_t all=p.n;p.n=all-1;fresh=port();recover(&p,&fresh,ids,2);dispose(&fresh);p.n=all;++groups;
 struct Iq4MkvScan s=scanner(&p);uint8_t out[CAP];uint32_t n;uint64_t ns,id;p.unknown=1;unsigned reads=p.calls;assert(iq4_mkv_scan_next(&s,out,CAP,&n,&ns,&id)==IQ4_MKV_SCAN_HOLD&&!n&&!ns&&!id&&p.calls==reads+1);p.unknown=0;reads=p.calls;assert(iq4_mkv_scan_next(&s,out,CAP,&n,&ns,&id)==IQ4_MKV_SCAN_HOLD&&p.calls==reads);++groups;
 s=scanner(&p);p.fail=1;assert(iq4_mkv_scan_next(&s,out,CAP,&n,&ns,&id)==IQ4_MKV_SCAN_IO&&!n&&!ns&&!id);p.fail=0;++groups;
 fresh=port();struct Iq4Mkv m=writer(&fresh);size_t header=fresh.n;assert(iq4_mkv_packet(&m,jpeg[0],lens[0],0,0)==IQ4_MKV_PACKET&&!m.frames&&fresh.n==header);dispose(&fresh);++groups;
 fresh=port();m=writer(&fresh);assert(iq4_mkv_packet(&m,jpeg[0],lens[0],times[0],0)==IQ4_MKV_OK&&iq4_mkv_packet(&m,jpeg[1],lens[1],times[1],0)==IQ4_MKV_ORDER&&m.frames==1);dispose(&fresh);++groups;
 scan_exact(&p,ids,3);dispose(&p);for(unsigned i=0;i<3;++i)free(jpeg[i]);printf("{\"groups\":%u,\"real_host_entropy_JPEG_decode\":true,\"actual_worker_source_callbacks_modeled\":true,\"software_zero_and_uint32_wrap_preserved\":true,\"target_executed\":false}\n",groups);return 0;}
