#ifndef IQ4_NATIVE_COPY_RTTI_01_H
#define IQ4_NATIVE_COPY_RTTI_01_H
#include <stdint.h>
#include <stddef.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Pure bounded own-memory reader. No object construction, virtual calls,
 * files, threads, dlsym or loader API. Exact library graph comes from collect.py.
 * Current final ELF's dynsym/versions/COPY metadata is separately Root-sealed. */
int iq4_native_copy_rtti_current_01(void*context,
 int(*read)(void*,uintptr_t,void*,size_t));
#ifdef __cplusplus
}
#endif
#endif
