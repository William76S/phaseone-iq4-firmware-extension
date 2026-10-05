#include "prepare.hpp"
#include "../f1_native_ui_02/entry_bytes.hpp"
#include "../f1_entry_button_ports_01/entries.hpp"
#include <cassert>
#include <cstdio>
#include <cstring>
#include <vector>
using namespace iq4::f1;
namespace {
native_ui02::Address tls=0x10000;
void*current(){return reinterpret_cast<void*>(tls);}
void invalidate(void*,bool){}
struct Cell {std::uint64_t address,value;};
struct Memory {
 std::vector<Cell> cells;
 static bool read(void*v,native_ui02::Address a,void*p,std::size_t n)noexcept{auto&m=*static_cast<Memory*>(v);if(n==16){for(auto&e:native_ui02::EntryChecks)if(a==e.va){std::memcpy(p,e.bytes.data(),16);return true;}for(auto&e:entry_ports01::Entries)if(a==e.captured_va){std::memcpy(p,e.first16,16);return true;}}for(auto&c:m.cells)if(c.address<=a&&a+n<=c.address+8){std::memcpy(p,reinterpret_cast<const unsigned char*>(&c.value)+a-c.address,n);return true;}return false;}
 native_ui02::Memory port(){return {this,read};}
};
}
namespace iq4::f1::entry10 {
struct OwnedFixture {
 static void bind(Binding&b,Memory&m,const Owner&o){b.configured_=true;b.memory_=m;b.owner_=o;b.status_.phase=static_cast<unsigned>(Phase::Ready);b.ports_.current_thread=current;b.native_.context=&b;b.native_.current_thread=Binding::native_current;b.native_.inspect_triple=Binding::native_triple;b.native_.invalidate=invalidate;}
};
}
namespace iq4::f1::normal10 {
struct OwnedFixture {static void bind(Renderer&r,native_ui02::Native n,const native_ui02::Owner&o){r.native_=n;r.owner_=o;r.status_.phase=Phase::OffClean;}};
}
int main(){
 Memory memory;native_ui02::Owner owner{0x10000,0x20000,0x30000,0x40000,0x50000};
 memory.cells={{owner.queue,0xb91f48},{owner.queue+0x1c8,owner.manager},{owner.manager,0xb8f358},{owner.manager+8,owner.queue},{owner.queue+0x9b8,owner.data},{owner.manager+0x790,owner.data},{owner.queue+0x8c0,owner.lv},{owner.lv+0xb0,owner.manager},{owner.popup,0xb931b0},{owner.popup+0xb0,owner.manager},{owner.popup+0x128,0xb90020},{owner.lv,0xb9a9d8},{owner.manager+0x108,0x60000},{0x60000,0x61000},{0x61018,0x62000},{0x61010,0x63000},{0x62000,0xd65f03c091020000ULL}};
 auto mem=memory.port();entry01::Module module;
 entry01::Module missing_sync;assert(missing_sync.configure(mem,{true,true,true,true,0},nullptr,nullptr)==false); // required synchronization is real, never omitted.
 auto lock=[](void*){return 0;};assert(module.configure(mem,{true,true,true,true,0},lock,lock));module.stop_observing();auto capped=module.selector_ports();assert(capped.current_thread(capped.context)==0);
 entry10::Binding binding;entry10::OwnedFixture::bind(binding,mem,owner);auto persistent=binding.persistent_ports_on_ui();assert(persistent.context==&binding&&persistent.current_thread(persistent.context)==owner.queue&&persistent.inspect_triple);
 normal10::Renderer renderer;normal10::OwnedFixture::bind(renderer,persistent,owner);assert(renderer.status_address_on_actual_ui());
 normal10::ProvenProviderAdapter provider;assert(provider.bind_observation_on_actual_ui(mem,persistent,owner)&&provider.ready_on_current_ui());
 normal10::ActualProviderContract c{};c.profile=normal10::ProviderProfile::RootReviewedInlineUIRetainedUntilPresent;std::memcpy(c.actual_UserSHA,native_overlay::UserSHA,65);std::memset(c.owner_review_sha256,'a',64);std::memset(c.hook_quiescence_receipt_sha256,'b',64);c.owner=owner;c.provider=0x60000;c.provider_vtable=0x61000;c.getter=0x62000;c.present=0x63000;c.near_entry=0x500000;c.near_trampoline=0x500020;c.own_bridge=0x70000;c.inline_surface_offset=128;c.getter_shape=normal10::InlineGetterShape::LeafAddRet8;
 assert(provider.configure_on_actual_ui(mem,persistent,c)&&provider.rendering_contract_bound()&&provider.ready_on_current_ui());
 tls=0x10008;assert(!binding.persistent_ports_on_ui().current_thread&&!provider.ready_on_current_ui()&&!renderer.status_address_on_actual_ui());assert(capped.current_thread(capped.context)==0);
 std::puts("1 owned Module-cap/persistent Binding/Renderer/Provider/TLS rejection group PASS; no native function or target execution");
}
