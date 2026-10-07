#ifndef IQ4_STOCK_JPEG_POLICY_01_H
#define IQ4_STOCK_JPEG_POLICY_01_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Called once after the existing JPEG task constructor and binding. */
int iq4_stock_jpeg_policy_bind_01(uintptr_t sd_group);
/* Only six original SD-composite JPEGMode virtual setter sites call this.
 * User Mode changes still call their original factory setter directly. */
uintptr_t iq4_stock_jpeg_policy_set_01(uintptr_t event, uint32_t value,
                                     uintptr_t factory_setter);
#ifdef __cplusplus
}
#endif
#endif
