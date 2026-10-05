#include "bootstrap.hpp"
#include <cstring>
#include <cerrno>
namespace iq4::f4::bootstrap {
namespace {
constexpr char control_name[] = "IQ4 F4 one-shot UI counter control";
constexpr unsigned max_frames=24, max_nodes=4096;
constexpr Address max_stack_span=1024*1024, max_frame_step=65536;
bool pointer(Address p) noexcept { return p>=4096 && p<=UINTPTR_MAX-4096 && (p&7)==0; }
bool same(const Owner& a,const Owner& b) noexcept {
    return a.queue==b.queue && a.manager==b.manager && a.ui_data==b.ui_data && a.lv==b.lv && a.access==b.access && a.engine==b.engine && a.frame_event==b.frame_event;
}
}
Bootstrap* Bootstrap::active_{};
Bootstrap::Bootstrap() noexcept : table_{0,nullptr,destroy,destroy,notify} {}
bool Bootstrap::read(Address p,void* out,std::size_t n) const noexcept {
    return memory_.read && p>=4096 && n>0 && n<=0x1000 && p<=UINTPTR_MAX-n && memory_.read(memory_.context,p,out,n);
}
bool Bootstrap::word(Address p,Address& out) const noexcept { return read(p,&out,8); }
bool Bootstrap::bindings_match() const noexcept {
#ifdef IQ4_F4_SYNTHETIC_HOST
    return true;
#else
    const auto b=gate_.load_bias;
    return reinterpret_cast<Address>(native_.construct)==b+0x70fe3c && reinterpret_cast<Address>(native_.subscribe)==b+0x70fed8 &&
      reinterpret_cast<Address>(native_.unsubscribe)==b+0x70ff08 && reinterpret_cast<Address>(native_.current)==b+0x710b0c &&
      reinterpret_cast<Address>(native_.event_construct)==b+0x70f12c && reinterpret_cast<Address>(native_.event_notify)==b+0x70f2f8;
#endif
}
bool Bootstrap::configure(Memory m,Native n,ImageGate g) noexcept {
    if(configured_) return false;
    configured_=true;memory_=m;native_=n;gate_=g;
    if(!g.enabled) return true;
    if(!g.whole_user_verified || !g.mapped_nonwritable_segments_verified || !g.original_pthread_verified || g.load_bias>UINTPTR_MAX-0x3ead000 ||
       !m.read || !n.construct || !n.subscribe || !n.unsubscribe || !n.current || !n.event_construct || !n.event_notify || !n.try_lock || !n.unlock || !bindings_match() || (active_ && active_!=this)) {
        phase_.store(Phase::Hold);return false;
    }
    active_=this;phase_.store(Phase::Waiting);return true;
}
bool Bootstrap::owner_chain(Address q,Owner& out) const noexcept {
    Address vt{},manager{},data{},lv{},access{},engine{},p{},check{};
    if(!pointer(q) || !word(q,vt) || vt!=gate_.load_bias+0xb91f48 ||
       !word(q+0x1c8,manager) || !pointer(manager) || !word(manager,vt) || vt!=gate_.load_bias+0xb8f358 ||
       !word(manager+8,check) || check!=q || !word(q+0x9b8,data) || !pointer(data) || !word(manager+0x790,check) || check!=data ||
       !word(q+0x8c0,lv) || !pointer(lv) || !word(lv,vt) || vt!=gate_.load_bias+0xb9a9d8 ||
       !word(data+0x118,access) || !pointer(access) || !word(lv+0x108,check) || check!=access ||
       !word(access,vt) || vt!=gate_.load_bias+0xc07da8 || !word(access+8,engine) || !pointer(engine) ||
       engine>UINTPTR_MAX-0x700 || !word(engine+0x640,vt) || vt!=gate_.load_bias+0xc237a0 ||
       !word(engine+0x640+0x98,p) || !pointer(p)) return false;
    out={q,manager,data,lv,access,engine,engine+0x640};return true;
}
bool Bootstrap::boundary(Address fp,Address tp,Address mutex,Boundary& out) const noexcept {
    Address q{}; Owner first{},second{};
    if(!pointer(tp) || !word(tp+0x10,q) || !owner_chain(q,first) || mutex!=q+0xf8 || !pointer(fp)) return false;
    Address begin=fp;
    for(unsigned i=0;i<max_frames;++i) {
        Address pair[2]{};
        if(!read(fp,pair,16) || !pointer(pair[0]) || pair[0]<=fp || pair[0]-fp>max_frame_step || pair[0]-begin>max_stack_span) return false;
        if(pair[1]==gate_.load_bias+0x71396c) {
            const auto pop=pair[0]; Address pop_pair[2]{},dispatch_pair[2]{},pop_q{},dispatch_q{},listener{},observer{};
            if(!read(pop,pop_pair,16) || pop_pair[1]!=gate_.load_bias+0x70ff9c || !pointer(pop_pair[0]) || pop_pair[0]<=pop || pop_pair[0]-pop>max_frame_step ||
               !read(pop_pair[0],dispatch_pair,16) || dispatch_pair[1]!=gate_.load_bias+0x4ef984 ||
               !word(pop+0x28,pop_q) || pop_q!=q || !word(pop_pair[0]+0x18,dispatch_q) || dispatch_q!=q ||
               !word(pop+0x68,listener) || !pointer(listener) || !word(listener+0x40,observer) || !pointer(observer) ||
               !owner_chain(q,second) || !same(first,second)) return false;
            out={second,listener,observer,pop,pop_pair[0]}; return true;
        }
        fp=pair[0];
    }
    return false;
}
bool Bootstrap::own_thread() const noexcept { try { return native_.current && reinterpret_cast<Address>(native_.current())==owner_.queue; } catch(...) { return false; } }
bool Bootstrap::valid_owner() const noexcept { Owner now{}; return owner_chain(owner_.queue,now) && same(owner_,now) && own_thread(); }
Triple Bootstrap::inspect(Address q,Address event,const Observer* observer) noexcept {
    // Exact native register/unregister protects queue+0x68 using the same
    // recursive global mutex at User+f553c0; the queue mutex is insufficient.
    if(!pointer(q) || !pointer(event) || !observer || !gate_.original_pthread_verified) return Triple::Unknown;
    std::uint32_t kind{};Address active_threads{};
    if(!read(gate_.load_bias+0xf553c0+0x10,&kind,4) || kind!=1 || !word(gate_.load_bias+0xf553a8,active_threads) || !active_threads) return Triple::Unknown;
    void* lock=reinterpret_cast<void*>(gate_.load_bias+0xf553c0);
    int locked=-1; try { locked=native_.try_lock(lock); } catch(...) { return Triple::Unknown; }
    if(locked!=0) return Triple::Unknown;
    Triple result=Triple::Unknown; Address head=q+0x78,next{},prev{},prior=head; unsigned found=0;
    if(word(head+8,next) && word(head+16,prev) && pointer(next) && pointer(prev)) {
        bool ok=true; unsigned n=0;
        while(next!=head && n++<max_nodes) {
            Address fields[4]{},listener{},ev{},queue{},obs{},back{};
            if(!read(next,fields,32) || fields[0]!=gate_.load_bias+0xc23cb8 || fields[2]!=prior || !pointer(fields[1]) ||
               !pointer(fields[3]) || fields[3]>UINTPTR_MAX-0x88 || next!=fields[3]+0x68 || !word(fields[1]+16,back) || back!=next) { ok=false;break; }
            listener=fields[3];
            if(!word(listener+8,ev) || !word(listener+0x30,queue) || !word(listener+0x40,obs) || queue!=q) {ok=false;break;}
            if(ev==event && obs==reinterpret_cast<Address>(observer)) ++found;
            if(found>1) {ok=false;break;}
            prior=next;next=fields[1];
        }
        if(ok && next==head && prior==prev) result=found==1?Triple::Present:Triple::Absent;
    }
    try { if(native_.unlock(lock)!=0) result=Triple::Unknown; } catch(...) { result=Triple::Unknown; }
    return result;
}
Triple Bootstrap::inspect_bridge(void* q,void* e,const Observer* o) noexcept { return active_?active_->inspect(reinterpret_cast<Address>(q),reinterpret_cast<Address>(e),o):Triple::Unknown; }
std::uint64_t Bootstrap::epoch_bridge(void* q) noexcept { return active_ && reinterpret_cast<Address>(q)==active_->owner_.queue?active_->epoch_:UINT64_MAX; }
bool Bootstrap::empty_control_event() noexcept {
    void* lock=control_event_+0x28;int held=-1; try { held=native_.try_lock(lock); }catch(...) {return false;}
    if(held!=0) return false;
    Address head=reinterpret_cast<Address>(control_event_)+0x98,a{},b{};
    bool empty=word(head+8,a) && word(head+16,b) && a==head && b==head;
    try {if(native_.unlock(lock)!=0)empty=false;}catch(...) {empty=false;}return empty;
}
void Bootstrap::begin(const Boundary& b) noexcept {
    owner_=b.owner;
    if(!own_thread()) {phase_.store(Phase::Hold);return;}
    module_retained_=true;phase_.store(Phase::RegisteringControl);
    try {
        native_.event_construct(control_event_,control_name); event_constructed_=true;
        Address vt{};
        if(!word(reinterpret_cast<Address>(control_event_),vt) || vt!=gate_.load_bias+0xc237a0 || !empty_control_event()) {phase_.store(Phase::Hold);return;}
        native_.construct(&control_,control_name,reinterpret_cast<void*>(owner_.queue));
        if(reinterpret_cast<Address>(control_.queue)!=owner_.queue || control_.persistent_name!=control_name) {phase_.store(Phase::Hold);return;}
        table_.base_rtti=reinterpret_cast<void*>(gate_.load_bias+0xc23ab0); control_.extension=this;control_.address_point=&table_.destroy;
        if(inspect(owner_.queue,reinterpret_cast<Address>(control_event_),&control_)!=Triple::Absent) {phase_.store(Phase::Hold);return;}
        native_.subscribe(&control_,control_event_);
        if(inspect(owner_.queue,reinterpret_cast<Address>(control_event_),&control_)!=Triple::Present) {phase_.store(Phase::Hold);return;}
        phase_.store(Phase::ControlQueued);native_.event_notify(control_event_);
    } catch(...) {phase_.store(Phase::Hold);}
}
void Bootstrap::control_callback(void* event) noexcept {
    in_callback_.fetch_add(1);++callbacks_;
    const auto prior=phase_.load();
    if(event!=control_event_ || !valid_owner() || (prior!=Phase::ControlQueued && prior!=Phase::CounterAttached)) {phase_.store(Phase::Hold);in_callback_.fetch_sub(1);report_on_ui();return;}
    try {
        if(prior==Phase::ControlQueued) {
            Operations ops{native_.construct,native_.subscribe,native_.unsubscribe,native_.current,inspect_bridge,epoch_bridge};
            Gate gate{exact_user_sha256,gate_.load_bias,reinterpret_cast<void*>(owner_.queue),reinterpret_cast<void*>(owner_.frame_event),reinterpret_cast<void*>(gate_.load_bias+0xc23ab0),true,true,true,true,true,true};
            if(counter_.attach(ops,gate)!=Result::Ok) {phase_.store(Phase::Hold);}
            else {phase_.store(Phase::CounterAttached);native_.event_notify(control_event_);}
        } else {
            phase_.store(Phase::Detaching);detach_epoch_=epoch_;
            if(counter_.detach_on_ui_dispatch()!=Result::Ok) phase_.store(Phase::Hold);
            else {
                native_.unsubscribe(&control_,control_event_);
                if(inspect(owner_.queue,reinterpret_cast<Address>(control_event_),&control_)!=Triple::Absent || !empty_control_event()) phase_.store(Phase::Hold);
            }
        }
    } catch(...) {phase_.store(Phase::Hold);}
    in_callback_.fetch_sub(1);
    report_on_ui();
}
void Bootstrap::later(const Boundary& b) noexcept {
    if(phase_.load()!=Phase::Detaching || epoch_<=detach_epoch_ || in_callback_.load()!=0 || !same(owner_,b.owner) ||
       b.popped_observer==reinterpret_cast<Address>(&control_) || b.popped_observer==reinterpret_cast<Address>(counter_.observer_address()) ||
       inspect(owner_.queue,reinterpret_cast<Address>(control_event_),&control_)!=Triple::Absent || !empty_control_event() || !counter_.confirm_later_ui_boundary()) return;
    // Original OsEvent destructor does not remove its two global registry nodes.
    // Keep the complete native event + persistent name + module until stock exit.
    phase_.store(Phase::ObserversDetachedEventRetained);
}
void Bootstrap::after_unlock(Address pc,Address fp,Address tp,Address mutex,int rc) noexcept {
    const auto s=phase_.load();
    if(!configured_ || !gate_.enabled || rc!=0 || pc!=gate_.load_bias+0x6be8ac || s==Phase::Disabled || s==Phase::Hold || s==Phase::ObserversDetachedEventRetained) return;
    if(filtering_.test_and_set(std::memory_order_acquire)) return;
    Boundary b{};
    if(!boundary(fp,tp,mutex,b)) {++skipped_;filtering_.clear(std::memory_order_release);return;}
    if(qualified_>=4096 || epoch_==UINT64_MAX || (owner_.queue && !same(owner_,b.owner))) {phase_.store(Phase::Hold);report_on_ui();filtering_.clear(std::memory_order_release);return;}
    ++qualified_;++epoch_;
    if(s==Phase::Waiting) begin(b);else later(b);
    report_on_ui();
    filtering_.clear(std::memory_order_release);
}
void Bootstrap::notify(Observer* o,void* event) noexcept {if(o && o->extension)static_cast<Bootstrap*>(o->extension)->control_callback(event);}
void Bootstrap::destroy(Observer* o) noexcept {if(o && o->extension)static_cast<Bootstrap*>(o->extension)->phase_.store(Phase::Hold);}
Status Bootstrap::status() const noexcept {return {phase_.load(),epoch_,qualified_,callbacks_,skipped_,counter_.snapshot().notifications,event_constructed_,module_retained_};}
void Bootstrap::report_on_ui() noexcept { if(report_&&own_thread())report_(report_context_,status()); }
int forward_once(Mutex original,void* mutex,int& caller_errno,void* context,Diagnostic diagnostic) noexcept {
    // Caller guarantees an already-resolved real provider. No failure is forged.
    const int incoming=caller_errno;errno=incoming;
    const int rc=original(mutex);const int saved=errno;
    if(diagnostic)diagnostic(context,rc);
    errno=saved;caller_errno=saved;return rc;
}
}
