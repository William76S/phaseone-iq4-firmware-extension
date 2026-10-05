#include "source_builder.hpp"
#include <cmath>
#include <cstring>

namespace iq4::raw_file_source_01 {
namespace {
template<class T> T load(const void* p, std::size_t offset) noexcept {
    T v{}; std::memcpy(&v, static_cast<const std::uint8_t*>(p) + offset, sizeof v); return v;
}
std::uint32_t word(const std::uint8_t* p, bool big) noexcept {
    return big ? (std::uint32_t(p[0]) << 24 | std::uint32_t(p[1]) << 16 |
                  std::uint32_t(p[2]) << 8 | p[3])
               : (std::uint32_t(p[3]) << 24 | std::uint32_t(p[2]) << 16 |
                  std::uint32_t(p[1]) << 8 | p[0]);
}
std::uint16_t half(const std::uint8_t* p, bool big) noexcept {
    return static_cast<std::uint16_t>(big ? (p[0] << 8 | p[1]) : (p[1] << 8 | p[0]));
}
bool equal(const FileStamp& a, const FileStamp& b) noexcept {
    return a.device == b.device && a.inode == b.inode && a.bytes == b.bytes &&
        a.mtime_seconds == b.mtime_seconds && a.mtime_nanoseconds == b.mtime_nanoseconds &&
        a.ctime_seconds == b.ctime_seconds && a.ctime_nanoseconds == b.ctime_nanoseconds &&
        a.mode == b.mode && a.read_only && b.read_only;
}
bool range(std::uint64_t offset, std::uint64_t n, std::uint64_t end) noexcept {
    return offset <= end && n <= end - offset;
}
bool read(const FileOps& io, int fd, void* out, std::uint32_t n,
          std::uint64_t offset, std::uint64_t end) {
    return range(offset, n, end) && io.pread(fd, out, n, offset) == n;
}
const Entry* find(const FileInfo& f, std::uint32_t tag) noexcept {
    for (std::uint32_t i = 0; i < f.count; ++i) if (f.entries[i].tag == tag) return f.entries + i;
    return nullptr;
}
bool scalar(const FileInfo& f, std::uint32_t tag, std::uint32_t& value) noexcept {
    const auto* e = find(f, tag); if (!e || e->type != 4 || e->bytes != 4) return false;
    value = e->value; return true;
}
bool geometry_valid(const Candidate& c) noexcept {
    return c.total_width && c.total_width <= 65535 && c.total_height && c.total_height <= 0x5410 &&
        c.left <= c.total_width && c.top <= c.total_height && c.valid_width && c.valid_height &&
        c.valid_width <= c.total_width - c.left && c.valid_height <= c.total_height - c.top;
}
bool same_geometry(const Candidate& a, const Candidate& b) noexcept {
    return a.total_width == b.total_width && a.total_height == b.total_height &&
        a.left == b.left && a.top == b.top && a.valid_width == b.valid_width &&
        a.valid_height == b.valid_height && a.payload_bytes == b.payload_bytes;
}
bool native_format(std::uint32_t raw, std::uint32_t& capture) noexcept {
    switch (raw) {
    case 3: capture = 1; return true;
    case 5: capture = 2; return true;
    case 6: capture = 3; return true;
    case 8: capture = 5; return true;
    case 9: capture = 6; return true;
    default: return false;
    }
}
bool ifd_value(const FileOps& io, int fd, std::uint64_t offset, bool big, std::uint64_t end,
               std::uint16_t tag, std::uint16_t type, std::uint32_t count,
               std::uint32_t& value, std::uint32_t* found_count = nullptr) {
    std::uint8_t raw[2 + 128 * 12 + 4]{};
    if (!read(io, fd, raw, 2, offset, end)) return false;
    const auto n = half(raw, big);
    if (n > 128 || !read(io, fd, raw + 2, std::uint32_t(n) * 12 + 4, offset + 2, end)) return false;
    unsigned found = 0;
    for (unsigned i = 0; i < n; ++i) {
        const auto* e = raw + 2 + i * 12;
        if (half(e, big) == tag) {
            if (half(e + 2, big) != type || (count && word(e + 4, big) != count)) return false;
            ++found; value = word(e + 8, big);
            if (found_count) *found_count = word(e + 4, big);
        }
    }
    return found == 1;
}
bool disjoint(const void* a, std::uint64_t an, const void* b, std::uint64_t bn) noexcept {
    const auto x = reinterpret_cast<std::uintptr_t>(a), y = reinterpret_cast<std::uintptr_t>(b);
    return a && b && x <= UINTPTR_MAX - an && y <= UINTPTR_MAX - bn &&
        (x + an <= y || y + bn <= x);
}
}

SourceResult inspect_saved_iiq(const FileOps& io, int fd, FileInfo& out) {
    out = {};
    if (!io.stat || !io.pread || !io.tell) return SourceResult::InvalidApi;
    FileInfo f;
    if (fd < 0 || !io.stat(fd, f.stamp) || !f.stamp.read_only ||
        (f.stamp.mode & 0170000) != 0100000 || !f.stamp.bytes || f.stamp.bytes > UINT32_MAX)
        return SourceResult::InvalidOwner;
    std::uint8_t h[20]{};
    if (!read(io, fd, h, sizeof h, 0, f.stamp.bytes)) return SourceResult::ShortRead;
    std::uint64_t iiqlimit = f.stamp.bytes;
    if ((h[0] == 'I' && h[1] == 'I') || (h[0] == 'M' && h[1] == 'M')) {
        const bool tiff_big = h[0] == 'M';
        if (half(h + 2, tiff_big) == 42) {
            std::uint32_t exif = 0, maker = 0, maker_bytes = 0;
            if (!ifd_value(io, fd, word(h + 4, tiff_big), tiff_big, f.stamp.bytes,
                           0x8769, 4, 1, exif) ||
                !ifd_value(io, fd, exif, tiff_big, f.stamp.bytes,
                           0x927c, 7, 0, maker, &maker_bytes) || maker != 8 ||
                maker_bytes < 20 || !range(maker, maker_bytes, f.stamp.bytes))
                return SourceResult::UnsupportedContainer;
            f.base = maker; iiqlimit = std::uint64_t(maker) + maker_bytes;
        }
    }
    const auto* hdr = h + f.base;
    if (std::memcmp(hdr, "IIII", 4) == 0) f.big_endian = false;
    else if (std::memcmp(hdr, "MMMM", 4) == 0) f.big_endian = true;
    else return SourceResult::UnsupportedContainer;
    const auto magic = word(hdr + 4, f.big_endian);
    if (magic != 0x52617743 && magic != 0x52617754 && magic != 0x52617742)
        return SourceResult::UnsupportedContainer; // no RawH/multiple exposure inference
    const auto directory = std::uint64_t(f.base) + word(hdr + 8, f.big_endian);
    if (directory > UINT32_MAX) return SourceResult::InvalidRange;
    f.directory = static_cast<std::uint32_t>(directory);
    std::uint8_t entries[8 + 200 * 16]{};
    if (!read(io, fd, entries, 8, directory, iiqlimit)) return SourceResult::ShortRead;
    f.count = word(entries, f.big_endian);
    if (!f.count || f.count > 200 || word(entries + 4, f.big_endian) != 0)
        return SourceResult::InvalidDirectory;
    if (!read(io, fd, entries + 8, f.count * 16, directory + 8, iiqlimit)) return SourceResult::ShortRead;
    for (std::uint32_t i = 0; i < f.count; ++i) {
        auto& e = f.entries[i]; const auto* p = entries + 8 + i * 16;
        e = {word(p, f.big_endian), word(p + 4, f.big_endian),
             word(p + 8, f.big_endian), word(p + 12, f.big_endian)};
        for (std::uint32_t j = 0; j < i; ++j)
            if (f.entries[j].tag == e.tag) return SourceResult::DuplicateTag;
        if (e.bytes > 4 && !range(std::uint64_t(f.base) + e.value, e.bytes, iiqlimit))
            return SourceResult::InvalidRange;
    }
    auto& g = f.geometry;
    if (!scalar(f, 0x108, g.total_width) || !scalar(f, 0x109, g.total_height) ||
        !scalar(f, 0x10a, g.left) || !scalar(f, 0x10b, g.top) ||
        !scalar(f, 0x10c, g.valid_width) || !scalar(f, 0x10d, g.valid_height) ||
        !scalar(f, 0x10e, f.raw_format)) return SourceResult::MissingTag;
    if (!geometry_valid(g) || !native_format(f.raw_format, g.capture_codec)) return SourceResult::InvalidGeometry;
    const auto* raw = find(f, 0x10f); const auto* rows = find(f, 0x21c);
    if (!raw || !rows) return SourceResult::MissingTag;
    if (raw->type != 2 || raw->bytes <= 4 || raw->bytes > INT32_MAX ||
        rows->type != 4 || rows->bytes != g.total_height * 4) return SourceResult::InvalidRange;
    g.payload_bytes = raw->bytes; f.payload_offset = std::uint64_t(f.base) + raw->value;
    FileStamp after{};
    if (!io.stat(fd, after) || !equal(f.stamp, after)) return SourceResult::FileChanged;
    out = f; return SourceResult::Ok;
}

SourceResult SourceBundle::build(const FileOps& io, int fd, const FileInfo& declared,
                                const ReaderStage& reader, const Candidate& candidate, Buffers b) {
    if (tags_alive_ || input_alive_ || ready_ || quarantined_) return SourceResult::InvalidOwner;
    if (!api_.map_construct || !api_.map_destroy || !api_.map_index || !api_.tag_u32 ||
        !api_.tag_float || !api_.tag_blob || !api_.input_construct || !api_.input_destroy ||
        !api_.vector_push || !api_.exact_image_and_layout_verified || !api_.compatible_cpp_unwind_verified)
        return SourceResult::InvalidApi;
    if (reader.state() != State::CandidateRead || fd < 0 || reader.held_native_fd() != fd ||
        !candidate.payload) return SourceResult::InvalidOwner;
    FileInfo actual;
    auto result = inspect_saved_iiq(io, fd, actual);
    if (result != SourceResult::Ok) return result;
    if (!equal(declared.stamp, actual.stamp) || declared.directory != actual.directory ||
        declared.base != actual.base || declared.payload_offset != actual.payload_offset ||
        !same_geometry(declared.geometry, actual.geometry) || declared.raw_format != actual.raw_format)
        return SourceResult::FileChanged;
    const auto& g = actual.geometry;
    if (!same_geometry(g, candidate) || g.capture_codec != candidate.capture_codec ||
        candidate.row_table != static_cast<const std::uint8_t*>(reader.reader()) + 0x20)
        return SourceResult::MetadataMismatch;
    const auto* fmt = static_cast<const std::uint8_t*>(reader.reader()) + CaptureFormatOffset;
    const auto kind = load<std::uint32_t>(fmt, 0xd030);
    if ((kind != 3 && kind != 4) || (kind == 3 && actual.base != 0) || (kind == 4 && actual.base != 8) ||
        load<std::uint32_t>(fmt, 0x40) != actual.raw_format ||
        io.tell(fd) != static_cast<std::int64_t>(actual.payload_offset + g.payload_bytes))
        return SourceResult::MetadataMismatch;
    const auto* cal = find(actual, 0x110);
    const auto mode = load<std::uint32_t>(fmt, 0xeaec);
    const auto row_tag = mode == 2 || mode == 4 ? 0x223u : mode == 5 ? 0x259u : 0x25au;
    const auto col_tag = mode == 2 || mode == 4 ? 0x225u : mode == 7 ? 0x26au : 0x258u;
    const auto* black_row = find(actual, row_tag); const auto* black_col = find(actual, col_tag);
    const auto black_bytes = (std::uint64_t(g.total_width) + g.total_height) * 4;
    if (mode < 2 || mode > 7 || !cal || cal->type != 1 || !cal->bytes ||
        !black_row || !black_col || black_row->type != 2 || black_col->type != 2 ||
        black_row->bytes != g.total_height * 4 || black_col->bytes != g.total_width * 4)
        return SourceResult::MissingTag;
    if (load<std::uint32_t>(fmt, 0x27c) != cal->bytes) return SourceResult::MetadataMismatch;
    struct Field { std::uint32_t tag, offset; };
    constexpr Field fields[] = {{0x103,0x7c},{0x105,0x214},{0x20b,0x204},{0x20c,0x208},
        {0x21e,0x22c},{0x222,0x234},{0x21d,0x200},{0x108,0},{0x109,4},{0x10a,8},
        {0x10b,12},{0x10c,16},{0x10d,20}};
    for (const auto& field : fields) {
        std::uint32_t expected = 0;
        if (!scalar(actual, field.tag, expected) || expected != load<std::uint32_t>(fmt, field.offset))
            return SourceResult::MetadataMismatch;
    }
    std::uint32_t scale_bits = 0;
    if (!scalar(actual, 0x245, scale_bits) || scale_bits != load<std::uint32_t>(fmt, 0x20c))
        return SourceResult::MetadataMismatch;
    const auto* profile = find(actual, 0x548);
    // Explicit finite admission: original type-1 blob length must be >4 to
    // identify an out-of-line section. Unknown inline encodings are rejected.
    if (profile && (profile->type != 1 || profile->bytes <= 4)) return SourceResult::InvalidRange;
    if (!b.rows || !b.black || !b.calibration ||
        (reinterpret_cast<std::uintptr_t>(b.rows) & 3) || b.rows_capacity < g.total_height ||
        b.black_capacity < black_bytes || b.calibration_capacity < cal->bytes ||
        (profile && (!b.profile || b.profile_capacity < profile->bytes)))
        return SourceResult::CapacityExceeded;
    const void* regions[] = {reader.reader(), candidate.payload, b.rows, b.black, b.calibration, this, b.profile};
    const std::uint64_t sizes[] = {ReaderBytes, g.payload_bytes, std::uint64_t(b.rows_capacity) * 4,
                                  b.black_capacity, b.calibration_capacity, sizeof(*this), b.profile_capacity};
    const auto region_count = profile ? 7u : 6u;
    for (unsigned i = 0; i < region_count; ++i) for (unsigned j = 0; j < i; ++j)
        if (!disjoint(regions[i], sizes[i], regions[j], sizes[j])) return SourceResult::InvalidOwner;
    std::uint8_t block[16384];
    for (std::uint32_t off = 0; off < g.payload_bytes;) {
        const auto n = g.payload_bytes - off > sizeof block ? std::uint32_t(sizeof block) : g.payload_bytes - off;
        if (!read(io, fd, block, n, actual.payload_offset + off, actual.stamp.bytes)) return SourceResult::ShortRead;
        if (std::memcmp(block, candidate.payload + off, n)) return SourceResult::PayloadMismatch;
        off += n;
    }
    const auto* row = find(actual, 0x21c);
    if (!read(io, fd, b.rows, row->bytes, std::uint64_t(actual.base) + row->value, actual.stamp.bytes))
        return SourceResult::ShortRead;
    for (std::uint32_t i = 0; i < g.total_height; ++i) {
        const auto value = word(reinterpret_cast<const std::uint8_t*>(b.rows + i), actual.big_endian);
        if (value >= g.payload_bytes || (i && value <= b.rows[i - 1]) ||
            value != load<std::uint32_t>(candidate.row_table, std::size_t(i) * 4))
            return SourceResult::MetadataMismatch;
        b.rows[i] = value;
    }
    if (!read(io, fd, b.black, black_row->bytes, std::uint64_t(actual.base) + black_row->value, actual.stamp.bytes) ||
        !read(io, fd, b.black + black_row->bytes, black_col->bytes,
              std::uint64_t(actual.base) + black_col->value, actual.stamp.bytes) ||
        !read(io, fd, b.calibration, cal->bytes, std::uint64_t(actual.base) + cal->value, actual.stamp.bytes))
        return SourceResult::ShortRead;
    if (profile && !read(io, fd, b.profile, profile->bytes,
                         std::uint64_t(actual.base) + profile->value, actual.stamp.bytes))
        return SourceResult::ShortRead;
    if (actual.big_endian) for (std::uint64_t i = 0; i < black_bytes; i += 2) {
        const auto tmp = b.black[i]; b.black[i] = b.black[i + 1]; b.black[i + 1] = tmp;
    }
    const auto* wb = find(actual, 0x107);
    std::uint8_t wb_bytes[12];
    if (!wb || wb->type != 4 || wb->bytes != 12 ||
        !read(io, fd, wb_bytes, 12, std::uint64_t(actual.base) + wb->value, actual.stamp.bytes))
        return SourceResult::MissingTag;
    for (unsigned i = 0; i < 3; ++i) {
        white_balance_[i] = word(wb_bytes + i * 4, actual.big_endian);
        if (white_balance_[i] != load<std::uint32_t>(fmt, 0x4c + i * 4)) return SourceResult::MetadataMismatch;
    }
    if (!std::isfinite(load<float>(fmt, 0xbc)) || !std::isfinite(load<float>(fmt, 0x20c)))
        return SourceResult::MetadataMismatch;
    FileStamp end{};
    if (!io.stat(fd, end) || !equal(actual.stamp, end)) return SourceResult::FileChanged;
    // Small semantic tag assignments reuse the native map/value API. They avoid
    // BuildTagsFile's two enormous ICE-relative scratch ranges; no vendor code
    // is copied or patched. Every blob is held in this nonmoving bundle/buffers.
    try {
        api_.map_construct(tags_); tags_alive_ = true;
        api_.input_construct(input_); input_alive_ = true;
        const auto set_u32 = [&](std::uint32_t tag, std::uint32_t value) {
            auto* item = api_.map_index(tags_, &tag);
            if (!item) throw 1;
            api_.tag_u32(item, value);
        };
        for (const auto& field : fields) set_u32(field.tag, load<std::uint32_t>(fmt, field.offset));
        set_u32(0x100, 0); set_u32(0x229, 0);
        constexpr Field float_fields[] = {{0x401,0xbc},{0x245,0x20c}};
        for (const auto& field : float_fields) {
            const auto value = load<float>(fmt, field.offset);
            if (!std::isfinite(value)) throw 1;
            const auto tag = field.tag; auto* item = api_.map_index(tags_, &tag);
            if (!item) throw 1;
            api_.tag_float(item, value);
        }
        const auto set_blob = [&](std::uint32_t tag, const void* data, std::uint32_t bytes) {
            auto* item = api_.map_index(tags_, &tag); if (!item) throw 1;
            api_.tag_blob(item, data, bytes);
        };
        set_blob(0x107, white_balance_, 12);
        set_blob(row_tag, b.black, black_row->bytes);
        set_blob(col_tag, b.black + black_row->bytes, black_col->bytes);
        set_blob(0x110, b.calibration, cal->bytes);
        for (std::uint32_t i = 0; i < g.total_height; ++i) api_.vector_push(input_ + 8, b.rows + i);
        const auto begin = load<std::uintptr_t>(input_, 8), end_rows = load<std::uintptr_t>(input_, 16);
        if (!begin || (begin & 3) || end_rows < begin ||
            end_rows - begin != std::uint64_t(g.total_height) * 4 ||
            load<std::uintptr_t>(input_, 24) < end_rows) throw 1;
        if (std::memcmp(reinterpret_cast<const void*>(begin), b.rows, std::size_t(g.total_height) * 4))
            throw 1;
        std::memcpy(input_, &actual.raw_format, 4);
        auto* payload = const_cast<std::uint8_t*>(candidate.payload);
        std::memcpy(input_ + 0x20, &payload, sizeof payload);
        std::memcpy(input_ + 0x28, &g.payload_bytes, 4);
        profile_ = profile ? ProfileView{b.profile, profile->bytes, b.profile[0] == 0} : ProfileView{};
        ready_ = true; return SourceResult::Ok;
    } catch (...) { quarantined_ = true; return SourceResult::NativeException; }
}
SourceResult SourceBundle::cleanup() {
    if (quarantined_) return SourceResult::NativeCleanupFailed;
    ready_ = false;
    profile_ = {};
    try {
        if (input_alive_) { input_alive_ = false; api_.input_destroy(input_); }
        if (tags_alive_) { tags_alive_ = false; api_.map_destroy(tags_); }
        return SourceResult::Ok;
    } catch (...) { quarantined_ = true; return SourceResult::NativeCleanupFailed; }
}
} // namespace iq4::raw_file_source_01
