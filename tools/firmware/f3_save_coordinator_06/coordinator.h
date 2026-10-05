#ifndef IQ4_F3_SAVE_COORDINATOR_06_H
#define IQ4_F3_SAVE_COORDINATOR_06_H
#include "../f3_saved_raw_capture_01/capture.h"
#include "../f3_native_executor_01/executor.h"
#include "../../../src/codec/bounded_jpeg.h"
#ifdef __cplusplus
extern "C" {
#endif
enum F3CoordinatorResult06 {F3_COORD_KNOWN_ENDED06=0,F3_COORD_BUSY06=1,
 F3_COORD_REJECTED06=2,F3_COORD_UNKNOWN06=3};
struct F3CoordinatorSettings06 {uint32_t mode,size_mode,quality;};
struct F3CoordinatorView06 {uint64_t generation;uint32_t phase,status,failure_step,
 requested_mode,size_mode,width,height,jpeg_published,raw_removed,hold;};
/* This is an actual linked-ELF reviewer entry, not a hardcoded positive input.
 * It must validate current symbols/code and the exact final ELF's FDE/LSDA,
 * landing pads/import/version/CFI contract. The reviewer does not claim that
 * native target throw/catch has been accepted on hardware. */
struct F3LinkedContract06 {void*context;
 int(*verify_current_linked_elf)(void*);char review_sha256[65];
 uint32_t verification_kind; /* 1 = exact-linked-ELF-static */
 uint32_t cpp_unwind_target_accepted; /* remains 0 until actual acceptance */
};
int f3_coordinator_install_native_06(const struct F3CardRead05*,
 const struct F3LinkedContract06*,const Iq4JpegApi*,uint64_t render_arena_bytes);
int f3_coordinator_ready_06(void);
/* Short original catalog-mutex snapshot on the real UI thread. Lease is the
 * executor's actual reservation; it is never reacquired or released here.
 * Manual always retains the selected existing IIQ, regardless capture mode. */
int f3_coordinator_manual_prepare_06(uintptr_t actual_ifm,int32_t actual_index,
 const struct F3CoordinatorSettings06*,const struct F3ExecutorReservation01*,void**job);
/* SD callback, before original node retirement. Copies process-lifetime
 * constructor dependencies and immutable checked file provenance. Worker does
 * not dereference manager/node. The capture's real owners remain held until
 * executor invoke_saved ACK and the SD callback's normal returned cleanup. */
int f3_coordinator_saved_prepare_06(struct F3CapturedRaw01*,void**job);
/* Exact executor callback. Returns 1 on known successful output, 0 on known
 * stopped failure (all own source/file/render/card cleanup completed), -1 on
 * UNKNOWN. Saved borrowed capture owners are released by the SD caller only. */
int f3_coordinator_worker_run_06(void*,const struct F3ExecutorOwner01*);
/* Direct installation consumer for frozen capture01; actual fixed executor
 * enqueue_and_wait is called once, never a second native rendering thread. */
int f3_coordinator_saved_callback_06(void*,struct F3CapturedRaw01*);
int f3_coordinator_view_06(struct F3CoordinatorView06*);
#ifdef __cplusplus
}
#endif
#endif
