#ifndef IQ4_F3_NATIVE_EXECUTOR_03_H
#define IQ4_F3_NATIVE_EXECUTOR_03_H
#include "../f3_native_executor_01/executor.h"
#include "saved_capture_contract.h"
#ifdef __cplusplus
extern "C" {
#endif
struct F3ExecutorSavedReservation03 {
 struct F3ExecutorReservation01 mailbox;
 uintptr_t receipt,group_owner;
 uint64_t capture_sequence;
 uint32_t card_id;
};
/* Reserve the sole native IFM mailbox BEFORE placing the sole coordinator Job.
 * Before-enqueue timeout/refusal is known no-enqueue: return BUSY/REJECTED with
 * no Notify, no source transfer and no group activity release. The producer
 * still owns its checked RAW/card/file cleanup and normal original RAW ACK. */
int iq4_f3_executor_begin_saved_on_native_03(struct F3CapturedRaw01*,
 struct F3ExecutorSavedReservation03*);
/* Only this same actual saved-callback thread/receipt may cancel a RESERVED
 * mailbox with no task/Notify. It never releases the producer's group lease. */
int iq4_f3_executor_cancel_saved_on_native_03(struct F3CapturedRaw01*,
 const struct F3ExecutorSavedReservation03*);
/* Task ticket is process-lifetime owned; caller performs known prepare refusal
 * cleanup before cancel. Once Notify is attempted, unknown retains every owner.
 * A normally ended callback ACK clears only the mailbox; the producer ends its
 * own card/File and last group owner. Exactly one IFM render executes at a time. */
int iq4_f3_executor_invoke_reserved_saved_on_native_03(const struct F3ExecutorTask01*,
 struct F3CapturedRaw01*,const struct F3ExecutorSavedReservation03*);
#ifdef __cplusplus
}
#endif
#endif
