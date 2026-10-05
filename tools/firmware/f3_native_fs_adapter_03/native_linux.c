/* Cross-compiled against the exact AArch64 Linux/glibc2.28 headers. Aliases below
 * resolve ONLY to independently checked existing original PLT, not fresh imports. */
#define _GNU_SOURCE
#include "fs.h"
#include <sys/syscall.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stddef.h>
#include <unistd.h>
#include <errno.h>
#if !defined(__aarch64__) || !defined(__linux__)
#error Target wrapper is only AArch64 Linux
#endif
_Static_assert(sizeof(struct stat)==128,"AArch64 Linux stat128");
_Static_assert(offsetof(struct stat,st_ino)==8&&offsetof(struct stat,st_mode)==16&&offsetof(struct stat,st_size)==48,"kernel stat offsets");
_Static_assert(SYS_openat==56&&SYS_newfstatat==79&&SYS_fstat==80&&SYS_pread64==67&&SYS_renameat2==276&&SYS_unlinkat==35,"fixed AArch64 syscall values");
extern long iq4_f3_original_syscall_03(long,...);
extern int *iq4_f3_original_errno_location_03(void);
static struct F3SysResult result(long v){return(struct F3SysResult){v,v<0?*iq4_f3_original_errno_location_03():0};}
static void stat_copy(struct F3FdStat*out,const struct stat*st){*out=(struct F3FdStat){st->st_dev,st->st_ino,st->st_size<0?UINT64_MAX:(uint64_t)st->st_size,st->st_nlink,st->st_mode,st->st_mtim.tv_sec,st->st_mtim.tv_nsec};}
static struct F3SysResult op(int d,const char*p,int wr){return result(iq4_f3_original_syscall_03(SYS_openat,d,p,wr?(O_RDWR|O_CREAT|O_EXCL|O_NOFOLLOW|O_CLOEXEC):(O_RDONLY|O_NOFOLLOW|O_CLOEXEC),0600));}
static struct F3SysResult sf(int fd,struct F3FdStat*out){struct stat st;long r=iq4_f3_original_syscall_03(SYS_fstat,fd,&st);struct F3SysResult v=result(r);if(r==0)stat_copy(out,&st);return v;}
static struct F3SysResult sl(int d,const char*p,struct F3FdStat*out){struct stat st;long r=iq4_f3_original_syscall_03(SYS_newfstatat,d,p,&st,AT_SYMLINK_NOFOLLOW);struct F3SysResult v=result(r);if(r==0)stat_copy(out,&st);return v;}
static struct F3SysResult rd(int fd,void*p,uint32_t n){return result(iq4_f3_original_syscall_03(SYS_read,fd,p,n));}
static struct F3SysResult ra(int fd,void*p,uint32_t n,uint64_t o){return result(iq4_f3_original_syscall_03(SYS_pread64,fd,p,n,o));}
static struct F3SysResult wr(int fd,const void*p,uint32_t n){return result(iq4_f3_original_syscall_03(SYS_write,fd,p,n));}
static struct F3SysResult sy(int fd){return result(iq4_f3_original_syscall_03(SYS_fsync,fd));}
static struct F3SysResult cl(int fd){return result(iq4_f3_original_syscall_03(SYS_close,fd));}
static struct F3SysResult mv(int d,const char*a,const char*b){return result(iq4_f3_original_syscall_03(SYS_renameat2,d,a,d,b,1u));}
static struct F3SysResult ul(int d,const char*p){return result(iq4_f3_original_syscall_03(SYS_unlinkat,d,p,0));}
void f3_fs_linux_api_03(struct F3Posix*out){*out=(struct F3Posix){op,sf,sl,rd,ra,wr,sy,cl,mv,ul};}
