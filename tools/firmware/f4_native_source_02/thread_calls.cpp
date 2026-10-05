#include "thread_calls.h"
#include <string.h>
extern "C" int iq4_f4_thread_pins_02(Iq4F4SelfRead02 read,void*ctx){
 static const uintptr_t va[2]={0x40a220,0x40a8c0};
 static const uint32_t words[2][4]={{0xb00059d0,0xf9419611,0x910ca210,0xd61f0220},{0xb00059d0,0xf9433e11,0x9119e210,0xd61f0220}};
 uint32_t b[4];if(!read)return 0;
 for(unsigned i=0;i<2;++i)if(read(ctx,va[i],b,sizeof b)!=1||memcmp(b,words[i],sizeof b))return 0;
 return 1;
}
extern "C" int iq4_f4_thread_create_02(uint64_t*out,void*(*start)(void*),void*arg,int*rc){
 try{*rc=((int(*)(uint64_t*,const void*,void*(*)(void*),void*))(uintptr_t)0x40a220)(out,0,start,arg);return 1;}catch(...){return 0;}
}
extern "C" int iq4_f4_thread_join_02(uint64_t t,void**v,int*rc){
 try{*rc=((int(*)(uint64_t,void**))(uintptr_t)0x40a8c0)(t,v);return 1;}catch(...){return 0;}
}
static long futex(uint32_t*p,int op,uint32_t value,const void*timeout){
#if defined(__aarch64__) && defined(__linux__)
 register long x8 __asm__("x8")=98;register long x0 __asm__("x0")=(long)p;
 register long x1 __asm__("x1")=op;register long x2 __asm__("x2")=value;register long x3 __asm__("x3")=(long)timeout;
 register long x4 __asm__("x4")=0;register long x5 __asm__("x5")=0;
 __asm__ volatile("svc 0":"+r"(x0):"r"(x8),"r"(x1),"r"(x2),"r"(x3),"r"(x4),"r"(x5):"memory","cc");return x0;
#else
 (void)p;(void)op;(void)value;(void)timeout;return -1;
#endif
}
extern "C" void iq4_f4_thread_wake_02(uint32_t*p){__atomic_fetch_add(p,1,__ATOMIC_RELEASE);(void)futex(p,129,1,0);}
extern "C" void iq4_f4_thread_wait_02(uint32_t*p,uint32_t value){const int64_t timeout[2]={0,100000000};(void)futex(p,128,value,timeout);}
