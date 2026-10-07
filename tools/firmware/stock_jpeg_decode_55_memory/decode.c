#include "decode.h"
#include <stdio.h>
#include <setjmp.h>
#include <stdlib.h>
#include <string.h>
#include <jpeglib.h>
#include "../stock_jpeg_gallery_55/exif.h"
struct Decode55 {struct jpeg_decompress_struct jpeg;struct jpeg_error_mgr error;jmp_buf jump;uint8_t*row;};
static void fatal55(j_common_ptr p){struct Decode55*d=(struct Decode55*)p;longjmp(d->jump,1);}
static void message55(j_common_ptr p,int level){if(level<0)fatal55(p);}
static void quiet55(j_common_ptr p){(void)p;}
static void reset55(j_common_ptr p){p->err->num_warnings=0;p->err->msg_code=0;}
static void format55(j_common_ptr p,char*out){(void)p;out[0]=0;}
static void init55(struct Decode55*d){d->jpeg.err=&d->error;d->error.reset_error_mgr=reset55;d->error.format_message=format55;d->error.error_exit=fatal55;d->error.emit_message=message55;d->error.output_message=quiet55;}
static int overlap55(const void*a,size_t n,const void*b,size_t m){uintptr_t x=(uintptr_t)a,y=(uintptr_t)b;return x>UINTPTR_MAX-n||y>UINTPTR_MAX-m||(x<y+m&&y<x+n);}
int iq4_stock_jpeg_probe_bytes_55(const uint8_t*in,size_t bytes,struct Iq4JpegDecodeResult55*r){
 if(!in||!r||bytes<4||bytes>100u*1024u*1024u||overlap55(in,bytes,r,sizeof *r)||in[0]!=0xff||in[1]!=0xd8||in[bytes-2]!=0xff||in[bytes-1]!=0xd9)return 0;memset(r,0,sizeof *r);
 struct Decode55*d=calloc(1,sizeof *d);if(!d)return 0;init55(d);
 if(setjmp(d->jump)){if(d->jpeg.mem)jpeg_destroy_decompress(&d->jpeg);free(d);return 0;}
 jpeg_create_decompress(&d->jpeg);jpeg_mem_src(&d->jpeg,in,(unsigned long)bytes);
 int ok=jpeg_read_header(&d->jpeg,TRUE)==JPEG_HEADER_OK&&d->jpeg.data_precision==8&&d->jpeg.num_components==3&&!d->jpeg.arith_code&&!d->jpeg.progressive_mode&&d->jpeg.image_width&&d->jpeg.image_height&&d->jpeg.image_width<=14204&&d->jpeg.image_height<=14204;
 uint32_t w=d->jpeg.image_width,h=d->jpeg.image_height,orientation=iq4_stock_jpeg_orientation_55(in,bytes);jpeg_destroy_decompress(&d->jpeg);free(d);if(!orientation)ok=0;if(ok)*r=(struct Iq4JpegDecodeResult55){w,h,0,0,0,orientation};return ok;
}
static int decode55(const uint8_t*in,size_t bytes,uint32_t rx,uint32_t ry,uint32_t rw,uint32_t rh,uint8_t*out,size_t cap,uint32_t stride,uint32_t maxw,uint32_t maxh,int(*guard)(void*),void*ctx,struct Iq4JpegDecodeResult55*r){
 if(!r)return 0;
 if(!in||bytes<4||bytes>100u*1024u*1024u||!out||!cap||!stride||!maxw||!maxh||maxw>3840||maxh>3840||!guard||overlap55(in,bytes,out,cap)||overlap55(out,cap,r,sizeof *r)||overlap55(in,bytes,r,sizeof *r)||in[0]!=0xff||in[1]!=0xd8||in[bytes-2]!=0xff||in[bytes-1]!=0xd9)return 0;
 memset(r,0,sizeof *r);if(guard(ctx)!=1)return -1;
 struct Decode55*d=calloc(1,sizeof *d);if(!d)return 0;
 init55(d);
 if(setjmp(d->jump)){if(d->jpeg.mem)jpeg_destroy_decompress(&d->jpeg);free(d->row);free(d);return 0;}
 jpeg_create_decompress(&d->jpeg);jpeg_mem_src(&d->jpeg,in,(unsigned long)bytes);
 if(jpeg_read_header(&d->jpeg,TRUE)!=JPEG_HEADER_OK||d->jpeg.data_precision!=8||d->jpeg.num_components!=3||d->jpeg.arith_code||d->jpeg.progressive_mode||!d->jpeg.image_width||!d->jpeg.image_height||d->jpeg.image_width>14204||d->jpeg.image_height>14204){jpeg_destroy_decompress(&d->jpeg);free(d);return 0;}
 const uint32_t sw=d->jpeg.image_width,sh=d->jpeg.image_height;
 const uint32_t orientation=iq4_stock_jpeg_orientation_55(in,bytes);if(!orientation){jpeg_destroy_decompress(&d->jpeg);free(d);return 0;}
 if(!rw&&!rh&&!rx&&!ry){rw=sw;rh=sh;}
 if(!rw||!rh||rx>=sw||ry>=sh||rw>sw-rx||rh>sh-ry){jpeg_destroy_decompress(&d->jpeg);free(d);return 0;}
 uint32_t w=rw,h=rh;
 if(w>maxw){w=maxw;h=(uint32_t)((uint64_t)rh*w/rw);if(!h)h=1;}
 if(h>maxh){h=maxh;w=(uint32_t)((uint64_t)rw*h/rh);if(!w)w=1;}
 d->jpeg.out_color_space=JCS_RGB;d->jpeg.dct_method=JDCT_ISLOW;d->jpeg.scale_num=1;
 unsigned den=1;while(den<8&&(rw+den*2-1)/(den*2)>=w&&(rh+den*2-1)/(den*2)>=h)den*=2;
 d->jpeg.scale_denom=den;jpeg_calc_output_dimensions(&d->jpeg);
 if(d->jpeg.output_width>UINT32_MAX/3||stride<w*3||(size_t)h>cap/stride){jpeg_destroy_decompress(&d->jpeg);free(d);return 0;}
 if(guard(ctx)!=1){jpeg_destroy_decompress(&d->jpeg);free(d);return -1;}
 if(!jpeg_start_decompress(&d->jpeg)||d->jpeg.output_components!=3){jpeg_destroy_decompress(&d->jpeg);free(d);return 0;}
 const uint32_t dw=d->jpeg.output_width,dh=d->jpeg.output_height;unsigned rows=0;
 d->row=malloc((size_t)dw*3);if(!d->row){jpeg_destroy_decompress(&d->jpeg);free(d);return 0;}
 while(d->jpeg.output_scanline<dh){if(guard(ctx)!=1){jpeg_destroy_decompress(&d->jpeg);free(d->row);free(d);return -1;}JSAMPROW row=d->row;unsigned before=d->jpeg.output_scanline;if(jpeg_read_scanlines(&d->jpeg,&row,1)!=1||d->jpeg.output_scanline!=before+1){jpeg_destroy_decompress(&d->jpeg);free(d->row);free(d);return 0;}
  while(rows<h&&(uint32_t)(((uint64_t)ry*2*h+(uint64_t)(rows*2+1)*rh)*dh/((uint64_t)h*2*sh))==before){uint8_t*dst=out+(size_t)rows*stride;for(uint32_t x=0;x<w;++x){uint32_t sx=(uint32_t)(((uint64_t)rx*2*w+(uint64_t)(x*2+1)*rw)*dw/((uint64_t)w*2*sw));memcpy(dst+x*3,row+sx*3,3);}++rows;}
 }
 if(rows!=h||!jpeg_finish_decompress(&d->jpeg)||d->error.num_warnings||guard(ctx)!=1){jpeg_destroy_decompress(&d->jpeg);free(d->row);free(d);return 0;}
 jpeg_destroy_decompress(&d->jpeg);free(d->row);free(d);
 *r=(struct Iq4JpegDecodeResult55){sw,sh,w,h,rows,orientation};return 1;
}
int iq4_stock_jpeg_decode_rgb_55(const uint8_t*in,size_t n,uint8_t*out,size_t cap,uint32_t stride,uint32_t mw,uint32_t mh,int(*g)(void*),void*ctx,struct Iq4JpegDecodeResult55*r){return decode55(in,n,0,0,0,0,out,cap,stride,mw,mh,g,ctx,r);}
int iq4_stock_jpeg_decode_crop_rgb_55(const uint8_t*in,size_t n,uint32_t x,uint32_t y,uint32_t w,uint32_t h,uint8_t*out,size_t cap,uint32_t stride,uint32_t mw,uint32_t mh,int(*g)(void*),void*ctx,struct Iq4JpegDecodeResult55*r){if(!w||!h)return 0;return decode55(in,n,x,y,w,h,out,cap,stride,mw,mh,g,ctx,r);}
