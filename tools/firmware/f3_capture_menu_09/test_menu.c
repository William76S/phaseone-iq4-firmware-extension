#include "runtime.c"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
static _Alignas(8) unsigned char root[0x118],ui[0xd50],manager_fixture[0x800];
static void*allocated[128];static unsigned allocation_count,append_count,fail_at,append_fail,notify_fail,notify_count;
static unsigned capability=3,init_error;
uint32_t iq4_extensions_installation_error_02(void){return init_error;}
uint32_t iq4_extensions_installation_stage_02(void){return init_error?init_error:100;}
static int ready=1,wrong_ui,selection_result=F3_EXEC_OK01,begin_result=F3_EXEC_OK01,prepare_result=F3_COORD_KNOWN_ENDED06,submit_result=F3_EXEC_OK01,cancel_result=F3_EXEC_OK01,finish_result=F3_EXEC_OK01;
static unsigned select_calls,begin_calls,prepare_calls,submit_calls,cancel_calls,finish_calls,holds;
static struct F3ExecutorView01 ev={F3_EXEC_IDLE01,0,9,{0x10000,0x11000,0x12000,11}};
static struct F3CoordinatorView06 cv;
static struct Iq4ActivitySnapshot01 av;
static struct F3ExecutorTask01 last_task;static struct F3CoordinatorSettings06 prepared_settings;static struct F3ExecutorReservation01 prepared_reservation;
static unsigned char ticket;
static const uintptr_t native_menu[24]={0,0xb8fbe0,0x4e5ed0,0x4e5ee8,0x4e5eb0,0x4e5efc,0x4e5f1c,0x4e58a4,0x4e5f84,0x4e5f9c,0x4e5fc0,0x4e5fd8,0x4e5ff0,0x4e5990,0x4e5a2c,0x4e5394,0x4e6004,0x4e601c,0x4e5834,0x4e587c,0x4e5ac8,0x4e5b34,0x4e6030,0x4e6054};
static const uintptr_t native_item[22]={0,0xb907e8,0x4ea1a8,0x4ea1c0,0x4ea188,0x4ea200,0x4ea220,0x4ea29c,0x4ea1d4,0x4ea1e8,0x4ea2b0,0x4ea2c4,0x4ea2d8,0x4e9e10,0x4e9e28,0x4e5394,0x4ea2fc,0x4ea310,0x4e9db8,0x4e9de8,0x4e9e84,0x4e9ea8};
int iq4_native_self_read_01(void*c,uintptr_t p,void*out,size_t n){(void)c;
 if(p>=0xb8f9a8&&p+n<=0xb8f9a8+sizeof native_menu){memcpy(out,(const char*)native_menu+p-0xb8f9a8,n);return 1;}
 if(p>=0xb90738&&p+n<=0xb90738+sizeof native_item){memcpy(out,(const char*)native_item+p-0xb90738,n);return 1;}
 for(unsigned i=0;i<sizeof iq4_f3_menu_pins_04/sizeof*iq4_f3_menu_pins_04;++i){const struct F3MenuPin04*x=iq4_f3_menu_pins_04+i;if(p>=x->va&&p+n<=x->va+x->length){memcpy(out,x->bytes+p-x->va,n);return 1;}}
 if(p<4096||p<0x100000000ull)return 0;memcpy(out,(void*)p,n);return 1;
}
int iq4_f4_native_current_02(uintptr_t*out){*out=wrong_ui?0:(uintptr_t)ui;return 1;}
int iq4_f4_menu_new_03(size_t n,void**out){if(fail_at&&allocation_count+1==fail_at){*out=0;return 1;}assert(allocation_count<128);*out=calloc(1,n);assert(*out);allocated[allocation_count++]=*out;return 1;}
int iq4_f4_menu_ctor_03(uintptr_t fn,void*p){uint32_t title=UINT32_MAX;put(p,0x14,title);if(fn==0x4e5744){put(p,0,0xb8f9b8);put(p,0x18,0xb8faa0);put(p,0x20,0xc22908);put(p,0x28,0xc22960);put(p,0x30,(uintptr_t)p+0x28);put(p,0x38,(uintptr_t)p+0x28);put(p,0x60,0xc237a0);}else{assert(fn==0x4e9d30);put(p,0,0xb90748);}return 1;}
int iq4_f4_menu_append_03(void*p,void*item){if(append_fail&&append_count+1==append_fail)return 0;uintptr_t h=(uintptr_t)p+0x28,last;memcpy(&last,(void*)(h+16),8);void*node;assert(iq4_f4_menu_new_03(0x20,&node)&&node);put(node,0,0xb8f958);put(node,8,h);put(node,16,last);put(node,24,(uintptr_t)item);put((void*)last,8,(uintptr_t)node);put((void*)h,16,(uintptr_t)node);++append_count;return 1;}
int iq4_f4_native_event_notify_02(void*p){assert(p==(char*)format_menu+0x60);++notify_count;return !notify_fail;}
int f3_coordinator_ready_06(void){return ready;}
unsigned f3_capture_backend_capabilities_03(void){return capability;}
int f3_coordinator_manual_prepare_06(uintptr_t ifm,int32_t i,const struct F3CoordinatorSettings06*s,const struct F3ExecutorReservation01*r,void**out){++prepare_calls;assert(ifm==ev.owner.ifm&&i==27&&r->sequence==9);prepared_settings=*s;prepared_reservation=*r;*out=prepare_result==F3_COORD_KNOWN_ENDED06?&ticket:0;return prepare_result;}
int f3_coordinator_worker_run_06(void*t,const struct F3ExecutorOwner01*o){assert(t==&ticket&&o);return 1;}
int f3_coordinator_view_06(struct F3CoordinatorView06*out){*out=cv;return 1;}
int iq4_f3_executor_selection_on_ui_01(struct F3ExecutorSelection01*out){++select_calls;*out=(struct F3ExecutorSelection01){ev.owner,27};return selection_result;}
int iq4_f3_executor_begin_on_ui_01(struct F3ExecutorReservation01*out){++begin_calls;*out=(struct F3ExecutorReservation01){9,{0x33,0x12000}};return begin_result;}
int iq4_f3_executor_cancel_on_ui_01(uint64_t seq){++cancel_calls;assert(seq==9);return cancel_result;}
int iq4_f3_executor_submit_on_ui_01(const struct F3ExecutorTask01*t){++submit_calls;last_task=*t;return submit_result;}
int iq4_f3_executor_view_on_ui_01(struct F3ExecutorView01*out){*out=ev;return ev.state==F3_EXEC_HOLD01?F3_EXEC_UNKNOWN01:ev.state==F3_EXEC_NOT_BOUND01?F3_EXEC_REJECTED01:F3_EXEC_OK01;}
int iq4_f3_executor_finish_on_ui_01(uint64_t seq){++finish_calls;assert(seq==ev.sequence);if(finish_result==F3_EXEC_OK01)ev.state=F3_EXEC_IDLE01;return finish_result;}
void iq4_f3_executor_hold_01(void){++holds;ev.state=F3_EXEC_HOLD01;}
int iq4_activity_snapshot_01(struct Iq4ActivitySnapshot01*out){*out=av;return IQ4_ACTIVITY_OK01;}
static void invoke(void){iq4_f3_after_file_settings_append_04(root,0x4f0d38);}
int main(int argc,char**argv){char b[64];unsigned before;
 iq4_f4_menu_ctor_03(0x4e5744,root);uint32_t title=391;memcpy(root+0x14,&title,4);
 put(ui,0,0xb91f48);put(ui,0x1c8,(uintptr_t)manager_fixture);put(manager_fixture,0,0xb8f358);put(manager_fixture,8,(uintptr_t)ui);
 if(argc==2 && argv[1][0]!='-'){fail_at=(unsigned)strtoul(argv[1],0,10);assert(fail_at>=1&&fail_at<=17);invoke();assert(held&&building&&!bound_parent&&present((uintptr_t)root,(uintptr_t)format_menu)==0);before=allocation_count;invoke();assert(allocation_count==before);goto done;}
 wrong_ui=1;invoke();assert(!allocation_count);wrong_ui=0;
 iq4_f3_after_file_settings_append_04(root,0x4eea5c);assert(!allocation_count);title=389;memcpy(root+0x14,&title,4);invoke();assert(!allocation_count);title=391;memcpy(root+0x14,&title,4);
 if(argc==2&&!strcmp(argv[1],"--append-failure")){append_fail=17;invoke();assert(held&&building&&!bound_parent&&present((uintptr_t)root,(uintptr_t)format_menu)==0);before=allocation_count;invoke();assert(allocation_count==before);goto done;}

 if(argc==2&&!strcmp(argv[1],"--backend-unavailable"))ready=0;
 invoke();assert(bound_parent==(uintptr_t)root&&!held&&!building&&append_count==17&&present((uintptr_t)root,(uintptr_t)format_menu)==1);
 before=allocation_count;invoke();assert(allocation_count==before);
 assert(iq4_f3_quality_get_03()==100);
 assert(!strcmp(item_name(current_quality,b,sizeof b),"Current JPEG quality"));
 assert(!strcmp(item_value(current_quality,b,sizeof b),"100"));
 assert(!activate(current_quality));
 if(argc==2&&!strcmp(argv[1],"--backend-unavailable")){
  struct F3SettingsSnapshot06 original,after;assert(snapshot(&original));
  assert(!strcmp(menu_name(format_menu,b,sizeof b),"Capture Output"));
  assert(!strcmp(menu_value(format_menu,b,sizeof b),"Backend unavailable"));
  assert(!strcmp(status(b,sizeof b),"Backend unavailable"));
  init_error=20;assert(!strcmp(status(b,sizeof b),"Initialization failed: 20"));init_error=0;
  for(unsigned card=0;card<2;++card){
   assert(!strcmp(menu_value(card_menu[card],b,sizeof b),"Backend unavailable"));
   assert(!strcmp(item_value(format_items[card][1],b,sizeof b),"Backend unavailable"));
   assert(!activate(format_items[card][1]));
  }
  assert(!strcmp(item_value(extra_items[0],b,sizeof b),"Backend unavailable"));
  assert(!activate(extra_items[0])&&!select_calls&&!begin_calls&&!prepare_calls&&!submit_calls&&!holds);
  assert(snapshot(&after)&&!memcmp(&original,&after,sizeof after));
  ready=1;before=allocation_count;invoke();assert(allocation_count==before&&append_count==17);
  assert(!strcmp(menu_value(format_menu,b,sizeof b),"SD / XQD independent"));
  assert(activate(format_items[0][1])==1&&activate(format_items[1][2])==1);
  assert(!activate(extra_items[0])&&select_calls==1&&prepare_calls==1&&submit_calls==1);
  goto done;
 }
 if(argc==2){
  if(!strcmp(argv[1],"--sd-cap-only")||!strcmp(argv[1],"--xqd-cap-only")||!strcmp(argv[1],"--bad-cap")){
   capability=!strcmp(argv[1],"--sd-cap-only")?1:!strcmp(argv[1],"--xqd-cap-only")?2:4;
   struct F3SettingsSnapshot06 a,before;assert(snapshot(&before));
   for(unsigned card=0;card<2;++card){int permitted=capability<4&&!!(capability&(1u<<card));assert(activate(format_items[card][1])==(unsigned)permitted);assert(!strcmp(menu_value(card_menu[card],b,sizeof b),permitted?"JPEG":"Backend unavailable"));assert(!strcmp(item_value(format_items[card][1],b,sizeof b),permitted?"Selected":"Backend unavailable"));assert(snapshot(&a));assert((card?a.xqd_mode:a.sd_mode)==(permitted?F3_JPEG_ONLY:(card?before.xqd_mode:before.sd_mode)));}
   goto done;
  }
  if(!strcmp(argv[1],"--submit-unknown")){submit_result=F3_EXEC_UNKNOWN01;assert(!activate(extra_items[0])&&held&&holds==1&&submit_calls==1&&cancel_calls==0);}
  else if(!strcmp(argv[1],"--submit-reject-after-prepare")){submit_result=F3_EXEC_REJECTED01;assert(!activate(extra_items[0])&&held&&holds==1&&submit_calls==1&&cancel_calls==0);}
  else if(!strcmp(argv[1],"--cancel-unknown")){prepare_result=F3_COORD_REJECTED06;cancel_result=F3_EXEC_UNKNOWN01;assert(!activate(extra_items[0])&&held&&holds==1&&cancel_calls==1);}
  else if(!strcmp(argv[1],"--notify-unknown")){selection_result=F3_EXEC_REJECTED01;notify_fail=1;assert(!activate(extra_items[0])&&held&&holds==1&&notify_count==1);}
  else if(!strcmp(argv[1],"--begin-unknown")){begin_result=F3_EXEC_UNKNOWN01;assert(!activate(extra_items[0])&&held&&holds==1&&!prepare_calls);}
  else if(!strcmp(argv[1],"--wrong-ui-action")){wrong_ui=1;assert(!activate(format_items[0][1])&&!activate(extra_items[0])&&!select_calls&&!prepare_calls);}
  else {assert(!strcmp(argv[1],"--completed-callback-fence"));ev.state=F3_EXEC_FINISHED01;finish_result=F3_EXEC_REJECTED01;assert(!activate(extra_items[0])&&finish_calls==1&&!select_calls&&!prepare_calls&&!held);}
  before=prepare_calls;assert(!activate(extra_items[0])&&prepare_calls==before);goto done;
 }
 for(unsigned i=0;i<24;++i)if(i!=5&&i!=6)assert(menu_table[i]==native_menu[i]);for(unsigned i=0;i<22;++i)if(i!=5&&i!=6&&i!=12)assert(item_table[i]==native_item[i]);assert(menu_table[16]==0x4e6004&&item_table[16]==0x4ea2fc);
 for(unsigned card=0;card<2;++card)for(unsigned i=0;i<3;++i){struct F3SettingsSnapshot06 before_s,after_s;assert(snapshot(&before_s));assert(activate(format_items[card][i])==1);assert(snapshot(&after_s));assert((card?after_s.xqd_mode:after_s.sd_mode)==format_modes[i]);assert((card?after_s.sd_mode:after_s.xqd_mode)==(card?before_s.sd_mode:before_s.xqd_mode));assert(!strcmp(menu_name(card_menu[card],b,sizeof b),card_names[card])&&!strcmp(menu_value(card_menu[card],b,sizeof b),format_names[i]));}
 assert(activate(quality_items[0])==1&&iq4_f3_quality_get_03()==99);
 assert(!strcmp(item_value(current_quality,b,sizeof b),"99"));
 assert(activate(quality_items[2])==1&&iq4_f3_quality_get_03()==100);
 assert(!strcmp(item_value(current_quality,b,sizeof b),"100"));
 assert(activate(quality_items[2])==1);for(unsigned i=0;i<110;++i)assert(activate(quality_items[1])==1);assert(iq4_f3_quality_get_03()==100);assert(!strcmp(menu_value(quality_menu,b,sizeof b),"100"));
 av.actor=IQ4_ACTIVITY_MOVIE01;assert(!activate(format_items[0][0])&&!activate(quality_items[0]));av.actor=0;av.held=1;assert(!activate(format_items[0][0]));av.held=0;
 assert(!activate(root)&&!activate(extra_items[1])&&!activate(extra_items[2]));assert(!strcmp(item_value(extra_items[0],b,sizeof b),"Manual: keeps RAW"));
 ev.state=F3_EXEC_NOT_BOUND01;assert(!strcmp(status(b,sizeof b),"Worker unavailable"));assert(!activate(extra_items[0])&&!select_calls);ev.state=F3_EXEC_IDLE01;
 selection_result=F3_EXEC_REJECTED01;assert(!activate(extra_items[0])&&select_calls==1&&!begin_calls&&!prepare_calls);selection_result=F3_EXEC_OK01;
 begin_result=F3_EXEC_BUSY01;assert(!activate(extra_items[0])&&begin_calls==1&&!prepare_calls);begin_result=F3_EXEC_OK01;
 prepare_result=F3_COORD_REJECTED06;assert(!activate(extra_items[0])&&prepare_calls==1&&cancel_calls==1&&!submit_calls&&!held);prepare_result=F3_COORD_KNOWN_ENDED06;
 ev.state=F3_EXEC_FINISHED01;finish_result=F3_EXEC_REJECTED01;assert(!activate(extra_items[0])&&finish_calls==1&&prepare_calls==1);finish_result=F3_EXEC_OK01;
 assert(!activate(extra_items[0])&&finish_calls==2&&prepare_calls==2&&submit_calls==1);
 struct F3SettingsSnapshot06 s;assert(snapshot(&s)&&prepared_settings.mode==F3_RAW_JPEG&&prepared_settings.size_mode==s.size_mode&&prepared_settings.quality==s.quality);
 assert(last_task.ticket==&ticket&&last_task.run==f3_coordinator_worker_run_06&&last_task.sequence==prepared_reservation.sequence&&last_task.ui_completion_event==(uintptr_t)format_menu+0x60);
 ev.state=F3_EXEC_RUNNING01;assert(!strcmp(status(b,sizeof b),"Rendering"));ev.state=F3_EXEC_IDLE01;cv.generation=1;cv.phase=4;cv.jpeg_published=1;cv.width=14204;cv.height=10652;assert(!strcmp(status(b,sizeof b),"JPEG saved"));assert(!strcmp(item_value(extra_items[2],b,sizeof b),"14204x10652"));cv.requested_mode=F3_JPEG_ONLY;cv.raw_removed=0;assert(!strcmp(status(b,sizeof b),"JPEG saved; RAW kept"));cv.raw_removed=1;assert(!strcmp(status(b,sizeof b),"JPEG saved"));cv.jpeg_published=0;cv.failure_step=17;assert(!strcmp(status(b,sizeof b),"Failed step 17"));
 {char z[4]={0x55,0x55,0x55,0x55};item_name(format_items[0][0],z+1,2);assert(z[0]==0x55&&z[1]=='R'&&z[2]==0&&z[3]==0x55);}
 prepare_result=F3_COORD_UNKNOWN06;before=cancel_calls;assert(!activate(extra_items[0])&&held&&holds==1&&cancel_calls==before);before=prepare_calls;assert(!activate(extra_items[0])&&prepare_calls==before);assert(!strcmp(status(b,sizeof b),"Hold: owners retained"));
 done:for(unsigned i=0;i<allocation_count;++i)free(allocated[i]);puts("PASS native dual-card menu ABI/actual capability/immutable request/Hold fixture");return 0;
}
