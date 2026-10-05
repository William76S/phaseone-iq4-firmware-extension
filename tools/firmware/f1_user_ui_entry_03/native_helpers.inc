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
