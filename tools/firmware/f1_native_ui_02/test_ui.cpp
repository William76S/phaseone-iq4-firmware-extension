#include "ui.hpp"
#include "entry_bytes.hpp"
#include <cassert>
#include <cstdio>
#include <cstring>
#include <stdexcept>
#include <vector>
using namespace iq4;using namespace iq4::f1::native_ui02;
namespace {
struct Span{Address at;std::size_t size;};
struct Fixture {
    alignas(16)std::array<unsigned char,0xd50>q{};
    alignas(16)std::array<unsigned char,0x800>m{};
    alignas(16)std::array<unsigned char,0x2000>lv{};
    alignas(16)std::array<unsigned char,0x180>data{};
    alignas(16)std::array<unsigned char,0x40>tp{};
    alignas(16)std::array<unsigned char,0x400>frames{};
    alignas(16)std::array<unsigned char,0x80>listener{};
    alignas(16)std::array<unsigned char,0x20>old_observer{};
    alignas(16)std::array<unsigned char,0xb8>title_header{};
    std::array<std::array<unsigned char,32>,5>menu_nodes{};
    std::vector<Span>spans;std::array<Address,5>registered{};
    Selector selector;BoundaryInput input{};Address queue{},manager{},live{},popup{},thread{},menu{};
    unsigned reads{},native_calls{},appended{},sets{},shows{},closes{},invalidates{},selects{};std::uint64_t serial{};
    bool triple_unknown{},select_failure{},throw_show{},bad_close{},bad_item{},wrong_thread{},navigator_subscribed{},bad_navigator_detach{};MaskMode chosen{};
    static Fixture*active;
    template<class T>static Address a(T&t){return reinterpret_cast<Address>(t.data());}
    template<class T>void register_span(T&t){spans.push_back({a(t),t.size()});}
    static void put(Address p,Address v){std::memcpy(reinterpret_cast<void*>(p),&v,8);}
    template<class T>static void value(Address p,T v){std::memcpy(reinterpret_cast<void*>(p),&v,sizeof(v));}
    static Address get(Address p){Address v;std::memcpy(&v,reinterpret_cast<void*>(p),8);return v;}
    static bool read(void*c,Address p,void*out,std::size_t n)noexcept{
        auto&f=*static_cast<Fixture*>(c);++f.reads;
        for(const auto&s:f.spans)if(p>=s.at&&n<=s.size&&p-s.at<=s.size-n){std::memcpy(out,reinterpret_cast<void*>(p),n);return true;}
        return false;
    }
    static Address current(void*c)noexcept{auto&f=*static_cast<Fixture*>(c);return f.wrong_thread?0:f.queue;}
    static Triple inspect(void*c,Address q,Address e,const Observer*o)noexcept{
        auto&f=*static_cast<Fixture*>(c);if(f.triple_unknown||q!=f.queue)return Triple::Unknown;
        if(reinterpret_cast<Address>(o)==f.popup+0x128&&e==f.menu+0x60)return f.navigator_subscribed?Triple::Present:Triple::Absent;
        for(auto registered:f.registered)if(registered==e)return Triple::Present;return Triple::Absent;
    }
    static void event_ctor(void*p,const char*){auto&f=*active;++f.native_calls;f.spans.push_back({reinterpret_cast<Address>(p),0xb8});put(reinterpret_cast<Address>(p),0xc237a0);}
    static void observer_ctor(Observer*p,const char*n,void*q){++active->native_calls;p->queue=q;p->name=n;}
    static void subscribe(Observer*,void*e){auto&f=*active;++f.native_calls;for(auto&v:f.registered)if(!v){v=reinterpret_cast<Address>(e);return;}throw std::runtime_error("full");}
    static void unsubscribe(Observer*,void*e){auto&f=*active;++f.native_calls;for(auto&v:f.registered)if(v==reinterpret_cast<Address>(e))v=0;}
    static void submenu_ctor(void*p,std::uint32_t title,void*,void*){
        auto&f=*active;++f.native_calls;f.menu=reinterpret_cast<Address>(p);f.spans.push_back({f.menu,0x118});
        put(f.menu,0xb8f9b8);put(f.menu+0x18,0xb8faa0);put(f.menu+0x20,0xc22908);put(f.menu+0x28,0xc22960);put(f.menu+0x30,f.menu+0x28);put(f.menu+0x38,f.menu+0x28);
        value(f.menu+0x14,title);
    }
    static void item_ctor(void*p,std::uint32_t id,void*e,void*){
        auto&f=*active;++f.native_calls;Address at=reinterpret_cast<Address>(p);f.spans.push_back({at,0x38});
        put(at,f.bad_item?0:0xb90748);value(at+0x14,id);put(at+0x18,reinterpret_cast<Address>(e));put(at+0x20,0);
    }
    static void append(void*,void*p){
        auto&f=*active;++f.native_calls;assert(f.appended<5);auto&n=f.menu_nodes[f.appended++];f.register_span(n);Address at=a(n),head=f.menu+0x28,last=get(head+16);
        put(at,0xb8f958);put(at+8,head);put(at+16,last);put(at+24,reinterpret_cast<Address>(p));put(last+8,at);put(head+16,at);
    }
    static void set_menu(void*p,void*root){
        auto&f=*active;++f.native_calls;++f.sets;Address n=reinterpret_cast<Address>(p)+0x128;
        if(root)f.navigator_subscribed=true;else if(!f.bad_navigator_detach)f.navigator_subscribed=false;
        put(n+0x18,reinterpret_cast<Address>(root));put(n+0x308,reinterpret_cast<Address>(root));
        for(unsigned i=1;i<8;++i)put(n+0x308+8*i,0);value(n+0x348,std::uint32_t(0));put(n+0x350,0);
    }
    void stack(bool opened){
        const Address head=manager+0x78,l=live+0x88,p=popup+0x88;put(head+8,l);put(head+16,opened?p:l);
        put(l+8,opened?p:head);put(l+16,head);put(l+24,live);
        put(p+8,opened?head:0);put(p+16,opened?l:0);put(p+24,popup);
    }
    static void show(void*){auto&f=*active;++f.native_calls;++f.shows;if(f.throw_show)throw std::runtime_error("native unknown");f.stack(true);}
    static void close(void*){auto&f=*active;++f.native_calls;++f.closes;if(!f.bad_close)f.stack(false);}
    static void invalidate(void*,bool){++active->native_calls;++active->invalidates;}
    static bool select(void*c,MaskMode mode)noexcept{auto&f=*static_cast<Fixture*>(c);++f.selects;if(f.select_failure)return false;f.chosen=mode;return true;}
    Fixture(){
        active=this;queue=a(q);manager=a(m);live=a(lv);popup=live+0x588;thread=a(tp);
        register_span(q);register_span(m);register_span(lv);register_span(data);register_span(tp);register_span(frames);register_span(listener);register_span(old_observer);register_span(title_header);
        put(queue,0xb91f48);put(queue+0x1c8,manager);put(queue+0x9b8,a(data));put(queue+0x8c0,live);put(manager,0xb8f358);put(manager+8,queue);put(manager+0x790,a(data));
        for(Address list:{manager+0x40,manager+0x68}){put(list,0xb8f4e8);put(list+8,0xc22908);put(list+16,0xc22960);}
        put(manager+0x58,manager+0x50);put(manager+0x60,manager+0x50);
        put(live,0xb9a9d8);put(live+0x88,0xb9abf8);put(live+0xb0,manager);
        put(popup,0xb931b0);put(popup+0x88,0xb933e0);put(popup+0xb0,manager);put(popup+0x128,0xb90020);stack(false);
        put(popup+0xe0,a(title_header));value(a(title_header)+0x88,std::uint32_t(0xffffffff));
        Rectangle24 bounds{0xb73b98,0,0,800,480};value(live+0x28,bounds);value(live+0x190,float(1));value(live+0x6f,std::uint8_t(1));value(live+0x104,std::uint8_t(1));
        put(thread+0x10,queue);Address fp=a(frames),pop=fp+0x100,dispatch=fp+0x200;
        put(fp,pop);put(fp+8,0x71396c);put(pop,dispatch);put(pop+8,0x70ff9c);put(dispatch,dispatch+0x100);put(dispatch+8,0x4ef984);
        put(pop+0x28,queue);put(dispatch+0x18,queue);put(pop+0x68,a(listener));put(a(listener)+0x40,a(old_observer));input={0x6be8ac,fp,thread,queue+0xf8,0};
    }
    Memory memory(){return {this,read};}
    Native native(){return {event_ctor,observer_ctor,subscribe,unsubscribe,submenu_ctor,item_ctor,append,set_menu,show,close,invalidate,this,current,inspect};}
    bool configure(){return selector.configure(memory(),native(),{this,select},UserSHA,0,input);}
    void ready(){assert(configure());assert(selector.build_on_ui()==Result::Ok);}
    void action(unsigned i){auto*o=selector.observer_for_test();auto*t=reinterpret_cast<const ObserverTable*>(reinterpret_cast<Address>(o->address_point)-16);t->notify(o,reinterpret_cast<void*>(selector.event_for_test(i)));}
    PaintReceipt receipt(){return {live,0x600000,selector.request_generation(),++serial,{0,0,800,480},{0,0,800,480},true,true,true};}
};Fixture*Fixture::active{};
#ifdef IQ4_F1_UI02_SYNTHETIC_HOST
unsigned groups{};template<class F>void group(F f){f();++groups;}
struct CodeFixture {
    unsigned reads{};bool corrupt{};
    static bool read(void*c,Address p,void*out,std::size_t n)noexcept{
        auto&f=*static_cast<CodeFixture*>(c);++f.reads;
        for(const auto&e:EntryChecks)if(p==e.va&&n==16){std::memcpy(out,e.bytes.data(),16);if(f.corrupt&&p==EntryChecks.back().va)static_cast<unsigned char*>(out)[15]^=1;return true;}
        return false;
    }
};
#endif
}
int main(){
#ifndef IQ4_F1_UI02_SYNTHETIC_HOST
    Fixture f;assert(!f.configure());assert(f.reads==0&&f.native_calls==0);assert(f.selector.build_on_ui()==Result::Disabled);std::puts("production EN0: zero native reads/calls");return 0;
#else
    group([]{Fixture f;Boundary b{};assert(Inspector(f.memory(),0).boundary(f.input,b));assert(b.owner.queue==f.queue&&b.owner.popup==f.popup);});
    group([]{Fixture f;Boundary b{};auto bad=f.input;bad.thread_pointer=f.queue;assert(!Inspector(f.memory(),0).boundary(bad,b));bad=f.input;bad.caller_pc++;assert(!Inspector(f.memory(),0).boundary(bad,b));bad=f.input;bad.original_result=1;assert(!Inspector(f.memory(),0).boundary(bad,b));});
    group([]{Fixture f;Boundary b{};Fixture::put(f.input.frame_pointer+0x100+0x28,0);assert(!Inspector(f.memory(),0).boundary(f.input,b));});
    group([]{Fixture f;Fixture::put(f.live+0xb0,f.queue);assert(!f.configure());assert(f.native_calls==0);});
    group([]{Fixture f;Fixture::put(f.manager+0xc8,f.live);assert(!f.configure());assert(f.native_calls==0);});
    group([]{Fixture f;Fixture::put(f.popup+0x128+0x18,0x700000);assert(!f.configure());});
    group([]{Fixture f;Owner o{};LayoutSnapshot s{};Inspector p(f.memory(),0);assert(p.owner_chain(f.queue,o)&&p.layout_candidates(o,s));assert(s.scale==1&&s.local_control_bounds.width==800);Fixture::value(f.live+0x1b0,std::int32_t(45));assert(!p.layout_candidates(o,s));});
    group([]{Fixture f;assert(!f.selector.configure(f.memory(),f.native(),{&f,Fixture::select},"wrong",0,f.input));assert(f.reads==0&&f.native_calls==0);});
    group([]{Fixture f;f.ready();assert(f.appended==5);for(unsigned i=0;i<5;++i){assert(std::strlen(f.selector.label_for_test(i))<32);assert(f.selector.label_for_test(i)[32]==0);}assert(f.selector.open_on_ui()==Result::Ok);});
    group([]{Fixture f;assert(f.configure());f.bad_item=true;assert(f.selector.build_on_ui()==Result::Hold);assert(f.selector.status_on_ui().module_retained);});
    group([]{Fixture f;f.ready();f.triple_unknown=true;assert(f.selector.open_on_ui()==Result::Rejected);assert(f.shows==0);});
    group([]{Fixture f;f.ready();f.throw_show=true;assert(f.selector.open_on_ui()==Result::Hold);assert(f.selector.status_on_ui().module_retained&&!f.selector.status_on_ui().menu_restored);});
    group([]{constexpr MaskMode modes[]={MaskMode::Off,MaskMode::XPan65_24,MaskMode::Ratio16_9,MaskMode::Ratio3_2,MaskMode::Ratio1_1};for(unsigned i=0;i<5;++i){Fixture f;f.ready();assert(f.selector.open_on_ui()==Result::Ok);f.action(i);assert(f.chosen==modes[i]&&f.selects==1&&f.closes==1&&f.invalidates==1);assert(f.selector.status_on_ui().phase==Phase::AwaitingPaint&&f.selector.status_on_ui().menu_restored);assert(f.selector.observe_paint_on_ui(f.receipt())==Result::Ok);assert(f.selector.status_on_ui().factory_repaint_confirmed==(i==0));}});
    group([]{Fixture f;f.ready();assert(f.selector.open_on_ui()==Result::Ok);f.action(1);f.action(4);assert(f.selects==1&&f.selector.status_on_ui().rejected==1);});
    group([]{Fixture f;f.ready();assert(f.selector.open_on_ui()==Result::Ok);f.bad_close=true;f.action(0);assert(f.selector.status_on_ui().phase==Phase::Hold&&f.sets==1&&f.invalidates==0);});
    group([]{Fixture f;f.ready();assert(f.selector.open_on_ui()==Result::Ok);f.select_failure=true;f.action(0);assert(f.selector.status_on_ui().phase==Phase::Hold&&f.closes==0);});
    group([]{Fixture f;f.ready();assert(f.selector.open_on_ui()==Result::Ok);f.stack(false);assert(f.selector.cancel_on_ui()==Result::Pending&&f.closes==0);assert(f.selector.observe_paint_on_ui(f.receipt())==Result::Ok);});
    group([]{Fixture f;f.ready();assert(f.selector.open_on_ui()==Result::Ok);f.action(0);auto r=f.receipt();r.native_image_blit_completed=false;assert(f.selector.observe_paint_on_ui(r)==Result::Pending);assert(f.selector.observe_paint_on_ui(r)==Result::Rejected);r=f.receipt();r.actual_stock_coverage.width=799;assert(f.selector.observe_paint_on_ui(r)==Result::Pending);r=f.receipt();assert(f.selector.observe_paint_on_ui(r)==Result::Ok);});
    group([]{Fixture f;f.ready();assert(f.selector.open_on_ui()==Result::Ok);f.action(0);auto r=f.receipt();--r.request_generation;assert(f.selector.observe_paint_on_ui(r)==Result::Rejected);r=f.receipt();r.display_lease_live=false;assert(f.selector.observe_paint_on_ui(r)==Result::Hold);});
    group([]{Fixture f;f.ready();assert(f.selector.open_on_ui()==Result::Ok);f.action(0);assert(f.selector.detach_on_ui(1)==Result::Rejected);assert(f.selector.observe_paint_on_ui(f.receipt())==Result::Ok);assert(f.selector.detach_on_ui(1)==Result::Pending);assert(f.selector.confirm_later_boundary(f.input,1)==Result::Pending);assert(f.selector.confirm_later_boundary(f.input,2)==Result::Ok);assert(f.selector.status_on_ui().phase==Phase::DetachedRetained&&f.selector.status_on_ui().native_events_retained);});
    group([]{Fixture f;f.ready();f.wrong_thread=true;assert(f.selector.open_on_ui()==Result::WrongThread);assert(f.shows==0);});
    group([]{Fixture f;f.ready();assert(f.selector.open_on_ui()==Result::Ok);f.action(0);assert(f.selector.observe_paint_on_ui(f.receipt())==Result::Ok);f.triple_unknown=true;assert(f.selector.detach_on_ui(1)==Result::Hold);assert(f.selector.status_on_ui().module_retained);});
    group([]{Fixture f;f.ready();assert(f.selector.open_on_ui()==Result::Ok);Address h=f.manager+0x78,p=f.popup+0x88,l=f.live+0x88;Fixture::put(h+8,p);Fixture::put(h+16,l);Fixture::put(p+8,l);Fixture::put(p+16,h);Fixture::put(l+8,h);Fixture::put(l+16,p);f.action(0);assert(f.selects==0&&f.selector.status_on_ui().rejected==1);});
    group([]{Fixture f;f.ready();assert(f.selector.open_on_ui()==Result::Ok);f.action(0);assert(f.selector.observe_paint_on_ui(f.receipt())==Result::Ok);assert(f.selector.detach_on_ui(1)==Result::Pending);Fixture::put(reinterpret_cast<Address>(f.listener.data())+0x40,reinterpret_cast<Address>(f.selector.observer_for_test()));assert(f.selector.confirm_later_boundary(f.input,2)==Result::Pending);});
    group([]{Fixture f;f.ready();assert(f.selector.open_on_ui()==Result::Ok);f.bad_navigator_detach=true;f.action(0);assert(f.selector.status_on_ui().phase==Phase::Hold&&!f.selector.status_on_ui().menu_restored&&f.invalidates==0);});
    group([]{CodeFixture f;Candidates c{};assert(resolve_static_candidates({&f,CodeFixture::read},0,c));assert(f.reads==12&&reinterpret_cast<Address>(c.set_menu)==0x4fb364);});
    group([]{CodeFixture f;f.corrupt=true;Candidates c{};assert(!resolve_static_candidates({&f,CodeFixture::read},0,c));assert(f.reads==12&&!c.event_ctor&&!c.set_menu);});
    group([]{Fixture f;Fixture::value(reinterpret_cast<Address>(f.title_header.data())+0x88,std::uint32_t(1234));f.ready();assert(f.selector.open_on_ui()==Result::Ok);f.action(0);assert(f.selector.status_on_ui().menu_restored);});
    group([]{Fixture f;f.ready();assert(f.selector.open_on_ui()==Result::Ok);Fixture::value(reinterpret_cast<Address>(f.title_header.data())+0x88,std::uint32_t(1234));f.action(0);assert(f.selector.status_on_ui().phase==Phase::Hold&&!f.selector.status_on_ui().menu_restored&&f.invalidates==0);});
    group([]{iq4::f1::native_overlay::Adapter overlay;OverlaySelectionBridge bridge(overlay,0x700000,{});const auto port=bridge.port();assert(!port.select(port.context,MaskMode::XPan65_24));});
    assert(groups==30);std::puts("30 F1 UI02 finite own-code groups; native/device execution zero");
#endif
}
