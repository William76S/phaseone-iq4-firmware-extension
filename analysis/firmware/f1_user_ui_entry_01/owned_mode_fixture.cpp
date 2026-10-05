#include "state.h"
#include <cassert>
#include <cstdint>
#include <stdexcept>
#include <atomic>
namespace iq4::f1::entry10 {enum class Phase:unsigned {Disabled,Bound,Building,Ready,Open,AwaitingStockPaint,Detaching,DetachedRetained,Hold};}
struct Status{unsigned phase=3;};
struct Native {void*context{};std::uintptr_t(*current_thread)(void*){};void(*invalidate)(void*,bool){};};
static unsigned calls=0;static bool fail=false;static std::uintptr_t actual_queue=0x1000;
static std::uintptr_t current(void*){return actual_queue;}
static void invalidate(void*p,bool force){assert(p==(void*)0x2000&&!force);++calls;if(fail)throw std::runtime_error("owned invalidation fault");}
struct Binding {Status status{};Status status_on_ui(){return status;}Native persistent_ports_on_ui(){return status.phase==8||status.phase==7?Native{}:Native{nullptr,current,invalidate};}};
static Binding owned;static Binding*binding=&owned;static std::atomic<bool>initialized{true},bound{true};
static std::uintptr_t current_queue(){return actual_queue;}
Iq4F1FirmwareState01 iq4_f1_state_01={1,64,0,3,3,0,1,0,0x1000,0x3000,0x2000,0};
static void reject(unsigned code){iq4_f1_state_01.last_failure=code;}
extern "C" unsigned iq4_f1_mode_get_01(){
 if(!initialized.load(std::memory_order_acquire)||!bound.load(std::memory_order_acquire)||!binding)return 0;
 try{if(current_queue()!=iq4_f1_state_01.queue)return 0;}catch(...){return 0;}
 const auto phase=binding->status_on_ui().phase;
 if(phase==static_cast<unsigned>(iq4::f1::entry10::Phase::Hold)||phase==static_cast<unsigned>(iq4::f1::entry10::Phase::DetachedRetained))return 0;
 const auto mode=__atomic_load_n(&iq4_f1_state_01.requested_mode,__ATOMIC_ACQUIRE);return mode<=4?mode:0;
}
extern "C" int iq4_f1_mode_set_on_ui_01(unsigned mode){
 if(mode>4||!initialized.load(std::memory_order_acquire)||!bound.load(std::memory_order_acquire)||!binding)return 0;
 try{if(current_queue()!=iq4_f1_state_01.queue)return 0;}catch(...){return 0;}
 const auto native=binding->persistent_ports_on_ui();
 if(!native.current_thread||!native.invalidate||native.current_thread(native.context)!=iq4_f1_state_01.queue)return 0;
 const auto old=iq4_f1_state_01.requested_mode;
 __atomic_store_n(&iq4_f1_state_01.requested_mode,mode,__ATOMIC_RELEASE);
 try{native.invalidate(reinterpret_cast<void*>(iq4_f1_state_01.lv),false);}
 catch(...){__atomic_store_n(&iq4_f1_state_01.requested_mode,old,__ATOMIC_RELEASE);reject(30);return 0;}
 if(iq4_f1_state_01.request_generation!=UINT64_MAX)++iq4_f1_state_01.request_generation;
 return 1; // Requested mode + original full-LV invalidation only; no paint ACK.
}
extern "C" int iq4_f1_firmware_disable_on_ui_01(){return iq4_f1_mode_set_on_ui_01(0);}
extern "C" const Iq4F1FirmwareState01*iq4_f1_state_readonly_01(){return &iq4_f1_state_01;}
int main(){
 assert(iq4_f1_mode_get_01()==0);
 for(unsigned m=0;m<=4;++m){assert(iq4_f1_mode_set_on_ui_01(m)==1);assert(iq4_f1_mode_get_01()==m);}assert(calls==5&&iq4_f1_state_01.request_generation==5);
 assert(iq4_f1_mode_set_on_ui_01(5)==0&&calls==5);
 actual_queue=0x4000;assert(iq4_f1_mode_set_on_ui_01(2)==0&&calls==5);actual_queue=0x1000;
 fail=true;assert(iq4_f1_mode_set_on_ui_01(2)==0&&iq4_f1_mode_get_01()==4&&iq4_f1_state_01.request_generation==5);fail=false;
 owned.status.phase=8;assert(iq4_f1_mode_get_01()==0&&iq4_f1_mode_set_on_ui_01(1)==0);owned.status.phase=3;
 assert(iq4_f1_firmware_disable_on_ui_01()==1&&iq4_f1_mode_get_01()==0&&iq4_f1_state_01.request_generation==6);
 bound=false;assert(iq4_f1_mode_set_on_ui_01(1)==0&&iq4_f1_mode_get_01()==0);
}
