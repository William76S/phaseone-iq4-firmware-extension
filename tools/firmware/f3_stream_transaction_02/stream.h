#ifndef IQ4_F3_STREAM_TRANSACTION_02_H
#define IQ4_F3_STREAM_TRANSACTION_02_H
#include "../f3_save_transaction_01/transaction.h"
#include "sha256.h"
#ifdef __cplusplus
extern "C" {
#endif
#define F3_STREAM_MAX_BYTES (256u*1024u*1024u)
#define F3_STREAM_SCRATCH 65536u
/* Own synchronous state, never a vendor structure. Baseline single-scan JPEG only. */
struct F3JpegSyntax {
    uint32_t state, marker, length, remaining, position, found_sof, found_sos;
    uint32_t width,height,entropy,failed;
    uint8_t body[15],component_ids[3];
};
struct F3StreamResult {
    struct F3Result saved;
    uint64_t accepted_prefix_bytes, encoded_bytes;
    char encoded_sha256[65], readback_sha256[65];
    uint32_t encoder_finish_checked, jpeg_structure_checked;
};
/* state0 unused,1 writing,2 known failure,3 retained UNKNOWN,4 ended. Do not reset/reuse live state. */
struct F3Stream {
    uint32_t state;
    struct F3Session *session;
    struct F3Job job;
    struct F3Ports ports;
    struct F3StreamResult result;
    uint8_t *scratch;
    size_t scratch_bytes;
    uint64_t byte_budget;
    F4Sha encoded_hash;
    struct F3JpegSyntax syntax;
};
/* Only an actually successful synchronous encoder return may populate this proof.
 * finish_returned means encoder finish completed and all rows joined; cleanup_returned
 * means normal destroy returned. A number of attempted rows/destroy calls is not proof. */
struct F3EncoderCompletion {
    uint32_t succeeded,finish_returned,cleanup_returned,rows_encoded;
    uint64_t jpeg_bytes;
};
void f3_jpeg_syntax_init_02(struct F3JpegSyntax*);
int f3_jpeg_syntax_feed_02(struct F3JpegSyntax*,const uint8_t*,size_t);
int f3_jpeg_syntax_done_02(const struct F3JpegSyntax*,uint32_t,uint32_t);
/* Fresh context must be zero initialized; encoded/span fields of job must be zero.
 * No callbacks occur on unbound/source/epoch/scratch/state rejection. Caller retains
 * source RAW/render, context, ports, scratch and session synchronously until known end. */
int f3_stream_begin_02(struct F3Stream*,struct F3Session*,const struct F3Job*,
                       const struct F3Ports*,uint64_t,uint8_t*,size_t);
/* Compatible with Root encoder's size_t sink. Stops after first short/failure;
 * never closes/publishes in a producer callback. Unknown remains held. */
size_t f3_stream_sink_write_02(void*,const uint8_t*,size_t);
const struct F3StreamResult *f3_stream_finish_02(struct F3Stream*,const struct F3EncoderCompletion*);
/* Invoke only after synchronous producer return on known failure; checks one Close.
 * It never publishes or removes RAW. On unknown producer ownership use hold, not abort. */
const struct F3StreamResult *f3_stream_abort_02(struct F3Stream*);
const struct F3StreamResult *f3_stream_hold_02(struct F3Stream*,uint32_t);
#ifdef __cplusplus
}
#endif
#endif
