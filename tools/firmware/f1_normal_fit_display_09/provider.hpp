#pragma once
#include "normal_fit.hpp"
#include "hook_capture.hpp"
namespace iq4::f1::normal09 {
enum class ProviderProfile:std::uint32_t {Unknown,RootReviewedInlineUIRetainedUntilPresent};
enum class InlineGetterShape:std::uint32_t {Unknown,LeafAddRet8,OriginalO0StackAddRet24};
// Only Root's protected actual admission may supply this contract. Hash syntax
// is checked here; the caller must have reviewed the referenced actual receipt.
// Off observations cannot fill profile/owner_review_sha256 by themselves.
struct ActualProviderContract {
 std::uint32_t schema{9};ProviderProfile profile{ProviderProfile::Unknown};
 char actual_UserSHA[65]{};char owner_review_sha256[65]{},hook_quiescence_receipt_sha256[65]{};
 native_ui02::Owner owner{};
 Address provider{},provider_vtable{},getter{},present{},near_entry{},near_trampoline{},own_bridge{};
 std::uint32_t inline_surface_offset{};
 InlineGetterShape getter_shape{InlineGetterShape::Unknown};
};
enum class IngressResult:std::uint32_t {Disabled,WrongOwner,PatchMismatch,UnsupportedCall,NoWrite,ReadFailed,ScopeMismatch,UnknownLease,PartialSource,UnsupportedFormat,InvalidGeometry,RendererRejected,Emitted,Observed,BoundaryObserved};
struct IngressStatus {std::uint32_t schema{9},bytes{sizeof(IngressStatus)};IngressResult result{};std::uint32_t emitted{},normal_returns{},reserved{};std::uint64_t serial{};WriteFacts last{};};
class ProvenProviderAdapter {
public:
 bool bind_observation_on_actual_ui(native_ui02::Memory,native_ui02::Native,const native_ui02::Owner&)noexcept;
 IngressResult observe_scaler_return_on_ui(const ScalerCapture&)noexcept;
 IngressResult sample_boundary_scalars_on_actual_ui()noexcept;
 // Own-code configuration, on the existing known UI boundary. No unknown
 // getter invocation, source acquire/release, target text/mprotect/mmap write.
 bool configure_on_actual_ui(native_ui02::Memory,native_ui02::Native,const ActualProviderContract&)noexcept;
 IngressResult dispatch_scaler_return_on_ui(const ScalerCapture&,Renderer&)noexcept;
 IngressStatus status_on_ui()const noexcept{return status_;}
 bool ready_on_current_ui()const noexcept{return (observing_||configured_)&&native_.current_thread&&native_.current_thread(native_.context)==contract_.owner.queue;}
 bool rendering_contract_bound()const noexcept{return configured_;}
private:
 bool read(Address,void*,std::size_t)const noexcept;
 template<class T>bool field(Address a,T&v)const noexcept{return read(a,&v,sizeof v);}
 bool provider_lease(Address surface)const noexcept;
 bool exact_inline_getter()const noexcept;
 bool exact_patch_route()const noexcept;
 IngressResult gather(const ScalerCapture&,WriteFacts&,bool require_lease)const noexcept;
 native_ui02::Memory memory_{};native_ui02::Native native_{};ActualProviderContract contract_{};IngressStatus status_{};bool configured_{},observing_{};
};
struct PublishedIngress {std::atomic<unsigned>sequence{0};unsigned bytes{sizeof(PublishedIngress)};IngressStatus metadata{};RawWriteObservation raw{};};
// Register once before any text patch, at Root's quiescent owner boundary. The
// immutable pair and module/objects must remain alive until original User exit.
// This is a concrete source port; no registration occurs in a constructor.
bool install_capture_consumer_once_on_ui(ProvenProviderAdapter&,Renderer&)noexcept;
void publish_ingress_on_ui(const IngressStatus&)noexcept;
}
extern "C" iq4::f1::normal09::PublishedIngress iq4_f1_normal_fit_ingress_observed_09;
