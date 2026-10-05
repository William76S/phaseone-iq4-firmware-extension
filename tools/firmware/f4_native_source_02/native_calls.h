#ifndef IQ4_F4_NATIVE_CALLS_02_H
#define IQ4_F4_NATIVE_CALLS_02_H
#include <stdint.h>
#include <stddef.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Guarded real calls: exception means unknown native state, never retry. */
int iq4_f4_native_current_02(uintptr_t *);
int iq4_f4_native_lock_02(uintptr_t,int32_t,uintptr_t *);
int iq4_f4_native_unlock_02(uintptr_t,int32_t,int *);
int iq4_f4_native_size_02(uintptr_t,uint64_t *);
int iq4_f4_native_id_02(uintptr_t,uint32_t *);
int iq4_f4_native_construct_observer_02(void *,const char *,uintptr_t);
int iq4_f4_native_subscribe_02(void *,uintptr_t);
int iq4_f4_native_unsubscribe_02(void *,uintptr_t);
int iq4_f4_native_trylock_02(uintptr_t,int *);
int iq4_f4_native_mutex_unlock_02(uintptr_t,int *);
int iq4_f4_native_event_construct_02(void *,const char *);
int iq4_f4_native_event_notify_02(void *);
uint64_t iq4_f4_native_clock_02(void);
uint64_t iq4_f4_native_tid_02(void);
#ifdef __cplusplus
}
#endif
#endif
