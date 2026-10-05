#include "module.hpp"
#include <cstring>
#include <cstdio>
#include <cstdlib>
#include <array>
using namespace iq4::f1::entry01;
namespace {
unsigned reads=0,calls=0;
bool read(void*,Address,void*,std::size_t)noexcept{++reads;return false;}
int native(void*){++calls;return 0;}
void need(bool v){if(!v)std::abort();}
std::array<unsigned char,0x4000> arena{};
bool bounded_read(void*,Address p,void*out,std::size_t n)noexcept{
    if(p<0x10000||n>arena.size()||p-0x10000>arena.size()-n)return false;
    std::memcpy(out,arena.data()+p-0x10000,n);return true;
}
void put(Address p,Address v){std::memcpy(arena.data()+p-0x10000,&v,8);}
void lists(const Owner&o,bool home){
    arena.fill(0);Address m=o.manager,normal=m+0x78,priority=m+0x50,node=o.lv+0x88,extra=0x12088;
    for(Address list:{m+0x40,m+0x68}){put(list,0xb8f4e8);put(list+8,0xc22908);put(list+16,0xc22960);}
    put(priority+8,priority);put(priority+16,priority);put(normal+8,home?extra:node);put(normal+16,node);
    put(node,0xb9abf8);put(node+8,normal);put(node+16,home?extra:normal);put(node+24,o.lv);put(o.lv+0xb0,m);
    if(home){put(extra,0xb90000);put(extra+8,node);put(extra+16,normal);put(extra+24,extra-0x88);put(extra-0x88+0xb0,m);}
}
}
int main(){
    Module disabled;need(disabled.configure({nullptr,read},{false,false,false,false,0},native,native));
    for(unsigned i=0;i<100;++i)disabled.after_unlock({0x6be8ac,0x1000,0x2000,0x3000,0});
    Observation status{};need(disabled.snapshot(status)&&status.dispatch_epoch==0&&reads==0&&calls==0&&status.native_mutating_calls==0&&status.mask_enabled==0);
    need(!disabled.configure({nullptr,read},{false,false,false,false,0},native,native));
    for(unsigned flag=0;flag<3;++flag){Module guarded;ImageGate g{true,true,true,true,0};if(flag==0)g.whole_user=false;if(flag==1)g.mapped_ro=false;if(flag==2)g.original_pthread=false;
        need(!guarded.configure({nullptr,read},g,native,native));need(guarded.snapshot(status)&&status.phase==static_cast<unsigned>(iq4::f1::entry01::Phase::Hold));}
    Module signature;need(!signature.configure({nullptr,read},{true,true,true,true,0},native,native));need(reads==1&&calls==0);
    // Concrete port addresses are never executed here. No synthetic macro or
    // mock native owner can enable either frozen overlay/selector configure.
    auto ui=disabled.selector_ports();auto overlay=disabled.overlay_ports();need(ui.context==&disabled&&overlay.context==&disabled&&ui.current_thread(ui.context)==0);
    need(ui.inspect_triple(ui.context,0,0,nullptr)==iq4::f1::native_ui02::Triple::Unknown);
    need(!overlay.request_stock_repaint(overlay.context,0));need(calls==0);
    disabled.stop_observing();need(disabled.snapshot(status)&&status.phase==static_cast<unsigned>(iq4::f1::entry01::Phase::Stopped));
    // Unknown original prefix is observable, but is never promoted into the
    // frozen UI02 selector enable gate. Fault/cycle reads remain bounded.
    Owner o{0,0x10000,0,0x11000,0};StackFacts stack{};lists(o,false);
    need(observe_stack({nullptr,bounded_read},0,o,stack)&&stack.normal_count==1&&stack.lv_at_tail);
    lists(o,true);need(observe_stack({nullptr,bounded_read},0,o,stack)&&stack.normal_count==2&&stack.dialogs[0]==0x12000&&stack.lv_at_tail);
    put(o.lv+0x88+8,o.lv+0x88);need(!observe_stack({nullptr,bounded_read},0,o,stack));
    lists(o,true);put(0x12088+16,0x12300);need(!observe_stack({nullptr,bounded_read},0,o,stack));
    need(calls==0);
    std::puts("13 own module gate/stack/forward-port groups PASS; zero vendor/target execution");
}
