#include "native_calls.h"
#include "../native_runtime_01/self_read.h"
#include <asm/unistd.h>
static_assert(__NR_clock_gettime==113&&__NR_nanosleep==101,"pinned AArch64 wait syscalls");
#define GUARDED(body) try {body;return 1;}catch(...){return 0;}
extern "C" int f3_executor_read_01(uintptr_t p,void*out,size_t n){return iq4_native_self_read_01(nullptr,p,out,n);}
extern "C" int f3_executor_current_01(uintptr_t*out){GUARDED(*out=(uintptr_t)((void*(*)())(uintptr_t)0x710b0c)());}
extern "C" uint64_t f3_executor_tid_01(void){return iq4_native_current_tid_01();}
extern "C" int f3_executor_event_ctor_01(void*p){GUARDED(((void(*)(void*,const char*))(uintptr_t)0x70f12c)(p,"IQ4OwnedCompleteRawJob01"));}
extern "C" int f3_executor_listener_ctor_01(void*p,void*e,uintptr_t q){GUARDED(((void(*)(void*,void*,void*))(uintptr_t)0x710524)(p,e,(void*)q));}
extern "C" int f3_executor_event_notify_01(void*p){GUARDED(((void(*)(void*))(uintptr_t)0x70f2f8)(p));}
extern "C" int f3_executor_selected_get_01(uintptr_t p,int32_t*out){GUARDED(*out=((int32_t(*)(void*))(uintptr_t)0x40c880)((void*)p));}
extern "C" uint64_t f3_executor_pthread_self_01(){try{return ((uint64_t(*)())(uintptr_t)0x40b1d0)();}catch(...){return 0;}}
static long syscall2(long n,long a,long b){register long x8 __asm__("x8")=n;register long x0 __asm__("x0")=a;register long x1 __asm__("x1")=b;
 __asm__ volatile("svc 0":"+r"(x0):"r"(x8),"r"(x1):"memory","cc");return x0;}
extern "C" uint64_t f3_executor_clock_01(){struct{int64_t s,n;}t;
 if(syscall2(113,1,(long)&t)||t.s<0||t.n<0||t.n>=1000000000||t.s>INT64_MAX/1000000000)return 0;
 return (uint64_t)t.s*1000000000+(uint64_t)t.n;}
extern "C" int f3_executor_pause_01(){const int64_t interval[2]={0,10000000};long r=syscall2(101,(long)interval,0);
 return r==0||r==-4; /* normal sleep or EINTR: observe again, never resend */}
