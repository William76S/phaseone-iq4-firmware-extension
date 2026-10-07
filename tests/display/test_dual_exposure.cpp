#define IQ4_DUAL_HOST 1
#include "../../src/display/dual_exposure.cpp"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <initializer_list>
#include "dual_exposure_factory_times.h"
static unsigned char dialog[0x500],label[0x200],core[0x100],status[0x2000],config[0x3000],manager[16],running[16];
static unsigned char arrow_buttons[2][0xa0],arrow_labels[2][0xb0];
static uintptr_t D=(uintptr_t)dialog,L=(uintptr_t)label,C=(uintptr_t)core,S=(uintptr_t)status,CFG=(uintptr_t)config,M=(uintptr_t)manager,R=(uintptr_t)running;
static unsigned fail_pins,busy_sequence,sets,updates,range_sets,throw_set,wrong_set,quantizes;
static int32_t long_min,long_max,native_min,native_max,last_min,last_max;
static uint32_t label_width,label_height,stepper_width,stepper_height;
static unsigned label_flags_calls;
static unsigned glyph_rect_calls,glyph_metadata_calls;
static float last_seconds;
static uintptr_t attached,stepper_value,stepper_label;
extern "C" int dual_test_pins(void) { return !fail_pins; }
extern "C" uintptr_t dual_test_central(uintptr_t p) { assert(p==M); return C; }
extern "C" float dual_test_ratio_get(uintptr_t p) { assert(p==S+0x1080); return load<float>(p+0xc0); }
extern "C" void dual_test_ratio_set(uintptr_t p,float v) { assert(p==S+0x1080); ++sets; if(throw_set) throw 1; if(!wrong_set) store<float>(p+0xc0,v); }
extern "C" int32_t dual_test_u32_get(uintptr_t p) { assert(p==S+0xe8); return load<int32_t>(p+0xc0); }
extern "C" int32_t dual_test_bound(uintptr_t p,unsigned offset) { assert(p==CFG+0x1468); return offset==0xf8?long_min:long_max; }
extern "C" bool dual_test_sequence_busy(uintptr_t p) { assert(p==R); return busy_sequence; }
extern "C" void dual_test_update(uintptr_t d) { assert(d==D); ++updates; }
extern "C" int32_t dual_test_quantize(float seconds) { ++quantizes; last_seconds=seconds; return 123; }
extern "C" float dual_test_seconds(int32_t tick) { assert(tick>=0 && tick<=factory_seconds_max_tick); return factory_seconds[tick]; }
static void native_range(uintptr_t p,int32_t lo,int32_t hi) { assert(p==CFG+0x118); last_min=lo; last_max=hi; ++range_sets; }
extern "C" void dual_test_bounds(uintptr_t d) {
    assert(d==D); store<int32_t>(D+0x418,native_min); store<int32_t>(D+0x41c,native_max);
    iq4_dual_range_03(CFG+0x118,native_min,native_max,(uintptr_t)&native_range,d);
    int32_t base=dual_test_u32_get(S+0xe8);
    if(base<native_min)base=native_min;if(base>native_max)base=native_max; // Original bare setter uses factory bounds, not extension bounds.
    base=iq4_dual_clamp_base_04(D,S+0xe8,base,0x40c8b4);
    store<int32_t>(S+0x1a8,base);
}
extern "C" void dual_test_label_ctor(uintptr_t p,uint32_t w,uint32_t h,uintptr_t font,uint32_t size,uintptr_t text,uint32_t a,uint32_t b,uint32_t c) {
    assert(p==L && font==0x1230 && size==4 && text==0x4560 && a==0 && b==1 && c==1);
    label_width=w; label_height=h; store<uintptr_t>(L,0xb846f0);
    store<uint32_t>(L+0x38,w);store<uint32_t>(L+0x3c,h);
}
extern "C" void dual_test_stepper_ctor(uintptr_t p,uint32_t w,uint32_t h,uintptr_t value,uint32_t size,uintptr_t font,uintptr_t center,uint32_t enabled) {
    assert(p && font==0x1230 && size==8 && enabled==1);
    stepper_width=w; stepper_height=h; stepper_value=value; stepper_label=center;
    memset((void*)p,0,0xe0);
    for(unsigned i=0;i!=2;++i) {
        uintptr_t b=(uintptr_t)arrow_buttons[i],g=(uintptr_t)arrow_labels[i];
        memset((void*)b,0,0xa0);memset((void*)g,0,0xb0);
        store<uintptr_t>(p+0x90+8*i,b);store<uintptr_t>(b,0xb8bb40);store<uintptr_t>(b+0x80,g);
        store<uint32_t>(b+0x38,70);store<uint32_t>(b+0x3c,0);store<uint32_t>(b+0x44,15);
        store<uintptr_t>(g,0xb846f0);store<uintptr_t>(g+8,b);store<uintptr_t>(g+0x80,0xb8bcd0+8*i);
        store<uint32_t>(g+0x44,15);store<uint32_t>(g+0x9c,8);store<uintptr_t>(g+0xa0,font);
        store<uint32_t>(g+0x94,1);store<uint32_t>(g+0x98,1);
    }
    store<uint32_t>(center+0x44,15);store<uint32_t>(center+0x48,10);
}
extern "C" void dual_test_label_flags(uintptr_t p,uint32_t flags) { assert(p==L && flags==12);++label_flags_calls;store<uint32_t>(p+0x44,flags); }
extern "C" void dual_test_rect_ctor(uintptr_t p,int32_t x,int32_t y,int32_t w,int32_t h) {
    assert(p==(uintptr_t)arrow_labels[0]+0x28 || p==(uintptr_t)arrow_labels[1]+0x28);
    assert(x==0 && y==-3 && w==70 && h==70);++glyph_rect_calls;
    store<uintptr_t>(p,0xb73b98);store<int32_t>(p+8,x);store<int32_t>(p+12,y);store<int32_t>(p+16,w);store<int32_t>(p+20,h);
}
extern "C" void dual_test_metadata(uintptr_t p,int32_t x,int32_t y,uint32_t flags,int32_t inset) {
    assert(p==(uintptr_t)arrow_labels[0] || p==(uintptr_t)arrow_labels[1]);
    assert(x==0 && y==-3 && flags==3 && inset==0);++glyph_metadata_calls;
    store<int32_t>(p+0x30,x);store<int32_t>(p+0x34,y);store<uint32_t>(p+0x44,flags);store<int32_t>(p+0x48,inset);
}
extern "C" void dual_test_attach(uintptr_t p,uintptr_t child,uint32_t spacer) { assert(p==0x7890 && spacer==20); attached=child; }
static void release() { if(proxy.stepper) ::operator delete((void*)proxy.stepper); proxy.stepper=0; }
static void setup() {
    release(); memset(dialog,0,sizeof dialog); memset(label,0,sizeof label); memset(core,0,sizeof core); memset(status,0,sizeof status); memset(config,0,sizeof config);
    checked=admitted=changing=0; pending_label=pending_font=0; proxy.dialog=proxy.label=0;
    fail_pins=busy_sequence=sets=updates=range_sets=throw_set=wrong_set=quantizes=0;
    native_min=4; native_max=factory_max_tick; long_min=-108; long_max=factory_max_tick; last_min=last_max=0; attached=stepper_value=stepper_label=0;
    label_flags_calls=0;
    glyph_rect_calls=glyph_metadata_calls=0;
    store<uintptr_t>(D,0xba2608);store<uintptr_t>(D+0xb0,M);store<uintptr_t>(C+0x30,S);store<uintptr_t>(C+0x38,CFG);
    store<uintptr_t>(D+0x3c8,L);store<uintptr_t>(D+0x3d8,CFG+0x118);store<uintptr_t>(D+0x3e0,CFG+0x1468);store<uintptr_t>(D+0x3e8,CFG+0x1370);
    store<uintptr_t>(CFG+0x1370,0xbc1088);store<uintptr_t>(CFG+0x1378,S+0x1080);store<uintptr_t>(S+0x1080,0x9f8508);store<uintptr_t>(L,0xb846f0);
    store<uintptr_t>(D+0x380,R);store<uint8_t>(D+0x128,1);store<int32_t>(D+0x404,4);store<int32_t>(D+0x408,factory_max_tick);
    store<int32_t>(S+0x1a8,138);store<float>(S+0x1140,8);
}
static void construct() {
    iq4_dual_label_ctor_03(L,350,70,0x1230,4,0x4560,0,1,1);
    iq4_dual_attach_03(0x7890,L,20,D);
    assert(label_width==154 && label_height==70 && stepper_width==310 && stepper_height==70);
    assert(label_flags_calls==1 && load<uint32_t>(L+0x44)==12 && load<uint32_t>(L+0x48)==10);
    assert(attached==proxy.stepper && stepper_value==(uintptr_t)&proxy && stepper_label==L && proxy.stepper);
    dual_test_bounds(D);
    range_sets=0;
    iq4_dual_after_open_01(D);
}
static int native_increment(int delta) {
    auto *p=(Proxy*)stepper_value;
    return ((int(*)(Proxy*,int32_t))p->vtable[12])(p,delta);
}
int main(int argc,char **argv) {
    unsigned cases=0;
    if(argc==2 && !strcmp(argv[1],"--glyph-only")) {
        setup();construct();assert(glyph_rect_calls==2 && glyph_metadata_calls==2);
        for(unsigned i=0;i!=2;++i) {
            uintptr_t b=(uintptr_t)arrow_buttons[i],g=(uintptr_t)arrow_labels[i];
            assert(load<uintptr_t>(b)==0xb8bb40 && load<uint32_t>(b+0x38)==70 && load<uint32_t>(b+0x3c)==0 && load<uint32_t>(b+0x44)==15);
            assert(load<uintptr_t>(g)==0xb846f0 && load<uint32_t>(g+0x9c)==8 && load<uint32_t>(g+0x94)==1 && load<uint32_t>(g+0x98)==1);
            assert(load<int32_t>(g+0x34)==-3 && load<uint32_t>(g+0x38)==70 && load<uint32_t>(g+0x3c)==70 && load<uint32_t>(g+0x44)==3);++cases;
        }
        assert(native_increment(1) && third(dual_test_ratio_get(S+0x1080))==10);
        assert(native_increment(-1) && third(dual_test_ratio_get(S+0x1080))==9);++cases;
        unsigned changes=glyph_rect_calls;align_glyphs(proxy.stepper,0x1230,70);assert(glyph_rect_calls==changes);++cases;
        setup();construct();store<uint32_t>((uintptr_t)arrow_labels[0]+0x44,15);store<uint32_t>((uintptr_t)arrow_labels[0]+0x9c,4);
        align_glyphs(proxy.stepper,0x1230,70);assert(glyph_rect_calls==2);++cases;
        setup();construct();busy_sequence=1;assert(!native_increment(1));++cases;
        release();printf("{\"glyph_cases\":%u,\"local_y\":-3,\"button_hitbox_changed\":false,\"hardware_executed\":false}\n",cases);return 0;
    }
    setup();construct();assert(third(dual_test_ratio_get(S+0x1080))==9);++cases; // Factory +3EV default is retained.
    for(unsigned n=10;n<=ratio_count;++n) { assert(native_increment(1));assert(third(dual_test_ratio_get(S+0x1080))==n);++cases; }
    assert(!native_increment(1));++cases;
    for(unsigned n=ratio_count-1;n>=1;--n) { assert(native_increment(-1));assert(third(dual_test_ratio_get(S+0x1080))==n);assert(last_min>=(int)(4*n) && factory_seconds[last_min]*ratios[n-1]<=1);++cases; }
    assert(!native_increment(-1));++cases;
    for(unsigned n=2;n<=ratio_count;++n) { assert(native_increment(1));assert(third(dual_test_ratio_get(S+0x1080))==n);++cases; }
    assert(!native_increment(1));assert(sets==34 && updates==34);++cases;
    for(unsigned kind=0;kind!=8;++kind) {
        setup();construct();if(kind==0)busy_sequence=1;if(kind==1)store<uint8_t>(D+0x128,0);if(kind==2)store<uintptr_t>(L,0);if(kind==3)store<uintptr_t>(CFG+0x1378,0);
        if(kind==4)store<float>(S+0x1140,64);if(kind==5)throw_set=1;if(kind==6)wrong_set=1;if(kind==7)changing=1;
        assert(!native_increment(-1) && !updates && !range_sets);++cases;
    }
    setup();fail_pins=1; iq4_dual_label_ctor_03(L,350,70,0x1230,4,0x4560,0,1,1);iq4_dual_attach_03(0x7890,L,20,D);assert(attached==L && label_width==350 && !proxy.stepper);++cases;
    /* Rounded native shutter table values, not idealized powers of two, must
     * satisfy the real short*ratio <= 1s cap. The native quantizer receives
     * that physical product unchanged and decides the displayed long tick. */
    for(unsigned n=1;n<=ratio_count;++n) for(int32_t base : {4,42,60,104,168}) {
        setup();construct();store<float>(S+0x1140,ratios[n-1]);store<int32_t>(S+0x1a8,base);dual_test_bounds(D);
        int32_t actual=dual_test_u32_get(S+0xe8);float physical=factory_seconds[actual]*ratios[n-1];int32_t result=iq4_dual_long_tick_02(D,actual,physical,ratios[n-1]);
        assert(result==123 && quantizes==1 && last_seconds==physical && physical<=1);assert(actual>=native_min && actual<=factory_seconds_max_tick);++cases;
    }
    setup();construct();native_min=48;native_max=120;long_min=12;long_max=92;store<float>(S+0x1140,ratios[8]);dual_test_bounds(D);assert(last_min>=48 && last_max==120 && factory_seconds[last_min]*8<=factory_seconds[12]);++cases;
    setup();construct();long_min=4;store<float>(S+0x1140,ratios[14]);store<int32_t>(S+0x1a8,4);dual_test_bounds(D);assert(last_min==64 && last_max==factory_seconds_max_tick && dual_test_u32_get(S+0xe8)==64);assert(factory_seconds[64]*32<=factory_seconds[4]);++cases; // Stricter native ~0.8s long limit wins even at +5EV.
    setup();construct();store<float>(S+0x1140,32);dual_test_bounds(D);assert(last_min==62 && last_max==factory_seconds_max_tick);assert(iq4_dual_clamp_base_04(D,S+0xe8,42,0x40c8b4)==62);assert(iq4_dual_clamp_base_04(D,S+0xe8,factory_max_tick+2,0x40c8b4)==factory_seconds_max_tick);assert(iq4_dual_clamp_base_04(D,S+0xe8,42,0x40c8b8)==42);assert(iq4_dual_display_ev_04(D,3.833333)==5.0);++cases;
    setup();construct();native_max=factory_max_tick+1;dual_test_bounds(D);assert(!native_increment(-1) && !sets && !updates);++cases; // Reject an unknown domain, admit native169.
    setup();construct();long_max=INT32_MAX-59;assert(!native_increment(1) && !sets && !updates);++cases; // New 60-tick span cannot overflow configuration bounds.
    setup();construct();int32_t lo=0,hi=0;assert(!range_for(D,ratio_count+1,4,144,lo,hi));++cases;
    setup();construct();native_min=80;long_max=40;store<float>(S+0x1140,ratios[0]);dual_test_bounds(D);assert(last_min==80 && last_max==factory_max_tick);++cases; // Infeasible keeps native behaviour.
    setup();construct();store<float>(S+0x1140,64);assert(iq4_dual_long_tick_02(D,138,1.0f,64)==123 && quantizes==1);++cases;
    setup();construct();assert(!native_increment(0) && !native_increment(2));++cases;
    setup();construct();store<int32_t>(S+0x1a8,104);assert(native_increment(1) && third(dual_test_ratio_get(S+0x1080))==10);assert(native_increment(-1) && third(dual_test_ratio_get(S+0x1080))==9 && updates==2);++cases; // Default3EV both arrows work in the real169 configuration domain.
    setup();construct();native_min=167;long_min=0;store<float>(S+0x1140,8);dual_test_bounds(D);assert(!native_increment(1) && !sets && !updates);++cases; // No ordinary safe seconds domain, preserve Ratio.
    release(); printf("{\"cases\":%u,\"adapters\":\"native arrow numeric VT+60, ratio setter, physical shutter limits, post-native base clamp, original quantizer and requested EV\",\"hardware_executed\":false}\n",cases);
}
