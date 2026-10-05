#pragma once
#include "integration.hpp"
namespace iq4::f1::hook10 {
// Written by the sole Root controller only after actual owner/provider,
// recovery and default-OFF review. This package emits no populated input.
struct PreparationInput {
 std::uint32_t schema{10},bytes{sizeof(PreparationInput)};
 std::uint64_t near_hint{},generation{};
 char root_admission_sha[65]{},unwind_review_sha[65]{};
 normal10::ActualProviderContract provider{};
};
enum class PreparationResult:std::uint32_t {Disabled,InvalidInput,WrongOwner,OriginalChanged,AllocationFailed,NearOutOfRange,SealFailed,ProviderRejected,Prepared};
struct PreparationMetadata {
 std::uint32_t schema{10},bytes{sizeof(PreparationMetadata)};PreparationResult result{};std::uint32_t attempts{},pid{},ui_tid{},requested{},renderer_phase{};
 std::uint64_t pid_ticks{},near_page{},near_bytes{},bridge{},trampoline_slot{},trampoline_value{},original_pair{},owner_queue{},generation{},renderer_status{};
 char input_sha[65]{};
};
struct PublishedPreparation {std::atomic<unsigned>sequence{0};unsigned bytes{sizeof(PublishedPreparation)};PreparationMetadata metadata{};};
static_assert(sizeof(PreparationMetadata)==184&&sizeof(PublishedPreparation)==192);
static_assert(offsetof(PublishedPreparation,metadata)==8&&offsetof(PreparationMetadata,input_sha)==112);
// Called by runtime_prepare_10.cpp at the real admitted UI boundary. Allocation,
// clear-cache, RX sealing and own configuration finish BEFORE external stop.
void prepare_once_at_live_ui(normal10::UI10Bridge&,entry01::Module&,native_ui02::Memory)noexcept;
}
extern "C" iq4::f1::hook10::PublishedPreparation iq4_f1_hook_preparation_observed_10;
