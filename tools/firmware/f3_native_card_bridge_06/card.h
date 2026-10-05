#ifndef IQ4_F3_NATIVE_CARD_BRIDGE_06_H
#define IQ4_F3_NATIVE_CARD_BRIDGE_06_H
#include "../f3_native_card_bridge_05/card.h"
#ifdef __cplusplus
extern "C" {
#endif
/* UI async acquisition: one original request, then read-only readiness polls.
 * No wait/sleep on UI, no fabricated current mode. Normal cancel/release must
 * execute on the same actual original UI-thread object as the initial request. */
#define F3_CARD_PENDING_06 3
struct F3TryCalls06 {
 void*context;
 uintptr_t(*current_native_thread)(void*);
 enum F3CardOutcome05(*request)(void*,uintptr_t,uint32_t,uint32_t*);
};
int f3_card_request_06(struct F3Card05*,const struct F3CardRead05*,
 const struct F3LeaseCalls05*,const struct F3CardIo05*,const struct F3TryCalls06*,
 uint32_t raw_id,uint32_t jpeg_id);
int f3_card_poll_06(struct F3Card05*);
enum F3CardOutcome05 f3_card_cancel_pending_06(struct F3Card05*);
void f3_card_native_try_calls_06(struct F3TryCalls06*);
#ifdef __cplusplus
}
#endif
#endif
