#include "contracts.hpp"
#include <cassert>
#include <cstdint>
#include <cstdio>
using namespace iq4::f1::entry_ports01;
static void* seen[4];static std::uint32_t values[9];static unsigned calls;
static void own_text(void*a,std::int32_t b,std::int32_t c,void*d,std::uint32_t e,const char*f,std::uint8_t g,std::uint32_t h,std::uint32_t i){
    seen[0]=a;seen[1]=d;seen[2]=const_cast<char*>(f);values[0]=std::uint32_t(b);values[1]=std::uint32_t(c);values[2]=e;values[3]=g;values[4]=h;values[5]=i;++calls;
}
static void own_popup(void*a,void*b,void*c,std::uint32_t d,std::uint8_t e){seen[0]=a;seen[1]=b;seen[2]=c;values[6]=d;values[7]=e;++calls;}
static void own_control_callback(ControlObserverNative*a,void*b,const void*c,std::uint32_t d){seen[0]=a;seen[1]=b;seen[2]=const_cast<void*>(c);values[8]=d;++calls;}
int main(){
    char storage[16]{},provider[16]{},root[16]{},text[]="F1 mask";
    TextButtonCtor t=own_text;t(storage,-130,54,provider,5,text,0xa5,0x87654321,0xfedcba98);
    assert(calls==1&&seen[0]==storage&&seen[1]==provider&&seen[2]==text&&values[0]==std::uint32_t(-130)&&values[1]==54&&values[2]==5&&values[3]==0xa5&&values[4]==0x87654321&&values[5]==0xfedcba98);
    PopupCtor p=own_popup;p(storage,provider,root,750,0xb7);
    assert(calls==2&&seen[0]==storage&&seen[1]==provider&&seen[2]==root&&values[6]==750&&values[7]==0xb7);
    ControlObserverNative observer{};ControlNotification n=own_control_callback;n(&observer,storage,root,0xabc123);
    assert(calls==3&&seen[0]==&observer&&seen[1]==storage&&seen[2]==root&&values[8]==0xabc123);
    Candidates c{};assert(!ProductionEntryEnabled&&!c.text_button_ctor&&!c.own_popup_ctor&&!c.control_observer_ctor&&!c.queue_observer_ctor&&!c.event_ctor&&!c.subscribe&&!c.unsubscribe&&!c.notify&&!c.control_bind&&!c.control_attach&&!c.control_detach&&!c.set_menu&&!c.show&&!c.close&&!c.current_thread&&!c.submenu_ctor&&!c.item_ctor&&!c.append_item&&!c.set_flag41);
    std::puts("3 owned ABI argument fixtures; production EN0/null19; native/device execution zero");
}
