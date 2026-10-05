#include "../f4_native_source_02/entry.h"
#include "../f4_native_source_02/source.h"
#include "../f4_native_source_02/session.h"
#include "../f4_native_source_02/movie_binding.h"
#include "../f4_native_menu_03/native_calls.h"
#include "../native_runtime_01/self_read.h"
#include <string.h>
#include "../f4_native_diagnostics_04/diagnostics.h"
#include "../native_activity_01/activity.h"
/* Process-lifetime native ownership. Never initialise UI in a constructor,
 * overwrite a vptr on the old page or free an unknown observer/worker. */
static void*source,*session;static unsigned char*arena,*packet,*hash;
static Iq4F4MovieBinding02*movie;static uint32_t destination,initial_destination,ready,failed,building;
static Iq4F4MenuPorts03 lazy_ports;static Iq4F4UiView03 observed_view;
static Iq4F4DiagUnit04 diagnostic;static unsigned source_attempted,session_attempted;
static void diagnose(uint32_t stage,uint32_t error,uint32_t detail){
 __atomic_store_n(&diagnostic.stage,stage,__ATOMIC_RELEASE);if(error){uint32_t z=0;if(__atomic_compare_exchange_n(&diagnostic.error,&z,error,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))__atomic_store_n(&diagnostic.detail,detail,__ATOMIC_RELEASE);}}

/* Original entry ABI02 is preserved. All lease fields are owned by the actual
 * UI thread; the session/worker never resets or borrows them. */
static struct Iq4ActivityLease01 movie_activity;
static uint32_t activity_live;
static void activity_hold(void){if(activity_live)iq4_activity_hold_01(&movie_activity);failed=1;}
static int ended_activity(const Iq4F4UiView03*v){
 if(!activity_live)return 1;
 if(v->phase==IQ4_F4_UI_HOLD){activity_hold();return 0;}
 if(v->phase!=IQ4_F4_UI_IDLE||v->card_request_held||
  (v->published_and_owners_released!=1&&v->known_empty_cancelled_and_released!=1))return 1;
 /* These completion fields are published only after actual original card
  * release; the actual owned-source fence is independently required here. */
 if(iq4_f4_source_fence_02(source)!=IQ4_F4_SRC_OK||
  iq4_activity_release_01(&movie_activity)!=IQ4_ACTIVITY_OK01){activity_hold();return 0;}
 memset(&movie_activity,0,sizeof movie_activity);activity_live=0;return 1;
}
static int acquire_activity(void){
 if(activity_live){if(iq4_activity_valid_01(&movie_activity)==IQ4_ACTIVITY_OK01)return 1;activity_hold();return 0;}
 struct Iq4ActivityLease01 a={0};int r=iq4_activity_try_01(IQ4_ACTIVITY_MOVIE01,&movie_activity,&a);
 if(r!=IQ4_ACTIVITY_OK01)return 0;movie_activity=a;activity_live=1;return 1;
}
static int lazy_view(void*ctx,Iq4F4UiView03*out){(void)ctx;if(!out)return 0;
 if(failed){
  /* Scalar snapshot only: no action, detach, cleanup or ownership repair. */
  if(ready){Iq4F4MenuPorts03 p=iq4_f4_session_menu_ports_02(session);Iq4F4UiView03 v;
   if(p.view_on_ui(p.context,&v)==1){if(v.destination_fs_id==10||v.destination_fs_id==11)destination=v.destination_fs_id;observed_view=v;}}
  *out=observed_view;out->phase=IQ4_F4_UI_HOLD;out->destination_fs_id=destination;
  if(!out->error)out->error=__atomic_load_n(&diagnostic.error,__ATOMIC_ACQUIRE);return 1;}
 if(ready){Iq4F4MenuPorts03 p=iq4_f4_session_menu_ports_02(session);int r=p.view_on_ui(p.context,out);
  if(!r){diagnose(110,110,1);if(activity_live)activity_hold();return 0;}
  if(out->destination_fs_id==10||out->destination_fs_id==11)destination=out->destination_fs_id;
  else out->destination_fs_id=destination;observed_view=*out;
  if(!ended_activity(out))out->phase=IQ4_F4_UI_HOLD;return r;}
 memset(out,0,sizeof*out);out->phase=failed?IQ4_F4_UI_HOLD:IQ4_F4_UI_UNAVAILABLE;out->destination_fs_id=destination;return 1;
}
static int allocate(size_t n,void**out){if(!iq4_f4_menu_new_03(n,out)||!*out||((uintptr_t)*out&15)!=0)return 0;memset(*out,0,n);return 1;}
static int initialise(void){if(ready)return 1;if(failed||building)return 0;building=1;
 /* 2*8MiB owned RGB slots: actual higher modes are rejected, never rescaled.
  * 16MiB bounded JPEG and independent64KiB whole-file hash scratch. Native
  * allocators are called before any source Lock; failure retains partials. */
 const uint32_t cap=8u*1024u*1024u,packet_cap=16u*1024u*1024u;
 diagnose(101,0,0);if(!allocate(iq4_f4_source_storage_bytes_02(),&source))goto fail;
 diagnose(102,0,0);if(!allocate(iq4_f4_session_storage_bytes_02(),&session))goto fail;
 diagnose(103,0,0);if(!allocate(2u*cap,(void**)&arena))goto fail;
 diagnose(104,0,0);if(!allocate(packet_cap,(void**)&packet))goto fail;
 diagnose(105,0,0);if(!allocate(65536,(void**)&hash))goto fail;
 diagnose(106,0,0);if(!allocate(sizeof*movie,(void**)&movie))goto fail;
 diagnose(107,0,0);source_attempted=1;
 if(iq4_f4_source_init_02(source,iq4_f4_source_storage_bytes_02(),iq4_native_self_read_01,0,arena,2u*cap,2,cap)!=IQ4_F4_SRC_OK)goto fail;
 diagnose(108,0,0);if(!iq4_f4_movie_binding_init_on_ui_02(movie,source,iq4_native_self_read_01,0,destination,hash,65536,packet,packet_cap,UINT64_C(4294967295),1000000))goto fail;
 Iq4F4MoviePorts02 m=iq4_f4_movie_binding_ports_02(movie);diagnose(109,0,0);session_attempted=1;
 if(iq4_f4_session_init_on_ui_02(session,iq4_f4_session_storage_bytes_02(),source,iq4_native_self_read_01,0,packet,packet_cap,90,&m)!=IQ4_F4_UI_COMPLETE)goto fail;
 diagnose(110,0,0);if(!iq4_f4_menu_connect_on_ui_03(source,&lazy_ports))goto fail;
 ready=1;building=0;diagnose(111,0,0);return 1;
 fail:{uint32_t step=__atomic_load_n(&diagnostic.stage,__ATOMIC_ACQUIRE);diagnose(step,step,1);activity_hold();return 0;}
}
static int lazy_action(void*ctx,uint32_t action){(void)ctx;
 if(failed)return IQ4_F4_UI_UNKNOWN;
 if(ready){Iq4F4UiView03 v;if(!lazy_view(0,&v)||failed)return IQ4_F4_UI_UNKNOWN;}
 /* Try before source initialization or real card request. A JPEG actor's
  * refusal does not initialize the source, consume a mode or steal its lease. */
 if(action==IQ4_F4_UI_START&&!acquire_activity())return failed?IQ4_F4_UI_UNKNOWN:IQ4_F4_UI_REJECTED;
 if(!ready&&action==IQ4_F4_UI_CARD_NEXT){destination=destination==10?11:10;return IQ4_F4_UI_COMPLETE;}
 if(!ready){if(action!=IQ4_F4_UI_START)return IQ4_F4_UI_REJECTED;if(!initialise())return IQ4_F4_UI_UNKNOWN;}
 Iq4F4MenuPorts03 p=iq4_f4_session_menu_ports_02(session);int r=p.control_on_ui(p.context,action);
 if(r==IQ4_F4_UI_UNKNOWN){diagnose(112,112,1);activity_hold();return r;}
 Iq4F4UiView03 v;if(!p.view_on_ui(p.context,&v)){diagnose(112,112,2);activity_hold();return IQ4_F4_UI_UNKNOWN;}
 if(v.destination_fs_id==10||v.destination_fs_id==11)destination=v.destination_fs_id;else v.destination_fs_id=destination;observed_view=v;
 if(!ended_activity(&v))return IQ4_F4_UI_UNKNOWN;
 return r;
}
int iq4_f4_native_menu_entry_02(void*s,void*r,uintptr_t pc,uint32_t id){
 if((id!=10&&id!=11)||(initial_destination&&initial_destination!=id)||failed)return 0;
 if(!iq4_f4_menu_install_03(s,r,pc,iq4_native_self_read_01,0))return 0;
 if(!initial_destination){initial_destination=destination=id;lazy_ports=(Iq4F4MenuPorts03){0,lazy_action,lazy_view};
  if(!iq4_f4_menu_bind_ports_on_ui_03(&lazy_ports)){failed=1;return 0;}}
 return 1;
}

int iq4_f4_entry_diagnostics_04(Iq4F4Diag04*out){if(!out)return 0;memset(out,0,sizeof*out);
 out->entry.stage=__atomic_load_n(&diagnostic.stage,__ATOMIC_ACQUIRE);out->entry.error=__atomic_load_n(&diagnostic.error,__ATOMIC_ACQUIRE);out->entry.detail=__atomic_load_n(&diagnostic.detail,__ATOMIC_ACQUIRE);
 if(source_attempted)iq4_f4_source_diagnostics_04(source,&out->source);
 if(session_attempted)iq4_f4_session_diagnostics_04(session,&out->session);return 1;}
