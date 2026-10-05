#include "export_geometry.h"
enum Iq4ExportGeometryStatus iq4_export_geometry(uint32_t w,uint32_t h,
 uint32_t rotation,uint32_t mode,struct Iq4ExportGeometry *out) {
 struct Iq4ExportGeometry g={0};uint64_t num,den;
 if(!out)return IQ4_EXPORT_GEOMETRY_ARGUMENT;
 *out=g;
 if(!w||!h||mode>IQ4_EXPORT_LONG7680||
    (rotation!=0&&rotation!=90&&rotation!=180&&rotation!=270))
  return IQ4_EXPORT_GEOMETRY_ARGUMENT;
 if(w>65500||h>65500)return IQ4_EXPORT_GEOMETRY_LIMIT;
 if(mode<=IQ4_EXPORT_25){
  static const uint32_t pct[]={100,75,50,25};num=pct[mode];den=100;
 }else{
  num=mode==IQ4_EXPORT_LONG3840?3840:7680;den=w>h?w:h;
  if(num>den)return IQ4_EXPORT_GEOMETRY_UPSCALE;
 }
 g.source_width=w;g.source_height=h;g.rotation=rotation;g.size_mode=mode;
 g.unrotated_width=(uint32_t)(((uint64_t)w*num+den/2)/den);
 g.unrotated_height=(uint32_t)(((uint64_t)h*num+den/2)/den);
 if(!g.unrotated_width||!g.unrotated_height||g.unrotated_width>w||g.unrotated_height>h)
  return IQ4_EXPORT_GEOMETRY_LIMIT;
 g.output_width=g.unrotated_width;g.output_height=g.unrotated_height;
 if(rotation==90||rotation==270){g.output_width=g.unrotated_height;g.output_height=g.unrotated_width;}
 *out=g;return IQ4_EXPORT_GEOMETRY_OK;
}
