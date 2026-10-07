#ifndef IQ4_HALF_REQUEST_OWNER_59_H
#define IQ4_HALF_REQUEST_OWNER_59_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
/* The original worker frame supplies request+60/+48/+50. This admission
 * uses only the published immutable native binding and never reads the ARMED
 * transaction. It excludes non-JPEG requests before diagnostic or acquire. */
int iq4_stock_half_request_owner_59(uintptr_t worker, uintptr_t cancel,
                                   uintptr_t output_main, uintptr_t output_rgb);
#ifdef __cplusplus
}
#endif
#endif
