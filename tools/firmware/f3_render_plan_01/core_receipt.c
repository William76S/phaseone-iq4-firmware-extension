#include "core_receipt.h"
#include <string.h>
static int identity(const struct f3_core_receipt *r, uint64_t request, uint64_t thread) {
    return r && r->armed && r->identity.request == request && r->identity.thread == thread;
}
enum f3_result f3_core_arm(struct f3_core_receipt *r, const struct f3_core_identity *i) {
    if (!r || !i || !i->request || !i->thread || !i->settings || !i->cancel ||
        !i->arena_base || !i->arena_bytes || i->arena_bytes > UINTPTR_MAX - i->arena_base)
        return F3_BAD_ARGUMENT;
    if (r->armed && !r->returned) return F3_BAD_STATE;
    memset(r, 0, sizeof(*r)); r->identity = *i; r->armed = 1; return F3_OK;
}
enum f3_result f3_core_enter(struct f3_core_receipt *r, uint64_t request, uint64_t thread,
                             const struct f3_core_entry *e) {
    uintptr_t end;
    if (!identity(r, request, thread) || !e || r->entered || r->returned)
        return F3_BAD_STATE;
    if (!e->frame_sp || !e->allocator || !e->output || !e->arena_bytes ||
        e->settings != r->identity.settings || e->cancel != r->identity.cancel ||
        e->arena_base < r->identity.arena_base ||
        e->arena_bytes > UINTPTR_MAX - e->arena_base) return F3_BAD_ARGUMENT;
    end = r->identity.arena_base + (uintptr_t)r->identity.arena_bytes;
    if (e->arena_base + e->arena_bytes > end) return F3_BAD_ARGUMENT;
    /* Only the four actual core callers inside the fixed original process. */
    if (e->return_pc != 0x963f48 && e->return_pc != 0x964358 &&
        e->return_pc != 0x964420 && e->return_pc != 0x964864)
        return F3_BAD_ARGUMENT;
    r->entry = *e; r->entered = 1; return F3_OK;
}
static int same_entry(const struct f3_core_entry *a, const struct f3_core_entry *b) {
    return a->frame_sp == b->frame_sp && a->allocator == b->allocator &&
        a->output == b->output && a->return_pc == b->return_pc &&
        a->arena_base == b->arena_base && a->arena_bytes == b->arena_bytes &&
        a->settings == b->settings && a->cancel == b->cancel;
}
enum f3_result f3_core_terminal(struct f3_core_receipt *r, uint64_t request, uint64_t thread,
                                const struct f3_core_terminal *t) {
    if (!identity(r, request, thread) || !t || !r->entered || r->returned ||
        r->terminal_seen || !same_entry(&r->entry, &t->entry)) return F3_BAD_STATE;
    /* Original 91a950 is also reached on cancel. Empty worker pools cannot
     * prove pixels were processed, despite their per-stage counters. */
    if (!t->total_stages || t->total_stages > 4096 ||
        t->completed_stages != t->total_stages || !t->thread_count || t->cancel_value)
        return F3_NATIVE_FAILURE;
    r->terminal_seen = 1; return F3_OK;
}
enum f3_result f3_core_return(struct f3_core_receipt *r, uint64_t request, uint64_t thread,
                              uintptr_t frame_sp) {
    if (!identity(r, request, thread) || !r->entered || r->returned ||
        frame_sp != r->entry.frame_sp) return F3_BAD_STATE;
    r->returned = 1;
    return r->terminal_seen ? F3_OK : F3_NATIVE_FAILURE;
}
