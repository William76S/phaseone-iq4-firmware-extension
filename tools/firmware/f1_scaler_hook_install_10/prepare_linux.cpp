#include "prepare.hpp"
#include "transaction.hpp"
#include "../f4_ui_bootstrap_02/sha256.h"
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <unistd.h>
#include <cerrno>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#if !defined(__aarch64__)||!defined(__linux__)
#error actual fixed AArch64 Linux source only
#endif
extern "C" void iq4_f1_scaler_bridge_10();
extern "C" std::uint64_t iq4_f1_scaler_trampoline_10;
extern "C" __attribute__((visibility("default"))) iq4::f1::hook10::PublishedPreparation iq4_f1_hook_preparation_observed_10;
iq4::f1::hook10::PublishedPreparation iq4_f1_hook_preparation_observed_10;
namespace iq4::f1::hook10 {
namespace {
bool attempted{};
bool digest(const char*s)noexcept{bool any=false;for(unsigned i=0;i<64;++i){if(!((s[i]>='0'&&s[i]<='9')||(s[i]>='a'&&s[i]<='f')))return false;any|=s[i]!='0';}return any&&s[64]==0;}
void publish(const PreparationMetadata&m)noexcept{auto&p=iq4_f1_hook_preparation_observed_10;p.sequence.fetch_add(1,std::memory_order_acq_rel);p.metadata=m;p.sequence.fetch_add(1,std::memory_order_release);}
bool root_dir()noexcept{struct stat s{};return !lstat("/run/iq4_f1_observe02",&s)&&S_ISDIR(s.st_mode)&&s.st_uid==0&&s.st_gid==0&&(s.st_mode&07777)==0700;}
bool read_root(const char*path,void*p,std::size_t n,bool missing_allowed)noexcept{
 struct stat a{},b{},c{};if(lstat(path,&a))return missing_allowed&&errno==ENOENT;
 if(!S_ISREG(a.st_mode)||a.st_uid||a.st_gid||(a.st_mode&07777)!=0600||a.st_nlink!=1||a.st_size<0||static_cast<std::uint64_t>(a.st_size)!=n)return false;
 int fd=open(path,O_RDONLY|O_CLOEXEC|O_NOFOLLOW);if(fd<0)return false;bool ok=!fstat(fd,&b)&&a.st_dev==b.st_dev&&a.st_ino==b.st_ino&&a.st_size==b.st_size&&a.st_mode==b.st_mode&&a.st_uid==b.st_uid&&a.st_gid==b.st_gid&&b.st_nlink==1;std::size_t done=0;
 while(ok&&done<n){ssize_t z=read(fd,static_cast<char*>(p)+done,n-done);if(z<0&&errno==EINTR)continue;if(z<=0){ok=false;break;}done+=static_cast<std::size_t>(z);}char extra{};ok=ok&&read(fd,&extra,1)==0&&!fstat(fd,&c)&&b.st_dev==c.st_dev&&b.st_ino==c.st_ino&&b.st_size==c.st_size&&b.st_mtim.tv_sec==c.st_mtim.tv_sec&&b.st_mtim.tv_nsec==c.st_mtim.tv_nsec;if(close(fd))ok=false;
 struct stat d{};return ok&&!lstat(path,&d)&&d.st_dev==c.st_dev&&d.st_ino==c.st_ino&&d.st_size==c.st_size&&d.st_mode==c.st_mode&&d.st_uid==c.st_uid&&d.st_gid==c.st_gid;
}
bool ticks(std::uint64_t&value)noexcept{
 int fd=open("/proc/self/stat",O_RDONLY|O_CLOEXEC);if(fd<0)return false;char b[4096]{};auto n=read(fd,b,sizeof b-1);char extra{};bool ok=n>0&&read(fd,&extra,1)==0;if(close(fd))ok=false;if(!ok)return false;char*p=std::strrchr(b,')');if(!p||p[1]!=' '||!p[2]||p[3]!=' ')return false;p+=4;
 for(unsigned f=4;f<=22;++f){char*z{};errno=0;if(*p=='-'){if(f==22)return false;++p;}auto v=std::strtoull(p,&z,10);if(errno||z==p||(*z!=' '&&*z!='\n'))return false;if(f==22){value=v;return v!=0;}p=z+1;}return false;
}
bool branch(Address from,Address to,std::uint32_t&w)noexcept{if((from|to)&3||from>INT64_MAX||to>INT64_MAX)return false;auto d=static_cast<std::int64_t>(to)-static_cast<std::int64_t>(from);if(d<-(1LL<<27)||d>=(1LL<<27))return false;w=0x14000000U|(static_cast<std::uint32_t>(d/4)&0x3ffffffU);return true;}
}
void prepare_once_at_live_ui(normal10::UI10Bridge&bridge,entry01::Module&module,native_ui02::Memory memory)noexcept{
 const int saved_errno=errno;
 if(attempted){errno=saved_errno;return;}
 struct stat candidate{};if(lstat("/run/iq4_f1_observe02/hook10.prepare",&candidate)){errno=saved_errno;return;}
 attempted=true;PreparationMetadata m{};m.attempts=1;m.pid=static_cast<std::uint32_t>(getpid());const auto tid=syscall(SYS_gettid);if(tid>0&&tid<=UINT32_MAX)m.ui_tid=static_cast<std::uint32_t>(tid);
 auto finish=[&](PreparationResult r){m.result=r;publish(m);errno=saved_errno;};
 PreparationInput input{};char supplied[66]{};
 if(!root_dir()||!read_root("/run/iq4_f1_observe02/hook10.prepare",&input,sizeof input,false)||!read_root("/run/iq4_f1_observe02/hook10.prepare.sha256",supplied,65,false)||supplied[64]!='\n'){finish(PreparationResult::InvalidInput);return;}
 supplied[64]=0;F4Sha hash;f4_sha_init(&hash);f4_sha_update(&hash,&input,sizeof input);f4_sha_end(&hash,m.input_sha);
 if(!digest(supplied)||std::strcmp(supplied,m.input_sha)||input.schema!=10||input.bytes!=sizeof input||!input.generation||!digest(input.root_admission_sha)||!digest(input.unwind_review_sha)||!input.near_hint||input.near_hint%4096||input.provider.near_entry||input.provider.near_trampoline||input.provider.own_bridge||sysconf(_SC_PAGESIZE)!=4096||!m.ui_tid||!ticks(m.pid_ticks)){finish(PreparationResult::InvalidInput);return;}
 m.generation=input.generation;const auto status=bridge.renderer().status_on_ui();m.requested=static_cast<unsigned>(status.requested);m.renderer_phase=static_cast<unsigned>(status.phase);m.owner_queue=module.observed_owner().queue;m.renderer_status=reinterpret_cast<Address>(bridge.renderer().status_address_on_actual_ui());
 if(status.phase!=normal10::Phase::OffClean||status.requested!=MaskMode::Off||!bridge.provider().ready_on_current_ui()||bridge.provider().rendering_contract_bound()||input.provider.owner.queue!=m.owner_queue){finish(PreparationResult::WrongOwner);return;}
 std::uint64_t original{};if(!memory.read||!memory.read(memory.context,entry,&original,8)||original!=original_pair||iq4_f1_scaler_trampoline_10!=0){finish(PreparationResult::OriginalChanged);return;}m.original_pair=original;
 // Hint only. No MAP_FIXED, no original mapping/page permission change, no
 // target-text write, no thread stop, and no native getter invocation here.
 void*page=mmap(reinterpret_cast<void*>(input.near_hint),65536,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0);
 if(page==MAP_FAILED){finish(PreparationResult::AllocationFailed);return;}
 const Address base=reinterpret_cast<Address>(page);m.near_page=base;m.near_bytes=65536;m.bridge=reinterpret_cast<Address>(&iq4_f1_scaler_bridge_10);m.trampoline_slot=reinterpret_cast<Address>(&iq4_f1_scaler_trampoline_10);
 std::uint32_t outward{},back{};if(!branch(entry,base,outward)||!branch(base+20,entry+4,back)){finish(PreparationResult::NearOutOfRange);return;}
 const std::uint32_t veneer[2]={0x58000050,0xd61f0200};const std::uint32_t trampoline[2]={0xd10403ff,back};
 std::memcpy(page,veneer,8);std::memcpy(static_cast<char*>(page)+8,&m.bridge,8);std::memcpy(static_cast<char*>(page)+16,trampoline,8);
 // Clear only newly allocated own instructions. The pinned link retains Zig's
 // local AArch64 __clear_cache, whose exact full body is saved. Add an explicit
 // completion barrier after its IC loop; this is not the text installer.
 __builtin___clear_cache(static_cast<char*>(page),static_cast<char*>(page)+24);
 asm volatile("dsb ish\n\tisb":::"memory");
 if(mprotect(page,65536,PROT_READ|PROT_EXEC)){finish(PreparationResult::SealFailed);return;}
 input.provider.near_entry=base;input.provider.near_trampoline=base+16;input.provider.own_bridge=m.bridge;
 if(!bridge.bind_actual_provider_before_patch_on_ui(memory,module,input.provider)){finish(PreparationResult::ProviderRejected);return;}
 __atomic_store_n(&iq4_f1_scaler_trampoline_10,base+16,__ATOMIC_RELEASE);m.trampoline_value=base+16;
 finish(PreparationResult::Prepared);
 // Mapping and module are retained to normal original User exit, including
 // failed allocations/seals. At most one 64 KiB allocation is attempted.
}
}
