#ifndef IQ4_RATIO_MASK_QUICK_BUTTON_H
#define IQ4_RATIO_MASK_QUICK_BUTTON_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Exact native UI-thread constructor/destructor boundaries only. */
void iq4_ratio_quick_append_on_ui_01(void *right_stack, void *frame_average, void *live_view);
void iq4_ratio_quick_cleanup_on_ui_01(void *live_view);
#ifdef __cplusplus
}
#endif
#endif
