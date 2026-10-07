#ifndef IQ4_RATIO_MASK_MENU_H
#define IQ4_RATIO_MASK_MENU_H
#ifdef __cplusplus
extern "C" {
#endif
unsigned iq4_f1_mode_get_01(void);
unsigned iq4_f1_opacity_get_01(void);
int iq4_f1_mode_set_on_ui_01(unsigned);
int iq4_f1_opacity_set_on_ui_01(unsigned);
/* Called only by original UI-thread control callbacks. */
int iq4_f1_toggle_on_ui_01(void);
void *iq4_f1_quick_menu_root_on_ui_01(void);
#ifdef __cplusplus
}
#endif
#endif
