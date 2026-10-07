#include <stdint.h>
#include <stddef.h>
#include <string.h>
#include <new>
#include "dual_exposure_pins.h"

/* Exact P1Linux 6.03.21 native adapter. A factory UiDataObjectStepperControl
 * owns the arrow buttons and original EXP label. The numeric adapter selects
 * Ratio, physical-time bounds constrain the original short setter, and the
 * original quantizer formats long shutter time. EXP labels the requested EV;
 * factory notifications, readout, sequence and capture paths remain in use. */
namespace {
static const float ratios[] = {
    1.2599210739135742f, 1.587401032447815f, 2.0f,
    2.5198421478271484f, 3.17480206489563f, 4.0f,
    5.039684295654297f, 6.34960412979126f, 8.0f,
    10.079368591308594f, 12.69920825958252f, 16.0f,
    20.158737182617188f, 25.39841651916504f, 32.0f
};
static constexpr unsigned ratio_count = sizeof ratios / sizeof ratios[0];
static constexpr int32_t max_ratio_ticks = 4 * ratio_count;
/* Native table first row/configuration constructor exposes max169. This is
 * a configuration bound, not the ordinary seconds lookup domain: 71b538
 * starts at row1 and excludes tick168. Use the last safe two-tick position166
 * (the same native 1/16000-second fast endpoint) for all seconds queries. */
static constexpr int32_t factory_max_tick = 169;
static constexpr int32_t factory_seconds_max_tick = 166;
template<class T> T load(uintptr_t p) { T v; memcpy(&v, (const void *)p, sizeof v); return v; }
template<class T> void store(uintptr_t p, T v) { memcpy((void *)p, &v, sizeof v); }
static bool pointer(uintptr_t p) { return p >= 4096 && !(p & 7); }
static unsigned third(float v) {
    for (unsigned i = 0; i != ratio_count; ++i) {
        float delta = v - ratios[i];
        if (delta < 0) delta = -delta;
        if (delta < 0.000001f) return i + 1;
    }
    return 0;
}
struct Graph { uintptr_t status, config, property, label; };
struct Proxy {
    const uintptr_t *vtable; uintptr_t dialog, label, stepper;
    int32_t native_min, native_max; unsigned range_ready;
};
static int increment(Proxy *, int32_t);
/* The native stepper calls only numeric VT+60, for tap and held-repeat paths.
 * It neither owns/deletes this proxy nor requests a value/format from it. The
 * original label remains its center child and is formatted by factory code. */
static const uintptr_t proxy_vtable[13] = {
    0,0,0,0,0,0,0,0,0,0,0,0,(uintptr_t)&increment
};
static Proxy proxy = {proxy_vtable, 0, 0, 0, 0, 0, 0};
static uintptr_t pending_label, pending_font;
static uint32_t pending_width, pending_height;
/* The original EXP column attaches its child with 20px on both sides.
 * Native attach resizes that child; the stepper's inner panels are computed
 * once by its constructor, so they must use the post-inset width already. */
static constexpr uint32_t exp_column_inset = 20;
static unsigned checked, admitted, changing;

#ifdef IQ4_DUAL_HOST
extern "C" int dual_test_pins(void);
extern "C" uintptr_t dual_test_central(uintptr_t);
extern "C" float dual_test_ratio_get(uintptr_t);
extern "C" void dual_test_ratio_set(uintptr_t, float);
extern "C" int32_t dual_test_u32_get(uintptr_t);
extern "C" int32_t dual_test_bound(uintptr_t, unsigned);
extern "C" bool dual_test_sequence_busy(uintptr_t);
extern "C" void dual_test_update(uintptr_t);
extern "C" void dual_test_bounds(uintptr_t);
extern "C" int32_t dual_test_quantize(float);
extern "C" float dual_test_seconds(int32_t);
extern "C" void dual_test_label_ctor(uintptr_t,uint32_t,uint32_t,uintptr_t,uint32_t,uintptr_t,uint32_t,uint32_t,uint32_t);
extern "C" void dual_test_stepper_ctor(uintptr_t,uint32_t,uint32_t,uintptr_t,uint32_t,uintptr_t,uintptr_t,uint32_t);
extern "C" void dual_test_attach(uintptr_t,uintptr_t,uint32_t);
extern "C" void dual_test_label_flags(uintptr_t,uint32_t);
extern "C" void dual_test_rect_ctor(uintptr_t,int32_t,int32_t,int32_t,int32_t);
extern "C" void dual_test_metadata(uintptr_t,int32_t,int32_t,uint32_t,int32_t);
static uintptr_t central(uintptr_t manager) { return dual_test_central(manager); }
static float ratio_get(uintptr_t p) { return dual_test_ratio_get(p); }
static void ratio_set(uintptr_t p,float v) { dual_test_ratio_set(p,v); }
static int32_t bound(uintptr_t p,unsigned offset) { return dual_test_bound(p,offset); }
static bool sequence_busy(uintptr_t p) { return dual_test_sequence_busy(p); }
static void update(uintptr_t d) { dual_test_update(d); }
static void bounds(uintptr_t d) { dual_test_bounds(d); }
static int32_t quantize(float seconds) { return dual_test_quantize(seconds); }
static float shutter_seconds(int32_t tick) { return dual_test_seconds(tick); }
static void label_ctor(uintptr_t p,uint32_t w,uint32_t h,uintptr_t f,uint32_t s,uintptr_t text,uint32_t a,uint32_t b,uint32_t c) { dual_test_label_ctor(p,w,h,f,s,text,a,b,c); }
static void stepper_ctor(uintptr_t p,uint32_t w,uint32_t h,uintptr_t value,uintptr_t font,uintptr_t label) { dual_test_stepper_ctor(p,w,h,value,8,font,label,1); }
static void attach(uintptr_t container,uintptr_t child,uint32_t spacer) { dual_test_attach(container,child,spacer); }
static void label_flags(uintptr_t label,uint32_t flags) { dual_test_label_flags(label,flags); }
static void rect_ctor(uintptr_t rect,int32_t x,int32_t y,int32_t w,int32_t h) { dual_test_rect_ctor(rect,x,y,w,h); }
static void metadata(uintptr_t label,int32_t x,int32_t y,uint32_t flags,int32_t inset) { dual_test_metadata(label,x,y,flags,inset); }
#else
static uintptr_t central(uintptr_t manager) { return ((uintptr_t(*)(uintptr_t))0x4e1a2c)(manager); }
static float ratio_get(uintptr_t p) { return ((float(*)(uintptr_t))0x432314)(p); }
static void ratio_set(uintptr_t p,float v) { ((void(*)(uintptr_t,float))0x44136c)(p,v); }
static int32_t bound(uintptr_t p,unsigned offset) { return ((int32_t(*)(uintptr_t))load<uintptr_t>(load<uintptr_t>(p)+offset))(p); }
static bool sequence_busy(uintptr_t p) { return ((bool(*)(uintptr_t))load<uintptr_t>(load<uintptr_t>(p)+0x40))(p); }
static void update(uintptr_t d) { ((void(*)(uintptr_t))0x5384cc)(d); }
static void bounds(uintptr_t d) { ((void(*)(uintptr_t))0x538684)(d); }
extern "C" int32_t iq4_stock_dual_quantize_02(float);
static int32_t quantize(float seconds) { return iq4_stock_dual_quantize_02(seconds); }
static float shutter_seconds(int32_t tick) { return ((float(*)(int32_t))0x71b538)(tick); }
static void label_ctor(uintptr_t p,uint32_t w,uint32_t h,uintptr_t f,uint32_t s,uintptr_t text,uint32_t a,uint32_t b,uint32_t c) { ((void(*)(uintptr_t,uint32_t,uint32_t,uintptr_t,uint32_t,uintptr_t,uint32_t,uint32_t,uint32_t))0x4ad230)(p,w,h,f,s,text,a,b,c); }
static void stepper_ctor(uintptr_t p,uint32_t w,uint32_t h,uintptr_t value,uintptr_t font,uintptr_t label) { ((void(*)(uintptr_t,uint32_t,uint32_t,uintptr_t,uint32_t,uintptr_t,uintptr_t,uint32_t))0x4d1ad0)(p,w,h,value,8,font,label,1); }
static void attach(uintptr_t container,uintptr_t child,uint32_t spacer) { ((void(*)(uintptr_t,uintptr_t,uint32_t))0x4d024c)(container,child,spacer); }
static void label_flags(uintptr_t label,uint32_t flags) { ((void(*)(uintptr_t,uint32_t))0x4ab8fc)(label,flags); }
static void rect_ctor(uintptr_t rect,int32_t x,int32_t y,int32_t w,int32_t h) { ((void(*)(uintptr_t,int32_t,int32_t,int32_t,int32_t))0x457cf0)(rect,x,y,w,h); }
static void metadata(uintptr_t label,int32_t x,int32_t y,uint32_t flags,int32_t inset) { ((void(*)(uintptr_t,int32_t,int32_t,uint32_t,int32_t))0x4ab984)(label,x,y,flags,inset); }
#endif
static bool pins() {
    if (checked) return admitted;
    checked = 1;
#ifdef IQ4_DUAL_HOST
    admitted = dual_test_pins() == 1;
#else
    /* These immutable segments are mapped by the exact executable. No Linux
     * self-read syscall, project actor, or guessed queue layout is required. */
    admitted = 1;
    for (const auto &pin : dual_pins_03)
        if (memcmp((const void *)pin.va,pin.data,pin.bytes)) { admitted = 0; break; }
#endif
    return admitted;
}
static bool graph(uintptr_t d,Graph &g) {
    if (!pointer(d) || load<uintptr_t>(d) != 0xba2608) return false;
    uintptr_t manager = load<uintptr_t>(d+0xb0);
    if (!pointer(manager)) return false;
    uintptr_t core = central(manager);
    if (!pointer(core)) return false;
    g.status = load<uintptr_t>(core+0x30);
    g.config = load<uintptr_t>(core+0x38);
    if (!pointer(g.status) || !pointer(g.config)) return false;
    g.property = g.status+0x1080;
    g.label = load<uintptr_t>(d+0x3c8);
    return pointer(g.label) && load<uintptr_t>(g.label) == 0xb846f0 &&
        load<uintptr_t>(d+0x3e8) == g.config+0x1370 &&
        load<uintptr_t>(g.config+0x1370) == 0xbc1088 &&
        load<uintptr_t>(g.config+0x1378) == g.property &&
        load<uintptr_t>(g.property) == 0x9f8508;
}
/* The factory renderer centers font metrics, rather than the visible +/- ink.
 * Apply the user's small upward visual adjustment only to our two glyph boxes.
 * Three pixels are a visual tuning value, not a measured font-ink correction.
 * Flags3 fills horizontally but retains the local y and height on every native
 * layout. The original arrow button, touch rectangle, font and paint stay stock. */
static void align_glyphs(uintptr_t stepper,uintptr_t font,uint32_t height) {
    if (height != 70) return;
    for (unsigned i=0;i!=2;++i) {
        uintptr_t button=load<uintptr_t>(stepper+0x90+8*i);
        if (!pointer(button) || load<uintptr_t>(button)!=0xb8bb40) continue;
        uintptr_t label=load<uintptr_t>(button+0x80);
        if (!pointer(label) || load<uintptr_t>(label)!=0xb846f0 ||
            load<uintptr_t>(label+8)!=button || load<uintptr_t>(label+0x80)!=0xb8bcd0+8*i ||
            load<uint32_t>(label+0x9c)!=8 || load<uintptr_t>(label+0xa0)!=font ||
            load<uint32_t>(label+0x44)!=15 || load<uint32_t>(label+0x48)!=0) continue;
        rect_ctor(label+0x28,0,-3,height,height);
        metadata(label,0,-3,3,0);
    }
}
/* Native ticks index a rounded/interpolated shutter table, rather than exact
 * powers of two. Start at the nominal third-stop offset, then tighten using
 * the actual factory seconds * Ratio. Keep the factory two-tick stepping,
 * readout minimum, maximum and any stricter native long limit. */
static bool range_for(uintptr_t d,unsigned n,int32_t native_min,int32_t native_max,int32_t &lo,int32_t &hi) {
    uintptr_t long_config = load<uintptr_t>(d+0x3e0);
    if (!n || n > ratio_count || !pointer(long_config) || native_min > native_max) return false;
    int32_t long_min = bound(long_config,0xf8);
    int32_t long_max = bound(long_config,0x100);
    if (long_min < 0) long_min = 0;
    if (long_min > long_max || long_max > INT32_MAX-max_ratio_ticks || long_min > INT32_MAX-max_ratio_ticks) return false;
    if (native_min < 0 || native_max > factory_max_tick || long_max > factory_max_tick) return false;
    lo = long_min + (int32_t)(4*n);
    if (lo < native_min) lo = native_min;
    hi = long_max + (int32_t)(4*n);
    if (hi > native_max) hi = native_max;
    if (hi > factory_seconds_max_tick) hi = factory_seconds_max_tick;
    if (long_min > factory_seconds_max_tick || lo > hi) return false;
    int32_t long_query_max = long_max > factory_seconds_max_tick ? factory_seconds_max_tick : long_max;
    float maximum_seconds = shutter_seconds(long_min);
    float minimum_seconds = shutter_seconds(long_query_max);
    if (!(maximum_seconds > 0) || !(minimum_seconds > 0)) return false;
    while (lo <= hi && shutter_seconds(lo)*ratios[n-1] > maximum_seconds) lo += 2;
    while (hi >= lo && shutter_seconds(hi)*ratios[n-1] < minimum_seconds) hi -= 2;
    return lo <= hi;
}
static int increment(Proxy *p,int32_t delta) {
    if (p != &proxy || !p->stepper || changing || !pins() || (delta != -1 && delta != 1)) return 0;
    Graph g = {};
    if (!graph(p->dialog,g) || g.label != p->label || load<uint8_t>(p->dialog+0x128) != 1) return 0;
    uintptr_t running = load<uintptr_t>(p->dialog+0x380);
    if (!pointer(running) || sequence_busy(running)) return 0;
    try {
        unsigned n = third(ratio_get(g.property));
        if (!n || (delta < 0 && n == 1) || (delta > 0 && n == ratio_count)) return 0;
        unsigned requested = delta < 0 ? n-1 : n+1;
        int32_t lo = 0,hi = 0;
        /* Native readout lower bound is recomputed inside bounds(), not copied
         * from an old extension range. The saved native maximum is unchanged. */
        if (!p->range_ready || !range_for(p->dialog,requested,p->native_min,p->native_max,lo,hi)) return 0;
        changing = 1;
        ratio_set(g.property,ratios[requested-1]);
        if (third(ratio_get(g.property)) != requested) { changing = 0; return 0; }
        bounds(p->dialog);
        update(p->dialog);
        changing = 0;
        return 1;
    } catch (...) { changing = 0; return 0; }
}
} // namespace

/* Exact 9-argument original label constructor call at 536eb4. The compiler
 * preserves its stack argument. EXP text/formatting still uses this UiLabel. */
extern "C" void iq4_dual_label_ctor_03(uintptr_t p,uint32_t w,uint32_t h,uintptr_t font,uint32_t size,uintptr_t text,uint32_t a,uint32_t b,uint32_t c) {
    pending_label = pending_font = 0;
    uint32_t center = w;
    if (pins() && h >= 32 && h <= 120 && w >= 2*exp_column_inset+2*(h+(h>>3))+80) {
        uint32_t width = w-2*exp_column_inset;
        center = width-2*(h+(h>>3));
        pending_label = p; pending_font = font; pending_width = width; pending_height = h;
    }
    label_ctor(p,center,h,font,size,text,a,b,c);
}
extern "C" void iq4_dual_attach_03(uintptr_t container,uintptr_t label,uint32_t spacer,uintptr_t d) {
    Graph g = {};
    if (label != pending_label || !pins() || !graph(d,g) || g.label != label) { attach(container,label,spacer); return; }
    uintptr_t memory = (uintptr_t)::operator new(0xe0);
    proxy.dialog = d; proxy.label = label; proxy.stepper = 0; proxy.range_ready = 0;
    try { stepper_ctor(memory,pending_width,pending_height,(uintptr_t)&proxy,pending_font,label); }
    catch (...) { ::operator delete((void *)memory); throw; }
    /* The factory center attachment applies 10px inset with flags15. Only
     * this EXP label releases horizontal inset; its vertical inset, font,
     * arrow dimensions and all exposure behaviour remain unchanged. */
    if (load<uint32_t>(label+0x44) == 15 && load<uint32_t>(label+0x48) == 10 &&
        load<uint32_t>(label+0x38) == pending_width-2*(pending_height+(pending_height>>3)))
        label_flags(label,12);
    align_glyphs(memory,pending_font,pending_height);
    proxy.stepper = memory;
    pending_label = pending_font = 0;
    attach(container,memory,spacer);
}
extern "C" void iq4_dual_after_open_01(uintptr_t d) {
    /* Kept for the existing open wrapper; no listener is installed on EXP. */
    if (proxy.dialog != d) return;
    Graph g = {};
    if (!graph(d,g) || g.label != proxy.label) proxy.stepper = 0;
}
extern "C" void iq4_dual_range_03(uintptr_t config,int32_t lo,int32_t hi,uintptr_t method,uintptr_t d) {
    Graph g = {};
    int32_t new_lo = lo,new_hi = hi;
    if (pins() && graph(d,g) && config == load<uintptr_t>(d+0x3d8)) {
        if (proxy.dialog == d) { proxy.native_min = lo; proxy.native_max = hi; proxy.range_ready = 1; }
        unsigned n = third(ratio_get(g.property));
        if (range_for(d,n,lo,hi,new_lo,new_hi)) {
            store<int32_t>(d+0x418,new_lo);
            store<int32_t>(d+0x41c,new_hi);
        } else { new_lo = lo; new_hi = hi; }
    }
    ((void(*)(uintptr_t,int32_t,int32_t))method)(config,new_lo,new_hi);
}
extern "C" int32_t iq4_dual_long_tick_02(uintptr_t d,int32_t base,float seconds,float ratio) {
    /* Factory update already multiplies its actual table seconds by Ratio.
     * Quantize that physical time; subtracting nominal EV ticks was inaccurate
     * at rounded table entries (e.g. +5EV and a short 1/30 second). */
    (void)d; (void)base; (void)ratio;
    return quantize(seconds);
}
extern "C" int32_t iq4_dual_clamp_base_04(uintptr_t d,uintptr_t property,int32_t value,uintptr_t method) {
    Graph g = {};
    if (!pins() || !graph(d,g) || property != g.status+0xe8 || method != 0x40c8b4) return value;
    unsigned n = third(ratio_get(g.property));
    if (!n) return value;
    int32_t lo = load<int32_t>(d+0x418),hi = load<int32_t>(d+0x41c);
    if (lo < 0 || hi > factory_seconds_max_tick || lo > hi || shutter_seconds(lo)*ratios[n-1] > 1.0f) return value;
    if (value < lo) value = lo;
    if (value > hi) value = hi;
    return value;
}
extern "C" double iq4_dual_display_ev_04(uintptr_t d,double actual) {
    Graph g = {};
    if (!pins() || !graph(d,g)) return actual;
    unsigned n = third(ratio_get(g.property));
    return n ? (double)n/3.0 : actual;
}

#if defined(__aarch64__) && !defined(IQ4_DUAL_HOST)
asm(R"(
.text
.p2align 2
.global iq4_dual_attach_wrapper_03
.type iq4_dual_attach_wrapper_03,%function
iq4_dual_attach_wrapper_03:
.cfi_startproc
stp x29,x30,[sp,#-32]!
.cfi_def_cfa_offset 32
.cfi_offset x29,-32
.cfi_offset x30,-24
mov x29,sp
.cfi_def_cfa_register x29
/* Exact Dual constructor's SP+0xa8 contains its dialog. */
ldr x3,[sp,#200]
bl iq4_dual_attach_03
ldp x29,x30,[sp],#32
.cfi_def_cfa sp,0
.cfi_restore x29
.cfi_restore x30
ret
.cfi_endproc
.size iq4_dual_attach_wrapper_03,.-iq4_dual_attach_wrapper_03
.p2align 2
.global iq4_dual_range_wrapper_03
.type iq4_dual_range_wrapper_03,%function
iq4_dual_range_wrapper_03:
.cfi_startproc
stp x29,x30,[sp,#-32]!
.cfi_def_cfa_offset 32
.cfi_offset x29,-32
.cfi_offset x30,-24
mov x29,sp
.cfi_def_cfa_register x29
/* Exact bounds frame SP+0x28 contains dialog; x3 is its native setter. */
ldr x4,[sp,#72]
bl iq4_dual_range_03
ldp x29,x30,[sp],#32
.cfi_def_cfa sp,0
.cfi_restore x29
.cfi_restore x30
ret
.cfi_endproc
.size iq4_dual_range_wrapper_03,.-iq4_dual_range_wrapper_03
.p2align 2
.global iq4_dual_long_tick_wrapper_02
.type iq4_dual_long_tick_wrapper_02,%function
iq4_dual_long_tick_wrapper_02:
.cfi_startproc
stp x29,x30,[sp,#-32]!
.cfi_def_cfa_offset 32
.cfi_offset x29,-32
.cfi_offset x30,-24
mov x29,sp
.cfi_def_cfa_register x29
ldr x0,[sp,#56]
ldr w1,[sp,#108]
bl iq4_dual_long_tick_02
ldp x29,x30,[sp],#32
.cfi_def_cfa sp,0
.cfi_restore x29
.cfi_restore x30
ret
.cfi_endproc
.size iq4_dual_long_tick_wrapper_02,.-iq4_dual_long_tick_wrapper_02
.p2align 2
.global iq4_dual_clamp_base_wrapper_04
.type iq4_dual_clamp_base_wrapper_04,%function
iq4_dual_clamp_base_wrapper_04:
.cfi_startproc
stp x29,x30,[sp,#-48]!
.cfi_def_cfa_offset 48
.cfi_offset x29,-48
.cfi_offset x30,-40
mov x29,sp
.cfi_def_cfa_register x29
stp x0,x2,[sp,#16]
mov x3,x2
mov w2,w1
mov x1,x0
/* Original bounds SP+28 is the exact dialog owner. */
ldr x0,[sp,#88]
bl iq4_dual_clamp_base_04
mov w1,w0
ldp x0,x2,[sp,#16]
blr x2
ldp x29,x30,[sp],#48
.cfi_def_cfa sp,0
.cfi_restore x29
.cfi_restore x30
ret
.cfi_endproc
.size iq4_dual_clamp_base_wrapper_04,.-iq4_dual_clamp_base_wrapper_04
.p2align 2
.global iq4_dual_display_ev_wrapper_04
.type iq4_dual_display_ev_wrapper_04,%function
iq4_dual_display_ev_wrapper_04:
.cfi_startproc
stp x29,x30,[sp,#-48]!
.cfi_def_cfa_offset 48
.cfi_offset x29,-48
.cfi_offset x30,-40
mov x29,sp
.cfi_def_cfa_register x29
stp x0,x1,[sp,#16]
str x2,[sp,#32]
/* Original update SP+18 is its dialog. D0 is its formatted EV. */
ldr x0,[sp,#72]
bl iq4_dual_display_ev_04
ldp x0,x1,[sp,#16]
ldr x2,[sp,#32]
ldp x29,x30,[sp],#48
.cfi_def_cfa sp,0
.cfi_restore x29
.cfi_restore x30
b iq4_stock_dual_format_04
.cfi_endproc
.size iq4_dual_display_ev_wrapper_04,.-iq4_dual_display_ev_wrapper_04
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
)");
#endif
