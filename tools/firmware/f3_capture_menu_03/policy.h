#ifndef IQ4_F3_CAPTURE_POLICY_01_H
#define IQ4_F3_CAPTURE_POLICY_01_H
#include <stdint.h>
#include "../f3_save_transaction_01/transaction.h"

/* Own ABI only. The native source owner/lease is supplied by a future binder;
 * nonzero tokens here do not establish an actual native ownership proof. */
enum F3Scale01 { F3_FULL01=0, F3_75_PERCENT01=1, F3_50_PERCENT01=2, F3_25_PERCENT01=3, F3_LONG384001=4, F3_LONG768001=5 };
enum F3PolicyStatus01 { F3_POLICY_EMPTY01=0, F3_POLICY_ACTIVE01=1,
                       F3_POLICY_FINISHED01=2, F3_POLICY_HOLD01=3 };
struct F3CapturePolicy01 {
    uint64_t boot_epoch, capture_id, source_token;
    uint32_t mode, scale_index, scale_percent;
    uint32_t jpeg_quality, automatic_jpeg;
    uint32_t source_width, source_height, output_width, output_height;
    uint32_t want_raw, want_jpeg, raw_backup_allowed;
};
struct F3PolicySlot01 {
    uint32_t status;
    struct F3CapturePolicy01 policy;
};
uint32_t iq4_f3_mode_get_01(void);
uint32_t iq4_f3_scale_get_01(void);
uint32_t iq4_f3_quality_get_03(void);
int iq4_f3_mode_set_on_ui_01(uint32_t);
int iq4_f3_scale_set_on_ui_01(uint32_t);
int iq4_f3_quality_set_on_ui_03(uint32_t);
/* Single serialized capture owner; once-only atomic-settings consumer.
 * Caller must initialize a new empty slot and establish its actual native
 * source lease before calling. This function does not dereference source. */
int iq4_f3_policy_begin_01(struct F3PolicySlot01*,uint64_t,uint64_t,uint64_t,uint32_t,uint32_t);
int iq4_f3_policy_read_01(const struct F3PolicySlot01*,uint64_t,uint64_t,uint64_t,struct F3CapturePolicy01*);
/* UNKNOWN preserves the policy identity and permanently forbids reuse of this slot.
 * Native lease retention/cleanup remains the external coordinator's responsibility.
 * DONE/FAIL are received only after the coordinator's actual source/card cleanup.
 * The policy module itself does not remove files or release native resources. */
int iq4_f3_policy_finish_01(struct F3PolicySlot01*,uint64_t,uint64_t,uint64_t,uint32_t);
#endif
