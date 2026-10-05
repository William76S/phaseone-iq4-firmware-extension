#ifndef IQ4_F1_STOCK_DISPLAY_PAYLOAD_15_H
#define IQ4_F1_STOCK_DISPLAY_PAYLOAD_15_H
#include <stdint.h>
#include <stddef.h>
#include "../f1_user_ui_entry_01/state.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Exact stock User SHA 9b611efe...032cdb. Register/memory descriptions,
 * not replacement declarations for native polymorphic C++ classes. */
typedef struct { uintptr_t vt; int32_t x,y,w,h; } F1Rect15;
typedef struct { int32_t format,w,h,stride; uintptr_t pixels; } F1Image15;
typedef struct { uint8_t alpha,c1,c2,c3; } F1Color15;
typedef struct {
    uint64_t args[9]; /* x0..x7 and hidden x8, captured BEFORE stock call. */
    uintptr_t caller_sp,caller_fp,return_pc;
} F1Call15;
typedef struct {
    F1Rect15 destination,projected,clip,surface_bounds,roi;
    int32_t source_w,source_h,stride,format,locked_w,locked_h,engine_w,engine_h;
    int32_t requested_w,requested_h;
    int32_t surface_pitch,surface_height;
    uint32_t rotation,scale_bits,normal_scale_bits,animation_active,countdown;
    uintptr_t surface_vt,screen_vt,draw_vt,source_pixels,surface_pixels;
    uint32_t provider_matches_surface,native_tables_valid;
} F1Facts15;
typedef struct { F1Rect15 bands[4]; uint32_t count; } F1Plan15;
enum F1Reason15 { F1_OFF15=0,F1_DRAW15=1,F1_BAD_MODE15=2,F1_SHAPE15=3,
    F1_SOURCE15=4,F1_ZOOM15=5,F1_SURFACE15=6,F1_COVERAGE15=7,F1_ROTATION15=8 };
enum F1Reason15 iq4_f1_plan_15(const F1Facts15*,unsigned,F1Plan15*);
/* Assembly-only hook. x0..x8 have the native 477038 signature. */
void iq4_f1_lv_draw_wrapper_15(void);
void iq4_f1_after_stock_draw_15(const F1Call15*);
/* Provided by the separately linked private UI state; ready-before-mode logic
 * is that module's responsibility. Default/unready returns mode 0. */
#ifdef __cplusplus
}
#endif
#endif
