#pragma once
#include "../codec/bounded_jpeg.h"
#include "../runtime/recording.hpp"
#include <memory>

namespace iq4::recording {
struct RgbJpegOptions {
    std::uint32_t width{},height{};
    std::size_t stride{}; // Explicit source row spacing, never inferred.
    std::size_t maxInputBytes{}; // Explicit owned RGB span upper bound.
    int quality=90;
    std::size_t maxOutputBytes{}; // Hard JPEG destination bound, 1..128MiB.
};
// Serial, noncopyable single-session decorator. Owns the downstream Backend
// and one bounded packet allocation. No camera symbol binding, RGB copy,
// resizing, source timestamps or duplicate frames are created here.
// The library behind the supplied function table must remain valid for life.
class RgbJpegBackend final : public runtime::Backend {
public:
    RgbJpegBackend(RgbJpegOptions options,Iq4JpegApi api,
                   std::unique_ptr<runtime::Backend> packetBackend);
    ~RgbJpegBackend() override;
    RgbJpegBackend(const RgbJpegBackend&) = delete;
    RgbJpegBackend& operator=(const RgbJpegBackend&) = delete;
    void prepare() override;
    void encode(const runtime::Frame& ownedRgb) override;
    void finalize() override;
    void abort() noexcept override;
    const Iq4JpegResult& lastCodecResult() const noexcept { return lastResult_; }
    std::size_t packetBufferCapacity() const noexcept { return packet_.bytes.capacity(); }
private:
    enum class State { Idle, Preparing, Ready, Encoding, Finalizing };
    const RgbJpegOptions options_;
    const Iq4JpegApi api_;
    std::unique_ptr<runtime::Backend> downstream_;
    runtime::Frame packet_;
    Iq4JpegResult lastResult_{};
    State state_=State::Idle;
    std::size_t requiredInputBytes_=0;
    bool downstreamArmed_=false;
};
}
