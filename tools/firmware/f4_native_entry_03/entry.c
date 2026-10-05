#include "../f4_native_source_02/entry.h"
#include "../f4_native_source_02/source.h"
#include "../f4_native_source_02/session.h"
#include "../f4_native_source_02/movie_binding.h"
#include "../f4_native_menu_03/native_calls.h"
#include "../native_runtime_01/self_read.h"
#include <string.h>
#include "../native_activity_01/activity.h"
/* Process-lifetime native ownership. Never initialise UI in a constructor,
 * overwrite a vptr on the old page or free an unknown observer/worker. */
static void*source,*session;static unsigned char*arena,*packet,*hash;
static Iq4F4MovieBinding02*movie;static uint32_t destination,initial_destination,ready,failed,building;
static Iq4F4MenuPorts03 lazy_ports;
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
 if(failed){memset(out,0,sizeof*out);out->phase=IQ4_F4_UI_HOLD;out->destination_fs_id=destination;return 1;}
 if(ready){Iq4F4MenuPorts03 p=iq4_f4_session_menu_ports_02(session);int r=p.view_on_ui(p.context,out);
  if(!r){if(activity_live)activity_hold();return 0;}if(!ended_activity(out))out->phase=IQ4_F4_UI_HOLD;return r;}
 memset(out,0,sizeof*out);out->phase=failed?IQ4_F4_UI_HOLD:IQ4_F4_UI_UNAVAILABLE;out->destination_fs_id=destination;return 1;
}
static int allocate(size_t n,void**out){return iq4_f4_menu_new_03(n,out)&&*out&&((uintptr_t)*out&15)==0;}
static int initialise(void){if(ready)return 1;if(failed||building)return 0;building=1;
 /* 2*8MiB owned RGB slots: actual higher modes are rejected, never rescaled.
  * 16MiB bounded JPEG and independent64KiB whole-file hash scratch. Native
  * allocators are called before any source Lock; failure retains partials. */
 const uint32_t cap=8u*1024u*1024u,packet_cap=16u*1024u*1024u;
 if(!allocate(iq4_f4_source_storage_bytes_02(),&source)||!allocate(iq4_f4_session_storage_bytes_02(),&session)||
  !allocate(2u*cap,(void**)&arena)||!allocate(packet_cap,(void**)&packet)||!allocate(65536,(void**)&hash)||!allocate(sizeof*movie,(void**)&movie))goto fail;
 if(iq4_f4_source_init_02(source,iq4_f4_source_storage_bytes_02(),iq4_native_self_read_01,0,arena,2u*cap,2,cap)!=IQ4_F4_SRC_OK)goto fail;
 if(!iq4_f4_movie_binding_init_on_ui_02(movie,source,iq4_native_self_read_01,0,destination,hash,65536,packet,packet_cap,UINT64_C(4294967295),1000000))goto fail;
 Iq4F4MoviePorts02 m=iq4_f4_movie_binding_ports_02(movie);
 if(iq4_f4_session_init_on_ui_02(session,iq4_f4_session_storage_bytes_02(),source,iq4_native_self_read_01,0,packet,packet_cap,90,&m)!=IQ4_F4_UI_COMPLETE)goto fail;
 if(!iq4_f4_menu_connect_on_ui_03(source,&lazy_ports))goto fail;
 ready=1;building=0;return 1;
 fail:activity_hold();return 0;
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
 if(r==IQ4_F4_UI_UNKNOWN){activity_hold();return r;}
 Iq4F4UiView03 v;if(!p.view_on_ui(p.context,&v)){activity_hold();return IQ4_F4_UI_UNKNOWN;}
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
