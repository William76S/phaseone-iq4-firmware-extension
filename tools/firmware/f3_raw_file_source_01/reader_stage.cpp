#include "reader_stage.hpp"
#include <cstring>

namespace iq4::raw_file_source_01 {
namespace {
bool terminated(const char* p, std::size_t length, bool nonempty) noexcept {
    if (!p || (nonempty && !length) || length > 255) return false;
    return std::memchr(p, '\0', length) == nullptr && p[length] == '\0';
}
template<class T> T load(const void* p, std::size_t offset) noexcept {
    T result{};
    std::memcpy(&result, static_cast<const std::uint8_t*>(p) + offset, sizeof(T));
    return result;
}
bool same_metadata(const Candidate& a, const Candidate& b) noexcept {
    return a.total_width == b.total_width && a.total_height == b.total_height &&
        a.left == b.left && a.top == b.top && a.valid_width == b.valid_width &&
        a.valid_height == b.valid_height && a.payload_bytes == b.payload_bytes &&
        a.row_table == b.row_table;
}
}
Result ReaderStage::construct(void* storage, std::size_t bytes, ConstructorInputs i) {
    if (state_ != State::Empty) return Result::InvalidState;
    if (!api_.construct || !api_.destroy || !api_.open || !api_.close ||
        !api_.is_open || !api_.read_payload || !api_.capture_codec ||
        !api_.exact_image_and_layout_verified || !api_.compatible_cpp_unwind_verified ||
        !api_.expected_file_vtable || !api_.expected_filesystem_vtable)
        return Result::InvalidApi;
    if (!storage || bytes < ReaderBytes || (reinterpret_cast<std::uintptr_t>(storage) & 15) ||
        reinterpret_cast<std::uintptr_t>(storage) > UINTPTR_MAX - ReaderBytes ||
        !i.filesystem) return Result::InvalidStorage;
    reader_ = storage;
    filesystem_ = i.filesystem;
    try {
        api_.construct(reader_, i.module_a, i.filesystem, i.metadata_init_a,
                       i.metadata_init_b, i.metadata_init_c, i.module_b);
        state_ = State::Constructed;
        return Result::Ok;
    } catch (...) {
        // A thrown native ctor's C++ member unwinding is its own responsibility.
        // Do not invoke the complete-object destructor on a partial object.
        state_ = State::Quarantined;
        return Result::NativeException;
    }
}
int ReaderStage::held_native_fd() const noexcept {
    if (state_ != State::Open && state_ != State::CandidateRead) return -1;
    const auto* stream = static_cast<const std::uint8_t*>(reader_) + 0x62c10;
    if (load<std::uintptr_t>(stream, 0) != api_.expected_file_vtable ||
        load<void*>(stream, 8) != filesystem_ ||
        load<std::uintptr_t>(filesystem_, 0) != api_.expected_filesystem_vtable ||
        load<std::uint8_t>(stream, 0x14) != 1 || load<std::uint8_t>(stream, 0x15) != 0)
        return -1;
    return load<std::int32_t>(stream, 0x10);
}
Result ReaderStage::open(const char* dir, std::size_t dir_bytes,
                        const char* name, std::size_t name_bytes) {
    if (state_ != State::Constructed) return Result::InvalidState;
    if (!terminated(name, name_bytes, true) ||
        (dir ? !terminated(dir, dir_bytes, false) || dir_bytes + 1 + name_bytes > 255
             : dir_bytes != 0)) return Result::InvalidPath;
    try {
        if (api_.is_open(reader_)) { state_ = State::Quarantined; return Result::InvalidState; }
        const bool opened = api_.open(reader_, dir, name, true, false);
        const bool held = api_.is_open(reader_);
        // Native Open's parse-failure branch discards its internal Close result.
        // A false return is quarantined even if its open byte has become zero.
        state_ = opened && held ? State::Open : State::Quarantined;
        return opened && held ? Result::Ok : Result::OpenFailed;
    } catch (...) { state_ = State::Quarantined; return Result::NativeException; }
}
bool ReaderStage::snapshot(Candidate& c) const noexcept {
    c = {};
    const auto* f = static_cast<const std::uint8_t*>(reader_) + CaptureFormatOffset;
    c.total_width = load<std::uint32_t>(f, 0);
    c.total_height = load<std::uint32_t>(f, 4);
    c.left = load<std::uint32_t>(f, 8);
    c.top = load<std::uint32_t>(f, 12);
    c.valid_width = load<std::uint32_t>(f, 16);
    c.valid_height = load<std::uint32_t>(f, 20);
    c.payload_bytes = load<std::uint32_t>(reader_, PayloadLengthOffset);
    c.row_table = load<const void*>(f, 0x24d8);
    return c.total_width && c.total_height && c.valid_width && c.valid_height &&
        c.total_width <= 65535 && c.total_height <= 0x5410 &&
        c.left <= c.total_width && c.top <= c.total_height &&
        c.valid_width <= c.total_width - c.left &&
        c.valid_height <= c.total_height - c.top && c.payload_bytes &&
        c.payload_bytes <= INT32_MAX &&
        c.row_table == static_cast<const std::uint8_t*>(reader_) + 0x20;
}
Result ReaderStage::read_candidate(std::uint8_t* p, std::uint32_t cap, Candidate& out) {
    out = {};
    if (state_ != State::Open) return Result::InvalidState;
    Candidate before{}, after{};
    if (!snapshot(before)) return Result::InvalidMetadata;
    if (!p || before.payload_bytes > cap) return Result::CapacityExceeded;
    // Caller must supply separately held exclusive storage, never memory within
    // reader/parser storage. uintptr arithmetic avoids unrelated pointer ordering.
    const auto begin = reinterpret_cast<std::uintptr_t>(p);
    const auto reader = reinterpret_cast<std::uintptr_t>(reader_);
    if (begin > UINTPTR_MAX - cap ||
        (begin < reader + ReaderBytes && reader < begin + cap)) return Result::InvalidStorage;
    try {
        if (!api_.is_open(reader_)) return Result::InvalidState;
        const auto received = api_.read_payload(reader_, p, before.payload_bytes);
        if (received != before.payload_bytes) return Result::ShortRead;
        if (!snapshot(after) || !same_metadata(before, after)) return Result::MetadataChanged;
        after.capture_codec = api_.capture_codec(reader_);
        after.payload = p;
        out = after;
        state_ = State::CandidateRead;
        return Result::Ok;
    } catch (...) { state_ = State::Quarantined; return Result::NativeException; }
}
Result ReaderStage::shutdown() {
    if (state_ == State::Closed) return Result::Ok;
    if (state_ == State::Empty || state_ == State::Quarantined) return Result::InvalidState;
    try {
        if (api_.is_open(reader_) && !api_.close(reader_)) {
            state_ = State::Quarantined;
            return Result::CloseFailed; // is_open==false does not erase a close error
        }
        if (api_.is_open(reader_)) { state_ = State::Quarantined; return Result::CloseFailed; }
        state_ = State::Quarantined; // no repeat destructor if it throws partially
        api_.destroy(reader_);
        state_ = State::Closed;
        return Result::Ok;
    } catch (...) { state_ = State::Quarantined; return Result::NativeException; }
}
} // namespace iq4::raw_file_source_01
