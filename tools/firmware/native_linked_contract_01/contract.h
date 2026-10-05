#ifndef IQ4_NATIVE_LINKED_CONTRACT_01_H
#define IQ4_NATIVE_LINKED_CONTRACT_01_H
#include <stddef.h>
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
#define IQ4_LINKED_CONTRACT_BYTES01 131072u
struct Iq4LinkedContractRead01 {
 void *context;
 int (*read)(void *,uintptr_t,void *,size_t);
};
extern const uint8_t iq4_linked_contract_seal_01[IQ4_LINKED_CONTRACT_BYTES01];
/* Rehashes the actual linked RX/RO regions, FDE/LSDA, hook and import proof
 * windows frozen after the final ELF static review. No synthetic success path;
 * a blank/unsealed candidate is rejected. No target unwind acceptance claim. */
int iq4_linked_contract_current_01(void *reader);
#ifdef __cplusplus
}
#endif
#endif
