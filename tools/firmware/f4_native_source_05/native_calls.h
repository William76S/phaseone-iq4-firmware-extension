#ifndef IQ4_F4_NATIVE_CALLS_05_H
#define IQ4_F4_NATIVE_CALLS_05_H
#include "../f4_native_source_02/native_calls.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Original 71242c(void *mutex), normal return means acquired; throw is unknown. */
int iq4_f4_native_queue_lock_05(uintptr_t);
#ifdef __cplusplus
}
#endif
#endif
