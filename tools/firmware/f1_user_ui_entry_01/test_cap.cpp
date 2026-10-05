#include "entry_binding_10.hpp"
#include "../f1_native_ui_02/entry_bytes.hpp"
#include "../f1_entry_button_ports_01/entries.hpp"
#include <cassert>
#include <cstring>
#include <vector>
using namespace iq4::f1;
namespace {
native_ui02::Address tls=0x10000;
void*current(){return reinterpret_cast<void*>(tls);}
void invalidate(void*,bool){}
struct Cell{std::uint64_t address,value;};
struct OwnedMemory{
 std::vector<Cell>cells;
 static bool read(void*v,native_ui02::Address a,void*p,std::size_t n)noexcept{
  auto&m=*static_cast<OwnedMemory*>(v);
  if(n==16){for(const auto&e:native_ui02::EntryChecks)if(a==e.va){std::memcpy(p,e.bytes.data(),16);return true;}for(const auto&e:entry_ports01::Entries)if(a==e.captured_va){std::memcpy(p,e.first16,16);return true;}}
  for(const auto&c:m.cells)if(c.address<=a&&a+n<=c.address+8){std::memcpy(p,reinterpret_cast<const unsigned char*>(&c.value)+a-c.address,n);return true;}
  return false;
 }
};
}
namespace iq4::f1::entry10 {
struct OwnedFixture {
 static void bind(Binding&b,native_ui02::Memory m,const Owner&o){b.configured_=true;b.memory_=m;b.owner_=o;b.status_.phase=static_cast<unsigned>(Phase::Ready);b.ports_.current_thread=current;b.native_.context=&b;b.native_.current_thread=Binding::native_current;b.native_.inspect_triple=Binding::native_triple;b.native_.invalidate=invalidate;}
 static void phase(Binding&b,Phase p){b.status_.phase=static_cast<unsigned>(p);}
};
}
int main(){
 OwnedMemory m;native_ui02::Owner o{0x10000,0x20000,0x30000,0x40000,0x50000};
 m.cells={{o.queue,0xb91f48},{o.queue+0x1c8,o.manager},{o.manager,0xb8f358},{o.manager+8,o.queue},{o.queue+0x9b8,o.data},{o.manager+0x790,o.data},{o.queue+0x8c0,o.lv},{o.lv+0xb0,o.manager},{o.popup,0xb931b0},{o.popup+0xb0,o.manager},{o.popup+0x128,0xb90020},{o.lv,0xb9a9d8}};
 native_ui02::Memory memory{&m,OwnedMemory::read};entry01::Module module;auto lock=[](void*){return 0;};
 assert(module.configure(memory,{true,true,true,true,0},lock,lock));module.stop_observing();auto capped=module.selector_ports();assert(capped.current_thread(capped.context)==0);
 entry10::Binding binding;entry10::OwnedFixture::bind(binding,memory,o);auto captured=binding.persistent_ports_on_ui();assert(captured.context==&binding&&captured.current_thread(captured.context)==o.queue);
 entry10::OwnedFixture::phase(binding,entry10::Phase::Hold);assert(captured.current_thread(captured.context)==0);entry10::OwnedFixture::phase(binding,entry10::Phase::Ready);assert(captured.current_thread(captured.context)==o.queue);
 entry10::OwnedFixture::phase(binding,entry10::Phase::DetachedRetained);assert(captured.current_thread(captured.context)==0);entry10::OwnedFixture::phase(binding,entry10::Phase::Ready);assert(captured.current_thread(captured.context)==o.queue);
 tls=0x10008;assert(!binding.persistent_ports_on_ui().current_thread);assert(capped.current_thread(capped.context)==0);
}
