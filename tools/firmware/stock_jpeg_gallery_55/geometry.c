#include "geometry.h"
#include <string.h>
int iq4_jpeg_gallery_inverse_roi_55(uint32_t sw,uint32_t sh,uint32_t angle,
 const struct Iq4JpegGalleryRoi55*r,struct Iq4JpegGalleryRoi55*out){
 if(!sw||!sh||!r||!out||!r->width||!r->height||
    (angle!=0&&angle!=90&&angle!=180&&angle!=270))return 0;
 uint32_t dw=(angle==90||angle==270)?sh:sw,dh=(angle==90||angle==270)?sw:sh;
 if((uint64_t)r->x+r->width>dw||(uint64_t)r->y+r->height>dh)return 0;
 struct Iq4JpegGalleryRoi55 n=*r;
 if(angle==90){n.x=r->y;n.y=sh-r->x-r->width;n.width=r->height;n.height=r->width;}
 else if(angle==180){n.x=sw-r->x-r->width;n.y=sh-r->y-r->height;}
 else if(angle==270){n.x=sw-r->y-r->height;n.y=r->x;n.width=r->height;n.height=r->width;}
 *out=n;return 1;
}
int iq4_jpeg_gallery_rotate_rgb_55(const uint8_t*src,size_t source_capacity,
 uint32_t stride,uint32_t w,uint32_t h,uint32_t angle,uint8_t*dst,size_t capacity,
 int(*guard)(void*),void*context){
 if(!src||!dst||!guard||!w||!h||w>3840||h>3840||
    (angle!=90&&angle!=180&&angle!=270)||stride<(uint64_t)w*3||
    (uint64_t)(h-1)*stride+(uint64_t)w*3>source_capacity)return 0;
 uint32_t dw=angle==180?w:h,dh=angle==180?h:w;size_t bytes=(size_t)dw*dh*3;
 if(bytes>capacity||bytes>32u*1024u*1024u||source_capacity>32u*1024u*1024u||
    (uintptr_t)src>UINTPTR_MAX-source_capacity||(uintptr_t)dst>UINTPTR_MAX-capacity||
    ((uintptr_t)src<(uintptr_t)dst+capacity&&(uintptr_t)dst<(uintptr_t)src+source_capacity))return 0;
 for(uint32_t y=0;y<h;++y){if(guard(context)!=1)return 0;
  for(uint32_t x=0;x<w;++x){uint32_t dx,dy;
   if(angle==90){dx=h-1-y;dy=x;}else if(angle==180){dx=w-1-x;dy=h-1-y;}else{dx=y;dy=w-1-x;}
   memcpy(dst+((size_t)dy*dw+dx)*3,src+(size_t)y*stride+3u*x,3);
  }
 }
 return guard(context)==1;
}
