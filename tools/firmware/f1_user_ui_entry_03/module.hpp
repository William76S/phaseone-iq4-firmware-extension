#pragma once
#include "../f1_native_ui_02/ui.hpp"
#include "../f4_ui_bootstrap_02/bootstrap.hpp"
#include "../f1_entry_button_ports_01/contracts.hpp"
#include <atomic>
namespace iq4::f1::entry01 {
using namespace native_ui02;
inline constexpr char TemporaryOpenEvent[]="IQ4_F1_OPEN_MASK_01";
// Firmware derivation: this Module keeps the bounded metadata cap and real
// native ports. New runtime separately calls the persistent production
// Binding; this Module itself never subscribes, writes vptrs or fills pixels.
struct ImageGate {bool enabled{},immutable_stock_code_windows{},mapped_ro{},original_pthread{};Address bias{};};
enum class Phase:std::uint32_t {Disabled,Waiting,OwnerObserved,LVNotCurrent,Stopped,Hold};
struct StackFacts {
    Address priority_first{},priority_last{},normal_first{},normal_last{};
    std::uint32_t normal_count{},bounded_complete{},lv_at_tail{},priority_empty{};
    Address nodes[8]{},dialogs[8]{},node_vtables[8]{};
};
// A read-only observation of the original list graph. Unknown dialogs below
// LV remain explicit metadata; this never extends frozen UI02's enable gate.
bool observe_stack(Memory,Address bias,const Owner&,StackFacts&)noexcept;
struct Observation {
    std::uint32_t schema{1},bytes{sizeof(Observation)},sequence{},phase{};
    std::uint64_t dispatch_epoch{},qualified_boundaries{},rejected_boundaries{};
    Address queue{},manager{},data{},lv{},popup{},popped_observer{};
    Address caller_pc{},frame_pointer{},thread_pointer{},mutex{};
    Rectangle24 local_bounds{};
    std::int32_t pan_x{},pan_y{},quarterturn{};float scale{};
    std::uint32_t countdown{},visible{},running{},native_original_calls{},native_mutating_calls{},mask_enabled{};
    StackFacts original_stack{};
    // These fields are observations/candidates, never full-source, viewport,
    // pixels, lease/fresh-blit, callback-lifetime or menu-restore attestations.
};
// Data-only self-observation ABI. A process-memory collector reads the sequence
// before/after a bounded copy. It must derive this symbol from the exact loaded
// module ELF/inode, never guess addresses or invoke the C integration exports.
struct PublishedObservation {
    std::atomic<unsigned> sequence{0};unsigned bytes{sizeof(PublishedObservation)};
    std::atomic<unsigned> startup{0};unsigned reserved{};Observation metadata{};
};
static_assert(sizeof(Observation)==424 && sizeof(PublishedObservation)==440);
static_assert(offsetof(PublishedObservation,metadata)==16);
class Module {
public:
    bool configure(Memory,ImageGate,int(*trylock)(void*),int(*unlock)(void*))noexcept;
    void after_unlock(const BoundaryInput&)noexcept;
    bool snapshot(Observation&)const noexcept;
    void stop_observing()noexcept;
    Native selector_ports()noexcept;
    entry_ports01::Candidates button_ports()const noexcept{return button_candidates_;}
    native_overlay::Native overlay_ports()noexcept;
    const Owner& observed_owner()const noexcept{return owner_;}
private:
    static Address current(void*)noexcept;
    static Triple triple(void*,Address,Address,const Observer*)noexcept;
    static bool repaint(void*,Address)noexcept;
    Memory memory_{};ImageGate image_{};Candidates candidates_{};Owner owner_{};
    entry_ports01::Candidates button_candidates_{};
    iq4::f4::bootstrap::Bootstrap triple_inspector_{};
    std::atomic_flag inside_=ATOMIC_FLAG_INIT;bool configured_{};
    Observation observation_{};
};
}
