#pragma once
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Synchronous native gallery/cold-scan lease. card 10=SD,11=XQD.
 * enter: 1 leased,0 finite busy/refusal,-1 unknown ownership/HOLD.
 * guard: 1 only for the same owning thread and exact native requester/card.
 * leave: 1 retired,0 foreign/refused,-1 unknown/HOLD; borrowed JPEG output
 * tokens are never released by this interface. No RAW-source token required. */
int iq4_stock_jpeg_gallery_card_enter_55(uint32_t card);
int iq4_stock_jpeg_gallery_card_guard_55(uint32_t card);
int iq4_stock_jpeg_gallery_card_leave_55(uint32_t card);
#ifdef __cplusplus
}
#endif
