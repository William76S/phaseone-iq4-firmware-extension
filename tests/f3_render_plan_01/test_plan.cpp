#include "render_plan.h"
#include <array>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <limits>
#include <string>
#include <vector>

static std::vector<std::string> passed;
static void check(bool v, const char *name) {
    if (!v) { std::cerr << "FAIL: " << name << '\n'; std::exit(1); }
    passed.emplace_back(name);
}
static f3_source source(uint32_t w = 14204, uint32_t h = 10652) {
    return {F3_RAW_POOL, w, h, 0, 0, w, h, 0, 42, 1, 1};
}
static f3_budget budget() {
    /* Host assumptions only, deliberately not supplied as target RAM facts. */
    return {UINT64_C(8) << 30, UINT64_C(4) << 30, UINT64_C(1) << 30,
            UINT64_C(1) << 28, UINT64_C(1) << 20, 1, 3};
}
struct SinkContext {
    f3_job *job;
    std::vector<uint8_t> pixels;
    bool fail = false, cancel = false, guards = false;
};
static f3_result sink(void *opaque, const f3_plane *p) {
    auto *c = static_cast<SinkContext *>(opaque);
    c->guards = c->job->owner_held && c->job->sink_active &&
        f3_job_release(c->job) == F3_BAD_STATE &&
        f3_job_consume(c->job, p, sink, opaque) == F3_BAD_STATE;
    if (c->cancel) f3_job_cancel(c->job);
    if (c->fail) return F3_NO_MEMORY;
    c->pixels.resize(static_cast<size_t>(p->width) * p->height * 3);
    for (uint32_t y = 0; y < p->height; ++y) {
        auto r = f3_rgb32_row(p, y, c->pixels.data() + y * p->width * 3,
                             p->width * 3);
        if (r != F3_OK) return r;
    }
    return F3_OK;
}
int main() {
    f3_source s = source(); f3_budget b = budget(); f3_plan p{};
    check(f3_make_plan(&s, F3_FULL, &b, &p) == F3_OK &&
          p.output_width == 14204 && p.output_height == 10652,
          "full uses valid complete RAW dimensions");
    check(p.rgb32_min_bytes == UINT64_C(605374464) &&
          p.planar_min_bytes == UINT64_C(151343616),
          "native whole RGB32 and planar rows include 32byte alignment");
    check(p.intermediate_pair_min_bytes == UINT64_C(1816123392) &&
          p.native_arena_min_bytes == UINT64_C(2572841472),
          "two whole RGB16 intermediates dominate multistage render");
    check(f3_make_plan(&s, F3_75_PERCENT, &b, &p) == F3_OK &&
          p.output_width == 10653 && p.output_height == 7989 &&
          p.render_width == 14204 && p.full_render_then_resample,
          "75percent is full render then resample");
    check(f3_make_plan(&s, F3_50_PERCENT, &b, &p) == F3_OK &&
          p.output_width == 7102 && p.output_height == 5326 &&
          !p.full_render_then_resample,
          "50percent specialized path preserves RAW requirement");
    check(UINT64_C(7102) * 5326 * 3 > UINT64_C(66739712),
          "halfsize RGB24 cannot fit old IFM 66739712byte backing");
    b.upper_bounds_verified = 0; b.reserved_bytes = UINT64_MAX;
    check(f3_make_plan(&s, F3_FULL, &b, &p) == F3_BUDGET_UNVERIFIED &&
          !p.admitted && p.native_arena_min_bytes > UINT64_C(2) * 1000000000,
          "huge reserved backing does not turn lower bound into proven budget");
    f3_job j{};
    check(f3_job_begin(&j, &p) == F3_BAD_ARGUMENT,
          "unverified budget cannot start job");
    b = budget(); b.reserved_bytes = 1000;
    check(f3_make_plan(&s, F3_FULL, &b, &p) == F3_NO_MEMORY && !p.admitted &&
          f3_job_begin(&j, &p) == F3_BAD_ARGUMENT,
          "insufficient bounded budget preserves RAW by rejecting job");
    b = budget(); b.native_arena_upper_bytes = 66739712;
    check(f3_make_plan(&s, F3_FULL, &b, &p) == F3_BUDGET_INCONSISTENT,
          "native upper budget below proved lower bound rejected");
    b = budget(); b.decoded_raw_upper_bytes = 1;
    check(f3_make_plan(&s, F3_50_PERCENT, &b, &p) == F3_BUDGET_INCONSISTENT,
          "halfsize still needs complete decoded RAW budget");
    b = budget(); b.extra_upper_bytes = 1;
    check(f3_make_plan(&s, F3_FULL, &b, &p) == F3_BUDGET_INCONSISTENT,
          "one-row sink conversion space included");
    b = budget(); b.native_arena_upper_bytes = UINT64_MAX;
    check(f3_make_plan(&s, F3_FULL, &b, &p) == F3_ARITHMETIC,
          "sum overflow rejected rather than wrapping RAM budget");
    b = budget(); s.kind = F3_THUMBNAIL;
    check(f3_make_plan(&s, F3_FULL, &b, &p) == F3_NOT_COMPLETE_RAW,
          "large declared thumbnail cannot qualify as RAW");
    s.kind = F3_LV_FRAME;
    check(f3_make_plan(&s, F3_FULL, &b, &p) == F3_NOT_COMPLETE_RAW,
          "LV input cannot qualify as export source");
    s = source(); s.immutable_owner_held = 0;
    check(f3_make_plan(&s, F3_FULL, &b, &p) == F3_NOT_COMPLETE_RAW,
          "unheld RAW owner rejected");
    s = source(); s.left = 1;
    check(f3_make_plan(&s, F3_FULL, &b, &p) == F3_BAD_CROP,
          "effective crop cannot exceed complete RAW dimensions");
    s = source(142, 108); s.left = 2; s.top = 4;
    s.valid_width = 139; s.valid_height = 101; s.rotation_degrees = 90;
    check(f3_make_plan(&s, F3_75_PERCENT, &b, &p) == F3_OK &&
          p.output_width == 76 && p.output_height == 104 &&
          p.render_width == 139 && p.render_height == 101,
          "effective crop odd dimensions round half up then orient");
    check((139 * 3 + 3) / 4 == 105 && p.output_height == 104,
          "native FCVTPS ceil mismatch must not silently satisfy selected size");
    s = source(65500, 65500);
    check(f3_make_plan(&s, F3_FULL, &b, &p) == F3_NATIVE_SIZE_LIMIT,
          "native signed byte size limit enforced");
    s = source(65501, 1);
    check(f3_make_plan(&s, F3_50_PERCENT, &b, &p) == F3_BAD_DIMENSIONS,
          "fixed JPEG dimensional limit checked before native call");

    s = source(3, 2); b = budget();
    check(f3_make_plan(&s, F3_FULL, &b, &p) == F3_OK &&
          f3_job_begin(&j, &p) == F3_OK &&
          f3_job_release(&j) == F3_BAD_STATE,
          "render owns RAW until joined completion");
    check(f3_job_render_complete(&j, 0) == F3_BAD_STATE &&
          f3_job_render_complete(&j, 1) == F3_OK,
          "render completion requires explicit worker join");
    std::array<uint8_t, 80> pixels; pixels.fill(0xa5);
    const std::array<uint8_t, 18> expected = {1,2,3, 4,5,6, 7,8,9,
                                            10,11,12, 13,14,15, 16,17,18};
    for (size_t y = 0; y < 2; ++y) for (size_t x = 0; x < 3; ++x) {
        pixels[16 + y * 20 + x * 4] = 0xfe;
        for (size_t c = 0; c < 3; ++c)
            pixels[17 + y * 20 + x * 4 + c] = expected[y * 9 + x * 3 + c];
    }
    const auto before = pixels;
    f3_plane plane{pixels.data(), pixels.size(), 16, 20, 3, 2, 4, 42};
    SinkContext ctx{&j, {}, false, false, false};
    check(f3_job_consume(&j, &plane, sink, &ctx) == F3_OK && ctx.guards &&
          ctx.pixels == std::vector<uint8_t>(expected.begin(), expected.end()) &&
          pixels == before,
          "borrowed padded RGB32 sink exact byteorder guards immutable input");
    std::array<uint8_t, 10> row; row.fill(0x88);
    check(f3_rgb32_row(&plane, 1, row.data(), 8) == F3_NO_MEMORY &&
          row == std::array<uint8_t, 10>{0x88,0x88,0x88,0x88,0x88,0x88,0x88,0x88,0x88,0x88},
          "short row output refuses without partial write");
    check(f3_rgb32_row(&plane, 1, pixels.data(), 9) == F3_BAD_PLANE && pixels == before,
          "destination aliasing whole input allocation rejected");
    auto bad = plane; bad.allocation_bytes = 47;
    check(f3_job_consume(&j, &bad, sink, &ctx) == F3_BAD_PLANE,
          "cropped lastrow requires actual byte bound");
    bad = plane; bad.stride = 11;
    check(f3_job_consume(&j, &bad, sink, &ctx) == F3_BAD_PLANE,
          "stride smaller than row rejected");
    bad = plane; bad.stride = UINT64_MAX;
    check(f3_job_consume(&j, &bad, sink, &ctx) == F3_BAD_PLANE,
          "lastrow address overflow rejected");
    bad = plane; bad.identity = 43;
    check(f3_job_consume(&j, &bad, sink, &ctx) == F3_BAD_PLANE,
          "different source job plane rejected");
    bad = plane; bad.width = 2;
    check(f3_job_consume(&j, &bad, sink, &ctx) == F3_BAD_PLANE,
          "native different dimension cannot satisfy requested output");
    ctx.fail = true;
    check(f3_job_consume(&j, &plane, sink, &ctx) == F3_NO_MEMORY && j.owner_held &&
          j.state == F3_JOB_READY && pixels == before,
          "encoder capacity failure keeps RAW until controlled release");
    ctx.fail = false; ctx.cancel = true;
    check(f3_job_consume(&j, &plane, sink, &ctx) == F3_CANCELLED && j.owner_held &&
          j.state == F3_JOB_CANCEL_PENDING && f3_job_release(&j) == F3_OK,
          "cancel during synchronous sink defers release until sink return");
    check(f3_job_begin(&j, &p) == F3_OK && f3_job_cancel(&j) == F3_OK &&
          f3_job_release(&j) == F3_BAD_STATE,
          "render timeout is not permission to release live RAW owner");
    check(f3_job_join_cancelled(&j) == F3_OK && f3_job_release(&j) == F3_OK &&
          f3_job_release(&j) == F3_BAD_STATE,
          "cancelled render joins before exactly once release");
    std::cout << "{\"schema\":\"iq4_f3_render_plan_host_01\",\"target_executed\":false,"
                 "\"source_dimensions_are_host_examples\":true,\"passed\":" << passed.size()
              << ",\"cases\":[";
    for (size_t i = 0; i < passed.size(); ++i)
        std::cout << (i ? "," : "") << '"' << passed[i] << '"';
    std::cout << "]}\n";
}
