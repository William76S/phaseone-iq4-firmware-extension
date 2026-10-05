#ifndef IQ4_F3_CORE_NATIVE_RECEIPT_01_H
#define IQ4_F3_CORE_NATIVE_RECEIPT_01_H
#include <stdint.h>
#include <stddef.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Receipt for the exact original Full/R0 core pass only. It is not a decoded
 * RAW provenance or PreviewProcess whole-pipeline receipt. Caller retains all
 * input/settings/pool/output/arena identities until matching end. */
typedef int(*Iq4CoreRead01)(void*,uintptr_t,void*,size_t);
enum Iq4CoreResult01 {IQ4_CORE_OK=0,IQ4_CORE_ARGUMENT=1,IQ4_CORE_BUSY=2,
 IQ4_CORE_FAILED=3,IQ4_CORE_HOLD=4,IQ4_CORE_UNBOUND=5};
typedef struct {uintptr_t settings,cancel,pool,output,arena_base;
 uint64_t arena_bytes;} Iq4CoreOwner01;
typedef struct {uint64_t generation,thread;uintptr_t frame,allocator;
 uint32_t joins,stages,core_returned,complete,held;} Iq4CoreView01;
int iq4_f3_core_begin_01(Iq4CoreRead01,void*,const Iq4CoreOwner01*,uint64_t*generation);
int iq4_f3_core_end_01(uint64_t generation,Iq4CoreView01*);
/* Called by the three exact AArch64 BL wrappers, never as user attestations.
 * args[0..7] and ninth[0] are saved original call arguments. */
void iq4_f3_core_before_01(const uintptr_t args[8],uintptr_t ninth,uintptr_t caller_pc);
void iq4_f3_core_after_01(void);
void iq4_f3_core_join_returned_01(uintptr_t original_frame,uintptr_t pool,uintptr_t caller_pc);
void iq4_f3_core_terminal_01(uintptr_t original_frame,uintptr_t caller_pc);
void iq4_f3_core_native_wrapper_01(void);
void iq4_f3_core_native_join_wrapper_01(void);
void iq4_f3_core_native_terminal_wrapper_01(void);
#ifdef __cplusplus
}
#endif
#endif
