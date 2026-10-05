#include "state.h"
#include "entry_binding_10.hpp"
#include "stock_windows.hpp"
#include "../f4_ui_bootstrap_02/sha256.h"
#include <elf.h>
#include <fcntl.h>
#include <pthread.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <unistd.h>
#include <atomic>
#include <cerrno>
#include <cstring>
#include <new>
#if !defined(__aarch64__)||!defined(__linux__)
#error firmware fixed User AArch64 source; compile only on host
#endif
extern "C" int iq4_stock_pthread_mutex_unlock_01(void*);
extern "C" Iq4F1FirmwareState01 iq4_f1_state_01={1,sizeof(Iq4F1FirmwareState01),0,0,0,0,0,0,0,0,0,0};
namespace {
using namespace iq4::f1::entry01;
using Binding=iq4::f1::entry10::Binding;
std::atomic<Address> original_unlock{},original_try_lock{};
int memory_fd=-1;std::atomic<bool>initialized{false},bound{false};bool image_verified{},mapped_verified{},pthread_verified{};
std::atomic_flag inside=ATOMIC_FLAG_INIT;
alignas(Module) unsigned char module_storage[sizeof(Module)]{};Module*module{};
alignas(Binding) unsigned char binding_storage[sizeof(Binding)]{};Binding*binding{};
std::uint64_t boundaries{};
#include "native_helpers.inc"
bool read_self(void*,Address a,void*p,std::size_t n)noexcept{return n<=4096&&pread_all(memory_fd,p,n,a);}
void reject(unsigned code)noexcept{iq4_f1_state_01.last_failure=code;}
bool hash_memory(Address a,std::uint64_t n,const char*wanted)noexcept{
 F4Sha sha;f4_sha_init(&sha);unsigned char block[4096];
 for(std::uint64_t k=0;k<n;){const auto z=static_cast<std::size_t>(n-k>sizeof block?sizeof block:n-k);if(!pread_all(memory_fd,block,z,a+k))return false;f4_sha_update(&sha,block,z);k+=z;}
 char actual[65];f4_sha_end(&sha,actual);return !std::strcmp(actual,wanted);
}
bool immutable_image()noexcept{
 // Candidate differs from stock at three explicit BLs and header metadata.
 // Every other original RX byte must match immutable stock exactly.
 for(const auto&w:StockCodeWindows01)if(!hash_memory(w.va,w.bytes,w.sha))return false;
 int fd=ropen("/proc/self/exe");struct stat st{};if(fd<0)return false;
 bool ok=raw_call(SYS_fstat,fd,reinterpret_cast<long>(&st))==0&&S_ISREG(st.st_mode);
 int maps=ropen("/proc/self/maps");char text[65536],extra{};
 long n=maps<0?-1:raw_call(SYS_read,maps,reinterpret_cast<long>(text),sizeof text-1);
 long tail=maps<0?-1:raw_call(SYS_read,maps,reinterpret_cast<long>(&extra),1);rclose(maps);
 if(n<=0||tail!=0)ok=false;else text[n]=0;
 if(ok)for(const auto&w:StockCodeWindows01){
  Address cursor=w.va,end=w.va+w.bytes;
  while(cursor<end){bool found=false;
   for(char*line=text;*line;){char*nl=std::strchr(line,'\n');if(!nl){ok=false;break;}*nl=0;Mapping m{};const bool parsed=mapping(line,m);*nl='\n';
    if(parsed&&m.begin<=cursor&&cursor<m.end&&same_inode(m,st)&&m.permissions[0]=='r'&&m.permissions[1]=='-'&&m.permissions[2]=='x'&&m.offset+cursor-m.begin==cursor-0x400000){cursor=m.end<end?m.end:end;found=true;break;}line=nl+1;
   }if(!ok||!found){ok=false;break;}
  }if(!ok)break;
 }
 rclose(fd);return ok;
}
bool source_matches(const Owner&o)noexcept{
 // Actual ctor return receipt and live queue/manager/LV graph must agree.
 Address vt{},manager{};
 return iq4_f1_state_01.ctor_count==1&&iq4_f1_state_01.lv==o.lv&&iq4_f1_state_01.manager==o.manager&&
  read_self(nullptr,o.lv,&vt,8)&&vt==0xb9a9d8&&read_self(nullptr,o.lv+0xb0,&manager,8)&&manager==o.manager;
}
bool free_placement(const Owner&o,iq4::f1::entry10::Placement&out)noexcept{
 Inspector p({nullptr,read_self},0);Rectangle24 bounds{};
 if(!p.read(o.lv+0x28,&bounds,sizeof bounds)||bounds.address_point!=0xb73b98||bounds.width<128||bounds.height<128||bounds.width>8192||bounds.height>8192)return false;
 struct Occupied {Rectangle24 r;};Occupied boxes[512]{};unsigned count=0;Address first{},node{},previous{};
 if(!p.word(o.lv+0x10,first))return false;node=first;Address seen[512]{};
 while(node){
  if(count==512||node<4096||(node&7))return false;for(unsigned i=0;i<count;++i)if(seen[i]==node)return false;seen[count]=node;
  Address parent{},prev{},next{};Rectangle24 r{};unsigned char visible{};
  if(!p.word(node+8,parent)||parent!=o.lv||!p.word(node+0x18,prev)||prev!=previous||!p.word(node+0x20,next)||!p.read(node+0x28,&r,sizeof r)||r.address_point!=0xb73b98||r.width<0||r.height<0||!p.read(node+0x6f,&visible,1)||visible>1)return false;
  boxes[count++].r=visible?r:Rectangle24{};previous=node;node=next;
 }
 Address again{};if(!p.word(o.lv+0x10,again)||again!=first)return false;
 for(int y=0;y<=bounds.height-128;y+=128)for(int x=0;x<=bounds.width-128;x+=128){
  bool vacant=true;for(unsigned i=0;i<count;++i){const auto&r=boxes[i].r;if(r.width>0&&r.height>0&&std::int64_t(r.x)<x+128&&std::int64_t(r.y)<y+128&&std::int64_t(r.x)+r.width>x&&std::int64_t(r.y)+r.height>y){vacant=false;break;}}
  if(vacant){out={x,y};return true;}
 }
 return false;
}
bool select(void*,iq4::MaskMode mode,std::uint64_t)noexcept{return iq4_f1_mode_set_on_ui_01(static_cast<unsigned>(mode))==1;}
Address current_queue(){return reinterpret_cast<Address>(reinterpret_cast<void*(*)()>(0x710b0c)());}
void after_unlock(const BoundaryInput&input)noexcept{
 if(!initialized||!module||!binding||input.caller_pc!=0x6be8ac||input.original_result||iq4_f1_state_01.ui_phase==static_cast<unsigned>(iq4::f1::entry10::Phase::Hold))return;
 if(inside.test_and_set(std::memory_order_acquire))return;
 module->after_unlock(input);
 if(!bound){
  Observation o{};if(!module->snapshot(o)||!o.qualified_boundaries){reject(10);inside.clear(std::memory_order_release);return;}
  const auto&owner=module->observed_owner();iq4::f1::entry10::Placement placement{};
  if(!source_matches(owner)||!free_placement(owner,placement)){reject(11);inside.clear(std::memory_order_release);return;}
  std::uint32_t kind{};Address threads{};
  const bool mutex_source=read_self(nullptr,0xf553d0,&kind,4)&&kind==1&&read_self(nullptr,0xf553a8,&threads,8)&&threads;
  const auto lock=reinterpret_cast<int(*)(void*)>(original_try_lock.load(std::memory_order_acquire));
  const auto unlock=reinterpret_cast<int(*)(void*)>(original_unlock.load(std::memory_order_acquire));
  const bool held=mutex_source&&lock&&unlock&&lock(reinterpret_cast<void*>(0xf553c0))==0;
  if(!held){reject(12);inside.clear(std::memory_order_release);return;}
  const iq4::f1::entry10::Admission admission{image_verified&&mapped_verified&&pthread_verified,held,initialized,initialized};
  const bool configured=binding->bind_on_actual_boundary({nullptr,read_self},*module,input,admission,placement,{nullptr,select},{lock,unlock});
  const bool built=configured&&binding->build_on_ui();
  const bool released=unlock(reinterpret_cast<void*>(0xf553c0))==0;
  if(!built||!released){reject(13);iq4_f1_state_01.ui_phase=static_cast<unsigned>(iq4::f1::entry10::Phase::Hold);inside.clear(std::memory_order_release);return;}
  iq4_f1_state_01.queue=owner.queue;bound=true;
 }
 if(boundaries!=UINT64_MAX)(void)binding->after_actual_boundary(input,++boundaries);
 iq4_f1_state_01.ui_phase=binding->status_on_ui().phase;
 inside.clear(std::memory_order_release);
}
}
extern "C" void iq4_f1_publish_ctor_on_return_01(uintptr_t lv,uintptr_t manager,uintptr_t pc){
 if(pc!=0x4eef30||lv<4096||manager<4096)return;
 // Only source pointers are retained. No native constructor/owner getter here.
 if(iq4_f1_state_01.ctor_count==UINT32_MAX)return;
 ++iq4_f1_state_01.ctor_count;
 if(iq4_f1_state_01.ctor_count==1){iq4_f1_state_01.lv=lv;iq4_f1_state_01.manager=manager;}else reject(20);
}
extern "C" void iq4_f1_firmware_initialize_01(){
 const int saved=errno;if(initialized){errno=saved;return;}
 iq4_f1_state_01.requested_mode=0;iq4_f1_state_01.startup=1;
 memory_fd=ropen("/proc/self/mem");
 image_verified=memory_fd>=0&&immutable_image();mapped_verified=image_verified;
 pthread_verified=image_verified&&resolve_original();
 if(!image_verified||!pthread_verified){iq4_f1_state_01.startup=2;reject(1);rclose(memory_fd);memory_fd=-1;errno=saved;return;}
 module=new(module_storage)Module;binding=new(binding_storage)Binding;
 if(!module->configure({nullptr,read_self},{image_verified,image_verified,mapped_verified,pthread_verified,0},reinterpret_cast<int(*)(void*)>(original_try_lock.load()),reinterpret_cast<int(*)(void*)>(original_unlock.load()))){iq4_f1_state_01.startup=2;reject(2);errno=saved;return;}
 initialized=true;iq4_f1_state_01.startup=3;errno=saved;
}
extern "C" __attribute__((noinline)) int iq4_f1_firmware_unlock_01(pthread_mutex_t*mutex){
 const int incoming=errno;
 const auto caller=reinterpret_cast<Address>(__builtin_return_address(0));
 errno=incoming;const int result=iq4_stock_pthread_mutex_unlock_01(mutex);const int saved=errno;
 if(result==0&&caller==0x6be8ac){Address tp{};asm volatile("mrs %0,tpidr_el0":"=r"(tp));after_unlock({caller,reinterpret_cast<Address>(__builtin_frame_address(0)),tp,reinterpret_cast<Address>(mutex),result});}
 errno=saved;return result;
}
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
