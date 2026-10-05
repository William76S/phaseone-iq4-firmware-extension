#ifndef IQ4_F3_RENDER_PLAN_01_H
#define IQ4_F3_RENDER_PLAN_01_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif

/* A freestanding, host-verified contract; no vendor addresses or allocator. */
enum f3_source_kind { F3_SOURCE_UNKNOWN, F3_RAW_POOL, F3_RAW_FILE_PAYLOAD,
                      F3_THUMBNAIL, F3_LV_FRAME };
enum f3_ratio { F3_FULL = 100, F3_75_PERCENT = 75, F3_50_PERCENT = 50 };
enum f3_result { F3_OK, F3_BAD_ARGUMENT, F3_NOT_COMPLETE_RAW, F3_BAD_CROP,
                 F3_BAD_DIMENSIONS, F3_ARITHMETIC, F3_NATIVE_SIZE_LIMIT,
                 F3_BUDGET_UNVERIFIED, F3_BUDGET_INCONSISTENT, F3_NO_MEMORY,
                 F3_BAD_STATE, F3_BAD_PLANE, F3_CANCELLED,
                 F3_NATIVE_UNBOUND, F3_NATIVE_FAILURE, F3_CLEANUP_FAILURE };
#define F3_NATIVE_GENERATOR_PREFIX_BYTES UINT64_C(83886080)
struct f3_source {
    uint32_t kind, total_width, total_height;
    uint32_t left, top, valid_width, valid_height, rotation_degrees;
    uint64_t identity;
    /* Set only by a separately verified raw reader/pool adapter. */
    uint32_t complete_payload_verified, immutable_owner_held;
};
struct f3_budget {
    uint64_t reserved_bytes, native_arena_upper_bytes;
    uint64_t decoded_raw_upper_bytes, encoded_packet_upper_bytes;
    uint64_t extra_upper_bytes;
    /* reserved_bytes is exclusive, held backing; a free-RAM observation is
     * insufficient. A lower bound is never a proof of a complete budget. */
    uint32_t upper_bounds_verified, native_pipeline_stages;
};
struct f3_plan {
    uint64_t identity;
    uint32_t output_width, output_height, render_width, render_height;
    uint32_t ratio, full_render_then_resample, admitted;
    uint64_t rgb32_min_bytes, planar_min_bytes, intermediate_pair_min_bytes;
    uint64_t native_arena_min_bytes, decoded_raw_min_bytes;
    uint64_t row_rgb24_bytes, generator_backing_upper_bytes, required_upper_bytes;
};
enum f3_result f3_make_plan(const struct f3_source *, uint32_t ratio,
                           const struct f3_budget *, struct f3_plan *);
/* Output dimensions round half up. Native ceil/other rounding must be checked rather
 * than silently changing the selected size; an adapter must deliver exactly
 * these dimensions or fail. */

enum f3_job_state { F3_JOB_IDLE, F3_JOB_RENDERING, F3_JOB_READY,
                    F3_JOB_SINKING, F3_JOB_CANCEL_PENDING, F3_JOB_DONE };
struct f3_job {
    struct f3_plan plan;
    uint32_t state, owner_held, cancelled, workers_joined, sink_active;
};
/* One serialized executor owns a job. No functions here are thread-safe. */
struct f3_plane {
    const uint8_t *allocation;
    uint64_t allocation_bytes, plane_offset, stride;
    uint32_t width, height, bytes_per_pixel;
    uint64_t identity;
};
typedef enum f3_result (*f3_sync_rgb32_sink)(void *, const struct f3_plane *);
enum f3_result f3_job_begin(struct f3_job *, const struct f3_plan *);
enum f3_result f3_job_render_complete(struct f3_job *, uint32_t workers_joined);
enum f3_result f3_job_cancel(struct f3_job *);
enum f3_result f3_job_join_cancelled(struct f3_job *);
enum f3_result f3_job_consume(struct f3_job *, const struct f3_plane *,
                             f3_sync_rgb32_sink, void *);
enum f3_result f3_job_release(struct f3_job *);
/* Copy one immutable [unused,R,G,B] row to bounded RGB24 storage. This is
 * original 0x7b982c's byte order, not a claim about the plane's color space. */
enum f3_result f3_rgb32_row(const struct f3_plane *, uint32_t row,
                            uint8_t *rgb24, uint64_t rgb24_capacity);

#ifdef __cplusplus
}
#endif
#endif
