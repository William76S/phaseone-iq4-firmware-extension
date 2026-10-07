#ifndef IQ4_NATIVE_HALF_01_H
#define IQ4_NATIVE_HALF_01_H
#include <stddef.h>
#include <stdint.h>
#include "../f3_stock_half_export_01/sink.h"
#ifdef __cplusplus
extern "C" {
#endif
/* These pointers belong to the active native processing-worker frame. None is
 * retained after this bridge call. node is the catalogNode held by the original
 * queue request+0x58 (worker frame+0x458), not its RawReader at+0x38/+0x438. */
typedef struct Iq4HalfScope01 {
 uintptr_t worker, generator, raw_input, settings, pool, cancel, node;
 int32_t photo_index;
 uint32_t full_width,full_height;
} Iq4HalfScope01;
typedef enum Iq4HalfRenderStatus01 {
 IQ4_HALF_RENDER_OK_01=0,IQ4_HALF_RENDER_ARGUMENT_01,
 IQ4_HALF_RENDER_UNBOUND_01,IQ4_HALF_RENDER_CANCELLED_01,
 IQ4_HALF_RENDER_INCOMPLETE_01,IQ4_HALF_RENDER_PLANE_01,
 IQ4_HALF_RENDER_SINK_01,IQ4_HALF_RENDER_EXCEPTION_01
} Iq4HalfRenderStatus01;
typedef struct Iq4HalfRenderReceipt01 {
 Iq4HalfRenderStatus01 status;
 uint32_t entered,stages,joins,terminal,render_returned,settings_restored;
 uint32_t width,height,stride,format;
 uint64_t native_buffer_bytes;
} Iq4HalfRenderReceipt01;
typedef struct Iq4HalfLease01 {
 void *context;
 /* claim:1 matching lease;0 finite cancel;-1 unknown. Called on the native
  * processing-worker thread, must not depend on the JPEG-writer thread ID. */
 int (*guard)(void *,const Iq4HalfScope01 *);
 /* This is synchronous. A return of any kind retires ALL borrowed row reads;
  * it must not retain/resume an encoder that can read the plane later. */
 int (*encode)(void *,const Iq4HalfScope01 *,const Iq4HalfArgb01 *,const Iq4HalfRenderReceipt01 *);
 void (*finish)(void *,const Iq4HalfScope01 *,const Iq4HalfRenderReceipt01 *);
} Iq4HalfLease01;
/* Implemented by owning original JPEG transaction. 1 acquires one matching
 * worker+index+node lease;0 declines without side effects. No global flag-only
 * match and no publication from this processing thread. */
int iq4_stock_half_acquire_01(const Iq4HalfScope01 *,Iq4HalfLease01 *);
uint32_t iq4_half_preview_on_worker_01(const uintptr_t arguments[7],uintptr_t original_caller_sp);
void iq4_half_join_observed_01(uintptr_t original_core_frame,uintptr_t pool,uintptr_t return_pc);
void iq4_half_terminal_observed_01(uintptr_t original_core_frame,uintptr_t return_pc);
void iq4_half_preview_wrapper_01(void);
void iq4_half_join_wrapper_01(void);
void iq4_half_terminal_wrapper_01(void);
#ifdef __cplusplus
}
#endif
#endif
