#ifndef IQ4_STOCK_JPEG_SETTINGS_H
#define IQ4_STOCK_JPEG_SETTINGS_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
struct Iq4StockJpegSettings { uint32_t mode, opacity, remembered_mode; };
enum Iq4StockJpegSettingsResult {
    IQ4_STOCK_JPEG_SETTINGS_OK = 0,
    IQ4_STOCK_JPEG_SETTINGS_ABSENT = 1,
    IQ4_STOCK_JPEG_SETTINGS_INVALID = 2,
    IQ4_STOCK_JPEG_SETTINGS_IO = 3
};
/* Non-OK load supplies SD destination (mode=0), with reserved fields 65 and 1. The caller may retry IO later.
 * Saves change only this extension's validated files, never native settings. */
enum Iq4StockJpegSettingsResult iq4_stock_jpeg_settings_load_01(struct Iq4StockJpegSettings *out);
enum Iq4StockJpegSettingsResult iq4_stock_jpeg_settings_save_01(const struct Iq4StockJpegSettings *value);
#ifdef __cplusplus
}
#endif
#endif
