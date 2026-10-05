#include "../f3_stream_export_04/stream_export.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define SIZE (16u*1024u*1024u)
static uint8_t stored[SIZE],scratch[F3_STREAM_SCRATCH];
struct Mock {unsigned checks,fail_phase,unknown_phase,short_phase,corrupt,swap_inode,swap_size,removed,published,write_open,read_open,unknown,after_unknown,calls;size_t written,read_off;struct F3File file;};
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
static struct F3Io pub(void*v,const struct F3File*f){struct Mock*m=v;assert(!m->write_open&&!m->read_open&&f->bytes==m->written);struct F3Io r=io(m,14,1);if(r.state==F3_IO_DONE)m->published=1;return r;}
static struct F3Io rmraw(void*v,const struct F3Job*j){struct Mock*m=v;assert(m->published&&m->checks==2&&j->purpose==F3_NEW_CAPTURE&&j->newly_created_raw_stage);struct F3Io r=io(m,16,1);if(r.state==F3_IO_DONE)m->removed=1;return r;}
static struct F3Ports ports(struct Mock*m){return(struct F3Ports){m,raw,openw,wr,cw,openr,rd,statr,cr,pub,rmraw};}
extern uint64_t iq4_f3_jpeg_retained_cleanup_contexts_04(void);
static int codec_fault;
static void library_error(j_compress_ptr c){c->err->msg_code=27;c->err->error_exit((j_common_ptr)c);}
static void finish(j_compress_ptr c){if(codec_fault==1)library_error(c);jpeg_finish_compress(c);}
static void destroy(j_compress_ptr c){if(codec_fault==4)library_error(c);jpeg_destroy_compress(c);if(codec_fault==2)library_error(c);}
static JDIMENSION scan(j_compress_ptr c,JSAMPARRAY p,JDIMENSION n){return codec_fault==3?0:jpeg_write_scanlines(c,p,n);}
static Iq4JpegApi api(void){return(Iq4JpegApi){jpeg_std_error,jpeg_CreateCompress,jpeg_set_defaults,jpeg_set_quality,jpeg_start_compress,scan,finish,destroy,80,sizeof(struct jpeg_compress_struct),1};}
static struct F3ExportRequest03 request(unsigned w,unsigned h,unsigned rot,unsigned size){struct F3ExportRequest03 r={0};struct Iq4ExportGeometry g;assert(iq4_export_geometry(w,h,rot,size,&g)==0);
 r.rotation=rot;r.size_mode=size;r.quality=95;struct F3Job*j=&r.job;j->boot_epoch=1;j->capture_id=2;j->mode=F3_RAW_JPEG;j->purpose=F3_MANUAL_EXISTING_RAW;
 j->source_raw_width=w;j->source_raw_height=h;j->render_source_kind=1;j->render_width=j->output_width=g.output_width;j->render_height=j->output_height=g.output_height;
 j->raw=(struct F3File){11,12,13,9,1000};j->render_source=j->raw;return r;}
static const struct F3StreamResult*execute(struct F3ExportStream03*c,struct F3Session*s,struct Mock*m,const struct F3ExportRequest03*r,const Iq4Rgb32Input*in,Iq4StreamResult*out){struct F3Ports p=ports(m);
 if(!f3_export_stream_begin_03(c,s,r,&p,SIZE,scratch,sizeof scratch))return &c->checked.result;Iq4JpegApi a=api();return f3_export_stream_encode_03(c,&a,in,out);}
/* Entropy decode all rows using the real, separately compiled host JPEG8 library. */
static void decode(size_t bytes,unsigned w,unsigned h){struct jpeg_decompress_struct d={0};struct jpeg_error_mgr e;d.err=jpeg_std_error(&e);jpeg_CreateDecompress(&d,80,sizeof d);jpeg_mem_src(&d,stored,(unsigned long)bytes);
 assert(jpeg_read_header(&d,TRUE)==JPEG_HEADER_OK);d.out_color_space=JCS_RGB;assert(jpeg_start_decompress(&d));assert(d.output_width==w&&d.output_height==h&&d.output_components==3);
 unsigned char*row=malloc((size_t)w*3);assert(row);while(d.output_scanline<h){JSAMPROW p=row;assert(jpeg_read_scanlines(&d,&p,1)==1);}assert(jpeg_finish_decompress(&d));jpeg_destroy_decompress(&d);free(row);}
struct Buffer {uint8_t*p;size_t bytes;};
static size_t buffer_write(void*v,const uint8_t*p,size_t n){struct Buffer*b=v;assert(n<=SIZE-b->bytes);memcpy(b->p+b->bytes,p,n);b->bytes+=n;return n;}
static int original_export_regression(void){unsigned tests=0;const unsigned w=8193,h=127;const size_t stride=(size_t)w*4+19,bytes=stride*h;uint8_t*src=malloc(bytes),*copy=malloc(bytes);assert(src&&copy);memset(src,0xed,bytes);
 for(unsigned y=0;y<h;++y)for(unsigned x=0;x<w;++x){uint8_t*p=src+(size_t)y*stride+x*4;p[1]=(uint8_t)(x/17+y);p[2]=(uint8_t)(y*3+x/31);p[3]=(uint8_t)(x/7+y*5);}memcpy(copy,src,bytes);
 Iq4Rgb32Input in={src,bytes,stride,w,h,95};Iq4StreamResult out;
 for(unsigned rot=0;rot<4;++rot)for(unsigned size=0;size<6;++size){struct Mock m={0};struct F3ExportStream03 c={0};struct F3Session s={1,0,0};struct F3ExportRequest03 r=request(w,h,rot*90,size);
  const struct F3StreamResult*z=execute(&c,&s,&m,&r,&in,&out);assert(z->saved.status==F3_JPEG_WITH_RAW&&z->saved.published&&!m.removed&&!m.write_open&&!m.read_open&&!s.in_progress&&!s.hold&&out.status==IQ4_STREAM_OK&&out.destroy_calls==1&&out.rows_encoded==r.job.output_height&&z->saved.verified_bytes==m.written&&!strcmp(z->encoded_sha256,z->readback_sha256));
  decode(m.written,r.job.output_width,r.job.output_height);assert(!memcmp(src,copy,bytes));++tests;
  if(!rot&&!size){uint8_t*old=malloc(SIZE);struct Buffer b={old,0};Iq4JpegSink sink={&b,buffer_write,SIZE};Iq4JpegApi a=api();Iq4StreamResult result;assert(iq4_jpeg_stream_rgb32(&a,&in,&sink,&result)==IQ4_STREAM_OK);assert(b.bytes==m.written&&!memcmp(old,stored,b.bytes));free(old);++tests;}
 }
 /* Input/source identity and settings failures occur before an output file opens. */
 for(unsigned bad=0;bad<8;++bad){struct Mock m={0};struct F3ExportStream03 c={0};struct F3Session s={1,0,0};struct F3Ports p=ports(&m);struct F3ExportRequest03 r=request(w,h,0,0);
  if(bad==0)r.job.render_source.inode++;if(bad==1)r.job.render_width++;if(bad==2)r.job.output_height++;if(bad==3)r.quality=0;if(bad==4)r.rotation=45;if(bad==5)r.job.mode=F3_RAW;if(bad==6)r.size_mode=6;if(bad==7)r.job.mode=3;
  assert(!f3_export_stream_begin_03(&c,&s,&r,&p,SIZE,scratch,sizeof scratch)&&!m.calls&&!s.in_progress);++tests;}
 const unsigned phases[]={1,2,4,6,7,9,11,13,14};
 for(unsigned i=0;i<sizeof phases/sizeof phases[0];++i)for(unsigned unknown=0;unknown<2;++unknown){struct Mock m={0};if(unknown)m.unknown_phase=phases[i];else m.fail_phase=phases[i];struct F3ExportStream03 c={0};struct F3Session s={1,0,0};struct F3ExportRequest03 r=request(w,h,0,2);
  const struct F3StreamResult*z=execute(&c,&s,&m,&r,&in,&out);assert(!m.published&&!m.removed);
  if(unknown){assert(z->saved.status==F3_UNKNOWN_HOLD&&s.hold&&s.in_progress&&!m.after_unknown);unsigned calls=m.calls;f3_stream_abort_03(&c.checked);assert(!f3_stream_sink_write_03(&c.checked,stored,4));Iq4JpegApi a=api();f3_export_stream_encode_03(&c,&a,&in,&out);assert(calls==m.calls&&!m.after_unknown);}
  else assert(z->saved.status==F3_FAILED_RAW_RETAINED&&!s.hold&&!s.in_progress&&!m.write_open&&!m.read_open);++tests;}
 for(unsigned bad=0;bad<5;++bad){struct Mock m={0};if(bad==0)m.short_phase=4;if(bad==1)m.short_phase=9;if(bad==2)m.corrupt=1;if(bad==3)m.swap_inode=1;if(bad==4)m.swap_size=1;struct F3ExportStream03 c={0};struct F3Session s={1,0,0};struct F3ExportRequest03 r=request(w,h,0,2);const struct F3StreamResult*z=execute(&c,&s,&m,&r,&in,&out);assert(z->saved.status==F3_FAILED_RAW_RETAINED&&!m.published&&!m.removed&&!s.in_progress&&!m.write_open&&!m.read_open);++tests;}
 for(unsigned fault=1;fault<=4;++fault){codec_fault=(int)fault;struct Mock m={0};struct F3ExportStream03 c={0};struct F3Session s={1,0,0};struct F3ExportRequest03 r=request(w,h,0,2);uint64_t held=iq4_f3_jpeg_retained_cleanup_contexts_04();const struct F3StreamResult*z=execute(&c,&s,&m,&r,&in,&out);assert(!out.jpeg_bytes&&!m.published&&!m.removed);if(fault==2||fault==4){assert(out.status==IQ4_STREAM_CLEANUP_ERROR&&z->saved.status==F3_UNKNOWN_HOLD&&s.hold&&s.in_progress&&m.write_open&&out.destroy_calls==1&&iq4_f3_jpeg_retained_cleanup_contexts_04()==held+1);unsigned calls=m.calls;Iq4JpegApi api2=api();f3_stream_abort_03(&c.checked);f3_export_stream_encode_03(&c,&api2,&in,&out);assert(m.calls==calls&&m.write_open&&s.hold&&out.destroy_calls==1);}else assert(z->saved.status==F3_FAILED_RAW_RETAINED&&!m.write_open&&!s.in_progress&&iq4_f3_jpeg_retained_cleanup_contexts_04()==held);++tests;}codec_fault=0;
 /* Manual existing RAW can never be deleted even if caller requests JPEG_ONLY. */
 {struct Mock m={0};struct F3ExportStream03 c={0};struct F3Session s={1,0,0};struct F3ExportRequest03 r=request(w,h,0,2);r.job.mode=F3_JPEG_ONLY;const struct F3StreamResult*z=execute(&c,&s,&m,&r,&in,&out);assert(z->saved.status==F3_JPEG_WITH_RAW&&!m.removed&&m.checks==1);++tests;}
 /* Even a newly-owned JPEG-only request retains RAW until native cleanup and
  * the later capture coordinator; no private-stage deletion shortcut here. */
 {struct Mock m={0};struct F3ExportStream03 c={0};struct F3Session s={1,0,0};struct F3ExportRequest03 r=request(w,h,0,2);r.job.mode=F3_JPEG_ONLY;r.job.purpose=F3_NEW_CAPTURE;r.job.newly_created_raw_stage=1;const struct F3StreamResult*z=execute(&c,&s,&m,&r,&in,&out);assert(z->saved.status==F3_JPEG_WITH_RAW&&!m.removed&&m.checks==1&&c.requested_mode==F3_JPEG_ONLY&&c.checked.job.mode==F3_RAW_JPEG);++tests;}
 assert(!memcmp(src,copy,bytes));free(copy);free(src);printf("{\"groups\":%u,\"passed\":true,\"real_host_entropy_decoded_geometry_cases\":24,\"actual_RAW_decode\":false,\"device_accessed\":false}\n",tests);return 0;
}
