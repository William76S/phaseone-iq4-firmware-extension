#ifndef IQ4_F3_EXECUTOR_NATIVE_CALLS_01_H
#define IQ4_F3_EXECUTOR_NATIVE_CALLS_01_H
#include <stddef.h>
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
int f3_executor_read_01(uintptr_t,void*,size_t);
int f3_executor_current_01(uintptr_t*);
uint64_t f3_executor_tid_01(void);
int f3_executor_event_ctor_01(void*);
int f3_executor_listener_ctor_01(void*,void*,uintptr_t);
int f3_executor_event_notify_01(void*);
int f3_executor_selected_get_01(uintptr_t,int32_t*);
uint64_t f3_executor_pthread_self_01(void);
uint64_t f3_executor_clock_01(void);
int f3_executor_pause_01(void);
/* Alias resolves exactly original71384c. Its exception is rethrown unchanged;
 * only a live owned task additionally latches Hold, never a stock translation. */
uintptr_t iq4_f3_original_ifm_wait_01(void*,uint32_t);
#ifdef __cplusplus
}
#endif
#endif
