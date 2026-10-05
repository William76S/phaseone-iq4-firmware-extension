#pragma once
#include "../f1_observe_stack_05/observe.hpp"
#include "../f1_observe_geometry_04/observe.hpp"
#include "native_layout.hpp"
#include <atomic>

namespace iq4::f1::display06 {
using namespace native_ui02;
using WireGeometry=observe04::WireFacts;
enum class Result:std::uint32_t {NotAttempted,Collected,OwnerRejected,ReadFailed,Changing,Invalid,NoPaintScope,SourceRejected,TableRejected};
enum class Kind:std::uint32_t {None,Boundary,Paint};
struct OwnerFacts {
    Owner owner{};
    Address actual_lv_vtable{},provider{},provider_vtable{},getter_target{},present_target{},configurator_provider{};
    Address resource_wrapper{},lv_resource_wrapper{},resource_provider{},resource_provider_vtable{},popup_header{},popup_root{},popup_selected{};
    Address provider_typeinfo{};std::int64_t provider_offset_to_top{};
    unsigned char getter_first16[16]{},present_first16[16]{};
    std::uint32_t provider_header_present{},getter_prefix_present{},present_prefix_present{},getter_in_original_user_executable_load{};
    std::uint32_t provider_alias_equal{},resource_alias_equal{},popup_title{},popup_depth{},stack_shape{},shadow_instance{};
};
struct GeometryFacts {
    WireGeometry scalars{};
    Address access{},engine{},buffer{};
    geometry03::Point8 config_point_candidates[4]{};
    std::uint32_t config_point_model_valid{},config_equals_slot{},config_equals_roi{},slot_equals_roi{};
};
struct PaintFacts {
    Address thread_pointer{},wrapper_frame{},caller_pc{},control_frame{},manager_frame{},lv{},surface{},draw_arg{},clip_arg{},draw_owner{},draw_vtable{};
    Rectangle24 input_draw{},input_clip{},display_bounds{},original_return{},post_draw{},post_clip{},post_display_bounds{};
    std::uint32_t pitch_pixels{},height{},original_returned_normally{},geometry_equal_before_after{},post_pitch_pixels{},post_height{},surface_metadata_equal{},reserved{};
};
struct Metadata {
    std::uint32_t schema{6},bytes{sizeof(Metadata)},result{},kind{};
    unsigned char exact_user_sha256[32]{0x9b,0x61,0x1e,0xfe,0x64,0x06,0x76,0x85,0xb7,0x70,0xba,0x39,0x84,0xae,0x95,0x16,0x84,0xc5,0xa4,0x01,0xf7,0x3f,0x77,0xa0,0x3b,0x31,0x6b,0xe3,0x74,0x03,0x2c,0xdb};
    std::uint64_t exact_user_bytes{11874544};
    std::uint64_t boundary_attempts{},paint_attempts{},publication_epoch{},source_dispatch_epoch{},source_stack_epoch{},paint_call_serial{};
    Address own_shadow_address_point{},own_paint_callback{};
    // Counts/consistency never become full mapping, pixel completion or lease.
    std::uint32_t owner_present{},geometry_present{},paint_present{},shadow_table_ready{};
    std::uint32_t source_anchor_startup{},source_anchor_relation{};
    std::uint32_t mask_enabled{},full_source_mapping_verified{},fresh_blit_verified{},surface_lease_verified{};
    std::uint32_t native_provider_getter_called{},native_fill_called{},native_ui_mutation_called{},reserved{};
    OwnerFacts owner_before{},owner_after{};
    GeometryFacts geometry_before{},geometry_after{};
    PaintFacts paint{};
};
struct Published {
    std::atomic<unsigned> sequence{0};unsigned bytes{sizeof(Published)},schema{6},reserved{};
    Metadata metadata{};
};
// This collector writes only project-owned state. Creating the private shadow
// table does not install it: no native vptr/tree/menu/event is written here.
// Paint identity accepts only the recorded LV, original table or this instance's
// complete exact table (one paint slot changed); no read adapter impersonation.
class Collector {
public:
    Collector(Memory,Address bias,Address exact_own_paint_callback)noexcept;
    bool capture_boundary(const BoundaryInput&,const stack05::Metadata&,Metadata&)noexcept;
    bool before_paint(const geometry03::PaintInput&,Metadata&)noexcept;
    bool after_paint(const geometry03::PaintInput&,const Rectangle24&,Metadata&)noexcept;
    void aborted_paint(Metadata&)noexcept;
    Address shadow_address_point()const noexcept{return table_ready_?reinterpret_cast<Address>(shadow_.data()+2):0;}
    Metadata snapshot()const noexcept{return state_;}
private:
    Result owner(Address tp,OwnerFacts&,bool painting)const noexcept;
    Result geometry(const OwnerFacts&,GeometryFacts&)const noexcept;
    Result paint_scope(const geometry03::PaintInput&,PaintFacts&)const noexcept;
    bool table(Address actual)const noexcept;
    bool read(Address,void*,std::size_t)const noexcept;
    bool word(Address p,Address&v)const noexcept{return read(p,&v,8);}
    Memory memory_{};Address callback_{};Owner bound_{};
    alignas(16)std::array<Address,61>shadow_{};
    bool table_ready_{},paint_pending_{};geometry03::PaintInput pending_{};
    Metadata state_{};
};
// Forwarding is always original-first with one call. Capture failures do not
// suppress/repeat the original paint. Original exceptions are propagated and
// cannot be reported as a normal return. This helper has no target installer.
Rectangle24 forward_once(native_overlay::LVPaint,void*,void*,const Rectangle24*,Rectangle24*,
                         Collector*,const geometry03::PaintInput*,Published*);
void publish(Published&,const Metadata&)noexcept;
}
