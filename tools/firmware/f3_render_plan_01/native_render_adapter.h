#ifndef IQ4_F3_NATIVE_RENDER_ADAPTER_01_H
#define IQ4_F3_NATIVE_RENDER_ADAPTER_01_H
#include "render_plan.h"
#ifdef __cplusplus
extern "C" {
#endif
#define F3_NATIVE_GENERATOR_BYTES 0x1f0u
#define F3_NATIVE_IMAGE_BUFFER_BYTES 0x58u
#define F3_NATIVE_SETTINGS_MIN_BYTES 0x2c8u

/* Recovered raw AAPCS64 call shapes. These typedefs do not bind addresses.
 * C++ constructors and exceptions require a checked native shim. */
typedef void (*f3_raw_generator_ctor)(void *, void *, uint64_t);
typedef void (*f3_raw_generator_dtor)(void *);
typedef uint32_t (*f3_raw_preview_process)(void *, const void *, void *, void *,
                                          void *, void *, const uint8_t *);

struct f3_native_input {
    const void *raw_input;
    void *owned_raw_tags; /* RawSourceFactory may insert missing defaults. */
    void *owned_settings;
    uint64_t settings_bytes;
    void *exclusive_thread_pool;
    const uint8_t *native_cancel_byte;
    uint32_t sensor_id, profile_id;
    /* These declarations are supplied by the target source binder, never
     * inferred from dimensions, a thumbnail, LV data, or our host fixtures. */
    uint32_t private_objects_verified, settings_exclusively_owned, tags_exclusively_owned;
};
struct f3_native_process_outcome {
    uint32_t vendor_return, pixels_completed, workers_joined;
};
struct f3_native_ops {
    void *context;
    uint32_t exact_original_and_abi_verified;
    /* Checked shims must contain C++ exceptions and return a result. They
     * are NOT casts of raw original function addresses. */
    enum f3_result (*generator_construct)(void *, void *, void *, uint64_t);
    enum f3_result (*generator_destroy)(void *, void *);
    enum f3_result (*image_construct)(void *, void *);
    enum f3_result (*image_destroy)(void *, void *);
    enum f3_result (*configure_source)(void *, void *, uint32_t, void *);
    enum f3_result (*configure_profile)(void *, void *, void *, uint32_t);
    enum f3_result (*process)(void *, void *, const void *, void *, void *,
                              void *, void *, const uint8_t *,
                              struct f3_native_process_outcome *);
    enum f3_result (*join_after_failure)(void *, void *);
    enum f3_result (*plane)(void *, const void *, const uint8_t **,
                            uint32_t *, uint32_t *, uint32_t *, uint32_t *);
};
union f3_generator_storage {
    uint64_t alignment;
    uint8_t bytes[F3_NATIVE_GENERATOR_BYTES];
};
union f3_image_storage {
    uint64_t alignment;
    uint8_t bytes[F3_NATIVE_IMAGE_BUFFER_BYTES];
};
struct f3_native_adapter {
    struct f3_job job;
    union f3_generator_storage generator;
    union f3_image_storage rgb32, planar;
    uint32_t generator_alive, rgb32_alive, planar_alive, join_needed;
    struct f3_native_ops ops;
    void *thread_pool;
};
/* Native objects, source lease and arena must stay alive until cleanup returns
 * OK. A cleanup failure deliberately retains the adapter and RAW ownership.
 * There is no file publish or RAW delete operation in this interface. */
enum f3_result f3_native_render(struct f3_native_adapter *,
                                const struct f3_native_ops *,
                                const struct f3_source *, const struct f3_plan *,
                                const struct f3_native_input *,
                                uint8_t *reserved_generator_backing, uint64_t bytes,
                                f3_sync_rgb32_sink, void *sink_context);
enum f3_result f3_native_cleanup(struct f3_native_adapter *);
#ifdef __cplusplus
}
#endif
#endif
