#pragma once
#include "../f1_native_overlay_01/overlay.hpp"
#include <array>
#include <cstddef>
#include <cstdint>

namespace iq4::f1::native_ui02 {
using Address=std::uintptr_t;
using Memory=native_overlay::Memory;
using Rectangle24=native_overlay::Rectangle24;
inline constexpr const char* UserSHA=native_overlay::UserSHA;
struct Owner {Address queue{},manager{},data{},lv{},popup{};};
struct Boundary {Owner owner{};Address popped_observer{},pop_frame{},dispatch_frame{};};
// Captured architectural state AFTER original pthread unlock; no supplied owner.
struct BoundaryInput {Address caller_pc{},frame_pointer{},thread_pointer{},mutex{};int original_result{};};
struct LayoutSnapshot {
    Rectangle24 local_control_bounds{}; // +28, NOT the full-image display viewport.
    std::array<std::int32_t,2> pan{};float scale{};std::int32_t quarterturn{};
    std::uint32_t countdown{};bool visible{},live_view_running{};
};
class Inspector {
public:
    Inspector(Memory memory,Address load_bias) noexcept:memory_(memory),bias_(load_bias){}
    bool owner_chain(Address,Owner&) const noexcept;
    bool boundary(const BoundaryInput&,Boundary&) const noexcept;
    // Restricted ordinary stack: LV top, or this LV's own popup above LV.
    // Reject override/aux/priority branches; never calls mutating Current().
    bool current(const Owner&,bool popup_open) const noexcept;
    bool idle_popup(const Owner&) const noexcept;
    bool popup_menu(const Owner&,Address root) const noexcept;
    bool popup_title(const Owner&,std::uint32_t&) const noexcept;
    bool layout_candidates(const Owner&,LayoutSnapshot&) const noexcept;
    bool word(Address,Address&) const noexcept;
    bool read(Address,void*,std::size_t) const noexcept;
private: Memory memory_;Address bias_{};
};
struct Observer;
struct ObserverTable {std::intptr_t offset_to_top{};const void* rtti{};void(*destroy)(Observer*)noexcept{};void(*deleting_destroy)(Observer*)noexcept{};void(*notify)(Observer*,void*)noexcept{};};
struct Observer {const void* address_point{};void* queue{};const char* name{};void* extension{};};
static_assert(sizeof(Observer)==0x20&&offsetof(ObserverTable,notify)==0x20);
enum class Triple:std::uint8_t {Present,Absent,Unknown};
using EventCtor=void(*)(void*,const char*);
using ObserverCtor=void(*)(Observer*,const char*,void*);
using Register=void(*)(Observer*,void*);
using SubMenuCtor=void(*)(void*,std::uint32_t,void*,void*);
using EventItemCtor=void(*)(void*,std::uint32_t,void*,void*);
using Append=void(*)(void*,void*);
using SetMenu=void(*)(void*,void*);
using Method=void(*)(void*);
using Invalidate=void(*)(void*,bool);
struct Native {
    EventCtor event_ctor{};ObserverCtor observer_ctor{};Register subscribe{},unsubscribe{};
    SubMenuCtor submenu_ctor{};EventItemCtor item_ctor{};Append append{};
    SetMenu set_menu{};Method show{},close{};Invalidate invalidate{};
    void* context{};Address(*current_thread)(void*)noexcept{};
    Triple(*inspect_triple)(void*,Address,Address,const Observer*)noexcept{};
};
struct SelectionPort {
    void* context{};
    // Own-code UI bridge: implements frozen overlay.select_on_ui with an ACTUAL
    // full-source mapping/epoch. No native crop/RAW/JPEG DTO setter is accepted.
    bool(*select)(void*,MaskMode)noexcept{};
};
struct GeometryPort {void*context{};bool(*actual_snapshot)(void*,Address lv,display::ViewMapping&,std::uint64_t&geometry_epoch)noexcept{};};
// Concrete own-code bridge to frozen overlay01. It does not derive full-image
// geometry from the candidate LV fields, buffers, or a configured aspect ratio.
class OverlaySelectionBridge {
public:
    OverlaySelectionBridge(native_overlay::Adapter&overlay,Address lv,GeometryPort geometry)noexcept:overlay_(overlay),lv_(lv),geometry_(geometry){}
    SelectionPort port()noexcept{return {this,select};}
private:
    static bool select(void*,MaskMode)noexcept;
    native_overlay::Adapter&overlay_;Address lv_{};GeometryPort geometry_{};
};
// Finite static-address resolver with exact first-16-byte checks. No calls;
// proves neither whole mapped User nor runtime ABI/lifetime. It does not fill
// actual thread/triple/geometry ports and does not enable Selector production.
struct Candidates {EventCtor event_ctor{};ObserverCtor observer_ctor{};Register subscribe{},unsubscribe{};SubMenuCtor submenu_ctor{};EventItemCtor item_ctor{};Append append{};SetMenu set_menu{};Method show{},close{};Invalidate invalidate{};void*(*original_current)(){};};
bool resolve_static_candidates(Memory,Address load_bias,Candidates&)noexcept;
enum class Phase:std::uint8_t {Disabled,Bound,Building,Ready,Open,RestoringMenu,AwaitingPaint,Detaching,DetachedRetained,Hold};
enum class Result:std::uint8_t {Ok,Disabled,WrongThread,Rejected,Pending,Hold};
struct Status {Phase phase{};MaskMode selected{MaskMode::Off};std::uint64_t actions{},rejected{},repaint_requests{},fresh_receipts{};bool module_retained{true},native_events_retained{true},menu_restored{},factory_repaint_confirmed{};};
struct PaintReceipt {
    Address lv{},surface{};std::uint64_t request_generation{},ui_paint_serial{};
    native_overlay::PixelRect image_viewport{},actual_stock_coverage{};
    bool original_returned_normally{},native_image_blit_completed{},display_lease_live{};
};
// Native five-choice selector + owner binding + repaint tracking. Production
// configure is unconditionally disabled. No constructor, vptr writer, loader,
// capture/storage/security API, global-menu append, or target entry is supplied.
class Selector {
public:
    Selector() noexcept;
    bool configure(Memory,Native,SelectionPort,const char* actual_sha,Address load_bias,const BoundaryInput&)noexcept;
    Result build_on_ui()noexcept;
    Result open_on_ui()noexcept;
    Result cancel_on_ui()noexcept;
    // Must be called after the original UI callback and fresh stock image write;
    // requesting UiIQ4Redraw alone, draw return, or software ID is insufficient.
    Result observe_paint_on_ui(const PaintReceipt&)noexcept;
    Result detach_on_ui(std::uint64_t actual_dispatch_epoch)noexcept;
    Result confirm_later_boundary(const BoundaryInput&,std::uint64_t actual_dispatch_epoch)noexcept;
    Status status_on_ui()const noexcept{return status_;}
    std::uint64_t request_generation()const noexcept{return generation_;}
    Address menu_for_test()const noexcept{return reinterpret_cast<Address>(menu_.data());}
    Address event_for_test(std::size_t i)const noexcept{return i<5?reinterpret_cast<Address>(events_[i].data()):0;}
    const char* label_for_test(std::size_t i)const noexcept{return i<5?labels_[i].data():nullptr;}
    Observer* observer_for_test()noexcept{return &observer_;}
private:
    bool owner(bool popup_open)const noexcept;
    bool on_ui()const noexcept;
    bool triples(Triple)const noexcept;
    bool check_items()const noexcept;
    Result restore_popup_on_ui()noexcept;
    Result request_repaint_on_ui()noexcept;
    void notification(void*)noexcept;
    void hold()noexcept{status_.phase=Phase::Hold;}
    static void notify(Observer*,void*)noexcept;
    static void destroy(Observer*)noexcept;
    Memory memory_{};Native native_{};SelectionPort selection_{};Address bias_{};Owner owner_{};
    Status status_{};ObserverTable table_{};Observer observer_{};
    alignas(16)std::array<unsigned char,0x118>menu_{};
    alignas(16)std::array<std::array<unsigned char,0x38>,5>items_{};
    alignas(16)std::array<std::array<unsigned char,0xb8>,5>events_{};
    std::array<std::array<char,33>,5>labels_{};
    std::uint64_t generation_{},last_paint_{},detach_epoch_{};
    std::uint32_t original_popup_title_{};
    unsigned callback_depth_{},registered_{};bool configured_{},painting_complete_{},cancelled_{};
};
}
