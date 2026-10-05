#pragma once
#include "../f1_module_entry_01/module.hpp"
#include <atomic>
#include <cstddef>

namespace iq4::f1::stack05 {
using namespace native_ui02;
enum class Result:std::uint32_t {NotAttempted,Collected,Unsupported,OwnerRejected,ReadFailed,Changing,Invalid};
enum class Relation:std::uint32_t {None,FreshEntry,PriorEntryAnchor};
enum class Shape:std::uint32_t {Unsupported,SoleLV,HomeCandidateLV,LVPopup,HomeCandidateLVPopup};
enum class Kind:std::uint32_t {Unknown,LV,HomeCandidate,Popup};
struct Node {
    Address node{},dialog{},node_vtable{},primary_vtable{},next{},previous{},manager{};
    std::uint32_t request_pending{},kind{};
};
struct Facts {
    Address priority_first{},priority_last{},normal_first{},normal_last{},override_dialog{},aux_dialog{};
    std::uint32_t aux_active{},count{},complete{},priority_empty{};
    Node nodes[8]{};
};
struct Metadata {
    std::uint32_t schema{5},bytes{sizeof(Metadata)},result{},graph_present{};
    std::uint64_t attempts{},snapshot_epoch{},source_dispatch_epoch{},prior_source_dispatch_epoch{},accepted{},rejected{};
    unsigned char exact_user_sha256[32]{
      0x9b,0x61,0x1e,0xfe,0x64,0x06,0x76,0x85,0xb7,0x70,0xba,0x39,0x84,0xae,0x95,0x16,
      0x84,0xc5,0xa4,0x01,0xf7,0x3f,0x77,0xa0,0x3b,0x31,0x6b,0xe3,0x74,0x03,0x2c,0xdb};
    std::uint64_t exact_user_bytes{11874544};
    std::uint32_t source_startup{},source_relation{},shape{},normal_tail_projection{},prior_source_sequence{},
      native_current_called{},paint_called{},full_source_mapping_verified{},fresh_blit_verified{},surface_lease_verified{},actual_scene_verified{},reserved{};
    Address actual_popped_observer{},normal_tail_dialog{},selected_dialog_projection{};
    // Verbatim actual Entry snapshot. Prior anchors are never relabelled as a
    // fresh Entry dispatch; selected_dialog_projection is not a native call.
    entry01::Observation source{};
    Facts facts{};
};
struct Published {
    std::atomic<unsigned> sequence{0};unsigned bytes{sizeof(Published)},schema{5},reserved{};
    Metadata metadata{};
};
static_assert(sizeof(Node)==64 && sizeof(Facts)==576);
static_assert(sizeof(Metadata)==1176 && offsetof(Metadata,source)==176 && offsetof(Metadata,facts)==600);
static_assert(sizeof(Published)==1192 && offsetof(Published,metadata)==16);
// Actual runtime calls this once after original unlock and Entry's snapshot.
// Only host-owned publications are written; Memory is an own-process RO port.
class Collector {
public:
    Collector(Memory memory,Address bias)noexcept:memory_(memory),bias_(bias){}
    bool capture(const BoundaryInput&,const entry01::Observation&before,const entry01::Observation&after,
                 unsigned actual_entry_startup,Metadata&)noexcept;
private:
    Result once(const Owner&,Facts&)const noexcept;
    Memory memory_{};Address bias_{};Metadata state_{};
};
}
