#include "integration.inc"
#include <cassert>
#include <cstdio>
#include <stdexcept>
#include <vector>
using namespace iq4::ordinary_capture_01;
static constexpr uintptr_t Base=0x10000000,CM=Base,Prod=Base+0x9000,Pool=Base+0xb000,Manager=Base+0xc000,Unlock=Base+0xd000;
static std::vector<unsigned char> bytes(0x500000);
static int read_fail=0,read_throw=0,race=0,queue_throw=0,inserted=1,queue_calls=0,release_calls=0,reset_calls=0;
static bool race_accepted=false;static Guard*interleave=nullptr;
template<class T>static void put(uintptr_t p,T v){assert(p>=Base&&p+sizeof(v)<=Base+bytes.size());std::memcpy(bytes.data()+p-Base,&v,sizeof(v));}
static int reader(void*,uintptr_t p,void*out,size_t n){
 if(read_throw)throw std::runtime_error("read fixture");if(read_fail)return 0;
 if(interleave){auto*g=interleave;interleave=nullptr;g->invalidate(0x1234);}
 for(const auto&pin:OrdinaryPins01)if(p==pin.va&&n==pin.bytes){std::memcpy(out,pin.data,n);return 1;}
 if(p<Base||p>Base+bytes.size()||n>Base+bytes.size()-p)return 0;std::memcpy(out,bytes.data()+p-Base,n);return 1;
}
static Memory memory{nullptr,reader};
struct F {uintptr_t node,mr,meta,raw;};
static F setup(unsigned i=0,uint32_t number=1){
 uintptr_t node=Base+0x10000+uintptr_t(i)*0x5000;F f{node,node+0x100,node+0x1000,node+0x200};
 put(Pool,uintptr_t(0xdb4980));put(CM+0x2090,Pool);put(CM+0x2098,node);put(CM+0x80f8,Prod);put(CM+0xc08,uint8_t(0));put(CM+0x2708,uint8_t(0));put(CM+0x26fc,uint32_t(0));put(CM+0x2330,number);put(Prod+0x1a0,uint8_t(0));put(Prod+0x1488,uint32_t(0));
 put(node+0x78,uintptr_t(0));put(node+0x80,node);put(node+0x90,f.mr);put(node+0x88,f.raw);put(f.mr+0x40,f.meta);put(f.meta+0xb8,number);put(f.meta+0x484,uint32_t(0));put(f.meta+0x490,uint8_t(0));put(Manager+0x38,Pool);put(Manager+0x48,node);return f;
}
static void ready(Guard&g,const F&f,uint32_t result=1){put(Unlock,Pool+0x98+0x20);put(Pool+0x98+8,f.node+0x78);put(Pool+0x98+0x10,f.node+0x78);g.before_queue_unlock(memory,Unlock,Pool+0x98,f.node+0x78,result);}
static void native_queue(void*,void*node){
 ++queue_calls;if(queue_throw==1)throw std::runtime_error("pre-link");
 uintptr_t n=uintptr_t(node);put(Unlock,Pool+0xb8);put(Pool+0xa0,n+0x78);put(Pool+0xa8,n+0x78);
 if(queue_throw==2)throw std::runtime_error("notification before normal unlock");
 iq4_f3_ordinary_queue_unlock_wrapper_01((void*)Unlock,(void*)(Pool+0x98),(void*)(n+0x78),inserted);
}
extern "C" void iq4_f3_original_calibration_enqueue_01(void*a,void*b){native_queue(a,b);}
extern "C" void iq4_f3_original_node_reset_01(void*){++reset_calls;}
extern "C" void iq4_f3_original_queue_guard_release_01(void*){
 ++release_calls;if(queue_throw==3)throw std::runtime_error("unlock fixture");
 if(race){uintptr_t node=0;reader(nullptr,Manager+0x48,&node,8);race_accepted=ordinary_guard01.consume(memory,Manager,node);}
}
int main(){
 unsigned checks=0;assert(original_prefixes(memory));++checks;
 {Guard g;F f=setup();auto t=g.begin(memory,CM,Pool,f.node);assert(t);ready(g,f);g.complete(t,true);assert(g.consume(memory,Manager,f.node));assert(!g.consume(memory,Manager,f.node));++checks;}
 {Guard g;F f=setup(0,0);auto t=g.begin(memory,CM,Pool,f.node);assert(t);ready(g,f);g.complete(t,true);assert(g.consume(memory,Manager,f.node));++checks;}
 {Guard g;F f=setup();auto t=g.begin(memory,CM,Pool,f.node);assert(t);assert(!g.consume(memory,Manager,f.node));ready(g,f);g.complete(t,true);assert(!g.consume(memory,Manager,f.node));++checks;}
 // Outer void success is never an insertion receipt.
 {Guard g;F f=setup();auto t=g.begin(memory,CM,Pool,f.node);g.complete(t,true);assert(!g.consume(memory,Manager,f.node));++checks;}
 for(unsigned reason=0;reason<8;++reason){Guard g;F f=setup();switch(reason){
  case 0:put(CM+0x2708,uint8_t(1));put(f.meta+0x490,uint8_t(1));break;
  case 1:put(CM+0x26fc,uint32_t(5));put(f.meta+0x484,uint32_t(5));break;
  case 2:put(Prod+0x1a0,uint8_t(1));break;
  case 3:put(Prod+0x1488,uint32_t(2));break;
  case 4:put(CM+0xc08,uint8_t(1));break;
  case 5:put(f.meta+0x484,uint32_t(6));break;
  case 6:put(f.meta+0xb8,uint32_t(2));break;
  case 7:put(CM+0x2098,f.node+8);break;}
  assert(!g.begin(memory,CM,Pool,f.node));assert(!g.consume(memory,Manager,f.node));++checks;
 }
 for(unsigned change=0;change<6;++change){Guard g;F f=setup();auto t=g.begin(memory,CM,Pool,f.node);ready(g,f);g.complete(t,true);
  switch(change){case 0:put(f.meta+0xb8,uint32_t(2));break;case 1:put(f.node+0x90,f.mr+8);break;case 2:put(f.mr+0x40,f.meta+8);break;case 3:put(f.node+0x88,f.raw+8);break;case 4:put(Manager+0x38,Pool+8);break;case 5:put(Manager+0x48,f.node+8);break;}
  assert(!g.consume(memory,Manager,f.node));++checks;
 }
 {Guard g;F f=setup();auto t=g.begin(memory,CM,Pool,f.node);ready(g,f);g.invalidate(f.node);g.complete(t,true);setup();assert(!g.consume(memory,Manager,f.node));++checks;}
 {Guard g;F f=setup();auto t=g.begin(memory,CM,Pool,f.node);ready(g,f,0);g.complete(t,true);assert(!g.consume(memory,Manager,f.node));++checks;}
 for(unsigned reason=0;reason<5;++reason){Guard g;F f=setup();auto t=g.begin(memory,CM,Pool,f.node);put(Unlock,Pool+0xb8);put(Pool+0xa0,f.node+0x78);put(Pool+0xa8,f.node+0x78);
  switch(reason){case 0:put(f.node+0x78,f.node+0x78);break;case 1:put(f.node+0x80,f.node+8);break;case 2:put(Pool+0xa0,Base+0xe000);put(Base+0xe000,Base+0xe000);break;case 3:put(Pool+0xa0,Base+0xe000);put(Base+0xe000,uintptr_t(0));break;case 4:put(Unlock,Pool+8);break;}
  g.before_queue_unlock(memory,Unlock,Pool+0x98,f.node+0x78,1);g.complete(t,true);assert(!g.consume(memory,Manager,f.node));++checks;}
 {Guard g;F f=setup();auto t=g.begin(memory,CM,Pool,f.node);put(Unlock,Pool+0xb8);put(Pool+0xa0,Base+0xe000);put(Base+0xe000,f.node+0x78);put(Pool+0xa8,f.node+0x78);g.before_queue_unlock(memory,Unlock,Pool+0x98,f.node+0x78,1);g.complete(t,true);assert(g.consume(memory,Manager,f.node));++checks;}
 {Guard g;F f=setup();auto t=g.begin(memory,CM,Pool,f.node);ready(g,f);g.complete(t,false);assert(!g.consume(memory,Manager,f.node));++checks;}
 {Guard g;F f=setup();auto t=g.begin(memory,CM,Pool,f.node);ready(g,f);read_fail=1;assert(!g.consume(memory,Manager,f.node));read_fail=0;assert(!g.consume(memory,Manager,f.node));g.complete(t,true);++checks;}
 {Guard g;F f=setup();read_throw=1;assert(!g.begin(memory,CM,Pool,f.node));read_throw=0;auto t=g.begin(memory,CM,Pool,f.node);assert(t);ready(g,f);assert(g.consume(memory,Manager,f.node));++checks;}
 {Guard g;F f=setup();interleave=&g;assert(!g.begin(memory,CM,Pool,f.node));auto t=g.begin(memory,CM,Pool,f.node);assert(t);ready(g,f);assert(g.consume(memory,Manager,f.node));++checks;}
 {Guard g;std::vector<F>f;for(unsigned i=0;i<Guard::Capacity;++i){f.push_back(setup(i,i+1));auto t=g.begin(memory,CM,Pool,f.back().node);assert(t);ready(g,f.back());g.complete(t,true);}F extra=setup(64,65);assert(!g.begin(memory,CM,Pool,extra.node));for(auto p:f){put(Manager+0x48,p.node);assert(g.consume(memory,Manager,p.node));}assert(g.begin(memory,CM,Pool,extra.node));++checks;}
 // These call the production C++ integration wrappers, including the native
 // callback racing before the outer enqueue has returned.
 ordinary_memory01=memory;
 {F f=setup();race=1;race_accepted=false;iq4_f3_ordinary_enqueue_wrapper_01((void*)Pool,(void*)f.node,(void*)CM);assert(race_accepted&&queue_calls==1&&release_calls==1);race=0;++checks;}
 for(int stage=1;stage<=3;++stage){F f=setup();queue_throw=stage;bool thrown=false;int before=queue_calls;try{iq4_f3_ordinary_enqueue_wrapper_01((void*)Pool,(void*)f.node,(void*)CM);}catch(const std::runtime_error&){thrown=true;}assert(thrown&&queue_calls==before+1&&!ordinary_guard01.consume(memory,Manager,f.node));queue_throw=0;++checks;}
 {F f=setup();inserted=0;iq4_f3_ordinary_enqueue_wrapper_01((void*)Pool,(void*)f.node,(void*)CM);assert(!ordinary_guard01.consume(memory,Manager,f.node));inserted=1;++checks;}
 {F f=setup();put(Prod+0x1a0,uint8_t(1));int before=queue_calls;iq4_f3_ordinary_enqueue_wrapper_01((void*)Pool,(void*)f.node,(void*)CM);assert(queue_calls==before+1&&!ordinary_guard01.consume(memory,Manager,f.node));++checks;}
 {F f=setup();iq4_f3_ordinary_enqueue_wrapper_01((void*)Pool,(void*)f.node,(void*)CM);iq4_f3_ordinary_node_reset_wrapper_01((void*)f.node);setup();assert(reset_calls==1&&!ordinary_guard01.consume(memory,Manager,f.node));++checks;}
 std::printf("{\"groups\":%u,\"passed\":true,\"device_executed\":false}\n",checks);
}
