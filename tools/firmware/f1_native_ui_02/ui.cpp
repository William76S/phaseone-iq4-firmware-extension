#include "ui.hpp"
#include <cmath>
#include <cstring>

namespace iq4::f1::native_ui02 {
namespace {
bool ptr(Address p)noexcept{return p>=4096&&p<=UINTPTR_MAX-0x2000&&(p&7)==0;}
bool same(const Owner&a,const Owner&b)noexcept{return a.queue==b.queue&&a.manager==b.manager&&a.data==b.data&&a.lv==b.lv&&a.popup==b.popup;}
constexpr std::array<MaskMode,5>Modes={MaskMode::Off,MaskMode::XPan65_24,MaskMode::Ratio16_9,MaskMode::Ratio3_2,MaskMode::Ratio1_1};
constexpr const char* Labels[5]={"Off / native","XPan 65:24","16:9","3:2","1:1"};
constexpr const char* EventNames[5]={"IQ4 F1 mask Off","IQ4 F1 mask XPan","IQ4 F1 mask 16:9","IQ4 F1 mask 3:2","IQ4 F1 mask 1:1"};
constexpr char ObserverName[]="IQ4 F1 five choice selector";
bool contains(native_overlay::PixelRect a,native_overlay::PixelRect b)noexcept{
    return a.width>0&&a.height>0&&b.width>0&&b.height>0&&a.x<=b.x&&a.y<=b.y&&std::int64_t(a.x)+a.width>=std::int64_t(b.x)+b.width&&std::int64_t(a.y)+a.height>=std::int64_t(b.y)+b.height;
}
}
bool Inspector::read(Address p,void*out,std::size_t n)const noexcept{return memory_.read&&p>=4096&&n&&n<=0x1000&&p<=UINTPTR_MAX-n&&memory_.read(memory_.context,p,out,n);}
bool Inspector::word(Address p,Address&v)const noexcept{return read(p,&v,8);}
bool Inspector::owner_chain(Address q,Owner&out)const noexcept{
    Address v{},m{},d{},l{},check{};
    if(bias_>UINTPTR_MAX-0xc22960||!ptr(q)||!word(q,v)||v!=bias_+0xb91f48||!word(q+0x1c8,m)||!ptr(m)||!word(m,v)||v!=bias_+0xb8f358||
       !word(m+8,check)||check!=q||!word(q+0x9b8,d)||!ptr(d)||!word(m+0x790,check)||check!=d||!word(q+0x8c0,l)||!ptr(l)||
       !word(l,v)||v!=bias_+0xb9a9d8||!word(l+0xb0,check)||check!=m||!word(l+0x588,v)||v!=bias_+0xb931b0||
       !word(l+0x588+0xb0,check)||check!=m||!word(l+0x588+0x128,v)||v!=bias_+0xb90020)return false;
    out={q,m,d,l,l+0x588};return true;
}
bool Inspector::boundary(const BoundaryInput&in,Boundary&out)const noexcept{
    Address q{};Owner a{},b{};
    if(in.original_result||in.caller_pc!=bias_+0x6be8ac||!ptr(in.thread_pointer)||!word(in.thread_pointer+0x10,q)||!owner_chain(q,a)||in.mutex!=q+0xf8||!ptr(in.frame_pointer))return false;
    Address fp=in.frame_pointer,begin=fp;
    for(unsigned i=0;i<24;++i){
        Address pair[2]{};if(!read(fp,pair,16)||!ptr(pair[0])||pair[0]<=fp||pair[0]-fp>65536||pair[0]-begin>1048576)return false;
        if(pair[1]==bias_+0x71396c){
            Address pop=pair[0],p[2]{},dispatch[2]{},popq{},dispatchq{},listener{},observer{};
            if(!read(pop,p,16)||p[1]!=bias_+0x70ff9c||!ptr(p[0])||p[0]<=pop||p[0]-pop>65536||p[0]-begin>1048576||
               !read(p[0],dispatch,16)||dispatch[1]!=bias_+0x4ef984||!word(pop+0x28,popq)||popq!=q||!word(p[0]+0x18,dispatchq)||dispatchq!=q||
               !word(pop+0x68,listener)||!ptr(listener)||!word(listener+0x40,observer)||!ptr(observer)||!owner_chain(q,b)||!same(a,b))return false;
            out={b,observer,pop,p[0]};return true;
        }fp=pair[0];
    }return false;
}
bool Inspector::current(const Owner&o,bool popup_open)const noexcept{
    Owner actual{};if(!owner_chain(o.queue,actual)||!same(actual,o))return false;
    Address m=o.manager,v{};std::uint8_t aux{};
    if(!word(m+0xc8,v)||v||!word(m+0xd8,v)||v||!read(m+0xe0,&aux,1)||aux)return false;
    for(Address list:{m+0x40,m+0x68})if(!word(list,v)||v!=bias_+0xb8f4e8||!word(list+8,v)||v!=bias_+0xc22908||!word(list+16,v)||v!=bias_+0xc22960)return false;
    Address first{},last{},priority=m+0x50,normal=m+0x78;
    if(!word(priority+8,first)||first!=priority||!word(priority+16,last)||last!=priority||!word(normal+8,first)||!word(normal+16,last))return false;
    // Current() reads the list's PREVIOUS/tail pointer: 4e4e2c -> 70bcc0
    // -> 460394 (+10). Native Push appends before head; LV precedes popup.
    const Address nodes[2]={o.lv+0x88,o.popup+0x88};
    const unsigned count=popup_open?2:1;Address previous=normal;
    for(unsigned i=0;i<count;++i){
        Address next{},prev{},dialog{},owner{},vt{};
        if(first!=nodes[i]||!word(first,vt)||vt!=bias_+(popup_open&&i==1?0xb933e0:0xb9abf8)||!word(first+8,next)||!word(first+16,prev)||prev!=previous||
           !word(first+24,dialog)||dialog+0x88!=first||!word(dialog+0xb0,owner)||owner!=m)return false;
        previous=first;first=next;
    }return first==normal&&previous==last;
}
bool Inspector::popup_menu(const Owner&o,Address root)const noexcept{
    const Address n=o.popup+0x128;Address v{};std::uint32_t depth{};
    // +300 is constructor's initial root, not changed by SetMenu; this LV
    // constructs the selector with null. Current root is +18 / stack[0].
    if(!word(n,v)||v!=bias_+0xb90020||!word(n+0x18,v)||v!=root||!word(n+0x300,v)||v||!read(n+0x348,&depth,4)||depth||!word(n+0x308,v)||v!=root)return false;
    for(unsigned i=1;i<8;++i)if(!word(n+0x308+8*i,v)||v)return false;
    return true;
}
bool Inspector::idle_popup(const Owner&o)const noexcept{
    Address v{};return current(o,false)&&popup_menu(o,0)&&word(o.popup+0x128+0x350,v)&&!v;
}
bool Inspector::popup_title(const Owner&o,std::uint32_t&out)const noexcept{
    Address header{};return word(o.popup+0xe0,header)&&ptr(header)&&read(header+0x88,&out,4);
}
bool Inspector::layout_candidates(const Owner&o,LayoutSnapshot&out)const noexcept{
    Owner actual{};if(!owner_chain(o.queue,actual)||!same(actual,o))return false;
    std::uint8_t shown{},running{};
    if(!read(o.lv+0x28,&out.local_control_bounds,24)||out.local_control_bounds.address_point!=bias_+0xb73b98||
       !read(o.lv+0x110,out.pan.data(),8)||!read(o.lv+0x190,&out.scale,4)||!std::isfinite(out.scale)||out.scale<=0||
       !read(o.lv+0x1b0,&out.quarterturn,4)||(out.quarterturn!=0&&out.quarterturn!=90&&out.quarterturn!=180&&out.quarterturn!=270)||
       !read(o.lv+0x1b8,&out.countdown,4)||!read(o.lv+0x6f,&shown,1)||shown>1||!read(o.lv+0x104,&running,1)||running>1)return false;
    out.visible=shown;out.live_view_running=running;return true;
}
Selector::Selector()noexcept:table_{0,nullptr,destroy,destroy,notify}{for(unsigned i=0;i<5;++i)std::strncpy(labels_[i].data(),Labels[i],32);}
bool OverlaySelectionBridge::select(void*context,MaskMode mode)noexcept{
    auto&bridge=*static_cast<OverlaySelectionBridge*>(context);display::ViewMapping mapping{};std::uint64_t epoch{};
    if(!bridge.lv_||!bridge.geometry_.actual_snapshot||!bridge.geometry_.actual_snapshot(bridge.geometry_.context,bridge.lv_,mapping,epoch)||!epoch||!mapping.fullSourceMappingKnown)return false;
    const auto result=bridge.overlay_.select_on_ui(mode,mapping,epoch);
    return result==native_overlay::Result::Ok||result==native_overlay::Result::Pending;
}
bool Selector::configure(Memory m,Native n,SelectionPort s,const char*sha,Address bias,const BoundaryInput&in)noexcept{
#ifndef IQ4_F1_UI02_SYNTHETIC_HOST
    (void)m;(void)n;(void)s;(void)sha;(void)bias;(void)in;return false;
#else
    if(configured_||!sha||std::strcmp(sha,UserSHA)||!m.read||!n.event_ctor||!n.observer_ctor||!n.subscribe||!n.unsubscribe||!n.submenu_ctor||!n.item_ctor||!n.append||
       !n.set_menu||!n.show||!n.close||!n.invalidate||!n.current_thread||!n.inspect_triple||!s.select)return false;
    Boundary b{};Inspector inspector(m,bias);if(!inspector.boundary(in,b)||!inspector.idle_popup(b.owner)||!inspector.popup_title(b.owner,original_popup_title_)||n.current_thread(n.context)!=b.owner.queue)return false;
    memory_=m;native_=n;selection_=s;bias_=bias;owner_=b.owner;configured_=true;status_.phase=Phase::Bound;return true;
#endif
}
bool Selector::on_ui()const noexcept{return configured_&&native_.current_thread&&native_.current_thread(native_.context)==owner_.queue;}
bool Selector::owner(bool popup)const noexcept{return on_ui()&&Inspector(memory_,bias_).current(owner_,popup);}
bool Selector::triples(Triple expected)const noexcept{
    for(unsigned i=0;i<registered_;++i)if(native_.inspect_triple(native_.context,owner_.queue,event_for_test(i),&observer_)!=expected)return false;
    return true;
}
bool Selector::check_items()const noexcept{
    Inspector p(memory_,bias_);Address v{};
    std::uint32_t menu_title{};
    if(!p.word(menu_for_test(),v)||v!=bias_+0xb8f9b8||!p.read(menu_for_test()+0x14,&menu_title,4)||menu_title!=original_popup_title_)return false;
    for(unsigned i=0;i<5;++i){
        Address a=reinterpret_cast<Address>(items_[i].data());std::uint32_t id{};
        if(!p.word(a,v)||v!=bias_+0xb90748||!p.word(a+0x18,v)||v!=event_for_test(i)||!p.word(a+0x20,v)||v||!p.word(a+0x30,v)||v!=reinterpret_cast<Address>(labels_[i].data())||
           !p.read(a+0x14,&id,4)||id!=UINT32_MAX)return false;
    }
    const Address menu=menu_for_test(),head=menu+0x28;Address first{},last{},prior=head;
    if(!p.word(menu+0x18,v)||v!=bias_+0xb8faa0||!p.word(menu+0x20,v)||v!=bias_+0xc22908||!p.word(head,v)||v!=bias_+0xc22960||!p.word(head+8,first)||!p.word(head+16,last))return false;
    std::array<bool,5>seen{};
    for(unsigned i=0;i<5;++i){
        Address next{},prev{},item{};if(!ptr(first)||first==head||!p.word(first,v)||v!=bias_+0xb8f958||!p.word(first+8,next)||!p.word(first+16,prev)||prev!=prior||!p.word(first+24,item))return false;
        unsigned k=0;for(;k<5;++k)if(item==reinterpret_cast<Address>(items_[k].data()))break;
        if(k==5||seen[k])return false;seen[k]=true;prior=first;first=next;
    }return first==head&&prior==last;
}
Result Selector::build_on_ui()noexcept{
    if(!configured_)return Result::Disabled;if(!on_ui())return Result::WrongThread;
    if(status_.phase!=Phase::Bound||!Inspector(memory_,bias_).idle_popup(owner_))return Result::Rejected;
    status_.phase=Phase::Building;
    try{
        native_.observer_ctor(&observer_,ObserverName,reinterpret_cast<void*>(owner_.queue));
        if(observer_.queue!=reinterpret_cast<void*>(owner_.queue)||observer_.name!=ObserverName){hold();return Result::Hold;}
        table_.rtti=reinterpret_cast<void*>(bias_+0xc23ab0);observer_.extension=this;observer_.address_point=&table_.destroy;
        // Preserve the observed existing popup header's resource value; no
        // invented title/resource ID and no header text replacement.
        native_.submenu_ctor(menu_.data(),original_popup_title_,nullptr,nullptr);
        for(unsigned i=0;i<5;++i){
            native_.event_ctor(events_[i].data(),EventNames[i]);
            native_.item_ctor(items_[i].data(),UINT32_MAX,events_[i].data(),nullptr);
            // The sole field update is in project-owned native item storage.
            const char*label=labels_[i].data();std::memcpy(items_[i].data()+0x30,&label,8);
            Inspector p(memory_,bias_);Address vt{};
            if(!p.word(event_for_test(i),vt)||vt!=bias_+0xc237a0||native_.inspect_triple(native_.context,owner_.queue,event_for_test(i),&observer_)!=Triple::Absent){hold();return Result::Hold;}
            ++registered_;native_.subscribe(&observer_,events_[i].data());
            if(!triples(Triple::Present)){hold();return Result::Hold;}
            native_.append(menu_.data(),items_[i].data());
        }
    }catch(...){hold();return Result::Hold;}
    if(!check_items()||!owner(false)){hold();return Result::Hold;}
    status_.phase=Phase::Ready;return Result::Ok;
}
Result Selector::open_on_ui()noexcept{
    if(!configured_)return Result::Disabled;if(!on_ui())return Result::WrongThread;
    if(status_.phase!=Phase::Ready||!Inspector(memory_,bias_).idle_popup(owner_)||!check_items()||!triples(Triple::Present))return Result::Rejected;
    try{
        // Record intent before a native call; any partial/unknown call retains.
        status_.phase=Phase::Open;status_.menu_restored=false;
        native_.set_menu(reinterpret_cast<void*>(owner_.popup),menu_.data());
        if(!Inspector(memory_,bias_).popup_menu(owner_,menu_for_test())||native_.inspect_triple(native_.context,owner_.queue,menu_for_test()+0x60,reinterpret_cast<const Observer*>(owner_.popup+0x128))!=Triple::Present){hold();return Result::Hold;}
        native_.show(reinterpret_cast<void*>(owner_.popup));
    }catch(...){hold();return Result::Hold;}
    std::uint32_t title{};if(!owner(true)||!Inspector(memory_,bias_).popup_title(owner_,title)||title!=original_popup_title_){hold();return Result::Hold;}return Result::Ok;
}
Result Selector::restore_popup_on_ui()noexcept{
    Inspector p(memory_,bias_);
    const bool opened=p.current(owner_,true);
    if(!opened&&!p.current(owner_,false)){hold();return Result::Hold;}
    status_.phase=Phase::RestoringMenu;
    try{
        if(opened)native_.close(reinterpret_cast<void*>(owner_.popup));
        if(!owner(false)){hold();return Result::Hold;}
        native_.set_menu(reinterpret_cast<void*>(owner_.popup),nullptr);
    }catch(...){hold();return Result::Hold;}
    std::uint32_t title{};
    if(!p.idle_popup(owner_)||!p.popup_title(owner_,title)||title!=original_popup_title_||native_.inspect_triple(native_.context,owner_.queue,menu_for_test()+0x60,reinterpret_cast<const Observer*>(owner_.popup+0x128))!=Triple::Absent){hold();return Result::Hold;}
    status_.menu_restored=true;return request_repaint_on_ui();
}
Result Selector::request_repaint_on_ui()noexcept{
    if(!owner(false)||generation_==UINT64_MAX){hold();return Result::Hold;}
    ++generation_;painting_complete_=false;status_.factory_repaint_confirmed=false;status_.phase=Phase::AwaitingPaint;
    try{native_.invalidate(reinterpret_cast<void*>(owner_.lv),false);++status_.repaint_requests;}catch(...){hold();return Result::Hold;}
    return Result::Pending;
}
void Selector::notification(void*event)noexcept{
    ++callback_depth_;
    if(status_.phase!=Phase::Open||!owner(true)||!triples(Triple::Present)){++status_.rejected;--callback_depth_;return;}
    unsigned i=0;for(;i<5;++i)if(reinterpret_cast<Address>(event)==event_for_test(i))break;
    if(i==5){++status_.rejected;--callback_depth_;return;}
    if(!selection_.select(selection_.context,Modes[i])){hold();--callback_depth_;return;}
    status_.selected=Modes[i];++status_.actions;cancelled_=false;(void)restore_popup_on_ui();--callback_depth_;
}
void Selector::notify(Observer*o,void*e)noexcept{if(o&&o->extension)static_cast<Selector*>(o->extension)->notification(e);}
void Selector::destroy(Observer*o)noexcept{if(o&&o->extension)static_cast<Selector*>(o->extension)->hold();}
Result Selector::cancel_on_ui()noexcept{
    if(!configured_)return Result::Disabled;if(!on_ui())return Result::WrongThread;
    if(status_.phase!=Phase::Open)return Result::Rejected;
    cancelled_=true;return restore_popup_on_ui(); // Native hardware Back may already have closed it.
}
Result Selector::observe_paint_on_ui(const PaintReceipt&r)noexcept{
    if(!configured_)return Result::Disabled;if(!on_ui())return Result::WrongThread;
    if(status_.phase!=Phase::AwaitingPaint||r.lv!=owner_.lv||!r.surface||r.request_generation!=generation_||!r.ui_paint_serial||r.ui_paint_serial<=last_paint_||!owner(false))return Result::Rejected;
    last_paint_=r.ui_paint_serial;
    if(!r.original_returned_normally||!r.display_lease_live){hold();return Result::Hold;}
    if(!r.native_image_blit_completed||!contains(r.actual_stock_coverage,r.image_viewport))return Result::Pending;
    painting_complete_=true;++status_.fresh_receipts;status_.factory_repaint_confirmed=status_.selected==MaskMode::Off;
    status_.phase=Phase::Ready;return Result::Ok;
}
Result Selector::detach_on_ui(std::uint64_t epoch)noexcept{
    if(!configured_)return Result::Disabled;if(!on_ui())return Result::WrongThread;
    if(status_.phase!=Phase::Ready||callback_depth_||epoch==0||!owner(false)||!status_.menu_restored||!painting_complete_||status_.selected!=MaskMode::Off||!status_.factory_repaint_confirmed)return Result::Rejected;
    detach_epoch_=epoch;status_.phase=Phase::Detaching;
    try{for(unsigned i=0;i<registered_;++i)native_.unsubscribe(&observer_,events_[i].data());}catch(...){hold();return Result::Hold;}
    if(!triples(Triple::Absent)){hold();return Result::Hold;}return Result::Pending;
}
Result Selector::confirm_later_boundary(const BoundaryInput&in,std::uint64_t epoch)noexcept{
    if(!configured_)return Result::Disabled;if(!on_ui())return Result::WrongThread;
    Boundary b{};Inspector p(memory_,bias_);
    if(status_.phase!=Phase::Detaching||epoch<=detach_epoch_||!p.boundary(in,b)||!same(owner_,b.owner)||b.popped_observer==reinterpret_cast<Address>(&observer_)||callback_depth_||!triples(Triple::Absent)||!p.idle_popup(owner_))return Result::Pending;
    status_.phase=Phase::DetachedRetained;return Result::Ok;
}
}
