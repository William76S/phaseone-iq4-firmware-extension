#include "../f3_stock_half_export_01/sink.h"
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
static int guard_calls,stop_at,unknown;
static int guard(void*ctx){assert(ctx==(void*)0x1234);++guard_calls;return stop_at&&guard_calls>=stop_at?(unknown?-1:0):1;}
static void destroy_unknown(j_compress_ptr j){j->err->msg_code=77;j->err->error_exit((j_common_ptr)j);}
static Iq4JpegApi api(void){return(Iq4JpegApi){jpeg_std_error,jpeg_CreateCompress,jpeg_set_defaults,jpeg_set_quality,jpeg_start_compress,jpeg_write_scanlines,jpeg_finish_compress,jpeg_destroy_compress,JPEG_LIB_VERSION,sizeof(struct jpeg_compress_struct),1};}
int main(void){
 const size_t stride=21312,bytes=stride*5326,cap=104857600;uint8_t*raw=malloc(bytes),*out=malloc(cap);assert(raw&&out);
 for(unsigned y=0;y<5326;++y)for(unsigned x=0;x<7102;++x){uint8_t*p=raw+y*stride+3*x;p[0]=80;p[1]=120;p[2]=160;}
 Iq4JpegApi a=api();Iq4HalfArgb01 p={raw,bytes,stride,7102,5326,2};Iq4HalfJpegResult01 r;
 assert(iq4_half_jpeg_encode_01(&a,&p,out,cap,100,guard,(void*)0x1234,&r)==IQ4_HALF_JPEG_OK_01);assert(r.rows==5326&&r.destroy_calls==1&&r.jpeg_bytes>4);
 struct jpeg_decompress_struct d={0};struct jpeg_error_mgr err;d.err=jpeg_std_error(&err);jpeg_create_decompress(&d);jpeg_mem_src(&d,out,r.jpeg_bytes);assert(jpeg_read_header(&d,TRUE)==JPEG_HEADER_OK);assert(d.image_width==7102&&d.image_height==5326);d.out_color_space=JCS_RGB;assert(jpeg_start_decompress(&d));uint8_t*line=malloc(d.output_width*d.output_components);assert(line);unsigned rows=0;
 while(d.output_scanline<d.output_height){JSAMPROW row=line;assert(jpeg_read_scanlines(&d,&row,1)==1);++rows;assert(abs(line[0]-80)<=2&&abs(line[1]-120)<=2&&abs(line[2]-160)<=2);}assert(rows==5326);assert(jpeg_finish_decompress(&d));jpeg_destroy_decompress(&d);free(line);size_t encoded=r.jpeg_bytes;
 p.format=5;assert(iq4_half_jpeg_encode_01(&a,&p,out,cap,100,guard,(void*)0x1234,&r)==IQ4_HALF_JPEG_ARGUMENT_01);p.format=2;
 p.stride=21305;assert(iq4_half_jpeg_encode_01(&a,&p,out,cap,100,guard,(void*)0x1234,&r)==IQ4_HALF_JPEG_ARGUMENT_01);p.stride=stride;
 guard_calls=0;assert(iq4_half_jpeg_encode_01(&a,&p,out,64,100,guard,(void*)0x1234,&r)==IQ4_HALF_JPEG_CAPACITY_01);assert(r.jpeg_bytes==0&&r.destroy_calls==1);
 guard_calls=0;stop_at=10;assert(iq4_half_jpeg_encode_01(&a,&p,out,cap,100,guard,(void*)0x1234,&r)==IQ4_HALF_JPEG_CANCELLED_01);assert(r.jpeg_bytes==0&&r.destroy_calls==1);
 guard_calls=0;stop_at=10;unknown=1;assert(iq4_half_jpeg_encode_01(&a,&p,out,cap,100,guard,(void*)0x1234,&r)==IQ4_HALF_JPEG_HOLD_01);assert(r.jpeg_bytes==0&&r.destroy_calls==1);
 guard_calls=0;stop_at=10;unknown=0;a.destroy_compress=destroy_unknown;uint64_t prior=iq4_half_jpeg_quarantined_contexts_01();assert(iq4_half_jpeg_encode_01(&a,&p,out,cap,100,guard,(void*)0x1234,&r)==IQ4_HALF_JPEG_HOLD_01);assert(r.jpeg_bytes==0&&r.destroy_calls==1&&iq4_half_jpeg_quarantined_contexts_01()==prior+1);
 free(raw);free(out);puts("PASS 7 focus cases: actual7102x5326 quality100 encode+full entropy decode RGB channel order; capacity/cancel/unknown/destroy uncertainty expose zero JPEG bytes");printf("{\"host_actual_output\":[7102,5326],\"quality\":100,\"encoded_bytes\":%zu,\"decoded_rows\":%u,\"cases\":7,\"camera_accessed\":false}\n",encoded,rows);return 0;
}
