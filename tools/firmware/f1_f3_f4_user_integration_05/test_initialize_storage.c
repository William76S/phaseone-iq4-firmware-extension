#include "initialize_storage_03.c"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
static unsigned fail_stage,seen[6],f1_calls;
const uint8_t iq4_linked_contract_seal_01[IQ4_LINKED_CONTRACT_BYTES01]={0};
int iq4_linked_contract_current_01(void*r){assert(r==&linked_reader);++seen[0];return fail_stage!=10;}
int iq4_native_copy_rtti_current_01(void*c,int(*r)(void*,uintptr_t,void*,size_t)){assert(!c&&r==iq4_native_self_read_01);++seen[1];return fail_stage!=20;}
int iq4_native_self_read_01(void*c,uintptr_t p,void*b,size_t n){assert(!c&&p==(uintptr_t)iq4_linked_contract_seal_01+32&&n==65);++seen[2];memset(b,'a',64);((char*)b)[64]=0;return fail_stage!=30;}
Iq4Jpeg82BindStatus01 iq4_native_jpeg82_bind_01(const uint8_t*s,Iq4Jpeg82ReadExact01 r,void*c,Iq4JpegApi*out){assert(s&&s[0]==0x9b&&r==jpeg_read&&!c&&out);++seen[3];return fail_stage==40?IQ4_JPEG82_CODE_MISMATCH_01:IQ4_JPEG82_BOUND_STATIC_ABI_01;}
int f3_coordinator_install_native_06(const struct F3CardRead05*r,const struct F3LinkedContract06*p,const Iq4JpegApi*c,uint64_t n){assert(r->read==iq4_native_self_read_01&&p->verify_current_linked_elf==iq4_extensions_contract_current_01&&p->context==&linked_reader&&p->verification_kind==1&&!p->cpp_unwind_target_accepted&&c&&n==UINT64_C(3221225472));assert(p->review_sha256[64]==0);++seen[5];return fail_stage!=50;}
int iq4_f3_native_storage_mutex_initialize_01(void){++seen[4];return fail_stage!=45;}
void iq4_f1_menu_initialize_04(void){++f1_calls;}
int main(int argc,char**argv){assert(argc==2);fail_stage=(unsigned)strtoul(argv[1],0,10);assert(!fail_stage||fail_stage==45||(fail_stage>=10&&fail_stage<=50&&!(fail_stage%10)));const unsigned stages[6]={10,20,30,40,45,50};iq4_extensions_initialize_01();assert(f1_calls==1&&installation_state==(fail_stage?3:2));assert(iq4_extensions_installation_error_02()==fail_stage&&iq4_extensions_installation_stage_02()==(fail_stage?fail_stage:100));for(unsigned i=0;i<6;++i)assert(seen[i]==(!fail_stage||stages[i]<=fail_stage));iq4_extensions_initialize_01();assert(f1_calls==2);for(unsigned i=0;i<6;++i)assert(seen[i]==(!fail_stage||stages[i]<=fail_stage));puts("PASS init failure attribution, downstream refusal, F1 preserved, no retry");}
