#pragma once
#include <cstddef>
#include <cstdint>
namespace iq4::f1::normal08 {
// Assembly frame is 1024B. These offsets are independently checked against
// actual AArch64 object bytes/disassembly; the trailing 144B is not published.
struct alignas(16) ScalerCapture {
 std::uint64_t stack_arguments[5],padding[3],arguments[9];
 std::uint64_t original_fp,original_lr,original_sp,thread_pointer,pad;
 std::uint64_t result_gpr[19],pad2;
 unsigned char result_q[32][16];
 std::uint64_t nzcv,fpcr,fpsr,pad3;
};
static_assert(sizeof(ScalerCapture)==880);
static_assert(offsetof(ScalerCapture,arguments)==64&&offsetof(ScalerCapture,original_fp)==136);
static_assert(offsetof(ScalerCapture,result_gpr)==176&&offsetof(ScalerCapture,result_q)==336);
static_assert(offsetof(ScalerCapture,nzcv)==848&&offsetof(ScalerCapture,fpcr)==856&&offsetof(ScalerCapture,fpsr)==864);
struct RawWriteObservation {
 std::uint64_t serial{},thread_pointer{},original_fp{},original_lr{};
 std::uint64_t args[9]{},stack[5]{};
 // A normal return is the only event generated. Geometry, full source,
 // Surface ownership and lease remain unknown; this is not a PaintToken.
 std::uint32_t normal_original_return{},full_source{},surface_lease{},mask_enabled{};
};
}
extern "C" void iq4_f1_scaler_after_08(const iq4::f1::normal08::ScalerCapture*)noexcept;
