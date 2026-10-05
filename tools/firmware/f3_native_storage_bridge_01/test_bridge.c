#include "runtime.c"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
static _Alignas(8) unsigned char root[0x118],old_item[0x48],dto[0x900],ui[0x200],manager_fixture[0x40],groups[2][0x1400];
static void*allocated[16];static size_t sizes[16];static unsigned allocations,ctors,appends,fail_new,fail_ctor,fail_append,native_calls;
static int wrong_ui,bad_pin,backend=1,write_result=1,protection_during,wrong_read;static unsigned capabilities=3,install_stage=100;
uint32_t iq4_extensions_installation_stage_02(void){return install_stage;}
static int contains(uintptr_t p,size_t n,void*b,size_t z){return p>=(uintptr_t)b&&p+n>p&&p+n<=(uintptr_t)b+z;}
int iq4_native_self_read_01(void*c,uintptr_t p,void*out,size_t n){(void)c;
 for(unsigned i=0;i<sizeof BridgePins01/sizeof*BridgePins01;++i){const struct BridgePin01*x=BridgePins01+i;if(p>=x->va&&p+n<=x->va+x->bytes){memcpy(out,x->data+p-x->va,n);if(bad_pin)((char*)out)[0]^=1;return 1;}}
 if(contains(p,n,root,sizeof root)||contains(p,n,old_item,sizeof old_item)||contains(p,n,dto,sizeof dto)||contains(p,n,ui,sizeof ui)||contains(p,n,manager_fixture,sizeof manager_fixture)||contains(p,n,groups,sizeof groups)){memcpy(out,(void*)p,n);return 1;}
 for(unsigned i=0;i<allocations;++i)if(contains(p,n,allocated[i],sizes[i])){memcpy(out,(void*)p,n);return 1;}return 0;
}
int iq4_f4_native_current_02(uintptr_t*out){*out=wrong_ui?0:(uintptr_t)ui;return 1;}
unsigned f3_capture_backend_capabilities_03(void){return capabilities;}
int f3_coordinator_ready_06(void){return backend;}
int iq4_f4_menu_new_03(size_t n,void**out){if(fail_new&&allocations+1==fail_new){*out=0;return 1;}assert(allocations<16);*out=calloc(1,n);assert(*out);allocated[allocations]=*out;sizes[allocations++]=n;return 1;}
int iq4_f4_menu_ctor_03(uintptr_t fn,void*p){(void)p;assert(fn==0x4e5744||fn==0x4e9d30);++ctors;return !(fail_ctor&&ctors==fail_ctor);}
int iq4_f4_menu_append_03(void*p,void*i){assert(p==sd_menu&&i);++appends;return !(fail_append&&appends==fail_append);}
void iq4_f3_storage_ui_set_return_01(void){}
static void set_mode(uintptr_t event,uint32_t value,uintptr_t pc){uint64_t r=iq4_f3_storage_enter_01(event,value,pc,0);value=(uint32_t)r;memcpy((void*)(event+0xc0),&value,4);iq4_f3_storage_leave_01((uint32_t)(r>>32));}
static uint32_t effective(uintptr_t event,uint32_t mode,uintptr_t pc){uint64_t r=iq4_f3_storage_enter_01(event,mode,pc,0);iq4_f3_storage_leave_01((uint32_t)(r>>32));return(uint32_t)r;}
int iq4_f3_native_storage_write_read_01(uintptr_t event,uint32_t mode,uint32_t*out){
 ++native_calls;assert(event==native_events[0]||event==native_events[1]);assert(mode==2);
 /* A real transition is still through the original event; stub records order. */
 struct F3SettingsSnapshot06 before;assert(iq4_f3_settings_snapshot_06(&before));
 set_mode(event,mode,(uintptr_t)iq4_f3_storage_ui_set_return_01);
 if(!write_result)return 0;
 if(protection_during)set_mode(event,0,0x708ad8);
 memcpy(out,(void*)(event+0xc0),4);if(wrong_read)*out=0;return 1;
}
static void setup(void){uint32_t t=389;put(root,0,0xb8f9b8);memcpy(root+0x14,&t,4);put(old_item,0,0xb8fd40);put(old_item,0x18,(uintptr_t)dto+0x408);put(dto,0,0xbbf0b8);put(dto,0x408,0xbbf718);put(dto,0x108,0xbbf8a8);put(dto,0x208,0xbbf8a8);put(dto,0x110,(uintptr_t)groups[1]+8);put(dto,0x210,(uintptr_t)groups[0]+8);
 for(unsigned i=0;i<2;++i){put(groups[i],0,0xbca228);put(groups[i],8,0xbcac08);groups[i][0x13f3]=i?2:4;}
 put(ui,0,0xb91f48);put(ui,0x1c8,(uintptr_t)manager_fixture);put(manager_fixture,0,0xb8f358);put(manager_fixture,8,(uintptr_t)ui);
 uint32_t original=2;memcpy(groups[1]+8+0xc0,&original,4); /* old SD JPEG Only: SD native RAW=0. */
}
int main(int argc,char**argv){assert(iq4_f3_native_storage_mutex_initialize_01());assert(iq4_f3_native_storage_mutex_initialize_01());setup();unsigned char old_before[sizeof old_item],dto_before[sizeof dto];memcpy(old_before,old_item,sizeof old_before);memcpy(dto_before,dto,sizeof dto_before);
 if(argc==3){unsigned n=(unsigned)strtoul(argv[2],0,10);if(!strcmp(argv[1],"alloc"))fail_new=n;else if(!strcmp(argv[1],"ctor"))fail_ctor=n;else {assert(!strcmp(argv[1],"append"));fail_append=n;}
  assert(iq4_f3_storage_output_child_01(root,old_item,0x4f04f4)==old_item&&held&&!parent);goto cleanup;}
 if(argc==2&&(!strcmp(argv[1],"badpin")||!strcmp(argv[1],"baddto")||!strcmp(argv[1],"badflag")||!strcmp(argv[1],"unbound")||!strcmp(argv[1],"install-failed")||!strcmp(argv[1],"install-pending"))){
  if(!strcmp(argv[1],"install-pending"))install_stage=0;else if(!strcmp(argv[1],"install-failed"))install_stage=50;else if(!strcmp(argv[1],"badpin"))bad_pin=1;else if(!strcmp(argv[1],"baddto"))put(dto,0x108,0);else if(!strcmp(argv[1],"badflag"))groups[0][0x13f3]=2;
  if(strcmp(argv[1],"unbound"))assert(iq4_f3_storage_output_child_01(root,old_item,0x4f04f4)==old_item);
  assert(!iq4_f3_native_mode_set_on_ui_01(10,F3_JPEG_ONLY)&&!native_calls);goto cleanup;}
 assert(iq4_f3_storage_output_child_01(root,old_item,0x4f04f4)==sd_menu&&sd_menu!=old_item&&allocations==4&&appends==3);
 assert(iq4_f3_native_storage_bound_01());assert(iq4_f3_storage_output_child_01(root,old_item,0x4f04f4)==sd_menu&&allocations==4);
 assert(!memcmp(old_before,old_item,sizeof old_before)&&!memcmp(dto_before,dto,sizeof dto_before));
 struct F3SettingsSnapshot06 snapshot;assert(iq4_f3_settings_snapshot_06(&snapshot)&&snapshot.sd_mode==F3_RAW&&snapshot.xqd_mode==F3_RAW&&snapshot.quality==100);
 if(argc==2){
  if(!strcmp(argv[1],"exception"))write_result=0;else if(!strcmp(argv[1],"readback"))wrong_read=1;else if(!strcmp(argv[1],"protect"))protection_during=1;else if(!strcmp(argv[1],"ui"))wrong_ui=1;else if(!strcmp(argv[1],"backend"))backend=0;else if(!strcmp(argv[1],"cap"))capabilities=2;else {assert(!strcmp(argv[1],"busy"));struct Iq4ActivityLease01 x={0};assert(iq4_activity_try_01(IQ4_ACTIVITY_MOVIE01,&dto,&x)==0);}
  assert(!iq4_f3_native_mode_set_on_ui_01(10,F3_JPEG_ONLY));assert(iq4_f3_settings_snapshot_06(&snapshot)&&snapshot.sd_mode==F3_RAW&&snapshot.xqd_mode==F3_RAW&&!iq4_f3_native_storage_override_mask_01());
  if(!write_result){struct Iq4ActivitySnapshot01 s;assert(held&&iq4_activity_snapshot_01(&s)==0&&s.held);}goto cleanup;
 }
 iq4_f3_quality_set_on_ui_03(73);iq4_f3_scale_set_on_ui_01(F3_50_PERCENT01);
 for(unsigned sd=0;sd<3;++sd)for(unsigned xqd=0;xqd<3;++xqd){assert(iq4_f3_native_mode_set_on_ui_01(10,sd));assert(iq4_f3_native_mode_set_on_ui_01(11,xqd));assert(iq4_f3_settings_snapshot_06(&snapshot)&&snapshot.sd_mode==sd&&snapshot.xqd_mode==xqd&&snapshot.quality==73&&snapshot.size_mode==F3_50_PERCENT01);uint32_t actual;assert(scalar(native_events[0]+0xc0,&actual)&&actual==2&&scalar(native_events[1]+0xc0,&actual)&&actual==2);}
 assert(saved_modes==3&&original_modes[0]==0&&original_modes[1]==2);
 assert(effective(native_events[0],0,0x6aa1c4)==2);
 assert(effective(native_events[1],0,0x6aa16c)==2);
 assert(effective(native_events[0],0,0x708ad8)==0);
 assert(effective(native_events[1],0,0x6aa1c4)==0);
 set_mode(native_events[0],2,0x708bc8);set_mode(native_events[1],2,0x708ba8);assert(iq4_f3_native_mode_set_on_ui_01(10,snapshot.sd_mode)&&iq4_f3_native_mode_set_on_ui_01(11,snapshot.xqd_mode));
 /* Native Off cancels only the bound card's override BEFORE the native write.
  * Subsequent composition callbacks cannot turn it back on. Original restore
  * leaves the F3 choice intact without silently rearming this override. */
 uint32_t saved=snapshot.sd_mode;set_mode(native_events[0],0,0x708ad8);assert(iq4_f3_native_storage_override_mask_01()==2);assert(effective(native_events[0],0,0x6aa1c4)==0);assert(!iq4_f3_native_mode_set_on_ui_01(10,F3_JPEG_ONLY));set_mode(native_events[0],2,0x708bc8);assert(iq4_f3_native_storage_override_mask_01()==2);assert(iq4_f3_settings_snapshot_06(&snapshot)&&snapshot.sd_mode==saved);
 set_mode(native_events[1],0,0x500000);assert(!iq4_f3_native_storage_override_mask_01());set_mode(native_events[1],2,0x708ba8);
 /* Each individual backend bit suffices for its respective card. */
 capabilities=1;assert(iq4_f3_native_mode_set_on_ui_01(10,F3_RAW_JPEG));capabilities=2;assert(iq4_f3_native_mode_set_on_ui_01(11,F3_JPEG_ONLY));capabilities=3;
 char textbuf[32];assert(!strcmp(menu_name(sd_menu,textbuf,sizeof textbuf),"SD output"));assert(!strcmp(menu_value(sd_menu,textbuf,sizeof textbuf),"RAW + JPEG"));for(unsigned i=0;i<3;++i){assert(activate(leaves[i])&&iq4_f3_settings_snapshot_06(&snapshot)&&snapshot.sd_mode==modes[i]);assert(!strcmp(leaf_value(leaves[i],textbuf,sizeof textbuf),"Selected"));}
 cleanup:for(unsigned i=0;i<allocations;++i)free(allocated[i]);puts("PASS native bridge: complete RAW route / protected Off / coherent policy / no legacy JPEG");return 0;
}
