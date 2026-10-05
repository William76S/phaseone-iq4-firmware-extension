#include "source.h"
#include "native_calls.h"
#include "code_pins.h"
#include <stdatomic.h>
#include <string.h>
#define MAGIC UINT64_C(0x4951344634535232)
typedef struct { uintptr_t queue,manager,data,lv,access,engine,event; } Owner;
typedef struct { const uintptr_t *vt;uintptr_t queue;const char *name;void *extension; } Observer;
typedef struct { uint32_t state,generation;Iq4F4FrameMetadata02 metadata; } Slot;
typedef struct {
 uint64_t magic; Iq4F4SelfRead02 read;void *read_context;Owner owner;uint64_t ui_tid,worker_tid;
 unsigned char *arena;size_t arena_bytes;uint32_t count,slot_bytes;
 Observer observer;uintptr_t table[5];uint32_t constructed,attached,accepting,hold,in_callback;
 _Alignas(16) unsigned char control_event[0xb8];Observer control_observer;uintptr_t control_table[5];
 uint32_t control_constructed,control_attached,stop_requested;Iq4F4PageGuard02 page_guard;void*page_context;
 Iq4F4OwnedWake02 owned_wake;Iq4F4OwnedControl02 owned_control;void*handoff_context;
 uint32_t has_measure,has_seen,has_session,last_id;uint64_t last_ns,write_index,read_index;
 Iq4F4FrameMetadata02 measured,session;Slot slots[IQ4_F4_SOURCE_SLOTS];
 Iq4F4SourceStatus02 status;
} Source;
_Static_assert(sizeof(uintptr_t)==8&&sizeof(Observer)==32,"native observer layout");
_Static_assert(ATOMIC_INT_LOCK_FREE==2&&ATOMIC_LLONG_LOCK_FREE==2,"nonwaiting source atomics");
static int ptr(uintptr_t p){return p>=4096&&(p&7)==0&&p<UINTPTR_MAX-0x9000;}
static int rd(Source*s,uintptr_t p,void*out,size_t n){return p>=4096&&n&&n<=4096&&p<=UINTPTR_MAX-n&&s->read(s->read_context,p,out,n)==1;}
static int word(Source*s,uintptr_t p,uintptr_t*v){return rd(s,p,v,8);}
static int owner(Source*s,Owner*out){
 uintptr_t q,v,m,d,l,a,e;Owner again; (void)again;
 if(!iq4_f4_native_current_02(&q)||!ptr(q)||!word(s,q,&v)||v!=0xb91f48||
 !word(s,q+0x1c8,&m)||!ptr(m)||!word(s,m,&v)||v!=0xb8f358||!word(s,m+8,&v)||v!=q||
 !word(s,q+0x9b8,&d)||!ptr(d)||!word(s,m+0x790,&v)||v!=d||
 !word(s,q+0x8c0,&l)||!ptr(l)||!word(s,l,&v)||v!=0xb9a9d8||
 !word(s,d+0x118,&a)||!ptr(a)||!word(s,l+0x108,&v)||v!=a||!word(s,a,&v)||v!=0xc07da8||
 !word(s,a+8,&e)||!ptr(e)||!word(s,e+0x640,&v)||v!=0xc237a0||!word(s,e+0x6d8,&v)||!ptr(v))return 0;
 *out=(Owner){q,m,d,l,a,e,e+0x640};return 1;
}
static int equal_owner(const Owner*a,const Owner*b){return !memcmp(a,b,sizeof *a);}
static int on_ui(Source*s){Owner a,b;return s->magic==MAGIC&&iq4_f4_native_tid_02()==s->ui_tid&&owner(s,&a)&&owner(s,&b)&&equal_owner(&a,&b)&&equal_owner(&a,&s->owner);}
static int live(Source*s,int32_t*c,uintptr_t*retained){
 uintptr_t name;uint8_t running,keep;int32_t actual;
 if(!on_ui(s)||!rd(s,s->owner.lv+0x100,c,4)||*c<0||*c>=5||
 !rd(s,s->owner.lv+0x104,&running,1)||running!=1||!rd(s,s->owner.access+0xb0,&actual,4)||actual!=*c||
 !word(s,s->owner.access+0xb8+8*(unsigned)*c,&name)||name!=0xb9a4e0||
 !word(s,s->owner.lv+0x188,retained)||!rd(s,s->owner.lv+0x1c0,&keep,1))return 0;
 if(keep)*retained=1;return 1;
}
static void held(Source*s){__atomic_store_n(&s->accepting,0,__ATOMIC_RELEASE);__atomic_store_n(&s->hold,1,__ATOMIC_RELEASE);}
static uint32_t loaded(const uint32_t*p){return __atomic_load_n(p,__ATOMIC_ACQUIRE);}
static int pins(Source*s){unsigned char actual[64];size_t i,j;
 for(i=0;i<sizeof iq4_f4_pins_02/sizeof iq4_f4_pins_02[0];++i){const Iq4F4Pin02*p=&iq4_f4_pins_02[i];
  for(j=0;j<p->length;j+=sizeof actual){size_t n=p->length-j;if(n>sizeof actual)n=sizeof actual;
   if(!rd(s,p->va+j,actual,n)||memcmp(actual,p->bytes+j,n))return 0;
  }
 }return 1;
}
/* Actual exact triple inspection under the same original recursive mutex.
 * Return 1 present, 0 absent, -1 unknown; a busy mutex is unknown, never wait. */
static int exact_triple(Source*s,uintptr_t event,const Observer*observer){uintptr_t p,prev,tail,next,back,fields[4],ev,q,obs,active;
 uint32_t kind;uint32_t nodes=0,found=0;int rc,result=-1;
 if(!on_ui(s)||!rd(s,0xf553d0,&kind,4)||kind!=1||!word(s,0xf553a8,&active)||!active||
 !iq4_f4_native_trylock_02(0xf553c0,&rc)||rc)return -1;
 uintptr_t head=s->owner.queue+0x78;prev=head;
 if(!word(s,head+8,&p)||!word(s,head+16,&tail))goto done;
 while(p!=head){
  if(!ptr(p)||++nodes>4096||!rd(s,p,fields,sizeof fields)||fields[0]!=0xc23cb8||fields[2]!=prev||
   !ptr(fields[1])||!ptr(fields[3])||p!=fields[3]+0x68||!word(s,fields[1]+16,&back)||back!=p||
   !word(s,fields[3]+8,&ev)||!word(s,fields[3]+0x30,&q)||q!=s->owner.queue||!word(s,fields[3]+0x40,&obs))goto done;
  if(ev==event&&obs==(uintptr_t)observer&&++found>1)goto done;
  next=fields[1];prev=p;p=next;
 }
 if(prev==tail)result=found?1:0;
 done:if(!iq4_f4_native_mutex_unlock_02(0xf553c0,&rc)||rc)result=-1;return result;
}
static int triple(Source*s){return exact_triple(s,s->owner.event,&s->observer);}
static int same_shape(const Iq4F4FrameMetadata02*a,const Iq4F4FrameMetadata02*b){
 return a->width==b->width&&a->height==b->height&&a->stride==b->stride&&a->bytes==b->bytes&&
 a->channels==b->channels&&a->configuration_width==b->configuration_width&&a->configuration_height==b->configuration_height&&
 a->configuration_bytes==b->configuration_bytes&&!memcmp(a->component_map,b->component_map,16);
}
/* Each path after a normally returned native lock attempts exactly one paired
 * unlock. A thrown/unknown lock, changed owner or unknown unlock holds forever. */
static int sample(Source*s,int copy,Iq4F4FrameMetadata02*out){
 int32_t client,c2;uintptr_t retained,p,p2;uint32_t locked,slot,id,reported,check,latest;uint64_t size,size2;
 Iq4F4FrameMetadata02 m={0};const uintptr_t vb=s->owner.engine+0x2170;int result=IQ4_F4_SRC_REJECTED,rc;
 if(!live(s,&client,&retained)){++s->status.wrong_owner;return IQ4_F4_SRC_REJECTED;}
 if(retained){++s->status.ui_retained;return IQ4_F4_SRC_REJECTED;}
 if(!rd(s,vb+0xe8,&locked,4)||locked!=4||!rd(s,vb+0xe4,&latest,4)||latest>=4){++s->status.invalid;return IQ4_F4_SRC_REJECTED;}
 if(!iq4_f4_native_lock_02(s->owner.access,client,&p)){held(s);return IQ4_F4_SRC_HOLD;}
 if(!rd(s,vb+0xe8,&slot,4)||slot>=4||!rd(s,vb+0xf4,&id,4)){held(s);return IQ4_F4_SRC_HOLD;}
 if(!iq4_f4_native_size_02(s->owner.access,&size)||!iq4_f4_native_id_02(s->owner.access,&reported))goto release;
 if(!live(s,&c2,&retained)||c2!=client||retained||!word(s,vb+0x10+slot*8,&p2)||p2!=p||!p||
  !rd(s,vb+0x50+slot*8,&size2,8)||size2!=size||reported!=id||!rd(s,vb+0xe8,&check,4)||check!=slot||
  !rd(s,vb+0xf4,&check,4)||check!=id)goto release;
 m.width=(uint32_t)size;m.height=(uint32_t)(size>>32);m.software_id=id;m.native_slot=slot;
 if(!m.width||!m.height||m.width>65535||m.height>65535||(uint64_t)m.width*m.height*3>s->slot_bytes)goto release;
 m.stride=m.width*3;m.bytes=m.stride*m.height;
 if(!rd(s,vb,m.component_map,16)||!rd(s,vb+0xd0,&m.configuration_width,4)||!rd(s,vb+0xd4,&m.configuration_height,4)||
  !rd(s,vb+0xd8,&m.configuration_bytes,4)||!rd(s,vb+0xfc,&m.channels,4))goto release;
 /* Revision03 admits only the exact canonical native three-component map.
  * Original793874/79387c initialize [0,1,2,255], 793880..8a4 count3.
  * Format0 transfer preserves bytes0/1/2 as ARGB32 bytes1/2/3; the stock
  * three-channel JPEG input treats this order as JCS_RGB. Other maps are
  * not transformed or mislabeled RGB24. Capacity remains actual native. */
 if(m.channels!=3||m.component_map[0]!=0||m.component_map[1]!=1||
  m.component_map[2]!=2||m.component_map[3]!=255||!m.configuration_width||!m.configuration_height||
  (uint64_t)m.configuration_width*m.configuration_height*3!=m.configuration_bytes||
  m.configuration_bytes>0x3fdf000u||m.bytes>m.configuration_bytes)goto release;
 if(p>UINTPTR_MAX-m.bytes||((uintptr_t)s->arena<p+m.bytes&&p<(uintptr_t)s->arena+s->arena_bytes))goto release;
 m.observed_completion_ns=iq4_f4_native_clock_02();
 if(!m.observed_completion_ns||(s->has_seen&&m.observed_completion_ns<=s->last_ns)){++s->status.clock_rejected;goto release;}
 if(copy){
  if(!s->has_session||!same_shape(&m,&s->session))goto release;
  uint32_t delta=id-s->last_id;
  if(s->has_seen&&delta==0){++s->status.duplicates;result=IQ4_F4_SRC_DUPLICATE;goto release;}
  if(s->has_seen&&delta>=0x80000000u){++s->status.stale;goto release;}
  uint32_t i=(uint32_t)(s->write_index%s->count);Slot*dest=&s->slots[i];
  if(__atomic_load_n(&dest->state,__ATOMIC_ACQUIRE)!=0){++s->status.full;result=IQ4_F4_SRC_FULL;goto observed;}
  /* No allocator, codec, card, UI, wait or borrowed Surface in this region. */
  memcpy(s->arena+(size_t)i*s->slot_bytes,(const void*)p,m.bytes);dest->metadata=m;
  result=IQ4_F4_SRC_OK;
  observed:if(s->has_seen&&delta>1)s->status.source_gaps+=delta-1;
  s->last_id=id;s->last_ns=m.observed_completion_ns;s->has_seen=1;
 }else result=IQ4_F4_SRC_OK;
 release:
 if(!live(s,&c2,&retained)||c2!=client||retained||!rd(s,vb+0xe8,&check,4)||check!=slot||!rd(s,vb+0xf4,&check,4)||check!=id){held(s);return IQ4_F4_SRC_HOLD;}
 ++s->status.unlock_attempts;
 if(!iq4_f4_native_unlock_02(s->owner.access,client,&rc)||!rc||!rd(s,vb+0xe8,&check,4)||check!=4){held(s);return IQ4_F4_SRC_HOLD;}
 /* Publish ONLY after a verified paired unlock. On unknown, copied bytes stay
  * private and cannot be claimed by the worker. */
 if(result==IQ4_F4_SRC_OK){
  if(copy){Slot*dest=&s->slots[s->write_index%s->count];if(++dest->generation==0){held(s);return IQ4_F4_SRC_HOLD;}
   __atomic_store_n(&dest->state,2,__ATOMIC_RELEASE);++s->write_index;++s->status.copied;
   if(s->owned_wake)s->owned_wake(s->handoff_context);
  }else{s->measured=m;s->has_measure=1;}
  if(out)*out=m;
 }else if(result==IQ4_F4_SRC_REJECTED)++s->status.invalid;
 return result;
}
static void destroy(Observer*o){if(o&&o->extension)held((Source*)o->extension);}
static void notified(Observer*o,void*event){
 if(!o||!o->extension)return;Source*s=o->extension;
 __atomic_fetch_add(&s->in_callback,1,__ATOMIC_ACQ_REL);++s->status.notifications;
 if(s->magic!=MAGIC||!on_ui(s)||event!=(void*)s->owner.event){++s->status.wrong_owner;held(s);}
 else if(__atomic_load_n(&s->accepting,__ATOMIC_ACQUIRE)&&!__atomic_load_n(&s->hold,__ATOMIC_ACQUIRE)){
  int page=s->page_guard?s->page_guard(s->page_context):-1;
  if(page==1)sample(s,1,0);else if(page==0)iq4_f4_source_request_stop_02(s);else held(s);
 }
 __atomic_fetch_sub(&s->in_callback,1,__ATOMIC_RELEASE);
}
static void control_notified(Observer*o,void*event){if(!o||!o->extension)return;Source*s=o->extension;
 if(!on_ui(s)||event!=s->control_event){held(s);return;}
 if(__atomic_load_n(&s->stop_requested,__ATOMIC_ACQUIRE))iq4_f4_source_stop_on_ui_02(s);
 if(!__atomic_load_n(&s->hold,__ATOMIC_ACQUIRE)&&s->owned_control)s->owned_control(s->handoff_context);
}
size_t iq4_f4_source_storage_bytes_02(void){return sizeof(Source);}
int iq4_f4_source_init_02(void*p,size_t n,Iq4F4SelfRead02 read,void*ctx,unsigned char*arena,size_t bytes,uint32_t count,uint32_t cap){
 if(!p||((uintptr_t)p&15)||n<sizeof(Source)||!read||!arena||count<2||count>IQ4_F4_SOURCE_SLOTS||!cap||cap>IQ4_F4_SOURCE_SLOT_MAX||
  (uint64_t)count*cap>bytes||(uintptr_t)arena>UINTPTR_MAX-bytes||(uintptr_t)p>UINTPTR_MAX-sizeof(Source)||
  ((uintptr_t)arena<(uintptr_t)p+sizeof(Source)&&(uintptr_t)p<(uintptr_t)arena+bytes))return IQ4_F4_SRC_REJECTED;
#if !(defined(__aarch64__)&&defined(__linux__)) && !defined(IQ4_F4_SOURCE_SYNTHETIC_HOST)
 (void)ctx;return IQ4_F4_SRC_DISABLED;
#else
 Source*s=p;memset(s,0,sizeof*s);s->read=read;s->read_context=ctx;
 Owner a,b;if(!pins(s)||!owner(s,&a)||!owner(s,&b)||!equal_owner(&a,&b)||(s->ui_tid=iq4_f4_native_tid_02())==0)return IQ4_F4_SRC_REJECTED;
 s->owner=a;s->arena=arena;s->arena_bytes=bytes;s->count=count;s->slot_bytes=cap;s->magic=MAGIC;return IQ4_F4_SRC_OK;
#endif
}
int iq4_f4_source_attach_on_ui_02(void*p){Source*s=p;if(!s||!on_ui(s))return IQ4_F4_SRC_REJECTED;
 if(loaded(&s->hold))return IQ4_F4_SRC_HOLD;if(loaded(&s->attached)||triple(s)!=0)return IQ4_F4_SRC_REJECTED;
 if(!s->constructed){
  if(!iq4_f4_native_construct_observer_02(&s->observer,"IQ4OwnedLvRecording02",s->owner.queue)){held(s);return IQ4_F4_SRC_HOLD;}
  if(s->observer.queue!=s->owner.queue){held(s);return IQ4_F4_SRC_HOLD;}
  s->table[0]=0;s->table[1]=0xc23ab0;s->table[2]=(uintptr_t)destroy;s->table[3]=(uintptr_t)destroy;s->table[4]=(uintptr_t)notified;
  s->observer.vt=&s->table[2];s->observer.extension=s;s->constructed=1;
 }
 if(!s->control_constructed){
  if(!iq4_f4_native_event_construct_02(s->control_event,"IQ4OwnedLvRecordingStop02")||
   *(uintptr_t*)s->control_event!=0xc237a0||
   !iq4_f4_native_construct_observer_02(&s->control_observer,"IQ4OwnedLvRecordingControl02",s->owner.queue)){held(s);return IQ4_F4_SRC_HOLD;}
  if(s->control_observer.queue!=s->owner.queue){held(s);return IQ4_F4_SRC_HOLD;}
  s->control_table[0]=0;s->control_table[1]=0xc23ab0;s->control_table[2]=(uintptr_t)destroy;s->control_table[3]=(uintptr_t)destroy;s->control_table[4]=(uintptr_t)control_notified;
  s->control_observer.vt=&s->control_table[2];s->control_observer.extension=s;s->control_constructed=1;
  if(exact_triple(s,(uintptr_t)s->control_event,&s->control_observer)!=0||
   !iq4_f4_native_subscribe_02(&s->control_observer,(uintptr_t)s->control_event)||
   exact_triple(s,(uintptr_t)s->control_event,&s->control_observer)!=1){held(s);return IQ4_F4_SRC_HOLD;}
  s->control_attached=1;
 }
 if(!iq4_f4_native_subscribe_02(&s->observer,s->owner.event)||triple(s)!=1){held(s);return IQ4_F4_SRC_HOLD;}
 __atomic_store_n(&s->attached,1,__ATOMIC_RELEASE);return IQ4_F4_SRC_OK;
}
int iq4_f4_source_measure_on_ui_02(void*p,Iq4F4FrameMetadata02*out){Source*s=p;if(!s||!out||!on_ui(s))return IQ4_F4_SRC_REJECTED;
 if(loaded(&s->hold))return IQ4_F4_SRC_HOLD;if(loaded(&s->accepting)||loaded(&s->in_callback))return IQ4_F4_SRC_REJECTED;return sample(s,0,out);
}
int iq4_f4_source_bind_page_guard_on_ui_02(void*p,Iq4F4PageGuard02 guard,void*ctx){Source*s=p;
 if(!s||!guard||!on_ui(s)||loaded(&s->accepting)||loaded(&s->hold))return IQ4_F4_SRC_REJECTED;s->page_guard=guard;s->page_context=ctx;return IQ4_F4_SRC_OK;
}
int iq4_f4_source_is_ui_02(void*p){Source*s=p;return s&&on_ui(s);}
int iq4_f4_source_bind_handoff_on_ui_02(void*p,Iq4F4OwnedWake02 wake,Iq4F4OwnedControl02 control,void*ctx){Source*s=p;
 if(!s||!wake||!control||!on_ui(s)||loaded(&s->accepting)||loaded(&s->hold)||s->owned_wake||s->owned_control)return IQ4_F4_SRC_REJECTED;
 s->owned_wake=wake;s->owned_control=control;s->handoff_context=ctx;return IQ4_F4_SRC_OK;
}
int iq4_f4_source_post_control_02(void*p){Source*s=p;
 if(!s||s->magic!=MAGIC)return IQ4_F4_SRC_DISABLED;
 if(__atomic_load_n(&s->hold,__ATOMIC_ACQUIRE))return IQ4_F4_SRC_HOLD;
 if(!s->control_attached||!iq4_f4_native_event_notify_02(s->control_event)){held(s);return IQ4_F4_SRC_HOLD;}
 return IQ4_F4_SRC_PENDING;
}
int iq4_f4_source_start_on_ui_02(void*p,const Iq4F4FrameMetadata02*m){Source*s=p;int32_t c;uintptr_t retained;
 if(!s||!m||!on_ui(s)||!loaded(&s->attached)||loaded(&s->accepting)||!s->has_measure||!s->page_guard||s->page_guard(s->page_context)!=1||memcmp(m,&s->measured,sizeof*m)||
  !live(s,&c,&retained)||retained)return IQ4_F4_SRC_REJECTED;
 if(loaded(&s->hold))return IQ4_F4_SRC_HOLD;
 for(uint32_t i=0;i<s->count;++i)if(__atomic_load_n(&s->slots[i].state,__ATOMIC_ACQUIRE))return IQ4_F4_SRC_PENDING;
 s->session=s->measured;s->has_session=1;s->has_seen=0;__atomic_store_n(&s->stop_requested,0,__ATOMIC_RELEASE);__atomic_store_n(&s->accepting,1,__ATOMIC_RELEASE);return IQ4_F4_SRC_OK;
}
int iq4_f4_source_request_stop_02(void*p){Source*s=p;if(!s||s->magic!=MAGIC)return IQ4_F4_SRC_DISABLED;
 __atomic_store_n(&s->accepting,0,__ATOMIC_RELEASE);
 if(__atomic_load_n(&s->hold,__ATOMIC_ACQUIRE))return IQ4_F4_SRC_HOLD;
 uint32_t expected=0;if(!__atomic_compare_exchange_n(&s->stop_requested,&expected,1,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))return IQ4_F4_SRC_PENDING;
 if(!s->control_attached||!iq4_f4_native_event_notify_02(s->control_event)){held(s);return IQ4_F4_SRC_HOLD;}return IQ4_F4_SRC_PENDING;
}
int iq4_f4_source_stop_on_ui_02(void*p){Source*s=p;if(!s||s->magic!=MAGIC)return IQ4_F4_SRC_DISABLED;
 __atomic_store_n(&s->accepting,0,__ATOMIC_RELEASE);
 if(loaded(&s->hold))return IQ4_F4_SRC_HOLD;
 if(!on_ui(s)||loaded(&s->in_callback)){held(s);return IQ4_F4_SRC_HOLD;}
 if(loaded(&s->attached)){if(triple(s)!=1||!iq4_f4_native_unsubscribe_02(&s->observer,s->owner.event)||triple(s)!=0){held(s);return IQ4_F4_SRC_HOLD;}
  __atomic_store_n(&s->attached,0,__ATOMIC_RELEASE);
 }return iq4_f4_source_fence_02(s);
}
int iq4_f4_source_fence_02(void*p){Source*s=p;if(!s||s->magic!=MAGIC)return IQ4_F4_SRC_DISABLED;
 if(__atomic_load_n(&s->hold,__ATOMIC_ACQUIRE))return IQ4_F4_SRC_HOLD;
 if(__atomic_load_n(&s->accepting,__ATOMIC_ACQUIRE)||__atomic_load_n(&s->attached,__ATOMIC_ACQUIRE)||__atomic_load_n(&s->in_callback,__ATOMIC_ACQUIRE))return IQ4_F4_SRC_PENDING;
 for(uint32_t i=0;i<s->count;++i)if(__atomic_load_n(&s->slots[i].state,__ATOMIC_ACQUIRE))return IQ4_F4_SRC_PENDING;
 return IQ4_F4_SRC_OK;
}
int iq4_f4_source_worker_claim_02(void*p,Iq4F4OwnedFrame02*out){Source*s=p;if(!s||!out||s->magic!=MAGIC)return IQ4_F4_SRC_DISABLED;
 if(__atomic_load_n(&s->hold,__ATOMIC_ACQUIRE))return IQ4_F4_SRC_HOLD;
 uint64_t tid=iq4_f4_native_tid_02();if(!tid||tid==s->ui_tid)return IQ4_F4_SRC_REJECTED;
 uint64_t expected_tid=0;
 __atomic_compare_exchange_n(&s->worker_tid,&expected_tid,tid,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE);
 if(__atomic_load_n(&s->worker_tid,__ATOMIC_ACQUIRE)!=tid)return IQ4_F4_SRC_REJECTED;
 uint32_t i=(uint32_t)(s->read_index%s->count),expected=2;Slot*slot=&s->slots[i];
 if(!__atomic_compare_exchange_n(&slot->state,&expected,3,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))return IQ4_F4_SRC_EMPTY;
 *out=(Iq4F4OwnedFrame02){s->arena+(size_t)i*s->slot_bytes,slot->metadata,i,slot->generation};return IQ4_F4_SRC_OK;
}
int iq4_f4_source_worker_release_02(void*p,const Iq4F4OwnedFrame02*f){Source*s=p;
 if(!s||!f||s->magic!=MAGIC||iq4_f4_native_tid_02()!=__atomic_load_n(&s->worker_tid,__ATOMIC_ACQUIRE)||f->slot>=s->count||f->slot!=s->read_index%s->count)return IQ4_F4_SRC_REJECTED;
 Slot*slot=&s->slots[f->slot];if(__atomic_load_n(&slot->state,__ATOMIC_ACQUIRE)!=3||f->generation!=slot->generation||f->bytes!=s->arena+(size_t)f->slot*s->slot_bytes)return IQ4_F4_SRC_REJECTED;
 __atomic_store_n(&slot->state,0,__ATOMIC_RELEASE);++s->read_index;return IQ4_F4_SRC_OK;
}
Iq4F4SourceStatus02 iq4_f4_source_status_on_ui_02(void*p){Iq4F4SourceStatus02 r={0};Source*s=p;
 if(!s||!on_ui(s)){r.held_uncertain=1;return r;}r=s->status;r.held_uncertain=loaded(&s->hold);r.attached=loaded(&s->attached);r.accepting=loaded(&s->accepting);return r;
}
