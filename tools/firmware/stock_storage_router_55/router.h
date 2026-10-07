#ifndef IQ4_STOCK_STORAGE_ROUTER_55_H
#define IQ4_STOCK_STORAGE_ROUTER_55_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
/* XQD Storage and SD Primary/SD-only share one output-format choice.
 * Getter succeeds only when the native backend and capture receipt bridge are
 * bound. Setting JPEG Only never deletes an existing photograph. */
enum Iq4StorageFormat55 {IQ4_STORAGE_JPEG_ONLY_55=1,IQ4_STORAGE_IIQ_ONLY_55=0,IQ4_STORAGE_IIQ_JPEG_55=2};
int iq4_stock_xqd_format_get_55(uint32_t *format);
int iq4_stock_xqd_format_set_55(uint32_t format);
/* Immutable backend identity plus one atomic format read; no card IO. */
int iq4_stock_storage_capture_format_55(uint32_t *format);
#ifdef __cplusplus
}
#endif
#endif
