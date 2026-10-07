#ifndef IQ4_JPEG_GALLERY_GEOMETRY_55_H
#define IQ4_JPEG_GALLERY_GEOMETRY_55_H
#include <stdint.h>
#include <stddef.h>
#ifdef __cplusplus
extern "C" {
#endif
struct Iq4JpegGalleryRoi55 {uint32_t x,y,width,height;};
int iq4_jpeg_gallery_inverse_roi_55(uint32_t source_width,uint32_t source_height,
 uint32_t clockwise_degrees,const struct Iq4JpegGalleryRoi55*,struct Iq4JpegGalleryRoi55*);
/* Distinct, bounded reduced-LCD destination only; guard each row. */
int iq4_jpeg_gallery_rotate_rgb_55(const uint8_t*,size_t source_capacity,uint32_t stride,
 uint32_t width,uint32_t height,uint32_t angle,uint8_t*,size_t destination_capacity,
 int(*guard)(void*),void*);
#ifdef __cplusplus
}
#endif
#endif
