#ifndef IQ4_F4_MENU_NATIVE_CALLS_H
#define IQ4_F4_MENU_NATIVE_CALLS_H
#include <stdint.h>
#include <stddef.h>
#ifdef __cplusplus
extern "C" {
#endif
int iq4_f4_menu_new_03(size_t,void**);
int iq4_f4_menu_ctor_03(uintptr_t,void*);
int iq4_f4_menu_append_03(void*,void*);
int iq4_f4_menu_close_03(void*);
int iq4_f4_menu_pop_03(void*,int*);
/* Unowned menu: native result and exceptions pass through unchanged. */
int iq4_f4_menu_pop_passthrough_03(void*);
#ifdef __cplusplus
}
#endif
#endif
