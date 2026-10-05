#pragma once
#include "provider.hpp"
namespace iq4::f1::normal10 {
// Concrete finite integration for a new derivative runtime, independent of
// frozen UI07/Loader07. No global ctor/paint installer is introduced.
class UI10Bridge {
public:
 bool after_original_boundary_on_ui(native_ui02::Memory memory,entry01::Module&module,entry10::Binding&entry,const native_ui02::BoundaryInput&input)noexcept{
  if(!install_after_original_boundary(renderer_,input,module,entry,memory))return false;
  if(!observing_){persistent_=entry.persistent_ports_on_ui();if(!persistent_.current_thread||!provider_.bind_observation_on_actual_ui(memory,persistent_,module.observed_owner()))return false;observing_=true;}
  if(!registered_){if(!install_capture_consumer_once_on_ui(provider_,renderer_))return false;registered_=true;}
  (void)provider_.sample_boundary_scalars_on_actual_ui();publish_ingress_on_ui(provider_.status_on_ui());
  return true;
 }
 // Root supplies actual protected receipts while all callbacks are quiescent,
 // before patching native text. Absence/profileUnknown keeps observer-only.
 bool bind_actual_provider_before_patch_on_ui(native_ui02::Memory memory,entry01::Module&module,const ActualProviderContract&contract)noexcept{
  if(!observing_||!registered_||renderer_.status_on_ui().phase!=Phase::OffClean)return false;
  const auto&o=module.observed_owner();if(contract.owner.queue!=o.queue||contract.owner.manager!=o.manager||contract.owner.data!=o.data||contract.owner.lv!=o.lv||contract.owner.popup!=o.popup)return false;
  return provider_.configure_on_actual_ui(memory,persistent_,contract);
 }
 Renderer&renderer()noexcept{return renderer_;}
 ProvenProviderAdapter&provider()noexcept{return provider_;}
private:
 native_ui02::Native persistent_{};Renderer renderer_{};ProvenProviderAdapter provider_{};bool observing_{},registered_{};
};
}
