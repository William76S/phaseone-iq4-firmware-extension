#include "counter.hpp"
#include <cstring>

namespace iq4::f4::ui_counter {
namespace {
constexpr char name[] = "IQ4 F4 completion notification counter";
bool bindings_match(const Operations& o, const Gate& g) noexcept {
#ifdef IQ4_F4_SYNTHETIC_HOST
    (void)o; (void)g;
    return true; // Only the separately built SDK-free synthetic test binary.
#else
    return reinterpret_cast<std::uintptr_t>(o.construct) == g.verified_load_bias + 0x70fe3c &&
           reinterpret_cast<std::uintptr_t>(o.subscribe) == g.verified_load_bias + 0x70fed8 &&
           reinterpret_cast<std::uintptr_t>(o.unsubscribe) == g.verified_load_bias + 0x70ff08 &&
           reinterpret_cast<std::uintptr_t>(o.current_thread) == g.verified_load_bias + 0x710b0c &&
           reinterpret_cast<std::uintptr_t>(g.original_base_rtti) == g.verified_load_bias + 0xc23ab0;
#endif
}
bool valid(const Operations& o, const Gate& g) noexcept {
    return g.actual_user_sha256 && std::strcmp(g.actual_user_sha256, exact_user_sha256) == 0 &&
           o.construct && o.subscribe && o.unsubscribe && o.current_thread && o.inspect && o.dispatch_epoch &&
           g.ui_queue && g.frame_event && g.original_base_rtti &&
           g.whole_user_verified && g.exact_mapped_functions_verified && g.live_owner_chain_verified &&
           g.sole_ui_dispatcher_verified && g.stable_native_lifetimes_verified && g.in_ui_dispatch_verified &&
           g.verified_load_bias <= UINTPTR_MAX - 0xc23ab0 && bindings_match(o, g);
}
}
Counter::Counter() noexcept : table_{0, nullptr, unexpected_destroy, unexpected_destroy, notified} {}
bool Counter::on_owner() const noexcept {
    try { return operations_.current_thread && operations_.current_thread() == gate_.ui_queue; }
    catch (...) { return false; }
}
bool Counter::actual_triple(Triple wanted) noexcept {
    return operations_.inspect && operations_.inspect(gate_.ui_queue, gate_.frame_event, &observer_) == wanted;
}
Result Counter::attach(const Operations& o, const Gate& g) noexcept {
    if (state_.load() != State::Empty) return Result::WrongState;
    if (!valid(o, g)) return Result::RejectedGate;
    operations_ = o; gate_ = g;
    if (!on_owner()) return Result::WrongThread;
    if (!actual_triple(Triple::Absent)) return Result::TripleUncertain;
    table_.base_rtti = g.original_base_rtti;
    state_.store(State::Registering);
    try {
        operations_.construct(&observer_, name, gate_.ui_queue);
        if (observer_.queue != gate_.ui_queue || observer_.persistent_name != name) {
            state_.store(State::Hold); return Result::TripleUncertain;
        }
        observer_.extension = this;
        observer_.address_point = &table_.destroy;
        operations_.subscribe(&observer_, gate_.frame_event);
    } catch (...) { state_.store(State::Hold); return Result::NativeException; }
    if (!actual_triple(Triple::Present)) { state_.store(State::Hold); return Result::TripleUncertain; }
    state_.store(State::Attached);
    return Result::Ok;
}
void Counter::notified(Observer* o, void* event) noexcept {
    if (!o || !o->extension) return;
    auto& c = *static_cast<Counter*>(o->extension);
    c.in_callback_.fetch_add(1);
    if (!c.on_owner()) { c.wrong_thread_.fetch_add(1); c.state_.store(State::Hold); }
    else if (event != c.gate_.frame_event) c.wrong_event_.fetch_add(1);
    else if (c.state_.load() != State::Attached) {
        c.inactive_.fetch_add(1);
        if (c.state_.load() == State::Detached) c.state_.store(State::Hold);
    }
    else c.notifications_.fetch_add(1);
    c.in_callback_.fetch_sub(1);
}
void Counter::unexpected_destroy(Observer* o) noexcept {
    if (!o || !o->extension) return;
    auto& c = *static_cast<Counter*>(o->extension);
    c.unexpected_destructor_.fetch_add(1); c.state_.store(State::Hold);
    // Native code must never delete this caller-owned extended observer.
}
Result Counter::detach_on_ui_dispatch() noexcept {
    if (!on_owner()) return Result::WrongThread;
    if (state_.load() != State::Attached) return Result::WrongState;
    if (in_callback_.load() != 0) return Result::CallbackInFlight;
    detach_epoch_ = operations_.dispatch_epoch(gate_.ui_queue);
    if (detach_epoch_ == UINT64_MAX) return Result::RejectedGate;
    state_.store(State::Detaching); later_boundary_.store(false);
    try { operations_.unsubscribe(&observer_, gate_.frame_event); }
    catch (...) { state_.store(State::Hold); return Result::NativeException; }
    if (!actual_triple(Triple::Absent)) { state_.store(State::Hold); return Result::TripleUncertain; }
    state_.store(State::Detached);
    return Result::Ok;
}
bool Counter::confirm_later_ui_boundary() noexcept {
    if (!on_owner() || state_.load() != State::Detached || in_callback_.load() != 0 || !actual_triple(Triple::Absent) ||
        operations_.dispatch_epoch(gate_.ui_queue) <= detach_epoch_) return false;
    later_boundary_.store(true); return true;
}
bool Counter::safe_to_release() const noexcept {
    auto s = state_.load();
    return s == State::Empty || (s == State::Detached && later_boundary_.load() && in_callback_.load() == 0);
}
Snapshot Counter::snapshot() const noexcept {
    return {state_.load(), notifications_.load(), wrong_event_.load(), wrong_thread_.load(), inactive_.load(), unexpected_destructor_.load(), in_callback_.load()};
}
}
