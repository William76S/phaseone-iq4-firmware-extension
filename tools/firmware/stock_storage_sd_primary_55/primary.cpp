#include <stdint.h>
#include <stddef.h>
#include <string.h>
#include "../native_runtime_01/self_read.h"
#include "pins.h"
extern "C" int iq4_stock_storage_normalize_idle_55(void);
#ifdef IQ4_SD_PRIMARY_TEST55
extern "C" uintptr_t iq4_sd_primary_test_call55(uintptr_t,uintptr_t,uintptr_t);
#endif
static uintptr_t call55(uintptr_t p,uintptr_t a,uintptr_t b=0){
#ifdef IQ4_SD_PRIMARY_TEST55
 return iq4_sd_primary_test_call55(p,a,b);
#else
 return ((uintptr_t(*)(uintptr_t,uintptr_t))p)(a,b);
#endif
}
static int read55(uintptr_t p,void*out,size_t n){unsigned char twice[8];return p>=4096&&n<=8&&p<=UINTPTR_MAX-n&&iq4_native_self_read_01(nullptr,p,out,n)==1&&iq4_native_self_read_01(nullptr,p,twice,n)==1&&!memcmp(out,twice,n);}
static int group55(uintptr_t p,uint8_t flag){uintptr_t v;uint8_t f;return read55(p,&v,8)&&v==0xbca228&&read55(p+0x13f3,&f,1)&&f==flag;}
static int pins55(){unsigned char a[16],b[16];for(const auto&p:primary_pins_55)if(iq4_native_self_read_01(nullptr,p.address,a,p.count)!=1||iq4_native_self_read_01(nullptr,p.address,b,p.count)!=1||memcmp(a,b,p.count)||memcmp(a,p.bytes,p.count))return 0;return 1;}
static int view55(uintptr_t vm,uintptr_t sd,uintptr_t xqd){uintptr_t v,a,b;return group55(sd,4)&&group55(xqd,2)&&read55(vm,&v,8)&&v==0xbbd068&&read55(vm+0x1c8,&a,8)&&a==sd+8&&read55(vm+0x1c0,&b,8)&&b==xqd+8;}
extern "C" int iq4_stock_storage_normalize_sd_55(uintptr_t vm,uintptr_t sd,uintptr_t xqd){
 try{
  if(!pins55()||!view55(vm,sd,xqd))return 0;
  const uintptr_t sp=call55(0x41497c,sd+0x468),xp=call55(0x41497c,xqd+0x468);
  if(sp>1||xp>1)return 0;if(sp!=1||xp!=0)return 1;
  uintptr_t mode=call55(0x495448,vm+0x1d8);if(mode>5)return 0;
  if(mode!=5)call55(0x5b66bc,vm+0x1d8,5);
  /* The original Primary observer sets XQD raw mode0 and SD raw mode2,
   * not mode1. Mode2 still performs the factory present/free-space checks. */
  return view55(vm,sd,xqd)&&call55(0x41497c,sd+0x468)==1&&
   call55(0x41497c,xqd+0x468)==0&&call55(0x495448,vm+0x1d8)==5&&
   call55(0x55b500,sd+8)==2&&call55(0x55b500,xqd+8)==0;
 }catch(...){return 0;}
}
extern "C" void iq4_stock_storage_after_policy_55(uintptr_t observer){
 try{uintptr_t vm,sd_event,xqd_event;
  if(!iq4_stock_storage_normalize_idle_55()||!read55(observer+0x18,&vm,8)||
   !read55(vm+0x1c8,&sd_event,8)||sd_event<8||
   !read55(vm+0x1c0,&xqd_event,8)||xqd_event<8)return;
  (void)iq4_stock_storage_normalize_sd_55(vm,sd_event-8,xqd_event-8);
 }catch(...){return;}
}
