#define _GNU_SOURCE
#include "movie.h"
#include <sys/syscall.h>
extern long iq4_f3_original_syscall_03(long,...);
extern int*iq4_f3_original_errno_location_03(void);
static struct F3SysResult write_at(int fd,const void*p,uint32_t n,uint64_t off){long v=iq4_f3_original_syscall_03(SYS_pwrite64,fd,p,n,off);return(struct F3SysResult){v,v<0?*iq4_f3_original_errno_location_03():0};}
void f4_movie_linux_api_01(struct F4MovieApi01*out){f3_fs_linux_api_03(&out->fs);out->write_at=write_at;}
