#include "bridge.hpp"
#include <cassert>
#include <cstring>
#include <map>
#include <set>
#include <vector>
#include <tuple>
#include <cstdio>
namespace iq4::f1::entry07 {
struct OwnedFixture {
 Binding b;std::map<Address,std::vector<unsigned char>>regions;std::set<std::tuple<Address,Address,Address>>listeners;std::array<std::array<unsigned char,32>,5>nodes{};
 unsigned appended{},notifies{},showcalls{},applies{};MaskMode selected{iq4::MaskMode::Off};bool wrong_thread{},bad_item{};
 static OwnedFixture*self;static constexpr Address Q=0x100000,M=0x102000,D=0x104000,LV=0x106000,H=0x109000,W=0x10b000,P=0x10c000;
 template<class T>void put(Address a,T v){for(auto&r:regions)if(a>=r.first&&a-r.first+sizeof v<=r.second.size()){std::memcpy(r.second.data()+a-r.first,&v,sizeof v);return;}std::memcpy(reinterpret_cast<void*>(a),&v,sizeof v);}
 static bool read(void*c,Address a,void*out,std::size_t n)noexcept{
  auto&f=*static_cast<OwnedFixture*>(c);for(auto&r:f.regions)if(a>=r.first&&a-r.first<=r.second.size()&&n<=r.second.size()-(a-r.first)){std::memcpy(out,r.second.data()+a-r.first,n);return true;}
  Address at=reinterpret_cast<Address>(&f.b),end=at+sizeof f.b;if(a>=at&&a<=end&&n<=end-a){std::memcpy(out,reinterpret_cast<void*>(a),n);return true;}
  for(auto&node:f.nodes){at=reinterpret_cast<Address>(node.data());end=at+node.size();if(a>=at&&a<=end&&n<=end-a){std::memcpy(out,reinterpret_cast<void*>(a),n);return true;}}
  return false;
 }
 static Address current(void*c)noexcept{return static_cast<OwnedFixture*>(c)->wrong_thread?Q+8:Q;}
 static Triple triple(void*c,Address q,Address e,const Observer*o)noexcept{return static_cast<OwnedFixture*>(c)->listeners.count({q,e,reinterpret_cast<Address>(o)})?Triple::Present:Triple::Absent;}
 static void control_ctor(entry_ports01::ControlObserverNative*o){o->address_point=reinterpret_cast<void*>(entry_ports01::ControlObserverVT);}
 static void queue_ctor(entry_ports01::QueueObserverNative*o,const char*n,void*q){o->address_point=reinterpret_cast<void*>(entry_ports01::QueueObserverVT);o->queue=q;o->persistent_name=n;}
 static void event_ctor(void*s,const char*){self->put(reinterpret_cast<Address>(s),Address(0xc237a0));}
 static void subscribe(entry_ports01::QueueObserverNative*o,void*e){self->listeners.insert({Q,reinterpret_cast<Address>(e),reinterpret_cast<Address>(o)});}
 static void unsubscribe(entry_ports01::QueueObserverNative*o,void*e){self->listeners.erase({Q,reinterpret_cast<Address>(e),reinterpret_cast<Address>(o)});}
 static void notify(void*){++self->notifies;}
 static void submenu(void*s,std::uint32_t title,void*,void*){Address a=reinterpret_cast<Address>(s);self->put(a,Address(0xb8f9b8));self->put(a+0x14,title);self->put(a+0x18,Address(0xb8faa0));self->put(a+0x20,Address(0xc22908));self->put(a+0x28,Address(0xc22960));self->put(a+0x30,a+0x28);self->put(a+0x38,a+0x28);}
 static void item(void*s,std::uint32_t id,void*e,void*){Address a=reinterpret_cast<Address>(s);self->put(a,Address(self->bad_item?0xb90740:0xb90748));self->put(a+0x14,id);self->put(a+0x18,reinterpret_cast<Address>(e));}
 static void append(void*root,void*item){Address r=reinterpret_cast<Address>(root),head=r+0x28,n=reinterpret_cast<Address>(self->nodes[self->appended++].data()),last{};read(self,head+16,&last,8);self->put(n,Address(0xb8f958));self->put(n+8,head);self->put(n+16,last);self->put(n+24,reinterpret_cast<Address>(item));self->put(last+8,n);self->put(head+16,n);}
 static void popup(void*s,void*m,void*,std::uint32_t width,std::uint8_t flag){assert(width==750&&flag==1);Address a=reinterpret_cast<Address>(s);self->put(a,Address(0xb931b0));self->put(a+0xb0,reinterpret_cast<Address>(m));self->put(a+0x128,Address(0xb90020));}
 static void text(void*s,std::int32_t w,std::int32_t h,void*p,std::uint32_t font,const char*label,std::uint8_t flag,std::uint32_t value,std::uint32_t ninth){assert(w==128&&h==128&&reinterpret_cast<Address>(p)==P&&font==5&&!std::strcmp(label,"F1 mask")&&flag==0&&value==1&&ninth==1);Address a=reinterpret_cast<Address>(s);self->put(a,Address(0xba6230));self->put(a+0x28,Rectangle24{0xb73b98,0,0,128,128});}
 static void bind(void*s,entry_ports01::ControlObserverNative*o,std::uint32_t tag){Address a=reinterpret_cast<Address>(s);self->put(a+0x60,reinterpret_cast<Address>(o));self->put(a+0x68,tag);}
 static void attach(void*parent,void*child,std::int32_t x,std::int32_t y,std::uint32_t a,std::uint32_t z){assert(x==0&&y==0&&a==1&&z==1);Address p=reinterpret_cast<Address>(parent),c=reinterpret_cast<Address>(child);self->put(p+0x10,c);self->put(c+8,p);}
 static void detach(void*child){Address c=reinterpret_cast<Address>(child);self->put(LV+0x10,Address(0));self->put(c+0x18,Address(0));self->put(c+0x20,Address(0));/* Parent retained */}
 static void setmenu(void*popup,void*root){Address p=reinterpret_cast<Address>(popup),r=reinterpret_cast<Address>(root);self->put(p+0x128+0x18,r);self->put(p+0x128+0x308,r);self->put(p+0x128+0x350,Address(0));auto k=std::make_tuple(Q,self->b.own_root()+0x60,p+0x128);if(r)self->listeners.insert(k);else self->listeners.erase(k);}
 static void show(void*popup){++self->showcalls;Address p=reinterpret_cast<Address>(popup),node=p+0x88,head=M+0x78,lv=LV+0x88;self->put(node,Address(0xb933e0));self->put(node+8,head);self->put(node+16,lv);self->put(node+24,p);self->put(lv+8,node);self->put(head+16,node);}
 static void close(void*){Address head=M+0x78,lv=LV+0x88;self->put(lv+8,head);self->put(head+16,lv);}
 static SelectResult apply(void*c,MaskMode mode,std::uint64_t generation)noexcept{auto&f=*static_cast<OwnedFixture*>(c);assert(generation);++f.applies;f.selected=mode;return SelectResult::AwaitingStockPaint;}
 OwnedFixture(){self=this;for(Address a:{Q,M,D,LV,H,W,P})regions[a]=std::vector<unsigned char>(a==LV?0x2000:0x1000);
  put(Q,Address(0xb91f48));put(Q+0x1c8,M);put(Q+0x9b8,D);put(Q+0x8c0,LV);put(M,Address(0xb8f358));put(M+8,Q);put(M+0x790,D);put(LV,Address(0xb9a9d8));put(LV+0xb0,M);put(LV+0x588,Address(0xb931b0));put(LV+0x588+0xb0,M);put(LV+0x588+0x128,Address(0xb90020));put(LV+0x588+0xe0,H);put(H+0x88,std::uint32_t(1));put(M+0x788,W);put(LV+0xf0,W);put(W+0x10,P);put(P,Address(0xb934d0));put(LV+0x28,Rectangle24{0xb73b98,0,0,750,1280});
  for(Address list:{M+0x40,M+0x68}){put(list,Address(0xb8f4e8));put(list+8,Address(0xc22908));put(list+16,Address(0xc22960));}
  Address priority=M+0x50,normal=M+0x78,node=LV+0x88;put(priority+8,priority);put(priority+16,priority);put(normal+8,node);put(normal+16,node);put(node,Address(0xb9abf8));put(node+8,normal);put(node+16,normal);put(node+24,LV);
  b.memory_={this,read};b.owner_={Q,M,D,LV,LV+0x588};b.resource_=P;b.title_=1;b.configured_=true;b.status_.phase=static_cast<unsigned>(iq4::f1::entry07::Phase::Bound);b.native_.context=this;b.native_.current_thread=current;b.native_.inspect_triple=triple;
  b.ports_={text,popup,control_ctor,queue_ctor,event_ctor,subscribe,unsubscribe,notify,bind,attach,detach,setmenu,show,close,nullptr,submenu,item,append,nullptr};
  read(this,LV+0x588+0x128,b.stock_menu_head_.data(),b.stock_menu_head_.size());read(this,LV+0x588+0x128+0x300,b.stock_menu_stack_.data(),b.stock_menu_stack_.size());
 }
 void control(Address sender,unsigned tag,std::uint32_t kind){regions[0x110000]=std::vector<unsigned char>(16);put(0x110000,kind);b.control_notification(reinterpret_cast<void*>(sender),reinterpret_cast<void*>(0x110000),tag);}
 void queued(unsigned i){b.queue_notification(reinterpret_cast<void*>(b.own_event(i)));}
 void selection(){b.selection_={this,apply};}
 void open(){control(b.own_button(),0x463107,1);b.queue_notification(reinterpret_cast<void*>(b.own_event(5)));assert(b.status_.phase==static_cast<unsigned>(iq4::f1::entry07::Phase::Open));}
};OwnedFixture*OwnedFixture::self=nullptr;
}
int main(){using namespace iq4::f1::entry07;unsigned groups=0;
 {BoundaryBridge bridge;assert(!bridge.admitted());assert(!bridge.admit_once({},{}));Binding b;assert(!b.build_on_ui()&&!b.cancel_on_ui()&&!b.detach_on_ui(1));++groups;}
 {OwnedFixture f;f.wrong_thread=true;assert(!f.b.build_on_ui());assert(!f.appended&&!f.notifies);++groups;}
 {OwnedFixture f;f.put(OwnedFixture::LV+0x10,OwnedFixture::H);f.put(OwnedFixture::H+8,OwnedFixture::LV);f.put(OwnedFixture::H+0x28,Rectangle24{0xb73b98,0,0,128,128});f.put(OwnedFixture::H+0x6f,std::uint8_t(1));assert(!f.b.build_on_ui());assert(!f.appended);++groups;}
 {OwnedFixture f;f.bad_item=true;assert(!f.b.build_on_ui());assert(f.b.status_on_ui().phase==static_cast<unsigned>(iq4::f1::entry07::Phase::Hold));++groups;}
 {OwnedFixture f;assert(f.b.build_on_ui());f.control(f.b.own_button(),1,1);f.control(f.b.own_button(),8,1);f.control(OwnedFixture::LV,0x463107,1);f.control(f.b.own_button(),0x463107,8);assert(!f.notifies);++groups;
  f.control(f.b.own_button(),0x463107,1);assert(f.notifies==1&&!f.showcalls);f.control(f.b.own_button(),0x463107,1);assert(f.notifies==1);f.queued(5);assert(f.showcalls==1);++groups;
  f.queued(1);assert(f.b.status_on_ui().phase==static_cast<unsigned>(iq4::f1::entry07::Phase::Open)&&f.b.status_on_ui().selected==iq4::MaskMode::Off);f.queued(0);assert(f.b.status_on_ui().phase==static_cast<unsigned>(iq4::f1::entry07::Phase::Ready)&&!f.applies);++groups;
  assert(f.b.detach_on_ui(10));assert(f.b.status_on_ui().phase==static_cast<unsigned>(iq4::f1::entry07::Phase::Detaching));Address parent{};assert(OwnedFixture::read(&f,f.b.own_button()+8,&parent,8)&&parent==OwnedFixture::LV);++groups;
 }
 {OwnedFixture f;assert(f.b.build_on_ui());assert(f.b.install_selection_once_on_ui({&f,OwnedFixture::apply}));assert(!f.b.install_selection_once_on_ui({&f,OwnedFixture::apply}));
  for(unsigned i=1;i<5;i++){f.open();f.queued(i);assert(f.b.status_on_ui().phase==static_cast<unsigned>(iq4::f1::entry07::Phase::AwaitingStockPaint));PaintReceipt r{};r.lv=OwnedFixture::LV;r.surface=0x112000;r.request_generation=f.b.status_on_ui().generation;r.ui_paint_serial=i;r.image_viewport={0,0,100,100};r.actual_stock_coverage={0,0,50,100};r.original_returned_normally=true;r.display_lease_live=true;r.native_image_blit_completed=true;assert(!f.b.observe_stock_paint_on_ui(r));r.actual_stock_coverage={0,0,100,100};assert(f.b.observe_stock_paint_on_ui(r));assert(!f.b.detach_on_ui(20));}
  assert(f.applies==4);++groups;f.open();assert(f.b.cancel_on_ui());assert(f.b.status_on_ui().phase==static_cast<unsigned>(iq4::f1::entry07::Phase::Ready));++groups;
 }
 assert(groups==10);std::printf("10 owned entry07 native-port/queue/restore fault groups PASS; vendor/target execution zero\n");}
