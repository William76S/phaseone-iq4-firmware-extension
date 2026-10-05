#include "observe.hpp"
#include <cmath>
#include <cstring>

namespace iq4::f1::observe04 {
namespace {
bool valid_source(const BoundaryInput&i,const entry01::Observation&s,unsigned startup,Address bias)noexcept {
    if(bias>UINTPTR_MAX-0xc22960 || startup!=4 || i.original_result || i.caller_pc!=bias+0x6be8ac ||
       s.schema!=1 || s.bytes!=424 || (s.sequence&1U) || (s.phase!=2 && s.phase!=3) ||
       s.dispatch_epoch!=s.qualified_boundaries || !s.dispatch_epoch || s.dispatch_epoch>64 ||
       s.native_original_calls<s.qualified_boundaries || s.native_original_calls>64 ||
       s.native_mutating_calls || s.mask_enabled || !std::isfinite(s.scale) ||
       s.caller_pc!=i.caller_pc || s.frame_pointer!=i.frame_pointer || s.thread_pointer!=i.thread_pointer || s.mutex!=i.mutex)return false;
    for(Address a:{s.queue,s.manager,s.data,s.lv,s.popup,s.popped_observer,s.frame_pointer,s.thread_pointer,s.mutex})if(a<4096 || (a&7U) || a>UINTPTR_MAX-0x5000)return false;
    const auto&k=s.original_stack;
    if(!k.normal_count || k.normal_count>8 || k.bounded_complete!=1 || k.lv_at_tail!=1 || k.priority_empty!=1 || k.dialogs[k.normal_count-1]!=s.lv)return false;
    for(unsigned n=k.normal_count;n<8;++n)if(k.nodes[n] || k.dialogs[n] || k.node_vtables[n])return false;
    return true;
}
bool same_owner(const Owner&o,const entry01::Observation&s)noexcept {
    return o.queue==s.queue && o.manager==s.manager && o.data==s.data && o.lv==s.lv && o.popup==s.popup;
}
struct Context {Address access{},engine{},buffer{};};
bool context(Memory m,Address bias,const entry01::Observation&s,Context&out)noexcept {
    Inspector p(m,bias);Address a{},b{},vt{},e{};
    if(!p.word(s.lv+0x108,a) || !p.word(s.data+0x118,b) || a!=b || a<4096 || (a&7U) ||
       a>UINTPTR_MAX-0xf8 || !p.word(a,vt) || vt!=bias+0xc07da8 || !p.word(a+8,e) || e<4096 || (e&7U) || e>UINTPTR_MAX-0x476c)return false;
    out={a,e,e+0x2170};return true;
}
bool equal(const Context&a,const Context&b)noexcept{return a.access==b.access && a.engine==b.engine && a.buffer==b.buffer;}
bool source_agrees(const entry01::Observation&s,const geometry03::Facts&f)noexcept {
    const auto&a=s.local_bounds;const auto&b=f.local_control;
    return s.phase==2 && a.address_point==b.address_point && a.x==b.x && a.y==b.y && a.width==b.width && a.height==b.height &&
      s.pan_x==f.pan_cached.x && s.pan_y==f.pan_cached.y && s.quarterturn==f.rotation && std::memcmp(&s.scale,&f.scale,4)==0 &&
      s.countdown==f.countdown && s.visible==f.visible && s.running==f.running;
}
WireFacts wire(const geometry03::Facts&f)noexcept {
    return {f.local_control,f.recursive_bounds_candidate,f.locked_roi,f.pan_cached.x,f.pan_cached.y,f.scale,f.normal_fit_scale,
      f.rotation,f.client_id,f.access_owner,f.config_width,f.config_height,f.slot_width,f.slot_height,f.countdown,f.software_completion_id,
      f.locked_slot,f.parent_depth,f.alignment_flags,f.running,f.visible,f.pan_animation,f.borrowed_pointer_present,f.retain_borrowed,
      f.locked_metadata_present,f.recursive_bounds_candidate_present,f.parent_transform_would_update_local_size,f.consistent_double_read,0};
}
}
bool Collector::capture(const BoundaryInput&i,const entry01::Observation&s,unsigned startup,Metadata&out)noexcept {
    // Rejected source does not advance/relabel an earlier geometry snapshot.
    // Valid successive dispatches are the sole finite sampling clock.
    if(!memory_.read || !valid_source(i,s,startup,bias_) || state_.attempts>=64 || s.dispatch_epoch!=state_.source_dispatch_epoch+1)return false;
    Metadata next{};next.attempts=state_.attempts+1;next.geometry_epoch=state_.geometry_epoch;
    next.successes=state_.successes;next.rejected=state_.rejected;next.source_dispatch_epoch=s.dispatch_epoch;
    next.source_startup=startup;next.source=s;
    Context before{},after{};geometry03::Observation observation{};Result result=Result::ReadFailed;
    if(context(memory_,bias_,s,before)){
      result=static_cast<Result>(geometry03::Probe(memory_,bias_).collect_boundary(i,observation));
      if(result==Result::Ok && (!same_owner(observation.owner,s) || !source_agrees(s,observation.facts) || !context(memory_,bias_,s,after) || !equal(before,after)))result=Result::Changing;
      if(result==Result::Ok && (!observation.facts.consistent_double_read || observation.facts.full_source_mapping_verified ||
         observation.facts.fresh_blit_verified || observation.facts.surface_lease_verified))result=Result::SourceRejected;
    }
    next.result=static_cast<unsigned>(result);
    if(result==Result::Ok){next.scalar_present=1;++next.successes;++next.geometry_epoch;next.access=after.access;next.engine=after.engine;next.buffer=after.buffer;next.facts=wire(observation.facts);}
    else ++next.rejected; // All context/facts stay zero, including after a prior success.
    state_=next;out=next;return true;
}
}
