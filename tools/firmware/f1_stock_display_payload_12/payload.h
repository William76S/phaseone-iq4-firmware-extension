#ifndef IQ4_F1_STOCK_DISPLAY_PAYLOAD_12_H
#define IQ4_F1_STOCK_DISPLAY_PAYLOAD_12_H
#include <stdint.h>
#include <stddef.h>
#include "../f1_user_ui_entry_01/state.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Exact stock User SHA 9b611efe...032cdb. Register/memory descriptions,
 * not replacement declarations for native polymorphic C++ classes. */
typedef struct { uintptr_t vt; int32_t x,y,w,h; } F1Rect12;
typedef struct { int32_t format,w,h,stride; uintptr_t pixels; } F1Image12;
typedef struct { uint8_t alpha,c1,c2,c3; } F1Color12;
typedef struct {
    uint64_t args[9]; /* x0..x7 and hidden x8, captured BEFORE stock call. */
    uintptr_t caller_sp,caller_fp,return_pc;
} F1Call12;
typedef struct {
    F1Rect12 destination,projected,clip,surface_bounds,roi;
    int32_t source_w,source_h,stride,format,locked_w,locked_h,engine_w,engine_h;
    int32_t surface_pitch,surface_height;
    uint32_t rotation,scale_bits,normal_scale_bits,animation_active,countdown;
    uintptr_t surface_vt,draw_vt,source_pixels,surface_pixels;
} F1Facts12;
typedef struct { F1Rect12 bands[4]; uint32_t count; } F1Plan12;
enum F1Reason12 { F1_OFF12=0,F1_DRAW12=1,F1_BAD_MODE12=2,F1_SHAPE12=3,
    F1_SOURCE12=4,F1_ZOOM12=5,F1_SURFACE12=6,F1_COVERAGE12=7,F1_ROTATION12=8 };
enum F1Reason12 iq4_f1_plan_12(const F1Facts12*,unsigned,F1Plan12*);
/* Assembly-only hook. x0..x8 have the native 477038 signature. */
void iq4_f1_lv_draw_wrapper_12(void);
void iq4_f1_after_stock_draw_12(const F1Call12*);
/* Provided by the separately linked private UI state; ready-before-mode logic
 * is that module's responsibility. Default/unready returns mode 0. */
#ifdef __cplusplus
}
#endif
#endif
