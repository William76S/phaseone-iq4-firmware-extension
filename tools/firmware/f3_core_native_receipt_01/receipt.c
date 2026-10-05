#include "receipt.h"
#include "../native_runtime_01/self_read.h"
#include "pins.h"
#include <string.h>
/* The whole PreviewProcess window contains the decoder reader BL as well.
 * Its sole admitted mutation is the exact linked native decode wrapper. */
extern void iq4_f3_decode_native_reader_wrapper_02(void);
static struct {Iq4CoreRead01 read;void*ctx;Iq4CoreOwner01 owner;Iq4CoreView01 view;
 uintptr_t allocator,entered_output;uint32_t busy,entered,terminal,bound,failed;} state;
static uint64_t sequence;
/* Unrelated original workers may execute the patched core. They inspect only
 * this atomic published thread id, never our mutable owner receipt. */
static uint64_t published_thread;
static int read_value(uintptr_t a,void*out,size_t n){return state.read&&a>=4096&&n&&n<=4096&&a<=UINTPTR_MAX-n&&state.read(state.ctx,a,out,n)==1;}
static int u64(uintptr_t a,uintptr_t*v){return read_value(a,v,8);}
static int u32(uintptr_t a,uint32_t*v){return read_value(a,v,4);}
static void hold(void){state.view.held=1;state.failed=1;}
static int owner_thread(void){uint64_t tid=__atomic_load_n(&published_thread,__ATOMIC_ACQUIRE);return tid&&iq4_native_current_tid_01()==tid;}
static int branch_to(uintptr_t pc,uintptr_t target){uint32_t w;int64_t d=(int64_t)target-(int64_t)pc;
 if((d&3)||d<-(INT64_C(1)<<27)||d>=(INT64_C(1)<<27)||!u32(pc,&w))return 0;
 return w==(UINT32_C(0x94000000)|((uint32_t)(d>>2)&UINT32_C(0x3ffffff)));
}
static int admit(void){unsigned char copy[64];
 for(size_t i=0;i<sizeof iq4_core_pins_01/sizeof*iq4_core_pins_01;++i){const struct Iq4CorePin01*p=&iq4_core_pins_01[i];
  for(size_t at=0;at<p->n;at+=4){uintptr_t a=p->va+at;if(a==0x964860||a==0x91a78c||a==0x91a964||a==0x963d28)continue;
   if(!read_value(a,copy,4)||memcmp(copy,p->bytes+at,4))return 0;}}
#ifdef IQ4_NATIVE_HOST_FIXTURE
 return branch_to(0x964860,0xa10000)&&branch_to(0x91a78c,0xa10100)&&branch_to(0x91a964,0xa10200)&&branch_to(0x963d28,0xa20000);
#else
 return branch_to(0x964860,(uintptr_t)iq4_f3_core_native_wrapper_01)&&
  branch_to(0x91a78c,(uintptr_t)iq4_f3_core_native_join_wrapper_01)&&
  branch_to(0x91a964,(uintptr_t)iq4_f3_core_native_terminal_wrapper_01)&&
  branch_to(0x963d28,(uintptr_t)iq4_f3_decode_native_reader_wrapper_02);
#endif
}
int iq4_f3_core_begin_01(Iq4CoreRead01 read,void*ctx,const Iq4CoreOwner01*o,uint64_t*out){
 if(!read||!o||!out||!o->settings||!o->cancel||!o->pool||!o->output||!o->arena_base||
  !o->arena_bytes||o->arena_bytes>UINTPTR_MAX-o->arena_base)return IQ4_CORE_ARGUMENT;
 if(state.view.held)return IQ4_CORE_HOLD;if(state.busy)return IQ4_CORE_BUSY;
 memset(&state,0,sizeof state);state.read=read;state.ctx=ctx;state.owner=*o;
 if(!admit())return IQ4_CORE_UNBOUND;
 uintptr_t s[2];uint32_t scale,rotation,auxiliary;unsigned char enable,cancel;
 if(!u32(o->settings,&scale)||!u32(o->settings+12,&rotation)||
  !read_value(o->settings+0x291,&enable,1)||!read_value(o->cancel,&cancel,1)||
  !u64(o->settings+0x2b8,&s[0])||!u64(o->settings+0x2c0,&s[1])||!u32(o->settings+0x30,&auxiliary))return IQ4_CORE_UNBOUND;
 if(scale!=0x3f800000||rotation||enable!=1||cancel||auxiliary||s[0]||!(uint32_t)s[1]||!(uint32_t)(s[1]>>32))return IQ4_CORE_ARGUMENT;
 uint64_t tid=iq4_native_current_tid_01();if(!tid||sequence==UINT64_MAX)return IQ4_CORE_UNBOUND;
 state.bound=1;state.busy=1;state.view.generation=++sequence;state.view.thread=tid;*out=sequence;
 __atomic_store_n(&published_thread,tid,__ATOMIC_RELEASE);return IQ4_CORE_OK;
}
void iq4_f3_core_before_01(const uintptr_t a[8],uintptr_t ninth,uintptr_t pc){(void)ninth;
 if(!owner_thread())return;
 if(!a||state.entered||state.failed||pc!=0x964864||a[2]!=state.owner.output||
  a[5]!=state.owner.settings||a[6]!=state.owner.pool||a[7]!=state.owner.cancel){hold();return;}
 uintptr_t base,bytes;if(!u64(a[0]+8,&base)||!u64(a[0]+16,&bytes)){hold();return;}
 if(!bytes||base<state.owner.arena_base||base>state.owner.arena_base+state.owner.arena_bytes||
  bytes>state.owner.arena_base+state.owner.arena_bytes-base){state.failed=1;return;}
 state.allocator=a[0];state.entered_output=a[2];state.entered=1;state.view.allocator=a[0];
}
static int frame_matches(uintptr_t frame){uintptr_t alloc,output,settings,cancel;
 if(!frame||!state.entered||state.failed||
  !u64(frame+0xe8,&alloc)||!u64(frame+0x118,&output)||!u64(frame+0x88,&settings)||!u64(frame+0xb8,&cancel)){hold();return 0;}
 if(alloc!=state.allocator||output!=state.entered_output||settings!=state.owner.settings||cancel!=state.owner.cancel){hold();return 0;}
 if(state.view.frame&&state.view.frame!=frame){hold();return 0;}state.view.frame=frame;return 1;
}
void iq4_f3_core_join_returned_01(uintptr_t frame,uintptr_t pool,uintptr_t pc){uint32_t stage,threads;
 if(!owner_thread())return;if(state.view.held||state.failed)return;
 if(pc!=0x91a790||pool!=state.owner.pool||!frame_matches(frame)){hold();return;}
 if(!u32(frame+0xf0,&stage)||!u32(frame+0xb4,&threads)){hold();return;}
 if(!threads||threads>1024||stage!=state.view.joins||state.view.joins>=4096){state.failed=1;return;}
 ++state.view.joins;
}
void iq4_f3_core_terminal_01(uintptr_t frame,uintptr_t pc){uint32_t done,total,threads;unsigned char cancelled;
 if(!owner_thread())return;if(state.view.held||state.failed)return;
 if(pc!=0x91a968||state.terminal||!frame_matches(frame)){hold();return;}
 if(!u32(frame+0xf0,&done)||!u32(frame+0x130,&total)||!u32(frame+0xb4,&threads)||
  !read_value(state.owner.cancel,&cancelled,1)){hold();return;}
 if(!total||total>4096||done!=total||done!=state.view.joins||!threads||cancelled){state.failed=1;return;}
 state.view.stages=total;state.terminal=1;
}
void iq4_f3_core_after_01(void){if(!owner_thread())return;
 if(state.view.core_returned||!state.entered){hold();return;}state.view.core_returned=1;
 if(!state.terminal||!state.view.joins)state.failed=1;
 state.view.complete=!state.failed&&!state.view.held;
}
int iq4_f3_core_end_01(uint64_t generation,Iq4CoreView01*out){
 if(!out||!generation||generation!=state.view.generation||!owner_thread())return IQ4_CORE_ARGUMENT;
 *out=state.view;if(state.view.held)return IQ4_CORE_HOLD;
 if(!state.view.core_returned){hold();*out=state.view;return IQ4_CORE_HOLD;}
 __atomic_store_n(&published_thread,0,__ATOMIC_RELEASE);state.busy=0;return state.view.complete?IQ4_CORE_OK:IQ4_CORE_FAILED;
}
