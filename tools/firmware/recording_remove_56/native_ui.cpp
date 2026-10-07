#include <stdint.h>
#include <stddef.h>
/* Shared JPEG menu ABI only: no recording page, frame subscription, thread,
 * encoder, card client, start/stop or movie resource is retained here.
 * Names preserve the already-frozen55 JPEG menus' four compatibility calls. */
#define CALL(body) try { body; return 1; } catch (...) {return 0;}
extern "C" int iq4_f4_menu_new_03(size_t n,void**p){CALL(*p=((void*(*)(size_t))(uintptr_t)0x409e60)(n));}
extern "C" int iq4_f4_menu_ctor_03(uintptr_t f,void*p){if(f!=0x4e5744&&f!=0x4e9d30)return 0;CALL(((void(*)(void*,uint32_t,void*,void*))f)(p,UINT32_MAX,nullptr,nullptr));}
extern "C" int iq4_f4_menu_append_03(void*p,void*i){CALL(((void(*)(void*,void*))(uintptr_t)0x4e58b8)(p,i));}
extern "C" int iq4_f4_native_current_02(uintptr_t *v){CALL(*v=(uintptr_t)((void *(*)())(uintptr_t)0x710b0c)());}
