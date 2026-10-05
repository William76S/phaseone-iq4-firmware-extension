#include "owned_copy_pool.hpp"
#include <array>
#include <cstring>
#include <limits>
#include <stdexcept>
#include <utility>

namespace iq4::f4 {
static_assert(std::atomic<std::uint32_t>::is_always_lock_free, "source path requires lock-free U32 atomics");
static_assert(std::atomic<std::uint64_t>::is_always_lock_free, "source counters require lock-free U64 atomics");
static_assert(std::atomic<bool>::is_always_lock_free, "source path requires lock-free bool atomics");
namespace detail {
enum State : std::uint32_t { Free, Writing, Ready, WorkerOwned };
struct Slot {
    std::unique_ptr<std::uint8_t[]> bytes;
    std::atomic<std::uint32_t> state{Free};
    FrameInfo info{};
};
#define IQ4_POOL_COUNTERS(X) \
    X(published) X(rejected_wrong_thread) X(rejected_reentrant) X(rejected_used) \
    X(rejected_closed) X(rejected_lease) X(rejected_ui_retained) X(rejected_layout) \
    X(rejected_span) X(rejected_clock) X(duplicate_ids) X(stale_ids) X(pool_full) \
    X(software_id_steps_skipped) X(release_attempts) X(release_success) \
    X(unlock_failed) X(unlock_unknown) X(worker_wrong_thread) X(worker_bad_state) \
    X(worker_owned_frames) X(worker_released_frames)
struct Storage {
    std::array<Slot, CopyPool::max_slots> slots;
    std::array<std::uint32_t, CopyPool::max_slots> queue{};
    std::atomic<std::uint32_t> head{0}, tail{0};
    std::atomic<bool> accepting{true}, uncertain{false};
    std::uint32_t count{};
    std::size_t capacity{};
#define IQ4_ATOMIC(name) std::atomic<std::uint64_t> name{0};
    IQ4_POOL_COUNTERS(IQ4_ATOMIC)
#undef IQ4_ATOMIC
};
}

SourceLease::SourceLease(SourceView v, std::uintptr_t thread, bool verified,
                        Disposition d, ReleaseFn fn, void* c) noexcept
    : view_(v), native_thread_(thread), slot_verified_(verified), disposition_(d), release_(fn), context_(c) {}

OwnedFrame::~OwnedFrame() { reset(); }
OwnedFrame::OwnedFrame(OwnedFrame&& other) noexcept
    : storage_(std::move(other.storage_)), slot_(other.slot_), info_(other.info_) {}
OwnedFrame& OwnedFrame::operator=(OwnedFrame&& other) noexcept {
    if(this != &other) { reset(); storage_=std::move(other.storage_); slot_=other.slot_; info_=other.info_; }
    return *this;
}
const std::uint8_t* OwnedFrame::data() const noexcept {
    return storage_ ? storage_->slots[slot_].bytes.get() : nullptr;
}
void OwnedFrame::reset() noexcept {
    if(storage_) {
        storage_->slots[slot_].state.store(detail::Free, std::memory_order_release);
        storage_->worker_released_frames.fetch_add(1, std::memory_order_relaxed);
        storage_.reset();
    }
}

CopyPool::CopyPool(Config c) : config_(c), producer_thread_(std::this_thread::get_id()) {
    if(!c.max_width || !c.max_height || !c.native_owner_thread || !c.slots || c.slots>max_slots)
        throw std::invalid_argument("explicit owner/geometry/pool bounds required");
    const std::size_t width=c.max_width;
    if(width>std::numeric_limits<std::size_t>::max()/3)
        throw std::invalid_argument("pool width overflow");
    const std::size_t row=width*3;
    if(c.max_height>std::numeric_limits<std::size_t>::max()/row)
        throw std::invalid_argument("pool frame overflow");
    const std::size_t bytes=row*c.max_height;
    if(bytes>max_slot_bytes || bytes>max_total_bytes/c.slots)
        throw std::invalid_argument("pool memory bound exceeded");
    storage_=std::make_shared<detail::Storage>();
    storage_->count=c.slots; storage_->capacity=bytes;
    for(std::uint32_t i=0;i<c.slots;++i) storage_->slots[i].bytes=std::make_unique<std::uint8_t[]>(bytes);
}

bool CopyPool::bind_worker() noexcept {
    if(std::this_thread::get_id()==producer_thread_) {
        storage_->worker_wrong_thread.fetch_add(1,std::memory_order_relaxed); return false;
    }
    if(worker_bind_claim_.test_and_set(std::memory_order_acquire)) return false;
    worker_thread_=std::this_thread::get_id();
    worker_ready_.store(true,std::memory_order_release); return true;
}
bool CopyPool::worker_ready() const noexcept { return worker_ready_.load(std::memory_order_acquire); }
bool CopyPool::on_worker_thread() const noexcept {
    return worker_ready_.load(std::memory_order_acquire) && std::this_thread::get_id()==worker_thread_;
}
bool CopyPool::native_release_uncertain() const noexcept { return storage_->uncertain.load(std::memory_order_acquire); }
void CopyPool::stop_accepting() noexcept {
    if(std::this_thread::get_id()!=producer_thread_) {
        storage_->rejected_wrong_thread.fetch_add(1,std::memory_order_relaxed); return;
    }
    storage_->accepting.store(false,std::memory_order_release);
}
ReleaseResult CopyPool::release(SourceLease& lease) noexcept {
    auto& s=*storage_;
    s.release_attempts.fetch_add(1,std::memory_order_relaxed);
    const auto result=lease.release_(lease.context_,lease.view_);
    if(result==ReleaseResult::Released) {
        lease.state_=LeaseState::Released;
        s.release_success.fetch_add(1,std::memory_order_relaxed);
    } else {
        s.uncertain.store(true,std::memory_order_release);
        s.accepting.store(false,std::memory_order_release);
        if(result==ReleaseResult::KnownStillLocked) {
            lease.state_=LeaseState::KnownStillLocked;
            s.unlock_failed.fetch_add(1,std::memory_order_relaxed);
        } else {
            lease.state_=LeaseState::Unknown;
            s.unlock_unknown.fetch_add(1,std::memory_order_relaxed);
        }
    }
    return result;
}
CaptureResult CopyPool::finish_reject(SourceLease& l, CaptureResult reason) noexcept {
    const auto result=release(l);
    return result==ReleaseResult::Released ? reason :
        (result==ReleaseResult::KnownStillLocked ? CaptureResult::UnlockFailed : CaptureResult::UnlockUnknown);
}

CaptureResult CopyPool::capture(SourceLease& l) noexcept {
    auto& s=*storage_;
    if(std::this_thread::get_id()!=producer_thread_ || l.native_thread_!=config_.native_owner_thread) {
        s.rejected_wrong_thread.fetch_add(1,std::memory_order_relaxed); return CaptureResult::WrongThread;
    }
    if(capturing_.test_and_set(std::memory_order_acquire)) {
        s.rejected_reentrant.fetch_add(1,std::memory_order_relaxed); return CaptureResult::Reentrant;
    }
    struct Guard { std::atomic_flag& flag; ~Guard(){flag.clear(std::memory_order_release);} } guard{capturing_};
    if(l.used_) { s.rejected_used.fetch_add(1,std::memory_order_relaxed); return CaptureResult::AlreadyUsed; }
    l.used_=true;
    if(l.disposition_==Disposition::UiRetainedBorrow) {
        l.state_=LeaseState::UiRetained;
        s.rejected_ui_retained.fetch_add(1,std::memory_order_relaxed); return CaptureResult::UiRetained;
    }
    const auto& v=l.view_;
    if(l.disposition_!=Disposition::ExclusiveReleaseRequired || !l.slot_verified_ ||
       !v.completed_slot_verified || v.slot>=4 || !v.lock_cookie || !l.release_) {
        l.state_=LeaseState::Unverified;
        s.rejected_lease.fetch_add(1,std::memory_order_relaxed); return CaptureResult::BadLease;
    }
    if(!s.accepting.load(std::memory_order_acquire)) {
        s.rejected_closed.fetch_add(1,std::memory_order_relaxed); return finish_reject(l,CaptureResult::Closed);
    }
    if(!v.active_mode_layout_verified || v.packing!=Packing::PackedThreeComponents || v.mode!=config_.mode ||
       !v.width || !v.height || v.width>config_.max_width || v.height>config_.max_height) {
        s.rejected_layout.fetch_add(1,std::memory_order_relaxed); return finish_reject(l,CaptureResult::BadLayout);
    }
    const auto width=std::size_t(v.width);
    if(width>std::numeric_limits<std::size_t>::max()/3) {
        s.rejected_span.fetch_add(1,std::memory_order_relaxed); return finish_reject(l,CaptureResult::BadSpan);
    }
    const auto row=width*3;
    if(v.stride!=row || v.height>std::numeric_limits<std::size_t>::max()/row) {
        s.rejected_span.fetch_add(1,std::memory_order_relaxed); return finish_reject(l,CaptureResult::BadSpan);
    }
    const auto bytes=row*v.height;
    if(!v.data || v.explicit_span<bytes || bytes>s.capacity) {
        s.rejected_span.fetch_add(1,std::memory_order_relaxed); return finish_reject(l,CaptureResult::BadSpan);
    }
    if(has_seen_id_) {
        const auto delta=std::uint32_t(v.software_completion_id-last_id_);
        if(delta==0) { s.duplicate_ids.fetch_add(1,std::memory_order_relaxed); return finish_reject(l,CaptureResult::Duplicate); }
        if(delta>=0x80000000u) { s.stale_ids.fetch_add(1,std::memory_order_relaxed); return finish_reject(l,CaptureResult::StaleSoftwareId); }
    }
    if(v.clock!=Clock::HostObservedCompletionNs64 || (has_seen_id_ && v.completion_clock_ns<=last_clock_)) {
        s.rejected_clock.fetch_add(1,std::memory_order_relaxed); return finish_reject(l,CaptureResult::BadClock);
    }
    if(has_seen_id_) {
        const auto delta=std::uint32_t(v.software_completion_id-last_id_);
        if(delta>1) s.software_id_steps_skipped.fetch_add(delta-1,std::memory_order_relaxed);
    }
    has_seen_id_=true; last_id_=v.software_completion_id; last_clock_=v.completion_clock_ns;
    const auto tail=s.tail.load(std::memory_order_relaxed);
    if(std::uint32_t(tail-s.head.load(std::memory_order_acquire))>=s.count) {
        s.pool_full.fetch_add(1,std::memory_order_relaxed); return finish_reject(l,CaptureResult::PoolFull);
    }
    std::uint32_t selected=s.count;
    for(std::uint32_t i=0;i<s.count;++i) {
        std::uint32_t expected=detail::Free;
        if(s.slots[i].state.compare_exchange_strong(expected,detail::Writing,std::memory_order_acq_rel)) {
            selected=i; break;
        }
    }
    if(selected==s.count) {
        s.pool_full.fetch_add(1,std::memory_order_relaxed); return finish_reject(l,CaptureResult::PoolFull);
    }
    auto& slot=s.slots[selected];
    std::memcpy(slot.bytes.get(),v.data,bytes);
    slot.info={v.width,v.height,v.mode,v.software_completion_id,row,bytes,v.completion_clock_ns,v.color};
    const auto result=release(l); // original slot release happens before queue publication
    if(result!=ReleaseResult::Released) {
        slot.state.store(detail::Free,std::memory_order_release);
        return result==ReleaseResult::KnownStillLocked ? CaptureResult::UnlockFailed : CaptureResult::UnlockUnknown;
    }
    slot.state.store(detail::Ready,std::memory_order_release);
    s.queue[tail%s.count]=selected;
    s.tail.store(tail+1,std::memory_order_release);
    s.published.fetch_add(1,std::memory_order_relaxed);
    return CaptureResult::Published;
}

bool CopyPool::try_pop(OwnedFrame& out) noexcept {
    auto& s=*storage_;
    if(!worker_ready_.load(std::memory_order_acquire) || std::this_thread::get_id()!=worker_thread_) {
        s.worker_wrong_thread.fetch_add(1,std::memory_order_relaxed); return false;
    }
    if(out) { s.worker_bad_state.fetch_add(1,std::memory_order_relaxed); return false; }
    const auto head=s.head.load(std::memory_order_relaxed);
    if(head==s.tail.load(std::memory_order_acquire)) return false;
    const auto index=s.queue[head%s.count];
    if(index>=s.count || s.slots[index].state.load(std::memory_order_acquire)!=detail::Ready) {
        s.worker_bad_state.fetch_add(1,std::memory_order_relaxed); return false;
    }
    s.slots[index].state.store(detail::WorkerOwned,std::memory_order_release);
    out.storage_=storage_; out.slot_=index; out.info_=s.slots[index].info;
    s.head.store(head+1,std::memory_order_release);
    s.worker_owned_frames.fetch_add(1,std::memory_order_relaxed);
    return true;
}
Counters CopyPool::counters() const noexcept {
    Counters c{};
#define IQ4_READ(name) c.name=storage_->name.load(std::memory_order_relaxed);
    IQ4_POOL_COUNTERS(IQ4_READ)
#undef IQ4_READ
    return c;
}
std::size_t CopyPool::preallocated_bytes() const noexcept { return storage_->capacity*storage_->count; }
std::uint32_t CopyPool::ready_count() const noexcept {
    const auto& s=*storage_;
    const auto head=s.head.load(std::memory_order_acquire),tail=s.tail.load(std::memory_order_acquire);
    return std::uint32_t(tail-head);
}
}
