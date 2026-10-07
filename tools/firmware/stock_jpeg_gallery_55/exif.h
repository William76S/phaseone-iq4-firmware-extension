#ifndef IQ4_STOCK_JPEG_ORIENTATION_55_H
#define IQ4_STOCK_JPEG_ORIENTATION_55_H
#include <stdint.h>
#include <stddef.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Parse only the primary TIFF IFD Orientation in JPEG APP1 Exif segments.
 * Returns its actual 1..8 value; no Orientation/Exif returns 1.
 * Malformed/conflicting Exif, invalid JPEG marker bounds or input return 0.
 * No file access, allocation, native state or RAW metadata. */
uint32_t iq4_stock_jpeg_orientation_55(const uint8_t*,size_t);
#ifdef __cplusplus
}
#endif
#endif
