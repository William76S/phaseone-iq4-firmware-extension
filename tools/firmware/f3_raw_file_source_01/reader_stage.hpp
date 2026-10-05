#pragma once
#include <cstddef>
#include <cstdint>

namespace iq4::raw_file_source_01 {
constexpr std::size_t ReaderBytes = 0x62c80;
constexpr std::size_t CaptureFormatOffset = 0x380a0;
constexpr std::size_t PayloadLengthOffset = 0x3a56c;

// These signatures describe observed AAPCS arguments, not a runtime binding.
struct NativeApi {
    void (*construct)(void*, void*, void*, void*, void*, void*, void*);
    void (*destroy)(void*); // non-deleting CaptureFileReader destructor
    bool (*open)(void*, const char*, const char*, bool, bool);
    bool (*close)(void*);
    bool (*is_open)(void*);
    std::uint32_t (*read_payload)(void*, void*, std::uint32_t);
    std::uint32_t (*capture_codec)(void*);
    bool exact_image_and_layout_verified;
    bool compatible_cpp_unwind_verified;
    std::uintptr_t expected_file_vtable;
    std::uintptr_t expected_filesystem_vtable;
};

struct ConstructorInputs {
    void* module_a;
    void* filesystem;
    void* metadata_init_a;
    void* metadata_init_b;
    void* metadata_init_c;
    void* module_b;
};

struct Candidate {
    std::uint32_t total_width, total_height, left, top, valid_width, valid_height;
    std::uint32_t capture_codec, payload_bytes;
    const void* row_table; // borrowed inline reader rows; SourceBundle verifies entries
    const std::uint8_t* payload; // owned by caller's exclusive held reservation
};

// Exact observed 0x30 input layout. SourceBundle constructs the native vector
// only after row allocation/codec conversion/full encoded-section proof.
struct NativeRawInputLayout {
    std::uint32_t format, padding0;
    std::uint32_t* rows_begin;
    std::uint32_t* rows_end;
    std::uint32_t* rows_capacity;
    std::uint8_t* payload;
    std::uint32_t payload_bytes, padding1;
};
static_assert(sizeof(void*) == 8 && sizeof(NativeRawInputLayout) == 0x30);
static_assert(offsetof(NativeRawInputLayout, payload) == 0x20);
static_assert(offsetof(NativeRawInputLayout, payload_bytes) == 0x28);

enum class State { Empty, Constructed, Open, CandidateRead, Closed, Quarantined };
enum class Result {
    Ok, InvalidApi, InvalidStorage, InvalidPath, InvalidState, NativeException,
    OpenFailed, InvalidMetadata, CapacityExceeded, ShortRead, MetadataChanged,
    CloseFailed
};

// This partial stage never asserts full RAW completeness. Storage and native
// dependencies remain exclusively held until shutdown succeeds. If quarantined,
// retain them and stop: retrying a partial native destructor is unsafe.
class ReaderStage final {
public:
    explicit ReaderStage(NativeApi api) noexcept : api_(api) {}
    ReaderStage(const ReaderStage&) = delete;
    ReaderStage& operator=(const ReaderStage&) = delete;
    Result construct(void* storage, std::size_t bytes, ConstructorInputs inputs);
    Result open(const char* directory, std::size_t directory_bytes,
                const char* name, std::size_t name_bytes);
    Result read_candidate(std::uint8_t* payload, std::uint32_t held_capacity,
                          Candidate& output);
    Result shutdown();
    State state() const noexcept { return state_; }
    void* reader() const noexcept { return reader_; }
    int held_native_fd() const noexcept; // access mode separately checked by FileOps.stat
private:
    bool snapshot(Candidate&) const noexcept;
    NativeApi api_;
    void* reader_ = nullptr;
    void* filesystem_ = nullptr;
    State state_ = State::Empty;
};
} // namespace iq4::raw_file_source_01
