#ifndef IQ4_F1_STOCK_DISPLAY_PAYLOAD_16_H
#define IQ4_F1_STOCK_DISPLAY_PAYLOAD_16_H
#include <stdint.h>
#include <stddef.h>
#include "../f1_user_ui_entry_01/state.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Exact stock User SHA 9b611efe...032cdb. Register/memory descriptions,
 * not replacement declarations for native polymorphic C++ classes. */
typedef struct { uintptr_t vt; int32_t x,y,w,h; } F1Rect16;
typedef struct { int32_t format,w,h,stride; uintptr_t pixels; } F1Image16;
typedef struct { uint8_t alpha,c1,c2,c3; } F1Color16;
typedef struct {
    uint64_t args[9]; /* x0..x7 and hidden x8, captured BEFORE stock call. */
    uintptr_t caller_sp,caller_fp,return_pc;
} F1Call16;
typedef struct {
    F1Rect16 destination,projected,clip,surface_bounds,roi;
    int32_t source_w,source_h,stride,format,locked_w,locked_h,engine_w,engine_h;
    int32_t requested_w,requested_h;
    int32_t surface_pitch,surface_height;
    uint32_t rotation,scale_bits,normal_scale_bits,animation_active,countdown;
    uintptr_t surface_vt,screen_vt,draw_vt,source_pixels,surface_pixels;
    uint32_t provider_matches_surface,native_tables_valid;
} F1Facts16;
typedef struct { F1Rect16 bands[4]; uint32_t count; } F1Plan16;
enum F1Reason16 { F1_OFF16=0,F1_DRAW16=1,F1_BAD_MODE16=2,F1_SHAPE16=3,
    F1_SOURCE16=4,F1_ZOOM16=5,F1_SURFACE16=6,F1_COVERAGE16=7,F1_ROTATION16=8 };
enum F1Reason16 iq4_f1_plan_16(const F1Facts16*,unsigned,F1Plan16*);
/* Assembly-only hook. x0..x8 have the native 477038 signature. */
void iq4_f1_lv_draw_wrapper_16(void);
void iq4_f1_after_stock_draw_16(const F1Call16*);
/* Provided by the separately linked private UI state; ready-before-mode logic
 * is that module's responsibility. Default/unready returns mode 0. */
#ifdef __cplusplus
}
#endif
#endif
