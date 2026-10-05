#include "native_binding.hpp"
#include "api_pins.h"
#include <cstring>
#if defined(__aarch64__) && defined(__linux__)
#include <sys/syscall.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <cstddef>
static_assert(sizeof(struct stat)==128&&offsetof(struct stat,st_size)==48&&offsetof(struct stat,st_mtim)==88&&offsetof(struct stat,st_ctim)==104,"A64 Linux kernel stat128");
static_assert(SYS_fcntl==25&&SYS_fstat==80&&SYS_pread64==67&&SYS_lseek==62,"A64 Linux saved-reader syscall numbers");
extern "C" long iq4_native_original_syscall_01(long,...);
namespace iq4::native_render_02 {
static bool native_stamp(int fd,raw_file_source_01::FileStamp& out){
 struct stat st{};const long flags=iq4_native_original_syscall_01(SYS_fcntl,fd,F_GETFL,0);
 if(flags<0||iq4_native_original_syscall_01(SYS_fstat,fd,&st)||st.st_size<0)return false;
 out={st.st_dev,st.st_ino,std::uint64_t(st.st_size),st.st_mtim.tv_sec,st.st_mtim.tv_nsec,
  st.st_ctim.tv_sec,st.st_ctim.tv_nsec,st.st_mode,(flags&O_ACCMODE)==O_RDONLY};return true;
}
static std::int64_t native_pread(int fd,void* p,std::uint32_t n,std::uint64_t offset){
 if(fd<0||!p||!n||offset>INT64_MAX||n>INT64_MAX-offset||std::uintptr_t(p)>UINTPTR_MAX-n)return -1;
 return iq4_native_original_syscall_01(SYS_pread64,fd,p,n,offset);
}
static std::int64_t native_tell(int fd){return fd<0?-1:iq4_native_original_syscall_01(SYS_lseek,fd,std::uint64_t(0),SEEK_CUR);}
}
#endif
namespace iq4::native_render_02 {
Result bind_native_file_ops_02(Iq4DecodeRead02 read,void* context,raw_file_source_01::FileOps& out) noexcept{
 out={};unsigned char b[32];if(!read||read(context,0x40ae40,b,32)!=1||std::memcmp(b,iq4_source_syscall_pin_02,32))return Result::Unbound;
#if defined(__aarch64__) && defined(__linux__)
 out={native_stamp,native_pread,native_tell};return Result::Ok;
#else
 return Result::Unbound;
#endif
}
}
