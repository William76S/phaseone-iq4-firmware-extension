#ifndef IQ4_JPEG_PAIR_DELETE_61_H
#define IQ4_JPEG_PAIR_DELETE_61_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Called only by the two native human DeleteFile RAW File.delete sites.
 * It does not participate in JPEG-only automatic RAW retirement. */
int iq4_jpeg_pair_raw_delete_61(uintptr_t raw_file, uintptr_t native_parent_sp,
                               uint32_t card);
int iq4_jpeg_only_delete_61(uintptr_t native_parent_sp);
#ifdef __cplusplus
}
#endif
#endif
