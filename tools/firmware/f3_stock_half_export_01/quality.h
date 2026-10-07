#ifndef IQ4_STOCK_JPEG_QUALITY_02_H
#define IQ4_STOCK_JPEG_QUALITY_02_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
/* This revision encodes both stock4K and nativeHalf with quality100.
 * Returns1 only after its native owning worker/core has bound; otherwise0. */
int iq4_stock_jpeg_quality_get_02(uint32_t *quality);
#ifdef __cplusplus
}
#endif
#endif
