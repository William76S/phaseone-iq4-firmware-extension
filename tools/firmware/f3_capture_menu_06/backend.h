#ifndef IQ4_F3_CAPTURE_BACKEND_06_H
#define IQ4_F3_CAPTURE_BACKEND_06_H
#ifdef __cplusplus
extern "C" {
#endif
/* Implemented by real producer03. bit0 SD, bit1 XQD, after successful actual
 * configure + exact code-pin validation. It is not card presence/readiness. */
unsigned f3_capture_backend_capabilities_03(void);
#ifdef __cplusplus
}
#endif
#endif
