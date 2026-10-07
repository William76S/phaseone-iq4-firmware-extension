#include <stdint.h>
#include <stddef.h>
#include <string.h>
#include <assert.h>
#include <stdio.h>
#include <initializer_list>
#include "pins.h"
extern "C" int iq4_stock_storage_normalize_sd_55(uintptr_t,uintptr_t,uintptr_t);
extern "C" void iq4_stock_storage_after_policy_55(uintptr_t);
static unsigned char vm[0x400],sd[0x1400],xqd[0x1400],observer[0x40];
static unsigned presentSD,presentXQD,mode,sdMode,xqdMode,writes,idle=1,defer;
static void put(uintptr_t p,uintptr_t v){memcpy((void*)p,&v,8);}
extern "C" int iq4_native_self_read_01(void*,uintptr_t p,void*out,size_t n){
 for(const auto&pin:primary_pins_55)if(p==pin.address&&n==pin.count){memcpy(out,pin.bytes,n);return 1;}
 for(auto b:{vm,sd,xqd,observer}){size_t cap=b==vm?sizeof vm:b==observer?sizeof observer:sizeof sd;if(p>=(uintptr_t)b&&p+n<=(uintptr_t)b+cap){memcpy(out,(void*)p,n);return 1;}}return 0;}
extern "C" int iq4_stock_storage_normalize_idle_55(){return idle;}
extern "C" uintptr_t iq4_sd_primary_test_call55(uintptr_t p,uintptr_t a,uintptr_t b){if(p==0x41497c)return a==(uintptr_t)sd+0x468?presentSD:presentXQD;
 if(p==0x495448){assert(a==(uintptr_t)vm+0x1d8);return mode;}
 if(p==0x5b66bc){assert(a==(uintptr_t)vm+0x1d8&&b==5);++writes;mode=5;if(!defer){sdMode=2;xqdMode=0;}return 0;}
 if(p==0x55b500)return a==(uintptr_t)sd+8?sdMode:xqdMode;assert(false);return 0;}
static void reset(){memset(vm,0,sizeof vm);memset(sd,0,sizeof sd);memset(xqd,0,sizeof xqd);memset(observer,0,sizeof observer);put((uintptr_t)vm,0xbbd068);put((uintptr_t)sd,0xbca228);put((uintptr_t)xqd,0xbca228);sd[0x13f3]=4;xqd[0x13f3]=2;put((uintptr_t)vm+0x1c8,(uintptr_t)sd+8);put((uintptr_t)vm+0x1c0,(uintptr_t)xqd+8);put((uintptr_t)observer+0x18,(uintptr_t)vm);presentSD=1;presentXQD=0;mode=sdMode=0;xqdMode=2;writes=defer=0;idle=1;}
int main(){reset();assert(iq4_stock_storage_normalize_sd_55((uintptr_t)vm,(uintptr_t)sd,(uintptr_t)xqd)==1&&writes==1&&mode==5&&sdMode==2&&xqdMode==0);
 assert(iq4_stock_storage_normalize_sd_55((uintptr_t)vm,(uintptr_t)sd,(uintptr_t)xqd)==1&&writes==1);
 reset();presentXQD=1;assert(iq4_stock_storage_normalize_sd_55((uintptr_t)vm,(uintptr_t)sd,(uintptr_t)xqd)==1&&!writes&&mode==0);
 reset();presentSD=0;assert(iq4_stock_storage_normalize_sd_55((uintptr_t)vm,(uintptr_t)sd,(uintptr_t)xqd)==1&&!writes);
 reset();presentSD=2;assert(!iq4_stock_storage_normalize_sd_55((uintptr_t)vm,(uintptr_t)sd,(uintptr_t)xqd)&&!writes);
 reset();mode=6;assert(!iq4_stock_storage_normalize_sd_55((uintptr_t)vm,(uintptr_t)sd,(uintptr_t)xqd)&&!writes);
 reset();sd[0x13f3]=2;assert(!iq4_stock_storage_normalize_sd_55((uintptr_t)vm,(uintptr_t)sd,(uintptr_t)xqd)&&!writes);
 reset();defer=1;assert(!iq4_stock_storage_normalize_sd_55((uintptr_t)vm,(uintptr_t)sd,(uintptr_t)xqd)&&writes==1&&mode==5);sdMode=2;xqdMode=0;assert(iq4_stock_storage_normalize_sd_55((uintptr_t)vm,(uintptr_t)sd,(uintptr_t)xqd)==1&&writes==1);
 reset();idle=0;iq4_stock_storage_after_policy_55((uintptr_t)observer);assert(!writes);idle=1;iq4_stock_storage_after_policy_55((uintptr_t)observer);assert(writes==1&&mode==5);
 puts("PASS 9 SD-only native Primary intent cases; factory calls are explicit host fixtures");}
