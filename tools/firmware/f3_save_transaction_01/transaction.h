#ifndef IQ4_F3_TRANSACTION_01_H
#define IQ4_F3_TRANSACTION_01_H
#include <stdint.h>
#include <stddef.h>
#ifdef __cplusplus
extern "C" {
#endif
/* This is our port ABI, never a declaration of recovered vendor ABI. */
enum F3Mode { F3_RAW=0, F3_RAW_JPEG=1, F3_JPEG_ONLY=2 };
enum F3Purpose { F3_NEW_CAPTURE=1, F3_MANUAL_EXISTING_RAW=2 };
enum F3Status { F3_RAW_RETAINED=0, F3_JPEG_WITH_RAW=1, F3_JPEG_ONLY_DONE=2,
                F3_REJECTED=3, F3_FAILED_RAW_RETAINED=4, F3_UNKNOWN_HOLD=5 };
enum F3IoState { F3_IO_DONE=0, F3_IO_FAIL=1, F3_IO_UNKNOWN=2 };
struct F3Io { uint32_t state; uint64_t value; };
struct F3File { uint64_t device, inode, card_epoch, task_nonce, bytes; };
struct F3Job {
    uint64_t boot_epoch, capture_id;
    uint32_t mode, purpose, newly_created_raw_stage;
    uint32_t source_raw_width, source_raw_height, render_width, render_height;
    uint32_t output_width, output_height;
    uint32_t render_source_kind; /* 1: actual complete RAW decode; 0/other unsupported. */
    struct F3File raw;
    struct F3File render_source;
    /* Full-RAW renderer output / encoder ownership stays pinned through return. */
    const uint8_t *encoded;
    uint64_t encoded_bytes;
};
struct F3Ports {
    void *context;
    /* Return DONE only on checked, actual operations. Unknown is a retained-owner latch. */
    struct F3Io (*check_raw)(void*,const struct F3Job*);
    /* Must create a private temporary file exclusively; no Exists→O_TRUNC emulation. */
    struct F3Io (*open_exclusive)(void*,const struct F3Job*,struct F3File*);
    struct F3Io (*write)(void*,const uint8_t*,uint32_t);
    /* On DONE or FAIL, the descriptor is known closed. UNKNOWN must retain it. */
    struct F3Io (*close_write)(void*);
    struct F3Io (*open_read)(void*,const struct F3File*,struct F3File*);
    struct F3Io (*read)(void*,uint8_t*,uint32_t);
    struct F3Io (*stat_read)(void*,struct F3File*);
    struct F3Io (*close_read)(void*);
    /* Atomic non-replacing publication + checked directory sync; immutable file identity. */
    struct F3Io (*publish)(void*,const struct F3File*);
    /* Only an exact, newly created private stage of this capture; never catalogue index alone. */
    struct F3Io (*remove_owned_raw_stage)(void*,const struct F3Job*);
};
struct F3Result {
    uint32_t status, failure_step, write_open, read_open, published, raw_removed;
    uint32_t check_raw_calls, write_calls, read_calls, close_write_calls, close_read_calls;
    uint64_t verified_bytes;
    struct F3File jpeg;
};
/* One serialized task owner. UNKNOWN retains owner and rejects every later operation. */
struct F3Session { uint64_t boot_epoch; uint32_t hold, in_progress; };
/* No allocations, thread creation, guessed vendor calls, filesystem paths, or target writes. */
struct F3Result f3_checked_save_01(struct F3Session*,const struct F3Job*,const struct F3Ports*,uint8_t*,size_t);
int f3_jpeg_shape_01(const uint8_t*,size_t,uint32_t*,uint32_t*);
#ifdef __cplusplus
}
#endif
#endif
