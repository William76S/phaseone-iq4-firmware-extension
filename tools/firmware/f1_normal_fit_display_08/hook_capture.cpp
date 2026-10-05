#include "hook_capture.hpp"
#include "provider.hpp"
#include <atomic>
#include <cerrno>
#include <cstring>
// Not an installer/export, not a provider getter, and not a token issuer.
// Retained OWN storage only. Actual hook dispatch is not enabled or loaded.
extern "C" {__attribute__((visibility("default"))) iq4::f1::normal08::PublishedIngress iq4_f1_normal_fit_ingress_observed_08;}
namespace {
 std::atomic_flag busy=ATOMIC_FLAG_INIT;std::atomic<unsigned>sequence{0};iq4::f1::normal08::RawWriteObservation observed{};
 struct Consumer {iq4::f1::normal08::ProvenProviderAdapter*provider{};iq4::f1::normal08::Renderer*renderer{};};
 Consumer retained{};std::atomic<Consumer*>consumer{nullptr};
}
namespace iq4::f1::normal08 {
void publish_ingress_on_ui(const IngressStatus&s)noexcept{
 iq4_f1_normal_fit_ingress_observed_08.sequence.fetch_add(1,std::memory_order_acq_rel);
 iq4_f1_normal_fit_ingress_observed_08.metadata=s;
 iq4_f1_normal_fit_ingress_observed_08.raw={};
 iq4_f1_normal_fit_ingress_observed_08.sequence.fetch_add(1,std::memory_order_release);
}
bool install_capture_consumer_once_on_ui(ProvenProviderAdapter&p,Renderer&r)noexcept{
 // Root must already hold its quiescence receipt. The renderer itself checks
 // the current native owner when a token is emitted; no false capture flag.
 if(consumer.load(std::memory_order_acquire)||!p.ready_on_current_ui()||r.status_on_ui().phase!=Phase::OffClean||!r.status_on_ui().selection_installed)return false;
 retained={&p,&r};Consumer*empty=nullptr;return consumer.compare_exchange_strong(empty,&retained,std::memory_order_release,std::memory_order_acquire);
}
}
extern "C" __attribute__((visibility("hidden"))) void iq4_f1_scaler_after_08(const iq4::f1::normal08::ScalerCapture*c)noexcept{
 const int saved=errno;
 if(c&&!busy.test_and_set(std::memory_order_acquire)){
  sequence.fetch_add(1,std::memory_order_acq_rel);
  if(observed.serial!=UINT64_MAX)++observed.serial;
  observed.thread_pointer=c->thread_pointer;observed.original_fp=c->original_fp;observed.original_lr=c->original_lr;
  std::memcpy(observed.args,c->arguments,sizeof observed.args);std::memcpy(observed.stack,c->stack_arguments,sizeof observed.stack);
  // ABI preservation keeps these inputs privately in the own stack, but the
  // public diagnostics do not expose source/destination pixel or x8 pointers.
  observed.args[2]=observed.args[4]=observed.args[8]=0;
  observed.normal_original_return=1;
  // These zero fields are deliberate. A function return is not a full-image
  // pixel/lease receipt, including when widths/heights happen to be positive.
  sequence.fetch_add(1,std::memory_order_release);
  if(auto*p=consumer.load(std::memory_order_acquire)){
   if(p->provider->rendering_contract_bound())(void)p->provider->dispatch_scaler_return_on_ui(*c,*p->renderer);
   else (void)p->provider->observe_scaler_return_on_ui(*c);
   iq4_f1_normal_fit_ingress_observed_08.sequence.fetch_add(1,std::memory_order_acq_rel);
   iq4_f1_normal_fit_ingress_observed_08.metadata=p->provider->status_on_ui();
   iq4_f1_normal_fit_ingress_observed_08.raw=observed;
   iq4_f1_normal_fit_ingress_observed_08.sequence.fetch_add(1,std::memory_order_release);
  }
  busy.clear(std::memory_order_release);
 }
 errno=saved;
}
