#include "../f3_native_half_01/half.h"
#include "../native_runtime_01/self_read.h"
#include "../f3_native_half_01/pins.h"
#include "trace.h"
#include <string.h>
#include <limits.h>
namespace {
using Preview=uint32_t(*)(void*,const void*,void*,void*,void*,void*,const uint8_t*);
struct Api {
 Preview preview;void (*reset)(void*);void (*destroy)(void*);
 const uint8_t* (*visible)(const void*);uint32_t (*width)(const void*);
 uint32_t (*height)(const void*);uint32_t (*stride)(const void*);uint32_t (*format)(const void*);
 int (*read)(void*,uintptr_t,void*,size_t);uint64_t (*tid)();
};
#ifdef IQ4_HALF_HOST_TEST_01
extern Api test_api;
static Api api(){return test_api;}
#else
static Api api(){return {reinterpret_cast<Preview>(0x963a28),reinterpret_cast<void(*)(void*)>(0x904550),
 reinterpret_cast<void(*)(void*)>(0x903ca8),reinterpret_cast<const uint8_t*(*)(const void*)>(0x9043c8),
 reinterpret_cast<uint32_t(*)(const void*)>(0x904448),reinterpret_cast<uint32_t(*)(const void*)>(0x904450),
 reinterpret_cast<uint32_t(*)(const void*)>(0x904468),reinterpret_cast<uint32_t(*)(const void*)>(0x9043a0),
 iq4_native_self_read_01,iq4_native_current_tid_01};}
#endif
static bool rd(const Api&a,uintptr_t p,void*b,size_t n){return p>=4096&&n&&p<=UINTPTR_MAX-n&&a.read&&a.read(nullptr,p,b,n)==1;}
template<class T>static bool get(const Api&a,uintptr_t p,T&v){return rd(a,p,&v,sizeof v);}
static bool admitted(const Api&a){
 unsigned char b[64];
 for(const auto&p:iq4_half_pins_01)for(size_t at=0;at<p.bytes;at+=4){
  const uintptr_t v=p.va+at;if(v==0x7b7ed0||v==0x91a78c||v==0x91a964||v==0x963d28||v==0x964860)continue;
  if(!rd(a,v,b,4)||memcmp(b,p.data+at,4))return false;
 }
#ifndef IQ4_HALF_HOST_TEST_01
 const uintptr_t sites[]={0x7b7ed0,0x91a78c,0x91a964};
 const uintptr_t targets[]={reinterpret_cast<uintptr_t>(iq4_half_preview_wrapper_01),reinterpret_cast<uintptr_t>(iq4_half_join_wrapper_01),reinterpret_cast<uintptr_t>(iq4_half_terminal_wrapper_01)};
 for(unsigned i=0;i<3;++i){uint32_t w;int64_t d=(int64_t)targets[i]-(int64_t)sites[i];
  if((d&3)||d<-(INT64_C(1)<<27)||d>=(INT64_C(1)<<27)||!get(a,sites[i],w)||w!=(UINT32_C(0x94000000)|((uint32_t)(d>>2)&0x3ffffff)))return false;
 }
#endif
 return true;
}
static struct Observer {
 Api a;Iq4HalfScope01 scope;uintptr_t frame,arena,output;
 uint32_t failed,terminal,joins,stages;
} observer;
static unsigned busy;
static uint64_t owner_tid;
static uint64_t current_tid(){
#ifdef IQ4_HALF_HOST_TEST_01
 return test_api.tid?test_api.tid():0;
#else
 return iq4_native_current_tid_01();
#endif
}
static bool same_thread(){const uint64_t t=__atomic_load_n(&owner_tid,__ATOMIC_ACQUIRE);return t&&current_tid()==t;}
static bool frame_matches(uintptr_t f){
 auto&o=observer;uintptr_t settings,cancel,arena,output,base,capacity;
 if(!f||!get(o.a,f+0x88,settings)||!get(o.a,f+0xb8,cancel)||!get(o.a,f+0xe8,arena)||!get(o.a,f+0x118,output)||
    settings!=o.scope.settings||cancel!=o.scope.cancel||!arena||!output||
    !get(o.a,arena+8,base)||!get(o.a,arena+16,capacity)||!base||!capacity||base>UINTPTR_MAX-capacity)return false;
 uintptr_t genbase,gencap;
 if(!get(o.a,o.scope.generator+0x1a0,genbase)||!get(o.a,o.scope.generator+0x198,gencap)||
    !genbase||!gencap||genbase>UINTPTR_MAX-gencap||base<genbase||base>genbase+gencap||capacity>genbase+gencap-base)return false;
 if((o.frame&&o.frame!=f)||(o.arena&&o.arena!=arena)||(o.output&&o.output!=output))return false;
 o.frame=f;o.arena=arena;o.output=output;return true;
}
struct SettingsRestore {
 void *s;unsigned char scale[4],format[4],planar[4],scratch[32],roi[16],cached;
 Iq4HalfRenderReceipt01 &r;bool restored=false;
 SettingsRestore(void*p,Iq4HalfRenderReceipt01&receipt):s(p),r(receipt){
  memcpy(scale,s,4);memcpy(format,(char*)s+0x20,4);memcpy(planar,(char*)s+0x30,4);
  memcpy(scratch,(char*)s+0x298,32);memcpy(roi,(char*)s+0x2b8,16);cached=*((unsigned char*)s+0x290);
 }
 void restore(){if(restored)return;memcpy(s,scale,4);memcpy((char*)s+0x20,format,4);memcpy((char*)s+0x30,planar,4);
  memcpy((char*)s+0x298,scratch,32);memcpy((char*)s+0x2b8,roi,16);*((unsigned char*)s+0x290)=cached;
  restored=true;r.settings_restored=1;
 }
 ~SettingsRestore(){restore();}
};
struct Cib {
 Api a;alignas(16)unsigned char body[0x58];
 explicit Cib(const Api&v):a(v){a.reset(body);}~Cib(){a.destroy(body);}
};
static uint32_t stock(const Api&a,const uintptr_t x[7]){
 return a.preview((void*)x[0],(const void*)x[1],(void*)x[2],(void*)x[3],(void*)x[4],(void*)x[5],(const uint8_t*)x[6]);
}
static bool scope_from(const Api&a,const uintptr_t x[7],uintptr_t sp,Iq4HalfScope01&s,uint32_t&reason){
 s={};reason=IQ4_HALF_ENTRY_ABI58;
 if(!x||x[0]<0x1000+0x2d8||!sp)return false;
 s={};s.generator=x[0];s.worker=x[0]-0x2d8;s.raw_input=x[1];s.settings=x[4];s.pool=x[5];s.cancel=x[6];
 uintptr_t vt,cancel;float w,h;uint8_t cancelled;uint32_t rotation;
 /* Capture only the actual native request identity before any rejection.
  * The runtime records it only under same-worker/node + ARMED CAS admission. */
 if(!get(a,sp+0x428,s.photo_index)||!get(a,sp+0x458,s.node)||!s.node)return false;
 if(x[4]!=sp+0x138||s.photo_index<0||s.raw_input!=s.worker+UINT64_C(0x65547968)||s.pool!=s.worker+0x2c0||
    !get(a,s.worker,vt)||vt!=0xd854c8||!get(a,sp+0x460,cancel)||cancel!=s.cancel||
    !get(a,s.settings+4,w)||!get(a,s.settings+8,h))return false;
 if(w!=14204.0f||h!=10652.0f){reason=IQ4_HALF_ENTRY_GEOMETRY58;return false;}
 if(!get(a,s.settings+12,rotation))return false;
 if(rotation&0x7fffffff){reason=IQ4_HALF_ENTRY_ROTATION58;return false;}
 if(!get(a,s.cancel,cancelled))return false;
 if(cancelled){reason=IQ4_HALF_ENTRY_CANCEL58;return false;}
 s.full_width=14204;s.full_height=10652;reason=0;return true;
}
static Iq4HalfRenderStatus01 render(const Api&a,const Iq4HalfScope01&s,const Iq4HalfLease01&lease,Iq4HalfRenderReceipt01&r){
 if(!lease.guard||!lease.encode||!lease.finish||lease.guard(lease.context,&s)!=1)return IQ4_HALF_RENDER_CANCELLED_01;
 uint8_t c;if(!get(a,s.cancel,c)||c)return IQ4_HALF_RENDER_CANCELLED_01;
 SettingsRestore restore((void*)s.settings,r);
 Cib main(a);
 const float scale=.5f;const uint32_t fmt=5,planar=0,roi[4]={0,0,s.full_width,s.full_height};
 memcpy((void*)s.settings,&scale,4);memcpy((void*)(s.settings+0x20),&fmt,4);memcpy((void*)(s.settings+0x30),&planar,4);
 memcpy((void*)(s.settings+0x2b8),roi,16);
 observer={};observer.a=a;observer.scope=s;const uint64_t t=current_tid();
 if(!t)return IQ4_HALF_RENDER_UNBOUND_01;
 __atomic_store_n(&owner_tid,t,__ATOMIC_RELEASE);
 struct Retire {~Retire(){__atomic_store_n(&owner_tid,UINT64_C(0),__ATOMIC_RELEASE);}} retire;
 r.entered=1;
 r.render_returned=a.preview((void*)s.generator,(const void*)s.raw_input,main.body,nullptr,(void*)s.settings,(void*)s.pool,(const uint8_t*)s.cancel);
 r.stages=observer.stages;r.joins=observer.joins;r.terminal=observer.terminal;
 if(observer.failed||!observer.terminal||!observer.stages||observer.joins!=observer.stages||r.render_returned!=1)return IQ4_HALF_RENDER_INCOMPLETE_01;
 if(!get(a,s.cancel,c)||c||lease.guard(lease.context,&s)!=1)return IQ4_HALF_RENDER_CANCELLED_01;
 Iq4HalfArgb01 p={a.visible(main.body),0,a.stride(main.body),a.width(main.body),a.height(main.body),a.format(main.body)};
 if(!p.visible||p.width!=7102||p.height!=5326||p.format!=5||p.stride<(uint64_t)p.width*4)return IQ4_HALF_RENDER_PLANE_01;
 uintptr_t genbase,gencap;const uint64_t span=(uint64_t)(p.height-1)*p.stride+(uint64_t)p.width*4;
 if(!get(a,s.generator+0x1a0,genbase)||!get(a,s.generator+0x198,gencap)||genbase>UINTPTR_MAX-gencap||
    span>SIZE_MAX||(uintptr_t)p.visible<genbase||(uintptr_t)p.visible>genbase+gencap||span>genbase+gencap-(uintptr_t)p.visible)return IQ4_HALF_RENDER_PLANE_01;
 p.bytes=(size_t)span;r.width=p.width;r.height=p.height;r.stride=(uint32_t)p.stride;r.format=p.format;r.native_buffer_bytes=p.bytes;
 /* The synchronous encoder consumes rows while every original owner is alive.
  * Its callback contract forbids retaining/resuming any borrowed plane read. */
 r.status=IQ4_HALF_RENDER_OK_01;
 if(lease.encode(lease.context,&s,&p,&r)!=1)return IQ4_HALF_RENDER_SINK_01;
 restore.restore();return IQ4_HALF_RENDER_OK_01;
}
}
extern "C" uint32_t iq4_half_preview_on_worker_01(const uintptr_t x[7],uintptr_t sp){
 const Api a=api();Iq4HalfScope01 scope;Iq4HalfLease01 lease={};
 uint32_t reason;
 if(!scope_from(a,x,sp,scope,reason)){
  (void)iq4_stock_half_entry_trace_58(scope.worker,scope.node,scope.photo_index,reason);return stock(a,x);
 }
 if(!admitted(a)){
  (void)iq4_stock_half_entry_trace_58(scope.worker,scope.node,scope.photo_index,IQ4_HALF_ENTRY_PINS58);return stock(a,x);
 }
 if(__atomic_exchange_n(&busy,1u,__ATOMIC_ACQUIRE)){
  (void)iq4_stock_half_entry_trace_58(scope.worker,scope.node,scope.photo_index,IQ4_HALF_ENTRY_BUSY58);return stock(a,x);
 }
 struct Unlock {~Unlock(){__atomic_store_n(&owner_tid,UINT64_C(0),__ATOMIC_RELEASE);__atomic_store_n(&busy,0u,__ATOMIC_RELEASE);}} unlock;
 (void)iq4_stock_half_entry_trace_58(scope.worker,scope.node,scope.photo_index,0);
 if(iq4_stock_half_acquire_01(&scope,&lease)!=1)return stock(a,x);
 Iq4HalfRenderReceipt01 receipt={};receipt.status=IQ4_HALF_RENDER_ARGUMENT_01;
 try {receipt.status=render(a,scope,lease,receipt);}
 catch(...){receipt.status=IQ4_HALF_RENDER_EXCEPTION_01;__atomic_store_n(&owner_tid,UINT64_C(0),__ATOMIC_RELEASE);
  /* Preserve original factory exception/unwind behavior. Never run another
   * render against possibly outstanding workers or publish a truthy return. */
  if(lease.finish)lease.finish(lease.context,&scope,&receipt);throw;
 }
 __atomic_store_n(&owner_tid,UINT64_C(0),__ATOMIC_RELEASE);if(lease.finish)lease.finish(lease.context,&scope,&receipt);
 /* The original shared-IFM 4K preview executes exactly once with its original
  * arguments and Settings. Half pixels never reach its conversion/write. */
 return stock(a,x);
}
extern "C" void iq4_half_join_observed_01(uintptr_t f,uintptr_t pool,uintptr_t pc){
 if(!same_thread())return;auto&o=observer;uint32_t stage,threads,total;
 if(o.failed||pc!=0x91a790||pool!=o.scope.pool||!frame_matches(f)||!get(o.a,f+0xf0,stage)||
    !get(o.a,f+0xb4,threads)||!get(o.a,f+0x130,total)||!threads||threads>1024||
    !total||total>32||stage!=o.joins||stage>=total){o.failed=1;return;}
 ++o.joins;
}
extern "C" void iq4_half_terminal_observed_01(uintptr_t f,uintptr_t pc){
 if(!same_thread())return;auto&o=observer;uint32_t done,total;uint8_t c;
 if(o.failed||o.terminal||pc!=0x91a968||!frame_matches(f)||!get(o.a,f+0xf0,done)||!get(o.a,f+0x130,total)||
    !get(o.a,o.scope.cancel,c)||c||!total||total>32||done!=total||done!=o.joins){o.failed=1;return;}
 o.stages=total;o.terminal=1;
}
