#include "executor.cpp"
#include "inherited_fixture_03.inc"
static std::atomic<unsigned> proof_fault,proof_calls;
static void reset_proof_fixture(){proof_fault=proof_calls=0;}
extern "C" int f3_capture_saved_proof_03(const F3CapturedRaw01*c,F3CaptureBorrow03*out){
 if(!c||!out||!c->card)return F3_CAPTURE_PROOF_REJECTED03;
 unsigned call=proof_calls++;if(proof_fault==1)return F3_CAPTURE_PROOF_REJECTED03;
 if(proof_fault==2)return F3_CAPTURE_PROOF_HOLD03;
 *out={c->ticket.sequence,c->card->raw_id,3,c->activity.owner,c->activity};
 if(proof_fault==3&&call&1)++out->capture_sequence;
 if(proof_fault==4)out->card_id=11;
 if(proof_fault==5)out->group_owner+=16;
 if(proof_fault==6)out->selected_mask=0;
 if(proof_fault==7)out->selected_mask=call&1?3:1;
 return F3_CAPTURE_PROOF_OK03;
}
static void native_context(unsigned card){current=(uintptr_t)(card==10?sdthread:xqdthread);tid=card==10?3001:4001;}
static F3CapturedRaw01 card_receipt(unsigned card){auto c=receipt();if(card==11){c.card=&cards[1];c.native_fs=cards[1].fs[0];c.storage=(uintptr_t)xqdstorage;c.writer_thread=0x3344;}return c;}
alignas(16) static uint64_t group_owner[2];
static Iq4ActivityLease01 group_lease(){Iq4ActivityLease01 lease{};assert(iq4_activity_try_01(3,group_owner,&lease)==0);return lease;}
static F3ExecutorTask01 task(){return {(void*)0xabc0,run,0,0};}
static int reserve(F3CapturedRaw01&c,F3ExecutorSavedReservation03&r){native_context(c.card->raw_id);return iq4_f3_executor_begin_saved_on_native_03(&c,&r);}
static int invoke(F3CapturedRaw01&c,const F3ExecutorSavedReservation03&r){native_context(c.card->raw_id);auto t=task();return iq4_f3_executor_invoke_reserved_saved_on_native_03(&t,&c,&r);}
int main(){inherited_executor_regressions();unsigned focused=0;
 for(unsigned card: {10u,11u})for(int result: {0,1}){reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();auto c=card_receipt(card);c.activity=group_lease();run_result=result;
  F3ExecutorSavedReservation03 r{};assert(reserve(c,r)==0&&state()==F3_EXEC_RESERVED01&&notifications==0&&ran==0&&r.card_id==card&&r.capture_sequence==111);
  assert(invoke(c,r)==0&&ran==1&&state()==F3_EXEC_IDLE01&&iq4_activity_valid_01(&c.activity)==0);
  assert(iq4_activity_release_01(&c.activity)==0);return_stock(t,v,thrown);++focused;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();auto a=card_receipt(10),b=card_receipt(11);a.activity=b.activity=group_lease();
  F3ExecutorSavedReservation03 ar{},br{};assert(reserve(a,ar)==0&&iq4_f3_executor_cancel_saved_on_native_03(&a,&ar)==0&&state()==F3_EXEC_IDLE01&&!notifications&&!ran&&iq4_activity_valid_01(&a.activity)==0);
  assert(reserve(b,br)==0&&br.mailbox.sequence==ar.mailbox.sequence+1&&invoke(b,br)==0&&ran==1);assert(iq4_activity_release_01(&b.activity)==0);return_stock(t,v,thrown);++focused;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();auto a=card_receipt(10),b=card_receipt(11);a.activity=b.activity=group_lease();F3ExecutorSavedReservation03 ar{},br{};
  assert(reserve(a,ar)==0);int second=-1;std::thread other([&]{second=reserve(b,br);if(second==0)second=invoke(b,br);});
  while(proof_calls<6)std::this_thread::yield();assert(!notifications&&!ran&&state()==F3_EXEC_RESERVED01);
  assert(invoke(a,ar)==0);other.join();assert(second==0&&ran==2&&state()==F3_EXEC_IDLE01&&br.mailbox.sequence==ar.mailbox.sequence+1);
  assert(iq4_activity_valid_01(&a.activity)==0&&iq4_activity_release_01(&a.activity)==0);return_stock(t,v,thrown);++focused;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();auto a=card_receipt(10),b=card_receipt(11);a.activity=b.activity=group_lease();F3ExecutorSavedReservation03 ar{},br{};
  assert(reserve(a,ar)==0);forced_timeout=true;assert(reserve(b,br)==F3_EXEC_BUSY01&&state()==F3_EXEC_RESERVED01&&!notifications&&!ran&&iq4_activity_valid_01(&a.activity)==0);
  forced_timeout=false;native_context(10);assert(iq4_f3_executor_cancel_saved_on_native_03(&a,&ar)==0&&iq4_activity_release_01(&a.activity)==0);return_stock(t,v,thrown);++focused;}
 for(unsigned fault: {1u,2u,3u,4u,5u,6u}){reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();auto c=card_receipt(10);c.activity=group_lease();proof_fault=fault;F3ExecutorSavedReservation03 r{};
  assert(reserve(c,r)==(fault==2?F3_EXEC_UNKNOWN01:F3_EXEC_REJECTED01)&&state()==F3_EXEC_IDLE01&&!notifications&&!ran&&iq4_activity_valid_01(&c.activity)==0);
  assert(iq4_activity_release_01(&c.activity)==0);return_stock(t,v,thrown);++focused;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();auto c=card_receipt(10);c.activity=group_lease();proof_fault=7;F3ExecutorSavedReservation03 r{};
  assert(reserve(c,r)==0&&invoke(c,r)==0&&ran==1);assert(iq4_activity_release_01(&c.activity)==0);return_stock(t,v,thrown);++focused;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();auto a=card_receipt(10),b=card_receipt(11);a.activity=b.activity=group_lease();F3ExecutorSavedReservation03 ar{};
  assert(reserve(a,ar)==0);native_context(11);assert(iq4_f3_executor_cancel_saved_on_native_03(&b,&ar)==F3_EXEC_REJECTED01&&state()==F3_EXEC_RESERVED01&&!notifications);
  auto forged=ar;forged.capture_sequence++;native_context(10);assert(iq4_f3_executor_cancel_saved_on_native_03(&a,&forged)==F3_EXEC_REJECTED01);
  assert(iq4_f3_executor_cancel_saved_on_native_03(&a,&ar)==0&&iq4_activity_release_01(&a.activity)==0);return_stock(t,v,thrown);++focused;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();auto c=card_receipt(10);c.activity=group_lease();F3ExecutorSavedReservation03 r{};assert(reserve(c,r)==0);
  ui_context();auto ui_task=task();ui_task.sequence=r.mailbox.sequence;ui_task.ui_completion_event=(uintptr_t)completion;
  assert(iq4_f3_executor_cancel_on_ui_01(r.mailbox.sequence)==F3_EXEC_REJECTED01&&iq4_f3_executor_submit_on_ui_01(&ui_task)==F3_EXEC_REJECTED01&&state()==F3_EXEC_RESERVED01&&!notifications&&iq4_activity_valid_01(&c.activity)==0);
  native_context(10);assert(iq4_f3_executor_cancel_saved_on_native_03(&c,&r)==0&&iq4_activity_release_01(&c.activity)==0);return_stock(t,v,thrown);++focused;}
 for(unsigned failure: {0u,1u}){reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();auto c=card_receipt(11);c.activity=group_lease();F3ExecutorSavedReservation03 r{};assert(reserve(c,r)==0);
  if(failure)run_result=-1;else notify_fail=true;
  assert(invoke(c,r)==F3_EXEC_UNKNOWN01&&state()==F3_EXEC_HOLD01&&iq4_activity_valid_01(&c.activity)==IQ4_ACTIVITY_HELD01);
  assert(iq4_f3_executor_cancel_saved_on_native_03(&c,&r)==F3_EXEC_UNKNOWN01);return_stock(t,v,thrown);++focused;}
 printf("{\"focused_groups\":%u,\"inherited_groups\":17,\"actual_executor_body\":true,\"producer_proof_is_host_mock\":true,\"single_worker_group_activity_not_released\":true,\"target_executed\":false}\n",focused);
}
