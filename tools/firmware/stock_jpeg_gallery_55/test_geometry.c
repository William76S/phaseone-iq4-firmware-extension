#include "geometry.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
static unsigned rows,stop;
static int guard(void*ctx){assert(ctx==&rows);return ++rows!=stop;}
int main(void){
 struct Iq4JpegGalleryRoi55 display={100,200,900,1200},out={0};
 assert(iq4_jpeg_gallery_inverse_roi_55(4000,3000,90,&display,&out));
 assert(out.x==200&&out.y==2000&&out.width==1200&&out.height==900);
 assert(iq4_jpeg_gallery_inverse_roi_55(4000,3000,270,&display,&out));
 assert(out.x==2600&&out.y==100&&out.width==1200&&out.height==900);
 assert(iq4_jpeg_gallery_inverse_roi_55(4000,3000,180,&display,&out));
 assert(out.x==3000&&out.y==1600&&out.width==900&&out.height==1200);
 display.x=UINT32_MAX;assert(!iq4_jpeg_gallery_inverse_roi_55(4000,3000,90,&display,&out));
 display=(struct Iq4JpegGalleryRoi55){0,0,3000,4000};assert(iq4_jpeg_gallery_inverse_roi_55(4000,3000,90,&display,&out));assert(out.x==0&&out.y==0&&out.width==4000&&out.height==3000);
 assert(!iq4_jpeg_gallery_inverse_roi_55(4000,3000,45,&display,&out));
 uint8_t src[24]={1,0,0,2,0,0,3,0,0,99,99,99,4,0,0,5,0,0,6,0,0,99,99,99},dst[32];
 for(unsigned a=90;a<=270;a+=90){memset(dst,77,sizeof dst);rows=0;stop=0;
  assert(iq4_jpeg_gallery_rotate_rgb_55(src,sizeof src,12,3,2,a,dst,18,guard,&rows));
  const uint8_t want[3][6]={{4,1,5,2,6,3},{6,5,4,3,2,1},{3,6,2,5,1,4}};
  for(unsigned n=0;n<6;++n)assert(dst[n*3]==want[a/90-1][n]);for(unsigned n=18;n<sizeof dst;++n)assert(dst[n]==77);
 }
 rows=0;stop=2;assert(!iq4_jpeg_gallery_rotate_rgb_55(src,24,12,3,2,90,dst,18,guard,&rows));
 rows=0;stop=0;assert(!iq4_jpeg_gallery_rotate_rgb_55(src,24,12,3,2,90,dst,17,guard,&rows));
 assert(!iq4_jpeg_gallery_rotate_rgb_55(src,24,12,3,2,90,src,24,guard,&rows));
 puts("PASS 12 focused ROI/real padded RGB transpose/cancel/capacity/overlap checks");return 0;
}
