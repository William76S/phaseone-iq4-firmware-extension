#include "bridge.h"
#include "../f3_capture_menu_06/policy.h"
#include "../native_activity_01/activity.h"
#include "../f4_native_menu_03/native_calls.h"
#include "../f4_native_source_02/native_calls.h"
#include "../native_runtime_01/self_read.h"
#include "pins.h"
#include <string.h>
extern int iq4_f3_native_storage_write_read_01(uintptr_t,uint32_t,uint32_t*);
extern unsigned f3_capture_backend_capabilities_03(void);
extern int f3_coordinator_ready_06(void);
extern uint32_t iq4_extensions_installation_stage_02(void);
static uintptr_t native_events[2],storage_dto,queue,manager,parent;
static uint32_t override_mask,inhibit_mask,held,building,original_modes[2],saved_modes;
extern int iq4_f3_storage_mutex_ready_01(void);
extern int iq4_f3_storage_mutex_lock_01(void);
extern int iq4_f3_storage_mutex_unlock_01(void);
extern void iq4_f3_storage_ui_set_return_01(void);
static void *sd_menu,*leaves[3],*saved_original;
static uintptr_t menu_table[24],leaf_table[22];
static const char*const names[3]={"RAW","JPEG","RAW + JPEG"};
static const uint32_t modes[3]={F3_RAW,F3_JPEG_ONLY,F3_RAW_JPEG};
static int rd(uintptr_t p,void*b,size_t n){return p>=4096&&n&&n<=4096&&p<=UINTPTR_MAX-n&&iq4_native_self_read_01(0,p,b,n)==1;}
static int word(uintptr_t p,uintptr_t*v){uintptr_t other;return rd(p,v,8)&&rd(p,&other,8)&&*v==other;}
static int scalar(uintptr_t p,uint32_t*v){uint32_t other;return rd(p,v,4)&&rd(p,&other,4)&&*v==other;}
static int pins(void){unsigned char b[64];for(unsigned i=0;i<sizeof BridgePins01/sizeof*BridgePins01;++i){const struct BridgePin01*p=BridgePins01+i;for(size_t j=0;j<p->bytes;j+=sizeof b){size_t n=p->bytes-j;if(n>sizeof b)n=sizeof b;if(!rd(p->va+j,b,n)||memcmp(b,p->data+j,n))return 0;}}return 1;}
static int on_ui(void){uintptr_t q,v,m,back;return queue&&iq4_f4_native_current_02(&q)&&q==queue&&word(q,&v)&&v==0xb91f48&&word(q+0x1c8,&m)&&m==manager&&word(m,&v)&&v==0xb8f358&&word(m+8,&back)&&back==q;}
static int event_shape(uintptr_t p,uint8_t flag){uintptr_t v;uint8_t f,a;return p>=4096+8&&!(p&7)&&word(p,&v)&&v==0xbcac08&&word(p-8,&v)&&v==0xbca228&&rd(p-8+0x13f3,&f,1)&&rd(p-8+0x13f3,&a,1)&&f==a&&f==flag;}
static int identities(void){uintptr_t v,xqd,sd;return storage_dto&&word(storage_dto,&v)&&v==0xbbf0b8&&word(storage_dto+0x108,&v)&&v==0xbbf8a8&&word(storage_dto+0x208,&v)&&v==0xbbf8a8&&word(storage_dto+0x110,&xqd)&&word(storage_dto+0x210,&sd)&&xqd==native_events[1]&&sd==native_events[0]&&xqd!=sd&&event_shape(sd,4)&&event_shape(xqd,2);}
int iq4_f3_native_storage_bound_01(void){return !__atomic_load_n(&held,__ATOMIC_ACQUIRE)&&identities();}
uint32_t iq4_f3_native_storage_override_mask_01(void){return __atomic_load_n(&override_mask,__ATOMIC_ACQUIRE);}
/* The paired assembly hooks bracket only the original load/compare/store.
 * The original 40c310 RAII is a NullLock; our real pthread mutex supplies this
 * serialization. It is released before any original notification/callback. */
uint64_t iq4_f3_storage_enter_01(uintptr_t event,uint32_t mode,uintptr_t pc,uint32_t silent){
 unsigned card=2;for(unsigned i=0;i<2;++i)if(event&&event==__atomic_load_n(native_events+i,__ATOMIC_ACQUIRE))card=i;
 if(card>=2||!iq4_f3_storage_mutex_ready_01())return mode;
 if(iq4_f3_storage_mutex_lock_01()!=0){__atomic_store_n(&held,1,__ATOMIC_RELEASE);return mode;}
 if(card<2){uint32_t bit=1u<<card;int ui=pc==(uintptr_t)iq4_f3_storage_ui_set_return_01;
  int composite=!silent&&((card==0&&pc==0x6aa1c4)||(card==1&&pc==0x6aa16c));
  if(ui){
   if(!__atomic_load_n(&held,__ATOMIC_ACQUIRE)&&!(__atomic_load_n(&inhibit_mask,__ATOMIC_ACQUIRE)&bit)){
    __atomic_fetch_or(&override_mask,bit,__ATOMIC_ACQ_REL);mode=2;
   }else memcpy(&mode,(const void*)(event+0xc0),4); /* Keep native protection value. */
  }else if(composite){
   if(!__atomic_load_n(&held,__ATOMIC_ACQUIRE)&&!(__atomic_load_n(&inhibit_mask,__ATOMIC_ACQUIRE)&bit)&&(__atomic_load_n(&override_mask,__ATOMIC_ACQUIRE)&bit)&&mode<=2)mode=2;
  }else if(mode==0){
   __atomic_fetch_or(&inhibit_mask,bit,__ATOMIC_ACQ_REL);__atomic_fetch_and(&override_mask,~bit,__ATOMIC_ACQ_REL);
  }else if(mode<=2){
   __atomic_fetch_and(&inhibit_mask,~bit,__ATOMIC_ACQ_REL); /* Native restore never rearms. */
  }
 }
 return UINT64_C(0x100000000)|mode;
}
void iq4_f3_storage_leave_01(uint32_t token){
 if(token==1&&iq4_f3_storage_mutex_unlock_01()!=0)__atomic_store_n(&held,1,__ATOMIC_RELEASE);
}
int iq4_f3_native_mode_set_on_ui_01(uint32_t id,uint32_t mode){
 if((id!=10&&id!=11)||mode>F3_JPEG_ONLY||!on_ui()||!iq4_f3_storage_mutex_ready_01()||!iq4_f3_native_storage_bound_01()||!pins()||
    !f3_coordinator_ready_06()||!(f3_capture_backend_capabilities_03()&(1u<<(id-10))))return 0;
 struct Iq4ActivityLease01 lease={0};unsigned card=id-10;uint32_t before,after;
 if(iq4_activity_try_01(IQ4_ACTIVITY_JPEG01,&override_mask,&lease)!=IQ4_ACTIVITY_OK01)return 0;
 if(!scalar(native_events[card]+0xc0,&before)||before>2){iq4_activity_release_01(&lease);return 0;}
 if(!(saved_modes&(1u<<card))){original_modes[card]=before;saved_modes|=1u<<card;}
 if(!iq4_f3_native_storage_write_read_01(native_events[card],2,&after)){
  __atomic_fetch_and(&override_mask,~(1u<<card),__ATOMIC_ACQ_REL);
  __atomic_store_n(&held,1,__ATOMIC_RELEASE);iq4_activity_hold_01(&lease);return 0;
 }
 int ok=!__atomic_load_n(&held,__ATOMIC_ACQUIRE)&&after==2&&identities()&&(__atomic_load_n(&override_mask,__ATOMIC_ACQUIRE)&(1u<<card));
 if(ok)ok=iq4_f3_mode_set_for_card_on_ui_06(id,mode);
 if(!ok)__atomic_fetch_and(&override_mask,~(1u<<card),__ATOMIC_ACQ_REL);
 if(iq4_activity_release_01(&lease)!=IQ4_ACTIVITY_OK01){__atomic_store_n(&held,1,__ATOMIC_RELEASE);return 0;}
 return ok;
}
static void put(void*p,size_t off,uintptr_t v){memcpy((char*)p+off,&v,8);}
static char*text(char*b,int32_t n,const char*s){int32_t i=0;if(!b||n<=0)return(char*)"";for(;i+1<n&&s[i];++i)b[i]=s[i];b[i]=0;return b;}
static unsigned index_of(void*p){for(unsigned i=0;i<3;++i)if(p&&p==leaves[i])return i;return 3;}
static const char*mode_name(uint32_t mode){for(unsigned i=0;i<3;++i)if(mode==modes[i])return names[i];return "Unavailable";}
static char*menu_name(void*p,char*b,int32_t n){return text(b,n,p==sd_menu?"SD output":"");}
static char*menu_value(void*p,char*b,int32_t n){struct F3SettingsSnapshot06 s;return text(b,n,p==sd_menu&&iq4_f3_settings_snapshot_06(&s)?mode_name(s.sd_mode):"Unavailable");}
static char*leaf_name(void*p,char*b,int32_t n){unsigned i=index_of(p);return text(b,n,i<3?names[i]:"");}
static char*leaf_value(void*p,char*b,int32_t n){unsigned i=index_of(p);struct F3SettingsSnapshot06 s;return text(b,n,i<3&&iq4_f3_settings_snapshot_06(&s)&&s.sd_mode==modes[i]?"Selected":"");}
static uint32_t activate(void*p){unsigned i=index_of(p);return i<3?(uint32_t)iq4_f3_native_mode_set_on_ui_01(10,modes[i]):0;}
static int construct(void**p,size_t n,uintptr_t fn,uintptr_t*t){if(!iq4_f4_menu_new_03(n,p)||!*p||!iq4_f4_menu_ctor_03(fn,*p))return 0;put(*p,0,(uintptr_t)&t[2]);return 1;}
void*iq4_f3_storage_output_child_01(void*root,void*original,uintptr_t pc){
 uintptr_t v,dto,base,q,m,back,xqd,sd;uint32_t title;
 if(iq4_extensions_installation_stage_02()!=100||pc!=0x4f04f4||!root||!original||held||building||!pins()||!word((uintptr_t)root,&v)||v!=0xb8f9b8||
 !scalar((uintptr_t)root+0x14,&title)||title!=389||!word((uintptr_t)original,&v)||v!=0xb8fd40||
 !word((uintptr_t)original+0x18,&dto)||dto<4096+0x408||!word(dto,&v)||v!=0xbbf718)return original;
 base=dto-0x408;
 if(!word(base,&v)||v!=0xbbf0b8||!word(base+0x108,&v)||v!=0xbbf8a8||!word(base+0x208,&v)||v!=0xbbf8a8||
 !word(base+0x110,&xqd)||!word(base+0x210,&sd)||xqd==sd||!event_shape(sd,4)||!event_shape(xqd,2)||
 !iq4_f4_native_current_02(&q)||!word(q,&v)||v!=0xb91f48||!word(q+0x1c8,&m)||!word(m,&v)||v!=0xb8f358||!word(m+8,&back)||back!=q)return original;
 if(parent)return parent==(uintptr_t)root&&saved_original==original&&queue==q&&manager==m&&storage_dto==base?sd_menu:original;
 building=1;queue=q;manager=m;
 for(unsigned i=0;i<24;++i)if(!word(0xb8f9a8+8*i,menu_table+i))goto fail;
 for(unsigned i=0;i<22;++i)if(!word(0xb90738+8*i,leaf_table+i))goto fail;
 menu_table[5]=(uintptr_t)menu_name;menu_table[6]=(uintptr_t)menu_value;
 leaf_table[5]=(uintptr_t)leaf_name;leaf_table[6]=(uintptr_t)leaf_value;leaf_table[12]=(uintptr_t)activate;
 if(!construct(&sd_menu,0x118,0x4e5744,menu_table))goto fail;
 for(unsigned i=0;i<3;++i)if(!construct(leaves+i,0x38,0x4e9d30,leaf_table))goto fail;
 for(unsigned i=0;i<3;++i)if(!iq4_f4_menu_append_03(sd_menu,leaves[i]))goto fail;
 storage_dto=base;__atomic_store_n(native_events,sd,__ATOMIC_RELEASE);__atomic_store_n(native_events+1,xqd,__ATOMIC_RELEASE);
 parent=(uintptr_t)root;saved_original=original;building=0;return sd_menu;
 fail:__atomic_store_n(&held,1,__ATOMIC_RELEASE);return original;
}
