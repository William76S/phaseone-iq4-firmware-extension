#include "../../../src/codec/bounded_jpeg.h"
#include <assert.h>
#include <stdlib.h>
#include <string.h>
static unsigned destroyed,unknown_destroyed;
static j_compress_ptr retained;
static void normal_destroy(j_compress_ptr p){++destroyed;jpeg_destroy_compress(p);assert(!p->mem);}
/* Genuine still-live library pools, not an error injected after real destroy. */
static void fatal_before_destroy(j_compress_ptr p){assert(p->mem);retained=p;++unknown_destroyed;p->err->error_exit((j_common_ptr)p);abort();}
static Iq4JpegApi api(void){return(Iq4JpegApi){jpeg_std_error,jpeg_CreateCompress,jpeg_set_defaults,jpeg_set_quality,jpeg_start_compress,jpeg_write_scanlines,jpeg_finish_compress,normal_destroy,JPEG_LIB_VERSION,sizeof(struct jpeg_compress_struct),1};}
int main(void){enum{W=48,H=32,CAP=65536};unsigned char rgb[W*H*3],original[sizeof rgb],packet[CAP+32];
 for(unsigned y=0;y<H;++y)for(unsigned x=0;x<W;++x){unsigned i=(y*W+x)*3;rgb[i]=x<24?230:10;rgb[i+1]=20;rgb[i+2]=x<24?10:230;}
 memcpy(original,rgb,sizeof rgb);memset(packet,0xa5,sizeof packet);Iq4JpegInput input={rgb,sizeof rgb,W,H,W*3,95};Iq4JpegApi a=api();Iq4JpegResult r;
 assert(iq4_jpeg_encode_bounded(&a,&input,packet,CAP,&r)==IQ4_JPEG_OK&&r.jpeg_bytes&&r.destroy_calls==1&&destroyed==1);
 assert(!memcmp(rgb,original,sizeof rgb));for(unsigned i=CAP;i<sizeof packet;++i)assert(packet[i]==0xa5);
 struct jpeg_decompress_struct d={0};struct jpeg_error_mgr e;d.err=jpeg_std_error(&e);jpeg_create_decompress(&d);jpeg_mem_src(&d,packet,r.jpeg_bytes);assert(jpeg_read_header(&d,TRUE)==JPEG_HEADER_OK);d.out_color_space=JCS_RGB;assert(jpeg_start_decompress(&d)&&d.output_width==W&&d.output_height==H&&d.output_components==3);
 unsigned char row[W*3];while(d.output_scanline<H){JSAMPROW p=row;assert(jpeg_read_scanlines(&d,&p,1)==1);assert(row[6*3]>row[6*3+2]+150&&row[36*3+2]>row[36*3]+150);}assert(jpeg_finish_decompress(&d));jpeg_destroy_decompress(&d);
 memset(packet,0xa5,sizeof packet);assert(iq4_jpeg_encode_bounded(&a,&input,packet,16,&r)==IQ4_JPEG_OUTPUT_CAPACITY&&!r.jpeg_bytes&&r.destroy_calls==1&&destroyed==2);for(unsigned i=16;i<sizeof packet;++i)assert(packet[i]==0xa5);assert(!memcmp(rgb,original,sizeof rgb));
 a.destroy_compress=fatal_before_destroy;assert(iq4_jpeg_encode_bounded(&a,&input,packet,CAP,&r)==IQ4_JPEG_CLEANUP_ERROR&&!r.jpeg_bytes&&r.destroy_calls==1&&unknown_destroyed==1);
 /* ASan must see a live owner after the longjmp and function return. */
 assert(retained&&retained->mem&&retained->err&&retained->dest);assert(retained->image_width==W&&retained->image_height==H);assert(!memcmp(rgb,original,sizeof rgb));
 a=api();memset(packet,0xa5,sizeof packet);assert(iq4_jpeg_encode_bounded(&a,&input,packet,CAP,&r)==IQ4_JPEG_CLEANUP_ERROR&&!r.jpeg_bytes&&!r.destroy_calls&&destroyed==2&&unknown_destroyed==1);for(unsigned i=0;i<sizeof packet;++i)assert(packet[i]==0xa5);
 puts("{\"groups\":5,\"real_host_rgb_to_jpeg_decode\":true,\"fatal_before_real_destroy\":true,\"target_executed\":false}");return 0;
}
