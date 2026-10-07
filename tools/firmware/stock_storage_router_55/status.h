#pragma once
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
enum Iq4JpegFailure55 {IQ4_JPEG_FAILURE_NONE55=0,IQ4_JPEG_FAILURE_HALF_BIND55=1,
 IQ4_JPEG_FAILURE_HALF_MATCH55=2,IQ4_JPEG_FAILURE_HALF_RENDER55=3,
 IQ4_JPEG_FAILURE_HALF_CODEC55=4,IQ4_JPEG_FAILURE_CARD55=5,
 IQ4_JPEG_FAILURE_HOLD55=6,IQ4_JPEG_FAILURE_PENDING55=7,IQ4_JPEG_FAILURE_ARCHIVE55=8};
/* Last operation's first finite job failure or explicit rejected Archive choice, independent of backend HOLD. A normal
 * successful new job supplies 0/0; no success is inferred from UI selection. */
int iq4_stock_jpeg_last_failure_55(uint32_t *stage,uint32_t *detail);
uintptr_t iq4_stock_jpeg_pending_clear_guard_55(uintptr_t catalog,uint32_t index,uint32_t mask);
#ifdef __cplusplus
}
#endif
