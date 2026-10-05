#include "contract.h"
#include "../f3_stream_transaction_02/sha256.h"
#include <assert.h>
#include <string.h>
#include <stdio.h>
static uint8_t seal[IQ4_LINKED_CONTRACT_BYTES01],image[8193];
static int bad_read;
static int read_mock(void*c,uintptr_t p,void*out,size_t n){
 (void)c;if(bad_read)return 2;
 uintptr_t base=(uintptr_t)iq4_linked_contract_seal_01;
 if(n<=sizeof(seal)&&p>=base&&p-base<=sizeof(seal)-n){memcpy(out,seal+(p-base),n);return 1;}
 if(n<=sizeof(image)&&p>=0x500000&&p-0x500000<=sizeof(image)-n){memcpy(out,image+(p-0x500000),n);return 1;}
 return 0;
}
static void put32(size_t at,uint32_t v){memcpy(seal+at,&v,4);}
static void put64(size_t at,uint64_t v){memcpy(seal+at,&v,8);}
static void fixture(void){
 memset(seal,0,sizeof(seal));for(unsigned i=0;i<sizeof(image);++i)image[i]=(uint8_t)(i*17u+3u);
 memcpy(seal,"IQ4LC01",8);put32(8,1);put32(12,1);put32(16,1);put64(24,sizeof(image));memset(seal+32,'a',64);
 put64(128,0x500000);put64(136,sizeof(image));F4Sha h;char hex[65];f4_sha_init(&h);f4_sha_update(&h,image,sizeof(image));f4_sha_end(&h,hex);
 for(unsigned i=0;i<32;++i){unsigned a=(unsigned)(hex[2*i]<='9'?hex[2*i]-'0':hex[2*i]-'a'+10);
  unsigned b=(unsigned)(hex[2*i+1]<='9'?hex[2*i+1]-'0':hex[2*i+1]-'a'+10);seal[144+i]=(uint8_t)((a<<4)|b);}
}
int main(void){
 struct Iq4LinkedContractRead01 r={0,read_mock};unsigned checks=0;
 assert(!iq4_linked_contract_current_01(&r));++checks;
 fixture();assert(iq4_linked_contract_current_01(&r));++checks;
 image[8192]^=1;assert(!iq4_linked_contract_current_01(&r));++checks;image[8192]^=1;
 seal[144]^=1;assert(!iq4_linked_contract_current_01(&r));++checks;seal[144]^=1;
 put32(20,1);assert(!iq4_linked_contract_current_01(&r));++checks;put32(20,0);
 put32(12,2049);assert(!iq4_linked_contract_current_01(&r));++checks;put32(12,1);
 put64(128,0x10000000);assert(!iq4_linked_contract_current_01(&r));++checks;put64(128,0x500000);
 bad_read=1;assert(!iq4_linked_contract_current_01(&r));++checks;bad_read=0;
 seal[96]='a';assert(!iq4_linked_contract_current_01(&r));++checks;seal[96]=0;
 put64(24,sizeof(image)+1);assert(!iq4_linked_contract_current_01(&r));++checks;
 printf("%u actual host manifest/byte/failure checks; no target execution\n",checks);return 0;
}
