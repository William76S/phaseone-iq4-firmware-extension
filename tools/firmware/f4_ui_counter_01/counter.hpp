#pragma once
#include <atomic>
#include <cstddef>
#include <cstdint>

namespace iq4::f4::ui_counter {
inline constexpr char exact_user_sha256[] = "9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb";
struct Observer;
using Destructor = void (*)(Observer*) noexcept;
using Callback = void (*)(Observer*, void*) noexcept;
// Exact original address point has two destructor slots followed by VT+0x10.
// This project-owned table retains storage on unexpected destructor calls.
struct Table { std::intptr_t offset_to_top; const void* base_rtti; Destructor destroy, deleting_destroy; Callback notify; };
struct Observer { const Destructor* address_point{}; void* queue{}; const char* persistent_name{}; void* extension{}; };
static_assert(sizeof(void*) == 8 && sizeof(Observer) == 0x20);
static_assert(sizeof(Destructor) == 8 && sizeof(Callback) == 8 && sizeof(Table) == 0x28);
static_assert(offsetof(Observer, queue) == 8 && offsetof(Observer, persistent_name) == 16);
static_assert(offsetof(Observer, extension) == 24 && offsetof(Table, notify) == 32);

enum class Triple { Present, Absent, Unknown };
using Construct = void (*)(Observer*, const char*, void*);
using Register = void (*)(Observer*, void*);
using CurrentThread = void* (*)();
// A bounded memory inspector implemented by the independently reviewed binder.
// It must inspect the actual queue/event/observer triple, not cached evidence.
using InspectTriple = Triple (*)(void*, void*, const Observer*) noexcept;
using DispatchEpoch = std::uint64_t (*)(void*) noexcept;
struct Operations { Construct construct{}; Register subscribe{}, unsubscribe{}; CurrentThread current_thread{}; InspectTriple inspect{}; DispatchEpoch dispatch_epoch{}; };
struct Gate {
    const char* actual_user_sha256{};
    std::uintptr_t verified_load_bias{};
    void* ui_queue{}; void* frame_event{}; const void* original_base_rtti{};
    bool whole_user_verified{}, exact_mapped_functions_verified{}, live_owner_chain_verified{};
    bool sole_ui_dispatcher_verified{}, stable_native_lifetimes_verified{}, in_ui_dispatch_verified{};
};
enum class State : std::uint8_t { Empty, Registering, Attached, Detaching, Detached, Hold };
enum class Result : std::uint8_t { Ok, RejectedGate, WrongThread, WrongState, NativeException, TripleUncertain, CallbackInFlight };
struct Snapshot { State state; std::uint64_t notifications, wrong_event, wrong_thread, inactive, unexpected_destructor; std::uint32_t in_callback; };

// Caller-owned object. No destructor calls native functions. The loader must
// retain this object AND this SO whenever safe_to_release() is false.
class Counter {
public:
    Counter() noexcept;
    Counter(const Counter&) = delete;
    Counter& operator=(const Counter&) = delete;
    Result attach(const Operations&, const Gate&) noexcept;
    Result detach_on_ui_dispatch() noexcept;
    // Call only from a later, independently observed dispatch boundary of the
    // same native UI queue. Does not claim cross-thread callback cancellation.
    bool confirm_later_ui_boundary() noexcept;
    bool safe_to_release() const noexcept;
    Snapshot snapshot() const noexcept;
    Observer* observer_address() noexcept { return &observer_; }
private:
    static void unexpected_destroy(Observer*) noexcept;
    static void notified(Observer*, void*) noexcept;
    bool on_owner() const noexcept;
    bool actual_triple(Triple) noexcept;
    Operations operations_{};
    Gate gate_{};
    Table table_{};
    Observer observer_{};
    std::atomic<State> state_{State::Empty};
    std::atomic<std::uint64_t> notifications_{0}, wrong_event_{0}, wrong_thread_{0}, inactive_{0}, unexpected_destructor_{0};
    std::atomic<std::uint32_t> in_callback_{0};
    std::atomic<bool> later_boundary_{false};
    std::uint64_t detach_epoch_{};
};
}
