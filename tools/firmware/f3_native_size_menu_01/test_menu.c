#include "runtime.c"
#include "../../../src/codec/export_geometry.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
static _Alignas(8) unsigned char root[0x118],original_item[0x48],dto[0x100],ui[0x200],manager_fixture[0x40];
static void*allocated[32];static size_t allocated_bytes[32];static unsigned allocations,appends,ctors,fail_new,fail_append,fail_ctor;static int wrong_ui,bad_pin;
static struct Iq4ActivitySnapshot01 activity;
static int contained(uintptr_t p,size_t n,void*start,size_t bytes){return p>=(uintptr_t)start&&p+n>p&&p+n<=(uintptr_t)start+bytes;}
int iq4_native_self_read_01(void*c,uintptr_t p,void*out,size_t n){(void)c;
 for(unsigned i=0;i<sizeof SizePins01/sizeof*SizePins01;++i){const struct SizePin01*x=SizePins01+i;if(p>=x->va&&p+n<=x->va+x->bytes){memcpy(out,x->data+p-x->va,n);if(bad_pin)((unsigned char*)out)[0]^=1;return 1;}}
 if(contained(p,n,root,sizeof root)||contained(p,n,original_item,sizeof original_item)||contained(p,n,dto,sizeof dto)||contained(p,n,ui,sizeof ui)||contained(p,n,manager_fixture,sizeof manager_fixture)){memcpy(out,(void*)p,n);return 1;}
 for(unsigned i=0;i<allocations;++i)if(contained(p,n,allocated[i],allocated_bytes[i])){memcpy(out,(void*)p,n);return 1;}return 0;
}
int iq4_f4_native_current_02(uintptr_t*out){*out=wrong_ui?0:(uintptr_t)ui;return 1;}
int iq4_activity_snapshot_01(struct Iq4ActivitySnapshot01*out){*out=activity;return IQ4_ACTIVITY_OK01;}
int iq4_f4_menu_new_03(size_t bytes,void**out){if(fail_new&&allocations+1==fail_new){*out=0;return 1;}assert(allocations<32);*out=calloc(1,bytes);assert(*out);allocated[allocations]=*out;allocated_bytes[allocations++]=bytes;return 1;}
int iq4_f4_menu_ctor_03(uintptr_t fn,void*p){++ctors;if(fail_ctor&&ctors==fail_ctor)return 0;
 if(fn==0x4e5744){put(p,0,0xb8f9b8);put(p,0x18,0xb8faa0);put(p,0x20,0xc22908);put(p,0x28,0xc22960);put(p,0x30,(uintptr_t)p+0x28);put(p,0x38,(uintptr_t)p+0x28);}
 else {assert(fn==0x4e9d30);put(p,0,0xb90748);}return 1;}
int iq4_f4_menu_append_03(void*p,void*item){if(fail_append&&appends+1==fail_append)return 0;void*node;assert(iq4_f4_menu_new_03(0x20,&node)&&node);uintptr_t h=(uintptr_t)p+0x28,last;memcpy(&last,(void*)(h+16),8);put(node,0,0xb8f958);put(node,8,h);put(node,16,last);put(node,24,(uintptr_t)item);put((void*)last,8,(uintptr_t)node);put((void*)h,16,(uintptr_t)node);++appends;return 1;}
int main(int argc,char**argv){unsigned char before_item[sizeof original_item],before_dto[sizeof dto];char b[32];
 iq4_f4_menu_ctor_03(0x4e5744,root);ctors=0;uint32_t title=389;memcpy(root+0x14,&title,4);put(original_item,0,0xb8fd40);put(original_item,0x18,(uintptr_t)dto);put(dto,0,0xbbf3f8);put(ui,0,0xb91f48);put(ui,0x1c8,(uintptr_t)manager_fixture);put(manager_fixture,0,0xb8f358);put(manager_fixture,8,(uintptr_t)ui);
 memcpy(before_item,original_item,sizeof before_item);memcpy(before_dto,dto,sizeof before_dto);
 if(argc==3){unsigned n=(unsigned)strtoul(argv[2],0,10);if(!strcmp(argv[1],"alloc"))fail_new=n;else if(!strcmp(argv[1],"append"))fail_append=n;else {assert(!strcmp(argv[1],"ctor"));fail_ctor=n;}
  assert(iq4_f3_storage_size_child_01(root,original_item,0x4f052c)==original_item&&held&&!saved_parent);unsigned count=allocations;assert(iq4_f3_storage_size_child_01(root,original_item,0x4f052c)==original_item&&allocations==count);goto done;
 }
 if(argc==2){
  uintptr_t pc=0x4f052c;if(!strcmp(argv[1],"pc"))pc+=4;else if(!strcmp(argv[1],"pin"))bad_pin=1;else if(!strcmp(argv[1],"ui"))wrong_ui=1;else if(!strcmp(argv[1],"parent"))put(root,0,0xb8fd40);else if(!strcmp(argv[1],"title")){title=391;memcpy(root+0x14,&title,4);}else if(!strcmp(argv[1],"item"))put(original_item,0,0xb90748);else {assert(!strcmp(argv[1],"dto"));put(dto,0,0xbca728);}
  assert(iq4_f3_storage_size_child_01(root,original_item,pc)==original_item&&!allocations&&!held);goto cleanup;
 }
 void*replacement=iq4_f3_storage_size_child_01(root,original_item,0x4f052c);assert(replacement==size_menu&&replacement!=original_item&&allocations==13&&appends==6&&!held&&saved_original==original_item);
 unsigned count=allocations;assert(iq4_f3_storage_size_child_01(root,original_item,0x4f052c)==replacement&&allocations==count);
 assert(!strcmp(menu_name(replacement,b,sizeof b),"JPEG Size")&&!strcmp(menu_value(replacement,b,sizeof b),"100%"));
 assert(iq4_f3_mode_set_for_card_on_ui_06(10,F3_JPEG_ONLY)&&iq4_f3_mode_set_for_card_on_ui_06(11,F3_RAW_JPEG)&&iq4_f3_quality_set_on_ui_03(73));
 for(unsigned i=0;i<6;++i){struct F3SettingsSnapshot06 s;assert(!strcmp(item_name(size_items[i],b,sizeof b),names[i]));assert(activate(size_items[i])==1&&iq4_f3_settings_snapshot_06(&s));assert(s.size_mode==scales[i]&&s.sd_mode==F3_JPEG_ONLY&&s.xqd_mode==F3_RAW_JPEG&&s.quality==73);assert(!strcmp(menu_value(replacement,b,sizeof b),names[i]));for(unsigned j=0;j<6;++j)assert(!strcmp(item_value(size_items[j],b,sizeof b),j==i?"Selected":""));struct Iq4ExportGeometry g;assert(iq4_export_geometry(14204,10652,0,s.size_mode,&g)==IQ4_EXPORT_GEOMETRY_OK);assert(g.output_width<=14204&&g.output_height<=10652);if(i==0)assert(g.output_width==3840);if(i==1)assert(g.output_width==7680);if(i==2)assert(g.output_width==10653&&g.output_height==7989);if(i==3)assert(g.output_width==7102&&g.output_height==5326);if(i==4)assert(g.output_width==3551&&g.output_height==2663);if(i==5)assert(g.output_width==14204&&g.output_height==10652);}
 activity.actor=IQ4_ACTIVITY_JPEG01;assert(!activate(size_items[0])&&iq4_f3_scale_get_01()==F3_FULL01);activity.actor=0;activity.held=1;assert(!activate(size_items[0]));activity.held=0;wrong_ui=1;assert(!activate(size_items[0]));wrong_ui=0;assert(!activate(root));
 {char shortbuf[4]={1,2,3,4};item_name(size_items[5],shortbuf+1,2);assert(shortbuf[0]==1&&shortbuf[1]=='1'&&shortbuf[2]==0&&shortbuf[3]==4);}
 for(unsigned i=0;i<24;++i)if(i!=5&&i!=6){uintptr_t original;assert(word(0xb8f9a8+8*i,&original)&&menu_table[i]==original);}for(unsigned i=0;i<22;++i)if(i!=5&&i!=6&&i!=12){uintptr_t original;assert(word(0xb90738+8*i,&original)&&item_table[i]==original);}
 done:assert(!memcmp(before_item,original_item,sizeof before_item)&&!memcmp(before_dto,dto,sizeof before_dto));
 cleanup:for(unsigned i=0;i<allocations;++i)free(allocated[i]);puts("PASS native Storage JPEG Size / six shared policy sizes / original DTO preserved");return 0;
}
