#include "../f1_native_ui_02/ui.hpp"
#include <cmath>
#include <cstring>

namespace iq4::f1::native_ui02 {
namespace {
bool ptr(Address p)noexcept{return p>=4096&&p<=UINTPTR_MAX-0x2000&&(p&7)==0;}
bool same(const Owner&a,const Owner&b)noexcept{return a.queue==b.queue&&a.manager==b.manager&&a.data==b.data&&a.lv==b.lv&&a.popup==b.popup;}

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
}
