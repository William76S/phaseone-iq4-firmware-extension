#ifndef IQ4_F3_SAVED_CAPTURE_CONTRACT_03_H
#define IQ4_F3_SAVED_CAPTURE_CONTRACT_03_H
#include "../f3_saved_raw_capture_01/capture.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Project-owned receipt proof, never a vendor object/ABI. Only producer03 may
 * approve its process-lifetime static slot and matching capture group lease.
 * selected_mask records actual native-selected/notified own-JPEG destinations
 * (SD bit1/XQD bit2), not completed callbacks or inferred card presence. */
struct F3CaptureBorrow03 {
 uint64_t capture_sequence;
 uint32_t card_id,selected_mask;
 uintptr_t group_owner;
 struct Iq4ActivityLease01 activity;
};
enum F3CaptureProof03 {F3_CAPTURE_PROOF_REJECTED03=0,
 F3_CAPTURE_PROOF_OK03=1,F3_CAPTURE_PROOF_HOLD03=2};
int f3_capture_saved_proof_03(const struct F3CapturedRaw01*,struct F3CaptureBorrow03*);
#ifdef __cplusplus
}
#endif
#endif
