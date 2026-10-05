#include <assert.h>
#include <stdint.h>
#include <stdio.h>

/* Standalone host math review. No target addresses, pointers, native functions,
 * or device access. Output-pair binding is an admission rule, not resampling. */
static int bounded(int v) { return v > 0 && v <= 65535; }
static int exact_aspect(int cw, int ch, int pw, int ph) {
    return bounded(cw) && bounded(ch) && bounded(pw) && bounded(ph) &&
        (int64_t)cw * ph == (int64_t)ch * pw;
}
static int common_positive_floor_scale(int cw, int ch, int pw, int ph) {
    if (!bounded(cw) || !bounded(ch) || !bounded(pw) || !bounded(ph)) return 0;
    /* [pw/cw,(pw+1)/cw) intersects [ph/ch,(ph+1)/ch).
     * Strict upper bounds retain the <1 output-pixel quantization rule. */
    return (int64_t)pw * ch < (int64_t)(ph + 1) * cw &&
           (int64_t)ph * cw < (int64_t)(pw + 1) * ch;
}
typedef struct {
    int cw,ch,rw,rh,rx,ry,pw,ph,lw,lh,ow,oh,stride,format;
} Facts;
static int native_configured_output_contract(Facts f) {
    return bounded(f.cw) && bounded(f.ch) && bounded(f.pw) && bounded(f.ph) &&
        bounded(f.ow) && bounded(f.oh) && f.format == 0 && f.stride == 3*f.pw &&
        f.rx == 0 && f.ry == 0 && f.rw == f.cw && f.rh == f.ch &&
        f.lw == f.pw && f.lh == f.ph && f.ow == f.pw && f.oh == f.ph;
}
static unsigned count;
static void test(const char *name, int actual, int expected) {
    assert(actual == expected);
    printf("%s{\"name\":\"%s\",\"actual\":%d,\"expected\":%d}",
           count ? ",\n" : "", name, actual, expected);
    ++count;
}
int main(void) {
    Facts actual = {14204,10652,14204,10652,0,0,640,480,640,480,640,480,1920,0};
    Facts f;
    puts("{\"schema\":\"iq4_f1_sampling_policy_host_01\","
         "\"native_executed\":false,\"camera_access\":false,\"cases\":[");
    test("root_reported_actual_exact_aspect_rejects",exact_aspect(14204,10652,640,480),0);
    test("root_reported_actual_common_floor_accepts",common_positive_floor_scale(14204,10652,640,480),1);
    test("root_reported_actual_configured_pair_accepts",native_configured_output_contract(actual),1);
    test("strong_aspect_change_floor_rejects",common_positive_floor_scale(1280,1024,640,480),0);
    test("exact_halving_floor_accepts",common_positive_floor_scale(1280,960,640,480),1);
    test("exclusive_interval_boundary_rejects",common_positive_floor_scale(1280,960,640,479),0);
    test("one_axis_extra_pixel_rejects",common_positive_floor_scale(1280,960,640,481),0);
    test("int64_cross_products_above_int32_accept",common_positive_floor_scale(65535,65535,65535,65535),1);
    test("int64_exact_above_int32_accept",exact_aspect(65535,65535,65535,65535),1);
    test("zero_config_rejects",common_positive_floor_scale(0,10652,640,480),0);
    test("negative_config_rejects",common_positive_floor_scale(-14204,10652,640,480),0);
    test("above_bound_config_rejects",common_positive_floor_scale(65536,10652,640,480),0);
    f=actual;f.rx=1;test("nonzero_roi_rejects",native_configured_output_contract(f),0);
    f=actual;f.rh--;test("partial_roi_rejects",native_configured_output_contract(f),0);
    f=actual;f.lw--;test("locked_image_mismatch_rejects",native_configured_output_contract(f),0);
    f=actual;f.oh--;test("configured_pair_mismatch_rejects",native_configured_output_contract(f),0);
    f=actual;f.stride++;test("unpacked_stride_rejects",native_configured_output_contract(f),0);
    f=actual;f.format=1;test("non_rgb_format_rejects",native_configured_output_contract(f),0);
    f=actual;f.ow=0;test("zero_configured_output_rejects",native_configured_output_contract(f),0);
    printf("\n],\"passed\":%u,\"case_count\":%u,"
           "\"cross_product_delta\":%lld,\"reported_config\":[14204,10652],"
           "\"reported_image\":[640,480],\"source_of_actual_values\":\"root_device_receipt\"}\n",
           count,count,(long long)((int64_t)14204*480-(int64_t)10652*640));
    return 0;
}
