#include "../f4_native_source_02/session.h"
#include "../f4_native_source_02/thread_calls.h"
#include "../f4_native_source_02/native_calls.h"
#include <assert.h>
#include "../f4_native_diagnostics_04/diagnostics.h"
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
static pthread_t main_thread,owned;static Iq4F4OwnedWake02 owned_wake;static Iq4F4OwnedControl02 owned_control;static void*owned_context;
static uint32_t pending,attached,accepting,copies,prepared,finalized,released,create_count,join_count,pumps;
static int acquire_pending,poll_unknown,prepare_fail,finalize_unknown,page=1,codec_error;
static int measure_rejected,acquire_failed,poll_failed,stop_unknown;
static uint32_t destination=10;
static struct Iq4Mkv mux;static unsigned char packet[4096];
static uint32_t get(uint32_t*p){return __atomic_load_n(p,__ATOMIC_ACQUIRE);}static void set(uint32_t*p,uint32_t n){__atomic_store_n(p,n,__ATOMIC_RELEASE);}
static void pause_ms(void){struct timespec t={0,1000000};nanosleep(&t,0);}
static Iq4F4FrameMetadata02 metadata(void){return(Iq4F4FrameMetadata02){.width=640,.height=480,.stride=1920,.bytes=921600,.channels=3,.configuration_width=640,.configuration_height=480,.configuration_bytes=921600,.software_id=12,.observed_completion_ns=20};}
int iq4_f4_source_is_ui_02(void*p){assert(p==(void*)1);return pthread_equal(pthread_self(),main_thread);}
int iq4_f4_source_attach_on_ui_02(void*p){assert(iq4_f4_source_is_ui_02(p));set(&attached,1);return 0;}
int iq4_f4_source_measure_on_ui_02(void*p,Iq4F4FrameMetadata02*out){assert(iq4_f4_source_is_ui_02(p));if(measure_rejected)return IQ4_F4_SRC_REJECTED;*out=metadata();return 0;}
int iq4_f4_source_bind_handoff_on_ui_02(void*p,Iq4F4OwnedWake02 w,Iq4F4OwnedControl02 c,void*ctx){assert(iq4_f4_source_is_ui_02(p));owned_wake=w;owned_control=c;owned_context=ctx;return 0;}
int iq4_f4_source_start_on_ui_02(void*p,const Iq4F4FrameMetadata02*m){assert(iq4_f4_source_is_ui_02(p)&&m->width==640);set(&accepting,1);return 0;}
int iq4_f4_source_stop_on_ui_02(void*p){assert(iq4_f4_source_is_ui_02(p));if(stop_unknown)return IQ4_F4_SRC_HOLD;set(&accepting,0);set(&attached,0);return get(&copies)?6:0;}
int iq4_f4_source_request_stop_02(void*p){assert(p==(void*)1);set(&accepting,0);set(&pending,1);return 6;}
int iq4_f4_source_post_control_02(void*p){assert(p==(void*)1);set(&pending,1);return 6;}
int iq4_f4_source_fence_02(void*p){assert(p==(void*)1);return get(&accepting)||get(&attached)||get(&copies)?6:0;}
Iq4F4SourceStatus02 iq4_f4_source_status_on_ui_02(void*p){assert(iq4_f4_source_is_ui_02(p));return(Iq4F4SourceStatus02){.attached=get(&attached),.accepting=get(&accepting),.notifications=get(&pumps)};}
int iq4_f4_source_worker_claim_02(void*p,Iq4F4OwnedFrame02*f){(void)f;assert(p==(void*)1&&!pthread_equal(pthread_self(),main_thread));uint32_t n=get(&copies);if(n){set(&copies,n-1);return 0;}return 7;}
int iq4_f4_source_worker_release_02(void*p,const Iq4F4OwnedFrame02*f){(void)f;assert(p==(void*)1);return 0;}
int iq4_f4_menu_page_guard_03(void*p){(void)p;return page;}
int iq4_f4_menu_refresh_on_ui_03(void){assert(pthread_equal(pthread_self(),main_thread));return 1;}
int iq4_f4_menu_finish_exit_on_ui_03(void){assert(pthread_equal(pthread_self(),main_thread));return 0;}
uint64_t iq4_f4_native_clock_02(void){struct timespec t;clock_gettime(CLOCK_MONOTONIC,&t);return(uint64_t)t.tv_sec*1000000000+t.tv_nsec;}
int iq4_f4_thread_pins_02(Iq4F4SelfRead02 read,void*ctx){assert(read&&ctx==0);return 1;}
int iq4_f4_thread_create_02(uint64_t*out,void*(*f)(void*),void*p,int*rc){++create_count;*rc=pthread_create(&owned,0,f,p);*out=(uintptr_t)owned;return 1;}
int iq4_f4_thread_join_02(uint64_t id,void**v,int*rc){assert(!pthread_equal(pthread_self(),main_thread)&&id==(uintptr_t)owned);++join_count;*rc=pthread_join(owned,v);return 1;}
void iq4_f4_thread_wake_02(uint32_t*p){__atomic_fetch_add(p,1,__ATOMIC_RELEASE);}
void iq4_f4_thread_wait_02(uint32_t*p,uint32_t v){if(get(p)==v)pause_ms();}
int iq4_f4_worker_init_02(Iq4F4Worker02*w,void*p,struct Iq4Mkv*m,unsigned char*b,uint32_t n,int q,Iq4F4SelfRead02 r,void*c){assert(p==(void*)1&&m==&mux&&b==packet&&n==sizeof packet&&q==90&&r&&c==0);memset(w,0,sizeof*w);w->ready=1;return 0;}
int iq4_f4_worker_pump_one_02(Iq4F4Worker02*w){assert(!pthread_equal(pthread_self(),main_thread));uint32_t n=get(&copies);if(!n)return 1;set(&copies,n-1);__atomic_fetch_add(&pumps,1,__ATOMIC_RELEASE);if(codec_error)return 3;++w->encoded;return 0;}
static int acquire(void*p){assert(p==(void*)2&&pthread_equal(pthread_self(),main_thread));return acquire_failed?IQ4_F4_MOVIE_FAIL:acquire_pending?1:0;}
static int poll_card(void*p){assert(p==(void*)2&&pthread_equal(pthread_self(),main_thread));if(poll_unknown)return 3;if(poll_failed)return IQ4_F4_MOVIE_FAIL;return 0;}
static int prepare(void*p,uint32_t w,uint32_t h,struct Iq4Mkv**out){assert(p==(void*)2&&!pthread_equal(pthread_self(),main_thread)&&w==640&&h==480);set(&prepared,1);mux=(struct Iq4Mkv){.state=IQ4_MKV_WRITING,.width=w,.height=h,.max_packet_bytes=4096};*out=&mux;return prepare_fail?2:0;}
static int finalize(void*p,struct Iq4Mkv*m,int complete,uint32_t*pub){assert(p==(void*)2&&!pthread_equal(pthread_self(),main_thread)&&m==&mux&&!get(&accepting)&&!get(&attached)&&!get(&copies));__atomic_fetch_add(&finalized,1,__ATOMIC_RELEASE);if(finalize_unknown)return 3;*pub=complete?1:0;return 0;}
static int release(void*p){assert(p==(void*)2&&pthread_equal(pthread_self(),main_thread)&&get(&finalized)==1);__atomic_fetch_add(&released,1,__ATOMIC_RELEASE);return 0;}
static int cancel(void*p){assert(p==(void*)2&&pthread_equal(pthread_self(),main_thread));__atomic_fetch_add(&released,1,__ATOMIC_RELEASE);return 0;}
static int set_destination(void*p,uint32_t id){assert(p==(void*)2&&pthread_equal(pthread_self(),main_thread)&&(id==10||id==11));destination=id;return 0;}
static uint32_t get_destination(void*p){assert(p==(void*)2&&pthread_equal(pthread_self(),main_thread));return destination;}
static int readself(void*c,uintptr_t a,void*b,size_t n){(void)c;(void)a;(void)b;(void)n;return 0;}
static void events(void){if(__atomic_exchange_n(&pending,0,__ATOMIC_ACQ_REL))owned_control(owned_context);}
static int await(Iq4F4MenuPorts03*p,unsigned phase){for(unsigned i=0;i<4000;++i){events();Iq4F4UiView03 v;assert(p->view_on_ui(p->context,&v)==1);if(v.phase==phase)return 1;pause_ms();}return 0;}
static void*reaper(void*p){for(unsigned i=0;i<4000;++i){int r=iq4_f4_session_join_returned_not_ui_02(p);if(r==IQ4_F4_UI_COMPLETE)return 0;assert(r==IQ4_F4_UI_REJECTED);pause_ms();}assert(0);return 0;}
int main(int argc,char**argv){main_thread=pthread_self();int scenario=argc>1?atoi(argv[1]):0;assert(scenario>=0&&scenario<=13);
 acquire_pending=scenario==1||scenario==2||scenario==6;poll_unknown=scenario==2;prepare_fail=scenario==3;codec_error=scenario==4;finalize_unknown=scenario==5;
 void*storage=calloc(1,iq4_f4_session_storage_bytes_02());assert(storage);
 Iq4F4MoviePorts02 movie={(void*)2,acquire,poll_card,prepare,finalize,release,cancel,set_destination,get_destination};
 assert(iq4_f4_session_init_on_ui_02(storage,iq4_f4_session_storage_bytes_02(),(void*)1,readself,0,packet,sizeof packet,90,&movie)==IQ4_F4_UI_COMPLETE);
 Iq4F4MenuPorts03 p=iq4_f4_session_menu_ports_02(storage);assert(create_count==1);
 assert(p.control_on_ui(p.context,IQ4_F4_UI_STOP)==IQ4_F4_UI_REJECTED);
 if(scenario>=10){
  measure_rejected=scenario==10||scenario==13;acquire_failed=scenario==11;
  acquire_pending=poll_failed=scenario==12;stop_unknown=scenario==13;
  int refused=p.control_on_ui(p.context,IQ4_F4_UI_START);
  if(scenario==13){assert(refused==IQ4_F4_UI_UNKNOWN);Iq4F4UiView03 v;assert(p.view_on_ui(p.context,&v)&&v.phase==IQ4_F4_UI_HOLD&&!v.known_empty_cancelled_and_released);assert(get(&attached)&&!get(&released)&&!get(&prepared));puts("unknown prestart detach retains owner; no retry PASS");return 0;}
  if(scenario==12){assert(refused==IQ4_F4_UI_PENDING);assert(await(&p,IQ4_F4_UI_IDLE));}
  else assert(refused==IQ4_F4_UI_REJECTED);
  Iq4F4UiView03 v;assert(p.view_on_ui(p.context,&v));
  assert(!get(&attached)&&!get(&accepting)&&!get(&prepared)&&!get(&finalized)&&!get(&released));
  assert(v.phase==IQ4_F4_UI_IDLE&&v.known_empty_cancelled_and_released&&!v.card_request_held&&!v.encoded);
  /* Retry the same initialized session after the finite condition clears. */
  measure_rejected=acquire_failed=acquire_pending=poll_failed=0;
 }
 assert(p.control_on_ui(p.context,IQ4_F4_UI_START)==IQ4_F4_UI_PENDING);
 if(scenario==2){assert(await(&p,IQ4_F4_UI_HOLD));Iq4F4DiagUnit04 d;assert(iq4_f4_session_diagnostics_04(storage,&d)&&d.error==321&&d.detail==1);assert(!get(&prepared)&&!get(&released)&&!get(&finalized));assert(p.control_on_ui(p.context,IQ4_F4_UI_START)==IQ4_F4_UI_UNKNOWN);assert(iq4_f4_session_request_shutdown_on_ui_02(storage)==IQ4_F4_UI_REJECTED);puts("unknown card poll: retained/no retry/no cleanup PASS");return 0;}
 if(scenario==6){assert(p.control_on_ui(p.context,IQ4_F4_UI_STOP_EXIT)==IQ4_F4_UI_COMPLETE);assert(!get(&prepared)&&!get(&finalized)&&get(&released)==1);Iq4F4UiView03 v;assert(p.view_on_ui(p.context,&v)&&v.known_empty_cancelled_and_released==1&&!v.published_and_owners_released);}
 else if(scenario==3){assert(await(&p,IQ4_F4_UI_ERROR));assert(get(&released)==1&&get(&finalized)==1);}
 else{assert(await(&p,IQ4_F4_UI_RECORDING));assert(p.control_on_ui(p.context,IQ4_F4_UI_CARD_NEXT)==IQ4_F4_UI_REJECTED&&destination==10);set(&copies,scenario==7||(scenario>=8&&scenario<=9)?0:3);owned_wake(owned_context);
  if(scenario==4){assert(await(&p,IQ4_F4_UI_ERROR));assert(get(&released)==1&&get(&finalized)==1&&!get(&copies));}
  else{if(scenario!=7&&(scenario<8||scenario>=10)){for(unsigned i=0;i<4000&&get(&pumps)<3;++i)pause_ms();assert(get(&pumps)==3);}page=scenario==9?-1:0;
   if(scenario==9){assert(await(&p,IQ4_F4_UI_HOLD));assert(!get(&finalized)&&!get(&released));puts("unknown page during worker timer: Hold, no frames/finalizer/cleanup PASS");return 0;}
   if(scenario<8)assert(p.control_on_ui(p.context,IQ4_F4_UI_STOP_EXIT)==IQ4_F4_UI_PENDING);
   if(scenario==5){assert(await(&p,IQ4_F4_UI_HOLD));Iq4F4DiagUnit04 d;assert(iq4_f4_session_diagnostics_04(storage,&d)&&d.error==332&&d.detail==3);assert(get(&finalized)==1&&!get(&released));assert(p.control_on_ui(p.context,IQ4_F4_UI_START)==IQ4_F4_UI_UNKNOWN);puts("unknown finalizer: all owners retained/no release PASS");return 0;}
   assert(await(&p,IQ4_F4_UI_IDLE));Iq4F4UiView03 v;assert(p.view_on_ui(p.context,&v));if(scenario==7||scenario==8)assert(v.known_empty_cancelled_and_released==1&&!v.published_and_owners_released&&v.encoded==0);else assert(v.published_and_owners_released==1&&v.encoded==3);
   /* Duplicate queued completion is not a second native release. */
   set(&pending,1);events();assert(get(&released)==1&&get(&finalized)==1);
  }
 }
 for(unsigned i=0;i<4000;++i){int r=p.control_on_ui(p.context,IQ4_F4_UI_CARD_NEXT);if(r==IQ4_F4_UI_COMPLETE)break;assert(r==IQ4_F4_UI_REJECTED&&i<3999);pause_ms();}assert(destination==11);
 for(unsigned i=0;i<4000;++i){if(iq4_f4_session_request_shutdown_on_ui_02(storage)==IQ4_F4_UI_PENDING)break;assert(i<3999);pause_ms();}
 assert(iq4_f4_session_join_returned_not_ui_02(storage)==IQ4_F4_UI_REJECTED);pthread_t cleanup;assert(!pthread_create(&cleanup,0,reaper,storage));assert(!pthread_join(cleanup,0));assert(join_count==1);free(storage);
 printf("session scenario %d: one pthread, actual UI/worker separation, task fence, single release/join PASS (synthetic native/card/codec)\n",scenario);return 0;}
