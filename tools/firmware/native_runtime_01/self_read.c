#include "self_read.h"
#ifndef IQ4_NATIVE_HOST_FIXTURE
#include <asm/unistd.h>
_Static_assert(__NR_process_vm_readv==270,"pinned AArch64 read syscall");
_Static_assert(__NR_getpid==172,"pinned AArch64 pid syscall");
_Static_assert(__NR_gettid==178,"pinned AArch64 tid syscall");
#endif
extern long iq4_native_original_syscall_01(long,...);
struct OwnIoVector01 {void *base;size_t bytes;};
_Static_assert(sizeof(struct OwnIoVector01)==16,"LP64 iovec");
int iq4_native_self_read_01(void *unused,uintptr_t address,void *out,size_t n) {
    struct OwnIoVector01 local,remote;long pid,result;(void)unused;
    if(!out||!n||n>4096||address<4096||address>UINTPTR_MAX-n||
       (uintptr_t)out>UINTPTR_MAX-n) return 0;
    pid=iq4_native_original_syscall_01(172);
    if(pid<=0) return 0;
    local.base=out;local.bytes=n;remote.base=(void*)address;remote.bytes=n;
    result=iq4_native_original_syscall_01(270,pid,&local,1ul,&remote,1ul,0ul);
    return result>=0&&(size_t)result==n;
}
uint64_t iq4_native_current_tid_01(void) {
    long id=iq4_native_original_syscall_01(178);
    return id>0?(uint64_t)id:0;
}
