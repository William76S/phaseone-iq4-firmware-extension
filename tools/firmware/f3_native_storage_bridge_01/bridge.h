#pragma once
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Only this UI transaction couples the existing atomic F3 selection to native
 * optional full-RAW storage. It never substitutes card-presence/status checks. */
int iq4_f3_native_mode_set_on_ui_01(uint32_t card_id,uint32_t mode);
int iq4_f3_native_storage_bound_01(void);
uint32_t iq4_f3_native_storage_override_mask_01(void);
/* Call once from initializer05 after exact code/seal checks and before native
 * threads/menu construction. Default pthread mutex is a process-lifetime owner. */
int iq4_f3_native_storage_mutex_initialize_01(void);
/* Internal paired body hooks, lower32=effective mode / upper32=lock token. */
uint64_t iq4_f3_storage_enter_01(uintptr_t,uint32_t,uintptr_t,uint32_t silent);
void iq4_f3_storage_leave_01(uint32_t token);
#ifdef __cplusplus
}
#endif
