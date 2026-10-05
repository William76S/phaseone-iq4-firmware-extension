#ifndef IQ4_F3_PUBLIC_RAW_06_H
#define IQ4_F3_PUBLIC_RAW_06_H
#include "../f3_saved_raw_capture_01/capture.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Internal second stage. Caller must have actual JPEG publication and normal
 * renderer/pool/input cleanup; source/card leases and captured raw_fd stay held.
 * This function establishes file identity, not a render cleanup receipt. */
enum F3PublicOutcome06 {F3_PUBLIC_REMOVED06=1,F3_PUBLIC_PRESERVED06=0,F3_PUBLIC_HOLD06=-1};
struct F3PublicRaw06 {int quarantine_fd;uint32_t state,hold,restore_attempted,restore_succeeded;
 char quarantine_leaf[64];};
/* Private namespace is serialized by the one activity owner. Never substitutes
 * stat+unlink for inode-conditional deletion in a user-controlled namespace. */
int f3_public_discard_06(struct F3PublicRaw06*,const struct F3Posix*,
 const struct F3CardGuard*,uint64_t epoch,int held_parent,uint64_t generation,
 const struct F3CapturedRaw01*,uint32_t actual_jpeg_published,uint8_t*,size_t);
#ifdef __cplusplus
}
#endif
#endif
