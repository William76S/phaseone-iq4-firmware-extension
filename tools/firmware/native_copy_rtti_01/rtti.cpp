#include "rtti.h"
#include "rtti_pins.inc"
#include <string.h>
namespace {
bool address(uint32_t mode,uint64_t va,uintptr_t base,uintptr_t&out){
 if(mode>1||va>UINTPTR_MAX)return false;
 if(mode&&va>UINTPTR_MAX-base)return false;
 out=uintptr_t(va)+(mode?base:0);return out!=0;
}
bool read_twice(void*ctx,int(*read)(void*,uintptr_t,void*,size_t),uintptr_t p,void*out,size_t n){
 unsigned char second[512];return p&&n&&n<=sizeof second&&p<=UINTPTR_MAX-n&&
 read(ctx,p,out,n)==1&&read(ctx,p,second,n)==1&&!memcmp(out,second,n);
}
}
extern "C" int iq4_native_copy_rtti_current_01(void*ctx,int(*read)(void*,uintptr_t,void*,size_t)){
 if(!read)return 0;uintptr_t anchor=0;
 if(!read_twice(ctx,read,UINT64_C(0xf429d8),&anchor,8)||anchor<=UINT64_C(0x8ee38))return 0;
 uintptr_t base=anchor-UINT64_C(0x8ee38);
 /* Actual original ELF PT_LOAD p_align is64KiB; no truncated or tagged pointer. */
 if(base&UINT64_C(0xffff))return 0;
 unsigned char expected[512],actual[512];
 for(const auto&span:RttiSpans01){
  uintptr_t at=0;if(!address(span.mode,span.address,base,at)||span.bytes>sizeof expected||at>UINTPTR_MAX-span.bytes)return 0;
  memcpy(expected,span.data,span.bytes);
  for(uint32_t i=0;i<span.count;++i){const auto&r=span.relocs[i];uintptr_t p=0;
   if(r.offset>span.bytes||span.bytes-r.offset<8||!address(r.mode,r.address,base,p))return 0;
   if(r.addend>=0){if(uint64_t(r.addend)>UINTPTR_MAX-p)return 0;p+=uintptr_t(r.addend);}
   else{uint64_t magnitude=uint64_t(-(r.addend+1))+1;if(magnitude>=p)return 0;p-=uintptr_t(magnitude);}
   memcpy(expected+r.offset,&p,8);
  }
  if(!read_twice(ctx,read,at,actual,span.bytes)||memcmp(actual,expected,span.bytes))return 0;
 }
 uintptr_t final_anchor=0;return read_twice(ctx,read,UINT64_C(0xf429d8),&final_anchor,8)&&final_anchor==anchor?1:0;
}
