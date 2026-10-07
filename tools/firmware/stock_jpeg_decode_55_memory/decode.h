#ifndef IQ4_STOCK_JPEG_DECODE_55_H
#define IQ4_STOCK_JPEG_DECODE_55_H
#include <stdint.h>
#include <stddef.h>
#ifdef __cplusplus
extern "C" {
#endif
struct Iq4JpegDecodeResult55 {uint32_t source_width,source_height,width,height,rows,source_orientation;};
enum { IQ4_JPEG_DECODE_OK55=1, IQ4_JPEG_DECODE_BAD55=0,
       IQ4_JPEG_DECODE_CANCEL55=-1 };
/* Complete entropy decode into caller-owned RGB24. No RAW reader, allocation
 * of a full RGB image, card routing, native object, or ownership transfer.
 * Native callers retain the source and destination leases for the whole call.
 * max_width/height are fit bounds; IDCT reduction is chosen from 1/2/4/8,
 * then a streamed nearest-pixel fit supplies the LCD preview. This is a
 * display cache, never the capture JPEG exporter. Partial output is invalid.
 * guard is called before start and each row; non-1 stops with no valid result.
 */
int iq4_stock_jpeg_decode_rgb_55(const uint8_t *jpeg,size_t bytes,
 uint8_t *rgb,size_t capacity,uint32_t stride,uint32_t max_width,
 uint32_t max_height,int (*guard)(void*),void *context,
 struct Iq4JpegDecodeResult55 *result);
int iq4_stock_jpeg_decode_crop_rgb_55(const uint8_t*,size_t,
 uint32_t,uint32_t,uint32_t,uint32_t,uint8_t*,size_t,uint32_t,uint32_t,
 uint32_t,int(*)(void*),void*,struct Iq4JpegDecodeResult55*);
int iq4_stock_jpeg_probe_bytes_55(const uint8_t*,size_t,
 struct Iq4JpegDecodeResult55*);
/* Native resolver + identity/card guard remain the caller's responsibility.
 * This adapter accepts only resolved camera-card DCIM JPEG paths, holds a
 * read-only non-symlink file, checks its identity/size before and after reading,
 * and admits a result only after a successful close. -2 means close unknown;
 * the file descriptor stays in the adapter's bounded quarantine, never reused.
 */
int iq4_stock_jpeg_decode_file_55(const char*,uint8_t*,size_t,uint32_t,
 uint32_t,uint32_t,int(*)(void*),void*,struct Iq4JpegDecodeResult55*);
int iq4_stock_jpeg_probe_file_55(const char*,int(*)(void*),void*,
 struct Iq4JpegDecodeResult55*);
int iq4_stock_jpeg_decode_crop_file_55(const char*,uint32_t,uint32_t,uint32_t,
 uint32_t,uint8_t*,size_t,uint32_t,uint32_t,uint32_t,int(*)(void*),void*,
 struct Iq4JpegDecodeResult55*);
int iq4_stock_jpeg_decoder_bound_55(void);
#ifdef __cplusplus
}
#endif
#endif
