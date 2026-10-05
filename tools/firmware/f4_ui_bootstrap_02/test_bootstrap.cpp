#include "bootstrap.hpp"
#include "sha256.h"
#include <array>
#include <cassert>
#include <cerrno>
#include <cstring>
#include <iostream>
#include <new>
#include <stdexcept>
#include <vector>
using namespace iq4::f4::bootstrap;
namespace {
constexpr Address q=0x100000,manager=0x110000,data=0x120000,lv=0x130000,access=0x140000,engine=0x150000;
constexpr Address tp=0x200000,fp=0x210000,pop=0x210100,dispatch=0x210200,original_observer=0x230000,popped=0x240000;
struct Region {Address start;std::vector<unsigned char> bytes;unsigned char* actual{};std::size_t size{};};
struct Fixture {
 std::vector<Region> regions;std::vector<Address> registrations;Address current=q;unsigned calls{},try_locks{},unlocks{},constructs{},notifies{},registry_nodes{},next_listener{};bool global_held{},busy{},throw_construct{},throw_register{},throw_unregister{},reenter{},bad_event{},bad_observer{},bad_read{},counter_inflight{};
 void add(Address a,std::size_t n){regions.push_back({a,std::vector<unsigned char>(n),nullptr,n});}
 void actual(void* p,std::size_t n){regions.push_back({reinterpret_cast<Address>(p),{},static_cast<unsigned char*>(p),n});}
 unsigned char* find(Address a,std::size_t n){for(auto& r:regions)if(a>=r.start&&n<=r.size&&a-r.start<=r.size-n)return (r.actual?r.actual:r.bytes.data())+(a-r.start);return nullptr;}
 void put(Address a,Address v){auto* p=find(a,8);assert(p);std::memcpy(p,&v,8);}
 Address get(Address a){Address v{};auto* p=find(a,8);assert(p);std::memcpy(&v,p,8);return v;}
 Fixture(){for(Address a:{q,manager,data,lv,access,engine,tp,fp,original_observer,popped,Address(0xf55000)})add(a,a==fp?0x400:0x1000);
  put(0xf553a8,0x409c10);put(0xf553d0,1);
  put(q,0xb91f48);put(q+0x1c8,manager);put(q+0x9b8,data);put(q+0x8c0,lv);put(manager,0xb8f358);put(manager+8,q);put(manager+0x790,data);put(lv,0xb9a9d8);put(lv+0x108,access);put(data+0x118,access);put(access,0xc07da8);put(access+8,engine);put(engine+0x640,0xc237a0);put(engine+0x640+0x98,0xc22908);
  put(tp+0x10,q);put(fp,pop);put(fp+8,0x71396c);put(pop,dispatch);put(pop+8,0x70ff9c);put(pop+0x28,q);put(pop+0x68,popped);put(dispatch,dispatch+0x100);put(dispatch+8,0x4ef984);put(dispatch+0x18,q);put(popped+0x40,original_observer);
  const auto head=q+0x78;put(head+8,head);put(head+16,head);
 }
};
Fixture* f{};alignas(Bootstrap) unsigned char storage[sizeof(Bootstrap)];Bootstrap* b{};
bool read(void*,Address a,void* p,std::size_t n) noexcept {if((a>=0x300000&&a<0x400000)||a==q+0x80||a==q+0x88)assert(f->global_held);if(f->bad_read)return false;auto* src=f->find(a,n);if(!src)return false;std::memcpy(p,src,n);return true;}
int try_lock(void* m){++f->try_locks;if(f->busy)return EBUSY;if(reinterpret_cast<Address>(m)==0xf553c0){assert(!f->global_held);f->global_held=true;}return 0;}
int unlock(void* m){++f->unlocks;if(reinterpret_cast<Address>(m)==0xf553c0){assert(f->global_held);f->global_held=false;}return 0;}
void control();
void* current(){if(f->counter_inflight){f->counter_inflight=false;control();}return reinterpret_cast<void*>(f->current);}
void construct(Observer* o,const char* name,void* queue){++f->calls;o->queue=f->bad_observer?nullptr:queue;o->persistent_name=name;f->actual(o,sizeof(*o));}
void subscribe(Observer* o,void* ev){++f->calls;if(f->throw_register)throw std::runtime_error("host fake registration");
 const Address listener=0x300000+0x1000*f->next_listener++;f->add(listener,0x1000);f->registrations.push_back(listener);
 const auto node=listener+0x68,head=q+0x78,last=f->get(head+16);
 f->put(node,0xc23cb8);f->put(node+8,head);f->put(node+16,last);f->put(node+24,listener);f->put(listener+8,reinterpret_cast<Address>(ev));f->put(listener+0x30,reinterpret_cast<Address>(o->queue));f->put(listener+0x40,reinterpret_cast<Address>(o));f->put(last+8,node);f->put(head+16,node);
}
void unsubscribe(Observer* o,void* ev){++f->calls;if(f->throw_unregister)throw std::runtime_error("host fake unregister");
 for(auto listener:f->registrations)if(f->get(listener+8)==reinterpret_cast<Address>(ev)&&f->get(listener+0x40)==reinterpret_cast<Address>(o)){
  auto node=listener+0x68,next=f->get(node+8),prev=f->get(node+16);if(next==node)continue;f->put(prev+8,next);f->put(next+16,prev);f->put(node+8,node);f->put(node+16,node);
 }
}
void event_construct(void* ev,const char*){++f->constructs;if(f->throw_construct)throw std::runtime_error("host fake event ctor");std::memset(ev,0,0xb8);f->actual(ev,0xb8);auto a=reinterpret_cast<Address>(ev),head=a+0x98;f->put(a,f->bad_event?0:0xc237a0);f->put(head+8,head);f->put(head+16,head);f->registry_nodes+=2;}
void event_notify(void*){++f->notifies;if(f->reenter)b->after_unlock(0x6be8ac,fp,tp,q+0xf8,0);}
Native native(){return {construct,subscribe,unsubscribe,current,event_construct,event_notify,try_lock,unlock};}
ImageGate gate(){return {true,true,true,true,0};}
void setup(Fixture& x){f=&x;b=new(storage)Bootstrap;}
void configure(ImageGate g=gate()){assert(b->configure({nullptr,read},native(),g));}
void boundary(){b->after_unlock(0x6be8ac,fp,tp,q+0xf8,0);}
void cb(Observer* o,void* event){Callback fn{};std::memcpy(&fn,reinterpret_cast<const unsigned char*>(o->address_point)+16,8);fn(o,event);}
void control(){auto* o=b->control_observer_for_test();Address ev{};for(auto a:f->registrations)if(f->get(a+0x40)==reinterpret_cast<Address>(o))ev=f->get(a+8);assert(ev);cb(o,reinterpret_cast<void*>(ev));}
void through_attached(){boundary();assert(b->status().phase==Phase::ControlQueued);control();assert(b->status().phase==Phase::CounterAttached);}
int real_calls{},diagnostic_calls{},ordered{};
int original_forward(void*){assert(ordered==0);ordered=1;++real_calls;errno=47;return 73;}
void diagnostic(void*,int result)noexcept{assert(ordered==1&&result==73);ordered=2;++diagnostic_calls;errno=94;}
}
int main(){unsigned groups=0;
 {Fixture x;setup(x);auto g=gate();g.enabled=false;configure(g);boundary();assert(b->status().phase==Phase::Disabled&&x.calls==0&&x.constructs==0);++groups;}
 for(unsigned missing=0;missing<3;++missing){Fixture x;setup(x);auto g=gate();if(missing==0)g.whole_user_verified=false;if(missing==1)g.mapped_nonwritable_segments_verified=false;if(missing==2)g.original_pthread_verified=false;assert(!b->configure({nullptr,read},native(),g));boundary();assert(x.calls==0&&x.constructs==0);++groups;}
 {Fixture x;setup(x);configure();x.put(q+0x1c8,0);boundary();assert(b->status().phase==Phase::Waiting&&x.constructs==0);++groups;}
 {Fixture x;setup(x);configure();x.put(q,0xb91f50);boundary();assert(x.constructs==0);++groups;}
 {Fixture x;setup(x);configure();x.put(tp+0x10,0);boundary();assert(x.constructs==0);++groups;}
 {Fixture x;setup(x);configure();b->after_unlock(0x6be8ac,0xdead0000,tp,q+0xf8,0);assert(x.constructs==0);++groups;}
 {Fixture x;setup(x);configure();x.put(fp,fp);boundary();assert(x.constructs==0);++groups;}
 {Fixture x;setup(x);configure();x.put(pop+8,0x70ff98);boundary();assert(x.constructs==0);++groups;}
 {Fixture x;setup(x);configure();x.put(dispatch+8,0x4ef97c);boundary();assert(x.constructs==0);++groups;}
 {Fixture x;setup(x);configure();x.put(pop+0x28,q+8);boundary();assert(x.constructs==0);++groups;}
 {Fixture x;setup(x);configure();x.put(lv+0x108,access+8);boundary();assert(x.constructs==0);++groups;}
 {Fixture x;setup(x);configure();b->after_unlock(0x7123c8,fp,tp,q+0xf8,0);b->after_unlock(0x6be8ac,fp,tp,q+0xf8,EPERM);b->after_unlock(0x6be8ac,fp,tp,q+8,0);assert(x.constructs==0);++groups;}
 {Fixture x;setup(x);configure();x.current=q+8;boundary();assert(b->status().phase==Phase::Hold&&x.constructs==0);++groups;}
 {Fixture x;setup(x);configure();x.busy=true;boundary();assert(b->status().phase==Phase::Hold);assert(x.calls==0);++groups;}
 {Fixture x;setup(x);configure();x.throw_construct=true;boundary();assert(b->status().phase==Phase::Hold&&x.calls==0);++groups;}
 {Fixture x;setup(x);configure();x.bad_event=true;boundary();assert(b->status().phase==Phase::Hold&&x.calls==0);++groups;}
 {Fixture x;setup(x);configure();x.bad_observer=true;boundary();assert(b->status().phase==Phase::Hold&&x.calls==1);++groups;}
 {Fixture x;setup(x);configure();x.throw_register=true;boundary();assert(b->status().phase==Phase::Hold&&x.constructs==1);++groups;}
 {Fixture x;setup(x);configure();x.reenter=true;boundary();assert(b->status().qualified_boundaries==1&&x.constructs==1&&x.notifies==1);++groups;}
 {Fixture x;setup(x);configure();through_attached();auto& c=b->counter_for_test();cb(c.observer_address(),reinterpret_cast<void*>(engine+0x640));assert(b->status().notifications==1);control();assert(b->status().phase==Phase::Detaching);boundary();assert(b->status().phase==Phase::ObserversDetachedEventRetained&&b->status().event_retained&&b->status().module_retained&&x.registry_nodes==2);assert(c.safe_to_release());++groups;}
 {Fixture x;setup(x);configure();through_attached();x.put(popped+0x40,reinterpret_cast<Address>(b->control_observer_for_test()));control();boundary();assert(b->status().phase==Phase::Detaching);x.put(popped+0x40,original_observer);boundary();assert(b->status().phase==Phase::ObserversDetachedEventRetained);++groups;}
 {Fixture x;setup(x);configure();through_attached();x.throw_unregister=true;control();assert(b->status().phase==Phase::Hold&&b->status().module_retained);++groups;}
 {Fixture x;setup(x);configure();boundary();for(unsigned i=1;i<4098;++i)boundary();assert(b->status().phase==Phase::Hold&&x.constructs==1&&x.notifies==1);++groups;}
 {Fixture x;setup(x);configure();boundary();auto* o=b->control_observer_for_test();cb(o,reinterpret_cast<void*>(engine+0x640));assert(b->status().phase==Phase::Hold);++groups;}
 {Fixture x;setup(x);configure();through_attached();x.current=q+8;control();assert(b->status().phase==Phase::Hold);++groups;}
 {Fixture x;setup(x);configure();through_attached();auto& c=b->counter_for_test();control();cb(c.observer_address(),reinterpret_cast<void*>(engine+0x640));boundary();assert(b->status().phase==Phase::Detaching&&!c.safe_to_release());++groups;}
 {Fixture x;setup(x);configure();through_attached();auto* o=b->control_observer_for_test();auto l=x.registrations[0];x.put(l+0x68+16,l+0x68);assert(b->inspect(q,x.get(l+8),o)==Triple::Unknown);++groups;}
 {Fixture x;setup(x);configure();through_attached();x.busy=true;assert(b->inspect(q,engine+0x640,b->counter_for_test().observer_address())==Triple::Unknown);++groups;}
 {Fixture x;setup(x);configure();through_attached();const auto before=x.calls;x.counter_inflight=true;cb(b->counter_for_test().observer_address(),reinterpret_cast<void*>(engine+0x640));assert(b->status().phase==Phase::Hold&&x.calls==before&&!b->counter_for_test().safe_to_release());++groups;}
 {Fixture x;setup(x);configure();x.put(0xf553d0,0);boundary();assert(b->status().phase==Phase::Hold&&x.calls==1);++groups;}
 {int e=6;real_calls=diagnostic_calls=ordered=0;assert(forward_once(original_forward,nullptr,e,nullptr,diagnostic)==73);assert(real_calls==1&&diagnostic_calls==1&&ordered==2&&e==47&&errno==47);++groups;}
 {F4Sha s;char out[65];f4_sha_init(&s);f4_sha_update(&s,"abc",3);f4_sha_end(&s,out);assert(std::strcmp(out,"ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad")==0);++groups;}
 std::cout<<groups<<" SDK-free synthetic bootstrap groups passed; no target code executed\n";
}
