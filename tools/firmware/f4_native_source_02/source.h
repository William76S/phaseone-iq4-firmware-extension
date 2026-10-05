#ifndef IQ4_F4_NATIVE_SOURCE_02_H
#define IQ4_F4_NATIVE_SOURCE_02_H
#include <stddef.h>
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Own C ABI. No native C++ class declarations or stdlib ownership crosses it. */
#define IQ4_F4_SOURCE_SLOTS 8u
#define IQ4_F4_SOURCE_SLOT_MAX (16u*1024u*1024u)
typedef int (*Iq4F4SelfRead02)(void *,uintptr_t,void *,size_t);
/* Own finite page inspector: 1 actual page present, 0 normally left, -1 unknown.
 * Native menu03 supplies this from selector stack + Navigator current menu. */
typedef int (*Iq4F4PageGuard02)(void *);
/* Owned callbacks, not native methods. wake runs only after paired unlock and
 * published owned slot; it must be nonblocking. control runs on verified UI. */
typedef void (*Iq4F4OwnedWake02)(void *);
typedef void (*Iq4F4OwnedControl02)(void *);
typedef struct { uint32_t width,height,stride,bytes,software_id,native_slot;
 uint32_t channels,component_map[4],configuration_width,configuration_height,configuration_bytes;
 uint64_t observed_completion_ns; } Iq4F4FrameMetadata02;
typedef struct { const unsigned char *bytes; Iq4F4FrameMetadata02 metadata;
 uint32_t slot,generation; } Iq4F4OwnedFrame02;
typedef struct { uint64_t notifications,copied,duplicates,stale,full,invalid,ui_retained,
 wrong_owner,clock_rejected,unlock_attempts,source_gaps; uint32_t held_uncertain,attached,accepting; } Iq4F4SourceStatus02;
enum Iq4F4SourceResult02 { IQ4_F4_SRC_OK=0,IQ4_F4_SRC_DISABLED=1,IQ4_F4_SRC_REJECTED=2,
 IQ4_F4_SRC_DUPLICATE=3,IQ4_F4_SRC_FULL=4,IQ4_F4_SRC_HOLD=5,IQ4_F4_SRC_PENDING=6,
 IQ4_F4_SRC_EMPTY=7 };
/* Storage lives until process exit. No hot-free/dlclose/destructor is supported.
 * init performs actual byte admission + UI owner inspection; it never registers.
 * arena is caller-owned, preallocated before source lock, bounded and retained.
 * A successful init is a production binding, not a camera capability receipt. */
size_t iq4_f4_source_storage_bytes_02(void);
int iq4_f4_source_init_02(void *storage,size_t storage_bytes,Iq4F4SelfRead02,void *read_context,
 unsigned char *arena,size_t arena_bytes,uint32_t slots,uint32_t slot_bytes);
int iq4_f4_source_attach_on_ui_02(void *);
int iq4_f4_source_measure_on_ui_02(void *,Iq4F4FrameMetadata02 *);
int iq4_f4_source_bind_page_guard_on_ui_02(void *,Iq4F4PageGuard02,void *);
int iq4_f4_source_bind_handoff_on_ui_02(void *,Iq4F4OwnedWake02,Iq4F4OwnedControl02,void *);
int iq4_f4_source_post_control_02(void *);
int iq4_f4_source_is_ui_02(void *);
/* expected is the exact fresh measure result, not width/FPS supplied by a UI.
 * This does not prepare codec/card: the coordinator must do so before calling. */
int iq4_f4_source_start_on_ui_02(void *,const Iq4F4FrameMetadata02 *expected);
int iq4_f4_source_stop_on_ui_02(void *);
/* Idempotent own control-event request, safe from worker; native Stop occurs
 * on the original UI queue. Unknown event send becomes Hold, never retry. */
int iq4_f4_source_request_stop_02(void *);
/* fence is own-copy/admission quiescence, NOT safe hot-unload proof. */
int iq4_f4_source_fence_02(void *);
int iq4_f4_source_worker_claim_02(void *,Iq4F4OwnedFrame02 *);
int iq4_f4_source_worker_release_02(void *,const Iq4F4OwnedFrame02 *);
Iq4F4SourceStatus02 iq4_f4_source_status_on_ui_02(void *);
#ifdef __cplusplus
}
#endif
#endif
