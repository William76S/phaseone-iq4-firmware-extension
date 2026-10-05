#include "counter.hpp"
#include <cassert>
#include <iostream>
using namespace iq4::f4::ui_counter;
namespace {
unsigned calls{};
int queue,event,rtti;
void construct(Observer*,const char*,void*) { ++calls; }
void reg(Observer*,void*) { ++calls; }
void* current() { ++calls; return &queue; }
Triple inspect(void*,void*,const Observer*) noexcept { ++calls; return Triple::Absent; }
std::uint64_t epoch(void*) noexcept { ++calls; return 1; }
}
int main() {
    Operations o{construct,reg,reg,current,inspect,epoch};
    Gate g{exact_user_sha256,0,&queue,&event,&rtti,true,true,true,true,true,true};
    Counter c;
    assert(c.attach(o,g)==Result::RejectedGate && calls==0);
    g.verified_load_bias=UINTPTR_MAX;
    assert(c.attach(o,g)==Result::RejectedGate && calls==0);
    std::cout << "2 production-address guard groups passed; zero native calls\n";
}
