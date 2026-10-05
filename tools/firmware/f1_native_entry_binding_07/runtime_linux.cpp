#include "bridge.hpp"
// Target-only Linux/AArch64 wrapper. Never executed by the host validation tool.
#include "../f1_observe_geometry_04/observe.hpp"
#include "../f1_observe_stack_05/observe.hpp"
#include "../f1_display_observe_06/observe.hpp"
#include "../f4_ui_bootstrap_02/sha256.h"
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
#if !defined(__aarch64__) || !defined(__linux__)
#error This runtime binds only the fixed IQ4 AArch64 Linux original
#endif
extern "C" unsigned iq4_f1_role_ctor_status;
extern "C" __attribute__((visibility("default"))) iq4::f1::entry07::Published iq4_f1_entry_binding_observed_07;
iq4::f1::entry07::Published iq4_f1_entry_binding_observed_07;
extern "C" {__attribute__((visibility("default"))) iq4::f1::entry01::PublishedObservation iq4_f1_entry_observed;
__attribute__((visibility("default"))) iq4::f1::observe04::Published iq4_f1_geometry_observed_04;
__attribute__((visibility("default"))) iq4::f1::stack05::Published iq4_f1_stack_observed_05;
__attribute__((visibility("default"))) iq4::f1::display06::Published iq4_f1_display_observed_06;}
iq4::f1::native_ui02::Rectangle24 iq4_f1_display_paint_callback_06(void*,void*,const iq4::f1::native_ui02::Rectangle24*,iq4::f1::native_ui02::Rectangle24*) __asm__("iq4_f1_display_paint_callback_06");
namespace {
using namespace iq4::f1::entry01;
// No dlvsym/dlsym, pthread_create, SDK, signal, process exit or retry interface.
long raw_call(long nr,long a=0,long b=0,long c=0,long d=0) noexcept {
    register long x8 asm("x8")=nr;register long x0 asm("x0")=a;register long x1 asm("x1")=b;register long x2 asm("x2")=c;register long x3 asm("x3")=d;
    asm volatile("svc 0" : "+r"(x0) : "r"(x8),"r"(x1),"r"(x2),"r"(x3) : "memory","cc");return x0;
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
alignas(iq4::f1::entry07::BoundaryBridge) unsigned char entry07_storage[sizeof(iq4::f1::entry07::BoundaryBridge)]{};
iq4::f1::entry07::BoundaryBridge* entry07_bridge=nullptr;
alignas(Module) unsigned char module_storage[sizeof(Module)]{};Module* module=nullptr;
alignas(iq4::f1::observe04::Collector) unsigned char geometry_storage[sizeof(iq4::f1::observe04::Collector)]{};
iq4::f1::observe04::Collector* geometry=nullptr;
alignas(iq4::f1::stack05::Collector) unsigned char stack_storage[sizeof(iq4::f1::stack05::Collector)]{};
iq4::f1::stack05::Collector* stack_collector=nullptr;
alignas(iq4::f1::display06::Collector) unsigned char display_storage[sizeof(iq4::f1::display06::Collector)]{};
iq4::f1::display06::Collector* display_collector=nullptr;
std::atomic<Address> original_paint{};
std::atomic_flag display_busy=ATOMIC_FLAG_INIT;
std::atomic<bool> diagnostic_ready{false};thread_local bool inside=false;
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
bool user_ro_mappings(const Elf64_Ehdr&eh,const Elf64_Phdr*ph,const struct stat&st) noexcept {
    int maps=ropen("/proc/self/maps");if(maps<0)return false;char lines[65536];char extra{};
    const long size=raw_call(SYS_read,maps,reinterpret_cast<long>(lines),sizeof(lines)-1);const long tail=raw_call(SYS_read,maps,reinterpret_cast<long>(&extra),1);rclose(maps);
    if(size<=0||tail!=0)return false;lines[size]=0;
    for(unsigned i=0;i<eh.e_phnum;++i)if(ph[i].p_type==PT_LOAD&&(ph[i].p_flags&PF_R)&&!(ph[i].p_flags&PF_W)){
        Address cursor=ph[i].p_vaddr,end=cursor+ph[i].p_filesz;if(end<cursor)return false;
        while(cursor<end){bool found=false;
            for(char*line=lines;*line;){char*nl=std::strchr(line,'\n');if(!nl)return false;*nl=0;Mapping m{};const bool parsed=mapping(line,m);*nl='\n';
                if(parsed&&m.begin<=cursor&&m.end>cursor&&same_inode(m,st)&&m.permissions[0]=='r'&&m.permissions[1]=='-'&&
                   m.permissions[2]==((ph[i].p_flags&PF_X)?'x':'-')&&m.offset+cursor-m.begin==ph[i].p_offset+cursor-ph[i].p_vaddr){cursor=m.end<end?m.end:end;found=true;break;}line=nl+1;
            }if(!found)return false;
        }
    }
    return true;
}
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
    if(ok)ok=user_ro_mappings(eh,ph,st);
    rclose(fd);return ok;
}
// Protected entry-only admission from Root's separately reviewed new UI07
// deployment contract. Absence/unknown/failure stays OFF. This file does not
// attest geometry, source coverage, paint freshness, or Surface lifetime.
bool entry07_admission(iq4::f1::entry07::Placement& placement) noexcept {
    if(iq4_f1_role_ctor_status!=4)return false;
    const char*path="/run/iq4_f1_observe02/ui07.entry";
    struct stat d{},a{},b{},c{};
    if(::lstat("/run/iq4_f1_observe02",&d)||!S_ISDIR(d.st_mode)||d.st_uid||d.st_gid||(d.st_mode&07777)!=0700||
       ::lstat(path,&a)||!S_ISREG(a.st_mode)||a.st_uid||a.st_gid||(a.st_mode&07777)!=0600||a.st_nlink!=1||a.st_size<=0||a.st_size>=96)return false;
    int fd=static_cast<int>(raw_call(SYS_openat,AT_FDCWD,reinterpret_cast<long>(path),O_RDONLY|O_CLOEXEC|O_NOFOLLOW));if(fd<0)return false;
    char text[96]{},canonical[96]{};bool ok=!::fstat(fd,&b)&&a.st_dev==b.st_dev&&a.st_ino==b.st_ino&&a.st_size==b.st_size&&a.st_mode==b.st_mode&&a.st_uid==b.st_uid&&a.st_gid==b.st_gid&&b.st_nlink==1;
    long n=ok?raw_call(SYS_read,fd,reinterpret_cast<long>(text),b.st_size):-1;char extra{};
    ok=ok&&n==b.st_size&&raw_call(SYS_read,fd,reinterpret_cast<long>(&extra),1)==0&&!::fstat(fd,&c)&&b.st_dev==c.st_dev&&b.st_ino==c.st_ino&&b.st_size==c.st_size&&b.st_mtim.tv_sec==c.st_mtim.tv_sec&&b.st_mtim.tv_nsec==c.st_mtim.tv_nsec;
    rclose(fd);int x=-1,y=-1;char tail{};
    if(!ok||::sscanf(text,"IQ4_F1_UI07_ENTRY_ONLY %d %d%c",&x,&y,&tail)!=3||tail!='\n'||x<0||y<0||x>32767||y>32767)return false;
    int size=::snprintf(canonical,sizeof canonical,"IQ4_F1_UI07_ENTRY_ONLY %d %d\n",x,y);
    if(size!=n||std::memcmp(text,canonical,static_cast<std::size_t>(n))||::lstat(path,&c)||b.st_dev!=c.st_dev||b.st_ino!=c.st_ino||b.st_size!=c.st_size)return false;
    placement={x,y};return true;
}
__attribute__((constructor)) void prepare() noexcept {
    // Dormant for UI: no native object/getter, thread, observer, event or camera
    // operation. No launcher marker descriptor is consumed by this module.
    const char* opt=std::getenv("IQ4_F1_MODULE_ENTRY_01");if(!opt||std::strcmp(opt,"OBSERVE")!=0)return;
    iq4_f1_entry_observed.startup.store(1,std::memory_order_release);
    if(!original_unlock.load(std::memory_order_acquire)&&!resolve_original()){iq4_f1_entry_observed.startup.store(5,std::memory_order_release);return;}
    iq4_f1_entry_observed.startup.store(2,std::memory_order_release);
    memory_fd=ropen("/proc/self/mem");if(memory_fd<0||!user_gate()){rclose(memory_fd);memory_fd=-1;iq4_f1_entry_observed.startup.store(6,std::memory_order_release);return;}
    iq4_f1_entry_observed.startup.store(3,std::memory_order_release);
    module=new(module_storage)Module;
    geometry=new(geometry_storage)iq4::f1::observe04::Collector({nullptr,self_read},0);
    stack_collector=new(stack_storage)iq4::f1::stack05::Collector({nullptr,self_read},0);
    display_collector=new(display_storage)iq4::f1::display06::Collector({nullptr,self_read},0,reinterpret_cast<Address>(&iq4_f1_display_paint_callback_06));
    entry07_bridge=new(entry07_storage)iq4::f1::entry07::BoundaryBridge;
    original_paint.store(0x51da0c,std::memory_order_release);
    iq4::f1::display06::publish(iq4_f1_display_observed_06,display_collector->snapshot());
    if(module->configure({nullptr,self_read},{true,true,true,true,0},reinterpret_cast<int(*)(void*)>(original_try_lock.load(std::memory_order_acquire)),reinterpret_cast<int(*)(void*)>(original_unlock.load(std::memory_order_acquire)))){diagnostic_ready.store(true,std::memory_order_release);iq4_f1_entry_observed.startup.store(4,std::memory_order_release);}
    else iq4_f1_entry_observed.startup.store(7,std::memory_order_release);

}
}
extern "C" __attribute__((visibility("default"),noinline)) int pthread_mutex_unlock(pthread_mutex_t* mutex) noexcept {
    const Address caller=reinterpret_cast<Address>(__builtin_return_address(0));
    Address address=original_unlock.load(std::memory_order_acquire);
    const int incoming=errno;
    if(!address){if(!resolve_original())unresolved_hold();address=original_unlock.load(std::memory_order_acquire);}
    errno=incoming;
    const int result=reinterpret_cast<int(*)(void*)>(address)(mutex); // EXACTLY ONCE, first.
    const int saved=errno;
    if(caller==0x6be8ac && result==0 && (diagnostic_ready.load(std::memory_order_acquire) || (entry07_bridge&&entry07_bridge->admitted())) && !inside) {
        inside=true;Address tp{};asm volatile("mrs %0, tpidr_el0":"=r"(tp));
        const BoundaryInput input{caller,reinterpret_cast<Address>(__builtin_frame_address(0)),tp,reinterpret_cast<Address>(mutex),result};
        iq4::f1::entry01::Observation before{};
        const bool before_copied=module->snapshot(before);
        module->after_unlock(input);
        iq4::f1::entry01::Observation observed{};
        if(module->snapshot(observed)){
            iq4_f1_entry_observed.sequence.fetch_add(1,std::memory_order_acq_rel);
            iq4_f1_entry_observed.metadata=observed;
            iq4_f1_entry_observed.sequence.fetch_add(1,std::memory_order_release);
            // Bound even the inherited original-current getter attempts if
            // native layout keeps failing before qualified epoch advances.
            if(observed.native_original_calls>=64 || observed.qualified_boundaries>=64 ||
               observed.phase==static_cast<unsigned>(iq4::f1::entry01::Phase::Stopped) || observed.phase==static_cast<unsigned>(iq4::f1::entry01::Phase::Hold))
                diagnostic_ready.store(false,std::memory_order_release);
            iq4::f1::observe04::Metadata facts{};
            if(geometry&&geometry->capture(input,observed,iq4_f1_entry_observed.startup.load(std::memory_order_acquire),facts)){
                iq4_f1_geometry_observed_04.sequence.fetch_add(1,std::memory_order_acq_rel);
                iq4_f1_geometry_observed_04.metadata=facts;
                iq4_f1_geometry_observed_04.sequence.fetch_add(1,std::memory_order_release);
            }
            iq4::f1::stack05::Metadata stack_facts{};
            if(before_copied && stack_collector && stack_collector->capture(input,before,observed,iq4_f1_entry_observed.startup.load(std::memory_order_acquire),stack_facts)){
                iq4_f1_stack_observed_05.sequence.fetch_add(1,std::memory_order_acq_rel);
                iq4_f1_stack_observed_05.metadata=stack_facts;
                iq4_f1_stack_observed_05.sequence.fetch_add(1,std::memory_order_release);
                iq4::f1::display06::Metadata display_facts{};
                if(display_collector&&!display_busy.test_and_set(std::memory_order_acquire)){
                    if(display_collector->capture_boundary(input,stack_facts,display_facts))
                        iq4::f1::display06::publish(iq4_f1_display_observed_06,display_facts);
                    display_busy.clear(std::memory_order_release);
                }
                if(stack_facts.attempts>=64)diagnostic_ready.store(false,std::memory_order_release);
            }
        }
        if(entry07_bridge&&display_collector){
            iq4::f1::entry07::Placement placement{};
            if(!entry07_bridge->admitted()&&entry07_admission(placement))
                (void)entry07_bridge->admit_once({true,true,true,true},placement);
            entry07_bridge->after_original_unlock_on_ui({nullptr,self_read},*module,*display_collector,input,
                {reinterpret_cast<int(*)(void*)>(original_try_lock.load(std::memory_order_acquire)),reinterpret_cast<int(*)(void*)>(original_unlock.load(std::memory_order_acquire))});
            iq4_f1_entry_binding_observed_07.sequence.fetch_add(1,std::memory_order_acq_rel);
            iq4_f1_entry_binding_observed_07.metadata=entry07_bridge->binding().status_on_ui();
            iq4_f1_entry_binding_observed_07.sequence.fetch_add(1,std::memory_order_release);
            if(iq4_f1_entry_binding_observed_07.metadata.ui_mutation_attempted){
                auto changed=display_collector->snapshot();changed.native_ui_mutation_called=1;
                iq4::f1::display06::publish(iq4_f1_display_observed_06,changed);
            }
        }
        inside=false;
    }
    errno=saved;return result;
}

// Data publications only. Read-only Geo04 deliberately exports no original
// menu, fill, observer, repaint, stop, or pointer-based integration methods.
// Stack05 independently reads only scalar identities/graph at this real boundary;
// it never changes the inherited Entry phase or Geometry03/04 gates.

// Callback is retained and exported for a separately reviewed reversible RAM
// table trial. This source only builds the private table; it never writes LV's
// vptr or installs a hook. No selector/toolbar callback is changed or invoked.
__attribute__((visibility("default"),noinline,aligned(16)))
iq4::f1::native_ui02::Rectangle24 iq4_f1_display_paint_callback_06(
    void* lv,void* surface,const iq4::f1::native_ui02::Rectangle24* draw,
    iq4::f1::native_ui02::Rectangle24* clip) {
    const auto original=original_paint.load(std::memory_order_acquire);
    if(!original)unresolved_hold(); // no table may be installed before actual User gate.
    Address tp{};asm volatile("mrs %0, tpidr_el0":"=r"(tp));
    const iq4::f1::geometry03::PaintInput input{
      tp,reinterpret_cast<Address>(__builtin_frame_address(0)),
      reinterpret_cast<Address>(__builtin_return_address(0)),
      reinterpret_cast<Address>(lv),reinterpret_cast<Address>(surface),
      reinterpret_cast<Address>(draw),reinterpret_cast<Address>(clip)};
    const bool own=!display_busy.test_and_set(std::memory_order_acquire);
    try {
      const auto returned=iq4::f1::display06::forward_once(
        reinterpret_cast<iq4::f1::native_overlay::LVPaint>(original),lv,surface,draw,clip,
        own?display_collector:nullptr,own?&input:nullptr,own?&iq4_f1_display_observed_06:nullptr);
      if(own)display_busy.clear(std::memory_order_release);
      asm volatile("":::"memory");return returned;
    } catch(...) {if(own)display_busy.clear(std::memory_order_release);throw;}
}
