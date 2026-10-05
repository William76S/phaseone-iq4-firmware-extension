#pragma once
#include "iq4/display_mask.hpp"
#include <array>
#include <cstddef>
#include <cstdint>

namespace iq4::f1::native_overlay {
using Address=std::uintptr_t;
inline constexpr char UserSHA[]="9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb";
struct Rectangle24 {Address address_point{};std::int32_t x{},y{},width{},height{};};
struct Color4 {std::uint8_t alpha{},c1{},c2{},c3{};};
static_assert(sizeof(Rectangle24)==24&&offsetof(Rectangle24,width)==16&&sizeof(Color4)==4);
// Native wrapper clones the input clip, then converts drawRect to inclusive
// endpoints. Do not substitute an empty/negative rectangle or a four-int ABI.
using FillWrapper=void (*)(void*,const Rectangle24*,const Rectangle24*,const Color4*);
using LVPaint=Rectangle24 (*)(void*,void*,const Rectangle24*,Rectangle24*);
struct Memory {void* context{};bool (*read)(void*,Address,void*,std::size_t) noexcept{};};
struct Native {
    FillWrapper fill{};void* context{};Address (*current_thread)(void*) noexcept{};
    // Own-code bridge port: a future exact original UI binding requests a stock
    // repaint on the already bound LV, not a new UI/capture/property operation.
    bool (*request_stock_repaint)(void*,Address) noexcept{};
};
struct Gate {
    const char* actual_UserSHA{};Address ui_owner{},LV{},load_bias{};
    std::uint32_t actual_pitch{},actual_height{};
    bool actual_whole_User_and_segments{},actual_UI_owner_boundary{},actual_LV_paint_ABI{},actual_display_surface_owner_and_extent{},
         actual_source_geometry_and_image_viewport{},actual_original_blit_receipt{},actual_original_repaint_and_disable_restore{},actual_callback_lifetime{};
};
struct PixelRect {std::int32_t x{},y{},width{},height{};};
struct FixedPlan {
    std::array<PixelRect,4> bands{};std::size_t count{};
    PixelRect image_clip{};std::uint8_t alpha{};MaskHidden hidden{MaskHidden::Disabled};
};
// Pure conversion of the existing display plan. Non-axis geometry, boundary
// strokes, invalid area/alpha and overlapping raster bands are rejected.
bool fixed_plan(const display::DrawPlan&,FixedPlan&) noexcept;
struct PaintObservation {
    std::uint32_t pre_original_countdown{};Rectangle24 original_return{};
    bool original_returned_normally{};
};
// A static candidate branch predicate only; not a fresh-display observation.
bool candidate_native_blit(const PaintObservation&) noexcept;
struct Receipt {
    Address LV{},surface{};Rectangle24 clip{};
    PixelRect actual_stock_repaint_coverage{}; // Display pixels actually restored this callback.
    std::uint64_t UI_paint_serial{},geometry_epoch{},configuration_generation{};
    bool original_returned_normally{},actual_native_image_blit_completed{},display_owner_lease_live{},LV_still_current{};
};
enum class Phase:std::uint8_t {Disabled,OffAwaitingRepaint,OffClean,MaskAwaitingRepaint,MaskShown,Hold,FactoryRestored};
enum class Result:std::uint8_t {Ok,Disabled,WrongThread,Pending,Rejected,Hold};
struct Status {
    Phase phase{};MaskMode mode{MaskMode::Off};std::uint64_t generation{},fills{},rejected{},duplicate_paints{};
    bool callback_and_module_retained{true},factory_repaint_confirmed{};
};
// This adapter only receives display geometry and a callback-local display
// Surface object. It never reads Surface+38 pixels, source frames, RAW/JPEG,
// encoder buffers, security/storage records or file/config data.
class Adapter {
public:
    Adapter() noexcept=default;
    bool configure(Memory,Native,Gate) noexcept; // Production always false.
    Result select_on_ui(MaskMode,const display::ViewMapping&,std::uint64_t geometry_epoch) noexcept;
    Result after_original_paint_on_ui(const Receipt&) noexcept;
    Result disable_on_ui() noexcept;
    Status status_on_ui() const noexcept{return status_;}
    const FixedPlan& plan_on_ui() const noexcept{return plan_;}
private:
    bool on_ui() const noexcept;
    bool surface_valid(const Receipt&,Rectangle24&) const noexcept;
    void hold() noexcept;
    Memory memory_{};Native native_{};Gate gate_{};display::TemporaryMask mask_{};
    Status status_{};FixedPlan plan_{};std::uint64_t geometry_epoch_{},last_paint_{};
    PixelRect required_clean_{}; // Old/new union until a confirmed full repaint.
    bool configured_{},in_paint_{},disabling_{};
};
}
