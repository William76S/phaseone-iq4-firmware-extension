#include "native_calls.h"
/* Only the same original User's real C++ methods, with a C exception barrier.
 * This object has no libc++/libstdc++ container/string/shared_ptr ABI. */
#define CALL(body) try { body; return 1; } catch (...) { return 0; }
extern "C" int iq4_f4_native_current_02(uintptr_t *v) { CALL(*v=(uintptr_t)((void *(*)())(uintptr_t)0x710b0c)()); }
extern "C" int iq4_f4_native_lock_02(uintptr_t a,int32_t c,uintptr_t *v) { CALL(*v=(uintptr_t)((const void *(*)(void *,int32_t))(uintptr_t)0x6b618c)((void *)a,c)); }
extern "C" int iq4_f4_native_unlock_02(uintptr_t a,int32_t c,int *v) { CALL(*v=((bool(*)(void *,int32_t))(uintptr_t)0x6b6250)((void *)a,c)?1:0); }
extern "C" int iq4_f4_native_size_02(uintptr_t a,uint64_t *v) { CALL(*v=((uint64_t(*)(void *))(uintptr_t)0x6b61fc)((void *)a)); }
extern "C" int iq4_f4_native_id_02(uintptr_t a,uint32_t *v) { CALL(*v=((uint32_t(*)(void *))(uintptr_t)0x6b62c0)((void *)a)); }
extern "C" int iq4_f4_native_construct_observer_02(void *p,const char *n,uintptr_t q) { CALL(((void(*)(void *,const char *,void *))(uintptr_t)0x70fe3c)(p,n,(void *)q)); }
extern "C" int iq4_f4_native_subscribe_02(void *p,uintptr_t e) { CALL(((void(*)(void *,void *))(uintptr_t)0x70fed8)(p,(void *)e)); }
extern "C" int iq4_f4_native_unsubscribe_02(void *p,uintptr_t e) { CALL(((void(*)(void *,void *))(uintptr_t)0x70ff08)(p,(void *)e)); }
extern "C" int iq4_f4_native_trylock_02(uintptr_t p,int *v) { CALL(*v=((int(*)(void *))(uintptr_t)0x40ae80)((void *)p)); }
extern "C" int iq4_f4_native_mutex_unlock_02(uintptr_t p,int *v) { CALL(*v=((int(*)(void *))(uintptr_t)0x40a730)((void *)p)); }
extern "C" int iq4_f4_native_event_construct_02(void*p,const char*n) { CALL(((void(*)(void*,const char*))(uintptr_t)0x70f12c)(p,n)); }
extern "C" int iq4_f4_native_event_notify_02(void*p) { CALL(((void(*)(void*))(uintptr_t)0x70f2f8)(p)); }
static long call2(long n,long a,long b) {
#if defined(__aarch64__) && defined(__linux__)
 register long x8 __asm__("x8")=n;register long x0 __asm__("x0")=a;register long x1 __asm__("x1")=b;
 __asm__ volatile("svc 0":"+r"(x0):"r"(x8),"r"(x1):"memory","cc");return x0;
#else
 (void)n;(void)a;(void)b;return -1;
#endif
}
extern "C" uint64_t iq4_f4_native_clock_02(void) { struct {int64_t s,n;} t;
 if(call2(113,1,(long)&t)||t.s<0||t.n<0||t.n>=1000000000||t.s>INT64_MAX/1000000000)return 0;
 return (uint64_t)t.s*1000000000+(uint64_t)t.n;
}
extern "C" uint64_t iq4_f4_native_tid_02(void) {long n=call2(178,0,0);return n>0?(uint64_t)n:0;}

/* Same original queue-global recursive lock used by 712790.
 * Never call while holding a native frame lock. No retry or synthetic success. */
#if defined(IQ4_F4_QUEUE_LOCK_SYNTHETIC_HOST)
extern "C" void iq4_f4_test_original_queue_lock_05(void *);
#endif
extern "C" int iq4_f4_native_queue_lock_05(uintptr_t p) {
 if(p!=0xf553c0)return 0;
 try {
#if defined(IQ4_F4_QUEUE_LOCK_SYNTHETIC_HOST)
  iq4_f4_test_original_queue_lock_05((void *)p);
#else
  ((void(*)(void *))(uintptr_t)0x71242c)((void *)p);
#endif
  return 1;
 } catch (...) { return 0; }
}
