#ifndef IQ4_STREAM_RGB32_JPEG_H
#define IQ4_STREAM_RGB32_JPEG_H
#include "bounded_jpeg.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Borrowed native rendered X,R,G,B rows: +1/+2/+3 are copied to one RGB24
 * scanline. The caller retains the original render owner synchronously.
 * Geometry is not evidence of full-RAW provenance or actual render capacity. */
typedef struct Iq4Rgb32Input {
    const uint8_t *pixels;
    size_t bytes, stride;
    uint32_t width, height;
    int quality;
} Iq4Rgb32Input;
typedef struct Iq4JpegSink {
    void *context;
    size_t (*write)(void *,const uint8_t *,size_t);
    uint64_t byte_budget;
} Iq4JpegSink;
typedef enum Iq4StreamStatus {
    IQ4_STREAM_OK=0, IQ4_STREAM_ARGUMENT, IQ4_STREAM_UNBOUND,
    IQ4_STREAM_NO_MEMORY, IQ4_STREAM_BUDGET, IQ4_STREAM_SHORT_WRITE,
    IQ4_STREAM_LIBRARY_ERROR, IQ4_STREAM_SUSPENDED, IQ4_STREAM_CLEANUP_ERROR
} Iq4StreamStatus;
typedef struct Iq4StreamResult {
    Iq4StreamStatus status;
    uint64_t jpeg_bytes; /* zero on every failure, including partial sink writes */
    uint64_t accepted_prefix_bytes; /* diagnostic only: invalid file until success */
    uint32_t rows_encoded, destroy_calls;
    size_t rgb24_scanline_bytes, destination_bytes;
    int library_message_code;
} Iq4StreamResult;
/* Sink writes only to an unpublished private transaction. This function does
 * not open, close, sync, publish or remove files, or decide to discard RAW.
 * Final SOF/EOI/readback/close verification belongs to the save transaction.
 * Working memory allocated internally by libjpeg is not a hard bounded arena.
 */
Iq4StreamStatus iq4_jpeg_stream_rgb32(const Iq4JpegApi *,const Iq4Rgb32Input *,
                                    const Iq4JpegSink *,Iq4StreamResult *);
#ifdef __cplusplus
}
#endif
#endif
