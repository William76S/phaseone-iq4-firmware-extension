#ifndef IQ4_STORAGE55_SETTINGS_H
#define IQ4_STORAGE55_SETTINGS_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
struct Iq4Storage55Settings { uint32_t mode, opacity, remembered_mode; };
enum Iq4Storage55SettingsResult {
    IQ4_STORAGE55_SETTINGS_OK = 0,
    IQ4_STORAGE55_SETTINGS_ABSENT = 1,
    IQ4_STORAGE55_SETTINGS_INVALID = 2,
    IQ4_STORAGE55_SETTINGS_IO = 3
};
/* Non-OK load supplies IIQ only (mode=0), with reserved fields 65 and 1. The caller may retry IO later.
 * Saves change only this extension's validated files, never native settings. */
enum Iq4Storage55SettingsResult iq4_storage55_settings_load_01(struct Iq4Storage55Settings *out);
enum Iq4Storage55SettingsResult iq4_storage55_settings_save_01(const struct Iq4Storage55Settings *value);
#ifdef __cplusplus
}
#endif
#endif
