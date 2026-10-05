#include "recorder_worker.hpp"
#include <limits>
#include <new>
#include <stdexcept>

namespace iq4::f4 {
RecorderWorker::RecorderWorker(CopyPool& p,runtime::Recorder& r,RecordingShape shape)
    :pool_(p),recorder_(r),shape_(shape) {
    if(!pool_.on_worker_thread()) throw std::logic_error("recorder bridge must belong to bound worker");
    if(!shape.width || !shape.height || std::size_t(shape.width)>std::numeric_limits<std::size_t>::max()/3 ||
       shape.stride!=std::size_t(shape.width)*3 || shape.height>std::numeric_limits<std::size_t>::max()/shape.stride ||
       shape.max_input_bytes!=shape.stride*shape.height || shape.max_input_bytes>CopyPool::max_slot_bytes)
        throw std::invalid_argument("worker needs fixed explicit packed geometry/span");
}
PumpResult RecorderWorker::pump_one() {
    if(!pool_.on_worker_thread()) { OwnedFrame unused; pool_.try_pop(unused); return PumpResult::WrongWorker; }
    if(pool_.native_release_uncertain()) {
        if(!source_error_reported_) { recorder_.source_lost(); source_error_reported_=true; }
        return PumpResult::SourceUnlockUncertain;
    }
    OwnedFrame owned;
    if(!pool_.try_pop(owned)) return PumpResult::Empty;
    const auto& info=owned.info();
    if(info.width!=shape_.width || info.height!=shape_.height || info.mode!=shape_.mode ||
       info.stride!=shape_.stride || info.bytes!=shape_.max_input_bytes) {
        ++counters_.rejected_shape; return PumpResult::RejectedShape;
    }
    if(info.color!=Color::RgbOrderVerified) {
        ++counters_.rejected_color; return PumpResult::RejectedColor;
    }
    if(info.host_completion_clock_ns>std::uint64_t(std::numeric_limits<std::int64_t>::max())) {
        ++counters_.rejected_clock; return PumpResult::RejectedClock;
    }
    runtime::Frame frame;
    try {
        frame.bytes.assign(owned.data(),owned.data()+info.bytes); // exclusively owned pool bytes, worker only
    } catch(const std::bad_alloc&) {
        owned.reset();
        ++counters_.worker_allocation_failed;
        // Original source ownership is already resolved. Stop/finalize only on
        // this worker; never retry capture/encode or synthesize replacement.
        recorder_.source_lost();
        return PumpResult::WorkerAllocationFailed;
    }
    frame.pts_ns=static_cast<std::int64_t>(info.host_completion_clock_ns);
    // Completion IDs describe software, not proven sensor exposures. Do not
    // make Recorder source_sequence/source_loss_known a hardware claim.
    frame.source_sequence.reset();
    owned.reset();
    if(!recorder_.submit(std::move(frame)) || !recorder_.consume_one()) {
        ++counters_.recorder_rejected; return PumpResult::RecorderRejected;
    }
    ++counters_.consumed; return PumpResult::Consumed;
}
}
