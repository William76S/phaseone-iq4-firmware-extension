#define IQ4_F3_STORAGE_BRIDGE_SYNTHETIC_HOST
#include "native_calls.cpp"
#include <cassert>
#include <cstdio>
static unsigned calls,throws,stage=50;
extern "C" uint32_t iq4_extensions_installation_stage_02(void){return stage;}
uint32_t iq4_fixture_legacy_get(void*p){assert(p==(void*)0x987600);++calls;if(throws==3)throw 3;return 2;}
void iq4_fixture_storage_set(void*p,uint32_t v){assert(p==(void*)0x123400&&v==2);++calls;if(throws==1)throw 1;}
uint32_t iq4_fixture_storage_get(void*p){assert(p==(void*)0x123400);++calls;if(throws==2)throw 2;return 2;}
int main(){uint32_t out=0xdead;
 assert(!iq4_f3_native_storage_write_read_01(0,2,&out)&&!calls&&out==0xdead);
 assert(!iq4_f3_native_storage_write_read_01(0x123400,3,&out)&&!calls&&out==0xdead);
 throws=1;assert(!iq4_f3_native_storage_write_read_01(0x123400,2,&out)&&calls==1&&out==0xdead);
 throws=2;calls=0;assert(!iq4_f3_native_storage_write_read_01(0x123400,2,&out)&&calls==2&&out==0xdead);
 throws=0;calls=0;assert(iq4_f3_native_storage_write_read_01(0x123400,2,&out)&&calls==2&&out==2);
 calls=0;stage=100;throws=3;assert(iq4_f3_legacy_jpeg_disabled_01((void*)0x987600)==0&&!calls);
 stage=50;throws=0;assert(iq4_f3_legacy_jpeg_disabled_01((void*)0x987600)==2&&calls==1);
 throws=3;try{(void)iq4_f3_legacy_jpeg_disabled_01((void*)0x987600);assert(false);}catch(int n){assert(n==3&&calls==2);}
 stage=0;throws=0;calls=0;assert(iq4_f3_legacy_jpeg_disabled_01((void*)0x987600)==2&&calls==1);
 puts("PASS 9 native exception/order and immutable installation fallback cases");}
