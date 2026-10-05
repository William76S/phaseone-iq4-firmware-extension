#include "../f3_save_coordinator_06/coordinator.h"
#include "../f3_native_jpeg8_binding_01/native_jpeg82.h"
#include "../native_linked_contract_01/contract.h"
#include "../native_copy_rtti_01/rtti.h"
#include "../native_runtime_01/self_read.h"
#include <string.h>
extern void iq4_f1_menu_initialize_04(void);
static struct Iq4LinkedContractRead01 linked_reader={0,iq4_native_self_read_01};
static uint32_t installation_state;
static int jpeg_read(void*c,uintptr_t p,uint8_t*out,size_t n){return iq4_native_self_read_01(c,p,out,n);}
int iq4_extensions_contract_current_01(void*v){
 struct Iq4LinkedContractRead01*r=v;
 return r&&iq4_linked_contract_current_01(r)==1&&
  iq4_native_copy_rtti_current_01(r->context,r->read)==1;
}
/* Registers real functions after the current sealed mapping and native JPEG
 * bytes passed. No Card/TLS/Reader/pool/arena creation here. Those are lazy on
 * the actual original native UI or IFM BackgroundThread. */
void iq4_extensions_initialize_01(void){
 uint32_t idle=0;
 if(__atomic_compare_exchange_n(&installation_state,&idle,1,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE)){
  static const uint8_t baseline[32]={0x9b,0x61,0x1e,0xfe,0x64,0x06,0x76,0x85,0xb7,0x70,0xba,0x39,0x84,0xae,0x95,0x16,
   0x84,0xc5,0xa4,0x01,0xf7,0x3f,0x77,0xa0,0x3b,0x31,0x6b,0xe3,0x74,0x03,0x2c,0xdb};
  Iq4JpegApi codec;struct F3LinkedContract06 proof;memset(&codec,0,sizeof codec);memset(&proof,0,sizeof proof);
  struct F3CardRead05 memory={0,iq4_native_self_read_01};
  int result=iq4_extensions_contract_current_01(&linked_reader)==1;
  if(result){
   proof.context=&linked_reader;proof.verify_current_linked_elf=iq4_extensions_contract_current_01;
   result=iq4_native_self_read_01(0,(uintptr_t)iq4_linked_contract_seal_01+32,proof.review_sha256,65)==1;
   proof.verification_kind=1;proof.cpp_unwind_target_accepted=0;
  }
  if(result)result=iq4_native_jpeg82_bind_01(baseline,jpeg_read,0,&codec)==IQ4_JPEG82_BOUND_STATIC_ABI_01;
  if(result)result=f3_coordinator_install_native_06(&memory,&proof,&codec,UINT64_C(3221225472))==1;
  __atomic_store_n(&installation_state,result?2u:3u,__ATOMIC_RELEASE);
 }
 iq4_f1_menu_initialize_04();
}
