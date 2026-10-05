// Target object only. No constructor, preload hook, automatic capture or pixel receipt issuer.
#include "adapter.hpp"
#include "../f4_ui_bootstrap_02/sha256.h"
#include <elf.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <time.h>
#include <cstring>
#if !defined(__aarch64__) || !defined(__linux__)
#error Target-only fixed IQ4 Linux AArch64 metadata verifier
#endif
namespace iq4::f4::native_metadata {
namespace {
int memory_fd=-1;
long call(long nr,long a=0,long b=0,long c=0,long d=0) noexcept {
    register long x8 asm("x8")=nr;register long x0 asm("x0")=a;register long x1 asm("x1")=b;
    register long x2 asm("x2")=c;register long x3 asm("x3")=d;
    asm volatile("svc 0":"+r"(x0):"r"(x8),"r"(x1),"r"(x2),"r"(x3):"memory","cc");return x0;
}
int ropen(const char*p) noexcept {return static_cast<int>(call(SYS_openat,AT_FDCWD,reinterpret_cast<long>(p),O_RDONLY|O_CLOEXEC));}
void close_fd(int fd) noexcept {if(fd>=0)(void)call(SYS_close,fd);}
bool pread_all(int fd,void*out,std::size_t n,std::uint64_t offset) noexcept {
    if(fd<0||!n||n>4096||offset>INT64_MAX-n)return false;
    std::size_t done=0;while(done<n){long got=call(SYS_pread64,fd,reinterpret_cast<long>(static_cast<unsigned char*>(out)+done),n-done,offset+done);if(got<=0)return false;done+=static_cast<std::size_t>(got);}return true;
}
bool self_read(void*,Address a,void*out,std::size_t n) noexcept {return pread_all(memory_fd,out,n,a);}
std::uint64_t now(void*) noexcept {
    struct timespec t{};if(call(SYS_clock_gettime,CLOCK_MONOTONIC,reinterpret_cast<long>(&t))!=0||t.tv_sec<0||t.tv_nsec<0||t.tv_nsec>=1000000000)return 0;
    const auto sec=static_cast<std::uint64_t>(t.tv_sec);if(sec>(UINT64_MAX-static_cast<std::uint64_t>(t.tv_nsec))/1000000000)return 0;
    return sec*1000000000+static_cast<std::uint64_t>(t.tv_nsec);
}
bool hex(const char*&p,Address&v) noexcept {v=0;unsigned count=0;while(*p){unsigned n=*p>='0'&&*p<='9'?unsigned(*p-'0'):*p>='a'&&*p<='f'?unsigned(*p-'a'+10):99;if(n>=16)break;if(v>(UINTPTR_MAX-n)/16)return false;v=v*16+n;++p;++count;}return count>0;}
bool ro_coverage(char*maps,Address first,Address last) noexcept {
    Address covered=first;
    for(char*line=maps;*line;){char*end=std::strchr(line,'\n');if(!end)return false;char saved=*end;*end=0;
        const char*p=line;Address a{},b{};bool ok=hex(p,a)&&*p++=='-'&&hex(p,b)&&*p++==' '&&a<b;
        if(ok&&a<=covered&&covered<b){if(p[0]!='r'||p[1]!='-'){*end=saved;return false;}covered=b<last?b:last;}
        *end=saved;if(!ok)return false;if(covered==last)return true;line=end+1;
    }return false;
}
bool actual_user_image() noexcept {
    int fd=ropen("/proc/self/exe"),maps_fd=ropen("/proc/self/maps");struct stat st{};bool ok=fd>=0&&maps_fd>=0;
    if(ok)ok=call(SYS_fstat,fd,reinterpret_cast<long>(&st))==0&&S_ISREG(st.st_mode)&&st.st_size==11874544;
    char maps[65536]{};if(ok){long n=call(SYS_read,maps_fd,reinterpret_cast<long>(maps),sizeof(maps)-1);char extra{};
        ok=n>0&&call(SYS_read,maps_fd,reinterpret_cast<long>(&extra),1)==0;if(ok)maps[n]=0;}
    close_fd(maps_fd);unsigned char a[4096],b[4096];F4Sha sha;f4_sha_init(&sha);
    if(ok)for(std::uint64_t off=0;off<11874544;){std::size_t n=11874544-off>sizeof(a)?sizeof(a):std::size_t(11874544-off);if(!pread_all(fd,a,n,off)){ok=false;break;}f4_sha_update(&sha,a,n);off+=n;}
    char digest[65]{};f4_sha_end(&sha,digest);if(ok)ok=std::strcmp(digest,ui_counter::exact_user_sha256)==0;
    Elf64_Ehdr eh{};Elf64_Phdr ph[32]{};
    if(ok)ok=pread_all(fd,&eh,sizeof(eh),0)&&std::memcmp(eh.e_ident,"\x7f" "ELF\x02\x01\x01",7)==0&&eh.e_machine==EM_AARCH64&&eh.e_type==ET_EXEC&&eh.e_phentsize==sizeof(Elf64_Phdr)&&eh.e_phnum>0&&eh.e_phnum<=32&&pread_all(fd,ph,eh.e_phnum*sizeof(Elf64_Phdr),eh.e_phoff);
    unsigned segments=0;
    if(ok)for(unsigned i=0;i<eh.e_phnum;++i)if(ph[i].p_type==PT_LOAD&&(ph[i].p_flags&PF_R)&&!(ph[i].p_flags&PF_W)){
        if(ph[i].p_offset>11874544||ph[i].p_filesz>11874544-ph[i].p_offset||ph[i].p_vaddr>UINTPTR_MAX-ph[i].p_filesz||
           !ro_coverage(maps,ph[i].p_vaddr,ph[i].p_vaddr+ph[i].p_filesz)){ok=false;break;}++segments;
        for(std::uint64_t off=0;off<ph[i].p_filesz;){std::size_t n=ph[i].p_filesz-off>sizeof(a)?sizeof(a):std::size_t(ph[i].p_filesz-off);
            if(!pread_all(fd,a,n,ph[i].p_offset+off)||!self_read(nullptr,ph[i].p_vaddr+off,b,n)||std::memcmp(a,b,n)!=0){ok=false;break;}off+=n;}
        if(!ok)break;
    }
    close_fd(fd);return ok&&segments>0;
}
}
bool prepare_native(Adapter&a) noexcept {
    // Once only. Root must call preparation outside source locking and only
    // through its independently established original UI dispatch integration.
    if(a.ready_||a.hold_||memory_fd>=0)return false;
    memory_fd=ropen("/proc/self/mem");if(memory_fd<0||!actual_user_image()){close_fd(memory_fd);memory_fd=-1;return false;}
    a.operations_={nullptr,self_read,reinterpret_cast<void*(*)()>(0x710b0c),
        reinterpret_cast<const std::uint8_t*(*)(void*,std::int32_t)>(0x6b618c),
        reinterpret_cast<bool(*)(void*,std::int32_t)>(0x6b6250),
        reinterpret_cast<std::uint64_t(*)(void*)>(0x6b61fc),
        reinterpret_cast<std::uint32_t(*)(void*)>(0x6b62c0),now};
    a.ready_=true;return true;
}
}
