#pragma once
#include "owned_copy_pool.hpp"
#include "../../../src/runtime/recording.hpp"

namespace iq4::f4 {
struct RecordingShape {
    std::uint32_t width{}, height{}, mode{};
    std::size_t stride{}, max_input_bytes{};
};
enum class PumpResult { Empty, WrongWorker, Consumed, RejectedShape, RejectedColor, RejectedClock, SourceUnlockUncertain, WorkerAllocationFailed, RecorderRejected };
struct WorkerCounters {
    std::uint64_t consumed{}, rejected_shape{}, rejected_color{}, rejected_clock{}, worker_allocation_failed{}, recorder_rejected{};
};
// Construct/use only on the separately bound worker; Recorder/RgbJpegBackend
// start/submit/consume/stop/abort belong exclusively to that worker executor.
// Copy into runtime::Frame may allocate here, after original source release.
class RecorderWorker {
public:
    RecorderWorker(CopyPool&, runtime::Recorder&, RecordingShape);
    PumpResult pump_one();
    const WorkerCounters& counters() const noexcept { return counters_; }
private:
    CopyPool& pool_;
    runtime::Recorder& recorder_;
    RecordingShape shape_;
    WorkerCounters counters_{};
    bool source_error_reported_{false};
};
}
