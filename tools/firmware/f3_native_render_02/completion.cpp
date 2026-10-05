#include "completion.hpp"
namespace iq4::native_render_02 {
static bool same(const Owner& a,const Owner& b) {
    return a.generator==b.generator && a.input==b.input && a.rgb32==b.rgb32 &&
        a.planar==b.planar && a.settings==b.settings && a.pool==b.pool &&
        a.cancel==b.cancel && a.arena==b.arena && a.capacity==b.capacity && a.identity==b.identity;
}
static Result begin_actual(void* ctx,const Owner& o) {
    auto& c=*static_cast<CombinedCompletion*>(ctx);
    if (c.active) return Result::Busy;
    if (!c.read || !c.row_states || !o.input) return Result::Unbound;
    const auto* raw=static_cast<const raw_file_source_01::NativeRawInputLayout*>(o.input);
    Attempt attempt;
    if (bounded_attempt(o.geometry,o.capacity,attempt)!=Result::Ok) return Result::Capacity;
    Iq4DecodeOwner02 d={reinterpret_cast<std::uintptr_t>(o.pool),reinterpret_cast<std::uintptr_t>(raw->payload),
        reinterpret_cast<std::uintptr_t>(raw->rows_begin),reinterpret_cast<std::uintptr_t>(o.arena)+PrefixBytes,
        reinterpret_cast<std::uintptr_t>(o.cancel),c.payload_allocation_bytes,attempt.decoded_reservation,
        raw->payload_bytes,o.geometry.total_width,o.geometry.total_height,o.geometry.left,o.geometry.top,
        o.geometry.valid_width,o.geometry.valid_height,c.row_states,c.row_states_bytes};
    auto dr=iq4_f3_decode_begin_02(c.read,c.read_context,&d,&c.decode_generation);
    if (dr!=IQ4_DECODE_OK) return dr==IQ4_DECODE_HOLD?Result::Hold:Result::Unbound;
    Iq4CoreOwner01 k={reinterpret_cast<std::uintptr_t>(o.settings),reinterpret_cast<std::uintptr_t>(o.cancel),
        reinterpret_cast<std::uintptr_t>(o.pool),reinterpret_cast<std::uintptr_t>(o.rgb32),
        reinterpret_cast<std::uintptr_t>(o.arena),o.capacity};
    auto kr=iq4_f3_core_begin_01(c.read,c.read_context,&k,&c.core_generation);
    if (kr!=IQ4_CORE_OK) {
        // No native call or worker was started by either begin. Release this
        // empty decode receipt; never end a core receipt that did not begin.
        if (iq4_f3_decode_abort_joined_02(c.decode_generation)!=IQ4_DECODE_OK) return Result::Hold;
        return kr==IQ4_CORE_HOLD?Result::Hold:Result::Unbound;
    }
    c.bound_owner=o;c.active=true;c.decode_retired=false;c.core_retired=false;c.decode={};c.core={};
    return Result::Ok;
}
static Result end_actual(void* ctx,const Owner& o,std::uint32_t actual,Receipt& out) {
    auto& c=*static_cast<CombinedCompletion*>(ctx);out={};
    if (!c.active || !same(o,c.bound_owner)) return Result::Hold;
    const int dr=iq4_f3_decode_end_02(c.decode_generation,&c.decode);
    const int kr=iq4_f3_core_end_01(c.core_generation,&c.core);
    c.decode_retired=dr==IQ4_DECODE_OK || dr==IQ4_DECODE_INCOMPLETE;
    c.core_retired=kr==IQ4_CORE_OK || kr==IQ4_CORE_FAILED;
    out.reader_returned=c.decode.returned==1;
    out.decoded_rows_complete=dr==IQ4_DECODE_OK && c.decode.complete==1;
    out.decode_workers_joined=c.decode.joins==1;
    out.full_r0_core_complete=kr==IQ4_CORE_OK && c.core.complete==1 && c.core.core_returned==1;
    out.core_workers_joined=c.core.joins>0 && c.core.joins==c.core.stages;
    if (!c.decode_retired || !c.core_retired) return Result::Hold;
    c.active=false;
    return actual==1 && out.reader_returned && out.decoded_rows_complete && out.decode_workers_joined &&
        out.full_r0_core_complete && out.core_workers_joined ? Result::Ok : Result::Incomplete;
}
static Result abort_actual(void* ctx,const Owner& o) {
    auto& c=*static_cast<CombinedCompletion*>(ctx);
    if (!same(o,c.bound_owner)) return Result::Hold;
    // A normal failed end may already have retired both actual receipts. This
    // is idempotent after the caller's real pool join. Unknown/held callbacks
    // retain every dependent native object instead of resetting global state.
    if (c.decode_retired && c.core_retired) {c.active=false;return Result::Ok;}
    return Result::Hold;
}
Completion CombinedCompletion::callbacks() noexcept {
    // The begin functions perform exact runtime code/slot/owner admission.
    return {this,true,begin_actual,end_actual,abort_actual};
}
} // namespace iq4::native_render_02
