#include "page_bridge.hpp"
#include <cassert>
#include <iostream>
#include <memory>
#include <stdexcept>
#include <thread>
using namespace iq4;
using namespace iq4::f4::page;
thread_local Token token=11;
struct Host {unsigned entered{},rendered{},returned{},prepared{},encoded{},finalized{},aborted{},fenced{};std::atomic<unsigned> current_calls{0};bool render_ok=true,return_ok=true,prepare_ok=true,finalize_ok=true;std::atomic<Fence> fence{Fence::Ready};};
Token current(void* p) noexcept {++static_cast<Host*>(p)->current_calls;return token;}
bool enter(void* p,const View&) noexcept {assert(token==11);++static_cast<Host*>(p)->entered;return true;}
bool render(void* p,const View&) noexcept {assert(token==11);auto& h=*static_cast<Host*>(p);++h.rendered;return h.render_ok;}
bool back(void* p) noexcept {assert(token==11);auto& h=*static_cast<Host*>(p);++h.returned;return h.return_ok;}
Fence fence(void* p) noexcept {assert(token==22);auto& h=*static_cast<Host*>(p);++h.fenced;return h.fence.load();}
struct Backend final:runtime::Backend {
 Host& h;explicit Backend(Host& h):h(h){}
 void prepare() override {assert(token==22);++h.prepared;if(!h.prepare_ok)throw std::runtime_error("host prepare fixture");}
 void encode(const runtime::Frame&) override {assert(token==22);++h.encoded;}
 void finalize() override {assert(token==22);++h.finalized;if(!h.finalize_ok)throw std::runtime_error("host finalize fixture");}
 void abort() noexcept override {assert(token==22);++h.aborted;}
};
Capability capability(){return {1024,764,60,1,RateBasis::SoftwareCompletionNotifications,true,true,true,true,true,true,true,true};}
BindingGate gate(){return {native_static::UserSHA,11,22,true,true,true,true,true,true,true,true};}
struct Fixture {
 Host h;runtime::Recorder r{4,4096,std::make_unique<Backend>(h)};
 Session s{r,{&h,current,enter,render,back},{&h,fence},gate(),capability()};
 Fixture(){token=22;assert(s.publish_after_owned_worker_on_recorder()==Result::Ok);token=11;assert(s.poll_on_ui()==Result::Ok);assert(s.enter_on_ui()==Result::Ok);}
 ~Fixture(){token=22;if(r.state()==runtime::State::Recording)r.stop();if(r.state()==runtime::State::Error)r.reset_error();token=11;}
 Result execute(){token=22;auto x=s.execute_one_on_recorder();token=11;return x;}
 void poll(){assert(s.poll_on_ui()==Result::Ok);}
 void start(){assert(s.action_on_ui(Action::Start)==Result::Ok);assert(execute()==Result::Ok);poll();}
};
int main(){
#ifndef IQ4_F4_PAGE_SYNTHETIC_HOST
 Host h;runtime::Recorder r{4,4096,std::make_unique<Backend>(h)};Session s{r,{&h,current,enter,render,back},{&h,fence},gate(),capability()};
 assert(s.enter_on_ui()==Result::Disabled);assert(s.action_on_ui(Action::Start)==Result::Disabled);assert(s.poll_on_ui()==Result::Disabled);
 assert(s.execute_one_on_recorder()==Result::Disabled);assert(s.publish_after_owned_worker_on_recorder()==Result::Disabled);assert(s.completion_observation_on_ui(60)==Result::Disabled);
 assert(s.view_on_ui().state==PageState::Closed&&h.current_calls==0&&h.entered==0&&h.prepared==0);
 std::cout<<"production reject: zero ports/backend/native calls\n";return 0;
#else
 unsigned groups=0;
 {Fixture f;assert(f.s.action_on_ui(Action::Start)==Result::Ok);assert(f.h.prepared==0);assert(f.s.action_on_ui(Action::Start)==Result::Pending);assert(f.execute()==Result::Ok);f.poll();assert(!f.s.view_on_ui().recording_indicator);
  token=22;assert(f.r.submit({{1,2,3},1,{}}));assert(f.r.consume_one());assert(f.s.publish_after_owned_worker_on_recorder()==Result::Ok);token=11;f.poll();assert(f.s.view_on_ui().recording_indicator);++groups;}
 {Fixture f;token=22;assert(f.s.action_on_ui(Action::Start)==Result::WrongThread);assert(f.s.view_on_ui().state==PageState::Closed);token=11;assert(f.s.execute_one_on_recorder()==Result::WrongThread);assert(f.h.prepared==0);++groups;}
 {Fixture f;assert(!f.s.view_on_ui().rate_available);assert(f.s.completion_observation_on_ui(3695)==Result::Ok);assert(!f.s.view_on_ui().rate_available&&f.s.view_on_ui().measured_fps_num==0);assert(f.s.view_on_ui().actual_width==1024);++groups;}
 {Host h;runtime::Recorder r{4,4096,std::make_unique<Backend>(h)};auto c=capability();c.actual_card_lease=false;Session s{r,{&h,current,enter,render,back},{&h,fence},gate(),c};token=22;assert(s.publish_after_owned_worker_on_recorder()==Result::Ok);token=11;assert(s.poll_on_ui()==Result::Ok);assert(s.enter_on_ui()==Result::Ok);assert(s.view_on_ui().state==PageState::Unavailable&&!s.view_on_ui().mode_available);assert(s.action_on_ui(Action::Start)==Result::Unavailable);++groups;}
 {Fixture f;f.start();assert(f.s.action_on_ui(Action::Back)==Result::Ok);assert(f.h.returned==0);f.h.fence=Fence::Pending;assert(f.execute()==Result::Pending&&f.h.finalized==0);f.h.fence=Fence::Ready;assert(f.execute()==Result::Ok&&f.h.finalized==1);f.poll();assert(f.h.returned==1&&f.s.view_on_ui().state==PageState::Closed);++groups;}
 {Fixture f;f.start();f.h.finalize_ok=false;assert(f.s.action_on_ui(Action::Stop)==Result::Ok);assert(f.execute()==Result::Hold);f.poll();assert(f.s.view_on_ui().state==PageState::Error&&f.h.returned==0);assert(f.s.action_on_ui(Action::Back)==Result::Ok);assert(f.execute()==Result::Ok);f.poll();assert(f.s.view_on_ui().recording.failed_session_aborted&&f.s.view_on_ui().state==PageState::Closed);++groups;}
 {Fixture f;f.h.prepare_ok=false;assert(f.s.action_on_ui(Action::Start)==Result::Ok);assert(f.execute()==Result::Hold);f.poll();assert(f.s.view_on_ui().state==PageState::Error);assert(f.s.action_on_ui(Action::ResetError)==Result::Ok);assert(f.execute()==Result::Ok);f.poll();assert(f.s.view_on_ui().state==PageState::Ready);++groups;}
 {Fixture f;token=22;for(int i=0;i<16;++i)assert(f.s.publish_after_owned_worker_on_recorder()==Result::Ok);assert(f.s.publish_after_owned_worker_on_recorder()==Result::QueueFull);token=11;assert(f.s.action_on_ui(Action::Start)==Result::Ok);assert(f.execute()==Result::QueueFull&&f.h.prepared==0);f.poll();assert(f.execute()==Result::Ok);f.poll();assert(f.s.status_updates_dropped()==1);++groups;}
 {Fixture f;f.h.render_ok=false;assert(f.s.action_on_ui(Action::Start)==Result::Hold);assert(f.execute()==Result::Hold&&f.h.prepared==0);assert(f.s.view_on_ui().state==PageState::Hold);assert(f.h.fenced==1&&f.s.UI_hold_progress()==HoldProgress::QuiescedNoRecording);++groups;}
 {Fixture f;f.start();f.h.render_ok=false;assert(f.s.completion_observation_on_ui(1)==Result::Hold);f.h.fence=Fence::Pending;
  assert(f.execute()==Result::Hold&&f.h.finalized==0&&f.r.state()==runtime::State::Recording);assert(f.s.UI_hold_progress()==HoldProgress::Pending);
  token=22;assert(f.s.publish_after_owned_worker_on_recorder()==Result::Hold);token=11;assert(f.h.finalized==0&&f.h.fenced==2);
  f.h.fence=Fence::Ready;assert(f.execute()==Result::Hold&&f.h.finalized==1&&f.r.state()==runtime::State::Idle);assert(f.s.UI_hold_progress()==HoldProgress::Finalized);
  assert(f.execute()==Result::Hold&&f.h.finalized==1&&f.h.fenced==3&&f.h.returned==0);++groups;}
 {Fixture f;f.start();f.h.render_ok=false;assert(f.s.completion_observation_on_ui(1)==Result::Hold);f.h.fence=Fence::Unknown;
  assert(f.execute()==Result::Hold&&f.h.finalized==0&&f.r.state()==runtime::State::Recording);assert(f.s.UI_hold_progress()==HoldProgress::Unknown);
  f.h.fence=Fence::Ready;assert(f.execute()==Result::Hold&&f.h.fenced==1&&f.h.finalized==0&&f.h.returned==0);
  assert(f.s.UI_hold_progress()==HoldProgress::Unknown&&f.s.view_on_ui().native_context_retained);++groups;}
 {Fixture f;assert(f.s.action_on_ui(Action::Start)==Result::Ok);f.h.render_ok=false;assert(f.s.completion_observation_on_ui(1)==Result::Hold);
  f.h.fence=Fence::Pending;assert(f.execute()==Result::Hold&&f.h.prepared==0&&f.h.finalized==0);f.h.fence=Fence::Ready;
  assert(f.execute()==Result::Hold&&f.r.state()==runtime::State::Idle&&f.h.prepared==0&&f.h.finalized==0);assert(f.s.UI_hold_progress()==HoldProgress::QuiescedNoRecording);
  assert(f.execute()==Result::Hold&&f.h.prepared==0&&f.h.returned==0&&f.h.fenced==2);++groups;}
 {Fixture f;f.start();f.h.finalize_ok=false;f.h.render_ok=false;assert(f.s.completion_observation_on_ui(1)==Result::Hold);
  assert(f.execute()==Result::Hold&&f.h.finalized==1&&f.r.state()==runtime::State::Error);assert(f.s.UI_hold_progress()==HoldProgress::FinalizeFailed);
  assert(f.execute()==Result::Hold&&f.h.finalized==1&&f.h.fenced==1&&f.h.returned==0);++groups;}
 {Fixture f;f.start();assert(f.s.action_on_ui(Action::Back)==Result::Ok);f.h.fence=Fence::Unknown;assert(f.execute()==Result::Hold);assert(f.s.poll_on_ui()==Result::Hold);assert(f.h.finalized==0&&f.h.returned==0);++groups;}
 {Fixture f;assert(f.s.completion_observation_on_ui(10)==Result::Ok);assert(f.s.completion_observation_on_ui(9)==Result::Hold);assert(f.s.view_on_ui().state==PageState::Hold);++groups;}
 {Fixture f;for(int i=0;i<20;++i){f.start();assert(f.s.action_on_ui(Action::Stop)==Result::Ok);assert(f.execute()==Result::Ok);f.poll();}assert(f.h.prepared==20&&f.h.finalized==20);++groups;}
 {bool BindingGate::* flags[]={&BindingGate::actual_whole_User_and_mapped_functions,&BindingGate::bootstrap03_actual_UI_boundary,&BindingGate::native_page_ctor_vtable_ABI,&BindingGate::native_display_surface_resources,&BindingGate::native_touch_action_mapping,&BindingGate::native_current_page_and_return_LV,&BindingGate::native_undo_and_lifetimes,&BindingGate::source_stop_drain_fence_binding};
  for(auto flag:flags){Host h;runtime::Recorder r{4,4096,std::make_unique<Backend>(h)};auto g=gate();g.*flag=false;Session s{r,{&h,current,enter,render,back},{&h,fence},g,capability()};assert(s.enter_on_ui()==Result::Disabled&&h.current_calls==0&&h.entered==0);}++groups;}
 {Fixture f;f.start();token=22;f.r.source_lost();assert(f.s.publish_after_owned_worker_on_recorder()==Result::Ok);token=11;f.poll();assert(f.s.view_on_ui().state==PageState::Error&&f.s.view_on_ui().recording.error==ErrorCode::RecorderFailure);assert(!f.s.view_on_ui().rate_available);++groups;}
 {Host h;runtime::Recorder r{4,4096,std::make_unique<Backend>(h)};auto c=capability();c.rate_basis=RateBasis::MeasuredDistinctCaptureFrames;c.capture_rate_independently_verified=false;Session noRate{r,{&h,current,enter,render,back},{&h,fence},gate(),c};assert(noRate.enter_on_ui()==Result::Ok&&!noRate.view_on_ui().rate_available);c.capture_rate_independently_verified=true;Session measured{r,{&h,current,enter,render,back},{&h,fence},gate(),c};assert(measured.enter_on_ui()==Result::Ok&&measured.view_on_ui().rate_available&&measured.view_on_ui().measured_fps_num==60);++groups;}
 {Fixture f;f.start();f.h.return_ok=false;assert(f.s.action_on_ui(Action::Back)==Result::Ok);assert(f.execute()==Result::Ok&&f.h.finalized==1);assert(f.s.poll_on_ui()==Result::Hold);assert(f.s.view_on_ui().native_context_retained&&f.h.returned==1);assert(f.s.poll_on_ui()==Result::Hold&&f.h.returned==1);++groups;}
 {Fixture f;std::atomic<bool> done{false};f.h.fence=Fence::Pending;
  std::thread worker([&]{token=22;while(!done.load()){f.s.execute_one_on_recorder();f.s.publish_after_owned_worker_on_recorder();std::this_thread::yield();}});
  assert(f.s.action_on_ui(Action::Start)==Result::Ok);
  unsigned attempts=0;while(f.s.view_on_ui().state!=PageState::Recording){assert(++attempts<1000000);assert(f.s.poll_on_ui()==Result::Ok);std::this_thread::yield();}
  f.h.render_ok=false;assert(f.s.completion_observation_on_ui(1)==Result::Hold);
  attempts=0;while(f.s.UI_hold_progress()!=HoldProgress::Pending){assert(++attempts<1000000);std::this_thread::yield();}
  f.h.fence=Fence::Ready;attempts=0;while(f.s.UI_hold_progress()!=HoldProgress::Finalized){assert(++attempts<1000000);std::this_thread::yield();}
  done.store(true);worker.join();assert(f.h.prepared==1&&f.h.finalized==1&&f.h.returned==0);assert(f.s.view_on_ui().state==PageState::Hold);++groups;}
 {Ring<std::uint64_t,16> q;std::thread producer([&]{for(std::uint64_t i=1;i<=20000;++i)while(!q.push(i))std::this_thread::yield();});std::uint64_t x=0;for(std::uint64_t i=1;i<=20000;++i){while(!q.pop(x))std::this_thread::yield();assert(x==i);}producer.join();++groups;}
 assert(groups==22);std::cout<<"22 own-code page groups passed; no vendor/UI/device calls\n";
#endif
}
