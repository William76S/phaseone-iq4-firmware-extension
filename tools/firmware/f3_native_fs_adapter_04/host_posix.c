/* Host verification only. Mac nonreplacement uses atomic linkat+unlinkat;
 * this deliberately is not claimed as camera renameat2 capability. */
#define _GNU_SOURCE
#include "fs.h"
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
static struct F3SysResult result(int64_t n){return(struct F3SysResult){n,n<0?errno:0};}
static void sc(struct F3FdStat*out,struct stat*st){
#ifdef __APPLE__
 *out=(struct F3FdStat){st->st_dev,st->st_ino,st->st_size<0?UINT64_MAX:(uint64_t)st->st_size,st->st_nlink,st->st_mode,st->st_mtimespec.tv_sec,st->st_mtimespec.tv_nsec};
#else
 *out=(struct F3FdStat){st->st_dev,st->st_ino,st->st_size<0?UINT64_MAX:(uint64_t)st->st_size,st->st_nlink,st->st_mode,st->st_mtim.tv_sec,st->st_mtim.tv_nsec};
#endif
}
static struct F3SysResult op(int d,const char*p,int wr){return result(openat(d,p,wr?(O_RDWR|O_CREAT|O_EXCL|O_NOFOLLOW|O_CLOEXEC):(O_RDONLY|O_NOFOLLOW|O_CLOEXEC),0600));}
static struct F3SysResult sf(int fd,struct F3FdStat*out){struct stat st;int n=fstat(fd,&st);struct F3SysResult r=result(n);if(!n)sc(out,&st);return r;}
static struct F3SysResult sl(int d,const char*p,struct F3FdStat*out){struct stat st;int n=fstatat(d,p,&st,AT_SYMLINK_NOFOLLOW);struct F3SysResult r=result(n);if(!n)sc(out,&st);return r;}
static struct F3SysResult rd(int fd,void*p,uint32_t n){return result(read(fd,p,n));}
static struct F3SysResult ra(int fd,void*p,uint32_t n,uint64_t o){return result(pread(fd,p,n,(off_t)o));}
static struct F3SysResult wr(int fd,const void*p,uint32_t n){return result(write(fd,p,n));}
static struct F3SysResult sy(int fd){return result(fsync(fd));}
static struct F3SysResult cl(int fd){return result(close(fd));}
static struct F3SysResult mv(int d,const char*a,const char*b){if(linkat(d,a,d,b,0))return result(-1);if(unlinkat(d,a,0))return(struct F3SysResult){-2,errno};return result(0);}
static struct F3SysResult ul(int d,const char*p){return result(unlinkat(d,p,0));}
void f3_fs_host_api_03(struct F3Posix*out){*out=(struct F3Posix){op,sf,sl,rd,ra,wr,sy,cl,mv,ul};}
