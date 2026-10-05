#include "overlay.hpp"
#include <cassert>
#include <cstring>
#include <iostream>
#include <stdexcept>
#include <vector>
using namespace iq4;
namespace f=iq4::f1::native_overlay;
thread_local f::Address thread_token=11;
struct Host;
thread_local Host* active=nullptr;
struct Host {
 std::array<unsigned char,0x58> surface{};std::array<unsigned char,8> draw{};
 std::vector<unsigned char> input=std::vector<unsigned char>(256*256,200),output=input;
 std::vector<unsigned> hits=std::vector<unsigned>(256*256,0);
 unsigned native_calls{},fill_calls{},repaints{},surface_pixel_pointer_reads{};bool repaint_ok=true,throw_fill=false;
 f::Adapter adapter;
 Host(){active=this;f::Address vt=0xb7b780,dptr=reinterpret_cast<f::Address>(draw.data()),dvt=0xb7b7d8,forbidden=0xdeadbeef;std::int32_t n=256;
  std::memcpy(surface.data(),&vt,8);std::memcpy(surface.data()+8,&dptr,8);std::memcpy(draw.data(),&dvt,8);std::memcpy(surface.data()+0x14,&n,4);std::memcpy(surface.data()+0x18,&n,4);f::Rectangle24 r{0xb73b98,0,0,n,n};std::memcpy(surface.data()+0x20,&r,24);std::memcpy(surface.data()+0x38,&forbidden,8);
 }
 static bool read(void* p,f::Address address,void* dst,std::size_t n) noexcept {
  auto& h=*static_cast<Host*>(p);auto s=reinterpret_cast<f::Address>(h.surface.data()),d=reinterpret_cast<f::Address>(h.draw.data());
  if(address>=s&&address-s<=h.surface.size()&&n<=h.surface.size()-(address-s)){
   if(address-s+n>0x38)++h.surface_pixel_pointer_reads;
   std::memcpy(dst,reinterpret_cast<void*>(address),n);return true;
  }
  if(address>=d&&address-d<=h.draw.size()&&n<=h.draw.size()-(address-d)){std::memcpy(dst,reinterpret_cast<void*>(address),n);return true;}return false;
 }
 static f::Address current(void* p) noexcept{++static_cast<Host*>(p)->native_calls;return thread_token;}
 static bool repaint(void* p,f::Address lv) noexcept{auto& h=*static_cast<Host*>(p);++h.native_calls;++h.repaints;assert(lv==0x100);return h.repaint_ok;}
 static void fill(void* s,const f::Rectangle24* r,const f::Rectangle24* clip,const f::Color4* color){
  auto& h=*active;++h.native_calls;++h.fill_calls;if(h.throw_fill)throw std::runtime_error("synthetic primitive");
  assert(s==h.surface.data()&&r->address_point==0xb73b98&&r->width>0&&r->height>0&&clip->width>0&&clip->height>0&&color->alpha&&color->c1==0&&color->c2==0&&color->c3==0);
  auto mutable_clone=*clip;mutable_clone.x=std::max(0,mutable_clone.x);mutable_clone.y=std::max(0,mutable_clone.y);
  for(int y=r->y;y<r->y+r->height;++y)for(int x=r->x;x<r->x+r->width;++x){assert(x>=0&&y>=0&&x<256&&y<256&&x>=mutable_clone.x&&y>=mutable_clone.y&&x<clip->x+clip->width&&y<clip->y+clip->height);auto i=static_cast<std::size_t>(y)*256+x;h.output[i]=static_cast<unsigned char>(h.output[i]*(255-color->alpha)/255);++h.hits[i];}
 }
 f::Gate gate(){return {f::UserSHA,11,0x100,0,256,256,true,true,true,true,true,true,true,true};}
 bool configure(){return adapter.configure({this,read},{fill,this,current,repaint},gate());}
 f::Receipt receipt(std::uint64_t serial,std::uint64_t epoch=1){f::Receipt r;r.LV=0x100;r.surface=reinterpret_cast<f::Address>(surface.data());r.clip={0xb73b98,0,0,256,256};r.actual_stock_repaint_coverage={0,0,256,256};r.UI_paint_serial=serial;r.geometry_epoch=epoch;r.configuration_generation=adapter.status_on_ui().generation;r.original_returned_normally=true;r.actual_native_image_blit_completed=true;r.display_owner_lease_live=true;r.LV_still_current=true;return r;}
 void stock(){output=input;std::fill(hits.begin(),hits.end(),0);}
};
display::ViewMapping mapping(unsigned turn=0){
 display::ViewMapping m;m.fullSource={0,0,120,80};m.fullSourceMappingKnown=true;
 switch(turn){case 0:m.imageViewport={30,40,120,80};m.sourceToDisplay={1,0,0,1,30,40};break;
 case 90:m.imageViewport={30,40,80,120};m.sourceToDisplay={0,1,-1,0,110,40};break;
 case 180:m.imageViewport={30,40,120,80};m.sourceToDisplay={-1,0,0,-1,150,120};break;
 default:m.imageViewport={30,40,80,120};m.sourceToDisplay={0,-1,1,0,30,160};break;}return m;
}
int main(){
#if !defined(IQ4_F1_OVERLAY_SYNTHETIC_HOST)
 Host h;assert(!h.configure());assert(h.adapter.select_on_ui(MaskMode::XPan65_24,mapping(),1)==f::Result::Disabled);assert(h.adapter.after_original_paint_on_ui(h.receipt(1))==f::Result::Disabled);assert(h.adapter.disable_on_ui()==f::Result::Disabled&&h.native_calls==0&&h.fill_calls==0&&h.surface_pixel_pointer_reads==0);std::cout<<"production disabled: zero native reads/calls\n";return 0;
#else
 unsigned groups=0;std::uint64_t compared=0;
 {for(auto mode:{MaskMode::XPan65_24,MaskMode::Ratio16_9,MaskMode::Ratio3_2,MaskMode::Ratio1_1})for(unsigned rotation:{0,90,180,270}){
   Host h;assert(h.configure());auto m=mapping(rotation);assert(h.adapter.select_on_ui(mode,m,1)==f::Result::Pending);auto receipt=h.receipt(1);const auto old_clip=receipt.clip;assert(h.adapter.after_original_paint_on_ui(receipt)==f::Result::Ok&&std::memcmp(&old_clip,&receipt.clip,sizeof(old_clip))==0);
   const double ratio=mode==MaskMode::XPan65_24?65./24:mode==MaskMode::Ratio16_9?16./9:mode==MaskMode::Ratio3_2?3./2:1;
   const double crop_w=ratio<1.5?80*ratio:120,crop_h=ratio>1.5?120/ratio:80,crop_x=(120-crop_w)/2,crop_y=(80-crop_h)/2;
   const auto a=m.sourceToDisplay;const double determinant=a.a*a.d-a.b*a.c;
   for(int y=0;y<256;++y)for(int x=0;x<256;++x){
     const double dx=x+.5-a.tx,dy=y+.5-a.ty,sx=(a.d*dx-a.c*dy)/determinant,sy=(-a.b*dx+a.a*dy)/determinant;
     const bool image=sx>=0&&sx<120&&sy>=0&&sy<80,masked=image&&(sx<crop_x||sx>=crop_x+crop_w||sy<crop_y||sy>=crop_y+crop_h);auto i=static_cast<std::size_t>(y)*256+x;
     assert(h.output[i]==(masked?69:200)&&h.hits[i]==(masked?1u:0u));++compared;
   }
   assert(h.input==std::vector<unsigned char>(256*256,200)&&h.surface_pixel_pointer_reads==0);
  }++groups;}
 {Host h;assert(h.configure());assert(h.adapter.select_on_ui(MaskMode::Off,mapping(),1)==f::Result::Pending);assert(h.adapter.after_original_paint_on_ui(h.receipt(1))==f::Result::Ok&&h.fill_calls==0&&h.adapter.status_on_ui().phase==f::Phase::OffClean);++groups;}
 {Host h;assert(h.configure());assert(h.adapter.select_on_ui(MaskMode::XPan65_24,mapping(),1)==f::Result::Pending);auto r=h.receipt(1);r.actual_native_image_blit_completed=false;assert(h.adapter.after_original_paint_on_ui(r)==f::Result::Pending&&h.fill_calls==0);r=h.receipt(2);assert(h.adapter.after_original_paint_on_ui(r)==f::Result::Ok);auto output=h.output;assert(h.adapter.after_original_paint_on_ui(r)==f::Result::Rejected&&h.output==output&&h.adapter.status_on_ui().duplicate_paints==1);++groups;}
 {Host h;assert(h.configure());assert(h.adapter.select_on_ui(MaskMode::Ratio1_1,mapping(),1)==f::Result::Pending);assert(h.adapter.after_original_paint_on_ui(h.receipt(1))==f::Result::Ok);assert(h.adapter.disable_on_ui()==f::Result::Pending&&!h.adapter.status_on_ui().factory_repaint_confirmed);auto r=h.receipt(2);r.actual_native_image_blit_completed=false;assert(h.adapter.after_original_paint_on_ui(r)==f::Result::Pending);r=h.receipt(3);r.actual_stock_repaint_coverage={30,40,20,20};assert(h.adapter.after_original_paint_on_ui(r)==f::Result::Pending);h.stock();assert(h.adapter.after_original_paint_on_ui(h.receipt(4))==f::Result::Ok&&h.output==h.input&&h.adapter.status_on_ui().phase==f::Phase::FactoryRestored);assert(h.adapter.disable_on_ui()==f::Result::Rejected);++groups;}
 {Host h;assert(h.configure());assert(h.adapter.select_on_ui(MaskMode::XPan65_24,mapping(),1)==f::Result::Pending);auto r=h.receipt(1);r.clip.width=20;assert(h.adapter.after_original_paint_on_ui(r)==f::Result::Pending&&h.fill_calls==0);++groups;}
 {Host h;assert(h.configure());assert(h.adapter.select_on_ui(MaskMode::Ratio1_1,mapping(),1)==f::Result::Pending);auto r=h.receipt(1);r.geometry_epoch=2;assert(h.adapter.after_original_paint_on_ui(r)==f::Result::Rejected&&h.fill_calls==0);r=h.receipt(2);r.configuration_generation=100;assert(h.adapter.after_original_paint_on_ui(r)==f::Result::Rejected&&h.fill_calls==0);++groups;}
 {Host h;assert(h.configure());thread_token=22;assert(h.adapter.select_on_ui(MaskMode::Ratio1_1,mapping(),1)==f::Result::WrongThread&&h.adapter.after_original_paint_on_ui(h.receipt(1))==f::Result::WrongThread&&h.fill_calls==0);thread_token=11;++groups;}
 {Host h;assert(h.configure());assert(h.adapter.select_on_ui(MaskMode::Ratio1_1,mapping(),1)==f::Result::Pending);auto r=h.receipt(1);r.LV_still_current=false;assert(h.adapter.after_original_paint_on_ui(r)==f::Result::Hold&&h.fill_calls==0);assert(h.adapter.disable_on_ui()==f::Result::Rejected&&h.adapter.status_on_ui().callback_and_module_retained);++groups;}
 {Host h;assert(h.configure());assert(h.adapter.select_on_ui(MaskMode::Ratio1_1,mapping(),1)==f::Result::Pending);std::uint32_t pitch=255;std::memcpy(h.surface.data()+0x14,&pitch,4);assert(h.adapter.after_original_paint_on_ui(h.receipt(1))==f::Result::Hold&&h.fill_calls==0);++groups;}
 {Host h;assert(h.configure());assert(h.adapter.select_on_ui(MaskMode::Ratio1_1,mapping(),1)==f::Result::Pending);auto r=h.receipt(1);r.clip.width=0;assert(h.adapter.after_original_paint_on_ui(r)==f::Result::Hold&&h.fill_calls==0);++groups;}
 {Host h;assert(h.configure());h.repaint_ok=false;assert(h.adapter.select_on_ui(MaskMode::Ratio1_1,mapping(),1)==f::Result::Hold&&h.fill_calls==0);++groups;}
 {Host h;assert(h.configure());auto m=mapping();m.sourceToDisplay.c=.3;assert(h.adapter.select_on_ui(MaskMode::Ratio1_1,m,1)==f::Result::Rejected&&h.fill_calls==0&&h.repaints==0);++groups;}
 {Host h;assert(h.configure());auto m=mapping();m.imageViewport={30.5,40,120+8e-11,80};m.sourceToDisplay={1,0,1e-12,1,30.5,40};assert(h.adapter.select_on_ui(MaskMode::Ratio1_1,m,1)==f::Result::Rejected&&h.fill_calls==0&&h.repaints==0);++groups;}
 {Host h;assert(h.configure());const f::PixelRect A{30,40,120,80},B{40,40,100,80};auto original=mapping();assert(h.adapter.select_on_ui(MaskMode::Ratio1_1,original,1)==f::Result::Pending);assert(h.adapter.after_original_paint_on_ui(h.receipt(1))==f::Result::Ok);
  auto next=original;next.imageViewport={40,40,100,80};next.sourceToDisplay={100./120,0,0,1,40,40};assert(h.adapter.select_on_ui(MaskMode::Ratio1_1,next,2)==f::Result::Pending);
  auto r=h.receipt(2,2);r.actual_stock_repaint_coverage=B;r.clip={0xb73b98,B.x,B.y,B.width,B.height};assert(h.adapter.after_original_paint_on_ui(r)==f::Result::Pending);h.stock();r=h.receipt(3,2);r.actual_stock_repaint_coverage=A;r.clip={0xb73b98,A.x,A.y,A.width,A.height};assert(h.adapter.after_original_paint_on_ui(r)==f::Result::Ok);
  h.stock();r=h.receipt(4,2);r.actual_stock_repaint_coverage=B;r.clip={0xb73b98,B.x,B.y,B.width,B.height};assert(h.adapter.after_original_paint_on_ui(r)==f::Result::Ok&&h.fill_calls==6);
  assert(h.adapter.disable_on_ui()==f::Result::Pending);h.stock();r=h.receipt(5,2);r.actual_stock_repaint_coverage=B;r.clip={0xb73b98,B.x,B.y,B.width,B.height};assert(h.adapter.after_original_paint_on_ui(r)==f::Result::Ok&&h.output==h.input&&h.adapter.status_on_ui().phase==f::Phase::FactoryRestored);++groups;}
 {Host h;assert(h.configure());auto m=mapping();m.focusZoom=true;m.fullSourceMappingKnown=false;assert(h.adapter.select_on_ui(MaskMode::Ratio1_1,m,1)==f::Result::Pending);assert(h.adapter.plan_on_ui().hidden==MaskHidden::SourceCoordinatesUnavailable);assert(h.adapter.after_original_paint_on_ui(h.receipt(1))==f::Result::Ok&&h.fill_calls==0);++groups;}
 {Host h;assert(h.configure());assert(h.adapter.select_on_ui(MaskMode::Ratio1_1,mapping(),1)==f::Result::Pending);h.throw_fill=true;assert(h.adapter.after_original_paint_on_ui(h.receipt(1))==f::Result::Hold);auto count=h.fill_calls;assert(h.adapter.after_original_paint_on_ui(h.receipt(2))==f::Result::Rejected&&h.fill_calls==count);++groups;}
 {f::PaintObservation o;o.original_return={0xb73b98,0,0,800,480};o.original_returned_normally=true;assert(f::candidate_native_blit(o));o.pre_original_countdown=1;assert(!f::candidate_native_blit(o));o.pre_original_countdown=0;o.original_return.width=0;assert(!f::candidate_native_blit(o));++groups;}
 {display::DrawPlan p;p.hidden=MaskHidden::None;p.imageClip={0,0,100,100};p.fills={{{{10.01,20},{10.1,20},{10.1,30},{10.01,30}},.65}};f::FixedPlan fixed;assert(f::fixed_plan(p,fixed)&&fixed.count==0);p.fills={{{{10,20},{20,20},{20,30},{10,30}},.65},{{{15,25},{25,25},{25,35},{15,35}},.65}};assert(!f::fixed_plan(p,fixed));p.hidden=MaskHidden::Disabled;assert(!f::fixed_plan(p,fixed));++groups;}
 {Host h;bool f::Gate::* flags[]={&f::Gate::actual_whole_User_and_segments,&f::Gate::actual_UI_owner_boundary,&f::Gate::actual_LV_paint_ABI,&f::Gate::actual_display_surface_owner_and_extent,&f::Gate::actual_source_geometry_and_image_viewport,&f::Gate::actual_original_blit_receipt,&f::Gate::actual_original_repaint_and_disable_restore,&f::Gate::actual_callback_lifetime};for(auto flag:flags){f::Adapter a;auto g=h.gate();g.*flag=false;assert(!a.configure({&h,Host::read},{Host::fill,&h,Host::current,Host::repaint},g));}assert(h.native_calls==0);++groups;}
 assert(groups==19&&compared==1048576);std::cout<<"19 F1 own-code groups; 1048576 independent pixels; vendor/device execution zero\n";
#endif
}
