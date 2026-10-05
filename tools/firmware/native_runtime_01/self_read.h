#ifndef IQ4_NATIVE_SELF_READ_01_H
#define IQ4_NATIVE_SELF_READ_01_H
#include <stddef.h>
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Read our own process only, never a SDK/device read. One bounded kernel
 * copy. Exact original syscall PLT is an ELF linker alias, not dlsym. */
int iq4_native_self_read_01(void *, uintptr_t, void *, size_t);
uint64_t iq4_native_current_tid_01(void);
#ifdef __cplusplus
}
#endif
#endif
