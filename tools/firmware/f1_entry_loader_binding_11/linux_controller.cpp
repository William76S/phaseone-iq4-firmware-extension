// Linux/AArch64 controller source only. No target execution in this package.
#include "transaction.hpp"
#include "../f1_scaler_hook_install_10/prepare.hpp"
#include "../f4_ui_bootstrap_02/sha256.h"
#include <asm/ptrace.h>
#include <dirent.h>
#include <elf.h>
#include <fcntl.h>
#include <signal.h>
#include <sys/file.h>
#include <sys/ptrace.h>
#include <sys/stat.h>
#include <sys/sysmacros.h>
#include <sys/uio.h>
#include <sys/utsname.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>
#include <cerrno>
#include <cstdio>
#include <cstdlib>
#include <cstring>
using namespace iq4::f1::hook10;
namespace normal10=iq4::f1::normal10;
#if !defined(__linux__)||!defined(__aarch64__)
#error fixed Linux AArch64 backend only
#endif
static_assert(sizeof(long)==8&&sizeof(user_pt_regs)==sizeof(Registers));
static_assert(offsetof(user_pt_regs,pc)==offsetof(Registers,pc));
namespace {
constexpr char user_sha[]="9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb";
constexpr char kernel_release[]="4.19.0-p1-iq4-82477-gff46069";
struct Context {const Contract*contract{};int mem{-1},directory{-1};unsigned sequence{};};
std::uint64_t millis()noexcept{timespec t{};return clock_gettime(CLOCK_MONOTONIC,&t)||t.tv_sec<0?0:static_cast<std::uint64_t>(t.tv_sec)*1000+static_cast<std::uint64_t>(t.tv_nsec)/1000000;}
bool read_exact(int fd,void*p,std::size_t n,Address off)noexcept{
 if(off>INT64_MAX||n>static_cast<std::uint64_t>(INT64_MAX)-off)return false;
 std::size_t done=0;while(done<n){ssize_t z=pread(fd,static_cast<char*>(p)+done,n-done,static_cast<off_t>(off+done));if(z<0&&errno==EINTR)continue;if(z<=0)return false;done+=static_cast<std::size_t>(z);}return true;
}
bool bounded(const char*path,char*p,std::size_t capacity,std::size_t&n)noexcept{
 int fd=open(path,O_RDONLY|O_CLOEXEC|O_NOFOLLOW);if(fd<0)return false;n=0;bool ok=true;
 while(n<capacity-1){const auto z=read(fd,p+n,capacity-1-n);if(z<0&&errno==EINTR)continue;if(z<0){ok=false;break;}if(!z)break;n+=static_cast<std::size_t>(z);}char extra{};if(n==capacity-1&&read(fd,&extra,1)!=0)ok=false;p[n]=0;if(close(fd))ok=false;return ok;
}
bool hash_fd(int fd,std::uint64_t size,const char*wanted)noexcept{
 if(size>16*1024*1024)return false;F4Sha s;f4_sha_init(&s);unsigned char b[4096];
 for(Address off=0;off<size;){const auto n=static_cast<std::size_t>(size-off>sizeof b?sizeof b:size-off);if(!read_exact(fd,b,n,off))return false;f4_sha_update(&s,b,n);off+=n;}
 char extra{};if(pread(fd,&extra,1,static_cast<off_t>(size))!=0)return false;char h[65];f4_sha_end(&s,h);return std::strcmp(h,wanted)==0;
}
bool proc_stat(std::uint32_t pid,std::uint64_t&tick)noexcept{
 char path[80],b[4096];std::size_t n{};std::snprintf(path,sizeof path,"/proc/%u/stat",pid);if(!bounded(path,b,sizeof b,n))return false;
 char*end{};errno=0;unsigned long first=std::strtoul(b,&end,10);if(errno||first!=pid||*end!=' ')return false;
 char*last=std::strrchr(end,')');if(!last||last[1]!=' '||!last[2]||last[3]!=' ')return false;char*p=last+4;
 for(unsigned field=4;field<=22;++field){errno=0;char*z{};if(*p=='-'){if(field==22)return false;++p;}auto v=std::strtoull(p,&z,10);if(errno||z==p||(*z!=' '&&*z!='\n'))return false;if(field==22){tick=v;return v!=0;}p=z+1;}return false;
}
bool root_receipt(Context&x,const char*name,const char*wanted)noexcept{
 int fd=openat(x.directory,name,O_RDONLY|O_CLOEXEC|O_NOFOLLOW);if(fd<0)return false;struct stat s{};
 bool ok=!fstat(fd,&s)&&S_ISREG(s.st_mode)&&s.st_uid==0&&s.st_gid==0&&(s.st_mode&07777)==0600&&s.st_nlink==1&&s.st_size>0&&s.st_size<=65536&&hash_fd(fd,static_cast<std::uint64_t>(s.st_size),wanted);
 if(close(fd))ok=false;return ok;
}
struct Map {Address a{},z{},off{};std::uint64_t ino{};unsigned ma{},mi{};char perm[5]{};};
bool maps(Context&x,char*text,std::size_t capacity)noexcept{char p[80];std::size_t n{};std::snprintf(p,sizeof p,"/proc/%u/maps",x.contract->pid);return bounded(p,text,capacity,n)&&n>0;}
bool map_line(const char*p,Map&m)noexcept{
 unsigned long long a,z,o,i;int consumed=0;
 if(std::sscanf(p,"%llx-%llx %4s %llx %x:%x %llu %n",&a,&z,m.perm,&o,&m.ma,&m.mi,&i,&consumed)!=7||a>=z||consumed<=0)return false;
 m.a=a;m.z=z;m.off=o;m.ino=i;return true;
}
bool covered(const char*text,Address a,Address z,std::uint64_t dev,std::uint64_t ino,unsigned flags,Address fileoff)noexcept{
 while(a<z){bool found=false;for(const char*p=text;*p;){const char*nl=std::strchr(p,'\n');if(!nl)return false;Map m{};if(!map_line(p,m))return false;
   if(m.a<=a&&a<m.z){if(m.ino!=ino||m.ma!=major(static_cast<dev_t>(dev))||m.mi!=minor(static_cast<dev_t>(dev))||m.perm[0]!='r'||m.perm[1]!='-'||m.perm[2]!=((flags&PF_X)?'x':'-')||m.perm[3]!='p'||m.off+a-m.a!=fileoff)return false;
    Address n=m.z<z?m.z:z;fileoff+=n-a;a=n;found=true;break;}p=nl+1;
  }if(!found)return false;
 }return true;
}
bool loaded_readonly(Context&x,int fd,std::uint64_t size,std::uint64_t dev,std::uint64_t ino,Address bias,bool user,const char*maptext)noexcept{
 Elf64_Ehdr h{};Elf64_Phdr ph[32]{};if(!read_exact(fd,&h,sizeof h,0)||std::memcmp(h.e_ident,"\x7f" "ELF\x02\x01\x01",7)||h.e_machine!=EM_AARCH64||h.e_type!=(user?ET_EXEC:ET_DYN)||h.e_phentsize!=sizeof(Elf64_Phdr)||!h.e_phnum||h.e_phnum>32||!read_exact(fd,ph,h.e_phnum*sizeof(Elf64_Phdr),h.e_phoff))return false;
 unsigned ro=0,ex=0;unsigned char file[4096],live[4096];
 for(unsigned i=0;i<h.e_phnum;++i)if(ph[i].p_type==PT_LOAD&&(ph[i].p_flags&PF_R)&&!(ph[i].p_flags&PF_W)){
  const auto&p=ph[i];if(p.p_offset>size||p.p_filesz>size-p.p_offset||bias>UINT64_MAX-p.p_vaddr||bias+p.p_vaddr>UINT64_MAX-p.p_filesz||!covered(maptext,bias+p.p_vaddr,bias+p.p_vaddr+p.p_filesz,dev,ino,p.p_flags,p.p_offset))return false;
  ++ro;if(p.p_flags&PF_X){if(!user){if(ex>=x.contract->own_executable_count||x.contract->own_executable[ex].begin!=bias+p.p_vaddr||x.contract->own_executable[ex].end!=bias+p.p_vaddr+p.p_memsz)return false;}++ex;}
  for(Address off=0;off<p.p_filesz;){const auto n=static_cast<std::size_t>(p.p_filesz-off>sizeof file?sizeof file:p.p_filesz-off);const Address va=bias+p.p_vaddr+off;
   if(!read_exact(fd,file,n,p.p_offset+off)||!read_exact(x.mem,live,n,va))return false;
   // Only this exact hook's first pair may differ from the original User.
   // The transaction independently selects original vs installed expectation.
   if(user&&va<=entry&&entry+8<=va+n){std::uint64_t actual{},patch{};std::memcpy(&actual,live+entry-va,8);if(!patched_pair(*x.contract,patch)||(actual!=original_pair&&actual!=patch))return false;std::memcpy(live+entry-va,file+entry-va,8);}
   if(std::memcmp(file,live,n))return false;off+=n;
  }
 }
 return ro>0&&ex>0&&(user||ex==x.contract->own_executable_count);
}
bool near_ready(Context&x,const char*text)noexcept{
 const auto&c=*x.contract;bool found=false;for(const char*p=text;*p;){const char*nl=std::strchr(p,'\n');if(!nl)return false;Map m{};if(!map_line(p,m))return false;
  if(m.a==c.near_page&&m.z==c.near_page+c.near_bytes&&m.ino==0&&m.ma==0&&m.mi==0&&std::strcmp(m.perm,"r-xp")==0)found=true;p=nl+1;
 }if(!found)return false;
 const std::uint64_t veneer0=0xd61f020058000050ULL;std::uint64_t a{},b{},tramp{},slot{};
 const auto source=c.near_page+20;const auto delta=static_cast<std::int64_t>(entry+4)-static_cast<std::int64_t>(source);
 if(delta<-(1LL<<27)||delta>=(1LL<<27)||(delta&3))return false;
 const std::uint64_t expected_tramp=0xd10403ffULL|((0x14000000ULL|(static_cast<std::uint32_t>(delta/4)&0x3ffffffU))<<32);
 struct CopiedPreparation {unsigned sequence{},bytes{};PreparationMetadata metadata{};};static_assert(sizeof(CopiedPreparation)==192);
 CopiedPreparation one{},two{};normal10::Status status{},again{};
 if(!read_exact(x.mem,&one,sizeof one,c.prepared_publication)||!read_exact(x.mem,&two,sizeof two,c.prepared_publication)||std::memcmp(&one,&two,sizeof one)||(one.sequence&1)||one.bytes!=192)return false;
 const auto&m=one.metadata;
 if(m.schema!=10||m.bytes!=sizeof m||m.result!=PreparationResult::Prepared||m.attempts!=1||m.pid!=c.pid||m.pid_ticks!=c.pid_ticks||m.ui_tid!=c.ui_tid||m.generation!=c.prepared_generation||m.near_page!=c.near_page||m.near_bytes!=c.near_bytes||m.bridge!=c.own_bridge||m.trampoline_slot!=c.trampoline_slot||m.trampoline_value!=c.near_page+16||m.original_pair!=original_pair||std::memcmp(m.input_sha,c.prepared_input_sha,65)||!m.owner_queue||!m.renderer_status)return false;
 // Own source-published status address, not an arbitrary callback or guessed
 // getter. Stop-time readback ensures default OFF and prior stock restoration.
 if(m.renderer_status<c.module_bias||m.renderer_status>c.module_bias+0x60000-sizeof status||!read_exact(x.mem,&status,sizeof status,m.renderer_status)||!read_exact(x.mem,&again,sizeof again,m.renderer_status)||std::memcmp(&status,&again,sizeof status)||status.schema!=10||status.bytes!=sizeof status||status.requested!=iq4::MaskMode::Off||status.phase!=normal10::Phase::OffClean||!status.factory_restored||!status.module_retained||!status.selection_installed)return false;
 return read_exact(x.mem,&a,8,c.near_page)&&a==veneer0&&read_exact(x.mem,&b,8,c.near_page+8)&&b==c.own_bridge&&read_exact(x.mem,&tramp,8,c.near_page+16)&&tramp==expected_tramp&&read_exact(x.mem,&slot,8,c.trampoline_slot)&&slot==c.near_page+16;
}
bool identity(void*v,const Contract&c,Operation)noexcept{
 auto&x=*static_cast<Context*>(v);std::uint64_t ticks{};utsname kernel{};
 if(getuid()!=0||geteuid()!=0||!proc_stat(c.pid,ticks)||ticks!=c.pid_ticks||uname(&kernel)||std::strcmp(kernel.release,kernel_release))return false;
 char version[4096];std::size_t n{};if(!bounded("/proc/version",version,sizeof version,n))return false;F4Sha hash;f4_sha_init(&hash);f4_sha_update(&hash,version,n);char digest[65];f4_sha_end(&hash,digest);if(std::strcmp(digest,c.proc_version_sha))return false;
 if(!root_receipt(x,"root.contract.receipt",c.root_receipt_sha)||!root_receipt(x,"provider.receipt",c.provider_receipt_sha)||!root_receipt(x,"off_clean.receipt",c.off_clean_receipt_sha)||!root_receipt(x,"near_prepared.receipt",c.preparation_receipt_sha))return false;
 char path[80],maptext[65536];std::snprintf(path,sizeof path,"/proc/%u/exe",c.pid);int fd=open(path,O_RDONLY|O_CLOEXEC);if(fd<0)return false;struct stat u{};
 bool ok=!fstat(fd,&u)&&S_ISREG(u.st_mode)&&u.st_size==11874544&&static_cast<std::uint64_t>(u.st_dev)==c.user_dev&&static_cast<std::uint64_t>(u.st_ino)==c.user_ino&&hash_fd(fd,11874544,user_sha)&&maps(x,maptext,sizeof maptext)&&loaded_readonly(x,fd,11874544,c.user_dev,c.user_ino,0,true,maptext);
 if(close(fd))ok=false;if(!ok)return false;
 fd=open(c.module_path,O_RDONLY|O_CLOEXEC|O_NOFOLLOW);if(fd<0)return false;struct stat s{};
 ok=!fstat(fd,&s)&&S_ISREG(s.st_mode)&&static_cast<std::uint64_t>(s.st_size)==module_bytes&&s.st_uid==0&&s.st_gid==0&&(s.st_mode&07777)==0500&&s.st_nlink==1&&static_cast<std::uint64_t>(s.st_dev)==c.module_dev&&static_cast<std::uint64_t>(s.st_ino)==c.module_ino&&hash_fd(fd,module_bytes,module_sha256)&&loaded_readonly(x,fd,module_bytes,c.module_dev,c.module_ino,c.module_bias,false,maptext)&&near_ready(x,maptext);
 if(close(fd))ok=false;return ok&&proc_stat(c.pid,ticks)&&ticks==c.pid_ticks;
}
bool list(void*,const Contract&c,Snapshot&s)noexcept{
 char path[80];std::snprintf(path,sizeof path,"/proc/%u/task",c.pid);DIR*d=opendir(path);if(!d)return false;bool ok=true;s={};
 errno=0;while(auto*e=readdir(d)){if(e->d_name[0]=='.')continue;char*end{};errno=0;auto tid=std::strtoul(e->d_name,&end,10);if(errno||*end||tid<=1||tid>UINT32_MAX||s.count==max_threads){ok=false;break;}
  std::uint64_t tick{};if(!proc_stat(static_cast<std::uint32_t>(tid),tick)){ok=false;break;}s.threads[s.count++]={static_cast<std::uint32_t>(tid),tick};errno=0;
 }if(errno)ok=false;if(closedir(d))ok=false;
 for(unsigned i=0;i<s.count;++i)for(unsigned j=i+1;j<s.count;++j)if(s.threads[j].tid<s.threads[i].tid){const auto t=s.threads[i];s.threads[i]=s.threads[j];s.threads[j]=t;}return ok;
}
bool seize(void*,std::uint32_t tid)noexcept{return ptrace(PTRACE_SEIZE,static_cast<pid_t>(tid),nullptr,0UL)==0;}
bool interrupt_wait(void*,std::uint32_t tid)noexcept{
 if(ptrace(PTRACE_INTERRUPT,static_cast<pid_t>(tid),nullptr,nullptr))return false;const auto start=millis();if(!start)return false;
 for(;;){int status{};pid_t got=waitpid(static_cast<pid_t>(tid),&status,__WALL|WNOHANG);if(got==static_cast<pid_t>(tid))return WIFSTOPPED(status)&&WSTOPSIG(status)==SIGTRAP&&(static_cast<unsigned>(status)>>16)==PTRACE_EVENT_STOP;
  if(got<0&&errno!=EINTR)return false;const auto now=millis();if(!now||now<start||now-start>=2000)return false;timespec delay{0,1000000};(void)nanosleep(&delay,nullptr);
 }
}
bool registers(void*,std::uint32_t tid,Registers&r)noexcept{
 user_pt_regs actual{};iovec io{&actual,sizeof actual};if(ptrace(PTRACE_GETREGSET,static_cast<pid_t>(tid),reinterpret_cast<void*>(NT_PRSTATUS),&io)||io.iov_len!=sizeof actual)return false;
 std::memcpy(&r,&actual,sizeof r);return true;
}
bool read_pair(void*,std::uint32_t tid,Address address,std::uint64_t&pair)noexcept{if(address!=entry)return false;errno=0;long r=ptrace(PTRACE_PEEKTEXT,static_cast<pid_t>(tid),reinterpret_cast<void*>(address),nullptr);if(r==-1&&errno)return false;pair=static_cast<std::uint64_t>(r);return true;}
bool poke(void*,std::uint32_t tid,Address address,std::uint64_t pair)noexcept{
 // Actual Boot's generic poke/access_remote/copy_to_user_page path synchronizes
 // VM_EXEC caches. No 4-byte atomicity or unreviewed remote cache RPC is claimed.
 return address==entry&&ptrace(PTRACE_POKETEXT,static_cast<pid_t>(tid),reinterpret_cast<void*>(address),reinterpret_cast<void*>(pair))==0;
}
bool save(void*v,const Journal&j)noexcept{
 auto&x=*static_cast<Context*>(v);if(x.sequence>=1024)return false;char name[48];std::snprintf(name,sizeof name,"journal.%04u.bin",x.sequence++);
 int fd=openat(x.directory,name,O_WRONLY|O_CREAT|O_EXCL|O_CLOEXEC|O_NOFOLLOW,0600);if(fd<0)return false;std::size_t done=0;bool ok=true;
 while(done<sizeof j){auto n=write(fd,reinterpret_cast<const char*>(&j)+done,sizeof j-done);if(n<0&&errno==EINTR)continue;if(n<=0){ok=false;break;}done+=static_cast<std::size_t>(n);}if(fsync(fd))ok=false;if(close(fd))ok=false;return ok&&!fsync(x.directory);
}
bool detach(void*,std::uint32_t tid)noexcept{return ptrace(PTRACE_DETACH,static_cast<pid_t>(tid),nullptr,nullptr)==0;}
[[noreturn]] void hold_forever(const Journal&j)noexcept{
 std::fprintf(stderr,"{\"hook10\":\"HOLD\",\"attached\":%u,\"detached\":%u,\"write_may_have_happened\":%s,\"automatic_exit_or_signal\":false}\n",j.attached_count,j.detached_count,j.write_may_have_happened?"true":"false");
 // Exiting a tracer can resume the target. Do not turn a timeout/error into
 // automatic detach, EXITKILL, kill, SDK stop, retry, or interpreter close.
 for(;;){timespec interval{1,0};(void)nanosleep(&interval,nullptr);}
}
}
// The separately reviewed Root runner calls this concrete backend with an
// embedded actual contract. This prep-only build's main never calls it.
extern "C" __attribute__((used,noinline)) int iq4_f1_root_trace_transaction_10(const Contract*c,unsigned requested)noexcept{
 if(!c||!fixed_contract(*c)||(requested!=1&&requested!=2))return 2;
 Context context{};context.contract=c;context.directory=open(c->state_dir,O_RDONLY|O_DIRECTORY|O_CLOEXEC|O_NOFOLLOW);if(context.directory<0)return 2;
 struct stat dir{};if(fstat(context.directory,&dir)||!S_ISDIR(dir.st_mode)||dir.st_uid||dir.st_gid||(dir.st_mode&07777)!=0700){close(context.directory);return 2;}
 int lock=openat(context.directory,"controller.lock",O_RDWR|O_CREAT|O_CLOEXEC|O_NOFOLLOW,0600);struct stat ls{};
 if(lock<0||fstat(lock,&ls)||!S_ISREG(ls.st_mode)||ls.st_uid||ls.st_gid||(ls.st_mode&07777)!=0600||ls.st_nlink!=1||flock(lock,LOCK_EX|LOCK_NB)){if(lock>=0)close(lock);close(context.directory);return 2;}
 char path[80];std::snprintf(path,sizeof path,"/proc/%u/mem",c->pid);context.mem=open(path,O_RDONLY|O_CLOEXEC);if(context.mem<0){close(lock);close(context.directory);return 2;}
 // Ignore ordinary process termination while owning tracees. Root must keep
 // this controller alive during HOLD. SIGKILL/crash/power loss cannot be made
 // safe by this source; independent cold recovery remains required.
 struct sigaction sa{};sa.sa_handler=SIG_IGN;sigemptyset(&sa.sa_mask);
 if(sigaction(SIGTERM,&sa,nullptr)||sigaction(SIGINT,&sa,nullptr)||sigaction(SIGHUP,&sa,nullptr)){close(context.mem);close(lock);close(context.directory);return 2;}
 Ops ops{&context,identity,list,seize,interrupt_wait,registers,read_pair,poke,save,detach};Transaction tx{ops};
 bool okay=tx.stop(*c,static_cast<Operation>(requested));
 if(okay)okay=tx.write_once(*c);
 // A failed install is never resent. If the process remains fully stopped and
 // readback is one of the two exact pairs, attempt the independent original
 // restoration once. Foreign/torn bytes and any detach failure remain HOLD.
 if(!okay&&tx.journal().write_may_have_happened&&requested==1)okay=tx.restore_after_failed_install(*c);
 if(okay)okay=tx.detach_ordered(*c);
 if(!okay&&tx.journal().attached_count)hold_forever(tx.journal());
 close(context.mem);close(lock);close(context.directory);return okay?0:2;
}
// Linked into the new five-file loader's entrytool. Fixed operation names and
// fixed Root-owned contract paths; no extra ELF or generic PID/address CLI.
extern "C" __attribute__((used,noinline)) int iq4_f1_hook10_fixed_file_operation(unsigned operation)noexcept{
 if(operation!=1&&operation!=2)return 2;
 constexpr const char*base="/run/iq4_f1_observe02";struct stat d{};
 if(lstat(base,&d)||!S_ISDIR(d.st_mode)||d.st_uid||d.st_gid||(d.st_mode&07777)!=0700)return 2;
 const char*path=operation==1?"/run/iq4_f1_observe02/hook10.install.contract":"/run/iq4_f1_observe02/hook10.restore.contract";
 const char*sidecar=operation==1?"/run/iq4_f1_observe02/hook10.install.contract.sha256":"/run/iq4_f1_observe02/hook10.restore.contract.sha256";
 const char*state=operation==1?"/run/iq4_f1_observe02/hook10.install":"/run/iq4_f1_observe02/hook10.restore";
 auto read_root=[](const char*file,void*out,std::size_t bytes)noexcept{
  int fd=open(file,O_RDONLY|O_CLOEXEC|O_NOFOLLOW);if(fd<0)return false;struct stat a{},b{};
  bool ok=!fstat(fd,&a)&&S_ISREG(a.st_mode)&&a.st_uid==0&&a.st_gid==0&&(a.st_mode&07777)==0600&&a.st_nlink==1&&a.st_size>=0&&static_cast<std::uint64_t>(a.st_size)==bytes&&read_exact(fd,out,bytes,0)&&!fstat(fd,&b)&&a.st_dev==b.st_dev&&a.st_ino==b.st_ino&&a.st_size==b.st_size&&a.st_mtim.tv_sec==b.st_mtim.tv_sec&&a.st_mtim.tv_nsec==b.st_mtim.tv_nsec&&a.st_ctim.tv_sec==b.st_ctim.tv_sec&&a.st_ctim.tv_nsec==b.st_ctim.tv_nsec;
  if(close(fd))ok=false;struct stat c{};return ok&&!lstat(file,&c)&&c.st_dev==b.st_dev&&c.st_ino==b.st_ino&&c.st_size==b.st_size&&c.st_mode==b.st_mode&&c.st_uid==b.st_uid&&c.st_gid==b.st_gid;
 };
 Contract contract{};char expected[66]{};
 if(!read_root(path,&contract,sizeof contract)||!read_root(sidecar,expected,65)||expected[64]!='\n')return 2;expected[64]=0;
 F4Sha sha;f4_sha_init(&sha);f4_sha_update(&sha,&contract,sizeof contract);char actual[65];f4_sha_end(&sha,actual);
 if(std::strcmp(actual,expected)||std::strcmp(contract.module_path,"/run/iq4_f1_observe02/observe.so")||std::strcmp(contract.state_dir,state)||!fixed_contract(contract))return 2;
 // The same protected loader receipt identifies the User process. A contract
 // for a different same-image PID must not become this entrytool's target.
 char loaded[96]{},canonical[96]{};std::size_t loaded_bytes{};struct stat ls{};
 constexpr const char*loaded_path="/run/iq4_f1_observe02/loaded.pid";
 if(lstat(loaded_path,&ls)||!S_ISREG(ls.st_mode)||ls.st_uid||ls.st_gid||(ls.st_mode&07777)!=0600||ls.st_nlink!=1||ls.st_size<=0||ls.st_size>=static_cast<off_t>(sizeof loaded)||!read_root(loaded_path,loaded,static_cast<std::size_t>(ls.st_size)))return 2;
 loaded_bytes=static_cast<std::size_t>(ls.st_size);
 const int z=std::snprintf(canonical,sizeof canonical,"%u %llu\n",contract.pid,static_cast<unsigned long long>(contract.pid_ticks));
 if(z<=0||static_cast<std::size_t>(z)!=loaded_bytes||std::memcmp(loaded,canonical,loaded_bytes))return 2;
 return iq4_f1_root_trace_transaction_10(&contract,operation);
}
#ifndef IQ4_F1_HOOK10_NO_MAIN
int main(int argc,char**argv){
 if(argc==1||(argc==2&&std::strcmp(argv[1],"--prep")==0)){
  std::puts("{\"schema\":10,\"prep_only\":true,\"controller_body_linked\":true,\"actual_contract_received\":false,\"target_stopped\":false,\"target_text_written\":false,\"target_loaded\":false,\"commands\":[]}");return 0;
 }
 std::fputs("actual operations require a separately reviewed Root runner and actual contract; no generic PID/address CLI\n",stderr);return 2;
}
#endif
