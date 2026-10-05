#ifndef IQ4_F1_FIRMWARE_STATE_01_H
#define IQ4_F1_FIRMWARE_STATE_01_H
#include <stdint.h>
#include <stddef.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Requested UI mode only. No field attests Surface lifetime or clean pixels. */
typedef struct Iq4F1FirmwareState01 {
 uint32_t schema,bytes,requested_mode,startup,ui_phase,last_failure,ctor_count,sequence;
 uintptr_t queue,manager,lv;
 uint64_t request_generation;
} Iq4F1FirmwareState01;
extern Iq4F1FirmwareState01 iq4_f1_state_01;
unsigned iq4_f1_mode_get_01(void);
int iq4_f1_mode_set_on_ui_01(unsigned mode);
const Iq4F1FirmwareState01* iq4_f1_state_readonly_01(void);
void iq4_f1_firmware_initialize_01(void);
void iq4_f1_publish_ctor_on_return_01(uintptr_t lv,uintptr_t manager,uintptr_t return_pc);
int iq4_f1_firmware_disable_on_ui_01(void);
#ifdef __cplusplus
}
static_assert(sizeof(Iq4F1FirmwareState01)==64);
static_assert(offsetof(Iq4F1FirmwareState01,queue)==32);
#endif
#endif
