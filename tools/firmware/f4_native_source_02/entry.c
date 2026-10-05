#include "entry.h"
#include "source.h"
#include "session.h"
#include "movie_binding.h"
#include "../f4_native_menu_03/native_calls.h"
#include "../native_runtime_01/self_read.h"
#include <string.h>
/* Process-lifetime native ownership. Never initialise UI in a constructor,
 * overwrite a vptr on the old page or free an unknown observer/worker. */
static void*source,*session;static unsigned char*arena,*packet,*hash;
static Iq4F4MovieBinding02*movie;static uint32_t destination,initial_destination,ready,failed,building;
static Iq4F4MenuPorts03 lazy_ports;
static int lazy_view(void*ctx,Iq4F4UiView03*out){(void)ctx;if(!out)return 0;
 if(ready){Iq4F4MenuPorts03 p=iq4_f4_session_menu_ports_02(session);return p.view_on_ui(p.context,out);}
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
 fail:failed=1;return 0;
}
static int lazy_action(void*ctx,uint32_t action){(void)ctx;
 if(failed)return IQ4_F4_UI_UNKNOWN;
 if(!ready&&action==IQ4_F4_UI_CARD_NEXT){destination=destination==10?11:10;return IQ4_F4_UI_COMPLETE;}
 if(!ready){if(action!=IQ4_F4_UI_START)return IQ4_F4_UI_REJECTED;if(!initialise())return IQ4_F4_UI_UNKNOWN;}
 Iq4F4MenuPorts03 p=iq4_f4_session_menu_ports_02(session);return p.control_on_ui(p.context,action);
}
int iq4_f4_native_menu_entry_02(void*s,void*r,uintptr_t pc,uint32_t id){
 if((id!=10&&id!=11)||(initial_destination&&initial_destination!=id)||failed)return 0;
 if(!iq4_f4_menu_install_03(s,r,pc,iq4_native_self_read_01,0))return 0;
 if(!initial_destination){initial_destination=destination=id;lazy_ports=(Iq4F4MenuPorts03){0,lazy_action,lazy_view};
  if(!iq4_f4_menu_bind_ports_on_ui_03(&lazy_ports)){failed=1;return 0;}}
 return 1;
}
