#include "transaction.hpp"
#include <cassert>
#include <cstdio>
#include <cstring>
#include <initializer_list>
using namespace iq4::f1::hook10;
namespace {
Contract contract(){Contract c{};c.pid=101;c.ui_tid=104;c.pid_ticks=201;c.user_dev=1;c.user_ino=2;c.module_dev=3;c.module_ino=4;c.kernel_profile=1;c.module_bias=0x10000000;c.near_page=0x500000;c.near_bytes=4096;c.own_bridge=c.module_bias+module_bridge_offset;c.trampoline_slot=c.module_bias+module_trampoline_offset;c.own_executable_count=1;c.own_executable[0]={c.module_bias+0x1000,c.module_bias+0x30000};std::strcpy(c.module_path,"/run/synthetic-only.so");std::strcpy(c.state_dir,"/run/synthetic-only-state");for(char*p:{c.proc_version_sha,c.root_receipt_sha,c.provider_receipt_sha,c.off_clean_receipt_sha,c.preparation_receipt_sha,c.prepared_input_sha}){std::memset(p,'a',64);p[64]=0;}c.prepared_publication=c.module_bias+module_preparation_offset;c.prepared_generation=2;return c;}
struct Fixture {
 Contract c{contract()};Snapshot snapshot{};bool stopped[4]{},attached[4]{};unsigned list_calls{},poke_calls{},detach_count{},detach_order[4]{},fail_detach{},add_on_list{};bool identity_ok{true},poke_reports_failure{},foreign{},fail_write_journal{};std::uint64_t pair{original_pair};Address bad_pc{};
 Fixture(){snapshot.count=3;for(unsigned i=0;i<3;++i)snapshot.threads[i]={101+i,201+i};snapshot.threads[2]={104,204};}
 static unsigned index(unsigned tid){assert(tid>=101&&tid<=104);return tid-101;}
 Ops ops(){return {this,identity,list,seize,interrupt,regs,read,poke,save,detach};}
 static bool identity(void*v,const Contract&,Operation)noexcept{return static_cast<Fixture*>(v)->identity_ok;}
 static bool list(void*v,const Contract&,Snapshot&s)noexcept{auto&f=*static_cast<Fixture*>(v);++f.list_calls;if(f.add_on_list&&f.list_calls>=f.add_on_list&&f.snapshot.count==3){f.snapshot.count=4;f.snapshot.threads[2]={103,203};f.snapshot.threads[3]={104,204};}s=f.snapshot;return true;}
 static bool seize(void*v,unsigned tid)noexcept{auto&f=*static_cast<Fixture*>(v);f.attached[index(tid)]=true;return true;}
 static bool interrupt(void*v,unsigned tid)noexcept{auto&f=*static_cast<Fixture*>(v);f.stopped[index(tid)]=true;return true;}
 static bool regs(void*v,unsigned tid,Registers&r)noexcept{auto&f=*static_cast<Fixture*>(v);if(!f.stopped[index(tid)])return false;r={};r.pc=f.bad_pc?f.bad_pc:0x900000;return true;}
 static bool read(void*v,unsigned,Address a,std::uint64_t&p)noexcept{assert(a==entry);p=static_cast<Fixture*>(v)->pair;return true;}
 static bool poke(void*v,unsigned,Address a,std::uint64_t p)noexcept{auto&f=*static_cast<Fixture*>(v);assert(a==entry);for(unsigned i=0;i<4;++i)if(f.attached[i])assert(f.stopped[i]);++f.poke_calls;f.pair=f.foreign?0x12345678:p;bool failure=f.poke_reports_failure;f.poke_reports_failure=false;return !failure;}
 static bool save(void*v,const Journal&j)noexcept{return !(static_cast<Fixture*>(v)->fail_write_journal&&j.phase==Phase::WriteIntent);}
 static bool detach(void*v,unsigned tid)noexcept{auto&f=*static_cast<Fixture*>(v);if(tid==f.fail_detach)return false;f.detach_order[f.detach_count++]=tid;f.stopped[index(tid)]=false;return true;}
};
}
int main(){
 // These are wholly owned synthetic fixtures. No native/kernel code executes.
 {Fixture f;f.add_on_list=2;Transaction t{f.ops()};assert(t.stop(f.c,Operation::Install));assert(t.journal().tid_count==4&&t.journal().all_stopped);assert(t.write_once(f.c));assert(!t.write_once(f.c));assert(f.poke_calls==1);assert(t.detach_ordered(f.c));assert(f.detach_count==4&&f.detach_order[3]==104&&t.journal().phase==Phase::Detached);}
 {Fixture f;f.c.kernel_profile=0;Transaction t{f.ops()};assert(!t.stop(f.c,Operation::Install)&&f.list_calls==0&&f.poke_calls==0);f.c=contract();f.identity_ok=false;Transaction u{f.ops()};assert(!u.stop(f.c,Operation::Install)&&f.list_calls==0);}
 {for(Address pc:{entry,entry+4,Address{0x500000},Address{0x500014},Address{0x10027aac}}){Fixture f;f.bad_pc=pc;Transaction t{f.ops()};assert(!t.stop(f.c,Operation::Install)&&t.journal().phase==Phase::Hold&&f.poke_calls==0&&f.detach_count==0);}}
 {Fixture f;Transaction t{f.ops()};assert(t.stop(f.c,Operation::Install));f.snapshot.threads[0].ticks++;assert(!t.write_once(f.c)&&f.poke_calls==0&&f.detach_count==0&&t.journal().phase==Phase::Hold);}
 {Fixture f;f.poke_reports_failure=true;Transaction t{f.ops()};assert(t.stop(f.c,Operation::Install));assert(!t.write_once(f.c)&&f.poke_calls==1);assert(t.restore_after_failed_install(f.c)&&f.poke_calls==2&&f.pair==original_pair&&t.journal().original_restored);assert(!t.restore_after_failed_install(f.c));assert(t.detach_ordered(f.c));}
 {Fixture f;f.foreign=true;Transaction t{f.ops()};assert(t.stop(f.c,Operation::Install));assert(!t.write_once(f.c));assert(!t.restore_after_failed_install(f.c)&&f.poke_calls==1&&f.detach_count==0);}
 {Fixture f;std::uint64_t patch{};assert(patched_pair(f.c,patch));assert((patch>>32)==(original_pair>>32));f.pair=patch;Transaction t{f.ops()};assert(t.stop(f.c,Operation::Restore)&&t.write_once(f.c)&&f.pair==original_pair&&t.journal().phase==Phase::RestoredStopped);f.fail_detach=101;assert(!t.detach_ordered(f.c)&&f.detach_count==1&&!t.journal().all_stopped&&t.journal().phase==Phase::Hold);assert(!t.restore_after_failed_install(f.c));}
 {Fixture f;Transaction t{f.ops()};assert(t.stop(f.c,Operation::Install));f.fail_write_journal=true;assert(!t.write_once(f.c)&&f.poke_calls==0&&f.detach_count==0&&t.journal().write_may_have_happened);}
 std::puts("8 owned stop/write/restore/detach fault groups PASS; target operations zero");
}
