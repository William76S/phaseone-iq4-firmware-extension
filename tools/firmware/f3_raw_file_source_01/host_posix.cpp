#include "source_builder.hpp"
#include <fcntl.h>
#include <sys/stat.h>
#include <unistd.h>

namespace iq4::raw_file_source_01 {
namespace {
bool stamp(int fd, FileStamp& out) {
    struct stat st{};
    const int flags = ::fcntl(fd, F_GETFL);
    if (flags < 0 || ::fstat(fd, &st) || st.st_size < 0) return false;
#if defined(__APPLE__)
    const auto mt = st.st_mtimespec, ct = st.st_ctimespec;
#else
    const auto mt = st.st_mtim, ct = st.st_ctim;
#endif
    out = {static_cast<std::uint64_t>(st.st_dev), static_cast<std::uint64_t>(st.st_ino),
        static_cast<std::uint64_t>(st.st_size), mt.tv_sec, mt.tv_nsec, ct.tv_sec, ct.tv_nsec,
        st.st_mode, (flags & O_ACCMODE) == O_RDONLY};
    return true;
}
std::int64_t read_at(int fd, void* p, std::uint32_t n, std::uint64_t offset) {
    if (offset > INT64_MAX) return -1;
    return ::pread(fd, p, n, static_cast<off_t>(offset));
}
std::int64_t tell(int fd) { return ::lseek(fd, 0, SEEK_CUR); }
}
FileOps host_posix_file_ops() noexcept { return {stamp, read_at, tell}; }
} // namespace iq4::raw_file_source_01
