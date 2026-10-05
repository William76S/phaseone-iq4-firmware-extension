#ifndef IQ4_F3_SAVE_COORDINATOR_05_H
#define IQ4_F3_SAVE_COORDINATOR_05_H
#include "../f3_native_card_bridge_05/card.h"
#include "../f3_render_plan_01/native_render_adapter.h"
#include "../f3_stream_transaction_02/codec_bridge.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Concrete source/arena binders supply checked operations, not declarations
 * that an owner is safe. Source lease stays held after reader objects close. */
struct F3SaveOwners05 {
 void*context;
 struct F3Io(*source_valid)(void*);
 struct F3Io(*close_source_reader)(void*);
 struct F3Io(*close_arena)(void*);
 struct F3Io(*release_source_lease)(void*);
};
struct F3SaveRequest05 {
 struct F3Job job; /* copied immutably before renderer/sink sees internal mode */
 const struct f3_source*source;const struct f3_plan*plan;
 const struct f3_native_input*input;const struct f3_native_ops*render_ops;
 const Iq4JpegApi*codec;
 uint8_t*arena;uint64_t arena_bytes,jpeg_budget;
 uint8_t*readback_scratch;size_t readback_bytes;int quality;
};
struct F3SaveResult05 {
 struct F3Result saved;uint32_t public_mode,phase,renderer_result;
 uint32_t render_cleanup_confirmed,reader_closed,arena_closed,raw_fd_closed;
 uint32_t directories_closed,source_lease_released,card_requests_released;
};
struct F3Save05 {
 uint32_t state;struct F3Fs*fs;struct F3Card05*card;
 struct F3Session session;struct F3Job immutable;
 struct F3SaveOwners05 owners;struct F3SaveRequest05 request;
 struct f3_native_adapter native;struct F3Stream stream;
 Iq4StreamResult encoder;struct F3SaveResult05 result;
};
/* Own synchronous actor. Caller keeps every object/address alive. No automatic
 * destructor runs on UNKNOWN: future calls return same held result without I/O.
 * Rejected state0 did not adopt/release caller's already-held leases. */
const struct F3SaveResult05*f3_save_run_05(struct F3Save05*,struct F3Fs*,
 struct F3Card05*,const struct F3SaveOwners05*,const struct F3SaveRequest05*);
#ifdef __cplusplus
}
#endif
#endif
