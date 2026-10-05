#ifndef IQ4_F3_NATIVE_EXECUTOR_01_H
#define IQ4_F3_NATIVE_EXECUTOR_01_H
#include <stdint.h>
#include "../native_activity_01/activity.h"
struct F3CapturedRaw01;
#ifdef __cplusplus
extern "C" {
#endif
/* Own task queue, capacity one. This does not borrow original JPEG Request
 * event, Reader, decode arena, file, source lease or native card request. */
enum F3ExecutorState01 {F3_EXEC_NOT_BOUND01=0,F3_EXEC_IDLE01=1,
 F3_EXEC_QUEUED01=2,F3_EXEC_RUNNING01=3,F3_EXEC_FINISHED01=4,F3_EXEC_HOLD01=5,
 F3_EXEC_RESERVED01=6};
enum F3ExecutorResult01 {F3_EXEC_OK01=0,F3_EXEC_BUSY01=1,
 F3_EXEC_REJECTED01=2,F3_EXEC_UNKNOWN01=3};
struct F3ExecutorOwner01 {uintptr_t queue,outer_ifm,ifm;uint64_t native_tid;};
struct F3ExecutorSelection01 {struct F3ExecutorOwner01 owner;int32_t index;};
/* run must be the linked project coordinator, never a vendor ABI cast. It is
 * called once on the actual original ImageFileBackgroundThread. Return 1 only
 * after the serial native render task has ended its own source/file/card fence;
 * return 0 for a known stopped failure, -1 for unknown retained ownership.
 * The coordinator still owns card/source and immutable ticket lifetime. The
 * executor releases its shared JPEG activity ONLY after a known ended run and
 * a normally returned completion notification. */
typedef int(*F3ExecutorRun01)(void*immutable_ticket,const struct F3ExecutorOwner01*);
struct F3ExecutorTask01 {void*ticket;F3ExecutorRun01 run;
 uint64_t sequence;uintptr_t ui_completion_event;};
struct F3ExecutorReservation01 {uint64_t sequence;struct Iq4ActivityLease01 activity;};
struct F3ExecutorView01 {uint32_t state,result;uint64_t sequence;
 struct F3ExecutorOwner01 owner;};
/* Actual native UI only; original selected-image integer getter acquires the
 * factory data-object mutex. Neither this nor a positive index pins the RAW. */
int iq4_f3_executor_selection_on_ui_01(struct F3ExecutorSelection01*);
/* Reserve prior to the coordinator's UI prepare. Pass this exact activity to
 * prepare; it must not acquire JPEG activity a second time. */
int iq4_f3_executor_begin_on_ui_01(struct F3ExecutorReservation01*);
/* Known no-owner prepare refusal only; unknown prepare must hold instead. */
int iq4_f3_executor_cancel_on_ui_01(uint64_t sequence);
/* Immutable caller-owned ticket remains alive through completion/Hold. No
 * second submission until finish_on_ui, which requires actual caller cleanup. */
int iq4_f3_executor_submit_on_ui_01(const struct F3ExecutorTask01*);
int iq4_f3_executor_view_on_ui_01(struct F3ExecutorView01*);
/* Called only after the real coordinator's source/file/card/activity cleanup.
 * It merely retires this task mailbox; it does not establish those proofs. */
int iq4_f3_executor_finish_on_ui_01(uint64_t sequence);
/* Called synchronously ONLY from the original SD Store's saved callback.
 * Receipt.storage/closed-file flags/actual original pthread_self and borrowed
 * activity are checked. Worker never dereferences receipt.manager/node. The
 * coordinator has already copied actual dependencies/file identity to ticket.
 * This uses the SAME native IFM worker; no second pool/TID and no native queue
 * notifications are consumed on SD. Original capture keeps card/file/activity
 * until this normally ACKs. Fixed maximum600s; unknown retains every owner and
 * never cancels/retries. A known ended error ACK is still OK; coordinator's own
 * output status distinguishes JPEG failure from successful output. */
int iq4_f3_executor_invoke_saved_on_native_01(const struct F3ExecutorTask01*,
 struct F3CapturedRaw01*actual_saved_receipt);
void iq4_f3_executor_hold_01(void);
/* Exact old BL49d9d0 ->71384c, return49d9d4. Stock return/throw are unchanged
 * for every unowned listener. Assembly tail wrapper preserves original x0/w1.
 * The original native Wait may throw and must unwind to its original caller. */
uintptr_t iq4_f3_ifm_wait_entry_01(void*actual_queue,uint32_t original_timeout);
#ifdef IQ4_F3_EXECUTOR_SYNTHETIC_HOST
void iq4_f3_executor_fixture_reset_01(void);
uintptr_t iq4_f3_executor_fixture_listener_01(void);
#endif
#ifdef __cplusplus
}
#endif
#endif
