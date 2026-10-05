#define main sequential_fixture_main
#include "test_bridge.c"
#undef main
#include <pthread.h>
#include <sched.h>
#include <stdatomic.h>
static atomic_int started,finished;
static int ui_result;
struct Call {uintptr_t pc;uint32_t mode;int ui;};
static void*run_setter(void*argument){struct Call*c=argument;atomic_store(&started,1);
 if(c->ui)ui_result=iq4_f3_native_mode_set_on_ui_01(10,F3_JPEG_ONLY);
 else set_mode(native_events[0],c->mode,c->pc);
 atomic_store(&finished,1);return 0;
}
static pthread_t launch(struct Call*c){pthread_t t;atomic_store(&started,0);atomic_store(&finished,0);assert(!pthread_create(&t,0,run_setter,c));while(!atomic_load(&started))sched_yield();return t;}
static void write_while_locked(uint64_t token){assert(token>>32==1);uint32_t v=(uint32_t)token;memcpy((void*)(native_events[0]+0xc0),&v,4);iq4_f3_storage_leave_01(1);}
static uint32_t actual(void){uint32_t n;memcpy(&n,(void*)(native_events[0]+0xc0),4);return n;}
static void rearm(void){set_mode(native_events[0],2,0x708bc8);assert(iq4_f3_native_mode_set_on_ui_01(10,F3_RAW_JPEG));}
int main(void){assert(iq4_f3_native_storage_mutex_initialize_01());setup();assert(iq4_f3_storage_output_child_01(root,old_item,0x4f04f4)==sd_menu);
 for(unsigned n=0;n<100;++n){
  rearm();uint64_t off=iq4_f3_storage_enter_01(native_events[0],0,0x708ad8,0);assert((uint32_t)off==0);assert(iq4_f3_storage_enter_01(0x600000,1,0x700000,0)==1);struct Call ui={0,2,1};pthread_t t=launch(&ui);assert(!atomic_load(&finished));write_while_locked(off);assert(!pthread_join(t,0));assert(!ui_result&&actual()==0&&!iq4_f3_native_storage_override_mask_01());struct F3SettingsSnapshot06 s;assert(iq4_f3_settings_snapshot_06(&s)&&s.sd_mode==F3_RAW_JPEG);
  /* Old composition acquired first: its legitimate update finishes before the
   * native protection Off, whose final value is 0. */
  rearm();uint64_t composed=iq4_f3_storage_enter_01(native_events[0],0,0x6aa1c4,0);assert((uint32_t)composed==2);struct Call native_off={0x708ad8,0,0};t=launch(&native_off);assert(!atomic_load(&finished));write_while_locked(composed);assert(!pthread_join(t,0));assert(actual()==0&&!iq4_f3_native_storage_override_mask_01());
  /* Protection acquired first: old composition cannot reopen after it. */
  rearm();off=iq4_f3_storage_enter_01(native_events[0],0,0x708ad8,0);struct Call native_composite={0x6aa1c4,0,0};t=launch(&native_composite);assert(!atomic_load(&finished));write_while_locked(off);assert(!pthread_join(t,0));assert(actual()==0&&!iq4_f3_native_storage_override_mask_01());
 }
 /* The silent native setter shares the same mutex and protection state. */
 rearm();uint64_t r=iq4_f3_storage_enter_01(native_events[0],0,0x600000,1);write_while_locked(r);assert(!iq4_f3_native_mode_set_on_ui_01(10,F3_JPEG_ONLY));set_mode(native_events[0],2,0x708bc8);assert(!iq4_f3_native_storage_override_mask_01());assert(iq4_f3_native_mode_set_on_ui_01(10,F3_JPEG_ONLY));
 for(unsigned i=0;i<allocations;++i)free(allocated[i]);puts("PASS 300 actual pthread interleavings + silent Off/restore/reselect");return 0;
}
