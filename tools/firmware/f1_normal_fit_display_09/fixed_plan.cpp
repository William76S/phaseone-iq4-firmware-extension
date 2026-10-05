#include "normal_fit.hpp"
#include <algorithm>
#include <cmath>
#include <limits>
namespace iq4::f1::normal09 {
namespace {
bool raster(double l,double t,double r,double b,Rect&out)noexcept{
 if(!std::isfinite(l)||!std::isfinite(t)||!std::isfinite(r)||!std::isfinite(b)||r<l||b<t)return false;
 l=std::ceil(l-.5);t=std::ceil(t-.5);r=std::ceil(r-.5);b=std::ceil(b-.5);
 if(l<0||t<0||r>4096||b>4096||r<l||b<t)return false;
 out={int(l),int(t),int(r-l),int(b-t)};return true;
}
bool overlap(Rect a,Rect b)noexcept{return a.x<b.x+b.width&&b.x<a.x+a.width&&a.y<b.y+b.height&&b.y<a.y+a.height;}
}
bool fixed_normal_plan(const Geometry&g,MaskMode mode,native_overlay::FixedPlan&out)noexcept{
 out={};out.image_clip=g.image_viewport;
 display::ViewMapping m{};if(normal_mapping(g,m)!=GeometryResult::NormalFullView)return false;
 if(mode==MaskMode::Off){out.hidden=MaskHidden::Disabled;return true;}
 double ratio{};
 switch(mode){case MaskMode::XPan65_24:ratio=65.0/24.0;break;case MaskMode::Ratio16_9:ratio=16.0/9.0;break;case MaskMode::Ratio3_2:ratio=3.0/2.0;break;case MaskMode::Ratio1_1:ratio=1;break;default:return false;}
 const auto&s=m.fullSource;const double w=std::min(s.width,s.height*ratio),h=w/ratio;
 const iq4::Rect f{s.x+(s.width-w)/2,s.y+(s.height-h)/2,w,h};
 // Exactly the frozen centered full-source crop and four disjoint source bands.
 // Zero-rotation normal-fit maps them to axis-aligned rectangles: no vector,
 // polygon allocation, arbitrary shear/rotation, stdlib allocation or lround.
 const iq4::Rect bands[4]={{s.x,s.y,s.width,f.y-s.y},{s.x,f.y+f.height,s.width,s.y+s.height-f.y-f.height},{s.x,f.y,f.x-s.x,f.height},{f.x+f.width,f.y,s.x+s.width-f.x-f.width,f.height}};
 out.hidden=MaskHidden::None;out.alpha=166;
 for(const auto&b:bands){
  if(b.width<=0||b.height<=0)continue;
  const auto&v=m.sourceToDisplay;
  const double l=v.a*b.x+v.c*b.y+v.tx,t=v.b*b.x+v.d*b.y+v.ty;
  const double r=v.a*(b.x+b.width)+v.c*(b.y+b.height)+v.tx,bb=v.b*(b.x+b.width)+v.d*(b.y+b.height)+v.ty;
  Rect px{};if(!raster(l,t,r,bb,px))return false;if(!px.width||!px.height)continue;
  const auto clip=out.image_clip;if(px.x<clip.x||px.y<clip.y||px.x+px.width>clip.x+clip.width||px.y+px.height>clip.y+clip.height||out.count>=4)return false;
  for(std::size_t i=0;i<out.count;i++)if(overlap(px,out.bands[i]))return false;
  out.bands[out.count++]=px;
 }
 // No actual write, source or lease qualification is minted by pure planning.
 return true;
}
}
