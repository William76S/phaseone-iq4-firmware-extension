#include "menu.h"
#include "native_calls.h"
#include "../f4_native_source_02/native_calls.h"
#include "code_pins.h"
#include <string.h>
static Iq4F4SelfRead02 read_memory;static void*read_context;static uintptr_t selector,manager,queue,parent;
static void*source;static Iq4F4MenuPorts03 ports;
static void*menu,*items[9];static uintptr_t mt[24],it[22];static unsigned held,building,connected,exit_pending;
static const char*const names[9]={"Start","Stop","Stop and Exit","Mode","Status","Encoded","Dropped","Notifications","Card"};
static int read_exact(uintptr_t a,void*p,size_t n){return read_memory&&a>=4096&&n&&n<=4096&&a<=UINTPTR_MAX-n&&read_memory(read_context,a,p,n)==1;}
static int word(uintptr_t a,uintptr_t*v){return read_exact(a,v,8);}
static int pins(void){unsigned char b[64];size_t i,j;for(i=0;i<sizeof iq4_f4_menu_pins_03/sizeof*iq4_f4_menu_pins_03;++i){const Iq4F4MenuPin03*p=&iq4_f4_menu_pins_03[i];for(j=0;j<p->length;j+=sizeof b){size_t n=p->length-j;if(n>sizeof b)n=sizeof b;if(!read_exact(p->va+j,b,n)||memcmp(b,p->bytes+j,n))return 0;}}return 1;}
static int on_ui(void){uintptr_t q,v;if(!queue||!iq4_f4_native_current_02(&q)||q!=queue||!word(q,&v)||v!=0xb91f48||!word(manager+8,&v)||v!=q)return 0;return 1;}
static void put(void*p,size_t off,uintptr_t v){memcpy((char*)p+off,&v,8);}
static int present(uintptr_t root,uintptr_t item){uintptr_t head=root+0x28,prev=head,p,tail,vt,next,back,value;unsigned n=0,found=0;
 if(!word(root+0x18,&vt)||vt!=0xb8faa0||!word(root+0x20,&vt)||vt!=0xc22908||!word(head,&vt)||vt!=0xc22960||!word(head+8,&p)||!word(head+16,&tail))return -1;
 while(p!=head){if(!p||(p&7)||++n>64||!word(p,&vt)||vt!=0xb8f958||!word(p+8,&next)||!word(p+16,&back)||back!=prev||!word(p+24,&value))return -1;if(value==item)++found;prev=p;p=next;}
 return prev==tail&&found<=1?(int)found:-1;
}
/* Actual original current-menu getter 4e7628 and ordinary stack tail. */
int iq4_f4_menu_page_guard_03(void*unused){(void)unused;uintptr_t v,node,dialog,top;uint32_t depth;
 if(!on_ui()||held||!selector||!menu||!word(selector,&v)||v!=0xb931b0||!word(selector+0xb0,&v)||v!=manager)return -1;
 if(!word(manager+0x88,&node)||!node||!word(node+24,&dialog))return -1;
 if(dialog!=selector)return 0;
 if(!read_exact(selector+0x470,&depth,4)||depth>7||!word(selector+0x430+8*depth,&top))return -1;
 return top==(uintptr_t)menu?1:0;
}
static Iq4F4UiView03 view(void){Iq4F4UiView03 v={0};if(held){v.phase=IQ4_F4_UI_HOLD;return v;}
 if(connected&&on_ui()&&ports.view_on_ui(ports.context,&v)==1&&v.phase<=IQ4_F4_UI_HOLD)return v;
 memset(&v,0,sizeof v);return v;
}
static char*text(char*b,int32_t n,const char*s){int32_t i=0;if(!b||n<=0)return(char*)"";for(;i+1<n&&s[i];++i)b[i]=s[i];b[i]=0;return b;}
static char*number(char*b,int32_t n,uint64_t v){char d[20];unsigned i=0,j=0;do{d[i++]=(char)('0'+v%10);v/=10;}while(v);if(!b||n<=0)return(char*)"";while(i&&j+1<(unsigned)n)b[j++]=d[--i];b[j]=0;return b;}
static unsigned item_index(void*p){for(unsigned i=0;i<9;++i)if(p==items[i])return i;return 9;}
static char*menu_name(void*p,char*b,int32_t n){(void)p;return text(b,n,"LV Recording");}
static const char*phase(uint32_t n){const char*const s[]={"Unavailable","Ready","Preparing","Recording","Finalizing","Error","Hold"};return n<7?s[n]:"Hold";}
static char*menu_value(void*p,char*b,int32_t n){(void)p;return text(b,n,phase(view().phase));}
static char*item_name(void*p,char*b,int32_t n){unsigned i=item_index(p);return text(b,n,i<9?names[i]:"Unknown");}
static char*item_value(void*p,char*b,int32_t n){unsigned i=item_index(p);Iq4F4UiView03 v=view();
 if(i==3){if(!v.width||!v.height)return text(b,n,"Unavailable");char a[20],h[20],s[48];number(a,sizeof a,v.width);number(h,sizeof h,v.height);size_t k=0;for(size_t j=0;a[j];++j)s[k++]=a[j];s[k++]='x';for(size_t j=0;h[j];++j)s[k++]=h[j];s[k++]=' ';s[k++]='V';s[k++]='F';s[k++]='R';s[k]=0;return text(b,n,s);}
 if(i==4)return text(b,n,phase(v.phase));if(i==5)return number(b,n,v.encoded);if(i==6)return number(b,n,v.dropped);if(i==7)return number(b,n,v.notifications);
 if(i==8)return text(b,n,v.destination_fs_id==10?(v.card_request_held?"SD (held)":"SD"):v.destination_fs_id==11?(v.card_request_held?"XQD (held)":"XQD"):"Unavailable");
 return text(b,n,i==2?"Finalize then return":"");
}
static uint32_t activate(void*p){unsigned i=item_index(p);if((i>2&&i!=8)||!connected||!on_ui()||iq4_f4_menu_page_guard_03(0)!=1||held)return 0;
 if(i==2)exit_pending=1;
 int r=ports.control_on_ui(ports.context,i==8?IQ4_F4_UI_CARD_NEXT:i);if(r==IQ4_F4_UI_UNKNOWN){held=1;return 0;}
 if(i==2&&r==IQ4_F4_UI_COMPLETE){Iq4F4UiView03 v=view();if((v.published_and_owners_released!=1&&v.known_empty_cancelled_and_released!=1)||v.phase!=IQ4_F4_UI_IDLE||iq4_f4_source_fence_02(source)!=IQ4_F4_SRC_OK){held=1;return 0;}
  /* Known finalization uses stock selector Close. Returning zero avoids a
   * second Navigator pop of a selector already removed by stock Close. */
  if(!iq4_f4_menu_close_03((void*)selector))held=1;else exit_pending=0;
 }
 return 0;
}
int iq4_f4_menu_install_03(void*s,void*r,uintptr_t pc,Iq4F4SelfRead02 read,void*ctx){uintptr_t v,q,m;uint32_t title;
 if(pc!=0x4eea5c||!s||!r||((uintptr_t)s&7)||((uintptr_t)r&7)||!read||held||building)return 0;
 if(read_memory&&(read_memory!=read||read_context!=ctx))return 0;read_memory=read;read_context=ctx;
 if(!pins()||!word((uintptr_t)s,&v)||v!=0xb931b0||!word((uintptr_t)r,&v)||v!=0xb8f9b8||!read_exact((uintptr_t)r+0x14,&title,4)||title!=604||
  !word((uintptr_t)s+0xb0,&m)||!m||!word(m,&v)||v!=0xb8f358||!word(m+8,&q)||!q||!word(q,&v)||v!=0xb91f48)return 0;
 if(selector&&(selector!=(uintptr_t)s||manager!=m||parent!=(uintptr_t)r))return 0;
 selector=(uintptr_t)s;manager=m;queue=q;parent=(uintptr_t)r;if(!on_ui())return 0;
 int seen=present(parent,(uintptr_t)menu);if(seen<0)return 0;if(seen)return 1;building=1;
 if(!menu){
  for(unsigned i=0;i<24;++i)if(!word(0xb8f9a8+8*i,&mt[i]))goto fail;
  for(unsigned i=0;i<22;++i)if(!word(0xb90738+8*i,&it[i]))goto fail;
  mt[2+3]=(uintptr_t)menu_name;mt[2+4]=(uintptr_t)menu_value;
  it[2+3]=(uintptr_t)item_name;it[2+4]=(uintptr_t)item_value;it[2+10]=(uintptr_t)activate;
  if(!iq4_f4_menu_new_03(0x118,&menu)||!menu||!iq4_f4_menu_ctor_03(0x4e5744,menu))goto fail;put(menu,0,(uintptr_t)&mt[2]);
  for(unsigned i=0;i<9;++i){if(!iq4_f4_menu_new_03(0x38,&items[i])||!items[i]||!iq4_f4_menu_ctor_03(0x4e9d30,items[i]))goto fail;put(items[i],0,(uintptr_t)&it[2]);if(!iq4_f4_menu_append_03(menu,items[i]))goto fail;}
 }
 if(!iq4_f4_menu_append_03(r,menu)||present(parent,(uintptr_t)menu)!=1)goto fail;building=0;return 1;
 fail:held=1;return 0; /* Retain partial native objects, no retry/free. */
}
int iq4_f4_menu_bind_ports_on_ui_03(const Iq4F4MenuPorts03*a){if(!a||!a->control_on_ui||!a->view_on_ui||!on_ui()||held||connected)return 0;ports=*a;connected=1;return 1;}
int iq4_f4_menu_connect_on_ui_03(void*p,const Iq4F4MenuPorts03*a){if(!p||!a||!a->control_on_ui||!a->view_on_ui||!on_ui()||held||source||
 (connected&&(a->context!=ports.context||a->control_on_ui!=ports.control_on_ui||a->view_on_ui!=ports.view_on_ui)))return 0;
 if(iq4_f4_source_bind_page_guard_on_ui_02(p,iq4_f4_menu_page_guard_03,0)!=IQ4_F4_SRC_OK)return 0;source=p;ports=*a;connected=1;return 1;
}
int iq4_f4_menu_before_native_pop_03(void*nav){if((uintptr_t)nav!=selector+0x128||!connected)return 0;int state=iq4_f4_menu_page_guard_03(0);
 if(state!=1)return 0;int r=source?iq4_f4_source_request_stop_02(source):IQ4_F4_SRC_OK;if(r==IQ4_F4_SRC_HOLD)held=1;
 int control=ports.control_on_ui(ports.context,IQ4_F4_UI_STOP);if(control==IQ4_F4_UI_UNKNOWN)held=1;return 1;
}
int iq4_f4_menu_refresh_on_ui_03(void){return menu&&on_ui()&&!held?iq4_f4_native_event_notify_02((char*)menu+0x60):0;}
int iq4_f4_menu_finish_exit_on_ui_03(void){
 if(!exit_pending||!source||held||!on_ui()||iq4_f4_menu_page_guard_03(0)!=1)return 0;
 Iq4F4UiView03 v=view();if(v.phase!=IQ4_F4_UI_IDLE||(v.published_and_owners_released!=1&&v.known_empty_cancelled_and_released!=1)||iq4_f4_source_fence_02(source)!=IQ4_F4_SRC_OK)return 0;
 if(!iq4_f4_menu_close_03((void*)selector)){held=1;return 0;}exit_pending=0;return 1;
}
int iq4_f4_menu_native_pop_wrapper_03(void*nav){
 if(!iq4_f4_menu_before_native_pop_03(nav))return iq4_f4_menu_pop_passthrough_03(nav);
 int result=0;if(!iq4_f4_menu_pop_03(nav,&result)){held=1;return 0;}return result;
}
