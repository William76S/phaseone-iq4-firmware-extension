#include "../f4_native_entry_04/entry.c"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
static Iq4F4MenuPorts03 captured_ports;static unsigned initializes,starts,stops,acquires,binds;
static void*owned[8];static unsigned allocation_count;static int failure_alloc,failure_init,view_fail,control_unknown,fence_fail;
static int finite_refusal;
static Iq4F4UiView03 actual_view={.phase=IQ4_F4_UI_IDLE,.destination_fs_id=10};
int iq4_native_self_read_01(void*c,uintptr_t p,void*out,size_t n){(void)c;(void)p;(void)out;(void)n;return 0;}
int iq4_f4_menu_new_03(size_t n,void**out){if(failure_alloc){*out=0;return 1;}assert(allocation_count<8);*out=calloc(1,n);assert(*out);owned[allocation_count++]=*out;return 1;}
size_t iq4_f4_source_storage_bytes_02(void){return 16;}
size_t iq4_f4_session_storage_bytes_02(void){return 16;}
int iq4_f4_source_init_02(void*s,size_t n,Iq4F4SelfRead02 rd,void*c,unsigned char*a,size_t bytes,uint32_t count,uint32_t cap){assert(s&&n==16&&rd==iq4_native_self_read_01&&!c&&a&&bytes==16u*1024u*1024u&&count==2&&cap==8u*1024u*1024u);struct Iq4ActivitySnapshot01 x;assert(iq4_activity_snapshot_01(&x)==IQ4_ACTIVITY_OK01&&x.actor==IQ4_ACTIVITY_MOVIE01);++initializes;return failure_init?IQ4_F4_SRC_REJECTED:IQ4_F4_SRC_OK;}
int iq4_f4_movie_binding_init_on_ui_02(Iq4F4MovieBinding02*m,void*s,Iq4F4SelfRead02 r,void*c,uint32_t d,unsigned char*h,size_t hn,unsigned char*p,uint32_t pn,uint64_t max,uint32_t frames){assert(m&&s&&r==iq4_native_self_read_01&&!c&&d==10&&h&&hn==65536&&p&&pn==16u*1024u*1024u&&max==4294967295ull&&frames==1000000);return 1;}
Iq4F4MoviePorts02 iq4_f4_movie_binding_ports_02(Iq4F4MovieBinding02*m){assert(m);Iq4F4MoviePorts02 p={0};return p;}
int iq4_f4_session_init_on_ui_02(void*s,size_t n,void*src,Iq4F4SelfRead02 r,void*c,unsigned char*p,uint32_t pn,int q,const Iq4F4MoviePorts02*m){assert(s&&n==16&&src&&r==iq4_native_self_read_01&&!c&&p&&pn==16u*1024u*1024u&&q==90&&m);return IQ4_F4_UI_COMPLETE;}
static int fake_view(void*c,Iq4F4UiView03*out){assert(c==session);if(view_fail)return 0;*out=actual_view;return 1;}
static int fake_control(void*c,uint32_t action){assert(c==session);if(action==IQ4_F4_UI_START){++starts;++acquires;if(finite_refusal){actual_view=(Iq4F4UiView03){.phase=IQ4_F4_UI_IDLE,.destination_fs_id=10,.known_empty_cancelled_and_released=1};return IQ4_F4_UI_REJECTED;}if(!control_unknown){actual_view.phase=IQ4_F4_UI_RECORDING;actual_view.card_request_held=1;actual_view.published_and_owners_released=actual_view.known_empty_cancelled_and_released=0;}}
 else{++stops;}return control_unknown?IQ4_F4_UI_UNKNOWN:IQ4_F4_UI_PENDING;}
Iq4F4MenuPorts03 iq4_f4_session_menu_ports_02(void*s){assert(s==session);return(Iq4F4MenuPorts03){s,fake_control,fake_view};}
int iq4_f4_menu_connect_on_ui_03(void*s,const Iq4F4MenuPorts03*p){assert(s==source&&p==&lazy_ports);return 1;}
int iq4_f4_menu_install_03(void*s,void*r,uintptr_t pc,Iq4F4SelfRead02 rd,void*c){assert(s==(void*)0x10000&&r==(void*)0x11000&&pc==0x4eea5c&&rd==iq4_native_self_read_01&&!c);return 1;}
int iq4_f4_menu_bind_ports_on_ui_03(const Iq4F4MenuPorts03*p){captured_ports=*p;++binds;return 1;}
int iq4_f4_source_fence_02(void*s){assert(s==source);return fence_fail?IQ4_F4_SRC_HOLD:IQ4_F4_SRC_OK;}
int iq4_f4_source_diagnostics_04(void*p,Iq4F4DiagUnit04*d){assert(p==source);*d=(Iq4F4DiagUnit04){201,201,4};return 1;}
int iq4_f4_session_diagnostics_04(void*p,Iq4F4DiagUnit04*d){assert(p==session);*d=(Iq4F4DiagUnit04){303,0,0};return 1;}
static int action(uint32_t a){return captured_ports.control_on_ui(captured_ports.context,a);}
static int observe(Iq4F4UiView03*out){return captured_ports.view_on_ui(captured_ports.context,out);}
int main(int argc,char**argv){const char*which=argc==2?argv[1]:"normal";Iq4F4UiView03 v;struct Iq4ActivityLease01 jpeg={0};struct Iq4ActivitySnapshot01 x;
 assert(iq4_f4_native_menu_entry_02((void*)0x10000,(void*)0x11000,0x4eea5c,10)&&binds==1);assert(!action(IQ4_F4_UI_STOP));
 if(!strcmp(which,"jpeg-busy")){assert(iq4_activity_try_01(IQ4_ACTIVITY_JPEG01,&jpeg,&jpeg)==IQ4_ACTIVITY_OK01);assert(action(IQ4_F4_UI_START)==IQ4_F4_UI_REJECTED&&!allocation_count&&!initializes&&!starts&&!failed);assert(iq4_activity_release_01(&jpeg)==IQ4_ACTIVITY_OK01);goto done;}
 if(!strcmp(which,"alloc-unknown"))failure_alloc=1;
 if(!strcmp(which,"init-unknown"))failure_init=1;
 if(!strcmp(which,"control-unknown"))control_unknown=1;
 if(!strcmp(which,"finite-refusal")||!strcmp(which,"finite-refusal-unknown")){
  finite_refusal=1;fence_fail=!strcmp(which,"finite-refusal-unknown");
  int result=action(IQ4_F4_UI_START);
  if(fence_fail){assert(result==IQ4_F4_UI_UNKNOWN&&activity_live&&failed);assert(iq4_activity_try_01(IQ4_ACTIVITY_JPEG01,&jpeg,&jpeg)==IQ4_ACTIVITY_HELD01);goto done;}
  assert(result==IQ4_F4_UI_REJECTED&&!activity_live&&!failed&&starts==1);
  assert(iq4_activity_try_01(IQ4_ACTIVITY_JPEG01,&jpeg,&jpeg)==IQ4_ACTIVITY_OK01);
  assert(iq4_activity_release_01(&jpeg)==IQ4_ACTIVITY_OK01);finite_refusal=0;
  assert(action(IQ4_F4_UI_START)==IQ4_F4_UI_PENDING&&activity_live&&!failed&&starts==2&&initializes==1);goto done;
 }
 int r=action(IQ4_F4_UI_START);
 if(failure_alloc||failure_init||control_unknown){Iq4F4Diag04 d;assert(iq4_f4_entry_diagnostics_04(&d));
 assert(d.entry.error==(failure_alloc?101u:failure_init?107u:112u));assert(observe(&v)&&v.phase==IQ4_F4_UI_HOLD&&v.destination_fs_id==10);
 assert(r==IQ4_F4_UI_UNKNOWN&&failed&&activity_live);assert(iq4_activity_snapshot_01(&x)==IQ4_ACTIVITY_OK01&&x.actor==IQ4_ACTIVITY_MOVIE01&&x.held);assert(iq4_activity_try_01(IQ4_ACTIVITY_JPEG01,&jpeg,&jpeg)==IQ4_ACTIVITY_HELD01);goto done;}
 assert(r==IQ4_F4_UI_PENDING&&activity_live&&initializes==1&&starts==1);assert(iq4_activity_try_01(IQ4_ACTIVITY_JPEG01,&jpeg,&jpeg)==IQ4_ACTIVITY_BUSY01);
 if(!strcmp(which,"read-unknown")){view_fail=1;assert(!observe(&v)&&failed);goto held_end;}
 if(!strcmp(which,"session-hold")){actual_view.phase=IQ4_F4_UI_HOLD;assert(observe(&v)&&v.phase==IQ4_F4_UI_HOLD&&failed);goto held_end;}
 actual_view.phase=IQ4_F4_UI_IDLE;
 if(!strcmp(which,"idle-with-card")){actual_view.published_and_owners_released=1;assert(observe(&v)&&activity_live&&!failed);goto done;}
 actual_view.card_request_held=0;
 if(!strcmp(which,"idle-no-fence")){assert(observe(&v)&&activity_live&&!failed);goto done;}
 actual_view.published_and_owners_released=1;
 if(!strcmp(which,"source-fence-unknown")){fence_fail=1;assert(observe(&v)&&v.phase==IQ4_F4_UI_HOLD&&failed);goto held_end;}
 if(!strcmp(which,"empty-cancel")){actual_view.published_and_owners_released=0;actual_view.known_empty_cancelled_and_released=1;}
 assert(observe(&v)&&v.phase==IQ4_F4_UI_IDLE&&!activity_live&&!failed);assert(iq4_activity_try_01(IQ4_ACTIVITY_JPEG01,&jpeg,&jpeg)==IQ4_ACTIVITY_OK01);assert(iq4_activity_release_01(&jpeg)==IQ4_ACTIVITY_OK01);assert(action(IQ4_F4_UI_START)==IQ4_F4_UI_PENDING&&activity_live&&initializes==1&&starts==2);goto done;
 held_end:actual_view.phase=IQ4_F4_UI_RECORDING;actual_view.width=1024;actual_view.height=764;actual_view.encoded=37;actual_view.notifications=99;view_fail=0;assert(observe(&v)&&v.phase==IQ4_F4_UI_HOLD);assert(v.width==1024&&v.height==764&&v.encoded==37&&v.notifications==99&&v.destination_fs_id==10);assert(activity_live&&iq4_activity_snapshot_01(&x)==IQ4_ACTIVITY_OK01&&x.actor==IQ4_ACTIVITY_MOVIE01&&x.held);assert(action(IQ4_F4_UI_START)==IQ4_F4_UI_UNKNOWN&&starts==1);
 done:for(unsigned i=0;i<allocation_count;++i)free(owned[i]);puts("PASS actual entry04 immediate finite-refusal lease release/retry or unknown-fence Hold; session/source are fixtures");return 0;
}
