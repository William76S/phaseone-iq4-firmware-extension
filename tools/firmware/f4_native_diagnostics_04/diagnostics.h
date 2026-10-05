#ifndef IQ4_F4_DIAGNOSTICS_04_H
#define IQ4_F4_DIAGNOSTICS_04_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Own scalar publication. No address, pixel, file content or native ABI.
 * error/detail are the first rejected/unknown step, not an errno or proof.
 * Every producer stores and reader loads these words atomically. */
typedef struct {uint32_t stage,error,detail;} Iq4F4DiagUnit04;
typedef struct {Iq4F4DiagUnit04 entry,source,session;} Iq4F4Diag04;
int iq4_f4_source_diagnostics_04(void*,Iq4F4DiagUnit04*);
int iq4_f4_session_diagnostics_04(void*,Iq4F4DiagUnit04*);
int iq4_f4_entry_diagnostics_04(Iq4F4Diag04*);
#ifdef __cplusplus
}
#endif
#endif
