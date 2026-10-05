#include "liveness.h"
#include "../f4_native_source_02/session.h"
#include "../f4_native_source_02/thread_calls.h"
#include "../f4_native_source_02/native_calls.h"
#include <string.h>
#include "../f4_native_diagnostics_04/diagnostics.h"
#define MAGIC UINT64_C(0x4951344634534532)
enum {W_IDLE,W_PREPARING,W_PREPARED,W_RECORDING,W_STOPPING,W_COMPLETE,W_HOLD,W_RETURNED};
enum {C_IDLE,C_PREPARE,C_RECORD,C_STOP,C_SHUTDOWN};
struct Iq4F4Session02 {uint64_t magic;void*source;Iq4F4SelfRead02 read;void*read_context;
 unsigned char*packet;uint32_t packet_capacity;int quality;Iq4F4MoviePorts02 movie;
 struct Iq4Mkv *mux;Iq4F4Worker02 worker;Iq4F4FrameMetadata02 measured;
 uint64_t thread_id;uint32_t created,joined,wake,command,worker_state,stop_desired;
 uint32_t ui_phase,ui_preparing,card_ready,error,hold,published,owners_released;
 uint64_t encoded;uint32_t worker_error,worker_published;Iq4F4DiagUnit04 diagnostic;
};
static uint32_t load(uint32_t*p){return __atomic_load_n(p,__ATOMIC_ACQUIRE);}
static void store(uint32_t*p,uint32_t v){__atomic_store_n(p,v,__ATOMIC_RELEASE);}
static void diagnose(Iq4F4Session02*s,uint32_t stage,uint32_t error,uint32_t detail){
 store(&s->diagnostic.stage,stage);if(error){uint32_t z=0;if(__atomic_compare_exchange_n(&s->diagnostic.error,&z,error,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))store(&s->diagnostic.detail,detail);}}
static void wake(void*p){Iq4F4Session02*s=p;iq4_f4_thread_wake_02(&s->wake);}
static void hold(Iq4F4Session02*s){store(&s->hold,1);store(&s->worker_state,W_HOLD);store(&s->ui_preparing,0);iq4_f4_source_request_stop_02(s->source);}
static int ui(Iq4F4Session02*s){return s&&s->magic==MAGIC&&iq4_f4_source_is_ui_02(s->source);}
static int same_mode(const Iq4F4FrameMetadata02*a,const Iq4F4FrameMetadata02*b){return
 a->width==b->width&&a->height==b->height&&a->stride==b->stride&&a->bytes==b->bytes&&a->channels==b->channels&&
 a->configuration_width==b->configuration_width&&a->configuration_height==b->configuration_height&&a->configuration_bytes==b->configuration_bytes&&
 !memcmp(a->component_map,b->component_map,sizeof a->component_map);}
static void request(Iq4F4Session02*s,uint32_t cmd){store(&s->command,cmd);wake(s);}
static int post(Iq4F4Session02*s){if(iq4_f4_source_post_control_02(s->source)==IQ4_F4_SRC_HOLD){hold(s);return 0;}return 1;}
static int action(void*p,uint32_t action);
/* A finite refusal before worker preparation owns no movie file. The card
 * adapter's FAIL contract has already released its requests. Detach our frame
 * listener and prove quiescence so the entry can release the activity lease.
 * Unknown detach/ownership is never converted into a retryable refusal. */
static int refuse_before_prepare(Iq4F4Session02*s){
 if(load(&s->worker_state)!=W_IDLE||load(&s->command)!=C_IDLE||s->card_ready){hold(s);return IQ4_F4_UI_UNKNOWN;}
 store(&s->ui_preparing,0);
 if(iq4_f4_source_stop_on_ui_02(s->source)!=IQ4_F4_SRC_OK||
    iq4_f4_source_fence_02(s->source)!=IQ4_F4_SRC_OK){hold(s);return IQ4_F4_UI_UNKNOWN;}
 s->error=s->published=0;s->owners_released=1;s->ui_phase=IQ4_F4_UI_IDLE;
 __atomic_store_n(&s->encoded,0,__ATOMIC_RELEASE);return IQ4_F4_UI_REJECTED;
}
/* Called only from Source's actual original UI ControlEvent observer. */
static void control(void*p){Iq4F4Session02*s=p;if(!ui(s)){hold(s);return;}if(load(&s->hold))return;
 /* The persistent worker posts this event even if the stock LV has stopped
  * producing notifications. Normal page departure must not wait for a frame. */
 if(s->ui_phase==IQ4_F4_UI_PREPARING||s->ui_phase==IQ4_F4_UI_RECORDING){
  int page=iq4_f4_menu_page_guard_03(0);if(page<0){hold(s);return;}
  int native_owned=iq4_f4_source_native_owned_on_ui_06(s->source);
  if(native_owned<0){diagnose(s,323,323,1);hold(s);return;}
  if((page==0||native_owned==0)&&action(s,IQ4_F4_UI_STOP)==IQ4_F4_UI_UNKNOWN)return;
 }
 uint32_t state=load(&s->worker_state);
 if(load(&s->ui_preparing)&&!s->card_ready){int r=s->movie.poll_on_ui(s->movie.context);
  if(r==IQ4_F4_MOVIE_UNKNOWN){diagnose(s,321,321,1);hold(s);return;}if(r==IQ4_F4_MOVIE_FAIL){diagnose(s,321,321,3);refuse_before_prepare(s);iq4_f4_menu_refresh_on_ui_03();iq4_f4_menu_finish_exit_on_ui_03();return;}
  if(r==IQ4_F4_MOVIE_READY){s->card_ready=1;request(s,C_PREPARE);}else if(r!=IQ4_F4_MOVIE_PENDING){hold(s);return;}
 }
 if(state==W_PREPARED&&load(&s->command)==C_PREPARE){
  Iq4F4FrameMetadata02 now;int page=iq4_f4_menu_page_guard_03(0);
  if(page<0){hold(s);return;}
  if(!load(&s->stop_desired)&&page==1&&iq4_f4_source_measure_on_ui_02(s->source,&now)==IQ4_F4_SRC_OK&&same_mode(&now,&s->measured)&&
   iq4_f4_source_start_on_ui_02(s->source,&now)==IQ4_F4_SRC_OK){s->ui_phase=IQ4_F4_UI_RECORDING;store(&s->ui_preparing,0);request(s,C_RECORD);}
  else{store(&s->stop_desired,1);int r=iq4_f4_source_stop_on_ui_02(s->source);if(r==IQ4_F4_SRC_HOLD){hold(s);return;}
   s->ui_phase=IQ4_F4_UI_FINALIZING;store(&s->ui_preparing,0);request(s,C_STOP);}
 }
 if(s->card_ready&&(state==W_STOPPING||state==W_COMPLETE)){
  int r=iq4_f4_source_stop_on_ui_02(s->source);if(r==IQ4_F4_SRC_HOLD){hold(s);return;}
  s->ui_phase=IQ4_F4_UI_FINALIZING;store(&s->ui_preparing,0);
 }
 if(state==W_COMPLETE&&s->card_ready){
  if(iq4_f4_source_fence_02(s->source)!=IQ4_F4_SRC_OK){hold(s);return;}
  int r=s->movie.release_on_ui(s->movie.context);if(r!=IQ4_F4_MOVIE_READY){hold(s);return;}
  s->owners_released=1;s->card_ready=0;s->published=load(&s->worker_published);s->error=load(&s->worker_error);
  s->ui_phase=s->error?IQ4_F4_UI_ERROR:IQ4_F4_UI_IDLE;request(s,C_IDLE);
 }
 if(load(&s->worker_state)==W_HOLD){hold(s);return;}
 iq4_f4_menu_refresh_on_ui_03();iq4_f4_menu_finish_exit_on_ui_03();
}
static int drain(Iq4F4Session02*s){Iq4F4OwnedFrame02 f;int r=iq4_f4_source_worker_claim_02(s->source,&f);
 if(r==IQ4_F4_SRC_EMPTY)return 0;if(r!=IQ4_F4_SRC_OK||iq4_f4_source_worker_release_02(s->source,&f)!=IQ4_F4_SRC_OK){hold(s);return -1;}return 1;}
static void finish(Iq4F4Session02*s,int normal){
 if(iq4_f4_source_fence_02(s->source)!=IQ4_F4_SRC_OK)return;
 if(normal&&(!s->mux||s->mux->state!=IQ4_MKV_WRITING)){store(&s->worker_error,3);normal=0;}
 uint32_t published=0;int r=s->movie.finalize_on_worker(s->movie.context,s->mux,normal,&published);
 if(r==IQ4_F4_MOVIE_UNKNOWN||r==IQ4_F4_MOVIE_PENDING||published>1){diagnose(s,332,332,(uint32_t)r);hold(s);return;}
 if(r!=IQ4_F4_MOVIE_READY){store(&s->worker_error,4);if(r!=IQ4_F4_MOVIE_FAIL){hold(s);return;}}
 if(normal&&!published)store(&s->worker_error,4);
 store(&s->worker_published,published);store(&s->worker_state,W_COMPLETE);post(s);
}
static void*run(void*p){Iq4F4Session02*s=p;uint64_t last_post=0;
 for(;;){uint32_t mark=load(&s->wake),cmd=load(&s->command),state=load(&s->worker_state);
  if(load(&s->hold)){iq4_f4_thread_wait_02(&s->wake,mark);continue;}
  if(cmd==C_SHUTDOWN&&state==W_IDLE){store(&s->worker_state,W_RETURNED);return s;}
  if(cmd==C_PREPARE&&state==W_IDLE){diagnose(s,330,0,0);store(&s->worker_state,W_PREPARING);
   s->mux=0;int r=s->movie.prepare_on_worker(s->movie.context,s->measured.width,s->measured.height,&s->mux);
   if(r==IQ4_F4_MOVIE_UNKNOWN||r==IQ4_F4_MOVIE_PENDING){diagnose(s,330,330,(uint32_t)r);hold(s);continue;}
   if(r==IQ4_F4_MOVIE_READY&&s->mux&&s->mux->state==IQ4_MKV_WRITING&&s->mux->width==s->measured.width&&s->mux->height==s->measured.height&&s->mux->max_packet_bytes<=s->packet_capacity&&
    iq4_f4_worker_init_02(&s->worker,s->source,s->mux,s->packet,s->packet_capacity,s->quality,s->read,s->read_context)==IQ4_F4_WORKER_PACKET){store(&s->worker_state,W_PREPARED);post(s);}
   else{store(&s->worker_error,2);store(&s->worker_state,W_STOPPING);iq4_f4_source_request_stop_02(s->source);post(s);request(s,C_STOP);}
  }else if(cmd==C_RECORD&&(state==W_PREPARED||state==W_RECORDING)){store(&s->worker_state,W_RECORDING);
   int r=iq4_f4_worker_pump_one_02(&s->worker);__atomic_store_n(&s->encoded,s->worker.encoded,__ATOMIC_RELEASE);
   if(r==IQ4_F4_WORKER_HOLD){diagnose(s,331,331,1);hold(s);continue;}
   if(r!=IQ4_F4_WORKER_PACKET&&r!=IQ4_F4_WORKER_EMPTY){store(&s->worker_error,(uint32_t)r);store(&s->worker_state,W_STOPPING);iq4_f4_source_request_stop_02(s->source);request(s,C_STOP);post(s);}
   if(r==IQ4_F4_WORKER_PACKET)continue;
  }else if(cmd==C_STOP&&(state==W_PREPARED||state==W_RECORDING||state==W_STOPPING)){
   store(&s->worker_state,W_STOPPING);
   if(!load(&s->worker_error)&&s->worker.ready){int r=iq4_f4_worker_pump_one_02(&s->worker);__atomic_store_n(&s->encoded,s->worker.encoded,__ATOMIC_RELEASE);
    if(r==IQ4_F4_WORKER_HOLD){hold(s);continue;}if(r==IQ4_F4_WORKER_PACKET)continue;
    if(r!=IQ4_F4_WORKER_EMPTY)store(&s->worker_error,(uint32_t)r);
   }
   if(load(&s->worker_error)){int r=drain(s);if(r)continue;}
   int f=iq4_f4_source_fence_02(s->source);if(f==IQ4_F4_SRC_HOLD){hold(s);continue;}
   if(f==IQ4_F4_SRC_OK)finish(s,!load(&s->worker_error)&&s->worker.encoded>0);
  }else if(cmd==C_IDLE&&state==W_COMPLETE){memset(&s->worker,0,sizeof s->worker);store(&s->worker_state,W_IDLE);}
  uint64_t ns=iq4_f4_native_clock_02();if(!ns){hold(s);continue;}
  if((load(&s->ui_preparing)||load(&s->worker_state)==W_RECORDING||load(&s->worker_state)==W_STOPPING)&&ns-last_post>=200000000){last_post=ns;post(s);}
  iq4_f4_thread_wait_02(&s->wake,mark);
 }
}
static int action(void*p,uint32_t action){Iq4F4Session02*s=p;if(!ui(s)||action>IQ4_F4_UI_CARD_NEXT)return IQ4_F4_UI_REJECTED;if(load(&s->hold))return IQ4_F4_UI_UNKNOWN;
 if(action==IQ4_F4_UI_CARD_NEXT){if(load(&s->worker_state)!=W_IDLE||load(&s->command)!=C_IDLE||load(&s->ui_preparing)||s->card_ready)return IQ4_F4_UI_REJECTED;
  if(iq4_f4_source_stop_on_ui_02(s->source)!=IQ4_F4_SRC_OK)return IQ4_F4_UI_REJECTED;
  uint32_t id=s->movie.destination_on_ui(s->movie.context);if(id!=10&&id!=11){hold(s);return IQ4_F4_UI_UNKNOWN;}
  int r=s->movie.set_destination_on_ui(s->movie.context,id==10?11:10);if(r==IQ4_F4_MOVIE_UNKNOWN){hold(s);return IQ4_F4_UI_UNKNOWN;}return r==IQ4_F4_MOVIE_READY?IQ4_F4_UI_COMPLETE:IQ4_F4_UI_REJECTED;
 }
 if(action==IQ4_F4_UI_START){if(load(&s->worker_state)!=W_IDLE||load(&s->ui_preparing)||s->card_ready||load(&s->command)!=C_IDLE)return IQ4_F4_UI_REJECTED;
  diagnose(s,320,0,0);Iq4F4SourceStatus02 source_state=iq4_f4_source_status_on_ui_02(s->source);
  if(source_state.held_uncertain){diagnose(s,320,320,1);hold(s);return IQ4_F4_UI_UNKNOWN;}
  int r=source_state.attached==1?IQ4_F4_SRC_OK:iq4_f4_source_attach_on_ui_02(s->source);
  if(r!=IQ4_F4_SRC_OK){diagnose(s,320,320,1);if(r==IQ4_F4_SRC_HOLD){hold(s);return IQ4_F4_UI_UNKNOWN;}return refuse_before_prepare(s);}
  if(iq4_f4_source_measure_on_ui_02(s->source,&s->measured)!=IQ4_F4_SRC_OK){diagnose(s,320,320,2);return refuse_before_prepare(s);}
  s->error=s->published=s->owners_released=0;store(&s->worker_error,0);store(&s->worker_published,0);store(&s->stop_desired,0);__atomic_store_n(&s->encoded,0,__ATOMIC_RELEASE);
  diagnose(s,321,0,0);r=s->movie.acquire_on_ui(s->movie.context);if(r==IQ4_F4_MOVIE_UNKNOWN){diagnose(s,321,321,2);hold(s);return IQ4_F4_UI_UNKNOWN;}
  if(r==IQ4_F4_MOVIE_FAIL){diagnose(s,321,321,4);return refuse_before_prepare(s);}
  if(r!=IQ4_F4_MOVIE_READY&&r!=IQ4_F4_MOVIE_PENDING){hold(s);return IQ4_F4_UI_UNKNOWN;}
  s->ui_phase=IQ4_F4_UI_PREPARING;store(&s->ui_preparing,1);if(r==IQ4_F4_MOVIE_READY){s->card_ready=1;request(s,C_PREPARE);}else wake(s);
  return IQ4_F4_UI_PENDING;
 }
 if(s->ui_phase==IQ4_F4_UI_IDLE&&s->owners_released&&(s->published||!__atomic_load_n(&s->encoded,__ATOMIC_ACQUIRE)))return IQ4_F4_UI_COMPLETE;
 if(load(&s->worker_state)==W_IDLE&&!load(&s->ui_preparing)&&!s->card_ready)return IQ4_F4_UI_REJECTED;
 store(&s->stop_desired,1);int r=iq4_f4_source_stop_on_ui_02(s->source);if(r==IQ4_F4_SRC_HOLD){hold(s);return IQ4_F4_UI_UNKNOWN;}
 s->ui_phase=IQ4_F4_UI_FINALIZING;uint32_t state=load(&s->worker_state);
 if(state==W_IDLE&&load(&s->ui_preparing)&&!s->card_ready){
  int cancelled=s->movie.cancel_pending_on_ui(s->movie.context);if(cancelled!=IQ4_F4_MOVIE_READY){hold(s);return IQ4_F4_UI_UNKNOWN;}
  store(&s->ui_preparing,0);s->owners_released=1;s->ui_phase=IQ4_F4_UI_IDLE;
  return iq4_f4_source_fence_02(s->source)==IQ4_F4_SRC_OK?IQ4_F4_UI_COMPLETE:IQ4_F4_UI_PENDING;
 }
 if(state==W_PREPARED||state==W_RECORDING||state==W_STOPPING)request(s,C_STOP);
 return IQ4_F4_UI_PENDING;
}
static int view(void*p,Iq4F4UiView03*out){Iq4F4Session02*s=p;if(!ui(s)||!out)return 0;
 Iq4F4SourceStatus02 q=iq4_f4_source_status_on_ui_02(s->source);*out=(Iq4F4UiView03){.phase=load(&s->hold)||q.held_uncertain?IQ4_F4_UI_HOLD:s->ui_phase,
 .width=s->measured.width,.height=s->measured.height,.error=s->error,.encoded=__atomic_load_n(&s->encoded,__ATOMIC_ACQUIRE),
 .dropped=q.full+q.duplicates+q.stale+q.invalid+q.ui_retained+q.clock_rejected,.notifications=q.notifications,
 .published_and_owners_released=s->published&&s->owners_released,
 .known_empty_cancelled_and_released=s->owners_released&&!s->published&&!s->error&&!__atomic_load_n(&s->encoded,__ATOMIC_ACQUIRE),
 .destination_fs_id=s->movie.destination_on_ui(s->movie.context),.card_request_held=s->card_ready};return 1;}
size_t iq4_f4_session_storage_bytes_02(void){return sizeof(Iq4F4Session02);}
int iq4_f4_session_init_on_ui_02(void*p,size_t n,void*source,Iq4F4SelfRead02 read,void*ctx,unsigned char*packet,uint32_t cap,int quality,const Iq4F4MoviePorts02*movie){
 if(!p||((uintptr_t)p&15)||n<sizeof(Iq4F4Session02)||!source||!read||!packet||cap<1024||cap>32u*1024u*1024u||quality<1||quality>100||!movie||!movie->acquire_on_ui||!movie->poll_on_ui||!movie->prepare_on_worker||!movie->finalize_on_worker||!movie->release_on_ui||!movie->cancel_pending_on_ui||!movie->set_destination_on_ui||!movie->destination_on_ui||
  !iq4_f4_source_is_ui_02(source)||!iq4_f4_thread_pins_02(read,ctx))return IQ4_F4_UI_REJECTED;
 Iq4F4Session02*s=p;memset(s,0,sizeof*s);s->magic=MAGIC;s->source=source;s->read=read;s->read_context=ctx;s->packet=packet;s->packet_capacity=cap;s->quality=quality;s->movie=*movie;diagnose(s,301,0,0);
 if(iq4_f4_source_attach_on_ui_02(source)!=IQ4_F4_SRC_OK||iq4_f4_source_bind_handoff_on_ui_02(source,wake,control,s)!=IQ4_F4_SRC_OK){diagnose(s,301,301,1);hold(s);return IQ4_F4_UI_UNKNOWN;}
 s->ui_phase=iq4_f4_source_measure_on_ui_02(source,&s->measured)==IQ4_F4_SRC_OK?IQ4_F4_UI_IDLE:IQ4_F4_UI_UNAVAILABLE;
 diagnose(s,302,0,0);int rc=0;if(!iq4_f4_thread_create_02(&s->thread_id,run,s,&rc)){diagnose(s,302,302,1);hold(s);return IQ4_F4_UI_UNKNOWN;}if(rc){diagnose(s,302,302,(uint32_t)rc);s->ui_phase=IQ4_F4_UI_ERROR;store(&s->hold,1);return IQ4_F4_UI_REJECTED;}
 if(!s->thread_id){diagnose(s,302,302,2);hold(s);return IQ4_F4_UI_UNKNOWN;}s->created=1;diagnose(s,303,0,0);return IQ4_F4_UI_COMPLETE;
}
Iq4F4MenuPorts03 iq4_f4_session_menu_ports_02(void*p){return(Iq4F4MenuPorts03){p,action,view};}
int iq4_f4_session_request_shutdown_on_ui_02(void*p){Iq4F4Session02*s=p;if(!ui(s)||load(&s->hold)||!s->created||s->card_ready||load(&s->ui_preparing)||load(&s->worker_state)!=W_IDLE)return IQ4_F4_UI_REJECTED;
 if(iq4_f4_source_stop_on_ui_02(s->source)!=IQ4_F4_SRC_OK||iq4_f4_source_fence_02(s->source)!=IQ4_F4_SRC_OK)return IQ4_F4_UI_REJECTED;request(s,C_SHUTDOWN);return IQ4_F4_UI_PENDING;}
int iq4_f4_session_join_returned_not_ui_02(void*p){Iq4F4Session02*s=p;if(!s||s->magic!=MAGIC||iq4_f4_source_is_ui_02(s->source)||load(&s->hold)||!s->created||s->joined||load(&s->worker_state)!=W_RETURNED)return IQ4_F4_UI_REJECTED;
 void*result=0;int rc;if(!iq4_f4_thread_join_02(s->thread_id,&result,&rc)||rc||result!=s){hold(s);return IQ4_F4_UI_UNKNOWN;}s->joined=1;return IQ4_F4_UI_COMPLETE;}

int iq4_f4_session_diagnostics_04(void*p,Iq4F4DiagUnit04*out){Iq4F4Session02*s=p;if(!s||!out||s->magic!=MAGIC)return 0;
 out->stage=load(&s->diagnostic.stage);out->error=load(&s->diagnostic.error);out->detail=load(&s->diagnostic.detail);return 1;}
