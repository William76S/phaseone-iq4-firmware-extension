#ifndef IQ4_F3_NATIVE_API_BRIDGE_01_H
#define IQ4_F3_NATIVE_API_BRIDGE_01_H
#include "native_render_adapter.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Explicit, unbound function table for the recovered original C++ ABI.
 * Original ctor/configure/process/getter symbols are supplied by a separately
 * exact-byte-verified binder. This table never resolves private addresses.
 * C++ unwind compatibility and exception cleanup require target verification. */
struct f3_raw_api {
    uint32_t exact_original_and_abi_verified, cpp_unwind_verified;
    f3_raw_generator_ctor generator_construct;
    f3_raw_generator_dtor generator_destroy;
    void (*image_construct)(void *);
    void (*image_destroy)(void *);
    void (*configure_source)(void *, uint32_t, void *);
    void (*configure_profile)(void *, void *, uint32_t);
    f3_raw_preview_process process;
    void (*join)(void *);
    const uint8_t *(*image_plane)(const void *);
    uint32_t (*image_width)(const void *);
    uint32_t (*image_height)(const void *);
    uint32_t (*image_stride)(const void *);
    uint32_t (*image_format)(const void *);
};
/* begin/end must attest the SAME generator/input/output/settings/thread pool
 * and cancellation identity. end must cover all native core passes plus any
 * resample/orientation path. core_receipt alone cannot provide this proof.
 * No completion provider is shipped for the target. */
struct f3_completion_provider {
    void *context;
    uint32_t all_paths_and_identity_verified;
    enum f3_result (*begin)(void *, void *, const void *, void *, void *, void *,
                            void *, const uint8_t *);
    enum f3_result (*end)(void *, void *, const void *, void *, void *, void *,
                          void *, const uint8_t *, uint32_t,
                          struct f3_native_process_outcome *);
};
struct f3_native_bridge {
    struct f3_raw_api raw;
    struct f3_completion_provider completion;
    /* A thrown destructor/join has unknown partial effects. Quarantine retains
     * owners and rejects repeats instead of retrying a partial destructor. */
    uint32_t quarantined;
    uint32_t live_generators, live_images;
    void *generator, *images[2], *thread_pool;
};
/* Initialize a zero-initialized, exclusively owned bridge before any job.
 * All table attestation bits are mandatory and never set by this function.
 * Host tests use synthetic functions and do not validate original C++ ABI. */
enum f3_result f3_native_bridge_init(struct f3_native_bridge *,
                                     const struct f3_raw_api *,
                                     const struct f3_completion_provider *,
                                     struct f3_native_ops *);
#ifdef __cplusplus
}
#endif
#endif
