#define IQ4_HALF_HOST_TEST_01 1
#include "bridge.cpp"
#include <cassert>
#include <cstdio>
#include <stdexcept>
#include <thread>
#include <vector>
namespace {
Api test_api;
static thread_local uint64_t thread_id=1;
static uint64_t tid(){return thread_id;}
static int variant;
static int read(void*,uintptr_t p,void*b,size_t n){
 for(const auto&r:iq4_half_pins_01)if(p>=r.va&&p+n<=r.va+r.bytes){memcpy(b,r.data+p-r.va,n);if(variant==15&&p==iq4_half_pins_01[0].va)((unsigned char*)b)[0]^=1;return 1;}
 if(variant==15&&p==iq4_half_pins_01[0].va){((unsigned char*)b)[0]^=1;return 1;}
 if(p<0x10000000)return 0;memcpy(b,(const void*)p,n);return 1;
}
template<class T>static void put(void*p,size_t off,T v){memcpy((char*)p+off,&v,sizeof v);}
template<class T>static T val(const void*p,size_t off){T v;memcpy(&v,(const char*)p+off,sizeof v);return v;}
static uint32_t width(const void*p){return val<uint32_t>(p,0x14);}static uint32_t height(const void*p){return val<uint32_t>(p,0x18);}
static uint32_t stride(const void*p){return val<uint32_t>(p,0x24);}static uint32_t format(const void*p){return val<uint32_t>(p,0x1c);}
static const uint8_t*visible(const void*p){return (const uint8_t*)val<uintptr_t>(p,0x28);}
static unsigned destroyed,stock_calls,half_calls,sink_calls,finished;static bool claimed=true;
static unsigned trace_calls;static uint32_t trace_reason;static Iq4HalfRenderReceipt01 receipt;static unsigned char snapshot[0x2c8];static uintptr_t spv;
static void reset(void*p){memset(p,0,0x58);}static void destroy(void*){++destroyed;}
static int guard(void*,const Iq4HalfScope01*){return variant==8?0:1;}
static int encode(void*,const Iq4HalfScope01*,const Iq4HalfArgb01*p,const Iq4HalfRenderReceipt01*r){
 ++sink_calls;assert(p->width==7102&&p->height==5326&&p->stride==28416&&p->format==5&&p->bytes==151343608);
 assert(r->terminal&&r->joins==3&&r->stages==3&&r->render_returned==1);
 return variant==9?0:1;
}
static void finish(void*,const Iq4HalfScope01*s,const Iq4HalfRenderReceipt01*r){++finished;receipt=*r;
 assert(!memcmp((const void*)s->settings,snapshot,sizeof snapshot));assert(__atomic_load_n(&owner_tid,__ATOMIC_ACQUIRE)==0);
}
static uint32_t preview(void*gen,const void*,void*out,void*secondary,void*s,void*pool,const uint8_t*cancel){
 if(val<float>(s,0)!=.5f){++stock_calls;assert(secondary==(void*)(spv+0x88));assert(!memcmp(s,snapshot,sizeof snapshot));return 0x55;}
 ++half_calls;assert(!secondary);assert(val<uint32_t>(s,0x30)==0&&val<uint32_t>(s,0x20)==5);
 assert(val<uint32_t>(s,0x2b8)==0&&val<uint32_t>(s,0x2bc)==0&&val<uint32_t>(s,0x2c0)==14204&&val<uint32_t>(s,0x2c4)==10652);
 assert(!memcmp((char*)s+0x40,snapshot+0x40,0x250));
 if(variant==10)throw std::runtime_error("native fixture exception");
 if(variant==1)return 1; // Truthy native return without pixels/completion.
 alignas(16)unsigned char frame[0x400]={},arena[0x40]={};
 put(arena,8,val<uintptr_t>(gen,0x1a0)+302687232);put(arena,16,uintptr_t(609573888));
 put(frame,0x88,(uintptr_t)s);put(frame,0xb8,(uintptr_t)cancel);put(frame,0xe8,(uintptr_t)arena);put(frame,0x118,(uintptr_t)out);
 put(frame,0xb4,uint32_t(3));put(frame,0x130,uint32_t(3));
 for(unsigned n=0;n<3;++n){put(frame,0xf0,n);
  if(variant==2&&n==1)continue;
  if(variant==3&&n==0){std::thread t([&]{thread_id=2;iq4_half_join_observed_01((uintptr_t)frame,(uintptr_t)pool,0x91a790);});t.join();continue;}
  iq4_half_join_observed_01((uintptr_t)frame,(uintptr_t)pool+(variant==4?16:0),0x91a790);
  if(variant==5&&n==0)iq4_half_join_observed_01((uintptr_t)frame,(uintptr_t)pool,0x91a790);
 }
 put(frame,0xf0,uint32_t(variant==6?2:3));iq4_half_terminal_observed_01((uintptr_t)frame,0x91a968);
 put(out,0x14,uint32_t(variant==7?3840:7102));put(out,0x18,uint32_t(5326));put(out,0x1c,uint32_t(5));put(out,0x24,uint32_t(28416));
 put(out,0x28,val<uintptr_t>(gen,0x1a0)+302687232);put(out,0x30,uint32_t(151343616));
 put(s,0x298,uint64_t(0x12345));put(s,0x290,uint8_t(1));return 1;
}
static void run(int v,bool take=true){
 trace_calls=trace_reason=0;
 variant=v;claimed=take;stock_calls=half_calls=sink_calls=finished=destroyed=0;receipt={};
 std::vector<unsigned char>w(0x600),stack(0x900);spv=(uintptr_t)stack.data();uintptr_t wk=(uintptr_t)w.data(),gen=wk+0x2d8,s=spv+0x138;
 memset((void*)s,0xa5,sizeof snapshot);put((void*)s,0,float(.271f));put((void*)s,4,float(14204));put((void*)s,8,float(10652));put((void*)s,12,uint32_t(0));
 memcpy(snapshot,(void*)s,sizeof snapshot);put((void*)wk,0,uintptr_t(0xd854c8));put((void*)gen,0x198,uintptr_t(912261120));put((void*)gen,0x1a0,uintptr_t(0x40000000));
 uint8_t c=0;put((void*)spv,0x460,(uintptr_t)&c);put((void*)spv,0x428,int32_t(12));put((void*)spv,0x438,wk+0x510);put((void*)spv,0x458,wk+0x500);
 uintptr_t x[7]={gen,wk+UINT64_C(0x65547968),spv+0xe0,spv+0x88,s,wk+0x2c0,(uintptr_t)&c};
 if(v==11){put((void*)s,12,uint32_t(0x42b40000));memcpy(snapshot,(void*)s,sizeof snapshot);}
 if(v==12){put((void*)s,4,float(100));memcpy(snapshot,(void*)s,sizeof snapshot);}
 if(v==13)c=1;
 if(v==14)put((void*)wk,0,uintptr_t(0));
 if(v==16)busy=1;
 bool thrown=false;try{assert(iq4_half_preview_on_worker_01(x,spv)==0x55);}catch(const std::runtime_error&){thrown=true;}
 assert(!memcmp((void*)s,snapshot,sizeof snapshot));assert((v==16?busy==1:busy==0)&&!__atomic_load_n(&owner_tid,__ATOMIC_ACQUIRE));if(v==16)busy=0;
 if(!take||v>=11){assert(stock_calls==1&&!half_calls&&!finished&&!sink_calls);
  const uint32_t reasons[]={IQ4_HALF_ENTRY_ROTATION58,IQ4_HALF_ENTRY_GEOMETRY58,IQ4_HALF_ENTRY_CANCEL58,IQ4_HALF_ENTRY_ABI58,IQ4_HALF_ENTRY_PINS58,IQ4_HALF_ENTRY_BUSY58};
  assert(trace_calls==1&&trace_reason==(v>=11?reasons[v-11]:0));return;}
 if(v==8){assert(!half_calls&&finished==1&&!destroyed&&stock_calls==1&&receipt.status==IQ4_HALF_RENDER_CANCELLED_01);return;}
 assert(half_calls==1&&finished==1&&destroyed==1);
 if(v==10){assert(thrown&&!stock_calls&&receipt.status==IQ4_HALF_RENDER_EXCEPTION_01);return;}
 assert(!thrown&&stock_calls==1&&receipt.settings_restored==1);
 if(v==0){assert(receipt.status==IQ4_HALF_RENDER_OK_01&&sink_calls==1);}else assert(receipt.status!=IQ4_HALF_RENDER_OK_01);
 if(v>=1&&v<=7)assert(!sink_calls);
}
}
extern "C" int iq4_stock_half_acquire_01(const Iq4HalfScope01*s,Iq4HalfLease01*l){assert(s->photo_index==12&&s->node==s->worker+0x500);if(!claimed)return 0;*l={nullptr,guard,encode,finish};return 1;}
extern "C" int iq4_stock_half_entry_trace_58(uintptr_t worker,uintptr_t node,int32_t uid,uint32_t reason){
 assert(worker&&node==worker+0x500&&uid==12);++trace_calls;trace_reason=reason;return 1;
}
int main(){test_api={preview,reset,destroy,visible,width,height,stride,format,read,tid};for(int i=0;i<=16;++i)run(i);run(0,false);puts("18 focused entry/stock-preservation cases passed");}
