#pragma once
#include <atomic>
#include <cstddef>
#include <cstdint>
#include <memory>
#include <thread>

namespace iq4::f4 {
enum class Packing : std::uint8_t { Unknown, PackedThreeComponents };
enum class Color : std::uint8_t { Unverified, RgbOrderVerified };
enum class Clock : std::uint8_t { Unknown, HostObservedCompletionNs64 };
enum class Disposition : std::uint8_t { ExclusiveReleaseRequired, UiRetainedBorrow };
enum class ReleaseResult : std::uint8_t { Released, KnownStillLocked, Unknown };
enum class LeaseState : std::uint8_t { Available, Released, UiRetained, Unverified, KnownStillLocked, Unknown };
enum class CaptureResult : std::uint8_t {
    Published, WrongThread, Reentrant, AlreadyUsed, Closed, BadLease,
    UiRetained, BadLayout, BadSpan, BadClock, Duplicate, StaleSoftwareId,
    PoolFull, UnlockFailed, UnlockUnknown
};

struct SourceView {
    const std::uint8_t* data{};
    std::size_t explicit_span{};
    std::uint32_t width{}, height{};
    std::size_t stride{};
    std::uint32_t mode{}, slot{}, software_completion_id{};
    std::uint64_t lock_cookie{}, completion_clock_ns{};
    Packing packing{Packing::Unknown};
    Color color{Color::Unverified};
    Clock clock{Clock::Unknown};
    bool completed_slot_verified{}, active_mode_layout_verified{};
};
using ReleaseFn = ReleaseResult (*)(void*, const SourceView&) noexcept;

// One attempt on a verified native lock. No destructor releases a native lock.
// Wrong-thread calls leave this available for its original owner to handle.
class SourceLease {
public:
    SourceLease(SourceView, std::uintptr_t current_native_owner_thread,
                bool lock_slot_verified, Disposition, ReleaseFn, void*) noexcept;
    SourceLease(const SourceLease&) = delete;
    SourceLease& operator=(const SourceLease&) = delete;
    SourceLease(SourceLease&&) = delete;
    SourceLease& operator=(SourceLease&&) = delete;
    LeaseState state() const noexcept { return state_; }
    const SourceView& view() const noexcept { return view_; }
private:
    friend class CopyPool;
    SourceView view_;
    std::uintptr_t native_thread_;
    bool slot_verified_, used_{false};
    Disposition disposition_;
    ReleaseFn release_;
    void* context_;
    LeaseState state_{LeaseState::Available};
};

struct Config {
    std::uint32_t max_width{}, max_height{}, mode{}, slots{};
    std::uintptr_t native_owner_thread{};
};
struct FrameInfo {
    std::uint32_t width{}, height{}, mode{}, software_completion_id{};
    std::size_t stride{}, bytes{};
    std::uint64_t host_completion_clock_ns{};
    Color color{Color::Unverified};
};
struct Counters {
    std::uint64_t published{}, rejected_wrong_thread{}, rejected_reentrant{}, rejected_used{};
    std::uint64_t rejected_closed{}, rejected_lease{}, rejected_ui_retained{}, rejected_layout{};
    std::uint64_t rejected_span{}, rejected_clock{}, duplicate_ids{}, stale_ids{}, pool_full{};
    std::uint64_t software_id_steps_skipped{}, release_attempts{}, release_success{};
    std::uint64_t unlock_failed{}, unlock_unknown{}, worker_wrong_thread{}, worker_bad_state{};
    std::uint64_t worker_owned_frames{}, worker_released_frames{};
};
namespace detail { struct Storage; }

// Independent pool bytes only. Storage survives a pool object's orderly
// destruction while a worker still owns a lease; never contains native pixels.
class OwnedFrame {
public:
    OwnedFrame() noexcept = default;
    ~OwnedFrame();
    OwnedFrame(OwnedFrame&&) noexcept;
    OwnedFrame& operator=(OwnedFrame&&) noexcept;
    OwnedFrame(const OwnedFrame&) = delete;
    OwnedFrame& operator=(const OwnedFrame&) = delete;
    explicit operator bool() const noexcept { return bool(storage_); }
    const std::uint8_t* data() const noexcept;
    const FrameInfo& info() const noexcept { return info_; }
    void reset() noexcept;
private:
    friend class CopyPool;
    std::shared_ptr<detail::Storage> storage_;
    std::uint32_t slot_{};
    FrameInfo info_{};
};

// One native owner/producer thread and one separately bound codec worker.
// Construction preallocates all slot bytes. capture() is noexcept/nonblocking:
// fixed checks, bounded memcpy, original paired release, atomic publication.
class CopyPool {
public:
    static constexpr std::uint32_t max_slots = 16;
    static constexpr std::size_t max_slot_bytes = 128u * 1024u * 1024u;
    static constexpr std::size_t max_total_bytes = 256u * 1024u * 1024u;
    explicit CopyPool(Config);
    ~CopyPool() = default;
    CopyPool(const CopyPool&) = delete;
    CopyPool& operator=(const CopyPool&) = delete;
    bool bind_worker() noexcept; // called once from the actual distinct worker
    bool worker_ready() const noexcept;
    bool on_worker_thread() const noexcept;
    CaptureResult capture(SourceLease&) noexcept;
    bool try_pop(OwnedFrame&) noexcept;
    void stop_accepting() noexcept; // producer only; no native call or wait
    bool native_release_uncertain() const noexcept;
    Counters counters() const noexcept;
    std::size_t preallocated_bytes() const noexcept;
    std::uint32_t ready_count() const noexcept;
private:
    ReleaseResult release(SourceLease&) noexcept;
    CaptureResult finish_reject(SourceLease&, CaptureResult) noexcept;
    std::shared_ptr<detail::Storage> storage_;
    Config config_;
    const std::thread::id producer_thread_;
    std::thread::id worker_thread_{};
    std::atomic<bool> worker_ready_{false};
    std::atomic_flag worker_bind_claim_ = ATOMIC_FLAG_INIT;
    std::atomic_flag capturing_ = ATOMIC_FLAG_INIT;
    bool has_seen_id_{false};
    std::uint32_t last_id_{};
    std::uint64_t last_clock_{};
};
}
