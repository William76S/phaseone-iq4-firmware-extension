#pragma once
#include "../f4_ui_bootstrap_02/bootstrap.hpp"
#include "../f4_owned_copy_pool_01/owned_copy_pool.hpp"
#include <atomic>
#include <cstdint>
namespace iq4::f4::native_metadata {
using Address=std::uintptr_t;
using Owner=bootstrap::Owner;
enum class Result : std::uint8_t { Disabled, WrongThread, Reentrant, InvalidOwner, UiRetained,
    AlreadyLocked, NoCompletedSlot, NativeException, BadMetadata, Duplicate, StaleId,
    ClockUnavailable, MetadataReleased, UnlockUnknown, Hold, NeedsHardwareReceipts, PoolResult };
enum class ModeBinding : std::uint8_t { Unbound }; // no guessed sensor/pipeline-mode field
struct RawBufferConfiguration {
    std::uint32_t component_map[4]{},configured_width{},configured_height{},calculated_bytes{},channels{};
}; // observed original fields, not layout/color/allocation/mapping receipts
struct Metadata {
    std::uint32_t width{},height{},slot{},software_completion_id{};
    std::uint64_t observed_completion_ns{};
    ModeBinding mode{ModeBinding::Unbound};
    bool pixels_copied{}, sensor_counter{}, hardware_timestamp{}, real_60fps_proven{};
    RawBufferConfiguration raw_buffer{};
};
struct Operations {
    void* context{};
    bool (*read)(void*,Address,void*,std::size_t) noexcept{};
    void* (*current)(){};
    const std::uint8_t* (*lock)(void*,std::int32_t){};
    bool (*unlock)(void*,std::int32_t){};
    std::uint64_t (*size)(void*){}; // proven packed two-u32 x0, not hidden-x8 Rectangle
    std::uint32_t (*id)(void*){};
    std::uint64_t (*clock)(void*) noexcept{};
};
class Adapter;
bool prepare_native(Adapter&) noexcept; // target-only self-image verifier; no constructor/automatic arm
class Adapter {
public:
    Adapter() noexcept=default;
    Result sample_metadata(Metadata&) noexcept;
    // Production has no receipt issuer yet. Cannot turn copying on with booleans.
    Result request_pixel_copy() const noexcept { return Result::NeedsHardwareReceipts; }
    bool held_uncertain() const noexcept { return hold_; }
    std::uint64_t unlock_attempts() const noexcept { return unlock_attempts_; }
#ifdef IQ4_F4_ADAPTER_SYNTHETIC_HOST
    void configure_synthetic(Operations n) noexcept { operations_=n;ready_=true; }
    CaptureResult copy_synthetic(CopyPool&,SourceView) noexcept;
#endif
private:
    friend bool prepare_native(Adapter&) noexcept;
    bool read(Address,void*,std::size_t) const noexcept;
    bool word(Address,Address&) const noexcept;
    bool owner_chain(Address,Owner&) const noexcept;
    bool live_owner(Owner&,std::int32_t&,Address&) noexcept;
    bool same_owner(const Owner&,std::int32_t) noexcept;
    ReleaseResult release() noexcept;
    static ReleaseResult release_bridge(void*,const SourceView&) noexcept;
    Result finish(Result) noexcept;
    Operations operations_{}; bool ready_{},hold_{},own_lock_{},attempted_unlock_{};
    Owner locked_owner_{}; Address queue_{},locked_pixels_{}; std::int32_t client_{};
    std::uint32_t slot_{},id_{}; std::uint64_t unlock_attempts_{},last_ns_{};
    std::uint32_t last_id_{}; bool seen_{};
    std::atomic_flag sampling_=ATOMIC_FLAG_INIT;
};
}
