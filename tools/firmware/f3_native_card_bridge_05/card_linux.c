#define _GNU_SOURCE
#include "card.h"
#include <sys/syscall.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#if !defined(__aarch64__) || !defined(__linux__)
#error Target only AArch64 Linux
#endif
extern long iq4_f3_original_syscall_03(long,...);
extern int*iq4_f3_original_errno_location_03(void);
static struct F3SysResult result(long v){return(struct F3SysResult){v,v<0?*iq4_f3_original_errno_location_03():0};}
static struct F3SysResult openroot(const char*p){return result(iq4_f3_original_syscall_03(SYS_openat,AT_FDCWD,p,O_RDONLY|O_DIRECTORY|O_NOFOLLOW|O_CLOEXEC,0));}
static struct F3SysResult parent(void){return openroot("/run/media");}
static struct F3SysResult cl(int fd){return result(iq4_f3_original_syscall_03(SYS_close,fd));}
static struct F3SysResult mountid(int fd,uint64_t*out,int*retained){
 if(fd<0||!out||!retained||*retained>=0)return(struct F3SysResult){-1,EINVAL};
 char path[64]="/proc/self/fdinfo/",digits[12],data[513];size_t used=17,n=0;unsigned v=(unsigned)fd;
 do{digits[n++]=(char)('0'+v%10);v/=10;}while(v);while(n)path[used++]=digits[--n];path[used]=0;
 long f=iq4_f3_original_syscall_03(SYS_openat,AT_FDCWD,path,O_RDONLY|O_NOFOLLOW|O_CLOEXEC,0);if(f<0)return result(f);
 size_t total=0;int error=0,complete=0;
 while(total<sizeof(data)){long r=iq4_f3_original_syscall_03(SYS_read,(int)f,data+total,sizeof(data)-total);if(r<0){error=*iq4_f3_original_errno_location_03();break;}if(!r){complete=1;break;}total+=(size_t)r;}
 int valid=complete&&total<=512&&f3_fdinfo_mount_id_05(data,total,out);
 long closed=iq4_f3_original_syscall_03(SYS_close,(int)f);if(closed){*retained=(int)f;return result(closed);}if(!valid)return(struct F3SysResult){-1,error?error:EINVAL};return(struct F3SysResult){0,0};
}
void f3_card_linux_io_05(struct F3CardIo05*out){struct F3Posix fs;f3_fs_linux_api_03(&fs);*out=(struct F3CardIo05){openroot,parent,mountid,fs.stat_fd,cl};}
