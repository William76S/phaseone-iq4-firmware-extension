#include "../f4_native_menu_03/menu.h"
#include "../f4_native_menu_03/native_calls.h"
#include "../f4_native_source_02/native_calls.h"
#include "../f4_native_menu_03/code_pins.h"
#include <assert.h>
#include "../f4_native_diagnostics_04/diagnostics.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
enum {Q=0x10000,M=0x12000,S=0x14000,R=0x16000};
static unsigned char memory[0x8000];static void*allocated[32];static size_t sizes[32];static unsigned used,new_calls,fail_new;
static int unknown_control;static int badpin,wrongtid,requests,actions,pops,passthroughs,closes,source_fence,result=1;static Iq4F4UiView03 current;
static void put(uintptr_t p,uint64_t v,size_t n){memcpy(memory+(p-Q),&v,n);}
static uint64_t get(uintptr_t p,size_t n){uint64_t v=0;memcpy(&v,memory+(p-Q),n);return v;}
static int readself(void*c,uintptr_t p,void*out,size_t n){(void)c;
 for(size_t i=0;i<sizeof iq4_f4_menu_pins_03/sizeof*iq4_f4_menu_pins_03;++i){const Iq4F4MenuPin03*x=&iq4_f4_menu_pins_03[i];if(p>=x->va&&p+n<=x->va+x->length){memcpy(out,x->bytes+p-x->va,n);if(badpin)((unsigned char*)out)[0]^=1;return 1;}}
 if(p>=Q&&p+n<=Q+sizeof memory){memcpy(out,memory+(p-Q),n);return 1;}
 for(unsigned i=0;i<used;++i)if(p>=(uintptr_t)allocated[i]&&p+n<=(uintptr_t)allocated[i]+sizes[i]){memcpy(out,(void*)p,n);return 1;}return 0;
}
int iq4_f4_native_current_02(uintptr_t*p){*p=wrongtid?0:Q;return 1;}
int iq4_f4_menu_new_03(size_t n,void**p){++new_calls;if(fail_new==new_calls){*p=0;return 1;}assert(used<32);*p=calloc(1,n);allocated[used]=*p;sizes[used++]=n;return 1;}
static void memput(void*p,size_t o,uint64_t v,size_t n){memcpy((char*)p+o,&v,n);}
int iq4_f4_menu_ctor_03(uintptr_t f,void*p){if(f==0x4e5744){memput(p,0,0xb8f9b8,8);memput(p,0x18,0xb8faa0,8);memput(p,0x20,0xc22908,8);memput(p,0x28,0xc22960,8);memput(p,0x30,(uintptr_t)p+0x28,8);memput(p,0x38,(uintptr_t)p+0x28,8);}else{assert(f==0x4e9d30);memput(p,0,0xb90748,8);}return 1;}
int iq4_f4_menu_append_03(void*parent,void*item){void*node;assert(iq4_f4_menu_new_03(32,&node)&&node);uintptr_t h=(uintptr_t)parent+0x28,tail;assert(readself(0,h+16,&tail,8));
 memput(node,0,0xb8f958,8);memput(node,8,h,8);memput(node,16,tail,8);memput(node,24,(uintptr_t)item,8);
 if(tail>=Q&&tail<Q+sizeof memory)put(tail+8,(uintptr_t)node,8);else memput((void*)tail,8,(uintptr_t)node,8);
 if(h>=Q&&h<Q+sizeof memory)put(h+16,(uintptr_t)node,8);else memput((void*)h,16,(uintptr_t)node,8);return 1;}
int iq4_f4_menu_close_03(void*p){assert(p==(void*)S);++closes;put(M+0x88,M+0x78,8);return 1;}
int iq4_f4_menu_pop_03(void*p,int*r){assert(p==(void*)(S+0x128));++pops;*r=result;return 1;}
int iq4_f4_menu_pop_passthrough_03(void*p){assert(p);++passthroughs;return result;}
int iq4_f4_native_event_notify_02(void*p){assert(p);return 1;}
int iq4_f4_source_bind_page_guard_on_ui_02(void*p,Iq4F4PageGuard02 g,void*c){assert(p==(void*)1&&g&&g(c)==1);return 0;}
int iq4_f4_source_request_stop_02(void*p){assert(p==(void*)1);++requests;return 6;}
int iq4_f4_source_fence_02(void*p){assert(p==(void*)1);return source_fence;}
static int control(void*p,uint32_t a){assert(p==(void*)2);actions++;if(unknown_control)return IQ4_F4_UI_UNKNOWN;if(a==2)return current.published_and_owners_released?2:1;return 1;}
static int view(void*p,Iq4F4UiView03*out){assert(p==(void*)2);*out=current;return 1;}
int iq4_f4_entry_diagnostics_04(Iq4F4Diag04*d){*d=(Iq4F4Diag04){{112,112,1},{214,214,1},{303,0,0}};return 1;}
static uintptr_t ownitem(uintptr_t menu,unsigned index){uintptr_t p,item;assert(readself(0,menu+0x30,&p,8));for(unsigned j=0;j<index;++j)assert(readself(0,p+8,&p,8));assert(readself(0,p+24,&item,8));return item;}
static void valuecheck(uintptr_t menu,unsigned i,const char*expected){uintptr_t item=ownitem(menu,i),vt,fun;char out[32];memset(out,0xa5,sizeof out);memcpy(&vt,(void*)item,8);memcpy(&fun,(void*)(vt+0x20),8);assert(((char*(*)(void*,char*,int32_t))fun)((void*)item,out,32)==out&&strcmp(out,expected)==0&&out[31]==(char)0xa5);}
int main(int argc,char**argv){(void)argv;unsigned groups=0;
 assert(iq4_f4_menu_native_pop_wrapper_03((void*)8)==1&&passthroughs==1&&requests==0&&actions==0);++groups;
 put(Q,0xb91f48,8);put(M,0xb8f358,8);put(M+8,Q,8);put(S,0xb931b0,8);put(S+0xb0,M,8);put(R,0xb8f9b8,8);put(R+0x14,604,4);
 put(R+0x18,0xb8faa0,8);put(R+0x20,0xc22908,8);put(R+0x28,0xc22960,8);put(R+0x30,R+0x28,8);put(R+0x38,R+0x28,8);
 if(argc>1){fail_new=1;assert(iq4_f4_menu_install_03((void*)S,(void*)R,0x4eea5c,readself,0)==0);assert(get(R+0x30,8)==R+0x28);assert(iq4_f4_menu_install_03((void*)S,(void*)R,0x4eea5c,readself,0)==0);puts("heap failure retained/no install/no retry PASS");return 0;}
 badpin=1;assert(!iq4_f4_menu_install_03((void*)S,(void*)R,0x4eea5c,readself,0));badpin=0;++groups;
 assert(!iq4_f4_menu_install_03((void*)S,(void*)R,0x4ee784,readself,0));++groups;
 assert(iq4_f4_menu_install_03((void*)S,(void*)R,0x4eea5c,readself,0));uintptr_t node=get(R+0x30,8),menu;assert(readself(0,node+24,&menu,8));assert(iq4_f4_menu_install_03((void*)S,(void*)R,0x4eea5c,readself,0));assert(get(R+0x30,8)==node);++groups;
 put(M+0x88,S+0x88,8);put(S+0xa0,S,8);put(S+0x470,1,4);put(S+0x438,menu,8);assert(iq4_f4_menu_page_guard_03(0)==1);Iq4F4MenuPorts03 ports={(void*)2,control,view};assert(iq4_f4_menu_bind_ports_on_ui_03(&ports));assert(iq4_f4_menu_connect_on_ui_03((void*)1,&ports));++groups;
 assert(iq4_f4_menu_native_pop_wrapper_03((void*)(S+0x128))==1&&pops==1&&requests==1&&actions==1);result=0;assert(iq4_f4_menu_native_pop_wrapper_03((void*)(S+0x128))==0&&pops==2);++groups;
 uintptr_t item_node,item,vt,activate;assert(readself(0,menu+0x30,&item_node,8));for(unsigned i=0;i<2;++i)assert(readself(0,item_node+8,&item_node,8));assert(readself(0,item_node+24,&item,8));memcpy(&vt,(void*)item,8);memcpy(&activate,(void*)(vt+0x50),8);
 current.phase=IQ4_F4_UI_FINALIZING;assert(((uint32_t(*)(void*))activate)((void*)item)==0&&closes==0);++groups;
 current.phase=IQ4_F4_UI_IDLE;current.published_and_owners_released=1;source_fence=6;assert(!iq4_f4_menu_finish_exit_on_ui_03()&&closes==0);source_fence=0;assert(iq4_f4_menu_finish_exit_on_ui_03()&&closes==1);assert(!iq4_f4_menu_finish_exit_on_ui_03()&&closes==1);++groups;
 put(M+0x88,S+0x88,8);assert(((uint32_t(*)(void*))activate)((void*)item)==0&&closes==2);++groups;
 assert(iq4_f4_menu_page_guard_03(0)==0);wrongtid=1;assert(iq4_f4_menu_page_guard_03(0)==-1);++groups;
 int prior_requests=requests,prior_actions=actions;assert(iq4_f4_menu_native_pop_wrapper_03((void*)(S+0x128))==0&&passthroughs==2&&requests==prior_requests&&actions==prior_actions);++groups;
 wrongtid=0;put(M+0x88,S+0x88,8);current=(Iq4F4UiView03){.phase=IQ4_F4_UI_RECORDING,.width=1024,.height=764,.encoded=37,.dropped=2,.notifications=99,.destination_fs_id=11,.card_request_held=1};
 valuecheck(menu,3,"1024x764 VFR");valuecheck(menu,8,"XQD (held)");unknown_control=1;uintptr_t start=ownitem(menu,0);memcpy(&vt,(void*)start,8);memcpy(&activate,(void*)(vt+0x50),8);
 assert(((uint32_t(*)(void*))activate)((void*)start)==0);int held_actions=actions;
 valuecheck(menu,3,"1024x764 VFR");valuecheck(menu,4,"Hold");valuecheck(menu,5,"37");valuecheck(menu,7,"99");valuecheck(menu,8,"XQD (held)");valuecheck(menu,9,"112/112");valuecheck(menu,10,"214/214");valuecheck(menu,11,"303/0");valuecheck(menu,13,"04 / scalar snapshot");
 assert(((uint32_t(*)(void*))activate)((void*)start)==0&&actions==held_actions);++groups;
 for(unsigned i=0;i<used;++i)free(allocated[i]);printf("%u native menu ABI/fault groups PASS; simulated calls only\n",groups);return 0;}
