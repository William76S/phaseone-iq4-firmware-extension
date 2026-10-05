#include "payload.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>

/* Offline test only. The native-address entrypoint is never invoked. */
unsigned iq4_f1_mode_get_01(void) { return 0; }
uintptr_t iq4_f1_fixture_table_word_13(uintptr_t p) { (void)p; return 0; }
void iq4_f1_fixture_fill_13(void *s, const F1Rect13 *r,
                          const F1Rect13 *c, const F1Color13 *v) {
    (void)s; (void)r; (void)c; (void)v;
    assert(!"this analysis must not invoke the fill path");
}
static F1Rect13 rect(int32_t x, int32_t y, int32_t w, int32_t h) {
    F1Rect13 r = {0xb73b98, x, y, w, h}; return r;
}
static F1Facts13 baseline(void) {
    F1Facts13 f = {0};
    f.destination = f.clip = f.surface_bounds = rect(0, 0, 800, 480);
    f.projected = rect(80, 0, 640, 480); f.roi = rect(0, 0, 640, 480);
    f.source_w = f.locked_w = f.engine_w = 640;
    f.source_h = f.locked_h = f.engine_h = 480;
    f.stride = 1920; f.surface_pitch = 800; f.surface_height = 480;
    f.scale_bits = f.normal_scale_bits = 0x3f800000;
    f.surface_vt = 0xb7cf90; f.screen_vt = 0xb7cfc0; f.draw_vt = 0xb7b7d8;
    f.source_pixels = 0x10000000; f.surface_pixels = 0x20000000;
    f.provider_matches_surface = f.native_tables_valid = 1;
    return f;
}
static float bits_float(uint32_t b) { float f; memcpy(&f, &b, 4); return f; }

/* Finite rotation-0 / inactive-pan subset of stock 51f50c and 51dbd0..51dc0c:
 * config domain is divided by LV scale to construct the destination. This is
 * an independently supplied hypothetical native state, NOT a camera receipt. */
static F1Rect13 native_destination(const F1Facts13 *f) {
    float scale = bits_float(f->scale_bits);
    int32_t meta_w = (int32_t)((float)f->engine_w / scale);
    int32_t meta_h = (int32_t)((float)f->engine_h / scale);
    int32_t x = (int32_t)((float)f->roi.x / scale);
    int32_t y = (int32_t)((float)f->roi.y / scale);
    if (meta_w < 800) x += (800 - meta_w) / 2;
    if (meta_h < 480) y += (480 - meta_h) / 2;
    return rect(x, y, (int32_t)((float)f->roi.w / scale),
                (int32_t)((float)f->roi.h / scale));
}
/* Stock 476e6c finite rotation-0 subset. Stock 477038 independently constructs
 * its input source rectangle from actual image dimensions (0,0,W,H). */
static F1Rect13 native_projection(const F1Facts13 *f, F1Rect13 d) {
    float sx = (float)d.w / (float)f->source_w;
    float sy = (float)d.h / (float)f->source_h;
    float s = sx < sy ? sx : sy;
    int32_t w = (int32_t)((float)f->source_w * s);
    int32_t h = (int32_t)((float)f->source_h * s);
    return rect(d.x + (d.w - w) / 2, d.y + (d.h - h) / 2, w, h);
}
static void result(const char *name, unsigned mode, enum F1Reason13 expected,
                   const F1Facts13 *f, unsigned *n) {
    F1Plan13 p;
    enum F1Reason13 actual = iq4_f1_plan_13(f, mode, &p);
    assert(actual == expected);
    if (actual != F1_DRAW13) assert(p.count == 0);
    if (*n) puts(",");
    printf("  {\"name\":\"%s\",\"mode\":%u,\"expected_reason\":%u,"
           "\"actual_reason\":%u,\"band_count\":%u}",
           name, mode, expected, actual, p.count);
    ++*n;
}
int main(void) {
    F1Facts13 f = baseline(); unsigned n = 0, m;
    puts("{\"schema\":\"iq4_f1_display13_domain_host_review_01\","
         "\"camera_access\":false,\"native_executed\":false,\"cases\":[");
    result("baseline_off", 0, F1_OFF13, &f, &n);
    for (m = 1; m <= 4; ++m) result("baseline_equal_domains", m, F1_DRAW13, &f, &n);
    f = baseline(); f.engine_w = 1280; f.engine_h = 960;
    result("config_domain_only_differs", 1, F1_SOURCE13, &f, &n);
    f = baseline(); f.roi = rect(0, 0, 1280, 960);
    result("roi_domain_only_differs", 1, F1_SOURCE13, &f, &n);
    f = baseline(); f.engine_w = 1280; f.engine_h = 960;
    f.roi = rect(0, 0, 1280, 960);
    f.scale_bits = f.normal_scale_bits = 0x40000000;
    f.destination = native_destination(&f);
    f.projected = native_projection(&f, f.destination);
    assert(f.destination.x == 80 && f.destination.y == 0 &&
           f.destination.w == 640 && f.destination.h == 480);
    assert(f.projected.x == 80 && f.projected.y == 0 &&
           f.projected.w == 640 && f.projected.h == 480);
    assert((int64_t)f.projected.w * f.projected.h == 640 * 480);
    for (m = 1; m <= 4; ++m)
        result("full_config_roi_scale2_full_actual_rgb_projection", m, F1_SOURCE13, &f, &n);
    printf("\n],\"case_count\":%u,\"passed\":%u,"
           "\"hypothetical_config\":[1280,960],\"actual_image_fixture\":[640,480],"
           "\"native_projection_fixture\":[80,0,640,480],"
           "\"actual_camera_field_values_observed\":false}\n", n, n);
    return 0;
}
