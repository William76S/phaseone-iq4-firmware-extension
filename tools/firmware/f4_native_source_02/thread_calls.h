#ifndef IQ4_F4_THREAD_CALLS_02_H
#define IQ4_F4_THREAD_CALLS_02_H
#include "source.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Ordinary original glibc pthread ABI, NOT a native CThread/TP+0x10 object. */
int iq4_f4_thread_pins_02(Iq4F4SelfRead02,void*);
int iq4_f4_thread_create_02(uint64_t*,void*(*)(void*),void*,int*);
int iq4_f4_thread_join_02(uint64_t,void**,int*);
/* Own Linux futex; native UI never waits. Timeout is bounded 100 ms. */
void iq4_f4_thread_wake_02(uint32_t*);
void iq4_f4_thread_wait_02(uint32_t*,uint32_t);
#ifdef __cplusplus
}
#endif
#endif
