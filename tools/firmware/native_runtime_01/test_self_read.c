#include "self_read.h"
#include <assert.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>
struct V {void*base;size_t bytes;};
static unsigned calls;static int error,short_read;static long pid=91,tid=73;
long iq4_native_original_syscall_01(long nr,...) {
    ++calls;if(nr==172) return pid;if(nr==178) return tid;
    assert(nr==270);va_list v;va_start(v,nr);
    assert(va_arg(v,long)==pid);struct V*dst=va_arg(v,struct V*);
    assert(va_arg(v,unsigned long)==1);struct V*src=va_arg(v,struct V*);
    assert(va_arg(v,unsigned long)==1&&va_arg(v,unsigned long)==0);va_end(v);
    assert(dst->bytes==src->bytes&&dst->bytes<=4096);
    if(error)return -1;size_t n=dst->bytes-(short_read?1:0);
    memcpy(dst->base,src->base,n);return (long)n;
}
int main(void) {
    unsigned char src[4096],dst[4096];for(unsigned i=0;i<sizeof src;++i)src[i]=(unsigned char)i;
    assert(iq4_native_self_read_01(0,(uintptr_t)src,dst,sizeof src));assert(!memcmp(src,dst,sizeof src));
    unsigned before=calls;
    assert(!iq4_native_self_read_01(0,12,dst,4));assert(!iq4_native_self_read_01(0,UINTPTR_MAX-2,dst,4));
    assert(!iq4_native_self_read_01(0,(uintptr_t)src,0,4));assert(!iq4_native_self_read_01(0,(uintptr_t)src,dst,0));
    assert(!iq4_native_self_read_01(0,(uintptr_t)src,dst,4097));assert(calls==before);
    short_read=1;assert(!iq4_native_self_read_01(0,(uintptr_t)src,dst,4));short_read=0;
    error=1;assert(!iq4_native_self_read_01(0,(uintptr_t)src,dst,4));error=0;
    pid=-1;before=calls;assert(!iq4_native_self_read_01(0,(uintptr_t)src,dst,4));assert(calls==before+1);pid=91;
    assert(iq4_native_current_tid_01()==73);tid=-1;assert(iq4_native_current_tid_01()==0);
    puts("PASS: bounded own-process kernel-copy adapter, 10 groups; synthetic syscall fixture only");return 0;
}
