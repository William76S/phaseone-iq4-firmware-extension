#ifndef IQ4_HALF_RGB24_TERMINAL_60_H
#define IQ4_HALF_RGB24_TERMINAL_60_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Exact 6.03.21 native half-pipeline terminal-constructor call at 0x917f58.
 * The argument is the CImgOp subobject (+16 in its native shared owner),
 * not the shared control block. Preserve the original constructor's x0. */
void *iq4_half_rgb24_construct_60(void *subobject);
int iq4_half_rgb24_pins_60(void);

/* Bridge-owned admission and cross-worker failure recording. Admission
 * checks active Half settings, owner thread, return_pc == 0x917f5c and
 * exactly one terminal construction. Rejection must be an atomic write;
 * the native tile dispatcher can call the converter on pool threads. */
int iq4_half_rgb24_ctor_allowed_60(void *subobject, uintptr_t return_pc);
void iq4_half_rgb24_reject_60(unsigned reason);
enum Iq4HalfRgb24Reject60 {
 IQ4_HALF_RGB24_OBJECT_60=1,
 IQ4_HALF_RGB24_FORMAT_60=2,
 IQ4_HALF_RGB24_GEOMETRY_60=3,
 IQ4_HALF_RGB24_STORAGE_60=4
};
#ifdef __cplusplus
}
#endif
#endif
