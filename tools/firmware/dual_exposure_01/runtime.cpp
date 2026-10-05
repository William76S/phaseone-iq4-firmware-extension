#include <stdint.h>
#include <stddef.h>
#include <string.h>
#include "pins.h"
#include "../native_runtime_01/self_read.h"
#include "../native_activity_01/activity.h"
#include "../f4_native_source_02/native_calls.h"
/* Only original UiLabel's listener fields and the native float property setter
 * are used. No borrowed class layout or hardware write is invented here. */
static const float ratios[9]={1.2599210739135742f,1.587401032447815f,2.0f,2.5198421478271484f,3.17480206489563f,4.0f,5.039684295654297f,6.34960412979126f,8.0f};
static uintptr_t active_dialog,active_label,active_queue;
static unsigned held,busy;
static int read_at(uintptr_t p,void*b,size_t n){return p>=4096&&n&&n<=4096&&p<=UINTPTR_MAX-n&&iq4_native_self_read_01(0,p,b,n)==1;}
static int word(uintptr_t p,uintptr_t*v){uintptr_t a,b;if(!read_at(p,&a,8)||!read_at(p,&b,8)||a!=b)return 0;*v=a;return 1;}
static int is_word(uintptr_t p,uintptr_t v){uintptr_t a;return word(p,&a)&&a==v;}
static int pins(void){unsigned char data[128];for(size_t i=0;i<sizeof dual_pins_01/sizeof*dual_pins_01;++i){const auto&p=dual_pins_01[i];for(size_t off=0;off<p.bytes;off+=sizeof data){size_t n=p.bytes-off;if(n>sizeof data)n=sizeof data;if(!read_at(p.va+off,data,n)||memcmp(data,p.data+off,n))return 0;}}return 1;}
static unsigned step(float v){for(unsigned i=0;i<9;++i){float d=v-ratios[i];if(d<0)d=-d;if(d<0.000001f)return i+1;}return 0;}
struct Graph {uintptr_t label,queue,property,config,central;};
static int graph(uintptr_t d,Graph*g){uintptr_t manager,central,status,config,q;unsigned char active=0;
 if(!d||(d&7)||!is_word(d,0xba2608)||!is_word(d+0x108,0xba2898)||!read_at(d+0x128,&active,1)||active!=1||
 !word(d+0xb0,&manager)||!is_word(manager,0xb8f358)||!iq4_f4_native_current_02(&q)||!is_word(q,0xb91f48)||
 !is_word(q+0x1c8,manager)||!is_word(manager+8,q)||!word(manager+0x790,&central)||
 !word(central+0x30,&status)||!word(central+0x38,&config)||!is_word(d+0x3e8,config+0x1370)||
 !is_word(config+0x1370,0xbc1088)||!is_word(config+0x1378,status+0x1080)||
 !is_word(status+0x1080,0x9f8508)||!word(d+0x3c8,&g->label)||!is_word(g->label,0xb846f0))return 0;
 g->queue=q;g->property=status+0x1080;g->config=config;g->central=central;return 1;
}
#ifdef IQ4_DUAL_HOST
extern "C" void dual_test_listener(uintptr_t,uintptr_t,uint64_t,uint32_t);
extern "C" float dual_test_get(uintptr_t);
extern "C" void dual_test_set(uintptr_t,float);
extern "C" void dual_test_update(uintptr_t);
static void listener(uintptr_t w,uintptr_t d){dual_test_listener(w,d+0x108,0x100,4);}
static float get_ratio(uintptr_t p){return dual_test_get(p);}
static void set_ratio(uintptr_t p,float v){dual_test_set(p,v);}
static void update(uintptr_t p){dual_test_update(p);}
#else
static void listener(uintptr_t w,uintptr_t d){((void(*)(void*,void*,uint64_t,uint32_t))(uintptr_t)0x4ac6a0)((void*)w,(void*)(d+0x108),UINT64_C(0x100),4);}
static float get_ratio(uintptr_t p){return ((float(*)(void*))(uintptr_t)0x432314)((void*)p);}
static void set_ratio(uintptr_t p,float v){((void(*)(void*,float))(uintptr_t)0x44136c)((void*)p,v);}
static void update(uintptr_t p){((void(*)(void*))(uintptr_t)0x5384cc)((void*)p);}
#endif
/* Open is entered after the stock mode setup, readout limits and first refresh.
 * A constructor/graph failure leaves original behaviour unchanged. */
extern "C" void iq4_dual_after_open_01(uintptr_t d){
 if(held||busy)return;Graph g={};if(!pins()||!graph(d,&g))return;
 uintptr_t old=0;uint32_t tag=0;
 if(!word(g.label+0x60,&old)||!read_at(g.label+0x68,&tag,4))return;
 if(old&&(old!=d+0x108||tag!=4))return;
 try {if(!step(get_ratio(g.property)))return;busy=1;listener(g.label,d);
  if(!is_word(g.label+0x60,d+0x108)||!read_at(g.label+0x68,&tag,4)||tag!=4){held=1;busy=0;return;}
  active_dialog=d;active_label=g.label;active_queue=g.queue;busy=0;
 }catch(...){held=1;busy=0;}
}
/* The original UiDual callback has already passed its own native busy check.
 * Its tags 0..3 branch to unchanged handlers before reaching our B-site. */
extern "C" void iq4_dual_cycle_01(uintptr_t d,uintptr_t widget,uintptr_t event,uint32_t tag){
 (void)event;if(tag!=4||held||busy||d!=active_dialog||widget!=active_label)return;
 Graph g={};Iq4ActivitySnapshot01 a={};
 if(!graph(d,&g)||g.queue!=active_queue||g.label!=widget||!is_word(widget+0x60,d+0x108)||
 iq4_activity_snapshot_01(&a)!=IQ4_ACTIVITY_OK01||a.actor||a.held)return;
 try {unsigned current=step(get_ratio(g.property));if(!current)return;
  busy=1;float requested=ratios[current%9];set_ratio(g.property,requested);
  if(step(get_ratio(g.property))!=current%9+1){held=1;busy=0;return;}
  update(d);busy=0;
 }catch(...){held=1;busy=0;}
}
#if defined(__aarch64__) && !defined(IQ4_DUAL_HOST)
asm(R"(
.text
.p2align 2
.global iq4_dual_open_wrapper_01
.type iq4_dual_open_wrapper_01,%function
iq4_dual_open_wrapper_01:
.cfi_startproc
stp x29,x30,[sp,#-32]!
.cfi_def_cfa_offset 32
.cfi_offset x29,-32
.cfi_offset x30,-24
mov x29,sp
.cfi_def_cfa_register x29
str x0,[sp,#16]
bl iq4_stock_dual_update_01
ldr x0,[sp,#16]
bl iq4_dual_after_open_01
ldp x29,x30,[sp],#32
.cfi_def_cfa sp,0
.cfi_restore x29
.cfi_restore x30
ret
.cfi_endproc
.size iq4_dual_open_wrapper_01,.-iq4_dual_open_wrapper_01
.p2align 2
.global iq4_dual_unknown_tag_wrapper_01
.type iq4_dual_unknown_tag_wrapper_01,%function
iq4_dual_unknown_tag_wrapper_01:
.cfi_startproc
/* B from 537958; stock callback's live frame is still in x29/sp. */
.cfi_def_cfa x29,48
.cfi_offset x29,-48
.cfi_offset x30,-40
ldr x0,[sp,#40]
ldr x1,[sp,#32]
ldr x2,[sp,#24]
ldr w3,[sp,#20]
bl iq4_dual_cycle_01
b iq4_stock_dual_callback_return_01
.cfi_endproc
.size iq4_dual_unknown_tag_wrapper_01,.-iq4_dual_unknown_tag_wrapper_01
)");
#endif
