#pragma once
#include "reader_stage.hpp"

namespace iq4::raw_file_source_01 {
struct FileStamp {
    std::uint64_t device, inode, bytes;
    std::int64_t mtime_seconds, mtime_nanoseconds, ctime_seconds, ctime_nanoseconds;
    std::uint32_t mode;
    bool read_only;
};
struct FileOps {
    bool (*stat)(int, FileStamp&);
    std::int64_t (*pread)(int, void*, std::uint32_t, std::uint64_t);
    std::int64_t (*tell)(int);
};
struct Entry { std::uint32_t tag, type, bytes, value; };
struct FileInfo {
    FileStamp stamp{};
    std::uint32_t base = 0, directory = 0, count = 0;
    bool big_endian = false;
    Entry entries[200]{};
    Candidate geometry{};
    std::uint32_t raw_format = 0;
    std::uint64_t payload_offset = 0;
};
enum class SourceResult {
    Ok, InvalidApi, InvalidOwner, FileChanged, ShortRead, UnsupportedContainer,
    InvalidDirectory, DuplicateTag, MissingTag, InvalidGeometry, InvalidRange,
    CapacityExceeded, MetadataMismatch, PayloadMismatch, NativeException,
    NativeCleanupFailed
};
// Scans metadata only, using exact return counts on one held read-only fd.
// Supported finite scope: IIQ RawC/T/B directory at base0, or TIFF MakerNote
// at base8 (IFD0 -> ExifIFD -> MakerNote), one image directory, <=200 entries.
SourceResult inspect_saved_iiq(const FileOps&, int fd, FileInfo&);

struct Buffers {
    std::uint32_t* rows;
    std::uint32_t rows_capacity;
    std::uint8_t* black;
    std::uint32_t black_capacity;
    std::uint8_t* calibration;
    std::uint32_t calibration_capacity;
    std::uint8_t* profile;
    std::uint32_t profile_capacity;
};
struct ProfileView {
    const std::uint8_t* bytes = nullptr;
    std::uint32_t length = 0;
    // Native file worker chooses profile slot 0 for no section or first byte 0.
    // A nonzero first byte still requires the original generator's parser.
    bool builtin_slot_zero = true;
};
struct ObjectApi {
    void (*map_construct)(void*);
    void (*map_destroy)(void*);
    void* (*map_index)(void*, const std::uint32_t*);
    void (*tag_u32)(void*, std::uint32_t);
    void (*tag_float)(void*, float);
    void (*tag_blob)(void*, const void*, std::uint32_t); // BORROWS, no copy
    void (*input_construct)(void*);
    void (*input_destroy)(void*);
    void (*vector_push)(void*, const std::uint32_t*);
    bool exact_image_and_layout_verified;
    bool compatible_cpp_unwind_verified;
};

// Owned, nonmoving native objects and WB storage; other buffers are caller-owned
// exclusive reservations held through renderer workers + native cleanup. Native
// raw data format remains encoded Bayer. Source completion does not prove decode
// or JPEG completion. All native addresses remain unbound.
class SourceBundle final {
public:
    explicit SourceBundle(ObjectApi api) noexcept : api_(api) {}
    SourceBundle(const SourceBundle&) = delete;
    SourceBundle& operator=(const SourceBundle&) = delete;
    SourceResult build(const FileOps&, int held_fd, const FileInfo&,
                       const ReaderStage&, const Candidate&, Buffers);
    SourceResult cleanup(); // caller may invoke ONLY after native renderer cleanup
    const void* raw_input() const noexcept { return ready_ ? input_ : nullptr; }
    void* owned_tags() noexcept { return ready_ ? tags_ : nullptr; }
    bool ready_encoded_full_section() const noexcept { return ready_; }
    ProfileView profile() const noexcept { return ready_ ? profile_ : ProfileView{}; }
    bool quarantined() const noexcept { return quarantined_; }
private:
    ObjectApi api_;
    alignas(16) std::uint8_t tags_[0x30]{};
    alignas(16) std::uint8_t input_[0x30]{};
    std::uint32_t white_balance_[3]{};
    ProfileView profile_{};
    bool tags_alive_ = false, input_alive_ = false, ready_ = false, quarantined_ = false;
};
FileOps host_posix_file_ops() noexcept; // host-only implementation, no camera
} // namespace iq4::raw_file_source_01
