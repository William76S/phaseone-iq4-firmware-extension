#include "recording.hpp"
#include <cerrno>
#include <cstring>
#include <exception>
#include <fcntl.h>
#include <stdexcept>
#include <unistd.h>

namespace iq4::runtime {
Recorder::Recorder(std::size_t max_frames, std::size_t max_frame_bytes,
                   std::unique_ptr<Backend> backend)
    : max_frames_(max_frames), max_frame_bytes_(max_frame_bytes), backend_(std::move(backend)) {
    if (!max_frames || !max_frame_bytes || !backend_) throw std::invalid_argument("invalid recorder limits/backend");
}
Recorder::~Recorder() { if (state_ != State::Idle) backend_->abort(); }
bool Recorder::fail(const std::string& reason) {
    error_ = reason;
    backend_->abort();
    queue_.clear();
    state_ = State::Error;
    return false;
}
bool Recorder::start() {
    if (state_ != State::Idle) return false;
    counters_ = {}; error_.clear(); last_pts_.reset(); last_sequence_.reset();
    all_frames_have_sequence_ = true;
    state_ = State::Preparing;
    try { backend_->prepare(); state_ = State::Recording; return true; }
    catch (const std::exception& e) { return fail(e.what()); }
}
bool Recorder::submit(Frame frame) {
    if (state_ != State::Recording) return false;
    if (frame.bytes.empty() || frame.bytes.size() > max_frame_bytes_) return fail("invalid or oversized owned frame");
    // No timestamps are synthesized. Nonmonotonic input cannot be called new.
    if (frame.pts_ns < 0 || (last_pts_ && frame.pts_ns <= *last_pts_)) {
        ++counters_.rejected_timestamp; return false;
    }
    if (frame.source_sequence && last_sequence_ && *frame.source_sequence <= *last_sequence_) {
        ++counters_.rejected_timestamp; return false;
    }
    if (!frame.source_sequence) all_frames_have_sequence_ = false;
    if (frame.source_sequence && last_sequence_) counters_.source_gaps += *frame.source_sequence - *last_sequence_ - 1;
    last_sequence_ = frame.source_sequence;
    last_pts_ = frame.pts_ns;
    counters_.source_loss_known = all_frames_have_sequence_;
    if (queue_.size() >= max_frames_) { ++counters_.dropped_queue_full; return false; }
    queue_.push_back(std::move(frame)); ++counters_.accepted;
    if (queue_.size() > counters_.queue_peak) counters_.queue_peak = queue_.size();
    return true;
}
bool Recorder::consume_one() {
    if ((state_ != State::Recording && state_ != State::Finalizing) || queue_.empty()) return false;
    try { backend_->encode(queue_.front()); queue_.pop_front(); ++counters_.encoded; return true; }
    catch (const std::exception& e) { return fail(e.what()); }
}
bool Recorder::stop() {
    if (state_ == State::Idle) return true;
    if (state_ != State::Recording) return false;
    state_ = State::Finalizing;
    while (!queue_.empty()) if (!consume_one()) return false;
    try { backend_->finalize(); state_ = State::Idle; return true; }
    catch (const std::exception& e) { return fail(e.what()); }
}
bool Recorder::exit_page() {
    if (state_ == State::Error) { backend_->abort(); queue_.clear(); return false; }
    return stop();
}
bool Recorder::reset_error() {
    if (state_ != State::Error) return false;
    backend_->abort(); queue_.clear(); error_.clear(); state_ = State::Idle; return true;
}
void Recorder::source_lost() {
    if (state_ == State::Recording) {
        // Save all already owned frames and finish the container before reporting.
        if (stop()) { error_ = "live-view source lost; buffered output finalized"; state_ = State::Error; }
    }
}
namespace {
[[noreturn]] void io_error(const char* operation) {
    const int saved = errno;
    throw std::runtime_error(std::string(operation) + ": " + std::strerror(saved));
}
}
AtomicOutput::AtomicOutput(const std::string& directory, const std::string& filename)
    : AtomicOutput(directory, filename, DirectoryOps{}) {}
AtomicOutput::AtomicOutput(const std::string& directory, const std::string& filename, DirectoryOps operations)
    : filename_(filename), operations_(operations) {
    if (!operations_.sync) operations_.sync = ::fsync;
    if (!operations_.unlink_leaf) operations_.unlink_leaf = ::unlinkat;
    if (filename.empty() || filename.size() > 160 || filename == "." || filename == ".." ||
        filename.find('/') != std::string::npos || filename.find('\\') != std::string::npos ||
        filename.find('\0') != std::string::npos) throw std::invalid_argument("invalid output leaf name");
    directory_fd_ = ::open(directory.c_str(), O_RDONLY | O_DIRECTORY | O_NOFOLLOW);
    if (directory_fd_ < 0) io_error("open output directory");
    // O_EXCL makes a stale temporary file a recoverable refusal, never a truncation.
    temporary_ = filename + ".iq4ext.partial";
    file_fd_ = ::openat(directory_fd_, temporary_.c_str(), O_WRONLY | O_CREAT | O_EXCL | O_NOFOLLOW, 0600);
    if (file_fd_ < 0) { int saved = errno; ::close(directory_fd_); directory_fd_ = -1; errno = saved; io_error("create exclusive temporary output"); }
}
AtomicOutput::~AtomicOutput() {
    if (file_fd_ >= 0) ::close(file_fd_);
    if (directory_fd_ >= 0) ::close(directory_fd_);
    // On failure/interruption keep .partial for inspection/recovery; no success claim.
}
void AtomicOutput::write(const std::uint8_t* data, std::size_t size) {
    if (publish_state_ != PublishState::Temporary || file_fd_ < 0 || (!data && size)) throw std::logic_error("invalid write state");
    while (size) {
        auto n = ::write(file_fd_, data, size);
        if (n < 0 && errno == EINTR) continue;
        if (n <= 0) io_error("write temporary output");
        data += n; size -= static_cast<std::size_t>(n);
    }
}
void AtomicOutput::publish() {
    if (publish_state_ != PublishState::Temporary || file_fd_ < 0) throw std::logic_error("output already visible");
    if (::fsync(file_fd_) != 0) io_error("sync temporary output");
    // POSIX hardlink creation fails if final exists, including existing symlinks.
    // Filesystems without hardlinks require a verified target-specific adapter.
    if (::linkat(directory_fd_, temporary_.c_str(), directory_fd_, filename_.c_str(), 0) != 0) io_error("publish output without overwrite");
    // Visibility is irreversible for this writer: never mutate the linked inode
    // even when directory sync or temporary-name removal subsequently fails.
    publish_state_ = PublishState::FinalNameVisible;
    if (operations_.sync(directory_fd_) != 0) io_error("sync published directory");
    if (operations_.unlink_leaf(directory_fd_, temporary_.c_str(), 0) != 0) io_error("remove completed temporary name");
    if (operations_.sync(directory_fd_) != 0) io_error("sync final directory");
    publish_state_ = PublishState::Complete;
}
}
