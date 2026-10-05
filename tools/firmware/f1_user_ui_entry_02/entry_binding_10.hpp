#pragma once
#include "module.hpp"
#include <array>
namespace iq4::f1::entry10 {
using namespace native_ui02;
// Computed firmware admission: exact stock windows, actual UI boundary and
// held original recursive registry mutex. No Root-supplied runtime flags.
struct Admission {bool immutable_UI_ABI_verified{},actual_registry_mutex_held{},retain_until_User_exit{},stock_fallback_retained{};};
struct Placement {std::int32_t x{},y{};};
struct Synchronization {int(*try_lock)(void*){};int(*original_unlock)(void*){};};
enum class Phase:std::uint32_t {Disabled,Bound,Building,Ready,Open,AwaitingStockPaint,Detaching,DetachedRetained,Hold};
enum class SelectResult:std::uint32_t {Rejected,AlreadyOff,AwaitingStockPaint};
struct Selection {
 void*context{};
 // Concrete future normal-fit display adapter; no full/fresh/lease boolean is
 // taken here. Must hide on native zoom/pan and retain original paint once.
 bool(*apply_on_ui)(void*,MaskMode,std::uint64_t request_generation)noexcept{};
};
struct Status {std::uint32_t schema{10},bytes{sizeof(Status)},phase{},mask_state_known{},mask_enabled{},reserved{};std::uint64_t callbacks{},open_requests{},selections{},rejected{},generation{},detach_epoch{};MaskMode selected{MaskMode::Off};std::uint32_t retained_until_User_exit{1},stock_toolbar_1_8_preserved{1},embedded_popup_preserved{1},stock_paint_restored{1},ui_mutation_attempted{};};
struct Published {std::atomic<unsigned>sequence{0};unsigned bytes{sizeof(Published)};Status metadata{};};
static_assert(sizeof(Status)==96&&sizeof(Published)==104&&offsetof(Published,metadata)==8);
struct ControlObserver {entry_ports01::ControlObserverNative native{};void*extension{};};
struct ControlTable {std::intptr_t offset{};const void*rtti{};void(*destroy)(ControlObserver*)noexcept{};void(*deleting)(ControlObserver*)noexcept{};void(*notify)(ControlObserver*,void*,const void*,std::uint32_t)noexcept{};};
static_assert(offsetof(ControlTable,notify)==32&&sizeof(ControlObserver)==16);
class Binding {
public:
 Binding()noexcept;
 bool bind_on_actual_boundary(Memory,entry01::Module&,const BoundaryInput&,Admission,Placement,Selection={},Synchronization={})noexcept;
 bool build_on_ui()noexcept;
 bool install_selection_once_on_ui(Selection selection)noexcept;
 bool after_actual_boundary(const BoundaryInput&,std::uint64_t dispatch_epoch)noexcept;
 bool cancel_on_ui()noexcept;
 bool observe_stock_paint_on_ui(const PaintReceipt&)noexcept;
 bool detach_on_ui(std::uint64_t dispatch_epoch)noexcept;
 Status status_on_ui()const noexcept{return status_;}
 // Existing validated Binding TLS/listener port; independent of Module cap.
 Native persistent_ports_on_ui()noexcept{return configured_&&status_.phase!=static_cast<unsigned>(Phase::Hold)&&status_.phase!=static_cast<unsigned>(Phase::DetachedRetained)&&on_ui()&&actual_owner()?native_:Native{};}
 Address own_button()const noexcept{return reinterpret_cast<Address>(button_.data());}
 Address own_popup()const noexcept{return reinterpret_cast<Address>(popup_.data());}
 Address own_root()const noexcept{return reinterpret_cast<Address>(root_.data());}
 Address own_event(unsigned i)const noexcept{return i<6?reinterpret_cast<Address>(events_[i].data()):0;}
 ControlObserver*control_observer()noexcept{return &control_;}
 Observer*queue_observer()noexcept{return &queue_;}
private:
 bool on_ui()const noexcept;
 bool current(bool own_popup_open)const noexcept;
 bool actual_owner()const noexcept;
 bool boundary_matches(const BoundaryInput&,Address&popped)const noexcept;
 bool resource()const noexcept;
 bool free_placement()const noexcept;
 bool own_menu(Address root)const noexcept;
 bool check_items()const noexcept;
 bool triples(Triple)const noexcept;
 bool button_bound(bool bound)const noexcept;
 bool stock_popup_unchanged()const noexcept;
 bool close_private()noexcept;
 void control_notification(void*,const void*,std::uint32_t)noexcept;
 void queue_notification(void*)noexcept;
 void hold()noexcept{status_.phase=static_cast<unsigned>(Phase::Hold);}
 static void control_notify(ControlObserver*,void*,const void*,std::uint32_t)noexcept;
 static void control_destroy(ControlObserver*)noexcept;
 static void queue_notify(Observer*,void*)noexcept;
 static void queue_destroy(Observer*)noexcept;
 static Address native_current(void*)noexcept;
 static Triple native_triple(void*,Address,Address,const Observer*)noexcept;
 Memory memory_{};entry01::Module*module_{};Native native_{};entry_ports01::Candidates ports_{};Owner owner_{};Selection selection_{};Placement placement_{};Status status_{};
 Address resource_{},home_{};std::uint32_t title_{};unsigned registered_{},callback_depth_{};bool open_pending_{},configured_{};std::uint64_t last_paint_{};
 iq4::f4::bootstrap::Bootstrap listener_inspector_{};
 ControlTable control_table_{};ControlObserver control_{};ObserverTable queue_table_{};Observer queue_{};
 alignas(16)std::array<unsigned char,entry_ports01::TextButtonBytes>button_{};
 alignas(16)std::array<unsigned char,entry_ports01::PopupBytes>popup_{};
 alignas(16)std::array<unsigned char,0x118>root_{};
 alignas(16)std::array<std::array<unsigned char,0x38>,5>items_{};
 alignas(16)std::array<std::array<unsigned char,0xb8>,6>events_{};
 std::array<std::array<char,33>,5>labels_{};
 // Saved fields of original embedded Navigator; never written by this binder.
 std::array<unsigned char,0x18>stock_menu_head_{};std::array<unsigned char,0x58>stock_menu_stack_{};
#ifdef IQ4_F1_ENTRY10_OWNED_HOST_FIXTURE
 friend struct OwnedFixture;
#endif
};
}
