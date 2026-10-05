#pragma once
#include "entry_binding_10.hpp"
#include "../f1_geometry_probe_03/probe.hpp"

namespace iq4::f1::normal10 {
using Address=native_ui02::Address;
using Rect=native_overlay::PixelRect;
using Rectangle=native_ui02::Rectangle24;
// Actual callback scalars; none is a sensor/exposure/frame-rate statement.
struct Geometry {
 std::int32_t source_width{},source_height{},rotation{};
 Rect source_rectangle{},clipped_source_rectangle{},image_viewport{},display_bounds{},clip{};
 float scale{},normal_fit_scale{};
 geometry03::Point8 pan{};
 std::uint32_t pan_animation{};
 std::int32_t config_width{},config_height{},captured_slot_width{},captured_slot_height{};
 Rect original_locked_roi{};
};
enum class GeometryResult:std::uint32_t {Invalid,NormalFullView,ZoomOrPan,PartialSource};
GeometryResult normal_mapping(const Geometry&,display::ViewMapping&)noexcept;
bool fixed_normal_plan(const Geometry&,MaskMode,native_overlay::FixedPlan&)noexcept;
struct WriteFacts {
 Address queue{},lv{},surface{},draw{},provider{},provider_vtable{},getter_target{},manager_frame{};
 std::uint64_t paint_serial{},geometry_epoch{};
 Geometry geometry{};
 Rect stock_clean_coverage{}; // Proven pixel writes, distinct from image extent.
 Address present_target{};std::uint32_t getter_words[6]{},present_words[4]{},getter_words_read{},present_words_read{};
};
// Production provider.hpp implements the sole issuer, with a Root-reviewed
// exact inline-provider model + native RGB24 return/call/row validation.
// There is no public caller-boolean receipt or public token constructor.
class ProvenProviderAdapter;
class PaintToken {
public:
 const WriteFacts&facts()const noexcept{return facts_;}
 PaintToken(const PaintToken&)=delete;
 PaintToken&operator=(const PaintToken&)=delete;
private:
 explicit PaintToken(const WriteFacts&f)noexcept:facts_(f){}
 WriteFacts facts_{};
 friend class ProvenProviderAdapter;
#ifdef IQ4_F1_NORMAL10_OWNED_HOST_FIXTURE
 friend struct OwnedFixture;
#endif
};
enum class Phase:std::uint32_t {Unbound,OffClean,Waiting,Shown,Hidden,Hold,Detached};
struct Status {
 std::uint32_t schema{10},bytes{sizeof(Status)};
 Phase phase{Phase::Unbound};MaskMode requested{MaskMode::Off};
 std::uint64_t generation{},last_paint{},fills{},rejected{},geometry_epoch{};
 std::uint32_t actual_geometry_known{},factory_restored{1},module_retained{1},selection_installed{};
};
// Concrete UI07 port + drawing body. Production starts Off, rejects active
// modes until a sealed actual write/lifetime token exists, and never generates
// one from an LV paint return. One token is callback-local and cannot escape.
class Renderer {
public:
 bool bind_once_on_ui(native_ui02::Memory,native_ui02::Native,native_overlay::FillWrapper,const native_ui02::Owner&,entry10::Binding*)noexcept;
 entry10::Selection selection_port()noexcept{return {this,apply};}
 bool install_selection_once_on_ui(entry10::Binding&)noexcept;
 bool after_native_write_on_ui(const PaintToken&)noexcept;
 bool off_and_detach_on_ui(std::uint64_t dispatch_epoch)noexcept;
 Status status_on_ui()const noexcept{return status_;}
 const Status* status_address_on_actual_ui()const noexcept{return on_ui()?&status_:nullptr;}
 const native_overlay::FixedPlan&plan_on_ui()const noexcept{return plan_;}
private:
 static entry10::SelectResult apply(void*,MaskMode,std::uint64_t)noexcept;
 entry10::SelectResult select(MaskMode,std::uint64_t)noexcept;
 bool on_ui()const noexcept;
 bool current()const noexcept;
 bool surface(const WriteFacts&)const noexcept;
 void hold()noexcept{status_.phase=Phase::Hold;}
 native_ui02::Memory memory_{};native_ui02::Native native_{};
 native_overlay::FillWrapper fill_{};native_ui02::Owner owner_{};entry10::Binding*entry_{};
 Status status_{};native_overlay::FixedPlan plan_{};
 Rect required_clean_{};bool busy_{};
#ifdef IQ4_F1_NORMAL10_OWNED_HOST_FIXTURE
 friend struct OwnedFixture;
#endif
};
// Called at the existing original-unlock UI boundary, after UI07 is Ready.
// No target constructor/getter/vtable/text patch is introduced by this bridge.
bool install_after_original_boundary(Renderer&,entry10::BoundaryInput const&,
 entry01::Module&,entry10::Binding&,native_ui02::Memory)noexcept;
}
