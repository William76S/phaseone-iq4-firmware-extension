#include "export_pixels.h"
#include <string.h>
static int overlaps(const void*a,size_t an,const void*b,size_t bn){uintptr_t x=(uintptr_t)a,y=(uintptr_t)b;
 if(!a||!b||!an||!bn)return 0;if(an>UINTPTR_MAX-x||bn>UINTPTR_MAX-y)return 1;return x<y+bn&&y<x+an;}
int iq4_export_pixels_init(struct Iq4ExportPixels*out,const unsigned char*pixels,size_t bytes,
 size_t stride,uint32_t w,uint32_t h,uint32_t r,uint32_t size){
 if(!out||overlaps(out,sizeof(*out),pixels,bytes))return 0;
 memset(out,0,sizeof(*out));
 if(!pixels||!w||!h||w>65500||h>65500||stride<(size_t)w*4||bytes>UINTPTR_MAX-(uintptr_t)pixels||
  (h>1&&stride>(SIZE_MAX-(size_t)w*4)/(h-1))||
  (size_t)(h-1)*stride+(size_t)w*4>bytes)return 0;
 if(iq4_export_geometry(w,h,r,size,&out->geometry)!=IQ4_EXPORT_GEOMETRY_OK)return 0;
 out->pixels=pixels;out->bytes=bytes;out->stride=stride;out->source_width=w;out->source_height=h;return 1;
}
static const unsigned char*pixel(const struct Iq4ExportPixels*p,uint32_t x,uint32_t y){uint32_t sx,sy;
 switch(p->geometry.rotation){
 case 0:sx=x;sy=y;break;
 case 90:sx=y;sy=p->source_height-1-x;break;
 case 180:sx=p->source_width-1-x;sy=p->source_height-1-y;break;
 case 270:sx=p->source_width-1-y;sy=x;break;
 default:return 0;
 }
 return p->pixels+(size_t)sy*p->stride+(size_t)sx*4;
}
int iq4_export_pixels_row(const struct Iq4ExportPixels*p,uint32_t row,unsigned char*out,size_t n){
 if(!p||!p->pixels||!out||row>=p->geometry.output_height||
  n<(size_t)p->geometry.output_width*3||overlaps(out,n,p,sizeof(*p))||overlaps(out,n,p->pixels,p->bytes))return 0;
 const int sideways=p->geometry.rotation==90||p->geometry.rotation==270;
 const uint32_t sw=sideways?p->source_height:p->source_width,sh=sideways?p->source_width:p->source_height;
 const uint32_t ow=p->geometry.output_width,oh=p->geometry.output_height;
 if(!sw||!sh||!ow||!oh||ow>sw||oh>sh)return 0;
 /* Half-open rational cells: source x bounds are [ix*ow,(ix+1)*ow),
  * target x bounds [ox*sw,(ox+1)*sw). Integer overlap weights avoid floating
  * rounding seams, including odd sizes and 90/270 degree rotations. */
 const uint64_t top=(uint64_t)row*sh,bottom=(uint64_t)(row+1)*sh,den=(uint64_t)sw*sh;
 uint32_t first_y=(uint32_t)(top/oh),last_y=(uint32_t)((bottom-1)/oh);
 for(uint32_t ox=0;ox<ow;++ox){uint64_t sum[3]={0,0,0};
  uint64_t left=(uint64_t)ox*sw,right=(uint64_t)(ox+1)*sw;
  uint32_t first_x=(uint32_t)(left/ow),last_x=(uint32_t)((right-1)/ow);
  for(uint32_t iy=first_y;iy<=last_y;++iy){uint64_t st=(uint64_t)iy*oh,sb=st+oh;
   uint64_t wy=(bottom<sb?bottom:sb)-(top>st?top:st);
   for(uint32_t ix=first_x;ix<=last_x;++ix){uint64_t sl=(uint64_t)ix*ow,sr=sl+ow;
    uint64_t weight=wy*((right<sr?right:sr)-(left>sl?left:sl));
    const unsigned char*q=pixel(p,ix,iy);if(!q)return 0;
    sum[0]+=weight*q[1];sum[1]+=weight*q[2];sum[2]+=weight*q[3];
   }
  }
  for(unsigned c=0;c<3;++c)out[(size_t)ox*3+c]=(unsigned char)((sum[c]+den/2)/den);
 }
 return 1;
}
