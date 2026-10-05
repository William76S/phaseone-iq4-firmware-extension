#ifndef IQ4_STREAM_EXPORT_RGB32_01_H
#define IQ4_STREAM_EXPORT_RGB32_01_H
#include "stream_rgb32.h"
#include "export_pixels.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Native full R0 rendered plane, output size and orientation from an immutable
 * capture/manual-export request. Full RAW/profiles/completion remain external. */
typedef struct Iq4Rgb32Export {const uint8_t*pixels;size_t bytes,stride;
 uint32_t width,height,rotation,size_mode;int quality;} Iq4Rgb32Export;
Iq4StreamStatus iq4_jpeg_stream_export_rgb32_01(const Iq4JpegApi*,
 const Iq4Rgb32Export*,const Iq4JpegSink*,Iq4StreamResult*);
#ifdef __cplusplus
}
#endif
#endif
