#pragma once
#include "../f3_raw_file_source_01/source_builder.hpp"
#include "../f3_render_plan_01/render_plan.h"

namespace iq4::native_render_02 {
using raw_file_source_01::SourceBundle;
using raw_file_source_01::Candidate;
constexpr std::uint64_t PrefixBytes = 80u * 1024u * 1024u;
enum class Result { Ok, Argument, Unbound, Busy, SourceLost, Geometry, Capacity,
    UnsupportedProfile, NativeException, Incomplete, Plane, Sink, Hold };
struct Attempt {
    std::uint64_t mapped_bytes = 0, decoded_reservation = 0;
    std::uint64_t rgb32_min = 0, planar_min = 0, rgb16_pair_min = 0;
    std::uint64_t core_min = 0, lower_bound = 0;
    // These are computed physical minima, never a native working-set upper bound.
};
Result bounded_attempt(const Candidate&, std::uint64_t mapped_bytes, Attempt&) noexcept;
struct SourceLease {
    SourceBundle* bundle = nullptr;
    Candidate geometry{};
    std::uint64_t identity = 0;
    void* context = nullptr;
    bool (*still_held)(void*, const void* input, void* tags, std::uint64_t identity) = nullptr;
    // The holder checks the actual ReaderStage fd/file/card/source lease.
    // SourceBundle::ready is encoded-section provenance, not decoded completion.
};
struct NativeApi {
    bool original_image_and_abi_verified = false, cpp_unwind_verified = false;
    void (*settings_construct)(void*) = nullptr;  // 7bbc54, actual containers
    void (*settings_destroy)(void*) = nullptr;    // 7bbf44, nondeleting
    void (*generator_construct)(void*, void*, std::uint64_t) = nullptr;
    void (*generator_destroy)(void*) = nullptr;
    void (*image_construct)(void*) = nullptr;
    void (*image_destroy)(void*) = nullptr;
    void (*configure_source)(void*, std::uint32_t, void*) = nullptr;
    void (*configure_profile)(void*, void*, std::uint32_t) = nullptr;
    std::uint32_t (*process)(void*, const void*, void*, void*, void*, void*, const std::uint8_t*) = nullptr;
    void (*pool_join)(void*) = nullptr;
    const std::uint8_t* (*image_plane)(const void*) = nullptr;
    std::uint32_t (*image_width)(const void*) = nullptr;
    std::uint32_t (*image_height)(const void*) = nullptr;
    std::uint32_t (*image_stride)(const void*) = nullptr;
    std::uint32_t (*image_format)(const void*) = nullptr;
};
struct Owner {
    void* generator; const void* input; void* rgb32; void* planar;
    void* settings; void* pool; const std::uint8_t* cancel;
    std::uint8_t* arena; std::uint64_t capacity, identity;
    Candidate geometry;
};
struct Receipt {
    bool reader_returned = false, decoded_rows_complete = false;
    bool decode_workers_joined = false, full_r0_core_complete = false;
    bool core_workers_joined = false;
    // No caller-set "complete" bit. The target provider must obtain all five
    // observations from exact original call wrappers on these owned identities.
};
struct Completion {
    void* context = nullptr;
    bool exact_hooks_and_owner_contract_verified = false;
    Result (*begin)(void*, const Owner&) = nullptr;
    Result (*end)(void*, const Owner&, std::uint32_t actual_return, Receipt&) = nullptr;
    // Called after failed process + successful pool join to retire receipts.
    Result (*abort_after_join)(void*, const Owner&) = nullptr;
};
struct PoolLease {
    void* pool = nullptr; void* context = nullptr;
    bool (*held_started_exclusive)(void*, const void*) = nullptr;
    // Original ctor 716a84 does not start workers. 716c58 starts them.
    // Persistent owner retains the pool; this adapter only joins, never invents
    // a shutdown/dtor ABI or frees an original live worker.
};
struct State {
    bool settings_alive = false, generator_alive = false;
    bool rgb32_alive = false, planar_alive = false;
    bool join_needed = false, receipt_active = false, source_held = false;
    bool sink_active = false, quarantined = false;
};
class Session final {
public:
    Session(NativeApi api, Completion completion) noexcept : api_(api), completion_(completion) {}
    Session(const Session&) = delete; Session& operator=(const Session&) = delete;
    Result run(SourceLease, PoolLease, std::uint32_t sensor_id,
               std::uint8_t* mapped, std::uint64_t mapped_bytes,
               const std::uint8_t* cancel, f3_sync_rgb32_sink, void* sink_context);
    Result cleanup();
    State state() const noexcept { return state_; }
    const Attempt& attempt() const noexcept { return attempt_; }
    const Owner& owner() const noexcept { return owner_; }
private:
    bool source_held() const;
    bool pool_held() const;
    Result finish(Result);
    NativeApi api_; Completion completion_; SourceLease source_{}; PoolLease pool_{};
    Attempt attempt_{}; Owner owner_{}; State state_{};
    alignas(16) std::uint8_t settings_[0x2c8]{};
    alignas(16) std::uint8_t generator_[0x1f0]{};
    alignas(16) std::uint8_t rgb32_[0x58]{}, planar_[0x58]{};
};
} // namespace iq4::native_render_02
