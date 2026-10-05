#include "observe.hpp"
#include "home_tables.hpp"
#include <cmath>
#include <cstring>

namespace iq4::f1::stack05 {
namespace {
bool pointer(Address a)noexcept{return a>=4096 && !(a&7U) && a<=UINTPTR_MAX-0x5000;}
bool same_owner(const Owner&a,const Owner&b)noexcept{return a.queue==b.queue&&a.manager==b.manager&&a.data==b.data&&a.lv==b.lv&&a.popup==b.popup;}
bool source_owner(const Owner&o,const entry01::Observation&s)noexcept{return same_owner(o,{s.queue,s.manager,s.data,s.lv,s.popup});}
bool source_common(const entry01::Observation&s)noexcept {
    return s.schema==1&&s.bytes==424&&!(s.sequence&1U)&&s.dispatch_epoch==s.qualified_boundaries&&s.dispatch_epoch<=64&&
      s.native_original_calls>=s.qualified_boundaries&&s.native_original_calls<=64&&!s.native_mutating_calls&&!s.mask_enabled&&std::isfinite(s.scale);
}
bool pair(const BoundaryInput&i,const entry01::Observation&before,const entry01::Observation&s,unsigned startup,Address bias,Relation&relation)noexcept {
    if(bias>UINTPTR_MAX-0xc22960||startup!=4||i.original_result||i.caller_pc!=bias+0x6be8ac||!source_common(before)||!source_common(s)||
       (before.phase!=1&&before.phase!=2&&before.phase!=3)||(s.phase!=2&&s.phase!=3)||!s.dispatch_epoch||
       s.caller_pc!=i.caller_pc||s.frame_pointer!=i.frame_pointer||s.thread_pointer!=i.thread_pointer||s.mutex!=i.mutex)return false;
    for(Address a:{s.queue,s.manager,s.data,s.lv,s.popup,s.popped_observer,s.frame_pointer,s.thread_pointer,s.mutex})if(!pointer(a))return false;
    const auto&k=s.original_stack;
    if(!k.normal_count||k.normal_count>8||k.bounded_complete!=1||k.lv_at_tail!=1||k.priority_empty!=1||k.dialogs[k.normal_count-1]!=s.lv)return false;
    for(unsigned n=k.normal_count;n<8;++n)if(k.nodes[n]||k.dialogs[n]||k.node_vtables[n])return false;
    if(s.dispatch_epoch==before.dispatch_epoch+1&&s.sequence==before.sequence+2&&s.rejected_boundaries==before.rejected_boundaries&&
       s.native_original_calls==before.native_original_calls+1){relation=Relation::FreshEntry;return true;}
    if(s.dispatch_epoch!=before.dispatch_epoch||s.sequence!=before.sequence||s.native_original_calls<before.native_original_calls||
       s.native_original_calls>before.native_original_calls+1||s.rejected_boundaries<before.rejected_boundaries||s.rejected_boundaries>before.rejected_boundaries+1)return false;
    // Failed Entry attempts change only these two counters. A prior anchor may
    // describe an older LV tail; do not overwrite its phase/stack/epoch.
    auto a=before,b=s;a.rejected_boundaries=b.rejected_boundaries=0;a.native_original_calls=b.native_original_calls=0;
    if(std::memcmp(&a,&b,sizeof a))return false;
    relation=Relation::PriorEntryAnchor;return true;
}
bool same_boundary(const Boundary&a,const Boundary&b)noexcept {
    return same_owner(a.owner,b.owner)&&a.popped_observer==b.popped_observer&&a.pop_frame==b.pop_frame&&a.dispatch_frame==b.dispatch_frame;
}
bool source_graph(const entry01::StackFacts&s,const Facts&f)noexcept {
    if(s.priority_first!=f.priority_first||s.priority_last!=f.priority_last||s.normal_first!=f.normal_first||s.normal_last!=f.normal_last||
       s.normal_count!=f.count||s.bounded_complete!=f.complete||s.priority_empty!=f.priority_empty)return false;
    for(unsigned i=0;i<f.count;++i)if(s.nodes[i]!=f.nodes[i].node||s.dialogs[i]!=f.nodes[i].dialog||s.node_vtables[i]!=f.nodes[i].node_vtable)return false;
    return true;
}
Shape shape(const Facts&f)noexcept {
    for(unsigned i=0;i<f.count;++i)if(f.nodes[i].request_pending)return Shape::Unsupported;
    const auto kind=[&](unsigned i,Kind k){return f.nodes[i].kind==static_cast<unsigned>(k);};
    if(f.count==1&&kind(0,Kind::LV))return Shape::SoleLV;
    if(f.count==2&&kind(0,Kind::HomeCandidate)&&kind(1,Kind::LV))return Shape::HomeCandidateLV;
    if(f.count==2&&kind(0,Kind::LV)&&kind(1,Kind::Popup))return Shape::LVPopup;
    if(f.count==3&&kind(0,Kind::HomeCandidate)&&kind(1,Kind::LV)&&kind(2,Kind::Popup))return Shape::HomeCandidateLVPopup;
    return Shape::Unsupported;
}
template<std::size_t N>bool exact(Inspector&p,Address at,const unsigned char(&expected)[N])noexcept {
    unsigned char bytes[N]{};return p.read(at,bytes,N)&&!std::memcmp(bytes,expected,N);
}
}
Result Collector::once(const Owner&o,Facts&out)const noexcept {
    Inspector p(memory_,bias_);Facts f{};Address v{};
    if(!p.word(o.manager+0xc8,f.override_dialog)||!p.word(o.manager+0xd8,f.aux_dialog))return Result::ReadFailed;
    std::uint8_t active{};if(!p.read(o.manager+0xe0,&active,1))return Result::ReadFailed;f.aux_active=active;
    if(f.override_dialog||f.aux_dialog||f.aux_active)return Result::OwnerRejected;
    for(Address list:{o.manager+0x40,o.manager+0x68})if(!p.word(list,v)||v!=bias_+0xb8f4e8||!p.word(list+8,v)||v!=bias_+0xc22908||
      !p.word(list+16,v)||v!=bias_+0xc22960)return Result::Invalid;
    const Address priority=o.manager+0x50,normal=o.manager+0x78;
    if(!p.word(priority+8,f.priority_first)||!p.word(priority+16,f.priority_last)||!p.word(normal+8,f.normal_first)||!p.word(normal+16,f.normal_last))return Result::ReadFailed;
    if(f.priority_first!=priority||f.priority_last!=priority)return Result::OwnerRejected;
    f.priority_empty=1;Address node=f.normal_first,previous=normal;
    while(node!=normal){
      if(f.count==8||!pointer(node))return Result::Invalid;
      for(unsigned i=0;i<f.count;++i)if(f.nodes[i].node==node)return Result::Invalid;
      Address fields[4]{};if(!p.read(node,fields,sizeof fields))return Result::ReadFailed;
      if(!pointer(fields[0])||fields[2]!=previous||!pointer(fields[3])||fields[3]+0x88!=node)return Result::Invalid;
      auto&n=f.nodes[f.count];n.node=node;n.dialog=fields[3];n.node_vtable=fields[0];n.next=fields[1];n.previous=fields[2];
      std::uint8_t request{};
      if(!p.word(n.dialog,n.primary_vtable)||!p.word(n.dialog+0xb0,n.manager)||!p.read(n.dialog+0xa8,&request,1))return Result::ReadFailed;
      if(!pointer(n.primary_vtable)||n.manager!=o.manager||request>1)return Result::Invalid;n.request_pending=request;
      if(n.dialog==o.lv){if(n.primary_vtable!=bias_+0xb9a9d8||n.node_vtable!=bias_+0xb9abf8)return Result::Invalid;n.kind=static_cast<unsigned>(Kind::LV);}
      else if(n.dialog==o.popup){if(n.primary_vtable!=bias_+0xb931b0||n.node_vtable!=bias_+0xb933e0)return Result::Invalid;n.kind=static_cast<unsigned>(Kind::Popup);}
      else if(n.primary_vtable==bias_+0xb94fe8&&n.node_vtable==bias_+0xb95200){
        if(!exact(p,bias_+0xb94fd8,HomePrimary)||!exact(p,bias_+0xb951f0,HomeNode))return Result::ReadFailed;
        n.kind=static_cast<unsigned>(Kind::HomeCandidate);
      }
      ++f.count;previous=node;node=n.next;
    }
    if(!f.count||previous!=f.normal_last)return Result::Invalid;
    Address first{},last{};if(!p.word(normal+8,first)||!p.word(normal+16,last))return Result::ReadFailed;
    if(first!=f.normal_first||last!=f.normal_last)return Result::Changing;
    f.complete=1;out=f;return Result::Collected;
}
bool Collector::capture(const BoundaryInput&i,const entry01::Observation&before,const entry01::Observation&s,unsigned startup,Metadata&out)noexcept {
    Relation relation{};
    if(!memory_.read||state_.attempts>=64||!pair(i,before,s,startup,bias_,relation)||
       (relation==Relation::FreshEntry&&s.dispatch_epoch!=state_.source_dispatch_epoch+1)||
       (relation==Relation::PriorEntryAnchor&&s.dispatch_epoch!=state_.source_dispatch_epoch))return false;
    Metadata next{};next.attempts=state_.attempts+1;next.snapshot_epoch=state_.snapshot_epoch;next.accepted=state_.accepted;next.rejected=state_.rejected;
    next.source_dispatch_epoch=s.dispatch_epoch;next.prior_source_dispatch_epoch=before.dispatch_epoch;next.prior_source_sequence=before.sequence;
    next.source_startup=startup;next.source_relation=static_cast<unsigned>(relation);next.source=s;
    Inspector p(memory_,bias_);Boundary a{},b{};Facts fa{},fb{};Result r=Result::OwnerRejected;
    if(p.boundary(i,a)){
      if(!source_owner(a.owner,s))r=Result::Changing;
      else{
        r=once(a.owner,fa);
        if(r==Result::Collected){
          if(!p.boundary(i,b)||!same_boundary(a,b))r=Result::Changing;
          else{r=once(b.owner,fb);if(r==Result::Collected&&std::memcmp(&fa,&fb,sizeof fa))r=Result::Changing;}
          if(r==Result::Collected&&relation==Relation::FreshEntry&&(!source_graph(s.original_stack,fa)||a.popped_observer!=s.popped_observer))r=Result::Changing;
        }
      }
    }
    if(r==Result::Collected){
      next.graph_present=1;next.facts=fa;next.actual_popped_observer=a.popped_observer;
      next.normal_tail_dialog=fa.nodes[fa.count-1].dialog;next.selected_dialog_projection=next.normal_tail_dialog;next.normal_tail_projection=1;
      next.shape=static_cast<unsigned>(shape(fa));++next.snapshot_epoch;
      if(next.shape==static_cast<unsigned>(Shape::Unsupported))r=Result::Unsupported;
    }
    next.result=static_cast<unsigned>(r);
    if(r==Result::Collected)++next.accepted;else ++next.rejected;
    // All graph facts are absent on read/owner/transition failure, never an
    // earlier success carried into a new source relation/epoch.
    state_=next;out=next;return true;
}
}
