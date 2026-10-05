#include "../f3_saved_raw_capture_01/capture.h"
extern "C" {
#include "../f3_capture_menu_04/policy.h"
}
#include <cstring>
/* These are exact original AAPCS interfaces. Fixed VAs/whole finite body bytes
 * are recorded in ORIGINAL_BINDINGS.json; no guessed object allocation/ABI. */
extern "C" void iq4_f3_original_file_bind_capture_01(void*,void*,int,bool);
extern "C" bool iq4_f3_original_writer_close_capture_01(void*);
extern "C" uint64_t iq4_f3_original_pthread_self_capture_01(void);
using Store=bool(*)(void*,void*,void*,void*,void*,void*,const char*);
using Open=bool(*)(void*,void*,const char*,bool,bool,bool);
static F3CaptureOps01 ops;
static F3CapturedRaw01 capture;
static F3CaptureTicket01 pending;
static uint32_t configured,armed;
static uint64_t sequence;
static uint64_t active_thread;
static int read(uintptr_t p,void*out,size_t n){return p&&n&&p<=UINTPTR_MAX-n&&ops.memory.read&&ops.memory.read(ops.memory.context,p,out,n)==1;}
static int twice(uintptr_t p,void*out,size_t n){unsigned char other[256];return n<=sizeof(other)&&read(p,out,n)&&read(p,other,n)&&!std::memcmp(out,other,n);}
static int policy(F3CapturePolicy01Small&out){
 F3SettingsSnapshot04 actual{};if(iq4_f3_settings_snapshot_04(&actual)!=1||
  actual.mode>2||actual.size_mode>5||actual.quality<1||actual.quality>100)return 0;
 out={actual.mode,actual.size_mode,actual.quality};return 1;
}
extern "C" int f3_capture_configure_01(const F3CaptureOps01*o){
 if(!o||configured||!o->memory.read||!o->acquire_sd||!o->saved||!o->dirs.open_child||!o->files.open_leaf||!o->files.stat_fd||!o->files.stat_leaf||!o->files.read_at||!o->files.sync||!o->files.close)return 0;
 ops=*o;__atomic_store_n(&configured,1,__ATOMIC_RELEASE);return 1;
}
extern "C" const F3CapturedRaw01*f3_capture_status_01(void){return &capture;}
extern "C" void iq4_f3_raw_acquired_after_01(uintptr_t manager,uintptr_t node) noexcept {
 try {
 if(!__atomic_load_n(&configured,__ATOMIC_ACQUIRE)||!manager||!node)return;
 uintptr_t actual=0;if(!twice(manager+0x48,&actual,8)||actual!=node)return;
 F3CapturePolicy01Small p{};if(!policy(p)||!p.mode)return;
 uint32_t empty=__atomic_load_n(&armed,__ATOMIC_ACQUIRE);
 // A newly acquired original node proves any unconsumed pending ticket from
 // the previous fanout has retired. It owns no source/card/activity resources.
 // Never replace a ticket already consumed by the SD worker (state 2).
 if(empty!=0&&empty!=1)return;
 if(!__atomic_compare_exchange_n(&armed,&empty,3,false,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))return;
 uint64_t next=__atomic_add_fetch(&sequence,1,__ATOMIC_RELAXED);if(!next){f3_capture_hold_01(&capture);return;}
 pending={manager,node,next,p};__atomic_store_n(&armed,1,__ATOMIC_RELEASE);
 } catch(...) { f3_capture_hold_01(&capture);__atomic_store_n(&armed,2,__ATOMIC_RELEASE); }
}
static void done_without_owners(){
 if(capture.activity.word&&iq4_activity_release_01(&capture.activity)!=IQ4_ACTIVITY_OK01){f3_capture_hold_01(&capture);return;}
 capture.state=F3_CAPTURE_DONE01;__atomic_store_n(&armed,0,__ATOMIC_RELEASE);
}
extern "C" bool iq4_f3_sd_store_wrapper_01(void*storage,void*node,void*fs,void*a,void*b,void*c,const char*name,Store original){
 /* The eighth argument is the real x7 target that the original BLR used.
  * Unselected/nonmatching calls retain original dispatch and arguments. */
 uint32_t expected=1;bool selected=__atomic_load_n(&configured,__ATOMIC_ACQUIRE)&&
  original==reinterpret_cast<Store>(0x8dcf98)&&!capture.hold&&
  __atomic_load_n(&armed,__ATOMIC_ACQUIRE)==1&&pending.node==reinterpret_cast<uintptr_t>(node)&&
  __atomic_compare_exchange_n(&armed,&expected,2,false,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE);
 if(!selected)return original(storage,node,fs,a,b,c,name);
 uintptr_t vt=0,actual=0;bool shape=twice(reinterpret_cast<uintptr_t>(storage),&vt,8)&&vt==0xdbc6b8&&
  twice(pending.manager+0x48,&actual,8)&&actual==pending.node;
 if(!shape){__atomic_store_n(&armed,0,__ATOMIC_RELEASE);return original(storage,node,fs,a,b,c,name);}
 capture={};capture.ticket=pending;capture.storage=reinterpret_cast<uintptr_t>(storage);
 capture.native_fs=reinterpret_cast<uintptr_t>(fs);capture.dcim_dir=capture.parent_dir=capture.raw_fd=capture.writer_fd=-1;capture.state=F3_CAPTURE_WRITING01;
 if(iq4_activity_try_01(IQ4_ACTIVITY_JPEG01,&capture,&capture.activity)!=IQ4_ACTIVITY_OK01){
  capture.state=F3_CAPTURE_DONE01;__atomic_store_n(&armed,0,__ATOMIC_RELEASE);
  return original(storage,node,fs,a,b,c,name);
 }
 try{capture.card=ops.acquire_sd(ops.context);}catch(...){f3_capture_hold_01(&capture);throw;}
 if(!capture.card||capture.card->hold||capture.card->state!=2||capture.card->fs[0]!=capture.native_fs){
  /* No own native File/open yet: a known acquire refusal preserves factory RAW.
   * A live/unknown card owner is retained, never silently released. */
  if(capture.card&&(capture.card->hold||capture.card->state!=3)){f3_capture_hold_01(&capture);return original(storage,node,fs,a,b,c,name);}
  done_without_owners();return original(storage,node,fs,a,b,c,name);
 }
 capture.writer_thread=iq4_f3_original_pthread_self_capture_01();
 if(!capture.writer_thread){f3_capture_hold_01(&capture);return original(storage,node,fs,a,b,c,name);}
 __atomic_store_n(&active_thread,capture.writer_thread,__ATOMIC_RELEASE);
 bool result=false;
 try{result=original(storage,node,fs,a,b,c,name);}catch(...){f3_capture_hold_01(&capture);throw;}
 if(capture.exclusive_created&&f3_capture_saved_01(&capture,&ops,result)){
  /* Complete saved-file identity, not thumbnail/pool assumptions. Consumer must
   * synchronously finish actual source/render/arena/file ownership. */
  try{if(ops.saved(ops.context,&capture)!=1){f3_capture_hold_01(&capture);return result;}}
  catch(...){f3_capture_hold_01(&capture);throw;}
 }
 if(capture.hold)return result;
 if(!capture.writer_bound&&capture.writer_fd>=0){
  /* Native File never took ownership: only this independent original fd can
   * be closed. No unlink: every failed capture preserves the RAW leaf. */
  if(ops.files.close(capture.writer_fd).value){f3_capture_hold_01(&capture);return result;}capture.writer_fd=-1;
 }
 if(capture.writer_bound&&!capture.close_success){f3_capture_hold_01(&capture);return result;}
 if(!f3_capture_release_files_01(&capture,&ops))return result;
 if(f3_card_finish_05(capture.card)!=F3_CARD_OK){f3_capture_hold_01(&capture);return result;}
 if(iq4_activity_release_01(&capture.activity)!=IQ4_ACTIVITY_OK01){f3_capture_hold_01(&capture);return result;}
 __atomic_store_n(&active_thread,0,__ATOMIC_RELEASE);__atomic_store_n(&armed,0,__ATOMIC_RELEASE);return result;
}
extern "C" bool iq4_f3_raw_open_wrapper_01(void*fs,void*file,const char*path,bool write,bool rw,bool sync,Open original){
 uint64_t thread=iq4_f3_original_pthread_self_capture_01();
 bool selected=thread&&thread==__atomic_load_n(&active_thread,__ATOMIC_ACQUIRE)&&capture.state==F3_CAPTURE_WRITING01&&!capture.hold&&
  capture.native_fs==reinterpret_cast<uintptr_t>(fs)&&original==reinterpret_cast<Open>(0x825ed4)&&write&&rw&&!sync;
 if(!selected)return original(fs,file,path,write,rw,sync);
 unsigned char shape[24];char copied[64]{},cwd[256];uintptr_t fsvt=0,filevt=0;
 bool file_read=twice(reinterpret_cast<uintptr_t>(file),shape,sizeof(shape));if(file_read)std::memcpy(&filevt,shape,8);
 if(!file_read||
  filevt!=0xd90410||shape[20]||
  !twice(reinterpret_cast<uintptr_t>(fs),&fsvt,8)||fsvt!=0xd91450||
  !twice(reinterpret_cast<uintptr_t>(fs)+0x115,cwd,sizeof(cwd))||cwd[0]!='/'||cwd[1]||
  !twice(reinterpret_cast<uintptr_t>(path),copied,32)||!std::memchr(copied,0,32))return original(fs,file,path,write,rw,sync);
 char directory[9],leaf[32];if(!f3_capture_path_01(copied,directory,leaf))return original(fs,file,path,write,rw,sync);
 if(!f3_capture_open_01(&capture,&ops,reinterpret_cast<uintptr_t>(fs),reinterpret_cast<uintptr_t>(file),copied,thread))return false;
 try{iq4_f3_original_file_bind_capture_01(fs,file,capture.writer_fd,true);}
 catch(...){f3_capture_hold_01(&capture);throw;}
 capture.writer_bound=1;
 if(!twice(reinterpret_cast<uintptr_t>(file),shape,sizeof(shape))){f3_capture_hold_01(&capture);return false;}
 uintptr_t boundfs=0;int fd=0;std::memcpy(&boundfs,shape+8,8);std::memcpy(&fd,shape+16,4);
 if(boundfs!=capture.native_fs||fd!=capture.writer_fd||shape[20]!=1||shape[21]){f3_capture_hold_01(&capture);return false;}return true;
}
extern "C" bool iq4_f3_raw_close_wrapper_01(void*writer){
 uint64_t thread=iq4_f3_original_pthread_self_capture_01();uintptr_t file=0;
 bool selected=thread&&thread==__atomic_load_n(&active_thread,__ATOMIC_ACQUIRE)&&capture.state==F3_CAPTURE_WRITING01&&capture.writer_bound&&
  twice(reinterpret_cast<uintptr_t>(writer)+0x2aba0,&file,8)&&file==capture.native_file;
 bool result=false;try{result=iq4_f3_original_writer_close_capture_01(writer);}catch(...){if(selected)f3_capture_hold_01(&capture);throw;}
 if(selected)f3_capture_close_result_01(&capture,file,1,result);return result;
}
