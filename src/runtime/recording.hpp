#pragma once
#include <cstddef>
#include <cstdint>
#include <deque>
#include <memory>
#include <optional>
#include <string>
#include <vector>

namespace iq4::runtime {
// Owned input only: camera borrowed buffers must be released after copying.
struct Frame {
    std::vector<std::uint8_t> bytes;
    std::int64_t pts_ns{};
    std::optional<std::uint64_t> source_sequence;
};
enum class State { Idle, Preparing, Recording, Finalizing, Error };
struct Counters {
    std::uint64_t accepted{}, encoded{}, dropped_queue_full{};
    std::uint64_t rejected_timestamp{}, source_gaps{};
    std::size_t queue_peak{};
    bool source_loss_known{false};
};
// Encoder and card implementations remain unbound until measured on the IQ4.
// All calls are serial on one executor; UI events must post to that executor.
class Backend {
public:
    virtual ~Backend() = default;
    virtual void prepare() = 0; // open temp output and initialize codec
    virtual void encode(const Frame&) = 0;
    virtual void finalize() = 0; // flush codec, sync, publish exclusive name
    virtual void abort() noexcept = 0; // idempotent: release resources, retain recovery temp
};
class Recorder {
public:
    explicit Recorder(std::size_t max_frames, std::size_t max_frame_bytes,
                      std::unique_ptr<Backend> backend);
    ~Recorder();
    Recorder(const Recorder&) = delete;
    Recorder& operator=(const Recorder&) = delete;
    bool start();
    bool submit(Frame frame);
    bool consume_one();
    bool stop();
    bool exit_page();
    bool reset_error();
    void source_lost();
    State state() const noexcept { return state_; }
    const std::string& error() const noexcept { return error_; }
    const Counters& counters() const noexcept { return counters_; }
    bool recording_indicator() const noexcept {
        return state_ == State::Recording && counters_.encoded > 0;
    }
private:
    bool fail(const std::string& reason);
    const std::size_t max_frames_, max_frame_bytes_;
    std::unique_ptr<Backend> backend_;
    std::deque<Frame> queue_;
    State state_{State::Idle};
    Counters counters_;
    std::string error_;
    std::optional<std::int64_t> last_pts_;
    std::optional<std::uint64_t> last_sequence_;
    bool all_frames_have_sequence_{true};
};
// POSIX exclusive final publish. Never accepts path separators, follows a
// destination symlink, overwrites IIQ/JPEG, or overwrites a prior output.
class AtomicOutput {
public:
    enum class PublishState { Temporary, FinalNameVisible, Complete };
    // Narrow syscall injection for error tests. Null functions use POSIX defaults.
    struct DirectoryOps {
        int (*sync)(int) = nullptr;
        int (*unlink_leaf)(int, const char*, int) = nullptr;
    };
    AtomicOutput(const std::string& directory, const std::string& filename);
    AtomicOutput(const std::string& directory, const std::string& filename, DirectoryOps operations);
    ~AtomicOutput();
    AtomicOutput(const AtomicOutput&) = delete;
    AtomicOutput& operator=(const AtomicOutput&) = delete;
    void write(const std::uint8_t* data, std::size_t size);
    void publish();
    const std::string& temporary_name() const noexcept { return temporary_; }
    PublishState publish_state() const noexcept { return publish_state_; }
private:
    int directory_fd_{-1}, file_fd_{-1};
    std::string filename_, temporary_;
    DirectoryOps operations_;
    PublishState publish_state_{PublishState::Temporary};
};
}
