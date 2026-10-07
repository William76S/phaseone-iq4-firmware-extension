#ifndef IQ4_STOCK_JPEG_GALLERY_55_H
#define IQ4_STOCK_JPEG_GALLERY_55_H
#include <stdint.h>
#include <stddef.h>
#ifdef __cplusplus
extern "C" {
#endif
/* A true independent JPEG catalog and native LCD consumer binding.  No RAW
 * presence bits are forged.  Zero means JPEG-only retirement is unavailable. */
int iq4_stock_jpeg_only_gallery_bound_55(void);
/* Invoke once after backend/card clients are genuinely bound.  Cold card
 * notifications may precede that constructor and therefore cannot bind it. */
int iq4_stock_jpeg_gallery_bind_55(uintptr_t catalog);
/* Caller owns the native photo/job lease, has published and fsynced all JPEG
 * outputs, and holds no catalog mutex.  This acquires catalog+1c0 itself.
 * 1 = exact JPEG source prepared; 0 = finite refusal; -1 = unknown/hold.
 * Prepare must precede deleting any corresponding original RAW inode.
 * Commit follows native RAW-presence removal only when both RAW bits are zero;
 * it preserves the original node/index and changes the record to its real JPG.
 * card is the primary true JPEG target (10 SD, 11 XQD). */
int iq4_stock_jpeg_gallery_prepare_retire_55(uintptr_t catalog,uintptr_t node,
 uint32_t index,uint32_t card);
int iq4_stock_jpeg_gallery_commit_retire_55(uintptr_t catalog,uintptr_t node,
 uint32_t index,uint32_t card);
/* Native common card-event refresh wrapper; original refresh executes once. */
uintptr_t iq4_stock_jpeg_gallery_card_refresh_55(uintptr_t catalog);
int iq4_stock_jpeg_gallery_metadata_55(uintptr_t catalog,uintptr_t node,
 uint32_t load_thumbnail);
int iq4_stock_jpeg_gallery_is_photo_55(uintptr_t catalog,uintptr_t node);
uintptr_t iq4_stock_jpeg_gallery_preview_enqueue_55(uintptr_t queue,
 uintptr_t request);
uintptr_t iq4_stock_jpeg_gallery_final_enqueue_55(uintptr_t queue,
 uintptr_t request);
#ifdef __cplusplus
}
#endif
#endif
