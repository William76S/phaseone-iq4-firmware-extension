#ifndef IQ4_STOCK_JPEG_XQD_01_H
#define IQ4_STOCK_JPEG_XQD_01_H
#include <stdint.h>
#include <stddef.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Public menu entry points. Mode and Size retain the original native enums.
 * This revision never disables a RAW destination or removes a RAW file. */
int iq4_stock_jpeg_bound_01(void);
uint32_t iq4_stock_jpeg_destination_get_01(void); /* 10 SD / 11 XQD */
int iq4_stock_jpeg_destination_set_01(uint32_t card);
int iq4_stock_jpeg_mode_get_01(uint32_t *mode);   /* Off 0/New 1/All 2 */
int iq4_stock_jpeg_mode_set_01(uint32_t mode);
int iq4_stock_jpeg_size_get_01(uint32_t *size);   /* Thumbnail 0/stock 4K 1 */
int iq4_stock_jpeg_size_set_01(uint32_t size);
void iq4_stock_jpeg_ctor_01(uintptr_t task,uintptr_t sd_group,uintptr_t ifm,
    uintptr_t sd_write,uintptr_t xqd_write,uintptr_t sd_fs,uintptr_t main_sp);
int iq4_stock_jpeg_thumbnail_01(uintptr_t task,int index);
int iq4_stock_jpeg_4k_01(uintptr_t task,int index);
uint32_t iq4_stock_jpeg_presence_01(uintptr_t original_event);
uint64_t iq4_stock_jpeg_free_space_01(uintptr_t original_event);
int iq4_stock_jpeg_encode_write_01(uintptr_t task,const char *base,
    const void *rgb,uint32_t width,uint32_t height);
/* 1 is complete fsync/close/atomic-publication; 0 is a finite failure;
 * -1 is unknown cleanup/durability and stops later extension jobs. */
int iq4_stock_jpeg_publish_01(const char *root,const char *relative,
    const void *jpeg,uint32_t bytes,int (*guard)(void));
#ifdef __cplusplus
}
#endif
#endif
