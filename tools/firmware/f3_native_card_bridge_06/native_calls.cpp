#include "card.h"
/* Exact ordinary AAPCS64 member shapes, this explicit. Source original bodies
 * 8ca3ec/8ca888/8ca708 and full dynamic vtable are checked before any call. */
extern "C" uint32_t iq4_f3_register_client_05(void*,const char*);
extern "C" uint32_t iq4_f3_wait_request_05(void*,uint32_t,uint32_t);
extern "C" uint32_t iq4_f3_release_request_05(void*,uint32_t);
static F3CardOutcome05 reg(void*,uintptr_t p,const char*n,uint32_t*out){try{*out=iq4_f3_register_client_05(reinterpret_cast<void*>(p),n);return F3_CARD_OK;}catch(...){return F3_CARD_UNKNOWN;}}
static F3CardOutcome05 wait(void*,uintptr_t p,uint32_t id,uint32_t ms,uint32_t*out){try{*out=iq4_f3_wait_request_05(reinterpret_cast<void*>(p),id,ms);return F3_CARD_OK;}catch(...){return F3_CARD_UNKNOWN;}}
static F3CardOutcome05 release(void*,uintptr_t p,uint32_t id,uint32_t*out){try{*out=iq4_f3_release_request_05(reinterpret_cast<void*>(p),id);return F3_CARD_OK;}catch(...){return F3_CARD_UNKNOWN;}}
extern "C" void f3_card_native_calls_05(F3LeaseCalls05*out){*out={nullptr,reg,wait,release};}

extern "C" uint32_t iq4_f3_request_device_06(void*,uint32_t);
extern "C" void*iq4_f3_current_native_thread_06(void);
static uintptr_t current(void*){try{return reinterpret_cast<uintptr_t>(iq4_f3_current_native_thread_06());}catch(...){return 0;}}
static F3CardOutcome05 request(void*,uintptr_t p,uint32_t id,uint32_t*out){try{*out=iq4_f3_request_device_06(reinterpret_cast<void*>(p),id);return F3_CARD_OK;}catch(...){return F3_CARD_UNKNOWN;}}
extern "C" void f3_card_native_try_calls_06(F3TryCalls06*out){*out={nullptr,current,request};}
