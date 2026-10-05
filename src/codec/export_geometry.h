#ifndef IQ4_EXPORT_GEOMETRY_H
#define IQ4_EXPORT_GEOMETRY_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
enum Iq4ExportSize {IQ4_EXPORT_FULL,IQ4_EXPORT_75,IQ4_EXPORT_50,
 IQ4_EXPORT_25,IQ4_EXPORT_LONG3840,IQ4_EXPORT_LONG7680};
enum Iq4ExportGeometryStatus {IQ4_EXPORT_GEOMETRY_OK,IQ4_EXPORT_GEOMETRY_ARGUMENT,
 IQ4_EXPORT_GEOMETRY_UPSCALE,IQ4_EXPORT_GEOMETRY_LIMIT};
struct Iq4ExportGeometry {
 uint32_t source_width,source_height,unrotated_width,unrotated_height;
 uint32_t output_width,output_height,rotation,size_mode;
};
/* Complete valid RAW image dimensions, not thumbnail, total Bayer incl borders,
 * or LV dimensions. Pixel provenance is proved separately by the reader.
 * nearest half up; 3840/7680 are long edge, no upscaling. */
enum Iq4ExportGeometryStatus iq4_export_geometry(uint32_t,uint32_t,uint32_t,
 uint32_t,struct Iq4ExportGeometry*);
#ifdef __cplusplus
}
#endif
#endif
