#include "executor.h"
#include "native_calls.h"
#include "pins.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <deque>
#include <atomic>
#include <stdexcept>
#include <chrono>
#include "../f3_saved_raw_capture_01/capture.h"
alignas(16) static unsigned char bg[0x2a8],outer[0xfb0],ifm[0x340],ui[0x1d0],manager[0x10],completion[0xb8],sdthread[32],storage[32];
static std::mutex mutex;static std::condition_variable cv;static std::deque<uintptr_t> pending;
static std::atomic<unsigned> waits,constructors,notifications,ran;
static std::atomic<bool> bind_ready,notify_fail,pause_completion,at_completion,allow_completion;
static std::atomic<bool> pause_run,allow_run,forced_timeout,force_wait_throw;
static thread_local uintptr_t current;static thread_local uint64_t tid;
static int selected=7,run_result=1;static bool throw_run;
static uintptr_t event_pointer,listener_pointer;
static void put(void*p,size_t n,uintptr_t v){memcpy((char*)p+n,&v,8);}
extern "C" int f3_executor_read_01(uintptr_t a,void*out,size_t n){
 for(const auto&p:iq4_f3_executor_pins_01)if(a>=p.va&&a-p.va<=p.length&&n<=p.length-(a-p.va)){memcpy(out,p.bytes+a-p.va,n);return 1;}
 struct Span{uintptr_t a;size_t n;};Span spans[]={{(uintptr_t)bg,sizeof bg},{(uintptr_t)outer,sizeof outer},{(uintptr_t)ifm,sizeof ifm},{(uintptr_t)ui,sizeof ui},{(uintptr_t)manager,sizeof manager},{(uintptr_t)completion,sizeof completion},{(uintptr_t)storage,sizeof storage},{(uintptr_t)sdthread,sizeof sdthread},{listener_pointer,0x88},{event_pointer,0xb8}};
 for(const auto&s:spans)if(s.a&&a>=s.a&&a-s.a<=s.n&&n<=s.n-(a-s.a)){memcpy(out,(void*)a,n);return 1;}return 0;
}
extern "C" int f3_executor_current_01(uintptr_t*out){*out=current;return 1;}
extern "C" uint64_t f3_executor_tid_01(){return tid;}
extern "C" int f3_executor_event_ctor_01(void*p){event_pointer=(uintptr_t)p;put(p,0,0xc237a0);return 1;}
extern "C" int f3_executor_listener_ctor_01(void*p,void*e,uintptr_t q){listener_pointer=(uintptr_t)p;put(p,0,0xc23c90);put(p,8,(uintptr_t)e);put(p,0x30,q);++constructors;return 1;}
extern "C" int f3_executor_selected_get_01(uintptr_t a,int32_t*out){assert(a==(uintptr_t)outer+8);assert(current==(uintptr_t)ui);*out=selected;return 1;}
extern "C" uint64_t f3_executor_pthread_self_01(){return current==(uintptr_t)sdthread?0x1122:0;}
extern "C" uint64_t f3_executor_clock_01(){static thread_local unsigned reads;uint64_t real=(uint64_t)std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::steady_clock::now().time_since_epoch()).count();
 if(!forced_timeout){reads=0;return real;}return real+(reads++?UINT64_C(601000000000):0);}
extern "C" int f3_executor_pause_01(){std::this_thread::sleep_for(std::chrono::microseconds(10));return 1;}
static void enqueue(uintptr_t p){{std::lock_guard<std::mutex> lock(mutex);pending.push_back(p);}cv.notify_all();}
extern "C" int f3_executor_event_notify_01(void*p){++notifications;if(notify_fail)return 0;
 if(p==completion){at_completion=true;if(pause_completion){std::unique_lock<std::mutex> lock(mutex);cv.wait(lock,[]{return allow_completion.load();});}return 1;}
 assert((uintptr_t)p==event_pointer);enqueue(listener_pointer);return 1;
}
extern "C" uintptr_t iq4_f3_original_ifm_wait_01(void*q,uint32_t timeout){assert(q==bg&&timeout==0);++waits;bind_ready=true;cv.notify_all();
 std::unique_lock<std::mutex> lock(mutex);cv.wait(lock,[]{return !pending.empty();});uintptr_t p=pending.front();pending.pop_front();lock.unlock();
 if(p==0xdeadc0de||force_wait_throw)throw std::runtime_error("original Wait exception");return p;
}
static int run(void*t,const F3ExecutorOwner01*o){assert(t==(void*)0xabc0&&o->queue==(uintptr_t)bg&&o->ifm==(uintptr_t)ifm&&o->native_tid==2001);assert(current==(uintptr_t)bg&&tid==2001);++ran;
 if(pause_run){std::unique_lock<std::mutex> lock(mutex);cv.wait(lock,[]{return allow_run.load();});}
 if(throw_run)throw std::runtime_error("native task unknown");return run_result;
}
static void ui_context(){current=(uintptr_t)ui;tid=1001;}
static void reset(){iq4_f3_executor_fixture_reset_01();iq4_activity_fixture_reset_01(0);memset(bg,0,sizeof bg);memset(outer,0,sizeof outer);memset(ifm,0,sizeof ifm);memset(ui,0,sizeof ui);memset(manager,0,sizeof manager);memset(completion,0,sizeof completion);
 put(bg,0,0xb805c0);put(bg,0x1a8,(uintptr_t)outer);put(outer,0,0xb7f960);put(outer,0xfa8,(uintptr_t)ifm);put(ifm,0,0xb7ece0);put(ifm,0x328,(uintptr_t)outer);put(ui,0,0xb91f48);put(ui,0x1c8,(uintptr_t)manager);put(manager,0,0xb8f358);put(manager,8,(uintptr_t)ui);put(completion,0,0xc237a0);put(sdthread,0,0x777000);put(storage,0,0xdbc6b8);
 {std::lock_guard<std::mutex> lock(mutex);pending.clear();}waits=constructors=notifications=ran=0;bind_ready=notify_fail=pause_completion=at_completion=allow_completion=false;pause_run=allow_run=forced_timeout=force_wait_throw=false;event_pointer=listener_pointer=0;selected=7;run_result=1;throw_run=false;ui_context();}
static std::thread worker(uintptr_t&result,bool&thrown){return std::thread([&]{current=(uintptr_t)bg;tid=2001;try{result=iq4_f3_ifm_wait_entry_01(bg,0);}catch(const std::runtime_error&e){assert(!strcmp(e.what(),"original Wait exception"));thrown=true;}});}
static void ready(){std::unique_lock<std::mutex> lock(mutex);cv.wait(lock,[]{return bind_ready.load();});}
static F3ExecutorReservation01 begin(){F3ExecutorReservation01 r{};assert(iq4_f3_executor_begin_on_ui_01(&r)==F3_EXEC_OK01);assert(r.sequence&&iq4_activity_valid_01(&r.activity)==IQ4_ACTIVITY_OK01);return r;}
static void submit(F3ExecutorReservation01 r){F3ExecutorTask01 t{(void*)0xabc0,run,r.sequence,(uintptr_t)completion};assert(iq4_f3_executor_submit_on_ui_01(&t)==F3_EXEC_OK01);}
static void done(){for(unsigned n=0;n<20000&&!at_completion;++n)std::this_thread::yield();assert(at_completion);}
static void return_stock(std::thread&t,uintptr_t&result,bool&thrown,uintptr_t p=0x1234){enqueue(p);t.join();assert(!thrown&&result==p);}
static F3CapturedRaw01 receipt(){F3CapturedRaw01 c{};c.state=F3_CAPTURE_SAVED01;c.exclusive_created=c.writer_bound=c.store_returned=c.store_success=c.close_returned=c.close_success=1;c.writer_fd=-1;c.raw_fd=100;c.storage=(uintptr_t)storage;c.writer_thread=0x1122;return c;}
int main(){unsigned groups=0;
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();F3ExecutorSelection01 s{};assert(iq4_f3_executor_selection_on_ui_01(&s)==0&&s.index==7&&s.owner.ifm==(uintptr_t)ifm);auto r=begin();submit(r);return_stock(t,v,thrown);assert(ran==1&&constructors==1&&waits==2);F3ExecutorView01 view{};assert(iq4_f3_executor_view_on_ui_01(&view)==0&&view.state==4&&view.result==1);assert(iq4_activity_valid_01(&r.activity)==IQ4_ACTIVITY_REJECTED01);assert(iq4_f3_executor_finish_on_ui_01(r.sequence)==0);++groups;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();enqueue(0xdeadc0de);t.join();assert(thrown&&ran==0);++groups;}
 {reset();uintptr_t v=0;bool thrown=false;put(bg,0,0);auto t=worker(v,thrown);ready();return_stock(t,v,thrown);assert(constructors==0&&ran==0);++groups;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();Iq4ActivityLease01 movie{};int owner=1;assert(iq4_activity_try_01(4,&owner,&movie)==0);F3ExecutorReservation01 r{};assert(iq4_f3_executor_begin_on_ui_01(&r)==F3_EXEC_BUSY01);assert(iq4_activity_release_01(&movie)==0);r=begin();assert(iq4_f3_executor_cancel_on_ui_01(r.sequence)==0);assert(iq4_activity_valid_01(&r.activity)==2);return_stock(t,v,thrown);assert(ran==0);++groups;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();selected=-1;F3ExecutorSelection01 s{};assert(iq4_f3_executor_selection_on_ui_01(&s)==2);selected=1;put(ifm,0,0);assert(iq4_f3_executor_selection_on_ui_01(&s)==2);put(ifm,0,0xb7ece0);return_stock(t,v,thrown);++groups;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();auto r=begin();F3ExecutorTask01 bad{(void*)0xabc0,run,r.sequence+1,(uintptr_t)completion};assert(iq4_f3_executor_submit_on_ui_01(&bad)==2);assert(notifications==0);assert(iq4_f3_executor_cancel_on_ui_01(r.sequence)==0);return_stock(t,v,thrown);++groups;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();auto r=begin();notify_fail=true;F3ExecutorTask01 job{(void*)0xabc0,run,r.sequence,(uintptr_t)completion};assert(iq4_f3_executor_submit_on_ui_01(&job)==3);assert(iq4_activity_valid_01(&r.activity)==3);F3ExecutorReservation01 next{};assert(iq4_f3_executor_begin_on_ui_01(&next)==3);return_stock(t,v,thrown);assert(!ran);++groups;}
 for(unsigned kind=0;kind<2;++kind){reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();auto r=begin();run_result=-1;throw_run=kind;submit(r);return_stock(t,v,thrown);F3ExecutorView01 view{};assert(iq4_f3_executor_view_on_ui_01(&view)==3&&view.state==5&&ran==1);assert(iq4_activity_valid_01(&r.activity)==3);assert(iq4_f3_executor_finish_on_ui_01(r.sequence)==2);++groups;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();auto r=begin();run_result=0;submit(r);return_stock(t,v,thrown);F3ExecutorView01 view{};assert(iq4_f3_executor_view_on_ui_01(&view)==0&&view.result==2);assert(iq4_f3_executor_finish_on_ui_01(r.sequence)==0);++groups;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();auto r=begin();pause_completion=true;submit(r);done();F3ExecutorView01 view{};assert(iq4_f3_executor_view_on_ui_01(&view)==0&&view.state==4);assert(iq4_f3_executor_finish_on_ui_01(r.sequence)==2);F3ExecutorReservation01 next{};assert(iq4_f3_executor_begin_on_ui_01(&next)==1);allow_completion=true;cv.notify_all();return_stock(t,v,thrown);assert(iq4_f3_executor_finish_on_ui_01(r.sequence)==0);++groups;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();enqueue(listener_pointer);return_stock(t,v,thrown);assert(ran==0&&waits==2);++groups;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();auto r=begin();force_wait_throw=true;submit(r);t.join();assert(thrown&&ran==0&&iq4_activity_valid_01(&r.activity)==3);F3ExecutorView01 view{};assert(iq4_f3_executor_view_on_ui_01(&view)==3);++groups;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();auto c=receipt();assert(iq4_activity_try_01(3,&c,&c.activity)==0);current=(uintptr_t)sdthread;tid=3001;F3ExecutorTask01 task{(void*)0xabc0,run,0,0};assert(iq4_f3_executor_invoke_saved_on_native_01(&task,&c)==0);assert(ran==1&&iq4_activity_valid_01(&c.activity)==0);ui_context();F3ExecutorReservation01 n{};assert(iq4_f3_executor_begin_on_ui_01(&n)==1);assert(iq4_activity_release_01(&c.activity)==0);return_stock(t,v,thrown);++groups;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();auto c=receipt();assert(iq4_activity_try_01(3,&c,&c.activity)==0);F3ExecutorTask01 task{(void*)0xabc0,run,0,0};assert(iq4_f3_executor_invoke_saved_on_native_01(&task,&c)==2);current=(uintptr_t)sdthread;tid=3001;c.close_success=0;assert(iq4_f3_executor_invoke_saved_on_native_01(&task,&c)==2);c.close_success=1;c.writer_thread=99;assert(iq4_f3_executor_invoke_saved_on_native_01(&task,&c)==2);assert(!ran&&!notifications);assert(iq4_activity_release_01(&c.activity)==0);return_stock(t,v,thrown);++groups;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();auto c=receipt();assert(iq4_activity_try_01(3,&c,&c.activity)==0);current=(uintptr_t)sdthread;tid=3001;run_result=-1;F3ExecutorTask01 task{(void*)0xabc0,run,0,0};assert(iq4_f3_executor_invoke_saved_on_native_01(&task,&c)==3);assert(iq4_activity_valid_01(&c.activity)==3);return_stock(t,v,thrown);++groups;}
 {reset();uintptr_t v=0;bool thrown=false;auto t=worker(v,thrown);ready();auto c=receipt();assert(iq4_activity_try_01(3,&c,&c.activity)==0);current=(uintptr_t)sdthread;tid=3001;forced_timeout=pause_run=true;F3ExecutorTask01 task{(void*)0xabc0,run,0,0};assert(iq4_f3_executor_invoke_saved_on_native_01(&task,&c)==3);assert(iq4_activity_valid_01(&c.activity)==3);allow_run=true;cv.notify_all();return_stock(t,v,thrown);ui_context();F3ExecutorView01 view{};assert(iq4_f3_executor_view_on_ui_01(&view)==3&&view.state==5);++groups;}
 printf("PASS %u native-thread mailbox/exception/fence fault groups\n",groups);
}
