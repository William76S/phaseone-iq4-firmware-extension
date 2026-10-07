#ifndef IQ4_JPEG_4K_SIZE_61_H
#define IQ4_JPEG_4K_SIZE_61_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Only choice 0 (stock 4K) is accepted. Native JPEG Size is enum 1.
 * Legacy exported names preserve the frozen Storage Setup wrapper ABI.
 * Retired Half settings are never loaded or written. */
int iq4_stock_jpeg_extended_size_get_02(uint32_t *choice);
int iq4_stock_jpeg_extended_size_set_02(uint32_t choice);
#ifdef __cplusplus
}
#endif
#endif
