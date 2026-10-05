#include "module.hpp"
#include "../f1_entry_button_ports_01/entries.hpp"
#include <cstring>
namespace iq4::f1::entry01 {
namespace {
bool same(const Owner&a,const Owner&b)noexcept{return a.queue==b.queue&&a.manager==b.manager&&a.data==b.data&&a.lv==b.lv&&a.popup==b.popup;}
}
bool observe_stack(Memory memory,Address bias,const Owner&o,StackFacts&out)noexcept{
    Inspector p(memory,bias);Address value{};std::uint8_t aux{};StackFacts f{};
    if(!p.word(o.manager+0xc8,value)||value||!p.word(o.manager+0xd8,value)||value||!p.read(o.manager+0xe0,&aux,1)||aux)return false;
    for(Address list:{o.manager+0x40,o.manager+0x68})if(!p.word(list,value)||value!=bias+0xb8f4e8||!p.word(list+8,value)||value!=bias+0xc22908||!p.word(list+16,value)||value!=bias+0xc22960)return false;
    Address priority=o.manager+0x50,normal=o.manager+0x78;
    if(!p.word(priority+8,f.priority_first)||!p.word(priority+16,f.priority_last)||!p.word(normal+8,f.normal_first)||!p.word(normal+16,f.normal_last))return false;
    f.priority_empty=f.priority_first==priority&&f.priority_last==priority;
    Address node=f.normal_first,previous=normal;
    while(node!=normal){
        if(f.normal_count==8||node<4096||(node&7))return false;Address fields[4]{},manager{};
        if(!p.read(node,fields,sizeof fields)||fields[2]!=previous||fields[3]<4096||(fields[3]&7)||fields[3]>UINTPTR_MAX-0x2000||fields[3]+0x88!=node||!p.word(fields[3]+0xb0,manager)||manager!=o.manager)return false;
        const auto k=f.normal_count++;f.nodes[k]=node;f.dialogs[k]=fields[3];f.node_vtables[k]=fields[0];previous=node;node=fields[1];
    }
    Address again_first{},again_last{};
    if(previous!=f.normal_last||!p.word(normal+8,again_first)||again_first!=f.normal_first||!p.word(normal+16,again_last)||again_last!=f.normal_last)return false;
    f.bounded_complete=1;f.lv_at_tail=f.normal_count&&f.dialogs[f.normal_count-1]==o.lv;out=f;return true;
}
bool Module::configure(Memory memory,ImageGate gate,int(*trylock)(void*),int(*unlock)(void*))noexcept{
    if(configured_)return false;configured_=true;memory_=memory;image_=gate;
    if(!gate.enabled)return true;
    if(!gate.whole_user||!gate.mapped_ro||!gate.original_pthread||!memory.read||!trylock||!unlock||
       !resolve_static_candidates(memory,gate.bias,candidates_)){observation_.phase=static_cast<unsigned>(Phase::Hold);return false;}
    // All 19 additional ports are actual exact User input, not addresses from
    // another camera/repository. Full User RO verification is required above.
    for(const auto&e:entry_ports01::Entries){unsigned char bytes[16]{};if(!memory.read(memory.context,gate.bias+e.captured_va,bytes,16)||std::memcmp(bytes,e.first16,16)){observation_.phase=static_cast<unsigned>(Phase::Hold);return false;}}
#define F1_PORT(field,type,va) button_candidates_.field=reinterpret_cast<entry_ports01::type>(gate.bias+va)
    F1_PORT(text_button_ctor,TextButtonCtor,0x545cf0);F1_PORT(own_popup_ctor,PopupCtor,0x4fad38);
    F1_PORT(control_observer_ctor,ControlObserverCtor,0x4c4588);F1_PORT(queue_observer_ctor,QueueObserverCtor,0x70fe3c);
    F1_PORT(event_ctor,EventCtor,0x70f12c);F1_PORT(subscribe,Subscribe,0x70fed8);F1_PORT(unsubscribe,Subscribe,0x70ff08);F1_PORT(notify,EventNotify,0x70f2f8);
    F1_PORT(control_bind,ControlBind,0x4ac660);F1_PORT(control_attach,ControlAttach,0x4ab898);F1_PORT(control_detach,ControlDetach,0x70c9bc);
    F1_PORT(set_menu,SetMenu,0x4fb364);F1_PORT(show,Method,0x4e12c8);F1_PORT(close,Method,0x4e1320);F1_PORT(current_thread,CurrentThread,0x710b0c);
    F1_PORT(submenu_ctor,SubMenuCtor,0x4e5744);F1_PORT(item_ctor,EventItemCtor,0x4e9d30);F1_PORT(append_item,AppendItem,0x4e58b8);F1_PORT(set_flag41,SetFlag41,0x4af694);
#undef F1_PORT
    // Reuse the exact frozen bounded native queue listener inspector, with its
    // own global recursive mutex. Its disabled configuration creates no event,
    // control observer, counter subscription, or camera operation.
    iq4::f4::bootstrap::Native n{};n.try_lock=trylock;n.unlock=unlock;
    if(!triple_inspector_.configure({memory.context,memory.read},n,{false,true,true,true,gate.bias})){observation_.phase=static_cast<unsigned>(Phase::Hold);return false;}
    observation_.phase=static_cast<unsigned>(Phase::Waiting);return true;
}
Address Module::current(void*p)noexcept{
    auto&self=*static_cast<Module*>(p);if(!self.configured_||!self.image_.enabled||!self.candidates_.original_current)return 0;
    ++self.observation_.native_original_calls;
    try{return reinterpret_cast<Address>(self.candidates_.original_current());}catch(...){return 0;}
}
Triple Module::triple(void*p,Address queue,Address event,const Observer*observer)noexcept{
    auto&self=*static_cast<Module*>(p);
    if(current(p)!=queue||queue!=self.owner_.queue)return Triple::Unknown;
    const auto result=self.triple_inspector_.inspect(queue,event,reinterpret_cast<const iq4::f4::ui_counter::Observer*>(observer));
    switch(result){case iq4::f4::ui_counter::Triple::Present:return Triple::Present;case iq4::f4::ui_counter::Triple::Absent:return Triple::Absent;default:return Triple::Unknown;}
}
Native Module::selector_ports()noexcept{
    return {candidates_.event_ctor,candidates_.observer_ctor,candidates_.subscribe,candidates_.unsubscribe,candidates_.submenu_ctor,candidates_.item_ctor,
      candidates_.append,candidates_.set_menu,candidates_.show,candidates_.close,candidates_.invalidate,this,current,triple};
}
bool Module::repaint(void*p,Address lv)noexcept{
    auto&self=*static_cast<Module*>(p);Inspector inspect(self.memory_,self.image_.bias);std::uint8_t pending_close{};
    if(!self.owner_.queue||lv!=self.owner_.lv||current(p)!=self.owner_.queue||!inspect.current(self.owner_,false)||
       !inspect.read(lv+0xa8,&pending_close,1)||pending_close||!self.candidates_.invalidate)return false;
    try{self.candidates_.invalidate(reinterpret_cast<void*>(lv),false);++self.observation_.native_mutating_calls;}
    catch(...){self.observation_.phase=static_cast<unsigned>(Phase::Hold);return false;}
    // This confirms only the stock request returned/current owner remains.
    // It never synthesizes a fresh-image or coverage receipt.
    return inspect.current(self.owner_,false);
}
native_overlay::Native Module::overlay_ports()noexcept{
    return {reinterpret_cast<native_overlay::FillWrapper>(image_.bias+0x46f370),this,current,repaint};
}
void Module::after_unlock(const BoundaryInput&input)noexcept{
    if(!configured_||!image_.enabled||input.original_result||input.caller_pc!=image_.bias+0x6be8ac||
       observation_.phase==static_cast<unsigned>(Phase::Stopped)||observation_.phase==static_cast<unsigned>(Phase::Hold))return;
    if(inside_.test_and_set(std::memory_order_acquire))return;
    Inspector inspect(memory_,image_.bias);Boundary boundary{};
    if(!inspect.boundary(input,boundary)){++observation_.rejected_boundaries;inside_.clear(std::memory_order_release);return;}
    if(observation_.qualified_boundaries>=64||observation_.dispatch_epoch==UINT64_MAX){stop_observing();inside_.clear(std::memory_order_release);return;}
    if(owner_.queue&&!same(owner_,boundary.owner)){observation_.phase=static_cast<unsigned>(Phase::Hold);inside_.clear(std::memory_order_release);return;}
    // Startup/Home notifications must not exhaust the one-session LV probe.
    // This is a bounded metadata check, not a native getter or a supplied ready
    // flag. Wait until the original LV is actually the current sole dialog.
    StackFacts stack{},second_stack{};
    if(!observe_stack(memory_,image_.bias,boundary.owner,stack)||!observe_stack(memory_,image_.bias,boundary.owner,second_stack)||std::memcmp(&stack,&second_stack,sizeof stack)||!stack.priority_empty||!stack.lv_at_tail){++observation_.rejected_boundaries;inside_.clear(std::memory_order_release);return;}
    // Genuine original TLS getter is called only at the exact qualified
    // dispatch boundary, after full User/mapped-code/pthread verification.
    if(current(this)!=boundary.owner.queue){observation_.phase=static_cast<unsigned>(Phase::Hold);inside_.clear(std::memory_order_release);return;}
    LayoutSnapshot layout{};std::int32_t cached_pan[2]{};
    // +110 is the pan object, not a Point. +118 is its cached point;
    // never invoke the animation-aware original getter to obtain it.
    if(!inspect.layout_candidates(boundary.owner,layout)||!inspect.read(boundary.owner.lv+0x118,cached_pan,sizeof cached_pan)){++observation_.rejected_boundaries;inside_.clear(std::memory_order_release);return;}
    owner_=boundary.owner;++observation_.sequence;std::atomic_thread_fence(std::memory_order_release);
    ++observation_.dispatch_epoch;++observation_.qualified_boundaries;
    observation_.queue=owner_.queue;observation_.manager=owner_.manager;observation_.data=owner_.data;observation_.lv=owner_.lv;observation_.popup=owner_.popup;
    observation_.popped_observer=boundary.popped_observer;observation_.caller_pc=input.caller_pc;observation_.frame_pointer=input.frame_pointer;
    observation_.thread_pointer=input.thread_pointer;observation_.mutex=input.mutex;observation_.local_bounds=layout.local_control_bounds;
    observation_.pan_x=cached_pan[0];observation_.pan_y=cached_pan[1];observation_.quarterturn=layout.quarterturn;observation_.scale=layout.scale;
    observation_.countdown=layout.countdown;observation_.visible=layout.visible;observation_.running=layout.live_view_running;
    observation_.original_stack=stack;
    observation_.phase=static_cast<unsigned>(inspect.current(owner_,false)?Phase::OwnerObserved:Phase::LVNotCurrent);
    std::atomic_thread_fence(std::memory_order_release);++observation_.sequence;inside_.clear(std::memory_order_release);
}
bool Module::snapshot(Observation&out)const noexcept{
    // Same UI-thread copy or external quiescent copied-memory observation only;
    // this method is not a cross-thread synchronization/attestation interface.
    if(observation_.sequence&1)return false;out=observation_;return !(out.sequence&1);
}
void Module::stop_observing()noexcept{observation_.phase=static_cast<unsigned>(Phase::Stopped);image_.enabled=false;}
}
