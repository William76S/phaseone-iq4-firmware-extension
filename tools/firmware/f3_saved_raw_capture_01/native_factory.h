#ifndef IQ4_F3_CAPTURE_NATIVE_FACTORY_01_H
#define IQ4_F3_CAPTURE_NATIVE_FACTORY_01_H
#include "capture.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Call once from integrated startup with the actual bounded own-memory reader
 * and synchronous coordinator06 consumer. Factory binds actual Card05 wait
 * and original syscall ports; it does not create a thread or call the SDK.
 * Saved runs on the original SD writer's native task thread. */
int f3_capture_install_native_01(const struct F3CardRead05*,
                               int(*saved)(void*,struct F3CapturedRaw01*),void*);
#ifdef __cplusplus
}
#endif
#endif
