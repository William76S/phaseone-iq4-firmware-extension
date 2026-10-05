#pragma once
#include "../f1_native_ui_02/ui.hpp"
#include <array>
#include <cstddef>
#include <cstdint>

namespace iq4::f1::geometry03 {
using Address=native_ui02::Address;
using Memory=native_ui02::Memory;
using Rectangle24=native_ui02::Rectangle24;
using Owner=native_ui02::Owner;
using BoundaryInput=native_ui02::BoundaryInput;
struct Point8 {std::int32_t x{},y{};};
struct Rect {std::int32_t x{},y{},w{},h{};};
enum class Result:std::uint8_t {Ok,OwnerRejected,ReadFailed,Changing,Invalid,UnsupportedParent,NoSourceLease,NoPaintScope};
// Finite scalar facts only. No pixel pointer, pixel byte, crop/property setter,
// Security pointer or SDK method occurs in this API. W/H are LV config and
// locked-slot candidates, never labelled sensor/RAW dimensions.
struct Facts {
    Rectangle24 local_control{},recursive_bounds_candidate{},locked_roi{};
    Point8 pan_cached{};
    float scale{},normal_fit_scale{};
    std::int32_t rotation{},client_id{},access_owner{},config_width{},config_height{},slot_width{},slot_height{};
    std::uint32_t countdown{},software_completion_id{},locked_slot{4},parent_depth{},alignment_flags{};
    bool running{},visible{},pan_animation{},borrowed_pointer_present{},retain_borrowed{},locked_metadata_present{},
         recursive_bounds_candidate_present{},parent_transform_would_update_local_size{},consistent_double_read{};
    // Always false: an instruction-consistent snapshot is not actual mapping.
    bool full_source_mapping_verified{},fresh_blit_verified{},surface_lease_verified{};
};
struct Observation {Owner owner{};Facts facts{};};
class Probe {
public:
    Probe(Memory memory,Address load_bias)noexcept:memory_(memory),bias_(load_bias){}
    // Validates the captured architectural original-first UI boundary, actual
    // current LV, Access/data binding and two agreeing bounded snapshots.
    Result collect_boundary(const BoundaryInput&,Observation&)const noexcept;
    // For a separately verified original paint wrapper on the same UI thread.
    // This independently validates TP and owner; caller-provided booleans are
    // not accepted as UI proof. It does not acquire/release the source lock.
    Result collect_owner(Address thread_pointer,Address expected_lv,Observation&)const noexcept;
private:
    bool read(Address,void*,std::size_t)const noexcept;
    Result once(const Owner&,Facts&)const noexcept;
    bool recursive_bounds(Address,Rectangle24&,std::uint32_t&,bool&)const noexcept;
    Memory memory_{};Address bias_{};
};
// Captured on the OWN wrapper stack while original Control::Draw is suspended
// at its actual LV paint call. No fabricated Surface owner or lease boolean.
struct PaintInput {Address thread_pointer{},frame_pointer{},caller_pc{},lv{},surface{},draw_rectangle{},clip_rectangle{};};
struct PaintScope {
    Owner owner{};Address control_frame{},manager_frame{},surface_provider{};
    Rectangle24 original_draw{},original_clip{},display_bounds{};
    std::uint32_t pitch_pixels{},height{};
    bool context_chain_consistent{},display_extent_valid{};
    // Remains false: the stack validates lexical draw scope, not a provider
    // lifetime guarantee or fresh full-image pixel write.
    bool surface_lease_verified{},actual_fresh_blit_verified{};
};
Result collect_paint_scope(Memory,Address load_bias,const PaintInput&,PaintScope&)noexcept;

// Pure instruction models used to compare finite actual observations later.
// They never call native getters (both pan and recursive bounds can mutate).
bool parent_transform(const Rectangle24&local,std::uint32_t flags,std::int32_t pad,
                      const Rectangle24&parent,Rectangle24&out,bool&writes_size)noexcept;
bool point_candidate(const Facts&,Point8 source,Point8&display)noexcept;
bool fit_candidate(Rect destination,std::int32_t source_w,std::int32_t source_h,
                   std::int32_t rotation,Rect&fitted,float&scale)noexcept;
// Surface metadata finite [0,0x38) only. Never reads pixel pointer Surface+38.
bool read_surface_metadata(Memory,Address load_bias,Address surface,Rectangle24&,
                           std::uint32_t&pitch_pixels,std::uint32_t&height)noexcept;

// Deliberately no enabled geometry or fresh-receipt output. Root's first RAM
// observe-only module can link collect_boundary/collect_paint_scope today;
// actual mapping and inner writes need the independent observations in README.
native_ui02::GeometryPort unavailable_geometry_port()noexcept;
bool fresh_receipt_unavailable(const PaintScope&,native_overlay::Receipt&)noexcept;
}
