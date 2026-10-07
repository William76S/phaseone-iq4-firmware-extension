#ifndef IQ4_STOCK_HALF_JPEG_SINK_01_H
#define IQ4_STOCK_HALF_JPEG_SINK_01_H
#include "../../../src/codec/bounded_jpeg.h"
#ifdef __cplusplus
extern "C" {
#endif
typedef struct Iq4HalfArgb01 {
 const uint8_t *visible;
 size_t bytes, stride;
 uint32_t width, height, format;
} Iq4HalfArgb01;
typedef enum Iq4HalfJpegStatus01 {
 IQ4_HALF_JPEG_OK_01=0, IQ4_HALF_JPEG_ARGUMENT_01,
 IQ4_HALF_JPEG_UNBOUND_01, IQ4_HALF_JPEG_MEMORY_01,
 IQ4_HALF_JPEG_CANCELLED_01, IQ4_HALF_JPEG_CAPACITY_01,
 IQ4_HALF_JPEG_LIBRARY_01, IQ4_HALF_JPEG_SUSPENDED_01,
 IQ4_HALF_JPEG_HOLD_01
} Iq4HalfJpegStatus01;
typedef struct Iq4HalfJpegResult01 {
 Iq4HalfJpegStatus01 status;
 uint32_t rows, destroy_calls;
 uint64_t jpeg_bytes;
 int library_message;
} Iq4HalfJpegResult01;
/* The caller proves complete RAW -> terminal nativeHalf geometry and keeps
 * this ARGB8 CIB visible plane borrowed synchronously. No resizing is done.
 * Native input format5 is [A,R,G,B] and maps JCS_EXT_ARGB15, not RGB24.
 * output is the owning JPEG job's unpublished hard-capacity buffer.
 * guard:1=valid same borrowed job,0=finite cancellation,-1=unknown state.
 * JPEG longjmp remains within this C function. No image pointer is retained
 * or used after return. A failed destroy quarantines only the independent
 * JPEG allocator/error/destination context; it is never retried or resumed.
 * Any failure exposes jpeg_bytes=0. It cannot be published as stock4K.
 * This function never touches the filesystem, card tokens or RAW retention. */
Iq4HalfJpegStatus01 iq4_half_jpeg_encode_01(const Iq4JpegApi *api,
 const Iq4HalfArgb01 *plane,uint8_t *output,size_t capacity,int quality,
 int (*guard)(void *),void *context,Iq4HalfJpegResult01 *result);
uint64_t iq4_half_jpeg_quarantined_contexts_01(void);
#ifdef __cplusplus
}
#endif
#endif
