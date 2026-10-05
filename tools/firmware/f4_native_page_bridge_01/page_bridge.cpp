#include "page_bridge.hpp"
#include <cstring>
namespace iq4::f4::page {
namespace {
bool permitted(const UIPort& p,const WorkerFence& f,const BindingGate& g) noexcept {
#ifndef IQ4_F4_PAGE_SYNTHETIC_HOST
    (void)p;(void)f;(void)g;return false; // Production has no verified binder yet.
#else
    return p.current_thread&&p.enter_native_page&&p.render_native_page&&p.return_original_LV&&
      g.UserSHA&&!std::strcmp(g.UserSHA,native_static::UserSHA)&&g.ui_owner&&g.recorder_owner&&g.ui_owner!=g.recorder_owner&&
      g.actual_whole_User_and_mapped_functions&&g.bootstrap03_actual_UI_boundary&&g.native_page_ctor_vtable_ABI&&g.native_display_surface_resources&&
      g.native_touch_action_mapping&&g.native_current_page_and_return_LV&&g.native_undo_and_lifetimes&&g.source_stop_drain_fence_binding&&f.quiesce_source_and_owned_pool;
#endif
}
}
Session::Session(runtime::Recorder& r,UIPort p,WorkerFence f,BindingGate g,Capability c) noexcept:
 recorder_(r),port_(p),fence_(f),gate_(g),capability_(c),configured_(permitted(p,f,g)) {}
bool Session::on(Token t) const noexcept {return configured_&&port_.current_thread(port_.context)==t;}
bool Session::mode_available() const noexcept {
 return capability_.width&&capability_.height&&capability_.width<=65535&&capability_.height<=65535&&
 capability_.actual_clean_source&&capability_.actual_layout_and_color&&capability_.actual_encoder&&
 capability_.actual_card_lease&&capability_.actual_card_publish_and_recovery&&capability_.actual_worker&&capability_.actual_mode;
}
bool Session::rate_available() const noexcept {
 return mode_available()&&capability_.rate_basis==RateBasis::MeasuredDistinctCaptureFrames&&
 capability_.capture_rate_independently_verified&&capability_.fps_num&&capability_.fps_den;
}
View Session::view_on_ui() const noexcept {
 View v{};if(!on(gate_.ui_owner))return v;v.recording=snapshot_;v.completion_notifications=completion_notifications_;
 if(!active_)return v;if(hold_){v.state=PageState::Hold;return v;}
 v.mode_available=mode_available();v.rate_available=rate_available();
 if(v.mode_available){v.actual_width=capability_.width;v.actual_height=capability_.height;}
 if(v.rate_available){v.measured_fps_num=capability_.fps_num;v.measured_fps_den=capability_.fps_den;}
 v.recording_indicator=snapshot_.recorder==runtime::State::Recording&&snapshot_.first_packet_encoded;
 if(pending_){v.state=pending_action_==Action::Start?PageState::StartPending:pending_action_==Action::Stop?PageState::StopPending:pending_action_==Action::Back?PageState::BackPending:PageState::ResetPending;return v;}
 v.back_enabled=worker_synced_;
 if(snapshot_.recorder==runtime::State::Error||snapshot_.worker_exception){v.state=PageState::Error;return v;}
 if(snapshot_.recorder==runtime::State::Recording){v.state=PageState::Recording;v.stop_enabled=true;return v;}
 if(snapshot_.recorder==runtime::State::Preparing||snapshot_.recorder==runtime::State::Finalizing){v.state=PageState::StopPending;v.back_enabled=false;return v;}
 v.start_enabled=worker_synced_&&v.mode_available;v.state=v.start_enabled?PageState::Ready:PageState::Unavailable;return v;
}
bool Session::render_on_ui() noexcept {if(!active_)return true;if(!port_.render_native_page(port_.context,view_on_ui())){hold_on_ui();return false;}return true;}
void Session::hold_on_ui() noexcept {hold_=true;if(snapshot_.error==ErrorCode::None)snapshot_.error=ErrorCode::NativeUIUnknown;UI_hold_stop_required_.store(true,std::memory_order_release);}
Result Session::enter_on_ui() noexcept {
 if(!configured_)return Result::Disabled;if(!on(gate_.ui_owner))return Result::WrongThread;
 if(active_||hold_)return Result::WrongState;
 active_=true;if(!port_.enter_native_page(port_.context,view_on_ui())){hold_on_ui();return Result::Hold;}
 return render_on_ui()?Result::Ok:Result::Hold;
}
Result Session::action_on_ui(Action action) noexcept {
 if(!configured_)return Result::Disabled;if(!on(gate_.ui_owner))return Result::WrongThread;
 if(!active_||hold_)return Result::WrongState;if(pending_)return Result::Pending;
 if(!worker_synced_)return Result::Unavailable;
 const auto v=view_on_ui();
 if(action==Action::Start&&!v.start_enabled)return Result::Unavailable;
 if(action==Action::Stop&&!v.stop_enabled)return Result::WrongState;
 if(action==Action::ResetError&&snapshot_.recorder!=runtime::State::Error)return Result::WrongState;
 if(action!=Action::Start&&action!=Action::Stop&&action!=Action::Back&&action!=Action::ResetError)return Result::WrongState;
 if(serial_==UINT64_MAX){hold_on_ui();return Result::Hold;}
 Request r{action,serial_+1};if(!requests_.can_push())return Result::QueueFull;
 serial_=r.serial;pending_serial_=r.serial;pending_action_=action;pending_=true;
 // Publish only after native UI accepted the pending state. A render failure
 // cannot race a newly enqueued Start on the worker.
 if(!render_on_ui())return Result::Hold;
 if(!requests_.push(r)){hold_on_ui();return Result::Hold;}return Result::Ok;
}
Snapshot Session::snapshot_on_recorder() const noexcept {
 const auto& c=recorder_.counters();Snapshot s{recorder_.state(),c.accepted,c.encoded,c.dropped_queue_full,c.rejected_timestamp,
 recorder_.recording_indicator(),c.source_loss_known,false,false,ErrorCode::None};
 if(s.recorder==runtime::State::Error)s.error=ErrorCode::RecorderFailure;
 return s;
}
bool Session::stop_for_UI_hold_on_recorder() noexcept {
 if(!UI_hold_stop_required_.load(std::memory_order_acquire))return false;
 if(worker_hold_terminal_)return true;
 // A UI failure cannot bypass the normal source-owner/pool fence. Pending
 // keeps all queued commands untouched, including an earlier unconsumed Start.
 // Unknown retains the open context and never attempts finalize or a retry.
 const auto fence=fence_.quiesce_source_and_owned_pool(fence_.context);
 if(fence==Fence::Pending){worker_hold_progress_.store(HoldProgress::Pending,std::memory_order_release);return true;}
 worker_hold_terminal_=true;
 if(fence!=Fence::Ready){worker_hold_progress_.store(HoldProgress::Unknown,std::memory_order_release);return true;}
 HoldProgress progress=HoldProgress::FinalizeFailed;
 try {
   switch(recorder_.state()){
     case runtime::State::Recording:progress=recorder_.stop()?HoldProgress::Finalized:HoldProgress::FinalizeFailed;break;
     case runtime::State::Idle:progress=HoldProgress::QuiescedNoRecording;break;
     case runtime::State::Error:progress=HoldProgress::QuiescedError;break;
     default:break; // Preparing/Finalizing are not completion proof.
   }
 }catch(...){}
 worker_hold_progress_.store(progress,std::memory_order_release);
 return true; // No return/detach/finalization success inferred on unknown UI.
}
Result Session::publish_after_owned_worker_on_recorder() noexcept {
 if(!configured_)return Result::Disabled;if(!on(gate_.recorder_owner))return Result::WrongThread;
 if(stop_for_UI_hold_on_recorder())return Result::Hold;
 if(!replies_.push({snapshot_on_recorder(),0,Action::Start,false,true})){status_dropped_.fetch_add(1);return Result::QueueFull;}return Result::Ok;
}
Result Session::execute_one_on_recorder() noexcept {
 if(!configured_)return Result::Disabled;if(!on(gate_.recorder_owner))return Result::WrongThread;
 if(stop_for_UI_hold_on_recorder())return Result::Hold;
 // Do not pop or call Recorder without a guaranteed completion reply slot.
 if(!replies_.can_push())return Result::QueueFull;Request r{};if(!requests_.peek(r))return Result::WrongState;
 Fence fence=Fence::Ready;
 if(r.action==Action::Stop||r.action==Action::Back)fence=fence_.quiesce_source_and_owned_pool(fence_.context);
 if(fence==Fence::Pending)return Result::Pending;
 if(!requests_.pop(r))return Result::Hold;
 bool okay=false,aborted=false,exception=false;
 if(fence!=Fence::Ready)exception=true;
 else try {
   switch(r.action){
     case Action::Start:okay=mode_available()&&recorder_.start();break;
     case Action::Stop:okay=recorder_.stop();break;
     case Action::Back:
       if(recorder_.state()==runtime::State::Error){aborted=recorder_.reset_error();if(!aborted)break;}
       okay=recorder_.exit_page();break;
     case Action::ResetError:okay=recorder_.reset_error();break;
   }
 }catch(...){exception=true;}
 auto s=snapshot_on_recorder();s.worker_exception=exception;s.failed_session_aborted=aborted;
 if(exception)s.error=fence!=Fence::Ready?ErrorCode::SourceFenceUnknown:ErrorCode::WorkerException;
 if(!replies_.push({s,r.serial,r.action,true,okay&&!exception}))return Result::Hold;
 return okay&&!exception?Result::Ok:Result::Hold;
}
Result Session::poll_on_ui() noexcept {
 if(!configured_)return Result::Disabled;if(!on(gate_.ui_owner))return Result::WrongThread;
 if(hold_)return Result::Hold;Reply r{};bool updated=false;
 for(unsigned n=0;n<16&&replies_.pop(r);++n){
   snapshot_=r.snapshot;worker_synced_=true;updated=true;
   if(!r.control)continue;
   if(!pending_||r.serial!=pending_serial_||r.action!=pending_action_){hold_on_ui();return Result::Hold;}
   pending_=false;
   if(r.snapshot.worker_exception){hold_on_ui();return Result::Hold;}
   if(r.action==Action::Back&&r.success){
     if(!port_.return_original_LV(port_.context)){hold_on_ui();return Result::Hold;}
     active_=false;
   }
 }
 return !updated||render_on_ui()?Result::Ok:Result::Hold;
}
Result Session::completion_observation_on_ui(std::uint64_t count) noexcept {
 if(!configured_)return Result::Disabled;if(!on(gate_.ui_owner))return Result::WrongThread;
 if(count<completion_notifications_){hold_on_ui();return Result::Hold;}
 completion_notifications_=count;return render_on_ui()?Result::Ok:Result::Hold;
}
}
