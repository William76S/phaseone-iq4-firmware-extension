// Target-only Linux/AArch64 wrapper. Never executed by the host validation tool.
#include "bootstrap.hpp"
#include "sha256.h"
#include "status_wire.h"
#include <elf.h>
#include <fcntl.h>
#include <pthread.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <unistd.h>
#include <cerrno>
#include <cstdlib>
#include <cstring>
#include <atomic>
#include <new>
#include <sys/socket.h>
#if !defined(__aarch64__) || !defined(__linux__)
#error This runtime binds only the fixed IQ4 AArch64 Linux original
#endif
namespace {
using namespace iq4::f4::bootstrap;
// No dlvsym/dlsym, pthread_create, SDK, signal, process exit or retry interface.
long raw_call(long nr,long a=0,long b=0,long c=0,long d=0,long e=0,long f=0) noexcept {
    register long x8 asm("x8")=nr;register long x0 asm("x0")=a;register long x1 asm("x1")=b;register long x2 asm("x2")=c;register long x3 asm("x3")=d;register long x4 asm("x4")=e;register long x5 asm("x5")=f;
    asm volatile("svc 0" : "+r"(x0) : "r"(x8),"r"(x1),"r"(x2),"r"(x3),"r"(x4),"r"(x5) : "memory","cc");return x0;
}
int ropen(const char* path) noexcept {return static_cast<int>(raw_call(SYS_openat,AT_FDCWD,reinterpret_cast<long>(path),O_RDONLY|O_CLOEXEC));}
void rclose(int fd) noexcept {if(fd>=0)(void)raw_call(SYS_close,fd);}
bool pread_all(int fd,void* data,std::size_t count,std::uint64_t offset) noexcept {
    if(fd<0 || offset>INT64_MAX || count>0x100000 || offset>static_cast<std::uint64_t>(INT64_MAX)-count)return false;
    std::size_t done=0;while(done<count){long n=raw_call(SYS_pread64,fd,reinterpret_cast<long>(static_cast<unsigned char*>(data)+done),static_cast<long>(count-done),static_cast<long>(offset+done));if(n<=0)return false;done+=static_cast<std::size_t>(n);}return true;
}
bool file_hash(int fd,std::uint64_t size,const char* wanted) noexcept {
    if(size==0 || size>16*1024*1024)return false;F4Sha sha;f4_sha_init(&sha);unsigned char bytes[4096];
    for(std::uint64_t off=0;off<size;){std::size_t n=size-off>sizeof(bytes)?sizeof(bytes):static_cast<std::size_t>(size-off);if(!pread_all(fd,bytes,n,off))return false;f4_sha_update(&sha,bytes,n);off+=n;}
    unsigned char extra{};if(raw_call(SYS_pread64,fd,reinterpret_cast<long>(&extra),1,static_cast<long>(size))!=0)return false;char digest[65];f4_sha_end(&sha,digest);return std::strcmp(digest,wanted)==0;
}
struct Mapping {Address begin{},end{},offset{};unsigned major{},minor{};std::uint64_t inode{};char permissions[5]{},path[512]{};};
bool number(const char*& p,unsigned base,std::uint64_t& v) noexcept {v=0;unsigned digits=0;while(*p){unsigned n=*p>='0'&&*p<='9'?static_cast<unsigned>(*p-'0'):*p>='a'&&*p<='f'?static_cast<unsigned>(*p-'a'+10):99;if(n>=base)break;if(v>(UINT64_MAX-n)/base)return false;v=v*base+n;++p;++digits;}return digits!=0;}
bool mapping(const char* line,Mapping& m) noexcept {
    const char* p=line;std::uint64_t a,b,o,maj,min,ino;
    if(!number(p,16,a)||*p++!='-'||!number(p,16,b)||*p++!=' '||a>=b)return false;
    for(unsigned i=0;i<4;++i){if(!*p)return false;m.permissions[i]=*p++;}if(*p++!=' '||!number(p,16,o)||*p++!=' '||!number(p,16,maj)||*p++!=':'||!number(p,16,min)||*p++!=' '||!number(p,10,ino)||maj>UINT32_MAX||min>UINT32_MAX)return false;
    while(*p==' ')++p;std::size_t n=std::strlen(p);if(n>=sizeof(m.path))return false;std::memcpy(m.path,p,n+1);m.begin=a;m.end=b;m.offset=o;m.major=static_cast<unsigned>(maj);m.minor=static_cast<unsigned>(min);m.inode=ino;return true;
}
bool same_inode(const Mapping& m,const struct stat& s) noexcept {
    // Linux dev_t encoding, verified AArch64 public syscall struct stat target.
    const auto d=static_cast<std::uint64_t>(s.st_dev);const auto major=((d>>8)&0xfff)|((d>>32)&0xfffff000);const auto minor=(d&0xff)|((d>>12)&0xffffff00);
    return m.inode==static_cast<std::uint64_t>(s.st_ino)&&m.major==major&&m.minor==minor;
}
std::atomic<Address> original_unlock{}, original_try_lock{};int memory_fd=-1;
alignas(Bootstrap) unsigned char bootstrap_storage[sizeof(Bootstrap)]{};Bootstrap* bootstrap=nullptr;
std::atomic<bool> diagnostic_ready{false};thread_local bool inside=false;
// Only this separately reviewed counter-role launcher lends FD198. Failed
// validation never closes or writes an unproven borrowed descriptor.
bool status_fd_owned=false;std::uint32_t status_sequence=0,status_dropped=0;int last_phase=-1;
bool validate_status_fd() noexcept {
    int type=0;socklen_t length=sizeof(type);struct ucred peer{};
    if(raw_call(SYS_getsockopt,198,SOL_SOCKET,SO_TYPE,reinterpret_cast<long>(&type),reinterpret_cast<long>(&length))!=0||length!=sizeof(type)||type!=SOCK_SEQPACKET)return false;
    length=sizeof(peer);
    if(raw_call(SYS_getsockopt,198,SOL_SOCKET,SO_PEERCRED,reinterpret_cast<long>(&peer),reinterpret_cast<long>(&length))!=0||length!=sizeof(peer)||peer.pid<=1||peer.uid!=0||peer.gid!=0)return false;
    char path[64]="/proc/",digits[12];unsigned count=0;unsigned pid=static_cast<unsigned>(peer.pid);
    do{digits[count++]=static_cast<char>('0'+pid%10);pid/=10;}while(pid&&count<sizeof(digits));
    unsigned at=6;while(count)path[at++]=digits[--count];std::memcpy(path+at,"/exe",5);
    char actual[128];long n=raw_call(SYS_readlinkat,AT_FDCWD,reinterpret_cast<long>(path),reinterpret_cast<long>(actual),sizeof(actual)-1);
    static constexpr char expected[]="/run/iq4_f4_entry03/entrytool";
    return n==static_cast<long>(sizeof(expected)-1)&&std::memcmp(actual,expected,sizeof(expected)-1)==0;
}
void report_status(std::uint8_t kind,std::uint8_t phase,std::uint32_t reason,const Status* status=nullptr) noexcept {
    if(!status_fd_owned||status_sequence>=F4_STATUS_MAX_MESSAGES)return;
    F4Status03 s{};s.kind=kind;s.phase=phase;s.sequence=++status_sequence;s.reason=reason;s.dropped=status_dropped;
    if(status){s.flags=static_cast<std::uint8_t>((status->event_retained?1:0)|(status->module_retained?2:0));s.epoch=status->epoch;s.qualified=status->qualified_boundaries;s.callbacks=status->control_callbacks;s.notifications=status->notifications;}
    unsigned char packet[F4_STATUS_BYTES];f4_status_encode(packet,&s);
    const long n=raw_call(SYS_sendto,198,reinterpret_cast<long>(packet),sizeof(packet),MSG_DONTWAIT|MSG_NOSIGNAL,0,0);
    if(n!=static_cast<long>(sizeof(packet)))++status_dropped; // no retry, no UI state change
    if(phase==F4_PHASE_DETACHED_RETAINED||phase==F4_PHASE_HOLD){rclose(198);status_fd_owned=false;}
}
void report_phase(void*,const Status& status) noexcept {
    const int p=static_cast<int>(status.phase);if(p==last_phase)return;
    last_phase=p;report_status(F4_KIND_PHASE,static_cast<std::uint8_t>(p),0,&status);
}
bool self_read(void*,Address address,void* data,std::size_t n) noexcept {return n<=4096 && pread_all(memory_fd,data,n,address);}
// Resolve only the original exact public export, from the actual loaded library.
// This runs without dynamic-loader/pthread locks and before diagnostics.
bool resolve_original() noexcept {
    int maps=ropen("/proc/self/maps");if(maps<0)return false;char data[65536];long size=raw_call(SYS_read,maps,reinterpret_cast<long>(data),sizeof(data)-1);char extra{};
    const long tail=raw_call(SYS_read,maps,reinterpret_cast<long>(&extra),1);rclose(maps);if(size<=0||tail!=0)return false;data[size]=0;
    unsigned matches=0;Address base=0;Mapping first{};
    for(char* line=data;*line;){char* end=std::strchr(line,'\n');if(!end)return false;*end=0;Mapping m{};
        if(!mapping(line,m))return false;
        const char* name=std::strrchr(m.path,'/');
        if(name && std::strcmp(name+1,"libpthread-2.28.so")==0 && m.offset==0 && m.permissions[0]=='r' && m.permissions[1]=='-' && m.permissions[2]=='x') {first=m;base=m.begin;++matches;}
        line=end+1;
    }
    if(matches!=1||base>UINTPTR_MAX-0x20000)return false;
    int fd=ropen(first.path);struct stat st{};if(fd<0)return false;
    bool ok=raw_call(SYS_fstat,fd,reinterpret_cast<long>(&st))==0&&S_ISREG(st.st_mode)&&st.st_size==105736&&same_inode(first,st)&&file_hash(fd,105736,"9305ff30980749a3f64b3e445764db2bc378d14d1ef8bbe004d0ecc768d00f77");
    Elf64_Ehdr eh{};Elf64_Phdr ph[16]{};
    if(ok)ok=pread_all(fd,&eh,sizeof(eh),0)&&std::memcmp(eh.e_ident,"\x7f" "ELF\x02\x01\x01",7)==0&&eh.e_machine==EM_AARCH64&&eh.e_type==ET_DYN&&eh.e_phentsize==sizeof(Elf64_Phdr)&&eh.e_phnum>0&&eh.e_phnum<=16&&pread_all(fd,ph,sizeof(Elf64_Phdr)*eh.e_phnum,eh.e_phoff);
    // Exact mapped code must match the already hashed original file. All PF_X
    // load bytes are checked, not only a guessed trampoline instruction.
    int mem=ropen("/proc/self/mem");if(mem<0)ok=false;unsigned char a[4096],b[4096];unsigned executable=0;
    if(ok)for(unsigned i=0;i<eh.e_phnum;++i)if(ph[i].p_type==PT_LOAD&&(ph[i].p_flags&PF_X)){
        if(ph[i].p_vaddr!=ph[i].p_offset||ph[i].p_filesz>105736||ph[i].p_offset>105736-ph[i].p_filesz){ok=false;break;}++executable;
        for(std::uint64_t off=0;off<ph[i].p_filesz;){std::size_t n=ph[i].p_filesz-off>sizeof(a)?sizeof(a):static_cast<std::size_t>(ph[i].p_filesz-off);if(!pread_all(fd,a,n,ph[i].p_offset+off)||!pread_all(mem,b,n,base+ph[i].p_vaddr+off)||std::memcmp(a,b,n)!=0){ok=false;break;}off+=n;}
        if(!ok)break;
    }
    rclose(fd);rclose(mem);if(!ok||executable!=1)return false;
    original_try_lock.store(base+0x9d88,std::memory_order_release);original_unlock.store(base+0xb248,std::memory_order_release);return true;
}
// No fake error/success and no second unlock if the fixed provider cannot be
// resolved. This unsupported startup remains held; independent supervisor must
// preserve it, never signal/force-close/retry it. Prelaunch originals gate is required.
[[noreturn]] void unresolved_hold() noexcept {for(;;)(void)raw_call(SYS_ppoll,0,0,0,0);}
bool user_gate() noexcept {
    int fd=ropen("/proc/self/exe");struct stat st{};if(fd<0)return false;
    bool ok=raw_call(SYS_fstat,fd,reinterpret_cast<long>(&st))==0&&S_ISREG(st.st_mode)&&st.st_size==11874544&&file_hash(fd,11874544,iq4::f4::ui_counter::exact_user_sha256);
    Elf64_Ehdr eh{};Elf64_Phdr ph[32]{};
    if(ok)ok=pread_all(fd,&eh,sizeof(eh),0)&&std::memcmp(eh.e_ident,"\x7f" "ELF\x02\x01\x01",7)==0&&eh.e_machine==EM_AARCH64&&eh.e_type==ET_EXEC&&eh.e_phentsize==sizeof(Elf64_Phdr)&&eh.e_phnum>0&&eh.e_phnum<=32&&pread_all(fd,ph,eh.e_phnum*sizeof(Elf64_Phdr),eh.e_phoff);
    // This fixed ET_EXEC is accepted only at its original VAs (load bias 0).
    if(ok){unsigned char a[4096],b[4096];unsigned ro=0;for(unsigned i=0;i<eh.e_phnum;++i)if(ph[i].p_type==PT_LOAD && (ph[i].p_flags&PF_R) && !(ph[i].p_flags&PF_W)){
        if(ph[i].p_offset>11874544||ph[i].p_filesz>11874544-ph[i].p_offset){ok=false;break;}++ro;
        for(std::uint64_t off=0;off<ph[i].p_filesz;){std::size_t n=ph[i].p_filesz-off>sizeof(a)?sizeof(a):static_cast<std::size_t>(ph[i].p_filesz-off);if(!pread_all(fd,a,n,ph[i].p_offset+off)||!pread_all(memory_fd,b,n,ph[i].p_vaddr+off)||std::memcmp(a,b,n)!=0){ok=false;break;}off+=n;}if(!ok)break;
    }
    if(ro==0)ok=false;
    }
    rclose(fd);return ok;
}
__attribute__((constructor)) void prepare() noexcept {
    // Dormant for UI: no native object/getter, thread, observer, event or camera
    // operation. The new role reports bounded IPC even when disabled/rejected;
    // it never makes a native UI call from the loader constructor.
    if(!validate_status_fd())return;status_fd_owned=true;report_status(F4_KIND_LOADED,F4_PHASE_DISABLED,0);
    const char* opt=std::getenv("IQ4_F4_BOOTSTRAP_COUNTER_03");if(!opt||std::strcmp(opt,"ONCE")!=0){report_status(F4_KIND_REJECTED,F4_PHASE_HOLD,F4_REASON_DISABLED);return;}
    if(!original_unlock.load(std::memory_order_acquire)&&!resolve_original()){report_status(F4_KIND_REJECTED,F4_PHASE_HOLD,F4_REASON_ORIGINAL_PTHREAD);return;}
    memory_fd=ropen("/proc/self/mem");if(memory_fd<0||!user_gate()) {rclose(memory_fd);memory_fd=-1;report_status(F4_KIND_REJECTED,F4_PHASE_HOLD,F4_REASON_USER_IMAGE);return;}
    Native n{reinterpret_cast<Construct>(0x70fe3c),reinterpret_cast<Register>(0x70fed8),reinterpret_cast<Register>(0x70ff08),reinterpret_cast<CurrentThread>(0x710b0c),reinterpret_cast<EventConstruct>(0x70f12c),reinterpret_cast<EventNotify>(0x70f2f8),reinterpret_cast<Mutex>(original_try_lock.load(std::memory_order_acquire)),reinterpret_cast<Mutex>(original_unlock.load(std::memory_order_acquire))};
    bootstrap=new(bootstrap_storage)Bootstrap;
    bootstrap->set_reporter(nullptr,report_phase);
    if(bootstrap->configure({nullptr,self_read},n,{true,true,true,true,0})){report_phase(nullptr,bootstrap->status());diagnostic_ready.store(true,std::memory_order_release);}
    else report_status(F4_KIND_REJECTED,F4_PHASE_HOLD,F4_REASON_CONFIGURE);
}
}
extern "C" __attribute__((visibility("default"),noinline)) int pthread_mutex_unlock(pthread_mutex_t* mutex) noexcept {
    const Address caller=reinterpret_cast<Address>(__builtin_return_address(0));
    Address address=original_unlock.load(std::memory_order_acquire);
    const int incoming=errno;
    if(!address){if(!resolve_original())unresolved_hold();address=original_unlock.load(std::memory_order_acquire);}
    errno=incoming;
    const int result=reinterpret_cast<Mutex>(address)(mutex); // EXACTLY ONCE, first.
    const int saved=errno;
    if(caller==0x6be8ac && result==0 && !inside && diagnostic_ready.load(std::memory_order_acquire)) {
        inside=true;Address tp{};asm volatile("mrs %0, tpidr_el0":"=r"(tp));
        bootstrap->after_unlock(caller,reinterpret_cast<Address>(__builtin_frame_address(0)),tp,reinterpret_cast<Address>(mutex),result);inside=false;
    }
    errno=saved;return result;
}
