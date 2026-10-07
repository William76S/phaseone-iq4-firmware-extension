#ifndef IQ4_HALF_ENTRY_TRACE_58
#define IQ4_HALF_ENTRY_TRACE_58
#include <stdint.h>
/* Finite reasons only: no paths, pixel data or device identifiers. Values do
 * not overlap the legacy HalfState values used by old mismatch receipts. */
enum Iq4HalfEntryReason58 {
 IQ4_HALF_ENTRY_NOT_REACHED58=0x5800,
 IQ4_HALF_ENTRY_ABI58,
 IQ4_HALF_ENTRY_GEOMETRY58,
 IQ4_HALF_ENTRY_ROTATION58,
 IQ4_HALF_ENTRY_CANCEL58,
 IQ4_HALF_ENTRY_PINS58,
 IQ4_HALF_ENTRY_BUSY58,
 IQ4_HALF_ENTRY_UID58,
 IQ4_HALF_ENTRY_CATALOG58,
 IQ4_HALF_ENTRY_BASENAME58,
 IQ4_HALF_ENTRY_THREAD58,
 IQ4_HALF_ENTRY_UNCLAIMED58
};
#ifdef __cplusplus
extern "C" {
#endif
int iq4_stock_half_entry_trace_58(uintptr_t worker,uintptr_t node,int32_t uid,uint32_t reason);
#ifdef __cplusplus
}
#endif
static inline const char *iq4_half_entry_text_58(uint32_t reason){
 switch(reason){
 case IQ4_HALF_ENTRY_ABI58:return "50% native ABI mismatch";
 case IQ4_HALF_ENTRY_GEOMETRY58:return "50% RAW size mismatch";
 case IQ4_HALF_ENTRY_ROTATION58:return "50% rotation unsupported";
 case IQ4_HALF_ENTRY_CANCEL58:return "50% source cancelled";
 case IQ4_HALF_ENTRY_PINS58:return "50% native code mismatch";
 case IQ4_HALF_ENTRY_BUSY58:return "50% processor busy";
 case IQ4_HALF_ENTRY_UID58:return "50% source UID mismatch";
 case IQ4_HALF_ENTRY_CATALOG58:return "50% catalog source changed";
 case IQ4_HALF_ENTRY_BASENAME58:return "50% source name changed";
 case IQ4_HALF_ENTRY_THREAD58:return "50% thread unavailable";
 case IQ4_HALF_ENTRY_UNCLAIMED58:return "50% source not claimed";
 default:return "50% source not reached";
 }
}
#endif
