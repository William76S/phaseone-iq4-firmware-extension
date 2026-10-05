#define _GNU_SOURCE
#include "arena.h"
#include <sys/mman.h>
#include <sys/syscall.h>
#include <errno.h>
#include <limits.h>
#if !defined(__aarch64__) || !defined(__linux__)
#error IQ4 scratch wrapper requires AArch64 Linux
#endif
_Static_assert(sizeof(void*)==8 && sizeof(long)==8,"LP64 syscall ABI");
_Static_assert(SYS_ftruncate==46 && SYS_fallocate==47 && SYS_mmap==222 &&
 SYS_munmap==215 && SYS_msync==227,"pinned AArch64 syscalls");
_Static_assert(PROT_READ==1 && PROT_WRITE==2 && MAP_SHARED==1 && MS_SYNC==4,
 "pinned Linux mmap flags");
extern long iq4_f3_original_syscall_03(long,...);
extern int *iq4_f3_original_errno_location_03(void);
static struct F3SysResult value(long r) {
 return (struct F3SysResult){r,r==-1?*iq4_f3_original_errno_location_03():0};
}
static struct F3SysResult tr(int fd,uint64_t n) {
 return value(iq4_f3_original_syscall_03(SYS_ftruncate,fd,n));
}
static struct F3SysResult alloc(int fd,uint64_t n) {
 struct F3SysResult r=value(iq4_f3_original_syscall_03(SYS_fallocate,fd,0,UINT64_C(0),n));
 if(r.value==-1 && (r.error==ENOSYS || r.error==EOPNOTSUPP)) r.value=-2;
 return r;
}
static struct F3SysResult map(int fd,uint64_t n) {
 return value(iq4_f3_original_syscall_03(SYS_mmap,0,n,PROT_READ|PROT_WRITE,MAP_SHARED,fd,UINT64_C(0)));
}
static struct F3SysResult flush(void *p,uint64_t n) {
 return value(iq4_f3_original_syscall_03(SYS_msync,p,n,MS_SYNC));
}
static struct F3SysResult unmap(void *p,uint64_t n) {
 return value(iq4_f3_original_syscall_03(SYS_munmap,p,n));
}
void f3_arena_linux_api_01(struct F3ArenaApi *out) {
 f3_fs_linux_api_03(&out->io);
 out->truncate=tr; out->allocate=alloc; out->map_shared=map;
 out->flush_map=flush; out->unmap=unmap;
}
