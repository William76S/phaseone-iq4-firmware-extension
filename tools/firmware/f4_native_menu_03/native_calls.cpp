#include "native_calls.h"
#define CALL(body) try { body; return 1; } catch (...) {return 0;}
extern "C" int iq4_f4_menu_new_03(size_t n,void**p){CALL(*p=((void*(*)(size_t))(uintptr_t)0x409e60)(n));}
extern "C" int iq4_f4_menu_ctor_03(uintptr_t f,void*p){if(f!=0x4e5744&&f!=0x4e9d30)return 0;CALL(((void(*)(void*,uint32_t,void*,void*))f)(p,UINT32_MAX,nullptr,nullptr));}
extern "C" int iq4_f4_menu_append_03(void*p,void*i){CALL(((void(*)(void*,void*))(uintptr_t)0x4e58b8)(p,i));}
extern "C" int iq4_f4_menu_close_03(void*p){CALL(((void(*)(void*))(uintptr_t)0x4e1320)(p));}
#if defined(IQ4_F4_MENU_POP_SYNTHETIC_HOST)
extern "C" bool iq4_f4_synthetic_stock_pop_03(void*);
static bool stock_pop(void*p){return iq4_f4_synthetic_stock_pop_03(p);}
#else
static bool stock_pop(void*p){return ((bool(*)(void*))(uintptr_t)0x4e7ca4)(p);}
#endif
extern "C" int iq4_f4_menu_pop_03(void*p,int*r){CALL(*r=stock_pop(p)?1:0);}
extern "C" int iq4_f4_menu_pop_passthrough_03(void*p){return stock_pop(p)?1:0;}
