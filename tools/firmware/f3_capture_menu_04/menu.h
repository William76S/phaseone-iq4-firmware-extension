#ifndef IQ4_F3_CAPTURE_MENU_04_H
#define IQ4_F3_CAPTURE_MENU_04_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Hook4f0d34 forwards original Append once, then calls this with actual root
 * and original return PC4f0d38. Menu installation requires the REAL
 * coordinator06 factory already installed, never a positive template flag. */
void iq4_f3_after_file_settings_append_04(void*root,uintptr_t original_return_pc);
#ifdef __cplusplus
}
#endif
#endif
