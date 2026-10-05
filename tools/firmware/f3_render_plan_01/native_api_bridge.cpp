#include "native_api_bridge.h"
#include <string.h>
static f3_native_bridge *bridge(void *c) { return static_cast<f3_native_bridge *>(c); }
static f3_result gc(void *c, void *g, void *p, uint64_t n) {
    auto *b=bridge(c); if (b->quarantined) return F3_CLEANUP_FAILURE;
    if (b->live_generators || b->live_images) return F3_BAD_STATE;
    try { memset(g,0,F3_NATIVE_GENERATOR_BYTES); b->raw.generator_construct(g,p,n); b->live_generators=1; b->generator=g; return F3_OK; }
    catch (...) { return F3_NATIVE_FAILURE; }
}
static f3_result gd(void *c, void *g) {
    auto *b=bridge(c); if (b->quarantined) return F3_CLEANUP_FAILURE;
    if (b->live_generators!=1 || b->live_images || b->generator!=g) return F3_BAD_STATE;
    try { b->raw.generator_destroy(g); b->live_generators=0; b->generator=nullptr; b->thread_pool=nullptr; return F3_OK; }
    catch (...) { b->quarantined=1; return F3_CLEANUP_FAILURE; }
}
static f3_result ic(void *c, void *i) {
    auto *b=bridge(c); if (b->quarantined) return F3_CLEANUP_FAILURE;
    /* Original 904550 reads the prior reference flag/pointer. New owned
     * storage must be zero before its string/descriptor constructor runs. */
    if (b->live_generators!=1 || b->live_images>=2 || i==b->generator ||
        i==b->images[0] || i==b->images[1]) return F3_BAD_STATE;
    try { memset(i,0,F3_NATIVE_IMAGE_BUFFER_BYTES); b->raw.image_construct(i);
        b->images[b->images[0] ? 1 : 0]=i; ++b->live_images; return F3_OK; }
    catch (...) { return F3_NATIVE_FAILURE; }
}
static f3_result id(void *c, void *i) {
    auto *b=bridge(c); if (b->quarantined) return F3_CLEANUP_FAILURE;
    if (!b->live_images || (i!=b->images[0] && i!=b->images[1])) return F3_BAD_STATE;
    try { b->raw.image_destroy(i); b->images[i==b->images[0] ? 0 : 1]=nullptr; --b->live_images; return F3_OK; }
    catch (...) { b->quarantined=1; return F3_CLEANUP_FAILURE; }
}
static f3_result cs(void *c, void *g, uint32_t sensor, void *tags) {
    auto *b=bridge(c); if (b->quarantined) return F3_CLEANUP_FAILURE;
    if (b->live_generators!=1 || b->generator!=g) return F3_BAD_STATE;
    try { b->raw.configure_source(g,sensor,tags); return F3_OK; }
    catch (...) { return F3_NATIVE_FAILURE; }
}
static f3_result cp(void *c, void *g, void *s, uint32_t profile) {
    auto *b=bridge(c); if (b->quarantined) return F3_CLEANUP_FAILURE;
    if (b->live_generators!=1 || b->generator!=g) return F3_BAD_STATE;
    try { b->raw.configure_profile(g,s,profile); return F3_OK; }
    catch (...) { return F3_NATIVE_FAILURE; }
}
static f3_result process(void *c, void *g, const void *r, void *i, void *p,
                         void *s, void *t, const uint8_t *cancel,
                         f3_native_process_outcome *o) {
    auto *b=bridge(c); if (!o) return F3_BAD_ARGUMENT; *o={0,0,0};
    if (b->quarantined) return F3_CLEANUP_FAILURE;
    if (b->live_generators!=1 || b->generator!=g || b->live_images!=2 || i==p ||
        (i!=b->images[0] && i!=b->images[1]) ||
        (p!=b->images[0] && p!=b->images[1])) return F3_BAD_STATE;
    b->thread_pool=t;
    try {
        f3_result rc=b->completion.begin(b->completion.context,g,r,i,p,s,t,cancel);
        if (rc!=F3_OK) return rc;
        const uint32_t result=b->raw.process(g,r,i,p,s,t,cancel);
        f3_native_process_outcome proved={0,0,0};
        rc=b->completion.end(b->completion.context,g,r,i,p,s,t,cancel,result,&proved);
        /* Reject incomplete receipts, and never copy a provider's invented
         * vendor return into the actual call result. */
        o->vendor_return=result;
        o->workers_joined=proved.workers_joined==1 ? 1u : 0u;
        if (rc!=F3_OK || result!=1 || proved.vendor_return!=result ||
            proved.pixels_completed!=1 || proved.workers_joined!=1)
            return rc!=F3_OK ? rc : F3_NATIVE_FAILURE;
        o->pixels_completed=1; return F3_OK;
    } catch (...) { return F3_NATIVE_FAILURE; }
}
static f3_result join(void *c, void *t) {
    auto *b=bridge(c); if (b->quarantined) return F3_CLEANUP_FAILURE;
    if (!b->thread_pool || b->thread_pool!=t) return F3_BAD_STATE;
    try { b->raw.join(t); return F3_OK; }
    catch (...) { b->quarantined=1; return F3_CLEANUP_FAILURE; }
}
static f3_result plane(void *c, const void *i, const uint8_t **p,
                       uint32_t *w, uint32_t *h, uint32_t *s, uint32_t *f) {
    auto *b=bridge(c); if (b->quarantined) return F3_CLEANUP_FAILURE;
    if (!p || !w || !h || !s || !f) return F3_BAD_ARGUMENT;
    if (!b->live_images || (i!=b->images[0] && i!=b->images[1])) return F3_BAD_STATE;
    try {
        *p=b->raw.image_plane(i); *w=b->raw.image_width(i);
        *h=b->raw.image_height(i); *s=b->raw.image_stride(i);
        *f=b->raw.image_format(i); return F3_OK;
    } catch (...) { return F3_NATIVE_FAILURE; }
}
extern "C" f3_result f3_native_bridge_init(f3_native_bridge *b, const f3_raw_api *r,
                                           const f3_completion_provider *p,
                                           f3_native_ops *o) {
    if (!b || !r || !p || !o) return F3_BAD_ARGUMENT;
    if (r->exact_original_and_abi_verified!=1 || r->cpp_unwind_verified!=1 ||
        p->all_paths_and_identity_verified!=1) return F3_NATIVE_UNBOUND;
    if (!r->generator_construct || !r->generator_destroy || !r->image_construct ||
        !r->image_destroy || !r->configure_source || !r->configure_profile ||
        !r->process || !r->join || !r->image_plane || !r->image_width ||
        !r->image_height || !r->image_stride || !r->image_format || !p->begin || !p->end)
        return F3_BAD_ARGUMENT;
    if (b->quarantined) return F3_CLEANUP_FAILURE;
    if (b->live_generators || b->live_images) return F3_BAD_STATE;
    b->raw=*r; b->completion=*p;
    *o={b,1,gc,gd,ic,id,cs,cp,process,join,plane}; return F3_OK;
}
