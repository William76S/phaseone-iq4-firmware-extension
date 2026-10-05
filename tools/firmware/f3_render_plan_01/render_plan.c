#include "render_plan.h"
#include <limits.h>
#include <stddef.h>

static int add(uint64_t a, uint64_t b, uint64_t *v) {
    if (a > UINT64_MAX - b) return 0;
    *v = a + b; return 1;
}
static int mul(uint64_t a, uint64_t b, uint64_t *v) {
    if (b && a > UINT64_MAX / b) return 0;
    *v = a * b; return 1;
}
static int frame(uint32_t w, uint32_t h, uint32_t bpp, uint64_t *v) {
    uint64_t stride;
    if (!mul(w, bpp, &stride) || !add(stride, 31, &stride)) return 0;
    stride &= ~UINT64_C(31);
    return mul(stride, h, v);
}
enum f3_result f3_make_plan(const struct f3_source *s, uint32_t ratio,
                           const struct f3_budget *b, struct f3_plan *out) {
    struct f3_plan p = {0}; uint64_t tmp, peak, resample;
    if (!s || !b || !out) return F3_BAD_ARGUMENT;
    *out = p;
    if ((s->kind != F3_RAW_POOL && s->kind != F3_RAW_FILE_PAYLOAD) ||
        s->complete_payload_verified != 1 || s->immutable_owner_held != 1 || !s->identity)
        return F3_NOT_COMPLETE_RAW;
    if (!s->total_width || !s->total_height || !s->valid_width || !s->valid_height ||
        s->left > s->total_width || s->top > s->total_height ||
        s->valid_width > s->total_width - s->left ||
        s->valid_height > s->total_height - s->top) return F3_BAD_CROP;
    if (s->rotation_degrees != 0 && s->rotation_degrees != 90 &&
        s->rotation_degrees != 180 && s->rotation_degrees != 270)
        return F3_BAD_ARGUMENT;
    if (ratio != F3_FULL && ratio != F3_75_PERCENT && ratio != F3_50_PERCENT)
        return F3_BAD_ARGUMENT;
    /* Native getters and byte-size arithmetic are signed 32 bit. JPEG 1.5.3
     * JPEG_MAX_DIMENSION is 65500; do not accept a larger export. */
    if (s->total_width > INT32_MAX || s->total_height > INT32_MAX ||
        s->valid_width > 65500 || s->valid_height > 65500)
        return F3_BAD_DIMENSIONS;
    p.identity = s->identity; p.ratio = ratio;
    p.output_width = (uint32_t)(((uint64_t)s->valid_width * ratio + 50) / 100);
    p.output_height = (uint32_t)(((uint64_t)s->valid_height * ratio + 50) / 100);
    if (!p.output_width || !p.output_height) return F3_BAD_DIMENSIONS;
    p.full_render_then_resample = ratio == F3_75_PERCENT;
    p.render_width = ratio == F3_50_PERCENT ? p.output_width : s->valid_width;
    p.render_height = ratio == F3_50_PERCENT ? p.output_height : s->valid_height;
    if (!frame(p.render_width, p.render_height, 4, &p.rgb32_min_bytes) ||
        !frame(p.render_width, p.render_height, 1, &p.planar_min_bytes) ||
        !frame(s->total_width, s->total_height, 2, &p.decoded_raw_min_bytes))
        return F3_ARITHMETIC;
    if (p.rgb32_min_bytes > INT32_MAX || p.planar_min_bytes > INT32_MAX ||
        p.decoded_raw_min_bytes > INT32_MAX) return F3_NATIVE_SIZE_LIMIT;
    if (b->native_pipeline_stages >= 2) {
        if (!frame(p.render_width, p.render_height, 6, &tmp)) return F3_ARITHMETIC;
        if (tmp > INT32_MAX) return F3_NATIVE_SIZE_LIMIT;
        if (!mul(tmp, 2, &p.intermediate_pair_min_bytes)) return F3_ARITHMETIC;
    }
    if (!add(p.rgb32_min_bytes, p.planar_min_bytes, &peak) ||
        !add(peak, p.intermediate_pair_min_bytes, &peak)) return F3_ARITHMETIC;
    if (p.full_render_then_resample) {
        uint64_t a, c;
        if (!frame(p.output_width, p.output_height, 4, &a) ||
            !frame(p.output_width, p.output_height, 1, &c) ||
            !add(a, c, &resample) || !add(p.rgb32_min_bytes, p.planar_min_bytes, &tmp) ||
            !add(tmp, resample, &resample)) return F3_ARITHMETIC;
        /* Intermediate buffers are reusable after rendering; use max phase,
         * not a fictional simultaneous sum. Native borders/scratch omitted. */
        if (resample > peak) peak = resample;
    }
    p.native_arena_min_bytes = peak;
    if (s->rotation_degrees == 90 || s->rotation_degrees == 270) {
        uint32_t w = p.output_width;
        p.output_width = p.output_height; p.output_height = w;
    }
    p.row_rgb24_bytes = (uint64_t)p.output_width * 3;
    *out = p; /* Preserve useful lower bounds on refused plans. */
    if (b->upper_bounds_verified != 1 || !b->native_pipeline_stages)
        return F3_BUDGET_UNVERIFIED;
    if (b->native_arena_upper_bytes < p.native_arena_min_bytes ||
        b->decoded_raw_upper_bytes < p.decoded_raw_min_bytes ||
        !b->encoded_packet_upper_bytes || b->extra_upper_bytes < p.row_rgb24_bytes)
        return F3_BUDGET_INCONSISTENT;
    if (!add(b->native_arena_upper_bytes, b->decoded_raw_upper_bytes, &tmp) ||
        !add(tmp, F3_NATIVE_GENERATOR_PREFIX_BYTES, &p.generator_backing_upper_bytes) ||
        !add(p.generator_backing_upper_bytes, b->encoded_packet_upper_bytes, &tmp) ||
        !add(tmp, b->extra_upper_bytes, &p.required_upper_bytes)) return F3_ARITHMETIC;
    p.admitted = p.required_upper_bytes <= b->reserved_bytes;
    *out = p;
    return p.admitted ? F3_OK : F3_NO_MEMORY;
}
static enum f3_result plane_check(const struct f3_plane *p) {
    uint64_t row, last;
    if (!p || !p->allocation || !p->width || !p->height || p->bytes_per_pixel != 4 ||
        !mul(p->width, 4, &row) || p->stride < row ||
        !mul(p->height - 1, p->stride, &last) || !add(last, row, &last) ||
        !add(p->plane_offset, last, &last) || last > p->allocation_bytes ||
        p->allocation_bytes > SIZE_MAX) return F3_BAD_PLANE;
    return F3_OK;
}
enum f3_result f3_job_begin(struct f3_job *j, const struct f3_plan *p) {
    if (!j || !p || !p->admitted || !p->identity || !p->required_upper_bytes ||
        !p->output_width || !p->output_height) return F3_BAD_ARGUMENT;
    if (j->state != F3_JOB_IDLE && j->state != F3_JOB_DONE) return F3_BAD_STATE;
    j->plan = *p; j->owner_held = 1; j->cancelled = 0;
    j->workers_joined = 0; j->sink_active = 0; j->state = F3_JOB_RENDERING;
    return F3_OK;
}
enum f3_result f3_job_render_complete(struct f3_job *j, uint32_t joined) {
    if (!j || j->state != F3_JOB_RENDERING || !joined) return F3_BAD_STATE;
    j->workers_joined = 1; j->state = F3_JOB_READY; return F3_OK;
}
enum f3_result f3_job_cancel(struct f3_job *j) {
    if (!j || !j->owner_held || j->state == F3_JOB_DONE) return F3_BAD_STATE;
    j->cancelled = 1;
    if (!j->sink_active) j->state = F3_JOB_CANCEL_PENDING;
    return F3_OK;
}
enum f3_result f3_job_join_cancelled(struct f3_job *j) {
    if (!j || j->state != F3_JOB_CANCEL_PENDING || j->sink_active)
        return F3_BAD_STATE;
    j->workers_joined = 1; return F3_OK;
}
enum f3_result f3_job_consume(struct f3_job *j, const struct f3_plane *p,
                             f3_sync_rgb32_sink sink, void *ctx) {
    enum f3_result r;
    if (!j || !sink || j->state != F3_JOB_READY || !j->owner_held ||
        !j->workers_joined || j->sink_active) return F3_BAD_STATE;
    if (j->cancelled) return F3_CANCELLED;
    if (plane_check(p) != F3_OK || p->identity != j->plan.identity ||
        p->width != j->plan.output_width || p->height != j->plan.output_height)
        return F3_BAD_PLANE;
    j->sink_active = 1; j->state = F3_JOB_SINKING;
    r = sink(ctx, p);
    j->sink_active = 0; j->state = j->cancelled ? F3_JOB_CANCEL_PENDING : F3_JOB_READY;
    /* The sink may not retain p or its pixels. Its synchronous return is the
     * only lifetime exposed by this API; no completion queues exist here. */
    return j->cancelled ? F3_CANCELLED : r;
}
enum f3_result f3_job_release(struct f3_job *j) {
    if (!j || !j->owner_held || !j->workers_joined || j->sink_active ||
        (j->state != F3_JOB_READY && j->state != F3_JOB_CANCEL_PENDING))
        return F3_BAD_STATE;
    j->owner_held = 0; j->state = F3_JOB_DONE; return F3_OK;
}
enum f3_result f3_rgb32_row(const struct f3_plane *p, uint32_t row,
                            uint8_t *out, uint64_t cap) {
    uint32_t x; const uint8_t *src; uint64_t n;
    uintptr_t begin, end, dst;
    if (plane_check(p) != F3_OK || row >= p->height || !out)
        return F3_BAD_PLANE;
    n = (uint64_t)p->width * 3;
    if (cap < n) return F3_NO_MEMORY;
    begin = (uintptr_t)p->allocation; dst = (uintptr_t)out;
    if (p->allocation_bytes > UINTPTR_MAX - begin || n > UINTPTR_MAX - dst)
        return F3_BAD_PLANE;
    end = begin + (uintptr_t)p->allocation_bytes;
    if (dst < end && dst + (uintptr_t)n > begin) return F3_BAD_PLANE;
    src = p->allocation + (size_t)(p->plane_offset + row * p->stride);
    for (x = 0; x < p->width; ++x) {
        out[(size_t)x * 3] = src[(size_t)x * 4 + 1];
        out[(size_t)x * 3 + 1] = src[(size_t)x * 4 + 2];
        out[(size_t)x * 3 + 2] = src[(size_t)x * 4 + 3];
    }
    return F3_OK;
}
