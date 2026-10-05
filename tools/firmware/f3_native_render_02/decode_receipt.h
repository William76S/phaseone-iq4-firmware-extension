#ifndef IQ4_F3_DECODE_RECEIPT_02_H
#define IQ4_F3_DECODE_RECEIPT_02_H
#include <stdint.h>
#include <stddef.h>
#ifdef __cplusplus
extern "C" {
#endif
typedef int (*Iq4DecodeRead02)(void*,uintptr_t,void*,size_t);
enum Iq4DecodeResult02 { IQ4_DECODE_OK=0, IQ4_DECODE_ARGUMENT=1, IQ4_DECODE_BUSY=2,
 IQ4_DECODE_UNBOUND=3, IQ4_DECODE_INCOMPLETE=4, IQ4_DECODE_HOLD=5 };
typedef struct {
 uintptr_t pool,payload,rows,decoded,cancel;
 uint64_t payload_allocation_bytes,decoded_allocation_bytes;
 uint32_t payload_bytes,total_width,total_height,left,top,valid_width,valid_height;
 uint8_t* row_states; size_t row_states_bytes;
} Iq4DecodeOwner02;
typedef struct {uint64_t generation;uint32_t entered,returned,rows_returned,joins,complete,held;} Iq4DecodeView02;
/* Physical read ceiling for exact pinned codec8/16bit, NOT an encoded-row
 * validity proof. Caller holds a distinct padded payload reservation whose
 * first payload_bytes exactly match the saved source; padding is not file data. */
int iq4_f3_codec8_read_ceiling_02(uint32_t width,uint64_t*bytes);
int iq4_f3_decode_begin_02(Iq4DecodeRead02,void*,const Iq4DecodeOwner02*,uint64_t*);
int iq4_f3_decode_end_02(uint64_t,Iq4DecodeView02*);
int iq4_f3_decode_abort_joined_02(uint64_t);
/* Exact wrappers only. Host tests model event delivery and execute no decoder. */
/* sp is the actual SP at the native-reader BL inside the wrapper. */
void iq4_f3_decode_reader_before_02(const uintptr_t args[9],const uintptr_t stack[10],uintptr_t sp,uintptr_t pc);
void iq4_f3_decode_reader_after_02(uintptr_t pc);
void iq4_f3_decode_row_before_02(const uintptr_t args[4],uintptr_t job,uintptr_t index,uintptr_t pc);
void iq4_f3_decode_row_after_02(const uintptr_t args[4],uintptr_t job,uintptr_t index,uintptr_t pc);
void iq4_f3_decode_join_after_02(uintptr_t frame,uintptr_t pool,uintptr_t pc);
void iq4_f3_decode_native_reader_wrapper_02(void);
void iq4_f3_decode_native_row_wrapper_02(void);
void iq4_f3_decode_native_join_wrapper_02(void);
#ifdef __cplusplus
}
#endif
#endif
