#include "bootstrap.hpp"
#include <cassert>
#include <iostream>
using namespace iq4::f4::bootstrap;
namespace {unsigned native_calls{},reads{};
bool read(void*,Address,void*,std::size_t) noexcept {++reads;return false;}
void ctor(Observer*,const char*,void*){++native_calls;}void reg(Observer*,void*){++native_calls;}void* thread(){++native_calls;return nullptr;}
void event(void*,const char*){++native_calls;}void notify(void*){++native_calls;}int mutex(void*){++native_calls;return 0;}}
int main(){Bootstrap b;Native n{ctor,reg,reg,thread,event,notify,mutex,mutex};assert(!b.configure({nullptr,read},n,{true,true,true,true,0}));b.after_unlock(0x6be8ac,0x10000,0x20000,0x30000,0);assert(native_calls==0&&reads==0&&b.status().phase==Phase::Hold);
 Bootstrap disabled;assert(disabled.configure({nullptr,read},n,{false,false,false,false,0}));disabled.after_unlock(0x6be8ac,0x10000,0x20000,0x30000,0);assert(native_calls==0&&reads==0);std::cout<<"2 production guard groups passed; zero native calls and zero memory reads\n";}
