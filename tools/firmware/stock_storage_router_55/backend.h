#pragma once
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Root-owned native SD-only normalizer. Only an original settings operation;
 * return 1 means unchanged or native Primary readback was verified. */
int iq4_stock_storage_normalize_sd_55(uintptr_t viewmodel,uintptr_t sd_group,uintptr_t xqd_group);
/* Cold card-ready callback predicate. Native UI sequence and JPEG pending
 * count must both be idle; no setting or requester is changed here. */
int iq4_stock_storage_normalize_idle_55(void);
#ifdef __cplusplus
}
#endif
