#include "transaction.hpp"
#include <cstring>
#include <limits>
namespace iq4::f1::hook10 {
namespace {
bool digest(const char*s)noexcept{for(unsigned i=0;i<64;++i)if(!((s[i]>='0'&&s[i]<='9')||(s[i]>='a'&&s[i]<='f')))return false;return s[64]==0;}
bool ordered(const Snapshot&s)noexcept{if(!s.count||s.count>max_threads)return false;for(unsigned i=0;i<s.count;++i)if(!s.threads[i].tid||!s.threads[i].ticks||(i&&s.threads[i-1].tid>=s.threads[i].tid))return false;return true;}
bool equal(const Snapshot&a,const Journal&b)noexcept{if(a.count!=b.tid_count)return false;for(unsigned i=0;i<a.count;++i)if(a.threads[i].tid!=b.threads[i].tid||a.threads[i].ticks!=b.threads[i].ticks)return false;return true;}
bool contains(Range r,Address p)noexcept{return r.begin<=p&&p<r.end;}
}
bool patched_pair(const Contract&c,std::uint64_t&pair)noexcept{
 if(c.near_page%4||c.near_page>INT64_MAX)return false;
 const auto d=static_cast<std::int64_t>(c.near_page)-static_cast<std::int64_t>(entry);
 if(d<-(1LL<<27)||d>=(1LL<<27))return false;
 const auto patch=0x14000000U|(static_cast<std::uint32_t>(d/4)&0x03ffffffU);
 pair=(original_pair&0xffffffff00000000ULL)|patch;return true;
}
bool fixed_contract(const Contract&c)noexcept{
 std::uint64_t pair{};
 if(c.schema!=10||c.pid<=1||c.ui_tid<=1||!c.pid_ticks||!c.user_dev||!c.user_ino||!c.module_dev||!c.module_ino||
    c.kernel_profile!=1||!c.module_bias||c.module_bias>UINT64_MAX-module_trampoline_offset-8||c.own_bridge!=c.module_bias+module_bridge_offset||c.trampoline_slot!=c.module_bias+module_trampoline_offset||
    c.near_bytes<24||c.near_bytes>65536||!c.near_page||c.near_page>UINT64_MAX-c.near_bytes||c.near_page%4096||!patched_pair(c,pair)||
    c.module_path[0]!='/'||c.state_dir[0]!='/'||!std::memchr(c.module_path,0,sizeof c.module_path)||!std::memchr(c.state_dir,0,sizeof c.state_dir)||
    std::strncmp(c.module_path,"/run/",5)||std::strncmp(c.state_dir,"/run/",5)||
    !digest(c.proc_version_sha)||!digest(c.root_receipt_sha)||!digest(c.provider_receipt_sha)||!digest(c.off_clean_receipt_sha)||!digest(c.preparation_receipt_sha)||!digest(c.prepared_input_sha)||
    c.prepared_publication!=c.module_bias+module_preparation_offset||!c.prepared_generation||!c.own_executable_count||c.own_executable_count>8)return false;
 bool bridge=false;
 for(unsigned i=0;i<c.own_executable_count;++i){const auto&r=c.own_executable[i];if(r.begin>=r.end||r.begin< c.module_bias||r.end-c.module_bias>0x50000)return false;bridge|=contains(r,c.own_bridge);}
 return bridge;
}
bool Transaction::persist(Phase p)noexcept{journal_.phase=p;if(!ops_.save(ops_.context,journal_)){journal_.phase=Phase::Hold;return false;}return true;}
bool Transaction::hold()noexcept{journal_.phase=Phase::Hold;(void)ops_.save(ops_.context,journal_);return false;}
bool Transaction::pc_allowed(const Contract&c,const Registers&r)const noexcept{
 if((r.pc&3)||(r.pstate&0xf)!=0||contains({entry,entry+8},r.pc)||contains({c.near_page,c.near_page+c.near_bytes},r.pc))return false;
 for(unsigned i=0;i<c.own_executable_count;++i)if(contains(c.own_executable[i],r.pc))return false;
 return true;
}
bool Transaction::stable(const Contract&c)noexcept{
 Snapshot a{},b{};
 if(!ops_.identity(ops_.context,c,journal_.operation)||!ops_.list(ops_.context,c,a)||!ordered(a)||!equal(a,journal_)||!ops_.list(ops_.context,c,b)||!ordered(b)||!equal(b,journal_))return hold();
 bool leader=false,ui=false;
 for(unsigned i=0;i<journal_.tid_count;++i){auto&t=journal_.threads[i];leader|=t.tid==c.pid;ui|=t.tid==c.ui_tid;
  if(detached_[i]||!ops_.registers(ops_.context,t.tid,journal_.registers[i])||!pc_allowed(c,journal_.registers[i]))return hold();
 }
 if(!leader||!ui)return hold();journal_.all_stopped=true;return true;
}
bool Transaction::stop(const Contract&c,Operation op)noexcept{
 if(journal_.phase!=Phase::Prep||!fixed_contract(c)||!ops_.identity||!ops_.list||!ops_.seize||!ops_.interrupt_and_wait||!ops_.registers||!ops_.read_pair||!ops_.poke_pair||!ops_.save||!ops_.detach||
    (op!=Operation::Install&&op!=Operation::Restore))return false;
 journal_.pid=c.pid;journal_.pid_ticks=c.pid_ticks;journal_.operation=op;
 if(!ops_.identity(ops_.context,c,op))return false;
 if(!persist(Phase::Acquiring))return false;
 // Threads can appear before their parents are stopped. Bounded enrollment
 // absorbs additions; deletion/reuse or any unexpected stop remains HOLD.
 for(unsigned round=0;round<4;++round){Snapshot s{};if(!ops_.list(ops_.context,c,s)||!ordered(s))return hold();
  for(unsigned i=0;i<journal_.tid_count;++i){bool found=false;for(unsigned j=0;j<s.count;++j)if(journal_.threads[i].tid==s.threads[j].tid&&journal_.threads[i].ticks==s.threads[j].ticks)found=true;if(!found)return hold();}
  for(unsigned j=0;j<s.count;++j){bool known=false;for(unsigned i=0;i<journal_.tid_count;++i)if(journal_.threads[i].tid==s.threads[j].tid)known=true;if(known)continue;
   if(journal_.tid_count==max_threads)return hold();
   const unsigned i=journal_.tid_count++;journal_.threads[i]=s.threads[j];
   if(!ops_.seize(ops_.context,s.threads[j].tid))return hold();++journal_.attached_count;
   if(!persist(Phase::Acquiring)||!ops_.interrupt_and_wait(ops_.context,s.threads[j].tid))return hold();
  }
  for(unsigned i=0;i<journal_.tid_count;++i)for(unsigned j=i+1;j<journal_.tid_count;++j)if(journal_.threads[j].tid<journal_.threads[i].tid){const auto t=journal_.threads[i];journal_.threads[i]=journal_.threads[j];journal_.threads[j]=t;}
  Snapshot next{};if(!ops_.list(ops_.context,c,next)||!ordered(next))return hold();if(!equal(next,journal_))continue;
  if(!stable(c))return false;
  std::uint64_t patch{};if(!patched_pair(c,patch)||!ops_.read_pair(ops_.context,c.pid,entry,journal_.before)||journal_.before!=(op==Operation::Install?original_pair:patch))return hold();
  return persist(Phase::StoppedVerified);
 }
 return hold();
}
bool Transaction::write_once(const Contract&c)noexcept{
 if(journal_.phase!=Phase::StoppedVerified||journal_.write_attempts||!stable(c))return false;
 std::uint64_t patch{},current{};if(!patched_pair(c,patch)||!ops_.read_pair(ops_.context,c.pid,entry,current)||current!=journal_.before)return hold();
 journal_.after=journal_.operation==Operation::Install?patch:original_pair;
 journal_.write_may_have_happened=true;journal_.write_attempts=1;
 if(!persist(Phase::WriteIntent))return false;
 // One 8-byte POKETEXT, not a claimed atomic 4-byte store. All target threads
 // are ptrace-stopped. The upper original STP instruction is preserved.
 if(!ops_.poke_pair(ops_.context,c.pid,entry,journal_.after)||!ops_.read_pair(ops_.context,c.pid,entry,current)||current!=journal_.after)return hold();
 journal_.original_restored=journal_.after==original_pair;
 return persist(journal_.original_restored?Phase::RestoredStopped:Phase::InstalledStopped);
}
bool Transaction::restore_after_failed_install(const Contract&c)noexcept{
 if(journal_.operation!=Operation::Install||!journal_.write_may_have_happened||journal_.restore_attempts||journal_.detached_count||!stable(c))return false;
 std::uint64_t patch{},current{};if(!patched_pair(c,patch)||!ops_.read_pair(ops_.context,c.pid,entry,current))return hold();
 if(current!=original_pair&&current!=patch)return hold(); // torn/foreign bytes: preserve, never overwrite by guessing.
 journal_.restore_attempts=1;journal_.after=original_pair;
 if(!persist(Phase::WriteIntent))return false;
 if(current!=original_pair&&!ops_.poke_pair(ops_.context,c.pid,entry,original_pair))return hold();
 if(!ops_.read_pair(ops_.context,c.pid,entry,current)||current!=original_pair)return hold();
 journal_.original_restored=true;return persist(Phase::RestoredStopped);
}
bool Transaction::detach_ordered(const Contract&c)noexcept{
 if((journal_.phase!=Phase::InstalledStopped&&journal_.phase!=Phase::RestoredStopped)||!stable(c))return false;
 std::uint64_t current{};if(!ops_.read_pair(ops_.context,c.pid,entry,current)||current!=journal_.after)return hold();
 if(!persist(Phase::Detaching))return false;
 // Resume every other TID first, the admitted UI last. No text/data writes
 // occur after the first detach. A detach failure is partial HOLD, never a
 // claim that all threads remain paused or that retry/restore is safe.
 for(unsigned pass=0;pass<2;++pass)for(unsigned i=journal_.tid_count;i>0;--i){const auto index=i-1;const auto tid=journal_.threads[index].tid;if((tid==c.ui_tid)!=(pass==1))continue;
  if(!ops_.detach(ops_.context,tid))return hold();detached_[index]=true;++journal_.detached_count;journal_.all_stopped=false;
  if(!persist(Phase::Detaching))return false;
 }
 return persist(Phase::Detached);
}
}
