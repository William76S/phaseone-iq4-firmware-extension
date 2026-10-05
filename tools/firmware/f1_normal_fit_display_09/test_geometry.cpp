#include "normal_fit.hpp"
#include <cassert>
#include <cstdio>
using namespace iq4::f1::normal09;
int main(){
 unsigned cases=0;
 for(auto source:std::array<std::array<int,2>,9>{{{800,600},{6048,4032},{14144,10656},{640,480},{4095,4095},{32768,1},{1,32768},{32767,16385},{641,481}}})
 for(auto view:std::array<Rect,6>{{{0,0,1280,720},{240,60,800,600},{11,17,639,479},{0,0,1,1},{1,1,4095,4095},{0,0,1440,1080}}})
 for(auto mode:std::array<iq4::MaskMode,5>{{iq4::MaskMode::Off,iq4::MaskMode::XPan65_24,iq4::MaskMode::Ratio16_9,iq4::MaskMode::Ratio3_2,iq4::MaskMode::Ratio1_1}}){
  Geometry g{};g.source_width=source[0];g.source_height=source[1];g.source_rectangle=g.clipped_source_rectangle={0,0,source[0],source[1]};g.image_viewport=view;g.display_bounds=g.clip={0,0,4096,4096};g.scale=g.normal_fit_scale=1;
  iq4::display::ViewMapping m{};assert(normal_mapping(g,m)==GeometryResult::NormalFullView);
  iq4::f1::native_overlay::FixedPlan expected{},actual{};
  assert(iq4::f1::native_overlay::fixed_plan(iq4::display::makeDrawPlan(m,{mode,.65,false}),expected));
  assert(fixed_normal_plan(g,mode,actual));assert(expected.count==actual.count&&expected.hidden==actual.hidden);
  if(expected.count)assert(expected.alpha==actual.alpha&&actual.alpha==166);
  for(std::size_t i=0;i<actual.count;i++){auto a=actual.bands[i],b=expected.bands[i];assert(a.x==b.x&&a.y==b.y&&a.width==b.width&&a.height==b.height);}
  ++cases;
 }
 Geometry invalid{};iq4::f1::native_overlay::FixedPlan out{};assert(!fixed_normal_plan(invalid,iq4::MaskMode::Ratio1_1,out));
 assert(cases==270);std::puts("270 owned fixed-array plans match frozen vector geometry; no target execution");
}
