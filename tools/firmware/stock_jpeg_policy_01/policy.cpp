#include "policy.h"
#include "pins.h"
#include "../f3_stock_jpeg_xqd_01/stock.h"
#include "../native_runtime_01/self_read.h"
#include <string.h>

static uintptr_t expected_event;

static int read(uintptr_t p,void*out,size_t n){
 return p>=4096&&n&&p<=UINTPTR_MAX-n&&
        iq4_native_self_read_01(nullptr,p,out,n)==1;
}
static int word(uintptr_t p,uintptr_t*out){
 uintptr_t again;return read(p,out,8)&&read(p,&again,8)&&*out==again;
}
static int event_identity(uintptr_t event){
 uintptr_t vt,getter,setter;
 return word(event,&vt)&&vt==0xbcaa68&&word(vt+0x40,&getter)&&
        getter==0x5e8c20&&word(vt+0x48,&setter)&&setter==0x5e8c54;
}
static int pins(){
 unsigned char bytes[64];
 for(const auto&p:StockJpegPolicyPins01){
  if(p.bytes>sizeof bytes||!read(p.va,bytes,p.bytes)||
     memcmp(bytes,p.data,p.bytes))return 0;
 }
 return 1;
}
extern "C" int iq4_stock_jpeg_policy_bind_01(uintptr_t sd){
 if(sd>UINTPTR_MAX-0x13f4||!iq4_stock_jpeg_bound_01()||!pins())return 0;
 uintptr_t vt;unsigned char flag;
 if(!word(sd,&vt)||vt!=0xbca228||!read(sd+0x13f3,&flag,1)||flag!=4||
    !event_identity(sd+0xe8))return 0;
 uintptr_t zero=0;
 return __atomic_compare_exchange_n(&expected_event,&zero,sd+0xe8,0,
          __ATOMIC_RELEASE,__ATOMIC_RELAXED)||zero==sd+0xe8;
}
extern "C" uintptr_t iq4_stock_jpeg_policy_set_01(uintptr_t event,uint32_t value,
                                                 uintptr_t factory_setter){
 /* The construction-time ownership proof is stable. Native card request
  * masks/ready fields vary during capture, so they must not decide whether
  * this independent XQD Mode can be overwritten by an SD-only policy.
  * A later core HOLD still prevents JPEG jobs; it does not grant this
  * observer ownership of the user's separately selected XQD Mode. */
 const uintptr_t own=__atomic_load_n(&expected_event,__ATOMIC_ACQUIRE);
 if(own&&event==own&&factory_setter==0x5e8c54&&value<=1&&
    iq4_stock_jpeg_destination_get_01()==11&&event_identity(event))return 0;
 /* Preserve the exact original virtual call, return and native unwind. */
 return ((uintptr_t(*)(uintptr_t,uint32_t))factory_setter)(event,value);
}
