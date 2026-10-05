#pragma once
#include "native_abi.hpp"
#include "../../../src/runtime/recording.hpp"
#include <array>
#include <atomic>
#include <cstddef>
#include <cstdint>

namespace iq4::f4::page {
using Token=std::uintptr_t;
enum class Action : std::uint8_t {Start,Stop,Back,ResetError};
enum class PageState : std::uint8_t {Closed,Unavailable,Ready,StartPending,Recording,StopPending,BackPending,ResetPending,Error,Hold};
enum class RateBasis : std::uint8_t {Unknown,SoftwareCompletionNotifications,MeasuredDistinctCaptureFrames};
enum class ErrorCode : std::uint8_t {None,RecorderFailure,WorkerException,SourceFenceUnknown,NativeUIUnknown};
struct Capability {
    std::uint32_t width{},height{},fps_num{},fps_den{};
    RateBasis rate_basis{RateBasis::Unknown};
    bool actual_clean_source{},actual_layout_and_color{},actual_encoder{},actual_card_lease{},
         actual_card_publish_and_recovery{},actual_worker{},actual_mode{},capture_rate_independently_verified{};
};
struct BindingGate {
    const char* UserSHA{};Token ui_owner{},recorder_owner{};
    bool actual_whole_User_and_mapped_functions{},bootstrap03_actual_UI_boundary{},native_page_ctor_vtable_ABI{},native_display_surface_resources{},
         native_touch_action_mapping{},native_current_page_and_return_LV{},native_undo_and_lifetimes{},source_stop_drain_fence_binding{};
};
struct Snapshot {
    runtime::State recorder{runtime::State::Idle};
    std::uint64_t accepted{},encoded{},dropped{},timestamp_rejected{};
    bool first_packet_encoded{},source_loss_known{},worker_exception{},failed_session_aborted{};
    ErrorCode error{ErrorCode::None}; // Fixed field; no backend paths/text copy.
};
struct View {
    PageState state{PageState::Closed};
    Snapshot recording{};
    bool start_enabled{},stop_enabled{},back_enabled{},recording_indicator{},mode_available{},rate_available{};
    std::uint32_t actual_width{},actual_height{},measured_fps_num{},measured_fps_den{};
    std::uint64_t completion_notifications{}; // Never source/capture FPS.
    bool native_context_retained{true}; // Closed is not safe-hot-unload proof.
};
// These are own-code host/target bridge ports, NOT guessed native C++ ABIs.
// Future original UI adapter must implement them on the verified native owner
// using actual constructor/Control/Surface/undo contracts. Default is rejected.
struct UIPort {
    void* context{};
    Token (*current_thread)(void*) noexcept{};
    bool (*enter_native_page)(void*,const View&) noexcept{};
    bool (*render_native_page)(void*,const View&) noexcept{};
    bool (*return_original_LV)(void*) noexcept{};
};
enum class Result : std::uint8_t {Ok,Disabled,WrongThread,WrongState,Unavailable,QueueFull,Pending,Hold};
enum class Fence : std::uint8_t {Pending,Ready,Unknown};
enum class HoldProgress : std::uint8_t {None,Pending,Unknown,QuiescedNoRecording,QuiescedError,Finalized,FinalizeFailed};
static_assert(std::atomic<HoldProgress>::is_always_lock_free,"Hold status must not wait");
struct WorkerFence {
    void* context{};
    // Own-code nonblocking contract: request shutdown on actual source owner,
    // then Ready only after native leases resolved and owned pool drained.
    // Ready must also exclude future source admission for this session until
    // an explicit validated Start re-arms it; UI Hold never re-arms a session.
    // Repeated Pending calls must observe the same idempotent stop request.
    // Never force unlock, wait, call UI, infer from Recorder Idle or cached bool.
    Fence (*quiesce_source_and_owned_pool)(void*) noexcept{};
};

template<class T,std::size_t N> class Ring {
public:
    bool can_push() const noexcept {return write_.load(std::memory_order_relaxed)-read_.load(std::memory_order_acquire)<N;}
    bool push(const T& item) noexcept {
        auto w=write_.load(std::memory_order_relaxed);if(w-read_.load(std::memory_order_acquire)>=N)return false;
        slots_[w%N]=item;write_.store(w+1,std::memory_order_release);return true;
    }
    bool pop(T& item) noexcept {
        auto r=read_.load(std::memory_order_relaxed);if(r==write_.load(std::memory_order_acquire))return false;
        item=slots_[r%N];read_.store(r+1,std::memory_order_release);return true;
    }
    bool peek(T& item) const noexcept {
        auto r=read_.load(std::memory_order_relaxed);if(r==write_.load(std::memory_order_acquire))return false;
        item=slots_[r%N];return true;
    }
private:
    std::array<T,N> slots_{};std::atomic<std::uint64_t> write_{0},read_{0};
};
static_assert(std::atomic<std::uint64_t>::is_always_lock_free,"UI mailbox must not wait");
struct Request {Action action{};std::uint64_t serial{};};
struct Reply {Snapshot snapshot{};std::uint64_t serial{};Action action{};bool control{},success{};};
// Construct outside source locks, keep alive through both owners' termination.
// Exactly one native UI producer/consumer and one Recorder executor. No frame,
// borrowed event/Surface pointer, codec/card operation or wait on the UI path.
class Session {
public:
    Session(runtime::Recorder&,UIPort,WorkerFence,BindingGate,Capability) noexcept;
    Session(const Session&)=delete;Session& operator=(const Session&)=delete;
    Result enter_on_ui() noexcept;
    Result action_on_ui(Action) noexcept;
    Result poll_on_ui() noexcept;
    Result completion_observation_on_ui(std::uint64_t count) noexcept;
    Result execute_one_on_recorder() noexcept;
    Result publish_after_owned_worker_on_recorder() noexcept;
    View view_on_ui() const noexcept; // UI only; worker state never read here.
    std::uint64_t status_updates_dropped() const noexcept {return status_dropped_.load();}
    HoldProgress UI_hold_progress() const noexcept {return worker_hold_progress_.load(std::memory_order_acquire);}
private:
    bool on(Token) const noexcept;
    bool mode_available() const noexcept;
    bool rate_available() const noexcept;
    Snapshot snapshot_on_recorder() const noexcept;
    bool render_on_ui() noexcept;
    void hold_on_ui() noexcept;
    bool stop_for_UI_hold_on_recorder() noexcept;
    runtime::Recorder& recorder_;UIPort port_;WorkerFence fence_;BindingGate gate_;Capability capability_;
    bool configured_{},active_{},worker_synced_{},pending_{},hold_{};
    Action pending_action_{};std::uint64_t serial_{},pending_serial_{},completion_notifications_{};
    Snapshot snapshot_{};
    Ring<Request,4> requests_;Ring<Reply,16> replies_;
    std::atomic<std::uint64_t> status_dropped_{0};
    std::atomic<bool> UI_hold_stop_required_{false};
    std::atomic<HoldProgress> worker_hold_progress_{HoldProgress::None};
    bool worker_hold_terminal_{}; // Recorder owner only; never UI read.
};
}
