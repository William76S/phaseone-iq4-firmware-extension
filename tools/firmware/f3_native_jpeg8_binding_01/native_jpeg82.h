#ifndef IQ4_F3_NATIVE_JPEG82_BINDING_01_H
#define IQ4_F3_NATIVE_JPEG82_BINDING_01_H
#include "../../../src/codec/bounded_jpeg.h"
#ifdef __cplusplus
extern "C" {
#endif

/* Only code bytes, never image/PIN/EEPROM data. Caller supplies an already
 * validated synchronous self-memory reader for the current process. It must
 * return 1 only after copying exactly bytes; no ownership or mapping discovery
 * is performed here. Original RX memory must stay immutable through encoding.
 */
typedef int (*Iq4Jpeg82ReadExact01)(void *context, uintptr_t address,
                                   uint8_t *destination, size_t bytes);
typedef enum Iq4Jpeg82BindStatus01 {
    IQ4_JPEG82_BOUND_STATIC_ABI_01=0,
    IQ4_JPEG82_ARGUMENT_01,
    IQ4_JPEG82_BASELINE_01,
    IQ4_JPEG82_CODE_READ_01,
    IQ4_JPEG82_CODE_MISMATCH_01,
    IQ4_JPEG82_ARCHITECTURE_01
} Iq4Jpeg82BindStatus01;

/* Returns the actual pinned C function table. It is deliberately not admitted
 * for encoding: binding_abi_verified==0. No native function is invoked.
 */
Iq4JpegApi iq4_native_jpeg82_unadmitted_table_01(void);

/* Explicit admission, not an initializer. The SHA names the original source
 * baseline, not an assertion that a patched User still has that whole SHA.
 * Checks every byte of eight API function bodies and the destroy tail target.
 * A patched User must independently have its own actual identity/immutable RX
 * proof. Success confirms static ABI+code identity, not target encoding tests.
 * No encoding, allocation, SDK, file/RAW access, or deployment occurs here.
 */
Iq4Jpeg82BindStatus01 iq4_native_jpeg82_bind_01(
    const uint8_t original_baseline_sha256[32], Iq4Jpeg82ReadExact01 read_exact,
    void *context, Iq4JpegApi *output);
#ifdef __cplusplus
}
#endif
#endif
