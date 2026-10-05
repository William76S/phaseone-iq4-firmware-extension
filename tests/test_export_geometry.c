#include "../src/codec/export_geometry.h"
#include <assert.h>
#include <stdio.h>
int main(void){
 struct Iq4ExportGeometry g;
 const uint32_t expected[6][2]={{14204,10652},{10653,7989},{7102,5326},
                              {3551,2663},{3840,2880},{7680,5759}};
 for(uint32_t m=0;m<6;++m)for(uint32_t r=0;r<360;r+=90){
  assert(iq4_export_geometry(14204,10652,r,m,&g)==IQ4_EXPORT_GEOMETRY_OK);
  assert(g.unrotated_width==expected[m][0]&&g.unrotated_height==expected[m][1]);
  assert(g.output_width==expected[m][r==90||r==270?1:0]);
  assert(g.output_height==expected[m][r==90||r==270?0:1]);
 }
 assert(iq4_export_geometry(139,101,0,IQ4_EXPORT_75,&g)==IQ4_EXPORT_GEOMETRY_OK&&g.output_width==104&&g.output_height==76);
 assert(iq4_export_geometry(139,101,0,IQ4_EXPORT_50,&g)==IQ4_EXPORT_GEOMETRY_OK&&g.output_width==70&&g.output_height==51);
 assert(iq4_export_geometry(3000,2000,0,IQ4_EXPORT_LONG3840,&g)==IQ4_EXPORT_GEOMETRY_UPSCALE&&!g.output_width);
 assert(iq4_export_geometry(3840,2000,0,IQ4_EXPORT_LONG3840,&g)==IQ4_EXPORT_GEOMETRY_OK&&g.output_width==3840&&g.output_height==2000);
 assert(iq4_export_geometry(2000,10000,90,IQ4_EXPORT_LONG7680,&g)==IQ4_EXPORT_GEOMETRY_OK&&g.output_width==7680&&g.output_height==1536);
 assert(iq4_export_geometry(0,1,0,0,&g)==IQ4_EXPORT_GEOMETRY_ARGUMENT);
 assert(iq4_export_geometry(1,1,0,IQ4_EXPORT_25,&g)==IQ4_EXPORT_GEOMETRY_LIMIT);
 assert(iq4_export_geometry(65501,1,0,0,&g)==IQ4_EXPORT_GEOMETRY_LIMIT);
 assert(iq4_export_geometry(100,100,45,0,&g)==IQ4_EXPORT_GEOMETRY_ARGUMENT);
 printf("{\"geometry_checks\":33,\"target_executed\":false}\n");return 0;
}
