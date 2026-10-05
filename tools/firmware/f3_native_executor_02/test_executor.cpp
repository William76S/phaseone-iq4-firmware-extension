#include "executor.cpp"
#include "inherited_fixture_02.inc"
static void finished_manual(std::thread&t,F3ExecutorReservation01&r){
 ready();r=begin();submit(r);
 for(unsigned i=0;i<200000&&waits<2;++i)std::this_thread::yield();
 assert(waits>=2&&state()==F3_EXEC_FINISHED01&&!__atomic_load_n(&g.in_callback,__ATOMIC_ACQUIRE));
 assert(iq4_activity_valid_01(&r.activity)==IQ4_ACTIVITY_REJECTED01);(void)t;
}
static int saved(F3CapturedRaw01&c){current=(uintptr_t)sdthread;tid=3001;F3ExecutorTask01 task{(void*)0xabc0,run,0,0};return iq4_f3_executor_invoke_saved_on_native_01(&task,&c);}
int main(){inherited_executor_regressions();unsigned focused=0;
 for(int result: {1,0}){reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);run_result=result;F3ExecutorReservation01 r{};finished_manual(t,r);
  auto c=receipt();assert(iq4_activity_try_01(3,&c,&c.activity)==0);assert(saved(c)==0&&ran==2&&state()==F3_EXEC_IDLE01&&sequence()==r.sequence+1);
  assert(iq4_activity_valid_01(&c.activity)==0);assert(iq4_activity_release_01(&c.activity)==0);ui_context();return_stock(t,v,thrown);++focused;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);F3ExecutorReservation01 r{};finished_manual(t,r);auto next=begin();assert(next.sequence==r.sequence+1);assert(iq4_f3_executor_cancel_on_ui_01(next.sequence)==0);return_stock(t,v,thrown);++focused;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();auto r=begin();pause_completion=true;submit(r);done();
  const auto seq=sequence();const auto ticket=g.task.ticket;assert(retire_finished_02()==F3_EXEC_BUSY01&&state()==F3_EXEC_FINISHED01&&sequence()==seq&&g.task.ticket==ticket&&iq4_activity_valid_01(&r.activity)==0);
  allow_completion=true;cv.notify_all();return_stock(t,v,thrown);assert(iq4_f3_executor_finish_on_ui_01(r.sequence)==0);++focused;}
 {reset();__atomic_store_n(&g.state,F3_EXEC_FINISHED01,__ATOMIC_RELEASE);__atomic_store_n(&g.borrowed_activity,1,__ATOMIC_RELEASE);g.task.ticket=(void*)0xabc0;
  assert(retire_finished_02()==F3_EXEC_BUSY01&&state()==F3_EXEC_FINISHED01&&g.task.ticket==(void*)0xabc0);++focused;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);F3ExecutorReservation01 r{};finished_manual(t,r);Iq4ActivityLease01 foreign{};int owner=1;assert(iq4_activity_try_01(3,&owner,&foreign)==0);save_lease(foreign);
  assert(retire_finished_02()==F3_EXEC_UNKNOWN01&&state()==F3_EXEC_HOLD01&&iq4_activity_valid_01(&foreign)==IQ4_ACTIVITY_HELD01);return_stock(t,v,thrown);++focused;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);F3ExecutorReservation01 r{};finished_manual(t,r);iq4_f3_executor_hold_01();auto c=receipt();assert(iq4_activity_try_01(3,&c,&c.activity)==0);
  assert(saved(c)==F3_EXEC_UNKNOWN01&&ran==1&&state()==F3_EXEC_HOLD01&&iq4_activity_valid_01(&c.activity)==0);assert(iq4_activity_release_01(&c.activity)==0);ui_context();return_stock(t,v,thrown);++focused;}
 for(unsigned round=0;round<32;++round){reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);F3ExecutorReservation01 r{};finished_manual(t,r);auto c=receipt();assert(iq4_activity_try_01(3,&c,&c.activity)==0);std::atomic<bool> go{false};int sr=-1;
  auto sd=std::thread([&]{while(!go.load())std::this_thread::yield();sr=saved(c);});go=true;int ur=iq4_f3_executor_finish_on_ui_01(r.sequence);sd.join();
  assert(iq4_activity_valid_01(&c.activity)==0&&state()==F3_EXEC_IDLE01);
  if(sr==F3_EXEC_OK01)assert((ur==F3_EXEC_OK01||ur==F3_EXEC_REJECTED01)&&ran==2);
  else assert(sr==F3_EXEC_BUSY01&&ur==F3_EXEC_OK01&&ran==1); /* no enqueue, no retry, RAW owner remains live */assert(iq4_activity_release_01(&c.activity)==0);return_stock(t,v,thrown);}
 ++focused;printf("{\"focused_groups\":%u,\"finish_SD_race_repetitions\":32,\"inherited_groups\":17,\"actual_executor_body\":true,\"native_callbacks_fixture\":true,\"target_executed\":false}\n",focused);
}
