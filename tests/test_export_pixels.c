#include "../src/codec/export_pixels.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
/* Independent floating geometric reference for small cells, with rotation
 * materialized into another matrix. The production sampler uses integers. */
static void reference(const unsigned char*oriented,unsigned sw,unsigned sh,unsigned ow,unsigned oh,unsigned y,unsigned char*out){
 for(unsigned x=0;x<ow;++x)for(unsigned c=0;c<3;++c){double sum=0;
  double left=(double)x*sw/ow,right=(double)(x+1)*sw/ow,top=(double)y*sh/oh,bottom=(double)(y+1)*sh/oh;
  for(unsigned sy=0;sy<sh;++sy)for(unsigned sx=0;sx<sw;++sx){double l=left>sx?left:sx,r=right<sx+1?right:sx+1,t=top>sy?top:sy,b=bottom<sy+1?bottom:sy+1;
   if(r>l&&b>t)sum+=(r-l)*(b-t)*oriented[((size_t)sy*sw+sx)*3+c];}
  out[(size_t)x*3+c]=(unsigned char)(sum/((right-left)*(bottom-top))+0.5000000001);
 }
}
int main(void){unsigned groups=0;
 for(unsigned h=1;h<12;++h)for(unsigned w=1;w<16;++w){size_t stride=(size_t)w*4+17,n=stride*h;
  unsigned char*src=malloc(n),*copy=malloc(n);memset(src,0xee,n);
  for(unsigned y=0;y<h;++y)for(unsigned x=0;x<w;++x)for(unsigned c=0;c<3;++c)src[(size_t)y*stride+x*4+c+1]=(unsigned char)(x*31+y*47+c*83);
  memcpy(copy,src,n);
  for(unsigned r=0;r<4;++r)for(unsigned mode=0;mode<4;++mode){struct Iq4ExportPixels p;
   if(!iq4_export_pixels_init(&p,src,n,stride,w,h,r*90,mode)){struct Iq4ExportGeometry g;assert(iq4_export_geometry(w,h,r*90,mode,&g)!=IQ4_EXPORT_GEOMETRY_OK);continue;}
   unsigned sw=r%2?h:w,sh=r%2?w:h;unsigned char*rot=malloc(sw*sh*3);
   /* Materialize with forward source-to-destination transforms. */
   for(unsigned y=0;y<h;++y)for(unsigned x=0;x<w;++x){unsigned dx,dy;
    if(r==0){dx=x;dy=y;}else if(r==1){dx=h-1-y;dy=x;}else if(r==2){dx=w-1-x;dy=h-1-y;}else{dx=y;dy=w-1-x;}
    memcpy(rot+((size_t)dy*sw+dx)*3,src+(size_t)y*stride+x*4+1,3);
   }
   unsigned char out[64],expected[64];for(unsigned y=0;y<p.geometry.output_height;++y){memset(out,0xcc,sizeof out);assert(iq4_export_pixels_row(&p,y,out,sizeof out));
    reference(rot,sw,sh,p.geometry.output_width,p.geometry.output_height,y,expected);assert(!memcmp(out,expected,p.geometry.output_width*3));
    for(unsigned x=p.geometry.output_width*3;x<sizeof out;++x)assert(out[x]==0xcc);
   }
   assert(!iq4_export_pixels_row(&p,p.geometry.output_height,out,sizeof out));assert(!iq4_export_pixels_row(&p,0,out,p.geometry.output_width*3-1));
   assert(!iq4_export_pixels_row(&p,0,src,n));assert(!memcmp(src,copy,n));free(rot);++groups;
  }
  free(copy);free(src);
 }
 unsigned char small[24]={0},out[6];struct Iq4ExportPixels p;
 assert(!iq4_export_pixels_init(&p,small,sizeof small,12,3,2,45,0));
 assert(!iq4_export_pixels_init(&p,small,sizeof small,12,3,2,0,IQ4_EXPORT_LONG3840));
 assert(!iq4_export_pixels_init(&p,small,23,12,3,2,0,0));assert(!iq4_export_pixels_init(&p,small,24,11,3,2,0,0));
 assert(!iq4_export_pixels_init(&p,(unsigned char*)(UINTPTR_MAX-4),24,12,3,2,0,0));
 assert(!iq4_export_pixels_row(0,0,out,sizeof out));
 printf("PASS: %u independent area/rotation/stride/unchanged-source cases plus six invalid-input groups\n",groups);return 0;
}
