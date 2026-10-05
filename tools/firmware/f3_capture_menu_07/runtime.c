#include "../f3_capture_menu_04/menu.h"
#include "../f3_capture_menu_06/policy.h"
#include "../f3_capture_menu_06/backend.h"
#include "../f3_save_coordinator_06/coordinator.h"
#include "../f4_native_menu_03/native_calls.h"
#include "../f4_native_source_02/native_calls.h"
#include "../native_runtime_01/self_read.h"
#include "../f3_capture_menu_04/code_pins.h"
#include <string.h>
/* Process-lifetime native objects. No ephemeral vendor object, property enum,
 * original Reader, RAW node, capture setting or card configuration is stored. */
static void *format_menu,*card_menu[2],*size_menu,*quality_menu,*format_items[2][3],*size_items[6],*quality_items[3],*extra_items[3];
static uintptr_t bound_parent,queue,manager,menu_table[24],item_table[22];
static unsigned building,held;
static uint32_t local_status; /* UI-only:0 ready,1 preparing,2 rejected,3 busy */
static const char*const format_names[3]={"RAW","JPEG","RAW + JPEG"};
static const char*const card_names[2]={"SD output","XQD output"};
static const uint32_t format_modes[3]={F3_RAW,F3_JPEG_ONLY,F3_RAW_JPEG};
static const char*const size_names[6]={"Full","75%","50%","25%","Long edge 3840","Long edge 7680"};
static const char*const quality_names[3]={"Decrease by 1","Increase by 1","Reset to 95"};
static const char*const extra_names[3]={"Export selected RAW","Latest export status","Output size"};
static int rd(uintptr_t p,void*b,size_t n){return p>=4096&&n&&n<=4096&&p<=UINTPTR_MAX-n&&iq4_native_self_read_01(0,p,b,n)==1;}
static int word(uintptr_t p,uintptr_t*out){uintptr_t a,b;if(!rd(p,&a,8)||!rd(p,&b,8)||a!=b)return 0;*out=a;return 1;}
static int pins(void){unsigned char b[64];for(unsigned i=0;i<sizeof iq4_f3_menu_pins_04/sizeof*iq4_f3_menu_pins_04;++i){const struct F3MenuPin04*p=iq4_f3_menu_pins_04+i;
 for(size_t j=0;j<p->length;j+=sizeof b){size_t n=p->length-j;if(n>sizeof b)n=sizeof b;if(!rd(p->va+j,b,n)||memcmp(b,p->bytes+j,n))return 0;}}return 1;}
static int on_ui(void){uintptr_t q=0,v=0,m=0,back=0;return queue&&iq4_f4_native_current_02(&q)&&q==queue&&word(q,&v)&&v==0xb91f48&&word(q+0x1c8,&m)&&m==manager&&word(m,&v)&&v==0xb8f358&&word(m+8,&back)&&back==q;}
static void put(void*p,size_t off,uintptr_t v){memcpy((char*)p+off,&v,8);}
static char*text(char*b,int32_t n,const char*s){int32_t i=0;if(!b||n<=0)return(char*)"";for(;i+1<n&&s[i];++i)b[i]=s[i];b[i]=0;return b;}
static char*number(char*b,int32_t n,uint64_t v){char d[20];unsigned i=0,j=0;do{d[i++]=(char)('0'+v%10);v/=10;}while(v);if(!b||n<=0)return(char*)"";while(i&&j+1<(unsigned)n)b[j++]=d[--i];b[j]=0;return b;}
static unsigned idx(void*p,void*const*a,unsigned n){for(unsigned i=0;i<n;++i)if(p&&p==a[i])return i;return n;}
static int snapshot(struct F3SettingsSnapshot06*s){return iq4_f3_settings_snapshot_06(s);}
static unsigned card_index(void*p){return p==card_menu[0]?0:p==card_menu[1]?1:2;}
static int card_capable(unsigned card){unsigned mask=f3_capture_backend_capabilities_03();return f3_coordinator_ready_06()&&card<2&&!(mask&~3u)&&!!(mask&(1u<<card));}
static unsigned format_index(void*p,unsigned*out_card){for(unsigned card=0;card<2;++card){unsigned i=idx(p,format_items[card],3);if(i<3){*out_card=card;return i;}}return 3;}
static const char*format_name(uint32_t mode){for(unsigned i=0;i<3;++i)if(format_modes[i]==mode)return format_names[i];return "Unavailable";}
static int present(uintptr_t root,uintptr_t item){uintptr_t h=root+0x28,prev=h,p,tail,v,next,back,value;unsigned count=0,found=0;
 if(!word(root+0x18,&v)||v!=0xb8faa0||!word(root+0x20,&v)||v!=0xc22908||!word(h,&v)||v!=0xc22960||!word(h+8,&p)||!word(h+16,&tail))return -1;
 while(p!=h){if(!p||(p&7)||++count>64||!word(p,&v)||v!=0xb8f958||!word(p+8,&next)||!word(p+16,&back)||back!=prev||!word(p+24,&value))return -1;
  if(value==item)++found;prev=p;p=next;}return tail==prev&&found<=1?(int)found:-1;
}
static void hold(void){held=1;local_status=2;iq4_f3_executor_hold_01();}
static int refresh(void){if(!format_menu)return 0;if(!iq4_f4_native_event_notify_02((char*)format_menu+0x60)){hold();return 0;}return 1;}
static int retire_finished(void){struct F3ExecutorView01 v={0};int r=iq4_f3_executor_view_on_ui_01(&v);
 if(r==F3_EXEC_UNKNOWN01){hold();return 0;}
 if(r==F3_EXEC_OK01&&v.state==F3_EXEC_FINISHED01)return iq4_f3_executor_finish_on_ui_01(v.sequence)==F3_EXEC_OK01;
 return r==F3_EXEC_OK01&&v.state==F3_EXEC_IDLE01;
}
static int settings_idle(void){struct Iq4ActivitySnapshot01 a={0};return !held&&on_ui()&&iq4_activity_snapshot_01(&a)==IQ4_ACTIVITY_OK01&&!a.actor&&!a.held;}
static char*menu_name(void*p,char*b,int32_t n){unsigned card=card_index(p);return text(b,n,card<2?card_names[card]:p==size_menu?"JPEG Size":p==quality_menu?"JPEG Quality":"Capture Output");}
static char*menu_value(void*p,char*b,int32_t n){struct F3SettingsSnapshot06 s;if(!snapshot(&s))return text(b,n,"Unavailable");unsigned card=card_index(p);
 if(card<2)return text(b,n,card_capable(card)?format_name(card?s.xqd_mode:s.sd_mode):"Backend unavailable");
 return p==quality_menu?number(b,n,s.quality):text(b,n,p==size_menu?size_names[s.size_mode]:f3_coordinator_ready_06()?"SD / XQD independent":"Backend unavailable");}
static char*item_name(void*p,char*b,int32_t n){unsigned card=2,i=format_index(p,&card);if(i<3)return text(b,n,format_names[i]);i=idx(p,size_items,6);if(i<6)return text(b,n,size_names[i]);i=idx(p,quality_items,3);if(i<3)return text(b,n,quality_names[i]);i=idx(p,extra_items,3);return text(b,n,i<3?extra_names[i]:"");}
static char*status(char*b,int32_t n){struct F3ExecutorView01 e={0};struct F3CoordinatorView06 v={0};
 if(held)return text(b,n,"Hold: owners retained");
 int r=iq4_f3_executor_view_on_ui_01(&e);if(r==F3_EXEC_UNKNOWN01)return text(b,n,"Hold: owners retained");
 if(r==F3_EXEC_OK01){if(e.state==F3_EXEC_QUEUED01||e.state==F3_EXEC_RESERVED01)return text(b,n,"Queued");if(e.state==F3_EXEC_RUNNING01)return text(b,n,"Rendering");}
 if(f3_coordinator_view_06(&v)==1&&v.generation){
  if(v.hold)return text(b,n,"Hold: owners retained");if(v.phase==2)return text(b,n,"Prepared");if(v.phase==3)return text(b,n,"Rendering");
  if(v.phase==4){if(v.jpeg_published)return text(b,n,v.requested_mode==F3_JPEG_ONLY&&!v.raw_removed?"JPEG saved; RAW kept":"JPEG saved");char step[12],s[32];number(step,sizeof step,v.failure_step);size_t k=0;const char*p="Failed step ";while(*p)s[k++]=*p++;for(unsigned i=0;step[i];++i)s[k++]=step[i];s[k]=0;return text(b,n,s);}}
 if(local_status==2)return text(b,n,"Selection unavailable");if(local_status==3)return text(b,n,"Busy");return text(b,n,!f3_coordinator_ready_06()?"Backend unavailable":r==F3_EXEC_OK01?"Ready":"Worker unavailable");
}
static char*item_value(void*p,char*b,int32_t n){struct F3SettingsSnapshot06 s;if(!snapshot(&s))return text(b,n,"Unavailable");unsigned card=2,i=format_index(p,&card);if(i<3)return text(b,n,!card_capable(card)?"Backend unavailable":format_modes[i]==(card?s.xqd_mode:s.sd_mode)?"Selected":"");i=idx(p,size_items,6);if(i<6)return text(b,n,i==s.size_mode?"Selected":"");
 i=idx(p,extra_items,3);if(i==0)return text(b,n,f3_coordinator_ready_06()?"Manual: keeps RAW":"Backend unavailable");if(i==1)return status(b,n);if(i==2){struct F3CoordinatorView06 v={0};if(f3_coordinator_view_06(&v)!=1||!v.width||!v.height)return text(b,n,"Not rendered");char w[12],h[12],d[28];number(w,sizeof w,v.width);number(h,sizeof h,v.height);size_t k=0;for(unsigned j=0;w[j];++j)d[k++]=w[j];d[k++]='x';for(unsigned j=0;h[j];++j)d[k++]=h[j];d[k]=0;return text(b,n,d);}return text(b,n,"");
}
static uint32_t export_selected(void){struct F3SettingsSnapshot06 s;struct F3ExecutorSelection01 selected;struct F3ExecutorReservation01 reservation;void*job=0;
 if(!on_ui()||held||!f3_coordinator_ready_06()||!snapshot(&s)){local_status=2;return 0;}
 /* A Finished task is retired only after its actual callback/notification and
  * released activity fence. An in-progress completion is never reused. */
 if(!retire_finished()){local_status=3;return 0;}
 int e=iq4_f3_executor_selection_on_ui_01(&selected);if(e!=F3_EXEC_OK01){local_status=2;refresh();return 0;}
 e=iq4_f3_executor_begin_on_ui_01(&reservation);if(e==F3_EXEC_UNKNOWN01){hold();return 0;}if(e!=F3_EXEC_OK01){local_status=3;refresh();return 0;}
 struct F3CoordinatorSettings06 settings={F3_RAW_JPEG,s.size_mode,s.quality}; /* Manual never removes the selected existing RAW. */
 int p=f3_coordinator_manual_prepare_06(selected.owner.ifm,selected.index,&settings,&reservation,&job);
 if(p!=F3_COORD_KNOWN_ENDED06||!job){
  if(p==F3_COORD_UNKNOWN06||(p==F3_COORD_KNOWN_ENDED06&&!job)){hold();return 0;}
  if(iq4_f3_executor_cancel_on_ui_01(reservation.sequence)!=F3_EXEC_OK01){hold();return 0;}
  local_status=2;refresh();return 0;
 }
 const struct F3ExecutorTask01 task={job,f3_coordinator_worker_run_06,reservation.sequence,(uintptr_t)format_menu+0x60};
 e=iq4_f3_executor_submit_on_ui_01(&task);
 if(e!=F3_EXEC_OK01){hold();return 0;}local_status=1;return 0; /* Stay in menu: no premature Navigator pop. */
}
static uint32_t activate(void*p){unsigned i=idx(p,extra_items,3);if(i==0)return export_selected();if(i<3)return 0;
 if(!settings_idle())return 0;unsigned card=2;i=format_index(p,&card);if(i<3)return card_capable(card)?(uint32_t)iq4_f3_mode_set_for_card_on_ui_06(card?11:10,format_modes[i]):0;i=idx(p,size_items,6);if(i<6)return (uint32_t)iq4_f3_scale_set_on_ui_01(i);
 i=idx(p,quality_items,3);if(i<3){struct F3SettingsSnapshot06 s;if(!snapshot(&s))return 0;uint32_t q=i==2?95:i==0?(s.quality>1?s.quality-1:1):(s.quality<100?s.quality+1:100);return (uint32_t)iq4_f3_quality_set_on_ui_03(q);}return 0;
}
static int construct(void**out,size_t bytes,uintptr_t fn,uintptr_t*table){if(!iq4_f4_menu_new_03(bytes,out)||!*out||!iq4_f4_menu_ctor_03(fn,*out))return 0;put(*out,0,(uintptr_t)&table[2]);return 1;}
void iq4_f3_after_file_settings_append_04(void*root,uintptr_t pc){uintptr_t parent=(uintptr_t)root,v,q,m,back;uint32_t title;
 if(pc!=0x4f0d38||parent<4096||(parent&7)||held||building||!pins()||!word(parent,&v)||v!=0xb8f9b8||!rd(parent+0x14,&title,4)||title!=391)return;
 if(!iq4_f4_native_current_02(&q)||!word(q,&v)||v!=0xb91f48||!word(q+0x1c8,&m)||!word(m,&v)||v!=0xb8f358||!word(m+8,&back)||back!=q)return;
 if(bound_parent&&(bound_parent!=parent||queue!=q||manager!=m))return;queue=q;manager=m;
 int attached=present(parent,(uintptr_t)format_menu);if(attached<0||attached)return;building=1;
 for(unsigned i=0;i<24;++i)if(!word(0xb8f9a8+8*i,&menu_table[i]))goto fail;
 for(unsigned i=0;i<22;++i)if(!word(0xb90738+8*i,&item_table[i]))goto fail;
 menu_table[5]=(uintptr_t)menu_name;menu_table[6]=(uintptr_t)menu_value;
 item_table[5]=(uintptr_t)item_name;item_table[6]=(uintptr_t)item_value;item_table[12]=(uintptr_t)activate;
 if(!construct(&format_menu,0x118,0x4e5744,menu_table)||!construct(&size_menu,0x118,0x4e5744,menu_table)||!construct(&quality_menu,0x118,0x4e5744,menu_table))goto fail;
 for(unsigned card=0;card<2;++card){if(!construct(card_menu+card,0x118,0x4e5744,menu_table))goto fail;
  for(unsigned i=0;i<3;++i)if(!construct(format_items[card]+i,0x38,0x4e9d30,item_table))goto fail;}
 for(unsigned i=0;i<6;++i)if(!construct(size_items+i,0x38,0x4e9d30,item_table))goto fail;
 for(unsigned i=0;i<3;++i)if(!construct(quality_items+i,0x38,0x4e9d30,item_table)||!construct(extra_items+i,0x38,0x4e9d30,item_table))goto fail;
 for(unsigned card=0;card<2;++card){for(unsigned i=0;i<3;++i)if(!iq4_f4_menu_append_03(card_menu[card],format_items[card][i]))goto fail;
  if(!iq4_f4_menu_append_03(format_menu,card_menu[card]))goto fail;}
 for(unsigned i=0;i<6;++i)if(!iq4_f4_menu_append_03(size_menu,size_items[i]))goto fail;
 for(unsigned i=0;i<3;++i)if(!iq4_f4_menu_append_03(quality_menu,quality_items[i]))goto fail;
 if(!iq4_f4_menu_append_03(format_menu,size_menu)||!iq4_f4_menu_append_03(format_menu,quality_menu))goto fail;
 for(unsigned i=0;i<3;++i)if(!iq4_f4_menu_append_03(format_menu,extra_items[i]))goto fail;
 if(!iq4_f4_menu_append_03(root,format_menu)||present(parent,(uintptr_t)format_menu)!=1)goto fail;
 bound_parent=parent;building=0;return;
 fail:held=1; /* Retain partial native heap/list objects. No retry/free. */
}
