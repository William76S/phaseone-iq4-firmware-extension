#ifndef IQ4_RATIO_MASK_SETTINGS_H
#define IQ4_RATIO_MASK_SETTINGS_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
struct Iq4RatioMaskSettings { uint32_t mode, opacity, remembered_mode; };
enum Iq4RatioSettingsResult {
    IQ4_RATIO_SETTINGS_OK = 0,
    IQ4_RATIO_SETTINGS_ABSENT = 1,
    IQ4_RATIO_SETTINGS_INVALID = 2,
    IQ4_RATIO_SETTINGS_IO = 3
};
/* Non-OK load supplies Off/Native, opacity 65, remembered XPan (1). The caller may retry IO later.
 * Saves change only this extension's validated files, never native settings. */
enum Iq4RatioSettingsResult iq4_ratio_settings_load_01(struct Iq4RatioMaskSettings *out);
enum Iq4RatioSettingsResult iq4_ratio_settings_save_01(const struct Iq4RatioMaskSettings *value);
#ifdef __cplusplus
}
#endif
#endif
