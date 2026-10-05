#ifndef IQ4_F3_CAPTURE_POLICY_06_H
#define IQ4_F3_CAPTURE_POLICY_06_H
#include "../f3_capture_menu_04/policy.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Own UI state only; actual native Store determines which card has a capture.
 * Every field is read coherently once at node acquisition; values do not create
 * card/source ownership, native storage flags, or a completed RAW receipt. */
struct F3SettingsSnapshot06 {uint32_t sd_mode,xqd_mode,size_mode,quality;};
int iq4_f3_settings_snapshot_06(struct F3SettingsSnapshot06*);
int iq4_f3_settings_for_card_06(const struct F3SettingsSnapshot06*,uint32_t actual_fs_id,struct F3SettingsSnapshot04*);
int iq4_f3_mode_set_for_card_on_ui_06(uint32_t actual_fs_id,uint32_t mode);
/* Compatibility _04/_01 selection functions remain SD-only. New producer03
 * must consume snapshot06 at the actual acquisition; never resnapshot per Store.
 * Only one policy.o may be linked: original policy04 is replaced, not retained. */
#ifdef __cplusplus
}
#endif
#endif
