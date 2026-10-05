#include "executor.h"
#include "../f3_native_executor_01/native_calls.h"
#include "../f3_native_executor_01/pins.h"
#include "../f3_saved_raw_capture_01/capture.h"
#include <string.h>
/* Retained until process termination. No hot unload, force reset, cancellation
 * or native queue destruction is provided. All atoms are lock-free A64 words. */
static struct {
 uint32_t state,in_callback,hold,borrowed_activity;uint64_t sequence;
 F3ExecutorOwner01 owner;F3ExecutorTask01 task;Iq4ActivityLease01 activity;
 F3ExecutorSavedReservation03 saved;
 uint32_t result;
 alignas(16) unsigned char event[0xb8];
 alignas(16) unsigned char listener[0x88];
} g;
static_assert(__atomic_always_lock_free(4,nullptr)&&__atomic_always_lock_free(8,nullptr),"finite nonblocking mailbox");
static uint32_t state(){return __atomic_load_n(&g.state,__ATOMIC_ACQUIRE);}
static Iq4ActivityLease01 lease(){return {__atomic_load_n(&g.activity.word,__ATOMIC_ACQUIRE),__atomic_load_n(&g.activity.owner,__ATOMIC_ACQUIRE)};}
static void save_lease(Iq4ActivityLease01 a){__atomic_store_n(&g.activity.owner,a.owner,__ATOMIC_RELEASE);__atomic_store_n(&g.activity.word,a.word,__ATOMIC_RELEASE);}
static int lease_valid(){const auto a=lease();return iq4_activity_valid_01(&a);}
static int lease_release(){const auto a=lease();return iq4_activity_release_01(&a);}
static uint64_t sequence(){return __atomic_load_n(&g.sequence,__ATOMIC_ACQUIRE);}
static bool pointer(uintptr_t p){return p>=4096&&!(p&7)&&p<UINTPTR_MAX-0x1000;}
static bool rd(uintptr_t p,void*out,size_t n){return p>=4096&&n&&n<=4096&&p<=UINTPTR_MAX-n&&f3_executor_read_01(p,out,n)==1;}
static bool twice(uintptr_t p,void*out,size_t n){unsigned char b[64];return n<=sizeof b&&rd(p,out,n)&&rd(p,b,n)&&!memcmp(out,b,n);}
static bool word(uintptr_t p,uintptr_t&v){return twice(p,&v,8);}
static bool pins(){unsigned char b[64];for(const auto&p:iq4_f3_executor_pins_01){
 if(p.length>sizeof b||!twice(p.va,b,p.length)||memcmp(b,p.bytes,p.length))return false;}return true;}
static bool inspect(uintptr_t q,F3ExecutorOwner01&out){uintptr_t v=0,o=0,i=0,again=0;
 if(!pointer(q)||!word(q,v)||v!=0xb805c0||!word(q+0x1a8,o)||!pointer(o)||
 !word(o,v)||v!=0xb7f960||!word(o+0xfa8,i)||!pointer(i)||!word(i,v)||v!=0xb7ece0||
 !word(i+0x328,again)||again!=o)return false;
 uint64_t tid=f3_executor_tid_01();if(!tid)return false;
 out={q,o,i,tid};return true;
}
static bool on_worker(uintptr_t q){uintptr_t current=0;F3ExecutorOwner01 a{},b{};
 return f3_executor_current_01(&current)&&current==q&&inspect(q,a)&&inspect(q,b)&&
 !memcmp(&a,&b,sizeof a)&&!memcmp(&a,&g.owner,sizeof a);
}
static bool on_ui(){uintptr_t q=0,v=0,m=0,back=0;
 return f3_executor_current_01(&q)&&pointer(q)&&word(q,v)&&v==0xb91f48&&
 word(q+0x1c8,m)&&pointer(m)&&word(m,v)&&v==0xb8f358&&word(m+8,back)&&back==q;
}
extern "C" void iq4_f3_executor_hold_01(){
 __atomic_store_n(&g.hold,1,__ATOMIC_RELEASE);
 const auto a=lease();if(a.word)iq4_activity_hold_01(&a);
 __atomic_store_n(&g.state,F3_EXEC_HOLD01,__ATOMIC_RELEASE);
}
static bool bind(uintptr_t q){uint32_t s=state();if(s)return s!=F3_EXEC_NOT_BOUND01&&g.owner.queue==q;
 uintptr_t current=0;F3ExecutorOwner01 a{},b{};
 if(!pins()||!f3_executor_current_01(&current)||current!=q||!inspect(q,a)||!inspect(q,b)||memcmp(&a,&b,sizeof a))return false;
 g.owner=a;
 if(!f3_executor_event_ctor_01(g.event)||!f3_executor_listener_ctor_01(g.listener,g.event,q)){
  iq4_f3_executor_hold_01();return false;
 }
 uintptr_t v=0,e=0,owner=0;unsigned char pending=255;
 if(!word((uintptr_t)g.event,v)||v!=0xc237a0||!word((uintptr_t)g.listener,v)||v!=0xc23c90||
 !word((uintptr_t)g.listener+8,e)||e!=(uintptr_t)g.event||
 !word((uintptr_t)g.listener+0x30,owner)||owner!=q||
 !rd((uintptr_t)g.listener+0x38,&pending,1)||pending!=0){iq4_f3_executor_hold_01();return false;}
 __atomic_store_n(&g.state,F3_EXEC_IDLE01,__ATOMIC_RELEASE);return true;
}
extern "C" int iq4_f3_executor_selection_on_ui_01(F3ExecutorSelection01*out){
 if(!out||!on_ui()||state()==F3_EXEC_NOT_BOUND01||state()==F3_EXEC_HOLD01)return F3_EXEC_REJECTED01;
 uintptr_t v=0,outer=0,ifm=0;int32_t selected=-1;
 if(!word(g.owner.queue+0x1a8,outer)||outer!=g.owner.outer_ifm||!word(outer,v)||v!=0xb7f960||
 !word(outer+0xfa8,ifm)||ifm!=g.owner.ifm||!word(ifm,v)||v!=0xb7ece0||
 !f3_executor_selected_get_01(outer+8,&selected)||selected<0)return F3_EXEC_REJECTED01;
 uintptr_t after=0;if(!word(outer+0xfa8,after)||after!=ifm||!word(g.owner.queue+0x1a8,after)||after!=outer)return F3_EXEC_REJECTED01;
 *out={g.owner,selected};return F3_EXEC_OK01;
}
/* Retire only a normally ended manual mailbox. RESERVED is a short own CAS
 * serialization state, not a new native request. It blocks begin/submit while
 * UI finish and SD saved admission race. Borrowed capture activity never retires
 * here: its original SD owner must receive the normal saved ACK. */
static int retire_finished_02(){
 if(__atomic_load_n(&g.hold,__ATOMIC_ACQUIRE)||state()==F3_EXEC_HOLD01)return F3_EXEC_UNKNOWN01;
 if(state()!=F3_EXEC_FINISHED01||__atomic_load_n(&g.in_callback,__ATOMIC_ACQUIRE))return F3_EXEC_BUSY01;
 if(__atomic_load_n(&g.borrowed_activity,__ATOMIC_ACQUIRE))return F3_EXEC_BUSY01;
 uint32_t expected=F3_EXEC_FINISHED01;
 if(!__atomic_compare_exchange_n(&g.state,&expected,F3_EXEC_RESERVED01,false,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))
  return expected==F3_EXEC_HOLD01?F3_EXEC_UNKNOWN01:F3_EXEC_BUSY01;
 if(__atomic_load_n(&g.borrowed_activity,__ATOMIC_ACQUIRE)){expected=F3_EXEC_RESERVED01;
  if(!__atomic_compare_exchange_n(&g.state,&expected,F3_EXEC_FINISHED01,false,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE)){iq4_f3_executor_hold_01();return F3_EXEC_UNKNOWN01;}
  return F3_EXEC_BUSY01;
 }
 const uint32_t result=__atomic_load_n(&g.result,__ATOMIC_ACQUIRE);
 if(__atomic_load_n(&g.hold,__ATOMIC_ACQUIRE)||__atomic_load_n(&g.in_callback,__ATOMIC_ACQUIRE)||
  !g.task.ticket||!g.task.run||!g.task.ui_completion_event||!g.task.sequence||g.task.sequence!=sequence()||
  (result!=1&&result!=2)||lease_valid()!=IQ4_ACTIVITY_REJECTED01){iq4_f3_executor_hold_01();return F3_EXEC_UNKNOWN01;}
 save_lease({});g.task={};expected=F3_EXEC_RESERVED01;
 if(!__atomic_compare_exchange_n(&g.state,&expected,F3_EXEC_IDLE01,false,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE)){iq4_f3_executor_hold_01();return F3_EXEC_UNKNOWN01;}
 return F3_EXEC_OK01;
}
extern "C" int iq4_f3_executor_begin_on_ui_01(F3ExecutorReservation01*out){
 if(!out||!on_ui())return F3_EXEC_REJECTED01;
 if(state()==F3_EXEC_FINISHED01){const int r=retire_finished_02();if(r!=F3_EXEC_OK01)return r;}
 if(state()==F3_EXEC_HOLD01)return F3_EXEC_UNKNOWN01;
 if(__atomic_load_n(&g.in_callback,__ATOMIC_ACQUIRE))return F3_EXEC_BUSY01;
 uint32_t expected=F3_EXEC_IDLE01;
 if(!__atomic_compare_exchange_n(&g.state,&expected,F3_EXEC_RESERVED01,false,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))return expected==F3_EXEC_HOLD01?F3_EXEC_UNKNOWN01:F3_EXEC_BUSY01;
 Iq4ActivityLease01 ticket{};int a=iq4_activity_try_01(IQ4_ACTIVITY_JPEG01,&g,&ticket);
 if(a!=IQ4_ACTIVITY_OK01){save_lease({});__atomic_store_n(&g.state,F3_EXEC_IDLE01,__ATOMIC_RELEASE);return F3_EXEC_BUSY01;}
 save_lease(ticket);uint64_t s=sequence();if(s==UINT64_MAX){iq4_f3_executor_hold_01();return F3_EXEC_UNKNOWN01;}
 __atomic_store_n(&g.sequence,s+1,__ATOMIC_RELEASE);__atomic_store_n(&g.borrowed_activity,0,__ATOMIC_RELEASE);__atomic_store_n(&g.result,0,__ATOMIC_RELEASE);g.task={};*out={s+1,ticket};return F3_EXEC_OK01;
}
extern "C" int iq4_f3_executor_cancel_on_ui_01(uint64_t seq){
 if(!on_ui()||state()!=F3_EXEC_RESERVED01||seq!=sequence()||__atomic_load_n(&g.borrowed_activity,__ATOMIC_ACQUIRE))return F3_EXEC_REJECTED01;
 if(lease_release()!=IQ4_ACTIVITY_OK01){iq4_f3_executor_hold_01();return F3_EXEC_UNKNOWN01;}
 save_lease({});__atomic_store_n(&g.state,F3_EXEC_IDLE01,__ATOMIC_RELEASE);return F3_EXEC_OK01;
}
extern "C" int iq4_f3_executor_submit_on_ui_01(const F3ExecutorTask01*t){
 if(!t||!on_ui()||state()!=F3_EXEC_RESERVED01||__atomic_load_n(&g.borrowed_activity,__ATOMIC_ACQUIRE)||!t->ticket||!t->run||t->sequence!=sequence()||
 !pointer(t->ui_completion_event)||lease_valid()!=IQ4_ACTIVITY_OK01)return F3_EXEC_REJECTED01;
 uintptr_t vt=0;if(!word(t->ui_completion_event,vt)||vt!=0xc237a0)return F3_EXEC_REJECTED01;
 g.task=*t;__atomic_store_n(&g.state,F3_EXEC_QUEUED01,__ATOMIC_RELEASE);
 if(!f3_executor_event_notify_01(g.event)){iq4_f3_executor_hold_01();return F3_EXEC_UNKNOWN01;}
 return F3_EXEC_OK01;
}
extern "C" int iq4_f3_executor_view_on_ui_01(F3ExecutorView01*out){
 if(!out||!on_ui())return F3_EXEC_REJECTED01;uint32_t s=state();
 if(!s)return F3_EXEC_REJECTED01;
 *out={s,__atomic_load_n(&g.result,__ATOMIC_ACQUIRE),sequence(),g.owner};return s==F3_EXEC_HOLD01?F3_EXEC_UNKNOWN01:F3_EXEC_OK01;
}
extern "C" int iq4_f3_executor_finish_on_ui_01(uint64_t seq){
 if(!on_ui()||state()!=F3_EXEC_FINISHED01||seq!=sequence()||__atomic_load_n(&g.in_callback,__ATOMIC_ACQUIRE))return F3_EXEC_REJECTED01;
 const int r=retire_finished_02();return r==F3_EXEC_BUSY01?F3_EXEC_REJECTED01:r;
}
static int saved_context_03(const F3CapturedRaw01*c,F3CaptureBorrow03&proof){
 uintptr_t q=0,vt=0;
 if(!c||!f3_executor_current_01(&q)||!pointer(q)||q==g.owner.queue||!word(q,vt)||
 vt==0xb91f48||vt==0xb805c0||!f3_executor_tid_01()||
 c->hold||c->state!=F3_CAPTURE_SAVED01||!c->exclusive_created||!c->writer_bound||
 !c->store_returned||!c->store_success||!c->close_returned||!c->close_success||c->writer_fd!=-1||c->raw_fd<0||
 !c->writer_thread||c->writer_thread!=f3_executor_pthread_self_01()||!pointer(c->storage))return F3_EXEC_REJECTED01;
 F3CaptureBorrow03 a{},b{};int first=f3_capture_saved_proof_03(c,&a),second=f3_capture_saved_proof_03(c,&b);
 if(first==F3_CAPTURE_PROOF_HOLD03||second==F3_CAPTURE_PROOF_HOLD03)return F3_EXEC_UNKNOWN01;
 if(first!=F3_CAPTURE_PROOF_OK03||second!=first||a.capture_sequence!=b.capture_sequence||a.card_id!=b.card_id||
 a.group_owner!=b.group_owner||a.activity.word!=b.activity.word||a.activity.owner!=b.activity.owner||
 !a.capture_sequence||!pointer(a.group_owner)||a.activity.owner!=a.group_owner||
 a.activity.word!=c->activity.word||a.activity.owner!=c->activity.owner||
 (a.card_id!=10&&a.card_id!=11)||!c->card||c->card->raw_id!=a.card_id||c->card->jpeg_id!=a.card_id||
 c->card->fs[0]!=c->native_fs||!word(c->storage,vt)||vt!=(a.card_id==10?0xdbc6b8:0xdbc280))return F3_EXEC_REJECTED01;
 const uint32_t bit=uint32_t(1)<<(a.card_id-10);
 if((a.selected_mask&~uint32_t(3))||(b.selected_mask&~uint32_t(3))||!(a.selected_mask&bit)||!(b.selected_mask&bit))return F3_EXEC_REJECTED01;
 const int activity=iq4_activity_valid_01(&a.activity);
 if(activity==IQ4_ACTIVITY_HELD01)return F3_EXEC_UNKNOWN01;
 if(activity!=IQ4_ACTIVITY_OK01)return F3_EXEC_REJECTED01;
 proof=a;return F3_EXEC_OK01;
}
static bool same_saved_03(const F3ExecutorSavedReservation03&r,const F3CapturedRaw01*c,const F3CaptureBorrow03&p){
 return r.mailbox.sequence&&r.mailbox.sequence==sequence()&&r.receipt==(uintptr_t)c&&
 r.group_owner==p.group_owner&&r.capture_sequence==p.capture_sequence&&r.card_id==p.card_id&&
 r.mailbox.activity.word==p.activity.word&&r.mailbox.activity.owner==p.activity.owner&&
 g.saved.mailbox.sequence==r.mailbox.sequence&&g.saved.receipt==r.receipt&&g.saved.group_owner==r.group_owner&&
 g.saved.capture_sequence==r.capture_sequence&&g.saved.card_id==r.card_id&&
 g.saved.mailbox.activity.word==r.mailbox.activity.word&&g.saved.mailbox.activity.owner==r.mailbox.activity.owner&&
 lease().word==p.activity.word&&lease().owner==p.activity.owner;
}
extern "C" int iq4_f3_executor_begin_saved_on_native_03(F3CapturedRaw01*c,F3ExecutorSavedReservation03*out){
 if(out)*out={};if(!out)return F3_EXEC_REJECTED01;
 F3CaptureBorrow03 proof{};int context=saved_context_03(c,proof);if(context!=F3_EXEC_OK01)return context;
 uint64_t start=f3_executor_clock_01();if(!start)return F3_EXEC_REJECTED01;
 for(;;){
  context=saved_context_03(c,proof);if(context!=F3_EXEC_OK01)return context;
  uint32_t s=state();if(s==F3_EXEC_NOT_BOUND01)return F3_EXEC_REJECTED01;if(s==F3_EXEC_HOLD01)return F3_EXEC_UNKNOWN01;
  if(s==F3_EXEC_FINISHED01&&!__atomic_load_n(&g.borrowed_activity,__ATOMIC_ACQUIRE)){
   int r=retire_finished_02();if(r==F3_EXEC_UNKNOWN01)return r;
  }
  uint32_t expected=F3_EXEC_IDLE01;
  if(!__atomic_load_n(&g.in_callback,__ATOMIC_ACQUIRE)&&
   __atomic_compare_exchange_n(&g.state,&expected,F3_EXEC_RESERVED01,false,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE)){
   uint64_t next=sequence();if(next==UINT64_MAX){iq4_f3_executor_hold_01();return F3_EXEC_UNKNOWN01;}
   save_lease(proof.activity);__atomic_store_n(&g.borrowed_activity,1,__ATOMIC_RELEASE);
   __atomic_store_n(&g.sequence,next+1,__ATOMIC_RELEASE);g.task={};__atomic_store_n(&g.result,0,__ATOMIC_RELEASE);
   g.saved={{next+1,proof.activity},(uintptr_t)c,proof.group_owner,proof.capture_sequence,proof.card_id};*out=g.saved;
   if(state()!=F3_EXEC_RESERVED01||__atomic_load_n(&g.hold,__ATOMIC_ACQUIRE)||lease_valid()!=IQ4_ACTIVITY_OK01){iq4_f3_executor_hold_01();return F3_EXEC_UNKNOWN01;}
   return F3_EXEC_OK01;
  }
  uint64_t now=f3_executor_clock_01();
  if(!now||now<start||now-start>=UINT64_C(600000000000)||!f3_executor_pause_01())return F3_EXEC_BUSY01;
 }
}
extern "C" int iq4_f3_executor_cancel_saved_on_native_03(F3CapturedRaw01*c,const F3ExecutorSavedReservation03*r){
 F3CaptureBorrow03 p{};int context=saved_context_03(c,p);if(context!=F3_EXEC_OK01)return context;
 if(!r||state()!=F3_EXEC_RESERVED01||__atomic_load_n(&g.in_callback,__ATOMIC_ACQUIRE)||
 !__atomic_load_n(&g.borrowed_activity,__ATOMIC_ACQUIRE)||!same_saved_03(*r,c,p)||
 g.task.ticket||g.task.run||g.task.sequence||g.task.ui_completion_event)return F3_EXEC_REJECTED01;
 if(__atomic_load_n(&g.hold,__ATOMIC_ACQUIRE)||lease_valid()!=IQ4_ACTIVITY_OK01){iq4_f3_executor_hold_01();return F3_EXEC_UNKNOWN01;}
 g.saved={};save_lease({});__atomic_store_n(&g.borrowed_activity,0,__ATOMIC_RELEASE);uint32_t expected=F3_EXEC_RESERVED01;
 if(!__atomic_compare_exchange_n(&g.state,&expected,F3_EXEC_IDLE01,false,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE)){iq4_f3_executor_hold_01();return F3_EXEC_UNKNOWN01;}
 return F3_EXEC_OK01;
}
extern "C" int iq4_f3_executor_invoke_reserved_saved_on_native_03(const F3ExecutorTask01*t,F3CapturedRaw01*c,const F3ExecutorSavedReservation03*r){
 F3CaptureBorrow03 p{};int context=saved_context_03(c,p);if(context!=F3_EXEC_OK01)return context;
 if(!t||!t->ticket||!t->run||t->ui_completion_event||!r||state()!=F3_EXEC_RESERVED01||
 __atomic_load_n(&g.in_callback,__ATOMIC_ACQUIRE)||!same_saved_03(*r,c,p)||
 !__atomic_load_n(&g.borrowed_activity,__ATOMIC_ACQUIRE)||g.task.ticket||g.task.run)return F3_EXEC_REJECTED01;
 g.task=*t;g.task.sequence=r->mailbox.sequence;uint64_t start=f3_executor_clock_01();
 if(!start){iq4_f3_executor_hold_01();return F3_EXEC_UNKNOWN01;}
 __atomic_store_n(&g.state,F3_EXEC_QUEUED01,__ATOMIC_RELEASE);
 if(!f3_executor_event_notify_01(g.event)){iq4_f3_executor_hold_01();return F3_EXEC_UNKNOWN01;}
 for(;;){uint32_t s=state();if(s==F3_EXEC_HOLD01)return F3_EXEC_UNKNOWN01;
  if(s==F3_EXEC_FINISHED01&&!__atomic_load_n(&g.in_callback,__ATOMIC_ACQUIRE)){
   context=saved_context_03(c,p);uint32_t result=__atomic_load_n(&g.result,__ATOMIC_ACQUIRE);
   if(context!=F3_EXEC_OK01||!same_saved_03(*r,c,p)||(result!=1&&result!=2)||lease_valid()!=IQ4_ACTIVITY_OK01){iq4_f3_executor_hold_01();return F3_EXEC_UNKNOWN01;}
   uint32_t expected=F3_EXEC_FINISHED01;
   if(!__atomic_compare_exchange_n(&g.state,&expected,F3_EXEC_RESERVED01,false,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))continue;
   if(__atomic_load_n(&g.hold,__ATOMIC_ACQUIRE)||__atomic_load_n(&g.in_callback,__ATOMIC_ACQUIRE)||lease_valid()!=IQ4_ACTIVITY_OK01){iq4_f3_executor_hold_01();return F3_EXEC_UNKNOWN01;}
   g.task={};g.saved={};save_lease({});__atomic_store_n(&g.borrowed_activity,0,__ATOMIC_RELEASE);expected=F3_EXEC_RESERVED01;
   if(!__atomic_compare_exchange_n(&g.state,&expected,F3_EXEC_IDLE01,false,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE)){iq4_f3_executor_hold_01();return F3_EXEC_UNKNOWN01;}
   return F3_EXEC_OK01;
  }
  uint64_t now=f3_executor_clock_01();
  if(!now||now<start||now-start>=UINT64_C(600000000000)||!f3_executor_pause_01()){iq4_f3_executor_hold_01();return F3_EXEC_UNKNOWN01;}
 }
}
extern "C" int iq4_f3_executor_invoke_saved_on_native_01(const F3ExecutorTask01*t,F3CapturedRaw01*c){
 if(!t||!t->ticket||!t->run||t->ui_completion_event)return F3_EXEC_REJECTED01;
 F3ExecutorSavedReservation03 r{};int result=iq4_f3_executor_begin_saved_on_native_03(c,&r);if(result!=F3_EXEC_OK01)return result;
 result=iq4_f3_executor_invoke_reserved_saved_on_native_03(t,c,&r);
 if(result==F3_EXEC_BUSY01||result==F3_EXEC_REJECTED01){int canceled=iq4_f3_executor_cancel_saved_on_native_03(c,&r);if(canceled!=F3_EXEC_OK01){iq4_f3_executor_hold_01();return F3_EXEC_UNKNOWN01;}}
 return result;
}
extern "C" uintptr_t iq4_f3_ifm_wait_entry_01(void*qptr,uint32_t timeout){
 uintptr_t q=(uintptr_t)qptr;
 /* Only this original native wait call's actual owner can bind/execute.
  * Rethrow the identical stock exception. A live own task additionally latches
  * Hold; no stock exception is translated, swallowed or turned into a result. */
 bool ours=timeout==0&&bind(q)&&on_worker(q);
 for(;;){uintptr_t listener;
  try{listener=iq4_f3_original_ifm_wait_01(qptr,timeout);}catch(...){
   uint32_t s=state();if(ours&&(s==F3_EXEC_RESERVED01||s==F3_EXEC_QUEUED01||s==F3_EXEC_RUNNING01))iq4_f3_executor_hold_01();throw;
  }
  if(!ours||listener!=(uintptr_t)g.listener)return listener;
  if(!on_worker(q)){iq4_f3_executor_hold_01();continue;}
  uint32_t expected=F3_EXEC_QUEUED01;
  if(!__atomic_compare_exchange_n(&g.state,&expected,F3_EXEC_RUNNING01,false,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))continue;
  __atomic_store_n(&g.in_callback,1,__ATOMIC_RELEASE);
  const F3ExecutorTask01 t=g.task;int r=-1;
  try{r=t.run(t.ticket,&g.owner);}catch(...){r=-1;}
  if((r!=0&&r!=1)||__atomic_load_n(&g.hold,__ATOMIC_ACQUIRE)){iq4_f3_executor_hold_01();__atomic_store_n(&g.in_callback,0,__ATOMIC_RELEASE);continue;}
  __atomic_store_n(&g.result,r?1:2,__ATOMIC_RELEASE);expected=F3_EXEC_RUNNING01;
  if(!__atomic_compare_exchange_n(&g.state,&expected,F3_EXEC_FINISHED01,false,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE)){
   iq4_f3_executor_hold_01();__atomic_store_n(&g.in_callback,0,__ATOMIC_RELEASE);continue;
  }
  if(!__atomic_load_n(&g.borrowed_activity,__ATOMIC_ACQUIRE)&&(!f3_executor_event_notify_01((void*)t.ui_completion_event)||
   __atomic_load_n(&g.hold,__ATOMIC_ACQUIRE)||lease_release()!=IQ4_ACTIVITY_OK01)){
   iq4_f3_executor_hold_01();__atomic_store_n(&g.in_callback,0,__ATOMIC_RELEASE);continue;
  }
  /* Keep the retired lease immutable until the UI sees in_callback==0 and
   * explicitly retires the mailbox. Never race its fields with a UI Hold. */
  __atomic_store_n(&g.in_callback,0,__ATOMIC_RELEASE);
  /* All original stock listeners are returned unchanged; our new listener
   * never reaches the original identity-based if/else dispatch. */
 }
}
#ifdef IQ4_F3_EXECUTOR_SYNTHETIC_HOST
extern "C" void iq4_f3_executor_fixture_reset_01(){memset(&g,0,sizeof g);}
extern "C" uintptr_t iq4_f3_executor_fixture_listener_01(){return (uintptr_t)g.listener;}
#endif
