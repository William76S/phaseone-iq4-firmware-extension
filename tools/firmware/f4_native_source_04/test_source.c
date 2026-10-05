#include "../f4_native_source_03/source.h"
#include "../f4_native_source_03/native_calls.h"
#include "../f4_native_source_03/code_pins.h"
#include <assert.h>
#include "../f4_native_diagnostics_04/diagnostics.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <sched.h>
enum{Q=0x10000,M=0x12000,D=0x13000,L=0x14000,A=0x16000,E=0x18000,N=0x20000};
static unsigned char memory[0x14000],pixels[64*48*3];static void*observer,*control_observer,*control_event;static int control_pending,page_present;static _Thread_local uint64_t tid=1;
static int failpin,lockthrow,unlockfail,corrupttriple,failclock;static uint64_t ns=1000;static unsigned unlocks;
static void put(uintptr_t p,uint64_t v,size_t n){assert(p>=Q&&p+n<=Q+sizeof memory);memcpy(memory+(p-Q),&v,n);}
static uint64_t get(uintptr_t p,size_t n){uint64_t v=0;assert(p>=Q&&p+n<=Q+sizeof memory);memcpy(&v,memory+(p-Q),n);return v;}
static int readself(void*c,uintptr_t p,void*out,size_t n){(void)c;
 for(size_t i=0;i<sizeof iq4_f4_pins_02/sizeof*iq4_f4_pins_02;++i){const Iq4F4Pin02*x=&iq4_f4_pins_02[i];if(p>=x->va&&p+n<=x->va+x->length){memcpy(out,x->bytes+p-x->va,n);if(failpin)((unsigned char*)out)[0]^=1;return 1;}}
 if(p==0xf553d0&&n==4){uint32_t v=1;memcpy(out,&v,4);return 1;}if(p==0xf553a8&&n==8){uint64_t v=0x10000;memcpy(out,&v,8);return 1;}
 if(p>=Q&&p+n<=Q+sizeof memory){memcpy(out,memory+(p-Q),n);if(corrupttriple&&p==N)((uint64_t*)out)[0]^=8;return 1;}return 0;
}
int iq4_f4_native_current_02(uintptr_t*v){*v=tid==1?Q:0;return 1;}
int iq4_f4_native_lock_02(uintptr_t a,int32_t c,uintptr_t*v){assert(a==A&&c==0);put(E+0x2170+0xe8,0,4);put(E+0x2170+0xf4,get(E+0x2170+0xf0,4),4);*v=(uintptr_t)pixels;return !lockthrow;}
int iq4_f4_native_unlock_02(uintptr_t a,int32_t c,int*v){assert(a==A&&c==0);++unlocks;*v=!unlockfail;if(!unlockfail)put(E+0x2170+0xe8,4,4);return 1;}
int iq4_f4_native_size_02(uintptr_t a,uint64_t*v){assert(a==A);*v=get(E+0x2170+0x50,8);return 1;}
int iq4_f4_native_id_02(uintptr_t a,uint32_t*v){assert(a==A);*v=(uint32_t)get(E+0x2170+0xf4,4);return 1;}
int iq4_f4_native_construct_observer_02(void*p,const char*n,uintptr_t q){uintptr_t*o=p;o[0]=0;o[1]=q;o[2]=(uintptr_t)n;o[3]=0;return 1;}
int iq4_f4_native_subscribe_02(void*p,uintptr_t e){uintptr_t node=e==E+0x640?N:N+0x100;if(e==E+0x640)observer=p;else{assert((void*)e==control_event);control_observer=p;}uintptr_t h=Q+0x78,tail=get(h+16,8);
 put(tail+8,node,8);put(h+16,node,8);put(node,0xc23cb8,8);put(node+8,h,8);put(node+16,tail,8);put(node+24,node-0x68,8);
 put(node-0x68+8,e,8);put(node-0x68+0x30,Q,8);put(node-0x68+0x40,(uintptr_t)p,8);return 1;}
int iq4_f4_native_unsubscribe_02(void*p,uintptr_t e){assert(p==observer&&e==E+0x640);uintptr_t next=get(N+8,8),prev=get(N+16,8);put(prev+8,next,8);put(next+16,prev,8);return 1;}
int iq4_f4_native_trylock_02(uintptr_t p,int*v){assert(p==0xf553c0);*v=0;return 1;}
int iq4_f4_native_mutex_unlock_02(uintptr_t p,int*v){assert(p==0xf553c0);*v=0;return 1;}
uint64_t iq4_f4_native_clock_02(void){return failclock?0:++ns;}
uint64_t iq4_f4_native_tid_02(void){return tid;}
int iq4_f4_native_event_construct_02(void*p,const char*n){assert(n);*(uintptr_t*)p=0xc237a0;control_event=p;return 1;}
int iq4_f4_native_event_notify_02(void*p){assert(p==control_event);control_pending=1;return 1;}
static int page(void*p){(void)p;return page_present;}
static void control_dispatch(void){assert(control_pending&&control_observer);control_pending=0;uintptr_t*o=control_observer;uintptr_t*vt=(uintptr_t*)o[0];((void(*)(void*,void*))vt[2])(control_observer,control_event);}
static void reset(void){memset(memory,0,sizeof memory);memset(pixels,0x5a,sizeof pixels);tid=1;observer=control_observer=control_event=0;control_pending=0;page_present=1;failpin=lockthrow=unlockfail=corrupttriple=failclock=0;ns=1000;unlocks=0;
 put(Q,0xb91f48,8);put(Q+0x1c8,M,8);put(M,0xb8f358,8);put(M+8,Q,8);put(Q+0x9b8,D,8);put(M+0x790,D,8);put(Q+0x8c0,L,8);put(L,0xb9a9d8,8);
 put(D+0x118,A,8);put(L+0x108,A,8);put(A,0xc07da8,8);put(A+8,E,8);put(E+0x640,0xc237a0,8);put(E+0x6d8,E+0x6d8,8);
 put(L+0x100,0,4);put(L+0x104,1,1);put(A+0xb0,0,4);put(A+0xb8,0xb9a4e0,8);put(Q+0x80,Q+0x78,8);put(Q+0x88,Q+0x78,8);
 uintptr_t b=E+0x2170;put(b,0,4);put(b+4,1,4);put(b+8,2,4);put(b+12,255,4);put(b+0x10,(uintptr_t)pixels,8);put(b+0x50,((uint64_t)48<<32)|64,8);put(b+0xe8,4,4);put(b+0xe4,0,4);put(b+0xf0,10,4);
 put(b+0xd0,1920,4);put(b+0xd4,1080,4);put(b+0xd8,1920*1080*3,4);put(b+0xfc,3,4);
}
static void event(void){assert(observer);uintptr_t*o=observer;uintptr_t*vt=(uintptr_t*)o[0];((void(*)(void*,void*))vt[2])(observer,(void*)(E+0x640));}
static void*storage;static unsigned char*arena;
static void init(void){reset();memset(storage,0,iq4_f4_source_storage_bytes_02());assert(iq4_f4_source_init_02(storage,iq4_f4_source_storage_bytes_02(),readself,0,arena,2*16384,2,16384)==0);assert(iq4_f4_source_attach_on_ui_02(storage)==0);assert(iq4_f4_source_bind_page_guard_on_ui_02(storage,page,0)==0);}
static void start(void){Iq4F4FrameMetadata02 m;assert(iq4_f4_source_measure_on_ui_02(storage,&m)==0);assert(m.width==64&&m.height==48&&m.stride==192&&m.bytes==sizeof pixels);assert(iq4_f4_source_start_on_ui_02(storage,&m)==0);}
static void consume(void){Iq4F4OwnedFrame02 f;tid=2;assert(iq4_f4_source_worker_claim_02(storage,&f)==0);assert(f.metadata.width==64&&f.metadata.height==48&&f.bytes[0]==0x5a);assert(f.bytes!=(const unsigned char*)pixels);
 Iq4F4OwnedFrame02 bad=f;bad.generation++;assert(iq4_f4_source_worker_release_02(storage,&bad)==2);assert(iq4_f4_source_worker_release_02(storage,&f)==0);assert(iq4_f4_source_worker_release_02(storage,&f)==2);tid=1;}
static unsigned producer_done;static uint64_t consumed;
static void*consumer(void*p){(void)p;tid=2;Iq4F4OwnedFrame02 f;uint64_t last=0;
 for(;;){int r=iq4_f4_source_worker_claim_02(storage,&f);if(r==0){assert(f.metadata.observed_completion_ns>last&&f.bytes[0]==0x5a&&f.bytes[f.metadata.bytes-1]==0x5a);last=f.metadata.observed_completion_ns;++consumed;assert(iq4_f4_source_worker_release_02(storage,&f)==0);}
 else{assert(r==7);if(__atomic_load_n(&producer_done,__ATOMIC_ACQUIRE)&&iq4_f4_source_fence_02(storage)==0)break;sched_yield();}}return 0;}
int main(void){storage=aligned_alloc(16,(iq4_f4_source_storage_bytes_02()+15)&~(size_t)15);arena=malloc(2*16384);assert(storage&&arena);unsigned groups=0;
 init();start();event();assert(unlocks==2);consume();assert(iq4_f4_source_stop_on_ui_02(storage)==0);assert(iq4_f4_source_fence_02(storage)==0);++groups;
 init();start();event();event();assert(iq4_f4_source_status_on_ui_02(storage).duplicates==1&&unlocks==3);consume();++groups;
 init();start();event();put(E+0x2170+0xf0,11,4);event();put(E+0x2170+0xf0,12,4);event();assert(iq4_f4_source_status_on_ui_02(storage).full==1);assert(unlocks==4);assert(iq4_f4_source_stop_on_ui_02(storage)==6);consume();consume();assert(iq4_f4_source_fence_02(storage)==0);++groups;
 init();start();put(L+0x188,(uintptr_t)pixels,8);event();assert(unlocks==1&&iq4_f4_source_status_on_ui_02(storage).ui_retained==1);++groups;
 init();start();put(E+0x2170+0xfc,4,4);event();assert(unlocks==2&&iq4_f4_source_status_on_ui_02(storage).invalid==1);tid=2;Iq4F4OwnedFrame02 f;assert(iq4_f4_source_worker_claim_02(storage,&f)==7);tid=1;++groups;
 init();start();unlockfail=1;event();assert(unlocks==2&&iq4_f4_source_fence_02(storage)==5);tid=2;assert(iq4_f4_source_worker_claim_02(storage,&f)==5);tid=1;event();assert(unlocks==2);++groups;
 init();start();lockthrow=1;event();assert(unlocks==1&&iq4_f4_source_fence_02(storage)==5);++groups;
 init();start();failclock=1;event();assert(unlocks==2&&iq4_f4_source_status_on_ui_02(storage).clock_rejected==1);++groups;
 init();start();corrupttriple=1;assert(iq4_f4_source_stop_on_ui_02(storage)==5);assert(iq4_f4_source_fence_02(storage)==5);++groups;
 reset();failpin=1;assert(iq4_f4_source_init_02(storage,iq4_f4_source_storage_bytes_02(),readself,0,arena,32768,2,16384)==2);++groups;
 init();Iq4F4FrameMetadata02 m;assert(iq4_f4_source_measure_on_ui_02(storage,&m)==0);m.width++;assert(iq4_f4_source_start_on_ui_02(storage,&m)==2);++groups;
 init();start();event();put(E+0x2170+0xf0,5,4);event();assert(iq4_f4_source_status_on_ui_02(storage).stale==1);++groups;
 init();start();page_present=0;event();assert(unlocks==1&&control_pending&&iq4_f4_source_fence_02(storage)==6);control_dispatch();assert(iq4_f4_source_fence_02(storage)==0);++groups;
 init();start();tid=2;assert(iq4_f4_source_request_stop_02(storage)==6);assert(iq4_f4_source_request_stop_02(storage)==6);tid=1;control_dispatch();assert(iq4_f4_source_fence_02(storage)==0);++groups;
 init();start();producer_done=0;consumed=0;pthread_t worker;assert(pthread_create(&worker,0,consumer,0)==0);
 for(unsigned i=0;i<5000;++i){put(E+0x2170+0xf0,10+i,4);event();if((i&31)==0)sched_yield();}
 int stop=iq4_f4_source_stop_on_ui_02(storage);assert(stop==0||stop==6);__atomic_store_n(&producer_done,1,__ATOMIC_RELEASE);assert(pthread_join(worker,0)==0);
 Iq4F4SourceStatus02 status=iq4_f4_source_status_on_ui_02(storage);assert(status.copied==consumed&&status.copied+status.full==5000&&iq4_f4_source_fence_02(storage)==0);++groups;
 /* Reject every noncanonical mapping after a successful paired borrow. */
 static const uint32_t bad[][4]={{2,1,0,255},{0,0,2,255},{0,1,255,255},{0,1,2,0},{0,1,2,3},{0,1,3,255}};
 for(unsigned j=0;j<sizeof bad/sizeof*bad;++j){
  init();for(unsigned k=0;k<4;++k)put(E+0x2170+4*k,bad[j][k],4);
  assert(iq4_f4_source_measure_on_ui_02(storage,&m)==2&&unlocks==1);
  assert(!iq4_f4_source_status_on_ui_02(storage).held_uncertain);++groups;
  init();start();for(unsigned k=0;k<4;++k)put(E+0x2170+4*k,bad[j][k],4);event();
  assert(unlocks==2&&iq4_f4_source_status_on_ui_02(storage).invalid==1);
  tid=2;assert(iq4_f4_source_worker_claim_02(storage,&f)==7);tid=1;++groups;
 }
 init();start();pixels[0]=0xd3;pixels[1]=0x51;pixels[2]=0x17;event();tid=2;
 assert(iq4_f4_source_worker_claim_02(storage,&f)==0&&f.bytes[0]==0xd3&&f.bytes[1]==0x51&&f.bytes[2]==0x17);
 assert(f.metadata.component_map[0]==0&&f.metadata.component_map[1]==1&&f.metadata.component_map[2]==2&&f.metadata.component_map[3]==255);
 assert(iq4_f4_source_worker_release_02(storage,&f)==0);tid=1;++groups;
 Iq4F4DiagUnit04 d;
 reset();failpin=1;assert(iq4_f4_source_init_02(storage,iq4_f4_source_storage_bytes_02(),readself,0,arena,32768,2,16384)==2);
 assert(iq4_f4_source_diagnostics_04(storage,&d)&&d.stage==200&&d.error==200&&d.detail==1);++groups;
 reset();put(L,0xdead0000,8);assert(iq4_f4_source_init_02(storage,iq4_f4_source_storage_bytes_02(),readself,0,arena,32768,2,16384)==2);
 assert(iq4_f4_source_diagnostics_04(storage,&d)&&d.stage==201&&d.error==201&&d.detail==4);++groups;
 init();start();unlockfail=1;event();unsigned before=unlocks;
 assert(iq4_f4_source_diagnostics_04(storage,&d)&&d.error==222&&d.detail==1);event();
 assert(unlocks==before&&iq4_f4_source_diagnostics_04(storage,&d)&&d.error==222);++groups;
 init();put(L+0x104,0,1);assert(iq4_f4_source_measure_on_ui_02(storage,&m)==IQ4_F4_SRC_REJECTED&&unlocks==0);
 assert(iq4_f4_source_diagnostics_04(storage,&d)&&d.error==220&&d.detail==11&&!iq4_f4_source_status_on_ui_02(storage).held_uncertain);++groups;
 free(storage);free(arena);printf("%u synthetic fault groups PASS; no target/SDK/device\n",groups);return 0;}
