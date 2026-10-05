#include "contract.h"
#include "../f3_stream_transaction_02/sha256.h"
#include <string.h>
#if defined(__ELF__)
#define IQ4_CONTRACT_SECTION01 __attribute__((section(".rodata.iq4_linked_contract_seal_01")))
#else
#define IQ4_CONTRACT_SECTION01
#endif
const uint8_t iq4_linked_contract_seal_01[IQ4_LINKED_CONTRACT_BYTES01]
 __attribute__((used,aligned(16))) IQ4_CONTRACT_SECTION01={0};
static uint32_t u32(const uint8_t*p){uint32_t v;memcpy(&v,p,4);return v;}
static uint64_t u64(const uint8_t*p){uint64_t v;memcpy(&v,p,8);return v;}
static int exact(struct Iq4LinkedContractRead01*r,uintptr_t p,void*out,size_t n){
 return r&&r->read&&n&&n<=4096&&p<=UINTPTR_MAX-n&&r->read(r->context,p,out,n)==1;
}
static int digest(const char hex[65],const uint8_t raw[32]){
 static const char digits[]="0123456789abcdef";
 for(unsigned i=0;i<32;++i)if(hex[2*i]!=digits[raw[i]>>4]||hex[2*i+1]!=digits[raw[i]&15])return 0;
 return hex[64]==0;
}
int iq4_linked_contract_current_01(void*v){
 struct Iq4LinkedContractRead01*r=v;uint8_t header[128],again[128],region[48],scratch[4096];
 uintptr_t seal=(uintptr_t)iq4_linked_contract_seal_01;
 if(!exact(r,seal,header,sizeof(header))||memcmp(header,"IQ4LC01",8)||u32(header+8)!=1||
 u32(header+16)!=1||u32(header+20)!=0||header[96]!=0)return 0;
 uint32_t count=u32(header+12);uint64_t total=u64(header+24),seen=0,last=0;
 if(!count||count>2048||total>32u*1024u*1024u||128u+48u*count>IQ4_LINKED_CONTRACT_BYTES01)return 0;
 for(unsigned i=32;i<96;++i)if(!((header[i]>='0'&&header[i]<='9')||(header[i]>='a'&&header[i]<='f')))return 0;
 for(unsigned i=97;i<128;++i)if(header[i])return 0;
 for(uint32_t i=0;i<count;++i){
  if(!exact(r,seal+128u+48u*i,region,sizeof(region)))return 0;
  uint64_t p=u64(region),n=u64(region+8);
  if(!n||n>total||p<0x400000||p>0x10000000-n||p<last||
   (p<seal+IQ4_LINKED_CONTRACT_BYTES01&&seal<p+n)||seen>total-n)return 0;
  F4Sha hash;char hex[65];f4_sha_init(&hash);
  for(uint64_t off=0;off<n;){size_t take=n-off<sizeof(scratch)?(size_t)(n-off):sizeof(scratch);
   if(!exact(r,(uintptr_t)(p+off),scratch,take))return 0;
   f4_sha_update(&hash,scratch,take);off+=take;
  }
  f4_sha_end(&hash,hex);if(!digest(hex,region+16))return 0;
  seen+=n;last=p+n;
 }
 return seen==total&&exact(r,seal,again,sizeof(again))&&!memcmp(header,again,sizeof(header));
}
