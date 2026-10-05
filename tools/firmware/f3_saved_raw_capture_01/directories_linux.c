#define _GNU_SOURCE
#include "capture.h"
#include <sys/syscall.h>
#include <fcntl.h>
#if !defined(__aarch64__) || !defined(__linux__)
#error AArch64 Linux target only
#endif
extern long iq4_f3_original_syscall_03(long,...);
extern int*iq4_f3_original_errno_location_03(void);
static struct F3SysResult child(int dir,const char*component){
 long fd=iq4_f3_original_syscall_03(SYS_openat,dir,component,O_RDONLY|O_DIRECTORY|O_NOFOLLOW|O_CLOEXEC,0);
 return(struct F3SysResult){fd,fd<0?*iq4_f3_original_errno_location_03():0};
}
void f3_capture_linux_directories_01(struct F3CaptureDirectories01*out){*out=(struct F3CaptureDirectories01){child};}
