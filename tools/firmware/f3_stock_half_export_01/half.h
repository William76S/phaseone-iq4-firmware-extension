#ifndef IQ4_STOCK_HALF_SIZE_02_H
#define IQ4_STOCK_HALF_SIZE_02_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
/* 0=stock4K, 1=50% of complete native RAW width and height. These are
 * extension choices; neither function sends enum2 to native JPEG Size.
 * Getter returns1 only for a bound, readable setting. Setter returns1 only
 * after an idle native worker, native Size=4K and durable config save succeed. */
int iq4_stock_jpeg_extended_size_get_02(uint32_t *choice);
int iq4_stock_jpeg_extended_size_set_02(uint32_t choice);
#ifdef __cplusplus
}
#endif
#endif
