#include "observe.hpp"
#include "../f1_observe_stack_05/home_tables.hpp"
#include <cerrno>
#include <cmath>
#include <cstring>

namespace iq4::f1::display06 {
namespace {
bool ptr(Address p)noexcept{return p>=4096&&!(p&7U)&&p<=UINTPTR_MAX-0x5000;}
bool same(const Owner&a,const Owner&b)noexcept{return a.queue==b.queue&&a.manager==b.manager&&a.data==b.data&&a.lv==b.lv&&a.popup==b.popup;}
bool rect(const Rectangle24&r)noexcept{return r.width>0&&r.height>0&&std::int64_t(r.x)+r.width<=INT32_MAX&&std::int64_t(r.y)+r.height<=INT32_MAX;}
bool size(std::int32_t w,std::int32_t h)noexcept{return w>0&&h>0&&w<=1048576&&h<=1048576;}
bool same_input(const geometry03::PaintInput&a,const geometry03::PaintInput&b)noexcept{
 return a.thread_pointer==b.thread_pointer&&a.frame_pointer==b.frame_pointer&&a.caller_pc==b.caller_pc&&a.lv==b.lv&&a.surface==b.surface&&a.draw_rectangle==b.draw_rectangle&&a.clip_rectangle==b.clip_rectangle;
}
}
bool Collector::read(Address at,void*out,std::size_t n)const noexcept{return memory_.read&&out&&at>=4096&&n&&n<=4096&&at<=UINTPTR_MAX-n&&memory_.read(memory_.context,at,out,n);}
Collector::Collector(Memory m,Address b,Address callback)noexcept:memory_(m),callback_(callback){
 if(b||!ptr(callback))return; // same fixed ET_EXEC, no invented rebase.
 std::array<Address,61>actual{};
 if(!read(0xb9a9c8,actual.data(),sizeof(actual))||actual!=OriginalLVTable)return;
 shadow_=OriginalLVTable;shadow_[PaintWord]=callback_;table_ready_=true;
 state_.shadow_table_ready=1;state_.own_shadow_address_point=shadow_address_point();state_.own_paint_callback=callback_;
}
bool Collector::table(Address actual)const noexcept{
 if(!table_ready_)return false;
 std::array<Address,61>original{},got{};
 if(!read(0xb9a9c8,original.data(),sizeof(original))||original!=OriginalLVTable)return false;
 if(actual==0xb9a9d8)return true;
 return actual==shadow_address_point()&&read(actual-16,got.data(),sizeof(got))&&got==shadow_;
}
Result Collector::owner(Address tp,OwnerFacts&out,bool painting)const noexcept{
 out={};Address q{},v{},check{};
 if(!ptr(tp)||!word(tp+0x10,q)||!ptr(q)||!word(q,v)||v!=0xb91f48)return Result::OwnerRejected;
 auto&o=out.owner;o.queue=q;
 if(!word(q+0x1c8,o.manager)||!ptr(o.manager)||!word(o.manager,v)||v!=0xb8f358||!word(o.manager+8,check)||check!=q||
    !word(q+0x9b8,o.data)||!ptr(o.data)||!word(o.manager+0x790,check)||check!=o.data||!word(q+0x8c0,o.lv)||!ptr(o.lv)||
    !word(o.lv,out.actual_lv_vtable)||!table(out.actual_lv_vtable)||!word(o.lv+0xb0,check)||check!=o.manager)return Result::OwnerRejected;
 o.popup=o.lv+0x588;
 if(!word(o.popup,v)||v!=0xb931b0||!word(o.popup+0xb0,check)||check!=o.manager||!word(o.popup+0x128,v)||v!=0xb90020)return Result::OwnerRejected;
 if(bound_.queue&&!same(o,bound_))return Result::OwnerRejected;
 out.shadow_instance=out.actual_lv_vtable==shadow_address_point();
 std::uint8_t active{};
 if(!word(o.manager+0xc8,check)||check||!word(o.manager+0xd8,check)||check||!read(o.manager+0xe0,&active,1)||active)return Result::OwnerRejected;
 for(Address list:{o.manager+0x40,o.manager+0x68})if(!word(list,v)||v!=0xb8f4e8||!word(list+8,v)||v!=0xc22908||!word(list+16,v)||v!=0xc22960)return Result::Invalid;
 Address head=o.manager+0x78,node{},last{},first{},previous=head,priority=o.manager+0x50;unsigned count=0,kinds[3]{};
 if(!word(priority+8,v)||v!=priority||!word(priority+16,v)||v!=priority||!word(head+8,node)||!word(head+16,last))return Result::OwnerRejected;
 first=node;
 while(node!=head){
  if(count==3||!ptr(node))return Result::Invalid;
  Address f[4]{},primary{},manager{};std::uint8_t request{};
  if(!read(node,f,sizeof f)||f[2]!=previous||!ptr(f[3])||f[3]+0x88!=node||!word(f[3],primary)||!word(f[3]+0xb0,manager)||manager!=o.manager||!read(f[3]+0xa8,&request,1)||request)return Result::OwnerRejected;
  if(f[3]==o.lv&&f[0]==0xb9abf8&&primary==out.actual_lv_vtable)kinds[count]=1;
  else if(f[3]==o.popup&&f[0]==0xb933e0&&primary==0xb931b0)kinds[count]=3;
  else if(primary==0xb94fe8&&f[0]==0xb95200){
   unsigned char p[sizeof(stack05::HomePrimary)]{},n[sizeof(stack05::HomeNode)]{};
   if(!read(0xb94fd8,p,sizeof p)||std::memcmp(p,stack05::HomePrimary,sizeof p)||!read(0xb951f0,n,sizeof n)||std::memcmp(n,stack05::HomeNode,sizeof n))return Result::TableRejected;
   kinds[count]=2;
  }else return Result::OwnerRejected;
  ++count;previous=node;node=f[1];
 }
 if(!count||previous!=last||!word(head+8,node)||node!=first||!word(head+16,v)||v!=last)return Result::Changing;
 if(count==1&&kinds[0]==1)out.stack_shape=1;
 else if(count==2&&kinds[0]==2&&kinds[1]==1)out.stack_shape=2;
 else if(count==2&&kinds[0]==1&&kinds[1]==3)out.stack_shape=3;
 else if(count==3&&kinds[0]==2&&kinds[1]==1&&kinds[2]==3)out.stack_shape=4;
 else return Result::OwnerRejected;
 if(painting&&out.stack_shape>2)return Result::OwnerRejected;
 if(!word(o.manager+0x108,out.provider)||!ptr(out.provider)||!word(out.provider,out.provider_vtable)||!ptr(out.provider_vtable)||
    !word(out.provider_vtable+0x18,out.getter_target)||!word(out.provider_vtable+0x10,out.present_target)||
    !word(q+0x9c8,out.configurator_provider))return Result::ReadFailed;
 out.provider_alias_equal=out.provider==out.configurator_provider;
 if(out.provider_vtable>=4112){Address header[2]{};if(read(out.provider_vtable-16,header,sizeof header)){out.provider_offset_to_top=static_cast<std::int64_t>(header[0]);out.provider_typeinfo=header[1];out.provider_header_present=1;}}
 if(out.getter_target>=4096&&!(out.getter_target&3U))out.getter_prefix_present=read(out.getter_target,out.getter_first16,16);
 if(out.present_target>=4096&&!(out.present_target&3U))out.present_prefix_present=read(out.present_target,out.present_first16,16);
 if(!out.getter_prefix_present)std::memset(out.getter_first16,0,16);
 if(!out.present_prefix_present)std::memset(out.present_first16,0,16);
 for(const auto&r:OriginalUserTextRanges)if(out.getter_target>=r[0]&&out.getter_target<r[1])out.getter_in_original_user_executable_load=1;
 if(!word(o.manager+0x788,out.resource_wrapper)||!ptr(out.resource_wrapper)||!word(o.lv+0xf0,out.lv_resource_wrapper)||
    !word(out.resource_wrapper+0x10,out.resource_provider)||!ptr(out.resource_provider)||!word(out.resource_provider,out.resource_provider_vtable)||
    !word(o.popup+0xe0,out.popup_header)||!ptr(out.popup_header)||!read(out.popup_header+0x88,&out.popup_title,4)||
    !word(o.popup+0x128+0x18,out.popup_root)||!read(o.popup+0x128+0x348,&out.popup_depth,4)||!word(o.popup+0x128+0x350,out.popup_selected))return Result::ReadFailed;
 out.resource_alias_equal=out.resource_wrapper==out.lv_resource_wrapper;
 return Result::Collected;
}
Result Collector::geometry(const OwnerFacts&o,GeometryFacts&out)const noexcept{
 out={};auto&f=out.scalars;const Address lv=o.owner.lv;Address check{},vt{},borrow{};std::uint8_t run{},visible{},animation{},retain{};
 if(!word(lv+0x108,out.access)||!ptr(out.access)||!word(o.owner.data+0x118,check)||check!=out.access||!word(out.access,vt)||vt!=0xc07da8||!word(out.access+8,out.engine)||!ptr(out.engine))return Result::ReadFailed;
 if(!read(lv+0x28,&f.local_control,24)||!read(lv+0x44,&f.alignment_flags,4)||!read(lv+0x118,&f.pan_x,8)||
    !read(lv+0x138,&animation,1)||!read(lv+0x190,&f.scale,4)||!read(lv+0x194,&f.normal_fit_scale,4)||
    !read(lv+0x1b0,&f.rotation,4)||!read(lv+0x1b8,&f.countdown,4)||!read(lv+0x100,&f.client_id,4)||!read(out.access+0xb0,&f.access_owner,4)||
    !read(out.engine+0x4764,&f.config_width,4)||!read(out.engine+0x4768,&f.config_height,4)||!read(lv+0x104,&run,1)||!read(lv+0x6f,&visible,1)||!read(lv+0x1c0,&retain,1)||!word(lv+0x188,borrow))return Result::ReadFailed;
 if(run>1||visible>1||animation>1||retain>1||f.local_control.address_point!=0xb73b98||!rect(f.local_control)||!std::isfinite(f.scale)||f.scale<=0||!std::isfinite(f.normal_fit_scale)||f.normal_fit_scale<=0||!size(f.config_width,f.config_height)||f.client_id<0||f.client_id>4||f.access_owner< -1||f.access_owner>4||(f.rotation!=0&&f.rotation!=90&&f.rotation!=180&&f.rotation!=270))return Result::Invalid;
 f.running=run;f.visible=visible;f.pan_animation=animation;f.retain_borrowed=retain;f.borrowed_pointer_present=borrow!=0;
 out.buffer=out.engine+0x2170;
 if(!read(out.buffer+0xe8,&f.locked_slot,4)||f.locked_slot>4)return Result::Invalid;
 if(f.locked_slot<4){
  if(!read(out.buffer+0x50+8*f.locked_slot,&f.slot_width,8)||!read(out.buffer+0x70+24*f.locked_slot,&f.locked_roi,24)||!read(out.buffer+0xf4,&f.software_completion_id,4))return Result::ReadFailed;
  if(!size(f.slot_width,f.slot_height)||f.locked_roi.address_point!=0xb73b98||!rect(f.locked_roi))return Result::Invalid;
  f.locked_metadata_present=1;out.config_equals_slot=f.config_width==f.slot_width&&f.config_height==f.slot_height;
  out.config_equals_roi=f.config_width==f.locked_roi.width&&f.config_height==f.locked_roi.height;
  out.slot_equals_roi=f.slot_width==f.locked_roi.width&&f.slot_height==f.locked_roi.height;
 }
 struct Parent{Rectangle24 r{};Address at{};std::uint32_t flags{};std::int32_t pad{};};Parent parents[16]{};Address at=lv;bool valid=true;
 while(at){
  if(f.parent_depth==16){valid=false;break;}for(unsigned j=0;j<f.parent_depth;++j)if(parents[j].at==at)valid=false;if(!valid)break;
  auto&p=parents[f.parent_depth];p.at=at;Address pv{},helper{},parent{};
  if(!word(at,pv)||!word(pv+0x18,helper)||helper!=0x70c4c0||!word(pv+0xb8,helper)||helper!=0x4ab9d8||!word(pv+0x130,helper)||helper!=0x4abac8||
     !word(at+8,parent)||!read(at+0x28,&p.r,24)||p.r.address_point!=0xb73b98||!rect(p.r)||!read(at+0x44,&p.flags,4)||!read(at+0x48,&p.pad,4)){valid=false;break;}
  ++f.parent_depth;at=parent;
 }
 if(valid&&f.parent_depth){f.recursive_bounds_candidate=parents[f.parent_depth-1].r;
  for(unsigned j=f.parent_depth-1;j>0;--j){Rectangle24 transformed{};bool writes{};auto&p=parents[j-1];
   if(!geometry03::parent_transform(p.r,p.flags,p.pad,f.recursive_bounds_candidate,transformed,writes)){valid=false;break;}f.recursive_bounds_candidate=transformed;f.parent_transform_would_update_local_size|=writes;}
 }
 if(valid&&f.parent_depth){f.recursive_bounds_candidate_present=1;geometry03::Facts candidate{};candidate.recursive_bounds_candidate_present=true;candidate.recursive_bounds_candidate=f.recursive_bounds_candidate;
  candidate.config_width=f.config_width;candidate.config_height=f.config_height;candidate.scale=f.scale;candidate.pan_cached={f.pan_x,f.pan_y};
  geometry03::Point8 corners[4]={{0,0},{f.config_width,0},{f.config_width,f.config_height},{0,f.config_height}};bool ok=true;
  for(unsigned j=0;j<4;++j)ok&=geometry03::point_candidate(candidate,corners[j],out.config_point_candidates[j]);out.config_point_model_valid=ok;
 }
 return Result::Collected;
}
bool Collector::capture_boundary(const BoundaryInput&i,const stack05::Metadata&s,Metadata&out)noexcept{
 if(state_.boundary_attempts>=64)return false;
 Metadata next{};next.boundary_attempts=state_.boundary_attempts+1;next.paint_attempts=state_.paint_attempts;next.publication_epoch=state_.publication_epoch;
 next.paint_call_serial=state_.paint_call_serial;next.kind=static_cast<unsigned>(Kind::Boundary);next.shadow_table_ready=table_ready_;next.own_shadow_address_point=shadow_address_point();next.own_paint_callback=callback_;
 next.source_dispatch_epoch=state_.source_dispatch_epoch;next.source_stack_epoch=state_.source_stack_epoch;
 next.source_anchor_startup=state_.source_anchor_startup;next.source_anchor_relation=state_.source_anchor_relation;
 Result r=Result::SourceRejected;
 if(table_ready_&&s.schema==5&&s.bytes==sizeof(stack05::Metadata)&&s.result==1&&s.graph_present==1&&s.shape>=1&&s.shape<=4&&s.source_startup==4&&s.source_dispatch_epoch&&s.source_dispatch_epoch<=64&&s.source_dispatch_epoch>=state_.source_dispatch_epoch&&s.snapshot_epoch>state_.source_stack_epoch&&
    !s.native_current_called&&!s.paint_called&&!s.full_source_mapping_verified&&!s.fresh_blit_verified&&!s.surface_lease_verified&&!s.actual_scene_verified&&s.source.caller_pc==i.caller_pc&&s.source.frame_pointer==i.frame_pointer&&s.source.thread_pointer==i.thread_pointer&&s.source.mutex==i.mutex&&i.caller_pc==0x6be8ac&&!i.original_result){
  Boundary actual{};if(!Inspector(memory_,0).boundary(i,actual))r=Result::OwnerRejected;
  else if(!same(actual.owner,{s.source.queue,s.source.manager,s.source.data,s.source.lv,s.source.popup}))r=Result::Changing;
  else{r=owner(i.thread_pointer,next.owner_before,false);if(r==Result::Collected){r=geometry(next.owner_before,next.geometry_before);
    if(r==Result::Collected){r=owner(i.thread_pointer,next.owner_after,false);if(r==Result::Collected)r=geometry(next.owner_after,next.geometry_after);
     if(r==Result::Collected&&(std::memcmp(&next.owner_before,&next.owner_after,sizeof(OwnerFacts))||std::memcmp(&next.geometry_before,&next.geometry_after,sizeof(GeometryFacts))))r=Result::Changing;}
  }
 }
 }else if(!table_ready_)r=Result::TableRejected;
 if(r==Result::Collected){bound_=next.owner_after.owner;next.owner_present=next.geometry_present=1;next.geometry_before.scalars.consistent_double_read=next.geometry_after.scalars.consistent_double_read=1;next.source_dispatch_epoch=s.source_dispatch_epoch;next.source_stack_epoch=s.snapshot_epoch;next.source_anchor_startup=s.source_startup;next.source_anchor_relation=s.source_relation;++next.publication_epoch;}
 else{next.owner_before={};next.owner_after={};next.geometry_before={};next.geometry_after={};}
 next.result=static_cast<unsigned>(r);state_=next;out=next;return true;
}
Result Collector::paint_scope(const geometry03::PaintInput&i,PaintFacts&out)const noexcept{
 out={};if(!bound_.queue||i.caller_pc!=0x4abe94||!ptr(i.frame_pointer)||(i.frame_pointer&15U))return Result::NoPaintScope;
 Address parent{},lr{},manager_frame{},control_lr{},v{},provider{};
 if(!word(i.frame_pointer,parent)||!word(i.frame_pointer+8,lr)||lr!=i.caller_pc||parent<=i.frame_pointer||parent-i.frame_pointer>65536||(parent&15U)||
    !word(parent,manager_frame)||!word(parent+8,control_lr)||control_lr!=0x4e33bc||manager_frame<=parent||manager_frame-parent>65536||(manager_frame&15U)||
    !word(parent+0x48,v)||v!=i.lv||!word(parent+0x40,v)||v!=i.surface||i.draw_rectangle!=parent+0xb8||i.clip_rectangle!=parent+0xd0||
    !word(manager_frame+0x28,v)||v!=bound_.manager||!word(manager_frame+0x148,v)||v!=i.surface||!word(manager_frame+0x150,v)||v!=i.lv||i.lv!=bound_.lv||
    !word(bound_.manager+0x108,provider)||!ptr(provider)||!read(i.draw_rectangle,&out.input_draw,24)||!read(i.clip_rectangle,&out.input_clip,24)||
    out.input_draw.address_point!=0xb73b98||out.input_clip.address_point!=0xb73b98||!rect(out.input_draw)||!rect(out.input_clip))return Result::NoPaintScope;
 if(!geometry03::read_surface_metadata(memory_,0,i.surface,out.display_bounds,out.pitch_pixels,out.height)||!word(i.surface+8,out.draw_owner)||!word(out.draw_owner,out.draw_vtable))return Result::Invalid;
 out.thread_pointer=i.thread_pointer;out.wrapper_frame=i.frame_pointer;out.caller_pc=i.caller_pc;out.control_frame=parent;out.manager_frame=manager_frame;
 out.lv=i.lv;out.surface=i.surface;out.draw_arg=i.draw_rectangle;out.clip_arg=i.clip_rectangle;return Result::Collected;
}
bool Collector::before_paint(const geometry03::PaintInput&i,Metadata&out)noexcept{
 if(state_.paint_attempts>=64||paint_pending_)return false;
 Metadata next{};next.boundary_attempts=state_.boundary_attempts;next.paint_attempts=state_.paint_attempts+1;next.publication_epoch=state_.publication_epoch;
 next.paint_call_serial=state_.paint_call_serial+1;next.source_dispatch_epoch=state_.source_dispatch_epoch;next.source_stack_epoch=state_.source_stack_epoch;next.kind=2;
 next.shadow_table_ready=table_ready_;next.own_shadow_address_point=shadow_address_point();next.own_paint_callback=callback_;
 next.source_anchor_startup=state_.source_anchor_startup;next.source_anchor_relation=state_.source_anchor_relation;
 auto r=owner(i.thread_pointer,next.owner_before,true);if(r==Result::Collected)r=geometry(next.owner_before,next.geometry_before);if(r==Result::Collected)r=paint_scope(i,next.paint);
 if(r==Result::Collected){next.owner_present=next.geometry_present=1;pending_=i;paint_pending_=true;}
 else{next.owner_before={};next.geometry_before={};next.paint={};}
 next.result=static_cast<unsigned>(r);state_=next;out=next;return r==Result::Collected;
}
bool Collector::after_paint(const geometry03::PaintInput&i,const Rectangle24&returned,Metadata&out)noexcept{
 if(!paint_pending_||!same_input(i,pending_))return false;paint_pending_=false;
 auto next=state_;auto r=owner(i.thread_pointer,next.owner_after,true);if(r==Result::Collected)r=geometry(next.owner_after,next.geometry_after);
 PaintFacts actual{};if(r==Result::Collected)r=paint_scope(i,actual);
 if(r==Result::Collected&&(actual.surface!=next.paint.surface||actual.draw_owner!=next.paint.draw_owner||actual.draw_vtable!=next.paint.draw_vtable||std::memcmp(&next.owner_before,&next.owner_after,sizeof(OwnerFacts))))r=Result::Changing;
 if(r==Result::Collected){next.paint.original_return=returned;next.paint.original_returned_normally=1;next.paint.geometry_equal_before_after=!std::memcmp(&next.geometry_before,&next.geometry_after,sizeof(GeometryFacts));
  next.paint.post_draw=actual.input_draw;next.paint.post_clip=actual.input_clip;next.paint.post_display_bounds=actual.display_bounds;next.paint.post_pitch_pixels=actual.pitch_pixels;next.paint.post_height=actual.height;
  next.paint.surface_metadata_equal=actual.pitch_pixels==next.paint.pitch_pixels&&actual.height==next.paint.height&&!std::memcmp(&actual.display_bounds,&next.paint.display_bounds,sizeof(Rectangle24));
  next.paint_present=1;++next.publication_epoch;}
 else{next.owner_after={};next.geometry_after={};next.paint_present=0;next.paint.original_returned_normally=1;next.paint.original_return=returned;}
 next.result=static_cast<unsigned>(r);state_=next;out=next;return true;
}
void Collector::aborted_paint(Metadata&out)noexcept{paint_pending_=false;state_.paint_present=0;state_.paint.original_returned_normally=0;state_.paint.original_return={};state_.result=static_cast<unsigned>(Result::Invalid);out=state_;}
void publish(Published&p,const Metadata&m)noexcept{p.sequence.fetch_add(1,std::memory_order_acq_rel);p.metadata=m;p.sequence.fetch_add(1,std::memory_order_release);}
Rectangle24 forward_once(native_overlay::LVPaint original,void*lv,void*surface,const Rectangle24*draw,Rectangle24*clip,Collector*c,const geometry03::PaintInput*i,Published*p){
 const int incoming=errno;Metadata m{};const auto prior=c?c->snapshot().paint_attempts:0;const bool captured=c&&i&&c->before_paint(*i,m);if(p&&c&&(captured||c->snapshot().paint_attempts>prior))publish(*p,captured?m:c->snapshot());errno=incoming;
 Rectangle24 returned{};
 try{returned=original(lv,surface,draw,clip);}catch(...){const int saved=errno;if(c&&captured){c->aborted_paint(m);if(p)publish(*p,m);}errno=saved;throw;}
 const int saved=errno;if(c&&captured&&c->after_paint(*i,returned,m)&&p)publish(*p,m);errno=saved;return returned;
}
}
