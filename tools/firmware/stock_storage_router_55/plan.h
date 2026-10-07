#ifndef IQ4_STORAGE_PLAN_55_H
#define IQ4_STORAGE_PLAN_55_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
struct Iq4StoragePlan55 {uint32_t source_card,primary_card,jpeg_mask,format,sd_mode,raw_flags;};
/* RAW flags 2=XQD / 4=SD are the actual catalog flags, not UI estimates.
 * presence mask bit0=SD bit1=XQD. SD-only is Primary. */
int iq4_storage_plan_55(uint32_t format,uint32_t sd_mode,uint32_t presence,
                       uint32_t raw_flags,struct Iq4StoragePlan55 *out);
#ifdef __cplusplus
}
#endif
#endif
