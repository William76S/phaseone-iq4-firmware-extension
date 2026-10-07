#include "decode.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <jpeglib.h>
static unsigned calls,stop;
static int guard(void*p){assert(p==(void*)0x1234);return ++calls==stop?0:1;}
static unsigned char*fixture(unsigned w,unsigned h,unsigned long*n){struct jpeg_compress_struct c={0};struct jpeg_error_mgr e;c.err=jpeg_std_error(&e);jpeg_create_compress(&c);unsigned char*jpeg=NULL;jpeg_mem_dest(&c,&jpeg,n);c.image_width=w;c.image_height=h;c.input_components=3;c.in_color_space=JCS_RGB;jpeg_set_defaults(&c);jpeg_set_quality(&c,100,TRUE);jpeg_start_compress(&c,TRUE);unsigned char*row=malloc(w*3);assert(row);for(unsigned x=0;x<w;++x){row[x*3]=x<w/2?230:20;row[x*3+1]=80;row[x*3+2]=x<w/2?20:230;}while(c.next_scanline<h){JSAMPROW q=row;assert(jpeg_write_scanlines(&c,&q,1)==1);}jpeg_finish_compress(&c);jpeg_destroy_compress(&c);free(row);return jpeg;}
int main(int argc,char**argv){unsigned groups=0;unsigned long n;unsigned char*p=fixture(7102,5326,&n),*copy=malloc(n);assert(copy);memcpy(copy,p,n);if(argc==2){FILE*f=fopen(argv[1],"wb");assert(f&&fwrite(p,1,n,f)==n&&!fclose(f));}const unsigned stride=1600*3+16;size_t cap=(size_t)stride*1200;unsigned char*out=malloc(cap);assert(out);memset(out,0x55,cap);struct Iq4JpegDecodeResult55 r;
 assert(iq4_stock_jpeg_decode_rgb_55(p,n,out,cap,stride,1600,1200,guard,(void*)0x1234,&r)==1);assert(r.source_width==7102&&r.source_height==5326&&r.width==1600&&r.height==1199&&r.rows==1199);assert(!memcmp(copy,p,n));for(unsigned y=0;y<r.height;++y){assert(out[y*stride+6]>out[y*stride+8]+150);assert(out[y*stride+(r.width-3)*3+2]>out[y*stride+(r.width-3)*3]+150);for(unsigned x=r.width*3;x<stride;++x)assert(out[y*stride+x]==0x55);}++groups;
 calls=0;assert(iq4_stock_jpeg_decode_rgb_55(p,n,out,cap,stride,800,480,guard,(void*)0x1234,&r)==1);assert(r.width==640&&r.height==480&&r.rows==480);++groups;
 calls=0;stop=10;assert(iq4_stock_jpeg_decode_rgb_55(p,n,out,cap,stride,800,480,guard,(void*)0x1234,&r)==-1&&r.rows==0);stop=0;++groups;
 assert(iq4_stock_jpeg_decode_rgb_55(p,n,out,64,stride,800,480,guard,(void*)0x1234,&r)==0&&r.rows==0);++groups;
 /* A truncated entropy payload with a real EOI must not silently create a
  * valid-looking preview via libjpeg's recovery warnings. */
 unsigned char*bad=malloc(n);assert(bad);memcpy(bad,p,n);size_t shortn=n/2;bad[shortn-2]=255;bad[shortn-1]=217;assert(iq4_stock_jpeg_decode_rgb_55(bad,shortn,out,cap,stride,800,480,guard,(void*)0x1234,&r)==0&&r.rows==0);free(bad);++groups;
 assert(iq4_stock_jpeg_decode_rgb_55(p,n,p,n,64,10,10,guard,(void*)0x1234,&r)==0);assert(!memcmp(copy,p,n));++groups;
 calls=0;assert(iq4_stock_jpeg_decode_crop_rgb_55(p,n,0,0,3551,5326,out,cap,stride,500,750,guard,(void*)0x1234,&r)==1);assert(r.width==500&&r.height==749&&r.rows==749);for(unsigned y=0;y<r.height;++y)assert(out[y*stride+240*3]>out[y*stride+240*3+2]+150);++groups;
 calls=0;assert(iq4_stock_jpeg_decode_crop_rgb_55(p,n,3551,0,3551,5326,out,cap,stride,500,750,guard,(void*)0x1234,&r)==1);for(unsigned y=0;y<r.height;++y)assert(out[y*stride+240*3+2]>out[y*stride+240*3]+150);++groups;
 memset(out,0x55,cap);calls=0;assert(iq4_stock_jpeg_decode_crop_rgb_55(p,n,7100,0,10,10,out,cap,stride,500,750,guard,(void*)0x1234,&r)==0);for(size_t i=0;i<cap;++i)assert(out[i]==0x55);assert(!memcmp(copy,p,n));++groups;
 free(copy);free(p);p=fixture(640,480,&n);calls=0;assert(iq4_stock_jpeg_decode_rgb_55(p,n,out,cap,stride,800,480,guard,(void*)0x1234,&r)==1&&r.width==640&&r.height==480);free(p);free(out);++groups;
 printf("{\"groups\":%u,\"half_source\":[7102,5326],\"actual_entropy_decode\":true,\"camera_accessed\":false}\n",groups);return 0;}
