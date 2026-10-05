#include "counter.hpp"
#include <cassert>
#include <cstring>
#include <iostream>
#include <stdexcept>
using namespace iq4::f4::ui_counter;
namespace {
int queue, event, other, rtti;
void* current = &queue;
Observer* registered{};
Triple forced = Triple::Absent;
bool force_inspect{}, throw_register{}, throw_unregister{}, bad_ctor{};
std::uint64_t epoch = 1;
unsigned native_calls{};
void construct(Observer* o, const char* name, void* q) {
    ++native_calls; o->queue = bad_ctor ? &other : q; o->persistent_name = name;
}
void subscribe(Observer* o, void*) { ++native_calls; registered = o; if (throw_register) throw std::runtime_error("synthetic"); }
void unsubscribe(Observer*, void*) { ++native_calls; if (throw_unregister) throw std::runtime_error("synthetic"); registered = nullptr; }
void* thread() { return current; }
Triple inspect(void*, void*, const Observer* o) noexcept { return force_inspect ? forced : (registered == o ? Triple::Present : Triple::Absent); }
std::uint64_t dispatch(void*) noexcept { return epoch; }
Operations ops{construct, subscribe, unsubscribe, thread, inspect, dispatch};
Gate gate() { return {exact_user_sha256, 0, &queue, &event, &rtti, true, true, true, true, true, true}; }
void reset() { current=&queue; registered=nullptr; force_inspect=throw_register=throw_unregister=bad_ctor=false; epoch=1; native_calls=0; }
void notify(Counter& c, void* e) {
    Callback cb{};
    std::memcpy(&cb, reinterpret_cast<const unsigned char*>(c.observer_address()->address_point)+0x10, sizeof(cb));
    cb(c.observer_address(), e);
}
}
int main() {
    unsigned groups=0;
    {
        reset(); Counter c; auto g=gate(); g.whole_user_verified=false;
        assert(c.attach(ops,g)==Result::RejectedGate && native_calls==0 && c.safe_to_release()); ++groups;
    }
    {
        reset(); Counter c; auto g=gate(); g.actual_user_sha256="different";
        assert(c.attach(ops,g)==Result::RejectedGate && native_calls==0); ++groups;
    }
    {
        reset(); Counter c; auto o=ops; o.inspect=nullptr;
        assert(c.attach(o,gate())==Result::RejectedGate && native_calls==0); ++groups;
    }
    {
        reset(); Counter c; auto o=ops; o.dispatch_epoch=nullptr;
        assert(c.attach(o,gate())==Result::RejectedGate && native_calls==0); ++groups;
    }
    {
        reset(); Counter c; current=&other;
        assert(c.attach(ops,gate())==Result::WrongThread && native_calls==0); ++groups;
    }
    {
        reset(); Counter c; forced=Triple::Unknown; force_inspect=true;
        assert(c.attach(ops,gate())==Result::TripleUncertain && native_calls==0); ++groups;
    }
    {
        reset(); Counter c; assert(c.attach(ops,gate())==Result::Ok);
        assert(c.observer_address()->queue==&queue && c.observer_address()->extension==&c);
        for(unsigned i=0;i<1000;++i) notify(c,&event);
        assert(c.snapshot().notifications==1000 && !c.safe_to_release());
        assert(c.attach(ops,gate())==Result::WrongState); ++groups;
    }
    {
        reset(); Counter c; assert(c.attach(ops,gate())==Result::Ok); notify(c,&other);
        assert(c.snapshot().wrong_event==1 && c.snapshot().notifications==0); ++groups;
    }
    {
        reset(); Counter c; assert(c.attach(ops,gate())==Result::Ok); current=&other; notify(c,&event);
        assert(c.snapshot().state==State::Hold && c.snapshot().wrong_thread==1 && !c.safe_to_release()); ++groups;
    }
    {
        reset(); Counter c; throw_register=true;
        assert(c.attach(ops,gate())==Result::NativeException && c.snapshot().state==State::Hold && !c.safe_to_release()); ++groups;
    }
    {
        reset(); Counter c; bad_ctor=true;
        assert(c.attach(ops,gate())==Result::TripleUncertain && c.snapshot().state==State::Hold && native_calls==1); ++groups;
    }
    {
        reset(); Counter c; assert(c.attach(ops,gate())==Result::Ok); throw_unregister=true;
        assert(c.detach_on_ui_dispatch()==Result::NativeException && !c.safe_to_release()); ++groups;
    }
    {
        reset(); Counter c; assert(c.attach(ops,gate())==Result::Ok); current=&other;
        assert(c.detach_on_ui_dispatch()==Result::WrongThread && native_calls==2); ++groups;
    }
    {
        reset(); Counter c; assert(c.attach(ops,gate())==Result::Ok);
        assert(c.detach_on_ui_dispatch()==Result::Ok && !c.safe_to_release());
        assert(!c.confirm_later_ui_boundary()); ++epoch;
        assert(c.confirm_later_ui_boundary() && c.safe_to_release()); ++groups;
    }
    {
        reset(); Counter c; assert(c.attach(ops,gate())==Result::Ok); assert(c.detach_on_ui_dispatch()==Result::Ok);
        notify(c,&event); ++epoch;
        assert(c.snapshot().state==State::Hold && !c.confirm_later_ui_boundary() && !c.safe_to_release()); ++groups;
    }
    {
        reset(); Counter c; assert(c.attach(ops,gate())==Result::Ok);
        c.observer_address()->address_point[0](c.observer_address());
        assert(c.snapshot().state==State::Hold && c.snapshot().unexpected_destructor==1 && !c.safe_to_release()); ++groups;
    }
    {
        reset(); Counter c; assert(c.attach(ops,gate())==Result::Ok); force_inspect=true; forced=Triple::Unknown;
        assert(c.detach_on_ui_dispatch()==Result::TripleUncertain && !c.safe_to_release()); ++groups;
    }
    {
        reset(); Counter c; assert(c.attach(ops,gate())==Result::Ok); epoch=UINT64_MAX;
        assert(c.detach_on_ui_dispatch()==Result::RejectedGate && native_calls==2 && !c.safe_to_release()); ++groups;
    }
    std::cout << groups << " SDK-free synthetic counter groups passed; notification count is not source FPS\n";
}
