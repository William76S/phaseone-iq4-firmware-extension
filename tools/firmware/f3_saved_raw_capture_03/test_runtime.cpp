#define _GNU_SOURCE
#include "capture03.h"
#include "../f3_native_executor_03/saved_capture_contract.h"
#include <cassert>
#include <cstring>
#include <cstdio>
#include <cstdlib>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <stdarg.h>
#include <sys/syscall.h>
#include <time.h>
#include <errno.h>
static unsigned scenario,stores,close_calls,actual_closes,dtor_calls,saved_calls;static F3Card05 card;
static unsigned char fs[512] __attribute__((aligned(8))), storage[0x528] __attribute__((aligned(8))), manager[0x80] __attribute__((aligned(8))), ctx[0x1400] __attribute__((aligned(8)));
static uintptr_t entries[1];static char path[64]="DCIM/100PHASE/P0000001.IIQ";static uintptr_t node=0x12345678;
static uint64_t tid=777;static uintptr_t retired_file;static void(*clock_hook)();static int held_writer=-1;static F3Posix files;
extern "C" void f3_fs_host_api_03(F3Posix*);
extern "C" bool iq4_f3_xqd_open_wrapper_03(void*,void*,const char*,bool,bool,bool,bool(*)(void*,void*,const char*,bool,bool,bool));
extern "C" void iq4_f3_xqd_dtor_wrapper_03(void*);
extern "C" bool iq4_f3_xqd_store_wrapper_03(void*,void*,const char*);
extern "C" bool iq4_f3_fanout_select_wrapper_03(void*,uint32_t);
extern "C" void iq4_f3_fanout_refs_wrapper_03(void*,void*,uint8_t);
extern "C" uint64_t iq4_f3_original_pthread_self_capture_01(){return tid;}
extern "C" long iq4_f3_original_syscall_03(long n,...){va_list a;va_start(a,n);long r=-1;if(n==113){if(clock_hook){auto h=clock_hook;clock_hook=nullptr;h();}int id=va_arg(a,int);auto*t=va_arg(a,timespec*);assert(id==1);r=clock_gettime(CLOCK_MONOTONIC,t);}else if(n==101){auto*t=va_arg(a,timespec*);auto*u=va_arg(a,timespec*);r=nanosleep(t,u);}va_end(a);return r;}
extern "C" void iq4_f3_original_file_bind_capture_01(void*f,void*p,int fd,bool){uintptr_t vt=0xd90410;std::memcpy(p,&vt,8);std::memcpy((char*)p+8,&f,8);std::memcpy((char*)p+16,&fd,4);((char*)p)[20]=1;((char*)p)[21]=0;held_writer=fd;}
extern "C" bool iq4_f3_original_file_close_capture_03(void*p){++close_calls;if(!((char*)p)[20])return false;((char*)p)[20]=0;int fd;std::memcpy(&fd,(char*)p+16,4);if(scenario==2)return false;if(scenario==3)throw 88;assert(!fsync(fd)&&!close(fd));++actual_closes;held_writer=-1;return true;}
extern "C" void iq4_f3_original_file_dtor_capture_03(void*p){++dtor_calls;(void)iq4_f3_original_file_close_capture_03(p);}
extern "C" bool iq4_f3_original_writer_close_capture_01(void*){return false;}
extern "C" bool iq4_f3_original_fanout_select_capture_03(void*,uint32_t){return true;}
extern "C" void iq4_f3_original_fanout_refs_capture_03(void*,void*,uint8_t){}
extern "C" int f3_card_valid_05(F3Card05*c){return c&&c->state==2&&!c->hold;}
extern "C" void f3_card_hold_05(F3Card05*c){if(c){c->hold=1;c->state=4;}}
extern "C" F3CardOutcome05 f3_card_finish_05(F3Card05*c){if(!f3_card_valid_05(c))return F3_CARD_UNKNOWN;c->state=3;return F3_CARD_OK;}
namespace iq4::source_dependencies_01 {
Result snapshot_from_raw_manager(Memory,uintptr_t m,uintptr_t n,Snapshot&s)noexcept{if(!m||!n)return Result::InvalidOwner;s.ifm=m;s.original_reader=n;return Result::Ok;}
Result recheck(Memory,const Snapshot&s)noexcept{return s.ifm==uintptr_t(manager)&&s.original_reader==node?Result::Ok:Result::InvalidOwner;}
}
static int memory(void*,uintptr_t p,void*out,size_t n){if(!p||!out||!n)return 0;assert(!retired_file||p+n<=retired_file||p>=retired_file+32);std::memcpy(out,(void*)p,n);return 1;}
static F3SysResult child(int d,const char*p){int f=openat(d,p,O_RDONLY|O_DIRECTORY|O_NOFOLLOW|O_CLOEXEC);return {f,f<0?errno:0};}
static F3Card05*acquire(void*,uint32_t id){if(scenario==7)return nullptr;assert(id==11);card.state=2;card.raw_id=card.jpeg_id=id;card.fs[0]=uintptr_t(fs);return &card;}
extern "C" int iq4_f3_settings_snapshot_06(F3SettingsSnapshot06*out){*out={scenario==7?2u:0u,scenario==5?0u:2u,0,92};return 1;}
static int saved(void*,F3CapturedRaw01*c){++saved_calls;assert(c->card->raw_id==11&&c->state==F3_CAPTURE_SAVED01&&c->close_success&&c->store_success&&strlen(c->sha256)==64);F3CaptureBorrow03 b{};assert(f3_capture_saved_proof_03(c,&b)==F3_CAPTURE_PROOF_OK03&&b.card_id==11&&b.selected_mask==2&&b.activity.owner==b.group_owner);iq4::source_dependencies_01::Snapshot d{};assert(f3_capture_dependencies_03(c,&d)==F3_CAPTURE_PROOF_OK03);F3CapturedRaw01 foreign=*c;assert(f3_capture_saved_proof_03(&foreign,&b)==F3_CAPTURE_PROOF_REJECTED03);if(scenario==4)return 0;return 1;}
extern "C" bool iq4_f3_original_xqd_store_capture_03(void*,void*,const char*){
 ++stores;if(f3_capture_active_card_03()!=11)return true;
 unsigned char file[32] __attribute__((aligned(8)))={};uintptr_t vt=0xd90410;std::memcpy(file,&vt,8);
 auto old=reinterpret_cast<bool(*)(void*,void*,const char*,bool,bool,bool)>(0x825ed4);
 if(!iq4_f3_xqd_open_wrapper_03(fs,file,path,true,true,true,old))return false;
 int fd;std::memcpy(&fd,file+16,4);assert(write(fd,"opaque full raw",15)==15);
 try{iq4_f3_xqd_dtor_wrapper_03(file);}catch(...){iq4_f3_xqd_dtor_wrapper_03(file);throw;}
 retired_file=uintptr_t(file);return scenario!=1;
}
// Fixture includes the exact production implementation; static state is inspected only here.
#include "runtime.cpp"
int main(int argc,char**argv){assert(argc==3);scenario=unsigned(atoi(argv[2]));assert(scenario<10);char root[4096];snprintf(root,sizeof root,"%s/xqd-%u-XXXXXX",argv[1],scenario);assert(mkdtemp(root));int d=open(root,O_RDONLY|O_DIRECTORY|O_CLOEXEC);assert(d>=0&&!mkdirat(d,"DCIM",0700));int dc=openat(d,"DCIM",O_RDONLY|O_DIRECTORY);assert(dc>=0&&!mkdirat(dc,"100PHASE",0700));int pd=openat(dc,"100PHASE",O_RDONLY|O_DIRECTORY);assert(pd>=0);
 uintptr_t vt=0xd91450;std::memcpy(fs,&vt,8);fs[0x115]='/';vt=0xdbc280;std::memcpy(storage,&vt,8);uintptr_t fp=uintptr_t(fs);std::memcpy(storage+0x2c0,&fp,8);std::memcpy(manager+0x48,&node,8);uintptr_t pool=0x65432100;std::memcpy(manager+0x38,&pool,8);uint32_t count=1;std::memcpy(manager+8,&count,4);entries[0]=uintptr_t(ctx);uintptr_t ap=uintptr_t(entries);std::memcpy(manager+0x10,&ap,8);ctx[0x13f3]=2;
 f3_fs_host_api_03(&files);card.raw_dir=card.jpeg_dir=d;assert(!files.stat_fd(d,&card.raw_stat).value);
 F3CaptureOps03 o{};o.common.memory={nullptr,memory};o.common.files=files;o.common.dirs.open_child=child;o.acquire_card=acquire;o.common.saved=saved;assert(f3_capture_configure_03(&o)==1&&f3_capture_backend_capabilities_03()==3);
 if(scenario==6){int f=openat(pd,"P0000001.IIQ",O_WRONLY|O_CREAT|O_EXCL,0600);assert(f>=0&&write(f,"existing user",13)==13&&!close(f));}
 iq4_f3_raw_acquired_after_01(uintptr_t(manager),node);assert(iq4_f3_fanout_select_wrapper_03(manager,0));
 if(scenario==7){ctx[0x13f3]=4;assert(iq4_f3_fanout_select_wrapper_03(manager,0));assert(group.selected_mask==3);}
 iq4_f3_fanout_refs_wrapper_03((void*)pool,(void*)node,2);
 if(scenario==7){assert(group.live==1&&group.sealed==1);uintptr_t svt=0xdbc6b8;std::memcpy(storage,&svt,8);assert(!begin_card(10,storage,(void*)node,fs));Iq4ActivitySnapshot01 a{};assert(iq4_activity_snapshot_01(&a)==IQ4_ACTIVITY_OK01&&a.actor==IQ4_ACTIVITY_JPEG01&&!a.held);svt=0xdbc280;std::memcpy(storage,&svt,8);assert(!begin_card(11,storage,(void*)node,fs));assert(iq4_activity_snapshot_01(&a)==IQ4_ACTIVITY_OK01&&!a.actor&&!a.held&&group.live==0&&group.finished_mask==3);printf("{\"scenario\":7,\"passed\":true,\"actual_selected_two_card_group\":true,\"known_no_owner_refusals\":true}\n");close(pd);close(dc);close(d);return 0;}
 if(scenario==8){clock_hook=[](){++group.sequence;};assert(!begin_card(11,storage,(void*)node,fs)&&serial_owner==0&&active_card==0&&captures[1].state==F3_CAPTURE_EMPTY01);printf("{\"scenario\":8,\"passed\":true,\"changed_group_after_wait_rejected\":true}\n");close(pd);close(dc);close(d);return 0;}
 if(scenario==9){__atomic_store_n(&active_thread,tid,__ATOMIC_RELEASE);assert(!begin_card(11,storage,(void*)node,fs)&&group.hold&&serial_owner==0);Iq4ActivitySnapshot01 a{};assert(iq4_activity_snapshot_01(&a)==IQ4_ACTIVITY_OK01&&a.held);printf("{\"scenario\":9,\"passed\":true,\"same_thread_self_wait_held\":true}\n");close(pd);close(dc);close(d);return 0;}
 bool result=false;try{result=iq4_f3_xqd_store_wrapper_03(storage,(void*)node,path);}catch(int n){assert(scenario==3&&n==88);}
 Iq4ActivitySnapshot01 a{};assert(iq4_activity_snapshot_01(&a)==IQ4_ACTIVITY_OK01);
 assert(stores==1);
 if(scenario==2||scenario==3||scenario==4){assert(a.held&&a.actor==IQ4_ACTIVITY_JPEG01);assert(close_calls==1+(scenario==4?1u:0u));assert(saved_calls==(scenario==4?1u:0u));}
 else{assert(!a.actor&&!a.held);assert(saved_calls==(scenario==0?1u:0u));if(scenario==0||scenario==1)assert(close_calls==2&&actual_closes==1&&dtor_calls==1);}
 if(scenario==6){char b[14]={};int f=openat(pd,"P0000001.IIQ",O_RDONLY);assert(f>=0&&read(f,b,13)==13&&!memcmp(b,"existing user",13)&&!close(f));}
 if(scenario==5)assert(result&&close_calls==0&&saved_calls==0);if(scenario==0)assert(result&&saved_calls==1);
 // Fixture teardown only; production has no force-close/Hold reset.
 if(held_writer>=0)close(held_writer);close(pd);close(dc);close(d);
 printf("{\"scenario\":%u,\"passed\":true,\"real_host_files\":true,\"native_abi_fixture_only\":true}\n",scenario);
}
