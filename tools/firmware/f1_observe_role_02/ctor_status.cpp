// Additional target constructor in the new fixed role only. No UI/native
// function invocation; all identity comes from actual OS/private-file reads.
#define _GNU_SOURCE
#include "../f1_module_entry_01/module.hpp"
#include "../f4_ui_bootstrap_02/sha256.h"
#include "status.h"
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>
#include <cstring>
#include <cstdio>
#include <cstdlib>
#include <cerrno>
#include "role_config.h"
extern "C" iq4::f1::entry01::PublishedObservation iq4_f1_entry_observed;
extern "C" int f4_parse_stat(const char*,std::size_t,std::uint64_t,std::uint64_t*);
extern "C" {__attribute__((visibility("default"))) unsigned iq4_f1_role_ctor_status;}
namespace {
bool same(const struct stat&a,const struct stat&b)noexcept{return a.st_dev==b.st_dev&&a.st_ino==b.st_ino&&a.st_mode==b.st_mode&&a.st_uid==b.st_uid&&a.st_gid==b.st_gid&&a.st_size==b.st_size&&a.st_nlink==b.st_nlink&&a.st_mtim.tv_sec==b.st_mtim.tv_sec&&a.st_mtim.tv_nsec==b.st_mtim.tv_nsec;}
bool metadata(const struct stat&s,unsigned mode,std::uint64_t maximum)noexcept{return S_ISREG(s.st_mode)&&s.st_uid==0&&s.st_gid==0&&(s.st_mode&07777)==mode&&s.st_nlink>=1&&s.st_size>0&&std::uint64_t(s.st_size)<=maximum;}
bool bounded_file(const char*path,void*out,std::size_t maximum,std::size_t&length,unsigned mode)noexcept{
    struct stat a{},b{},c{};if(lstat(path,&a)||!metadata(a,mode,maximum)||a.st_nlink!=1)return false;
    int fd=open(path,O_RDONLY|O_CLOEXEC|O_NOFOLLOW);if(fd<0)return false;
    bool ok=!fstat(fd,&b)&&same(a,b);std::size_t done=0;
    while(ok&&done<static_cast<std::size_t>(b.st_size)){ssize_t n=read(fd,static_cast<char*>(out)+done,static_cast<std::size_t>(b.st_size)-done);if(n<=0){ok=false;break;}done+=static_cast<std::size_t>(n);}
    char extra{};if(ok)ok=read(fd,&extra,1)==0&&!fstat(fd,&c)&&same(b,c)&&!lstat(path,&c)&&same(b,c);if(close(fd))ok=false;length=done;return ok;
}
bool decimal(const char*&p,const char*end,std::uint64_t&out)noexcept{
    out=0;const char*start=p;if(p==end||*p<'1'||*p>'9')return false;
    while(p<end&&*p>='0'&&*p<='9'){unsigned d=static_cast<unsigned>(*p++-'0');if(out>(UINT64_MAX-d)/10)return false;out=out*10+d;}return p!=start;
}
bool loaded_identity(std::uint64_t&pid,std::uint64_t&ticks)noexcept{
    char b[96]{};std::size_t n{};if(!bounded_file(F1_ROLE_STATE "/loaded.pid",b,sizeof(b),n,0600))return false;
    const char*p=b,*end=b+n;return decimal(p,end,pid)&&p<end&&*p++==' '&&decimal(p,end,ticks)&&p<end&&*p++=='\n'&&p==end&&pid==static_cast<std::uint64_t>(getpid());
}
bool current_ticks(std::uint64_t pid,std::uint64_t&tick)noexcept{
    char path[64],b[4096];if(std::snprintf(path,sizeof path,"/proc/%llu/stat",static_cast<unsigned long long>(pid))<=0)return false;
    int fd=open(path,O_RDONLY|O_CLOEXEC|O_NOFOLLOW);if(fd<0)return false;std::size_t n=0;bool ok=true;
    while(n<sizeof(b)){ssize_t count=read(fd,b+n,sizeof(b)-n);if(count<0){ok=false;break;}if(!count)break;n+=static_cast<std::size_t>(count);}
    if(n==sizeof(b))ok=false;if(close(fd))ok=false;return ok&&f4_parse_stat(b,n,pid,&tick);
}
bool peer_executable(pid_t pid)noexcept{
    char p[64],path[512];if(std::snprintf(p,sizeof p,"/proc/%ld/exe",static_cast<long>(pid))<=0)return false;
    ssize_t n=readlink(p,path,sizeof(path)-1);if(n<=0||n>=static_cast<ssize_t>(sizeof(path)-1))return false;path[n]=0;if(std::strcmp(path,F1_ROLE_TOOL))return false;
    // Bind actual peer executable to the protected staged public artifact hash.
    char expected[65];std::size_t size{};if(!bounded_file(F1_ROLE_STATE "/entry.sha256",expected,sizeof expected,size,0600)||size!=65||expected[64]!='\n')return false;expected[64]=0;
    for(unsigned i=0;i<64;i++)if(!((expected[i]>='0'&&expected[i]<='9')||(expected[i]>='a'&&expected[i]<='f')))return false;
    int fd=open(p,O_RDONLY|O_CLOEXEC);if(fd<0)return false;struct stat a{},b{},staged{};bool ok=!fstat(fd,&a)&&metadata(a,0500,1048576)&&!lstat(F1_ROLE_TOOL,&staged)&&same(a,staged);
    F4Sha sha;f4_sha_init(&sha);unsigned char bytes[4096];std::uint64_t offset=0;
    while(ok&&offset<static_cast<std::uint64_t>(a.st_size)){std::size_t count=static_cast<std::uint64_t>(a.st_size)-offset>sizeof bytes?sizeof bytes:static_cast<std::size_t>(a.st_size-offset);ssize_t nread=pread(fd,bytes,count,static_cast<off_t>(offset));if(nread!=static_cast<ssize_t>(count)){ok=false;break;}f4_sha_update(&sha,bytes,count);offset+=count;}
    char hash[65];f4_sha_end(&sha,hash);if(ok)ok=!std::strcmp(hash,expected)&&!fstat(fd,&b)&&same(a,b)&&!lstat(F1_ROLE_TOOL,&staged)&&same(a,staged);
    // Recheck the peer's actual executable path after hashing the held inode.
    if(ok){n=readlink(p,path,sizeof(path)-1);if(n<=0||n>=static_cast<ssize_t>(sizeof(path)-1))ok=false;else{path[n]=0;ok=!std::strcmp(path,F1_ROLE_TOOL);}}
    if(close(fd))ok=false;return ok;
}
bool inherited_owner(struct stat&identity)noexcept{
    if(fstat(198,&identity)||!S_ISSOCK(identity.st_mode))return false;
    struct stat dir{},socket{};
    if(lstat(F1_ROLE_STATE,&dir)||!S_ISDIR(dir.st_mode)||dir.st_uid!=0||dir.st_gid!=0||(dir.st_mode&07777)!=0700||lstat(F1_ROLE_STATE "/control.sock",&socket)||!S_ISSOCK(socket.st_mode)||socket.st_uid!=0||socket.st_gid!=0||(socket.st_mode&07777)!=0600)return false;
    int type=0;socklen_t len=sizeof type;if(getsockopt(198,SOL_SOCKET,SO_TYPE,&type,&len)||len!=sizeof type||type!=SOCK_SEQPACKET)return false;
    sockaddr_un address{};len=sizeof address;constexpr auto address_minimum=offsetof(sockaddr_un,sun_path)+sizeof(F1_ROLE_STATE "/control.sock");
    if(getpeername(198,reinterpret_cast<sockaddr*>(&address),&len)||address.sun_family!=AF_UNIX||len<address_minimum||len>sizeof address||std::memcmp(address.sun_path,F1_ROLE_STATE "/control.sock",sizeof(F1_ROLE_STATE "/control.sock")))return false;
    for(std::size_t i=address_minimum;i<len;i++)if(reinterpret_cast<const unsigned char*>(&address)[i])return false;
    struct ucred peer{};len=sizeof peer;if(getsockopt(198,SOL_SOCKET,SO_PEERCRED,&peer,&len)||len!=sizeof peer||peer.uid!=0||peer.gid!=0||peer.pid<=1||!peer_executable(peer.pid))return false;
    std::uint64_t pid{},before{},after{},stored{};if(!loaded_identity(pid,stored)||!current_ticks(pid,before)||before!=stored||!current_ticks(pid,after)||before!=after)return false;
    struct stat fd_after{};return !fstat(198,&fd_after)&&same(identity,fd_after);
}
__attribute__((constructor)) void role_constructor()noexcept{
    // Default compiled role does not inspect or close any inherited descriptor.
    if(!F1_ROLE_ENABLED)return;
    const char*mode=std::getenv("IQ4_F1_MODULE_ENTRY_01");if(!mode||std::strcmp(mode,"OBSERVE")){iq4_f1_role_ctor_status=1;return;}
    struct stat identity{},now{};if(!inherited_owner(identity)){iq4_f1_role_ctor_status=2;return;}
    const unsigned startup=iq4_f1_entry_observed.startup.load(std::memory_order_acquire);if(startup>7){iq4_f1_role_ctor_status=3;return;}
    if(fstat(198,&now)||!same(identity,now)){iq4_f1_role_ctor_status=2;return;}
    std::uint8_t packet[16];f1_status_encode(packet,startup);ssize_t count=send(198,packet,sizeof packet,MSG_DONTWAIT|MSG_NOSIGNAL);
    iq4_f1_role_ctor_status=count==sizeof packet?(startup==4?4:5):6;
    // Only the authenticated launcher-owned descriptor is closed. No user
    // process/thread/module termination, arbitrary FD or UI object cleanup.
    // Unknown descriptor replacement is retained. A constructor-only lease
    // remains required: POSIX close(fd) cannot atomically compare an inode.
    if(fstat(198,&now)||!same(identity,now)){iq4_f1_role_ctor_status=8;return;}
    if(close(198))iq4_f1_role_ctor_status=7;
}
}
