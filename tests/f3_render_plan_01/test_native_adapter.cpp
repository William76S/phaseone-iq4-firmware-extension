#include "native_render_adapter.h"
#include <array>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <memory>
#include <string>
#include <vector>
static unsigned count = 0;
static void check(bool v, const char *name) {
    if (!v) { std::cerr << "FAIL: " << name << '\n'; std::exit(1); }
    ++count;
}
struct Fake {
    std::vector<std::string> events;
    uint8_t *backing = nullptr;
    f3_native_adapter *adapter = nullptr;
    bool configured_fail = false, process_fail = false, join_fail = false;
    bool image_ctor_fail = false, completed = true, joined = true;
    bool sink_called = false, guarded = false, corrupt_dimensions = false;
};
static f3_result gc(void *c, void *g, void *b, uint64_t) {
    auto &f = *static_cast<Fake *>(c); f.events.push_back("generator_construct");
    f.backing = static_cast<uint8_t *>(b);
    std::memset(g, 0, F3_NATIVE_GENERATOR_BYTES); return F3_OK;
}
static f3_result gd(void *c, void *) {
    static_cast<Fake *>(c)->events.push_back("generator_destroy"); return F3_OK;
}
static f3_result ic(void *c, void *v) {
    auto &f = *static_cast<Fake *>(c); f.events.push_back("image_construct");
    if (f.image_ctor_fail) return F3_NATIVE_FAILURE;
    std::memset(v, 0, F3_NATIVE_IMAGE_BUFFER_BYTES); return F3_OK;
}
static f3_result id(void *c, void *) {
    static_cast<Fake *>(c)->events.push_back("image_destroy"); return F3_OK;
}
static f3_result cs(void *c, void *, uint32_t, void *) {
    auto &f = *static_cast<Fake *>(c); f.events.push_back("configure_source");
    return f.configured_fail ? F3_NATIVE_FAILURE : F3_OK;
}
static f3_result cp(void *c, void *, void *, uint32_t) {
    static_cast<Fake *>(c)->events.push_back("configure_profile"); return F3_OK;
}
static f3_result process(void *c, void *, const void *, void *, void *, void *,
                          void *, const uint8_t *, f3_native_process_outcome *o) {
    auto &f = *static_cast<Fake *>(c); f.events.push_back("process");
    /* This is a host lifecycle simulator, never a RAW decoder or native ABI test. */
    uint8_t *v = f.backing + F3_NATIVE_GENERATOR_PREFIX_BYTES;
    for (unsigned y = 0; y < 2; ++y) for (unsigned x = 0; x < 3; ++x) {
        v[y * 32 + x * 4] = 0xf0;
        for (unsigned k = 1; k < 4; ++k) v[y * 32 + x * 4 + k] = y * 9 + x * 3 + k;
    }
    *o = {1, static_cast<uint32_t>(f.completed), static_cast<uint32_t>(f.joined)};
    return f.process_fail ? F3_NATIVE_FAILURE : F3_OK;
}
static f3_result join(void *c, void *) {
    auto &f = *static_cast<Fake *>(c); f.events.push_back("join_after_failure");
    return f.join_fail ? F3_NATIVE_FAILURE : F3_OK;
}
static f3_result plane(void *c, const void *, const uint8_t **p, uint32_t *w,
                        uint32_t *h, uint32_t *s, uint32_t *fmt) {
    auto &f = *static_cast<Fake *>(c); f.events.push_back("get_plane");
    *p = f.backing + F3_NATIVE_GENERATOR_PREFIX_BYTES;
    *w = f.corrupt_dimensions ? 2 : 3; *h = 2; *s = 32; *fmt = 5; return F3_OK;
}
static f3_result sink(void *c, const f3_plane *p) {
    auto &f = *static_cast<Fake *>(c); f.events.push_back("synchronous_sink");
    f.sink_called = true;
    f.guarded = f.adapter->job.owner_held && f.adapter->generator_alive &&
        f.adapter->rgb32_alive && f.adapter->job.sink_active &&
        f3_native_cleanup(f.adapter) == F3_BAD_STATE;
    std::array<uint8_t, 9> row{};
    if (f3_rgb32_row(p, 1, row.data(), row.size()) != F3_OK) return F3_BAD_PLANE;
    const std::array<uint8_t, 9> expected{10,11,12,13,14,15,16,17,18};
    return row == expected ? F3_OK : F3_BAD_PLANE;
}
static void put_float(std::array<uint8_t, F3_NATIVE_SETTINGS_MIN_BYTES> &v,
                       size_t off, float x) { std::memcpy(v.data()+off, &x, 4); }
static void put_u32(std::array<uint8_t, F3_NATIVE_SETTINGS_MIN_BYTES> &v,
                     size_t off, uint32_t x) { std::memcpy(v.data()+off, &x, 4); }
int main() {
    f3_source source{F3_RAW_POOL,3,2,0,0,3,2,0,42,1,1};
    f3_budget budget{UINT64_C(96)<<20,65536,4096,65536,65536,1,3}; f3_plan plan{};
    check(f3_make_plan(&source, F3_FULL, &budget, &plan) == F3_OK &&
          plan.generator_backing_upper_bytes == F3_NATIVE_GENERATOR_PREFIX_BYTES + 65536 + 4096,
          "owned generator backing includes original prefix and decoded RAW");
    const size_t bytes = static_cast<size_t>((plan.generator_backing_upper_bytes + 31) & ~UINT64_C(31));
    std::unique_ptr<uint8_t, decltype(&std::free)> backing(
        static_cast<uint8_t *>(std::aligned_alloc(32, bytes)), &std::free);
    if (!backing) return 1;
    std::array<uint8_t, F3_NATIVE_SETTINGS_MIN_BYTES> settings{};
    put_float(settings, 0, 1); put_float(settings, 4, 3); put_float(settings, 8, 2);
    put_u32(settings, 0x20, 5); put_u32(settings, 0x2c0, 3); put_u32(settings, 0x2c4, 2);
    uint8_t cancel = 0; int raw = 1, tags = 2, pool = 3;
    f3_native_input input{&raw,&tags,settings.data(),settings.size(),&pool,&cancel,1,1,1,1,1};
    Fake f; f3_native_adapter a{}; f.adapter = &a;
    f3_native_ops ops{&f,1,gc,gd,ic,id,cs,cp,process,join,plane};
    auto run = [&]() { return f3_native_render(&a,&ops,&source,&plan,&input,
        backing.get(),bytes,sink,&f); };
    ops.exact_original_and_abi_verified = 0;
    check(run() == F3_NATIVE_UNBOUND && f.events.empty(),
          "unverified binding cannot invoke original or fake native operations");
    ops.exact_original_and_abi_verified = 1;
    input.tags_exclusively_owned = 0;
    check(run() == F3_BAD_ARGUMENT && f.events.empty(),
          "borrowed stock tag map cannot be mutated by owned raw source factory");
    input.tags_exclusively_owned = 1;
    check(run() == F3_OK && f.sink_called && f.guarded && !a.job.owner_held &&
          f.events == std::vector<std::string>{"generator_construct","image_construct",
          "image_construct","configure_source","configure_profile","process","get_plane",
          "synchronous_sink","image_destroy","image_destroy","generator_destroy"},
          "construct configure render borrowed sink destroy exact lifecycle");
    f.events.clear(); f.sink_called = false; f.completed = false;
    check(run() == F3_NATIVE_FAILURE && !f.sink_called && !a.generator_alive &&
          !a.job.owner_held,
          "vendor bool1 and correct shape do not imply completed pixels");
    f.events.clear(); f.completed = true; f.corrupt_dimensions = true;
    check(run() == F3_BAD_PLANE && !f.sink_called && !a.job.owner_held,
          "4K or differently rounded plane cannot satisfy output request");
    f.events.clear(); f.corrupt_dimensions = false; f.configured_fail = true;
    check(run() == F3_NATIVE_FAILURE && !f.sink_called &&
          f.events.back() == "generator_destroy" && !a.job.owner_held,
          "source failure destroys native image holders before generator");
    f.events.clear(); f.configured_fail = false; f.image_ctor_fail = true;
    check(run() == F3_NATIVE_FAILURE && f.events == std::vector<std::string>{
          "generator_construct","image_construct","generator_destroy"},
          "failed native constructor is not destructed as complete object");
    f.events.clear(); f.image_ctor_fail = false;
    put_float(settings, 0, 0.49f);
    check(run() == F3_BAD_ARGUMENT && f.events.empty(),
          "old clamp settings cannot silently render undersized request");
    put_float(settings, 0, 1); f.process_fail = true; f.joined = false; f.join_fail = true;
    check(run() == F3_CLEANUP_FAILURE && a.join_needed && a.generator_alive &&
          a.rgb32_alive && a.planar_alive && a.job.owner_held && !f.sink_called,
          "unjoined native failure retains source arena and all objects");
    f.join_fail = false;
    check(f3_native_cleanup(&a) == F3_OK && !a.join_needed && !a.generator_alive &&
          !a.job.owner_held,
          "retained failed job can join and clean up without native rerender");
    cancel = 1; f.events.clear();
    check(run() == F3_CANCELLED && f.events.empty(),
          "cancelled job never invokes renderer");
    std::cout << "{\"schema\":\"iq4_f3_native_adapter_host_simulator_01\","
                 "\"target_executed\":false,\"raw_decoded\":false,\"passed\":"
              << count << "}\n";
}
