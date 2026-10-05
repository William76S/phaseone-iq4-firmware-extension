#pragma once
#include "../f4_ui_counter_01/counter.hpp"
#include <atomic>
#include <cstddef>
#include <cstdint>
namespace iq4::f4::bootstrap {
using namespace ui_counter;
using Address = std::uintptr_t;
using Read = bool (*)(void*, Address, void*, std::size_t) noexcept;
struct Memory { void* context{}; Read read{}; };
using Mutex = int (*)(void*);
using EventConstruct = void (*)(void*, const char*);
using EventNotify = void (*)(void*);
struct Native {
    Construct construct{}; Register subscribe{}, unsubscribe{}; CurrentThread current{};
    EventConstruct event_construct{}; EventNotify event_notify{};
    Mutex try_lock{}, unlock{};
};
struct ImageGate { bool enabled{}, whole_user_verified{}, mapped_nonwritable_segments_verified{}, original_pthread_verified{}; Address load_bias{}; };
struct Owner { Address queue{}, manager{}, ui_data{}, lv{}, access{}, engine{}, frame_event{}; };
struct Boundary { Owner owner{}; Address popped_listener{}, popped_observer{}, pop_frame{}, dispatch_frame{}; };
enum class Phase : std::uint8_t { Disabled, Waiting, RegisteringControl, ControlQueued, CounterAttached, Detaching, ObserversDetachedEventRetained, Hold };
struct Status { Phase phase; std::uint64_t epoch, qualified_boundaries, control_callbacks, skipped, notifications; bool event_retained, module_retained; };
// Only self-memory is passed in production. No supplied native owner is accepted.
class Bootstrap {
public:
    Bootstrap() noexcept;
    bool configure(Memory, Native, ImageGate) noexcept;
    // Called only AFTER the original unlock. Caller captures original caller PC,
    // its own FP and actual architectural thread pointer; no address hooks.
    void after_unlock(Address caller_pc, Address frame_pointer, Address thread_pointer, Address mutex, int original_result) noexcept;
    Status status() const noexcept;
    Observer* control_observer_for_test() noexcept { return &control_; }
    Counter& counter_for_test() noexcept { return counter_; }
    bool owner_chain(Address queue, Owner&) const noexcept;
    bool boundary(Address fp, Address tp, Address mutex, Boundary&) const noexcept;
    Triple inspect(Address queue, Address event, const Observer*) noexcept;
    bool empty_control_event() noexcept;
private:
    bool read(Address, void*, std::size_t) const noexcept;
    bool word(Address, Address&) const noexcept;
    bool own_thread() const noexcept;
    bool valid_owner() const noexcept;
    bool bindings_match() const noexcept;
    void begin(const Boundary&) noexcept;
    void later(const Boundary&) noexcept;
    void control_callback(void*) noexcept;
    static void notify(Observer*, void*) noexcept;
    static void destroy(Observer*) noexcept;
    static Triple inspect_bridge(void*, void*, const Observer*) noexcept;
    static std::uint64_t epoch_bridge(void*) noexcept;
    static Bootstrap* active_;
    Memory memory_{}; Native native_{}; ImageGate gate_{}; Owner owner_{};
    std::atomic<Phase> phase_{Phase::Disabled};
    std::uint64_t epoch_{}, qualified_{}, callbacks_{}, skipped_{}, detach_epoch_{};
    std::atomic<std::uint32_t> in_callback_{0};
    bool configured_{}, event_constructed_{}, module_retained_{};
    std::atomic_flag filtering_=ATOMIC_FLAG_INIT;
    alignas(16) unsigned char control_event_[0xb8]{};
    Table table_{}; Observer control_{}; Counter counter_{};
};
// SDK-free isolated predicate/forwarding tests exercise original-first semantics.
using Diagnostic = void (*)(void*, int) noexcept;
int forward_once(Mutex original, void* mutex, int& caller_errno, void* context, Diagnostic) noexcept;
}
