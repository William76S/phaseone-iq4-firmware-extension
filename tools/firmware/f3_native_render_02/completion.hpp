#pragma once
#include "adapter.hpp"
#include "decode_receipt.h"
#include "../f3_core_native_receipt_01/receipt.h"
namespace iq4::native_render_02 {
// The actual source holder supplies a real exclusive padded payload capacity
// and per-row receipt reservation. No allocation, fd release or device access.
struct CombinedCompletion {
    Iq4DecodeRead02 read = nullptr; void* read_context = nullptr;
    std::uint64_t payload_allocation_bytes = 0;
    std::uint8_t* row_states = nullptr; std::size_t row_states_bytes = 0;
    std::uint64_t decode_generation = 0, core_generation = 0;
    Owner bound_owner{};
    bool active = false, decode_retired = false, core_retired = false;
    Iq4DecodeView02 decode{}; Iq4CoreView01 core{};
    Completion callbacks() noexcept;
};
} // namespace iq4::native_render_02
