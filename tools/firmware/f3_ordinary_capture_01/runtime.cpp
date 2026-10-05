// Generated from the frozen capture03 runtime; see build.py.
#include "integration.inc"
#include "capture03.h"
#include "../f3_native_executor_03/saved_capture_contract.h"
#include "../f3_source_dependencies_01/dependencies.hpp"
#include <cstring>
#include <time.h>
#include <sys/syscall.h>
extern "C" void iq4_f3_original_file_bind_capture_01(void*,void*,int,bool);
extern "C" bool iq4_f3_original_writer_close_capture_01(void*);
extern "C" bool iq4_f3_original_file_close_capture_03(void*);
extern "C" void iq4_f3_original_file_dtor_capture_03(void*);
extern "C" bool iq4_f3_original_xqd_store_capture_03(void*,void*,const char*);
extern "C" bool iq4_f3_original_fanout_select_capture_03(void*,uint32_t);
extern "C" void iq4_f3_original_fanout_refs_capture_03(void*,void*,uint8_t);
extern "C" uint64_t iq4_f3_original_pthread_self_capture_01(void);
extern "C" long iq4_f3_original_syscall_03(long,...);
using Store=bool(*)(void*,void*,void*,void*,void*,void*,const char*);
using Open=bool(*)(void*,void*,const char*,bool,bool,bool);
struct Group03 {
 uintptr_t manager,node;uint64_t sequence;
 F3SettingsSnapshot06 settings;Iq4ActivityLease01 activity;
 uint32_t live,sealed,selected_mask,finished_mask,hold;
 iq4::source_dependencies_01::Snapshot dependencies;
};
static F3CaptureOps03 cfg;
static F3CapturedRaw01 captures[2];
static Group03 group;
static uint32_t configured,serial_owner,active_card;
static uint64_t sequence,active_thread;
static uint32_t close_attempted[2];
extern "C" void f3_capture_group_hold_03(const F3CapturedRaw01*c){
 if((c==&captures[0]||c==&captures[1])&&c->activity.word==group.activity.word&&c->activity.owner==uintptr_t(&group))__atomic_store_n(&group.hold,1,__ATOMIC_RELEASE);
}
static int read(uintptr_t p,void*out,size_t n){return p&&n&&p<=UINTPTR_MAX-n&&cfg.common.memory.read&&cfg.common.memory.read(cfg.common.memory.context,p,out,n)==1;}
static int twice(uintptr_t p,void*out,size_t n){unsigned char other[256];return n<=sizeof(other)&&read(p,out,n)&&read(p,other,n)&&!std::memcmp(out,other,n);}
static void hold(F3CapturedRaw01*c){__atomic_store_n(&group.hold,1,__ATOMIC_RELEASE);if(c)f3_capture_hold_01(c);else if(group.activity.word)iq4_activity_hold_01(&group.activity);}
static bool clock_ns(uint64_t&n){timespec t{};if(iq4_f3_original_syscall_03(113,1,&t)!=0||t.tv_sec<0||t.tv_nsec<0||t.tv_nsec>=1000000000)return false;n=uint64_t(t.tv_sec)*1000000000u+uint64_t(t.tv_nsec);return true;}
static bool wait_serial(uint32_t card){uint64_t start,now;if(!clock_ns(start))return false;for(;;){
 if(__atomic_load_n(&group.hold,__ATOMIC_ACQUIRE))return false;
 uint32_t empty=0;if(__atomic_compare_exchange_n(&serial_owner,&empty,card,false,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))return true;
 if(!clock_ns(now)||now<start||now-start>600000000000ull)return false;
 timespec t{0,10000000};if(iq4_f3_original_syscall_03(101,&t,nullptr)!=0)return false;
}}
static void maybe_release_group(){
 if(!__atomic_load_n(&group.live,__ATOMIC_ACQUIRE)||!__atomic_load_n(&group.sealed,__ATOMIC_ACQUIRE)||__atomic_load_n(&group.hold,__ATOMIC_ACQUIRE)||__atomic_load_n(&serial_owner,__ATOMIC_ACQUIRE))return;
 uint32_t mask=__atomic_load_n(&group.selected_mask,__ATOMIC_ACQUIRE);
 if((__atomic_load_n(&group.finished_mask,__ATOMIC_ACQUIRE)&mask)!=mask)return;
 uint32_t live=1;if(!__atomic_compare_exchange_n(&group.live,&live,2,false,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))return;
 if(group.activity.word&&iq4_activity_release_01(&group.activity)!=IQ4_ACTIVITY_OK01){hold(nullptr);return;}
 __atomic_store_n(&group.live,0,__ATOMIC_RELEASE);
}
static void finish_card(uint32_t id){
 __atomic_fetch_or(&group.finished_mask,1u<<(id-10),__ATOMIC_RELEASE);
 __atomic_store_n(&active_thread,0,__ATOMIC_RELEASE);__atomic_store_n(&active_card,0,__ATOMIC_RELEASE);
 __atomic_store_n(&serial_owner,0,__ATOMIC_RELEASE);maybe_release_group();
}
extern "C" int f3_capture_configure_03(const F3CaptureOps03*o){
 if(!o||configured||!o->common.memory.read||!o->acquire_card||!o->common.saved||!o->common.dirs.open_child||!o->common.files.open_leaf||!o->common.files.stat_fd||!o->common.files.stat_leaf||!o->common.files.read_at||!o->common.files.sync||!o->common.files.close)return 0;
 iq4::ordinary_capture_01::Memory om{o->common.memory.context,o->common.memory.read};
 if(!iq4::ordinary_capture_01::original_prefixes(om))return 0;ordinary_memory01=om;
 cfg=*o;__atomic_store_n(&configured,1,__ATOMIC_RELEASE);return 1;
}
extern "C" unsigned f3_capture_backend_capabilities_03(){return __atomic_load_n(&configured,__ATOMIC_ACQUIRE)?3u:0u;}
extern "C" uint32_t f3_capture_active_card_03(){return __atomic_load_n(&active_card,__ATOMIC_ACQUIRE);}
extern "C" const F3CapturedRaw01*f3_capture_status_01(){return &captures[0];}
extern "C" void iq4_f3_raw_acquired_after_01(uintptr_t manager,uintptr_t node) noexcept {
 try{
 if(!__atomic_load_n(&configured,__ATOMIC_ACQUIRE)||!manager||!node||__atomic_load_n(&group.hold,__ATOMIC_ACQUIRE))return;
 uintptr_t actual=0;if(!twice(manager+0x48,&actual,8)||actual!=node)return;
 if(!ordinary_guard01.consume(ordinary_memory01,manager,node))return;
 maybe_release_group();if(__atomic_load_n(&group.live,__ATOMIC_ACQUIRE))return;
 F3SettingsSnapshot06 p{};if(iq4_f3_settings_snapshot_06(&p)!=1||p.sd_mode>2||p.xqd_mode>2||p.size_mode>5||!p.quality||p.quality>100||(!p.sd_mode&&!p.xqd_mode))return;
 iq4::source_dependencies_01::Snapshot dependencies{};
 if(iq4::source_dependencies_01::snapshot_from_raw_manager({cfg.common.memory.context,cfg.common.memory.read},manager,node,dependencies)!=iq4::source_dependencies_01::Result::Ok)return;
 Iq4ActivityLease01 lease{};if(iq4_activity_try_01(IQ4_ACTIVITY_JPEG01,&group,&lease)!=IQ4_ACTIVITY_OK01)return;
 uint64_t next=++sequence;if(!next){iq4_activity_hold_01(&lease);__atomic_store_n(&group.hold,1,__ATOMIC_RELEASE);return;}
 group.manager=manager;group.node=node;group.sequence=next;group.settings=p;group.activity=lease;group.dependencies=dependencies;
 group.selected_mask=group.finished_mask=group.sealed=0;__atomic_store_n(&group.live,1,__ATOMIC_RELEASE);
 }catch(...){hold(nullptr);}
}
/* This hook runs exactly the original enable getter once.  The bit mapping is
 * original ctor data (SD=4/XQD=2), not a fabricated feature capability. */
extern "C" bool iq4_f3_fanout_select_wrapper_03(void*manager,uint32_t index){
 bool result=iq4_f3_original_fanout_select_capture_03(manager,index);
 if(!result||!__atomic_load_n(&group.live,__ATOMIC_ACQUIRE)||group.manager!=uintptr_t(manager))return result;
 uintptr_t node=0,array=0,entry=0;uint32_t count=0;uint8_t flags=0;
 if(!twice(group.manager+0x48,&node,8)||node!=group.node||!twice(group.manager+8,&count,4)||count>16||index>=count||!twice(group.manager+0x10,&array,8)||!twice(array+index*8,&entry,8)||!twice(entry+0x13f3,&flags,1)){hold(nullptr);return result;}
 uint32_t mask=0;if(flags==4&&group.settings.sd_mode)mask=1;else if(flags==2&&group.settings.xqd_mode)mask=2;else if(flags!=1&&flags!=2&&flags!=4){hold(nullptr);return result;}
 __atomic_fetch_or(&group.selected_mask,mask,__ATOMIC_RELEASE);return result;
}
extern "C" void iq4_f3_fanout_refs_wrapper_03(void*pool,void*node,uint8_t count){
 iq4_f3_original_fanout_refs_capture_03(pool,node,count);
 if(__atomic_load_n(&group.live,__ATOMIC_ACQUIRE)&&group.node==uintptr_t(node)){
  uintptr_t actual=0;if(!twice(group.manager+0x38,&actual,8)||actual!=uintptr_t(pool)){hold(nullptr);return;}
  __atomic_store_n(&group.sealed,1,__ATOMIC_RELEASE);maybe_release_group();
 }
}
static F3CapturedRaw01* begin_card(uint32_t id,void*storage,void*node,void*fs){
 if(!__atomic_load_n(&configured,__ATOMIC_ACQUIRE)||id<10||id>11||!__atomic_load_n(&group.live,__ATOMIC_ACQUIRE)||__atomic_load_n(&group.hold,__ATOMIC_ACQUIRE)||group.node!=uintptr_t(node))return nullptr;
 uint32_t bit=1u<<(id-10);if(!(__atomic_load_n(&group.selected_mask,__ATOMIC_ACQUIRE)&bit)||(__atomic_load_n(&group.finished_mask,__ATOMIC_ACQUIRE)&bit))return nullptr;
 uint64_t begun_sequence=group.sequence;uintptr_t begun_node=group.node;Iq4ActivityLease01 begun_lease=group.activity;
 uintptr_t vt=0;uint64_t tid=iq4_f3_original_pthread_self_capture_01();
 // The actual live original Store argument still equals the immutable acquired
 // node. Do not require a late mutable RawManager current node after fanout.
 if(!tid||!twice(uintptr_t(storage),&vt,8)||vt!=(id==10?0xdbc6b8u:0xdbc280u)||iq4::source_dependencies_01::recheck({cfg.common.memory.context,cfg.common.memory.read},group.dependencies)!=iq4::source_dependencies_01::Result::Ok){__atomic_fetch_or(&group.finished_mask,bit,__ATOMIC_RELEASE);maybe_release_group();return nullptr;}
 // A duplicate same-thread Store cannot wait for itself.
 if(tid==__atomic_load_n(&active_thread,__ATOMIC_ACQUIRE)){hold(nullptr);return nullptr;}
 if(!wait_serial(id)){if(__atomic_load_n(&group.hold,__ATOMIC_ACQUIRE))return nullptr;__atomic_fetch_or(&group.finished_mask,bit,__ATOMIC_RELEASE);maybe_release_group();return nullptr;}
 if(__atomic_load_n(&group.live,__ATOMIC_ACQUIRE)!=1||__atomic_load_n(&group.hold,__ATOMIC_ACQUIRE)||group.sequence!=begun_sequence||group.node!=begun_node||group.node!=uintptr_t(node)||group.activity.word!=begun_lease.word||group.activity.owner!=begun_lease.owner||!(__atomic_load_n(&group.selected_mask,__ATOMIC_ACQUIRE)&bit)||(__atomic_load_n(&group.finished_mask,__ATOMIC_ACQUIRE)&bit)||iq4::source_dependencies_01::recheck({cfg.common.memory.context,cfg.common.memory.read},group.dependencies)!=iq4::source_dependencies_01::Result::Ok){
  __atomic_store_n(&serial_owner,0,__ATOMIC_RELEASE);maybe_release_group();return nullptr;
 }
 F3CapturedRaw01*c=&captures[id-10];*c={};c->ticket={group.manager,group.node,group.sequence,{id==10?group.settings.sd_mode:group.settings.xqd_mode,group.settings.size_mode,group.settings.quality}};
 c->storage=uintptr_t(storage);c->native_fs=uintptr_t(fs);c->dcim_dir=c->parent_dir=c->raw_fd=c->writer_fd=-1;c->state=F3_CAPTURE_WRITING01;c->writer_thread=tid;c->activity=group.activity;close_attempted[id-10]=0;
 __atomic_store_n(&active_card,id,__ATOMIC_RELEASE);__atomic_store_n(&active_thread,tid,__ATOMIC_RELEASE);
 try{c->card=cfg.acquire_card(cfg.common.context,id);}catch(...){hold(c);return nullptr;}
 if(!c->card||c->card->hold||c->card->state!=2||c->card->fs[0]!=c->native_fs||c->card->raw_id!=id||c->card->jpeg_id!=id){
  if(c->card&&(c->card->hold||c->card->state!=3)){hold(c);return nullptr;}
  c->state=F3_CAPTURE_DONE01;finish_card(id);return nullptr;
 }
 return c;
}
static void complete_card(F3CapturedRaw01*c,bool result){
 uint32_t id=f3_capture_active_card_03();if(!c||id<10||id>11||c!=&captures[id-10]){hold(c);return;}
 if(c->hold||__atomic_load_n(&group.hold,__ATOMIC_ACQUIRE))return;
 if(c->exclusive_created&&f3_capture_saved_01(c,&cfg.common,result)){
  try{if(cfg.common.saved(cfg.common.context,c)!=1){hold(c);return;}}catch(...){hold(c);throw;}
 }
 if(c->hold)return;
 if(!c->writer_bound&&c->writer_fd>=0){if(cfg.common.files.close(c->writer_fd).value){hold(c);return;}c->writer_fd=-1;}
 if(c->writer_bound&&!c->close_success){hold(c);return;}
 if(!f3_capture_release_files_01(c,&cfg.common)||f3_card_finish_05(c->card)!=F3_CARD_OK){hold(c);return;}
 finish_card(id);
}
extern "C" bool iq4_f3_sd_store_wrapper_01(void*s,void*n,void*fs,void*a,void*b,void*c,const char*name,Store original){
 if(original!=reinterpret_cast<Store>(0x8dcf98))return original(s,n,fs,a,b,c,name);
 F3CapturedRaw01*slot=begin_card(10,s,n,fs);bool result=false;
 try{result=original(s,n,fs,a,b,c,name);}catch(...){if(slot)hold(slot);throw;}
 if(slot)complete_card(slot,result);return result;
}
extern "C" bool iq4_f3_xqd_store_wrapper_03(void*s,void*n,const char*name){
 uintptr_t fs=0;if(!twice(uintptr_t(s)+0x2c0,&fs,8))return iq4_f3_original_xqd_store_capture_03(s,n,name);
 F3CapturedRaw01*slot=begin_card(11,s,n,reinterpret_cast<void*>(fs));bool result=false;
 try{result=iq4_f3_original_xqd_store_capture_03(s,n,name);}catch(...){if(slot)hold(slot);throw;}
 if(slot)complete_card(slot,result);return result;
}
static F3CapturedRaw01* active(){uint32_t id=f3_capture_active_card_03();if(id<10||id>11||iq4_f3_original_pthread_self_capture_01()!=__atomic_load_n(&active_thread,__ATOMIC_ACQUIRE))return nullptr;return &captures[id-10];}
static bool opened(void*fs,void*file,const char*path){
 F3CapturedRaw01*c=active();if(!c||c->hold)return false;
 unsigned char shape[24];char copied[64]{},cwd[2];uintptr_t fsvt=0,filevt=0;
 bool got=twice(uintptr_t(file),shape,sizeof(shape));if(got)std::memcpy(&filevt,shape,8);
 if(!got||filevt!=0xd90410||shape[20]||!twice(uintptr_t(fs),&fsvt,8)||fsvt!=0xd91450||!twice(uintptr_t(fs)+0x115,cwd,sizeof(cwd))||cwd[0]!='/'||cwd[1]||!twice(uintptr_t(path),copied,sizeof(copied))||!std::memchr(copied,0,sizeof(copied)))return false;
 if(!f3_capture_open_01(c,&cfg.common,uintptr_t(fs),uintptr_t(file),copied,c->writer_thread))return false;
 try{iq4_f3_original_file_bind_capture_01(fs,file,c->writer_fd,true);}catch(...){hold(c);throw;}
 c->writer_bound=1;
 if(!twice(uintptr_t(file),shape,sizeof(shape))){hold(c);return false;}
 uintptr_t boundfs=0;int fd=0;std::memcpy(&boundfs,shape+8,8);std::memcpy(&fd,shape+16,4);
 if(boundfs!=c->native_fs||fd!=c->writer_fd||shape[20]!=1||shape[21]){hold(c);return false;}return true;
}
extern "C" bool iq4_f3_raw_open_wrapper_01(void*fs,void*file,const char*path,bool write,bool rw,bool sync,Open original){
 F3CapturedRaw01*c=active();bool selected=c&&c->state==F3_CAPTURE_WRITING01&&c->native_fs==uintptr_t(fs)&&original==reinterpret_cast<Open>(0x825ed4)&&write&&rw&&!sync&&f3_capture_active_card_03()==10;
 if(!selected)return original(fs,file,path,write,rw,sync);
 if(opened(fs,file,path))return true;
 // Unsupported filename/shape before any exclusive create preserves the stock
 // RAW route. An EXCL collision or unknown own file must never fall through to
 // original O_TRUNC, and partial directory/file owners remain checked below.
 if(!c->hold&&!c->exclusive_created&&c->writer_fd<0&&c->raw_fd<0&&c->dcim_dir<0&&c->parent_dir<0)return original(fs,file,path,write,rw,sync);
 return false;
}
extern "C" bool iq4_f3_xqd_open_wrapper_03(void*fs,void*file,const char*path,bool write,bool rw,bool direct,Open original){
 F3CapturedRaw01*c=active();bool selected=c&&c->state==F3_CAPTURE_WRITING01&&c->native_fs==uintptr_t(fs)&&original==reinterpret_cast<Open>(0x825ed4)&&write&&rw&&direct&&f3_capture_active_card_03()==11;
 if(!selected)return original(fs,file,path,write,rw,direct);
 if(opened(fs,file,path))return true;
 if(!c->hold&&!c->exclusive_created&&c->writer_fd<0&&c->raw_fd<0&&c->dcim_dir<0&&c->parent_dir<0)return original(fs,file,path,write,rw,direct);
 return false;
}
extern "C" bool iq4_f3_raw_close_wrapper_01(void*writer){
 F3CapturedRaw01*c=active();uintptr_t file=0;bool selected=c&&f3_capture_active_card_03()==10&&c->state==F3_CAPTURE_WRITING01&&c->writer_bound&&twice(uintptr_t(writer)+0x2aba0,&file,8)&&file==c->native_file;
 bool r=false;try{r=iq4_f3_original_writer_close_capture_01(writer);}catch(...){if(selected)hold(c);throw;}if(selected)f3_capture_close_result_01(c,file,1,r);return r;
}
extern "C" void iq4_f3_xqd_dtor_wrapper_03(void*file){
 F3CapturedRaw01*c=active();bool selected=c&&f3_capture_active_card_03()==11&&c->writer_bound&&c->native_file==uintptr_t(file);
 if(!selected){iq4_f3_original_file_dtor_capture_03(file);return;}
 // Own checked close executes at most once, including the original unwind call.
 if(c->hold||close_attempted[1])return;close_attempted[1]=1;
 bool r=false;try{r=iq4_f3_original_file_close_capture_03(file);}catch(...){hold(c);throw;}
 if(!f3_capture_close_result_01(c,uintptr_t(file),1,r))return;
 unsigned char shape[24];if(!twice(uintptr_t(file),shape,24)||shape[20]){hold(c);return;}
 // Close has already cleared open+14 before FS+e8. Stock dtor is now no-I/O;
 // it restores the stock File VT. Never use cleared byte as the close proof.
 iq4_f3_original_file_dtor_capture_03(file);
}
extern "C" int f3_capture_saved_proof_03(const F3CapturedRaw01*c,F3CaptureBorrow03*out){
 if(!c||!out)return F3_CAPTURE_PROOF_REJECTED03;
 uint32_t id=__atomic_load_n(&active_card,__ATOMIC_ACQUIRE);
 if(id<10||id>11||c!=&captures[id-10])return F3_CAPTURE_PROOF_REJECTED03;
 if(c->hold||__atomic_load_n(&group.hold,__ATOMIC_ACQUIRE))return F3_CAPTURE_PROOF_HOLD03;
 if(__atomic_load_n(&serial_owner,__ATOMIC_ACQUIRE)!=id||!__atomic_load_n(&group.live,__ATOMIC_ACQUIRE)||!c->card||c->card->raw_id!=id||c->card->jpeg_id!=id||c->card->fs[0]!=c->native_fs||c->ticket.manager!=group.manager||c->ticket.node!=group.node||c->ticket.sequence!=group.sequence||c->state!=F3_CAPTURE_SAVED01||!c->exclusive_created||!c->writer_bound||!c->store_success||!c->close_returned||!c->close_success||c->writer_fd>=0||c->activity.owner!=uintptr_t(&group)||c->activity.word!=group.activity.word||iq4_activity_valid_01(&c->activity)!=IQ4_ACTIVITY_OK01||!f3_card_valid_05(c->card)||c->writer_thread!=__atomic_load_n(&active_thread,__ATOMIC_ACQUIRE))return F3_CAPTURE_PROOF_REJECTED03;
 F3CaptureBorrow03 p{group.sequence,id,__atomic_load_n(&group.selected_mask,__ATOMIC_ACQUIRE),uintptr_t(&group),group.activity};
 // Own immutable receipt identity checked again across publication; worker holds
 // serial_owner throughout, so no peer can replace this slot or card owner.
 if(__atomic_load_n(&active_card,__ATOMIC_ACQUIRE)!=id||c->ticket.sequence!=p.capture_sequence||c->activity.word!=p.activity.word||c->card->fs[0]!=c->native_fs||c->state!=F3_CAPTURE_SAVED01||c->hold)return F3_CAPTURE_PROOF_HOLD03;
 *out=p;return F3_CAPTURE_PROOF_OK03;
}
extern "C" int f3_capture_dependencies_03(const F3CapturedRaw01*c,iq4::source_dependencies_01::Snapshot*out){
 if(!out)return F3_CAPTURE_PROOF_REJECTED03;
 F3CaptureBorrow03 proof{};int r=f3_capture_saved_proof_03(c,&proof);if(r!=F3_CAPTURE_PROOF_OK03)return r;
 auto copy=group.dependencies;
 if(iq4::source_dependencies_01::recheck({cfg.common.memory.context,cfg.common.memory.read},copy)!=iq4::source_dependencies_01::Result::Ok)return F3_CAPTURE_PROOF_REJECTED03;
 F3CaptureBorrow03 after{};r=f3_capture_saved_proof_03(c,&after);
 if(r!=F3_CAPTURE_PROOF_OK03||after.capture_sequence!=proof.capture_sequence||after.group_owner!=proof.group_owner)return F3_CAPTURE_PROOF_HOLD03;
 *out=copy;return F3_CAPTURE_PROOF_OK03;
}
