#pragma once
#include "binding.hpp"
namespace iq4::f1::entry07 {
// Own-runtime integration: call after the exact original unlock has returned
// and Module::after_unlock has published the actual owner. This is never called
// from a host setter, timer, constructor UI thread guess or borrowed input.
class BoundaryBridge {
public:
 bool admit_once(Admission admission,Placement placement,Selection selection={})noexcept{
  if(admitted_||!admission.native_object_construction_reviewed||!admission.registry_quiescence_held||!admission.retain_until_User_exit||!admission.RAM_restore_route_held)return false;
  admission_=admission;placement_=placement;selection_=selection;admitted_=true;return true;
 }
 void after_original_unlock_on_ui(Memory memory,entry01::Module&module,display06::Collector&display,const BoundaryInput&input,Synchronization sync)noexcept{
  if(!admitted_||input.original_result||input.caller_pc!=0x6be8ac)return;
  entry01::Observation observation{};if(!module.snapshot(observation)||!observation.dispatch_epoch)return;
  if(!bound_){if(!binding_.bind_on_actual_boundary(memory,module,input,admission_,placement_,selection_,&display,sync))return;bound_=true;}
  if(boundary_attempts_==UINT64_MAX)return;++boundary_attempts_;
  (void)binding_.after_actual_boundary(input,boundary_attempts_);
 }
 Binding&binding()noexcept{return binding_;}
 bool admitted()const noexcept{return admitted_;}
private:
 Binding binding_{};Admission admission_{};Placement placement_{};Selection selection_{};std::uint64_t boundary_attempts_{};bool admitted_{},bound_{};
};
}
