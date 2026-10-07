#ifndef IQ4_STOCK_HALF_SETTINGS_H
#define IQ4_STOCK_HALF_SETTINGS_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
struct Iq4StockHalfSettings { uint32_t mode, opacity, remembered_mode; };
enum Iq4StockHalfSettingsResult {
    IQ4_STOCK_HALF_SETTINGS_OK = 0,
    IQ4_STOCK_HALF_SETTINGS_ABSENT = 1,
    IQ4_STOCK_HALF_SETTINGS_INVALID = 2,
    IQ4_STOCK_HALF_SETTINGS_IO = 3
};
/* Non-OK load supplies stock4K (mode=0), with reserved fields 65 and 1. The caller may retry IO later.
 * Saves change only this extension's validated files, never native settings. */
enum Iq4StockHalfSettingsResult iq4_stock_half_settings_load_01(struct Iq4StockHalfSettings *out);
enum Iq4StockHalfSettingsResult iq4_stock_half_settings_save_01(const struct Iq4StockHalfSettings *value);
#ifdef __cplusplus
}
#endif
#endif
