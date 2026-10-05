#ifndef IQ4_F3_SAVED_RAW_CAPTURE_03_H
#define IQ4_F3_SAVED_RAW_CAPTURE_03_H
#include "../f3_saved_raw_capture_01/capture.h"
#include "../f3_capture_menu_06/policy.h"
#ifdef __cplusplus
extern "C" {
#endif
struct F3CaptureOps03 {
 struct F3CaptureOps01 common;
 struct F3Card05*(*acquire_card)(void*,uint32_t actual_card_id);
};
int f3_capture_configure_03(const struct F3CaptureOps03*);
unsigned f3_capture_backend_capabilities_03(void);
/* These slots are project receipts, not movable vendor storage. Borrow proof
 * is supplied through executor03/saved_capture_contract.h. */
uint32_t f3_capture_active_card_03(void);
#ifdef __cplusplus
}
#include "../f3_source_dependencies_01/dependencies.hpp"
extern "C" int f3_capture_dependencies_03(const F3CapturedRaw01*,
 iq4::source_dependencies_01::Snapshot*);
#endif
#endif
