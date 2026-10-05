#include "native_calls.h"
#include "code_pins.h"
#define main inherited_source04_fault_main
#define iq4_f4_native_trylock_02 fixture_trylock_04
#define iq4_f4_native_mutex_unlock_02 fixture_unlock_04
#define iq4_f4_native_subscribe_02 fixture_subscribe_04
#include "../f4_native_source_04/test_source.c"
#undef iq4_f4_native_subscribe_02
#undef iq4_f4_native_mutex_unlock_02
#undef iq4_f4_native_trylock_02
#undef main
#include <errno.h>

static pthread_mutex_t registry;
static pthread_mutex_t rendezvous=PTHREAD_MUTEX_INITIALIZER;
static pthread_cond_t progress=PTHREAD_COND_INITIALIZER;
static unsigned ready, release_holder, contender, acquired, released, trybusy;
static int injected_lock_exception, injected_unlock_failure;

static void *registry_holder(void *unused){
 (void)unused;tid=2;assert(!pthread_mutex_lock(&registry));
 assert(!pthread_mutex_lock(&rendezvous));ready=1;assert(!pthread_cond_signal(&progress));
 while(!release_holder)assert(!pthread_cond_wait(&progress,&rendezvous));
 assert(!pthread_mutex_unlock(&rendezvous));assert(!pthread_mutex_unlock(&registry));return 0;
}
static void make_holder(pthread_t *thread){
 ready=release_holder=0;contender=1;assert(!pthread_create(thread,0,registry_holder,0));
 assert(!pthread_mutex_lock(&rendezvous));while(!ready)assert(!pthread_cond_wait(&progress,&rendezvous));
 assert(!pthread_mutex_unlock(&rendezvous));
}
static void permit_release(void){assert(!pthread_mutex_lock(&rendezvous));release_holder=1;
 assert(!pthread_cond_signal(&progress));assert(!pthread_mutex_unlock(&rendezvous));}
int iq4_f4_native_trylock_02(uintptr_t p,int *value){
 assert(p==0xf553c0);*value=pthread_mutex_trylock(&registry);
 if(*value==EBUSY)++trybusy;else if(!*value)++acquired;return 1;
}
int iq4_f4_native_queue_lock_05(uintptr_t p){
 assert(p==0xf553c0);if(injected_lock_exception)return 0;
 if(contender){int value=pthread_mutex_trylock(&registry);assert(value==EBUSY);
  ++trybusy;contender=0;permit_release();}
 assert(!pthread_mutex_lock(&registry));++acquired;return 1;
}
int iq4_f4_native_mutex_unlock_02(uintptr_t p,int *value){
 assert(p==0xf553c0);assert(!pthread_mutex_unlock(&registry));++released;
 *value=injected_unlock_failure?EINVAL:0;return 1;
}
int iq4_f4_native_subscribe_02(void *p,uintptr_t event_address){
 /* Original Subscribe also uses the same recursive registry mutex. */
 assert(!pthread_mutex_lock(&registry));int value=fixture_subscribe_04(p,event_address);
 assert(!pthread_mutex_unlock(&registry));return value;
}
static void prepare(void){reset();acquired=released=trybusy=contender=0;
 injected_lock_exception=injected_unlock_failure=0;
 memset(storage,0,iq4_f4_source_storage_bytes_02());
 assert(iq4_f4_source_init_02(storage,iq4_f4_source_storage_bytes_02(),readself,0,arena,32768,2,16384)==IQ4_F4_SRC_OK);
 assert(iq4_f4_source_bind_page_guard_on_ui_02(storage,page,0)==IQ4_F4_SRC_OK);
}
int main(int argc,char **argv){
 assert(argc==2);pthread_mutexattr_t attr;assert(!pthread_mutexattr_init(&attr));
 assert(!pthread_mutexattr_settype(&attr,PTHREAD_MUTEX_RECURSIVE));
 assert(!pthread_mutex_init(&registry,&attr));assert(!pthread_mutexattr_destroy(&attr));
 storage=aligned_alloc(16,(iq4_f4_source_storage_bytes_02()+15)&~(size_t)15);arena=malloc(32768);assert(storage&&arena);
 prepare();pthread_t other;make_holder(&other);
 int result=iq4_f4_source_attach_on_ui_02(storage);
 if(!strcmp(argv[1],"old")){
  assert(result==IQ4_F4_SRC_REJECTED&&!observer&&!control_observer&&trybusy==1&&acquired==0&&released==0);
  permit_release();assert(!pthread_join(other,0));
  puts("old source04 actual pthread EBUSY rejects before registration; session04 init maps this to permanent Hold");
 }else{
  assert(!strcmp(argv[1],"new"));assert(!pthread_join(other,0));
  assert(result==IQ4_F4_SRC_OK&&observer&&control_observer&&trybusy==1&&acquired==released&&acquired==4);
  assert(!iq4_f4_source_status_on_ui_02(storage).held_uncertain);unsigned groups=1;
  /* A caller already holding this recursive mutex remains valid. */
  prepare();assert(!pthread_mutex_lock(&registry));assert(iq4_f4_source_attach_on_ui_02(storage)==IQ4_F4_SRC_OK);
  assert(!pthread_mutex_unlock(&registry));assert(acquired==released&&acquired==4);++groups;
  /* Unknown lock must never traverse, register, or issue an unmatched unlock. */
  prepare();injected_lock_exception=1;assert(iq4_f4_source_attach_on_ui_02(storage)==IQ4_F4_SRC_REJECTED);
  assert(!observer&&!control_observer&&acquired==0&&released==0);++groups;
  prepare();assert(iq4_f4_source_attach_on_ui_02(storage)==IQ4_F4_SRC_OK);corrupttriple=1;
  assert(iq4_f4_source_stop_on_ui_02(storage)==IQ4_F4_SRC_HOLD);assert(acquired==released);
  assert(iq4_f4_source_fence_02(storage)==IQ4_F4_SRC_HOLD);++groups;
  prepare();assert(iq4_f4_source_attach_on_ui_02(storage)==IQ4_F4_SRC_OK);injected_unlock_failure=1;
  assert(iq4_f4_source_stop_on_ui_02(storage)==IQ4_F4_SRC_HOLD);assert(acquired==released);
  assert(iq4_f4_source_fence_02(storage)==IQ4_F4_SRC_HOLD);++groups;
  prepare();assert(iq4_f4_source_attach_on_ui_02(storage)==IQ4_F4_SRC_OK);start();event();consume();
  assert(iq4_f4_source_stop_on_ui_02(storage)==IQ4_F4_SRC_OK&&iq4_f4_source_fence_02(storage)==IQ4_F4_SRC_OK);
  assert(unlocks==2&&acquired==released);++groups;
  reset();failpin=1;assert(iq4_f4_source_init_02(storage,iq4_f4_source_storage_bytes_02(),readself,0,arena,32768,2,16384)==IQ4_F4_SRC_REJECTED);
  Iq4F4DiagUnit04 diagnostic;assert(iq4_f4_source_diagnostics_04(storage,&diagnostic)&&diagnostic.error==200&&diagnostic.detail==1);++groups;
  printf("%u source05 real pthread contention/recursion/unknown/fence/pin groups PASS; no device\n",groups);
 }
 free(storage);free(arena);assert(!pthread_mutex_destroy(&registry));return 0;
}
