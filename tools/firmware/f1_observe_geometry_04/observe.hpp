#pragma once
#include "../f1_module_entry_01/module.hpp"
#include "../f1_geometry_probe_03/probe.hpp"
#include <atomic>
#include <cstddef>

namespace iq4::f1::observe04 {
using namespace native_ui02;
// Explicit U32 flags rather than publishing compiler-dependent bool padding.
// This is a scalar candidate snapshot. No source/surface pixel pointer exists.
struct WireFacts {
    Rectangle24 local_control{},recursive_bounds_candidate{},locked_roi{};
    std::int32_t pan_x{},pan_y{};float scale{},normal_fit_scale{};
    std::int32_t rotation{},client_id{},access_owner{},config_width{},config_height{},slot_width{},slot_height{};
    std::uint32_t countdown{},software_completion_id{},locked_slot{},parent_depth{},alignment_flags{};
    std::uint32_t running{},visible{},pan_animation{},borrowed_pointer_present{},retain_borrowed{},locked_metadata_present{},
      recursive_bounds_candidate_present{},parent_transform_would_update_local_size{},consistent_double_read{},reserved{};
};
enum class Result:std::uint32_t {Ok,OwnerRejected,ReadFailed,Changing,Invalid,UnsupportedParent,NoSourceLease,NoPaintScope,NotAttempted,SourceRejected};
struct Metadata {
    std::uint32_t schema{4},bytes{sizeof(Metadata)},result{static_cast<unsigned>(Result::NotAttempted)},scalar_present{};
    std::uint64_t attempts{},geometry_epoch{},source_dispatch_epoch{},successes{},rejected{};
    unsigned char exact_user_sha256[32]{
      0x9b,0x61,0x1e,0xfe,0x64,0x06,0x76,0x85,0xb7,0x70,0xba,0x39,0x84,0xae,0x95,0x16,
      0x84,0xc5,0xa4,0x01,0xf7,0x3f,0x77,0xa0,0x3b,0x31,0x6b,0xe3,0x74,0x03,0x2c,0xdb};
    std::uint64_t exact_user_bytes{11874544};
    Address access{},engine{},buffer{};
    std::uint32_t source_startup{},paint_scope_called{},full_source_mapping_verified{},fresh_blit_verified{},surface_lease_verified{},reserved{};
    entry01::Observation source{};
    WireFacts facts{};
};
struct Published {
    std::atomic<unsigned> sequence{0};unsigned bytes{sizeof(Published)},schema{4},reserved{};
    Metadata metadata{};
};
static_assert(sizeof(WireFacts)==176 && offsetof(WireFacts,consistent_double_read)==168);
static_assert(sizeof(Metadata)==744 && offsetof(Metadata,source)==144 && offsetof(Metadata,facts)==568);
static_assert(sizeof(Published)==760 && offsetof(Published,metadata)==16);
// Runs only on the actual qualified UI boundary in runtime_linux.cpp. It does
// not configure Module, accept an enable Gate, mutate User, or call a native
// getter. Frozen Probe independently checks FP/TLS/current/owner twice.
class Collector {
public:
    Collector(Memory memory,Address bias)noexcept:memory_(memory),bias_(bias){}
    bool capture(const BoundaryInput&,const entry01::Observation&,unsigned actual_entry_startup,Metadata&)noexcept;
private:
    Memory memory_{};Address bias_{};Metadata state_{};
};
}
