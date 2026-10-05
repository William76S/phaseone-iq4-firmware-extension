#ifndef IQ4_EXPORT_PIXELS_01_H
#define IQ4_EXPORT_PIXELS_01_H
#include "export_geometry.h"
#include <stddef.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Immutable borrowed full rendered X,R,G,B. No ownership/provenance is inferred
 * from its dimensions. Area downsampling averages the rendered code values. */
struct Iq4ExportPixels {const unsigned char*pixels;size_t bytes,stride;
 struct Iq4ExportGeometry geometry;uint32_t source_width,source_height;};
int iq4_export_pixels_init(struct Iq4ExportPixels*,const unsigned char*,size_t,
 size_t stride,uint32_t width,uint32_t height,uint32_t rotation,uint32_t size_index);
/* Exact single RGB24 output row; no upsampling, LUT, source writes or whole
 * RGB24 allocation. The caller retains the native full-pixel owner. */
int iq4_export_pixels_row(const struct Iq4ExportPixels*,uint32_t row,unsigned char*,size_t);
#ifdef __cplusplus
}
#endif
#endif
