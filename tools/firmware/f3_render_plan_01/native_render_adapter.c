#include "native_render_adapter.h"
#include <stddef.h>
#include <string.h>

static uint32_t read_u32(const void *p, size_t n) {
    uint32_t v; memcpy(&v, (const uint8_t *)p + n, sizeof(v)); return v;
}
static float read_f32(const void *p, size_t n) {
    float v; memcpy(&v, (const uint8_t *)p + n, sizeof(v)); return v;
}
static int settings_match(const struct f3_native_input *n,
                          const struct f3_source *s, const struct f3_plan *p) {
    const void *v = n->owned_settings;
    return n->private_objects_verified == 1 && n->settings_exclusively_owned == 1 &&
        v && n->settings_bytes >= F3_NATIVE_SETTINGS_MIN_BYTES &&
        read_f32(v, 0) == (float)p->ratio / 100.0f &&
        read_f32(v, 4) == (float)s->valid_width &&
        read_f32(v, 8) == (float)s->valid_height &&
        read_f32(v, 12) == (float)s->rotation_degrees &&
        read_u32(v, 0x20) == 5 &&
        read_u32(v, 0x2b8) == 0 && read_u32(v, 0x2bc) == 0 &&
        read_u32(v, 0x2c0) == s->valid_width &&
        read_u32(v, 0x2c4) == s->valid_height;
}
static int bound(const struct f3_native_ops *o) {
    return o && o->exact_original_and_abi_verified == 1 &&
        o->generator_construct && o->generator_destroy &&
        o->image_construct && o->image_destroy && o->configure_source &&
        o->configure_profile && o->process && o->join_after_failure && o->plane;
}
enum f3_result f3_native_cleanup(struct f3_native_adapter *a) {
    if (!a || !bound(&a->ops)) return F3_BAD_ARGUMENT;
    if (a->job.sink_active) return F3_BAD_STATE;
    if (a->join_needed) {
        if (a->ops.join_after_failure(a->ops.context, a->thread_pool) != F3_OK)
            return F3_CLEANUP_FAILURE;
        a->join_needed = 0;
        a->job.workers_joined = 1;
    }
    if (a->planar_alive) {
        if (a->ops.image_destroy(a->ops.context, a->planar.bytes) != F3_OK)
            return F3_CLEANUP_FAILURE;
        a->planar_alive = 0;
    }
    if (a->rgb32_alive) {
        if (a->ops.image_destroy(a->ops.context, a->rgb32.bytes) != F3_OK)
            return F3_CLEANUP_FAILURE;
        a->rgb32_alive = 0;
    }
    if (a->generator_alive) {
        if (a->ops.generator_destroy(a->ops.context, a->generator.bytes) != F3_OK)
            return F3_CLEANUP_FAILURE;
        a->generator_alive = 0;
    }
    if (a->job.owner_held) {
        a->job.workers_joined = 1;
        if (a->job.state == F3_JOB_RENDERING) a->job.state = F3_JOB_CANCEL_PENDING;
        if (f3_job_release(&a->job) != F3_OK) return F3_CLEANUP_FAILURE;
    }
    return F3_OK;
}
enum f3_result f3_native_render(struct f3_native_adapter *a,
                                const struct f3_native_ops *o,
                                const struct f3_source *s, const struct f3_plan *p,
                                const struct f3_native_input *n,
                                uint8_t *backing, uint64_t bytes,
                                f3_sync_rgb32_sink sink, void *sink_context) {
    enum f3_result result;
    struct f3_native_process_outcome outcome = {0};
    struct f3_plane plane = {0};
    const uint8_t *pixels = NULL; uint32_t w = 0, h = 0, stride = 0, format = 0;
    uintptr_t base, ptr;
    if (!a || !s || !p || !n || !backing || !sink) return F3_BAD_ARGUMENT;
    if (!bound(o)) return F3_NATIVE_UNBOUND;
    if (a->generator_alive || a->rgb32_alive || a->planar_alive ||
        a->job.owner_held || a->join_needed) return F3_BAD_STATE;
    if (s->immutable_owner_held != 1 || s->complete_payload_verified != 1 ||
        (s->kind != F3_RAW_POOL && s->kind != F3_RAW_FILE_PAYLOAD) ||
        s->identity != p->identity) return F3_NOT_COMPLETE_RAW;
    if (!settings_match(n, s, p) || !n->raw_input || !n->owned_raw_tags ||
        n->tags_exclusively_owned != 1 ||
        !n->exclusive_thread_pool || !n->native_cancel_byte) return F3_BAD_ARGUMENT;
    base = (uintptr_t)backing;
    if ((base & 31u) || bytes > SIZE_MAX || bytes > UINTPTR_MAX - base ||
        bytes < p->generator_backing_upper_bytes ||
        bytes < F3_NATIVE_GENERATOR_PREFIX_BYTES) return F3_NO_MEMORY;
    if (*n->native_cancel_byte) return F3_CANCELLED;
    result = f3_job_begin(&a->job, p);
    if (result != F3_OK) return result;
    a->ops = *o; a->thread_pool = n->exclusive_thread_pool;
    result = o->generator_construct(o->context, a->generator.bytes, backing, bytes);
    if (result != F3_OK) goto cleanup;
    a->generator_alive = 1;
    result = o->image_construct(o->context, a->rgb32.bytes);
    if (result != F3_OK) goto cleanup;
    a->rgb32_alive = 1;
    result = o->image_construct(o->context, a->planar.bytes);
    if (result != F3_OK) goto cleanup;
    a->planar_alive = 1;
    result = o->configure_source(o->context, a->generator.bytes, n->sensor_id, n->owned_raw_tags);
    if (result != F3_OK) goto cleanup;
    result = o->configure_profile(o->context, a->generator.bytes,
                                 n->owned_settings, n->profile_id);
    if (result != F3_OK) goto cleanup;
    /* The checked shim must prove completion, not just forward the original
     * PreviewProcess return. Its void subpipeline can fail after attachment. */
    a->join_needed = 1;
    result = o->process(o->context, a->generator.bytes, n->raw_input,
                        a->rgb32.bytes, a->planar.bytes, n->owned_settings,
                        n->exclusive_thread_pool, n->native_cancel_byte, &outcome);
    if (outcome.workers_joined) a->join_needed = 0;
    if (result != F3_OK || !outcome.vendor_return || !outcome.pixels_completed ||
        !outcome.workers_joined) {
        if (result == F3_OK) result = F3_NATIVE_FAILURE;
        goto cleanup;
    }
    if (*n->native_cancel_byte) { result = F3_CANCELLED; goto cleanup; }
    result = f3_job_render_complete(&a->job, 1);
    if (result != F3_OK) goto cleanup;
    result = o->plane(o->context, a->rgb32.bytes, &pixels, &w, &h, &stride, &format);
    if (result != F3_OK) goto cleanup;
    ptr = (uintptr_t)pixels;
    if (!pixels || ptr < base || ptr - base >= bytes || format != 5) {
        result = F3_BAD_PLANE; goto cleanup;
    }
    plane.allocation = backing; plane.allocation_bytes = bytes;
    plane.plane_offset = ptr - base; plane.stride = stride;
    plane.width = w; plane.height = h; plane.bytes_per_pixel = 4;
    plane.identity = s->identity;
    result = f3_job_consume(&a->job, &plane, sink, sink_context);
cleanup:
    if (f3_native_cleanup(a) != F3_OK) return F3_CLEANUP_FAILURE;
    return result;
}
