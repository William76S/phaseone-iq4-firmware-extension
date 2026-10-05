#include "normal_fit.hpp"
#include <algorithm>
#include <cmath>
#include <cstring>
#include <limits>
namespace iq4::f1::normal08 {
namespace {
bool positive(Rect r)noexcept{return r.width>0&&r.height>0&&r.width<=4096&&r.height<=4096&&r.x>=0&&r.y>=0&&std::int64_t(r.x)+r.width<=4096&&std::int64_t(r.y)+r.height<=4096;}
bool same(Rect a,Rect b)noexcept{return a.x==b.x&&a.y==b.y&&a.width==b.width&&a.height==b.height;}
bool contains(Rect a,Rect b)noexcept{return positive(a)&&positive(b)&&b.x>=a.x&&b.y>=a.y&&std::int64_t(b.x)+b.width<=std::int64_t(a.x)+a.width&&std::int64_t(b.y)+b.height<=std::int64_t(a.y)+a.height;}
bool unite(Rect a,Rect b,Rect&out)noexcept{
 if(!positive(a)){out=b;return positive(b);}if(!positive(b))return false;
 auto x=std::min(a.x,b.x),y=std::min(a.y,b.y);auto r=std::max(a.x+a.width,b.x+b.width),d=std::max(a.y+a.height,b.y+b.height);
 out={x,y,r-x,d-y};return positive(out);
}
bool mode(MaskMode m)noexcept{return m==MaskMode::Off||m==MaskMode::XPan65_24||m==MaskMode::Ratio16_9||m==MaskMode::Ratio3_2||m==MaskMode::Ratio1_1;}
}
GeometryResult normal_mapping(const Geometry&g,display::ViewMapping&out)noexcept{
 out={};if(g.source_width<=0||g.source_height<=0||g.source_width>32768||g.source_height>32768||!positive(g.image_viewport)||!positive(g.display_bounds)||!contains(g.display_bounds,g.image_viewport)||!positive(g.clip)||!std::isfinite(g.scale)||!std::isfinite(g.normal_fit_scale)||g.scale<=0||g.normal_fit_scale<=0)return GeometryResult::Invalid;
 if(g.rotation!=0&&g.rotation!=90&&g.rotation!=180&&g.rotation!=270)return GeometryResult::Invalid;
 if(g.pan_animation||g.pan.x||g.pan.y||g.scale!=g.normal_fit_scale)return GeometryResult::ZoomOrPan;
 const Rect full{0,0,g.source_width,g.source_height};
 if(!same(g.source_rectangle,full)||!same(g.clipped_source_rectangle,full))return GeometryResult::PartialSource;
 // Normal-fit ratios belong to the actual complete displayed source extent.
 // This is issued only for a sealed native write, not from config W/H alone.
 out.fullSource={0,0,double(g.source_width),double(g.source_height)};
 out.imageViewport={double(g.image_viewport.x),double(g.image_viewport.y),double(g.image_viewport.width),double(g.image_viewport.height)};
 const double sx=double(g.image_viewport.width)/(g.rotation==90||g.rotation==270?g.source_height:g.source_width);
 const double sy=double(g.image_viewport.height)/(g.rotation==90||g.rotation==270?g.source_width:g.source_height);
 const double x=g.image_viewport.x,y=g.image_viewport.y;
 switch(g.rotation){
 case 0:out.sourceToDisplay={sx,0,0,sy,x,y};break;
 case 90:out.sourceToDisplay={0,sy,-sx,0,x+g.image_viewport.width,y};break;
 case 180:out.sourceToDisplay={-sx,0,0,-sy,x+g.image_viewport.width,y+g.image_viewport.height};break;
 case 270:out.sourceToDisplay={0,-sy,sx,0,x,y+g.image_viewport.height};break;
 }
 out.fullSourceMappingKnown=true;return GeometryResult::NormalFullView;
}
bool Renderer::on_ui()const noexcept{return status_.phase!=Phase::Unbound&&native_.current_thread&&native_.current_thread(native_.context)==owner_.queue;}
bool Renderer::current()const noexcept{
 if(!on_ui())return false;native_ui02::Inspector p(memory_,0);Address v{};
 for(const auto&c:std::array<std::array<Address,2>,8>{{{owner_.queue,0xb91f48},{owner_.queue+0x1c8,owner_.manager},{owner_.manager,0xb8f358},{owner_.manager+8,owner_.queue},{owner_.queue+0x9b8,owner_.data},{owner_.manager+0x790,owner_.data},{owner_.queue+0x8c0,owner_.lv},{owner_.lv+0xb0,owner_.manager}}})if(!p.word(c[0],v)||v!=c[1])return false;
 if(!p.word(owner_.lv,v)||v!=0xb9a9d8)return false;
 // Reuse the bounded original list model; no Current/getter invocation.
 entry01::StackFacts stack{};if(!entry01::observe_stack(memory_,0,owner_,stack)||!stack.priority_empty||!stack.bounded_complete||!stack.lv_at_tail||!stack.normal_count||stack.normal_count>2)return false;
 if(stack.normal_count==2&&(!p.word(stack.dialogs[0],v)||v!=0xb94fd8||stack.node_vtables[0]!=0xb951f0))return false;
 return stack.node_vtables[stack.normal_count-1]==0xb9abf8;
}
bool Renderer::bind_once_on_ui(native_ui02::Memory m,native_ui02::Native n,native_overlay::FillWrapper f,const native_ui02::Owner&o,entry07::Binding*e)noexcept{
 if(status_.phase!=Phase::Unbound||!m.read||!n.current_thread||!n.invalidate||!f||!o.queue||!o.lv||!o.manager||n.current_thread(n.context)!=o.queue)return false;
 memory_=m;native_=n;fill_=f;owner_=o;entry_=e;status_.phase=Phase::OffClean;
 if(!current()){status_.phase=Phase::Unbound;return false;}return true;
}
bool Renderer::install_selection_once_on_ui(entry07::Binding&e)noexcept{
 if(status_.selection_installed||!current()||status_.phase!=Phase::OffClean||status_.actual_geometry_known)return false;
 if(!e.install_selection_once_on_ui(selection_port()))return false;entry_=&e;status_.selection_installed=1;return true;
}
entry07::SelectResult Renderer::apply(void*p,MaskMode m,std::uint64_t g)noexcept{return p?static_cast<Renderer*>(p)->select(m,g):entry07::SelectResult::Rejected;}
entry07::SelectResult Renderer::select(MaskMode m,std::uint64_t generation)noexcept{
 if(!current()||busy_||status_.phase==Phase::Hold||status_.phase==Phase::Detached||!mode(m)||!generation||generation<=status_.generation){++status_.rejected;return entry07::SelectResult::Rejected;}
 if(m==MaskMode::Off&&status_.factory_restored&&!positive(required_clean_)){status_.requested=m;status_.generation=generation;return entry07::SelectResult::AlreadyOff;}
 if(m!=MaskMode::Off&&!status_.actual_geometry_known){++status_.rejected;return entry07::SelectResult::Rejected;}
 // The callback does not touch pixels. The next actual complete stock write
 // must restore old/new union before any new alpha fills are allowed.
 status_.requested=m;status_.generation=generation;status_.factory_restored=0;status_.phase=Phase::Waiting;
 try{native_.invalidate(reinterpret_cast<void*>(owner_.lv),false);}catch(...){hold();return entry07::SelectResult::Rejected;}
 return entry07::SelectResult::AwaitingStockPaint;
}
bool Renderer::surface(const WriteFacts&w)const noexcept{
 if(!w.surface||!w.draw||!w.provider||!w.provider_vtable||!w.getter_target||!w.manager_frame)return false;
 unsigned char b[0x38]{};Address sv{},dv{},draw{};std::int32_t pitch{},height{};Rectangle bounds{};
 if(!memory_.read(memory_.context,w.surface,b,sizeof b))return false;
 std::memcpy(&sv,b,8);std::memcpy(&draw,b+8,8);std::memcpy(&pitch,b+0x14,4);std::memcpy(&height,b+0x18,4);std::memcpy(&bounds,b+0x20,24);
 if(sv!=0xb7b780||draw!=w.draw||pitch<=0||height<=0||pitch>4096||height>4096||bounds.address_point!=0xb73b98||bounds.x||bounds.y||bounds.width!=pitch||bounds.height!=height||!same(w.geometry.display_bounds,{0,0,pitch,height}))return false;
 return memory_.read(memory_.context,draw,&dv,8)&&dv==0xb7b7d8;
}
bool Renderer::after_native_write_on_ui(const PaintToken&t)noexcept{
 const auto&w=t.facts();if(!current()||busy_||status_.phase==Phase::Hold||status_.phase==Phase::Detached||w.queue!=owner_.queue||w.lv!=owner_.lv||!w.paint_serial||w.paint_serial<=status_.last_paint||!w.geometry_epoch||!surface(w)){++status_.rejected;return false;}
 display::ViewMapping mapping{};const auto kind=normal_mapping(w.geometry,mapping);
 if(kind==GeometryResult::Invalid){hold();return false;}
 // The entire prior viewport must be rewritten before hiding or changing it.
 // Moving a stock zoom view cannot leave old bars behind and call that OFF.
 const Rect coverage=w.geometry.image_viewport,clean=w.stock_clean_coverage;
 if(!contains(clean,coverage)||!contains(w.geometry.display_bounds,clean))return false;
 if(positive(required_clean_)&&(!contains(clean,required_clean_)||!contains(w.geometry.clip,required_clean_)))return false;
 if(!contains(w.geometry.clip,coverage))return false;
 native_overlay::FixedPlan next{};
 try{
  if(kind==GeometryResult::NormalFullView){mask_.select(status_.requested);if(!native_overlay::fixed_plan(mask_.plan(mapping),next)){hold();return false;}}
  else {next.image_clip=coverage;next.hidden=MaskHidden::SourceCoordinatesUnavailable;}
 }catch(...){hold();return false;}
 Rect needed{};if(!unite(required_clean_,coverage,needed)||!contains(clean,needed)||!contains(w.geometry.clip,needed))return false;
 busy_=true;
 try{
  const native_overlay::Color4 black{next.alpha,0,0,0};
  const native_overlay::Rectangle24 clip{0xb73b98,coverage.x,coverage.y,coverage.width,coverage.height};
  for(std::size_t i=0;i<next.count;++i){const auto&r=next.bands[i];if(!contains(coverage,r)){hold();busy_=false;return false;}
   const native_overlay::Rectangle24 draw{0xb73b98,r.x,r.y,r.width,r.height};fill_(reinterpret_cast<void*>(w.surface),&draw,&clip,&black);++status_.fills;
  }
 }catch(...){hold();busy_=false;return false;}
 // A completed stock write that hides/OFF produces no new own pixels. Do not
 // retain a clean zoom viewport as a fake future mask restoration obligation.
 busy_=false;plan_=next;required_clean_=next.count?coverage:Rect{};status_.last_paint=w.paint_serial;status_.geometry_epoch=w.geometry_epoch;
 status_.actual_geometry_known=kind==GeometryResult::NormalFullView;
 status_.factory_restored=next.count==0;status_.phase=status_.requested==MaskMode::Off?Phase::OffClean:kind==GeometryResult::NormalFullView?Phase::Shown:Phase::Hidden;
 if(entry_&&entry_->status_on_ui().phase==static_cast<unsigned>(entry07::Phase::AwaitingStockPaint)){
  // These legacy booleans are derived only here from the sealed actual token;
  // there is no public external three-boolean/native-return input adapter.
  const native_ui02::PaintReceipt receipt{w.lv,w.surface,status_.generation,w.paint_serial,coverage,clean,true,true,true};
  if(!entry_->observe_stock_paint_on_ui(receipt)){hold();return false;}
 }
 return true;
}
bool Renderer::off_and_detach_on_ui(std::uint64_t epoch)noexcept{
 if(!current()||busy_||status_.requested!=MaskMode::Off||!status_.factory_restored||status_.phase!=Phase::OffClean||!epoch)return false;
 if(entry_&&!entry_->detach_on_ui(epoch))return false;status_.phase=Phase::Detached;return true;
}
bool install_after_original_boundary(Renderer&r,const entry07::BoundaryInput&in,entry01::Module&m,entry07::Binding&e,native_ui02::Memory memory)noexcept{
 if(in.original_result||in.caller_pc!=0x6be8ac||e.status_on_ui().phase!=static_cast<unsigned>(entry07::Phase::Ready))return false;
 entry01::Observation observed{};if(!m.snapshot(observed)||!observed.dispatch_epoch||observed.lv!=m.observed_owner().lv)return false;
 if(r.status_on_ui().phase==Phase::Unbound&&!r.bind_once_on_ui(memory,m.selector_ports(),m.overlay_ports().fill,m.observed_owner(),&e))return false;
 return r.status_on_ui().selection_installed||r.install_selection_once_on_ui(e);
}
}
