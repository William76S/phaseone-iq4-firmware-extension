#ifndef IQ4_F4_NATIVE_ENTRY_02_H
#define IQ4_F4_NATIVE_ENTRY_02_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Root's single LiveView Settings BL wrapper calls this before original
 * SetMenu once. Explicit destination:10 SD/11 XQD. Actual card availability
 * is proved by Card06 later, never by this integer. Native page may be built
 * before LV; source binds lazily on the real later UI Start callback. */
int iq4_f4_native_menu_entry_02(void*selector,void*root,uintptr_t actual_return_pc,
 uint32_t recording_destination_fs_id);
#ifdef __cplusplus
}
#endif
#endif
