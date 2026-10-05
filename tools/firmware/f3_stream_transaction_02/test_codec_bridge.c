/* Reuse owned mock implementation; never executes vendor camera code. */
#define main owned_fixture_unused_entry
#include "test_stream.c"
#undef main
#include "codec_bridge.h"
static uint8_t pixels[256u*(384u*4u+13u)],before[sizeof(pixels)];
static struct F3Io publish_dynamic(void*v,const struct F3File*f){struct Mock*m=v;assert(!m->write_open&&!m->read_open&&f->bytes==m->written);struct F3Io r=io(m,14,1);if(r.state==F3_IO_DONE)m->published=1;return r;}
static Iq4JpegApi codec(void){return(Iq4JpegApi){jpeg_std_error,jpeg_CreateCompress,jpeg_set_defaults,jpeg_set_quality,jpeg_start_compress,jpeg_write_scanlines,jpeg_finish_compress,jpeg_destroy_compress,JPEG_LIB_VERSION,sizeof(struct jpeg_compress_struct),1};}
static void bad_finish(j_compress_ptr c){c->err->msg_code=999;(*c->err->error_exit)((j_common_ptr)c);}
static void bad_destroy(j_compress_ptr c){jpeg_destroy_compress(c);c->err->msg_code=999;(*c->err->error_exit)((j_common_ptr)c);}
static const struct F3StreamResult *encode(struct Mock*m,struct F3Stream*c,struct F3Session*s,Iq4JpegApi*a,Iq4StreamResult*out){
 struct F3Job j=job();j.render_width=j.output_width=384;j.render_height=j.output_height=256;struct F3Ports p=ports(m);p.publish=publish_dynamic;
 assert(f3_stream_begin_02(c,s,&j,&p,SIZE,scratch,sizeof(scratch)));
 Iq4Rgb32Input in={pixels,sizeof(pixels),384u*4u+13u,384,256,85};return f3_stream_encode_rgb32_02(c,a,&in,out);
}
int main(void){unsigned groups=0,seed=1;for(size_t i=0;i<sizeof(pixels);++i){seed=seed*1664525u+1013904223u;pixels[i]=(uint8_t)(seed>>24);}memcpy(before,pixels,sizeof(pixels));
 struct Mock m={0};struct F3Stream c={0};struct F3Session s={1,0,0};Iq4JpegApi a=codec();Iq4StreamResult out;
 const struct F3StreamResult*r=encode(&m,&c,&s,&a,&out);
 assert(out.status==IQ4_STREAM_OK&&out.rows_encoded==256&&out.destroy_calls==1&&r->saved.status==F3_JPEG_ONLY_DONE&&m.published&&m.removed&&r->encoded_bytes==m.written&&r->saved.write_calls>1&&!strcmp(r->encoded_sha256,r->readback_sha256)&&!memcmp(pixels,before,sizeof(pixels)));
 struct jpeg_decompress_struct d={0};struct jpeg_error_mgr e;uint8_t row[384*3];d.err=jpeg_std_error(&e);jpeg_create_decompress(&d);jpeg_mem_src(&d,stored,m.written);assert(jpeg_read_header(&d,TRUE)==JPEG_HEADER_OK&&d.image_width==384&&d.image_height==256);assert(jpeg_start_decompress(&d));unsigned rows=0;while(d.output_scanline<d.output_height){JSAMPROW q=row;assert(jpeg_read_scanlines(&d,&q,1)==1);++rows;}assert(rows==256&&jpeg_finish_decompress(&d));jpeg_destroy_decompress(&d);++groups;
 m=(struct Mock){0};m.short_phase=4;c=(struct F3Stream){0};s=(struct F3Session){1,0,0};r=encode(&m,&c,&s,&a,&out);assert(out.status==IQ4_STREAM_SHORT_WRITE&&out.jpeg_bytes==0&&r->saved.status==F3_FAILED_RAW_RETAINED&&!m.removed&&!m.published&&!m.write_open&&out.destroy_calls==1);++groups;
 m=(struct Mock){0};m.unknown_phase=4;c=(struct F3Stream){0};s=(struct F3Session){1,0,0};r=encode(&m,&c,&s,&a,&out);assert(r->saved.status==F3_UNKNOWN_HOLD&&s.hold&&s.in_progress&&m.write_open&&!m.after_unknown&&!m.removed&&!m.published&&out.destroy_calls==1);++groups;
 m=(struct Mock){0};c=(struct F3Stream){0};s=(struct F3Session){1,0,0};a=codec();a.finish_compress=bad_finish;r=encode(&m,&c,&s,&a,&out);assert(out.status==IQ4_STREAM_LIBRARY_ERROR&&out.jpeg_bytes==0&&r->saved.status==F3_FAILED_RAW_RETAINED&&!m.write_open&&!m.published&&!m.removed);++groups;
 m=(struct Mock){0};c=(struct F3Stream){0};s=(struct F3Session){1,0,0};a=codec();a.destroy_compress=bad_destroy;r=encode(&m,&c,&s,&a,&out);assert(out.status==IQ4_STREAM_CLEANUP_ERROR&&out.jpeg_bytes==0&&r->saved.status==F3_FAILED_RAW_RETAINED&&!m.write_open&&!m.published&&!m.removed);++groups;
 m=(struct Mock){0};m.corrupt=1;c=(struct F3Stream){0};s=(struct F3Session){1,0,0};a=codec();r=encode(&m,&c,&s,&a,&out);assert(out.status==IQ4_STREAM_OK&&r->saved.status==F3_FAILED_RAW_RETAINED&&!m.published&&!m.removed);++groups;
 printf("{\"actual_host_codec_transaction_groups\":%u,\"passed\":true,\"entropy_decoded_rows\":256,\"synthetic_RGB_only\":true,\"RAW_source_provenance_verified\":false,\"native_ports_bound\":false}\n",groups);return 0;}
