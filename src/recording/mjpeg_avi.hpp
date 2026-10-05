#pragma once
#include "../runtime/recording.hpp"
#include <cstdint>
#include <memory>
#include <string>
#include <vector>
#include <sys/types.h>

namespace iq4::recording {
// Fault injection defaults to real syscalls. No hardlink operation exists.
struct FileOps {
    ssize_t (*write)(int,const void*,std::size_t) = nullptr;
    ssize_t (*pwrite)(int,const void*,std::size_t,off_t) = nullptr;
    int (*sync)(int) = nullptr;
    int (*renameExclusive)(int,const char*,int,const char*) = nullptr;
};
enum class Publication { Temporary, Sealed, FinalNameVisible, Complete };
class ExclusiveFile {
public:
    ExclusiveFile(std::string directory,std::string finalLeaf,FileOps ops = {});
    ~ExclusiveFile();
    ExclusiveFile(const ExclusiveFile&) = delete;
    ExclusiveFile& operator=(const ExclusiveFile&) = delete;
    void append(const void* bytes,std::size_t count);
    void patch(std::uint64_t offset,const void* bytes,std::size_t count);
    void publish();
    void close() noexcept;
    Publication publication() const noexcept { return publication_; }
    std::uint64_t size() const noexcept { return size_; }
    const std::string& finalLeaf() const noexcept { return final_; }
    const std::string& temporaryLeaf() const noexcept { return temporary_; }
private:
    int directoryFd_=-1,fileFd_=-1;
    FileOps ops_;
    Publication publication_=Publication::Temporary;
    std::string final_,temporary_;
    std::uint64_t size_=0;
};
struct AviOptions {
    std::string directory;
    std::string prefix="IQ4_LV";
    unsigned width{},height{};
    unsigned rateNumerator=30,rateDenominator=1; // NOMINAL CFR playback only.
    // Default: reject nonrepresentable input timestamps. Explicitly bounded
    // tolerance still records ORIGINAL PTS in per-packet IQ4T JUNK records.
    std::int64_t ptsToleranceNs=0;
    std::uint64_t maxFileBytes=1024ULL*1024*1024; // below FAT32 4GiB boundary.
    std::size_t maxPacketBytes=32u*1024*1024;
    std::size_t maxFrames=100000;
    FileOps fileOps{};
};
// Consumes owned, complete baseline JPEG packets; it never encodes RGB, makes
// duplicate frames or creates source timestamps. Container rate != source FPS.
class MjpegAviBackend final : public runtime::Backend {
public:
    explicit MjpegAviBackend(AviOptions options);
    ~MjpegAviBackend() override;
    void prepare() override;
    void encode(const runtime::Frame& jpegPacket) override;
    void finalize() override;
    void abort() noexcept override;
    const std::string& finalLeaf() const noexcept { return finalLeaf_; }
    const std::string& temporaryLeaf() const noexcept { return temporaryLeaf_; }
    Publication publication() const noexcept { return publication_; }
    std::size_t packetCount() const noexcept { return index_.size(); }
    std::int64_t maxPtsDeviationNs() const noexcept { return maxPtsDeviationNs_; }
private:
    struct Entry { std::uint32_t offset,length; };
    AviOptions options_;
    std::unique_ptr<ExclusiveFile> file_;
    std::vector<Entry> index_;
    std::vector<std::uint8_t> header_;
    std::size_t moviSizeOffset_{},moviTypeOffset_{},totalFramesOffset_{},streamLengthOffset_{},mainBufferOffset_{},streamBufferOffset_{};
    std::uint64_t nameCounter_=0;
    std::string finalLeaf_,temporaryLeaf_;
    Publication publication_=Publication::Temporary;
    std::int64_t firstPts_=0,lastPts_=-1,maxPtsDeviationNs_=0;
    std::optional<std::uint64_t> lastSequence_;
    std::uint32_t largestPacket_=0;
    bool failed_=false;
};
// Scan this backend's recognizable .partial format into a NEW exclusive AVI.
// Original partial is read-only. Only fully written JPEG+timestamp pairs survive.
// No claim of arbitrary power-loss durability or generic third-party AVI repair.
std::size_t recoverPartial(const std::string& partialLeaf,AviOptions recoveredOptions,
                           std::string& recoveredFinalLeaf);
struct MatroskaOptions {
    std::string directory;
    std::string prefix="IQ4_LV_VFR";
    unsigned width{},height{};
    std::uint64_t maxFileBytes=1024ULL*1024*1024;
    std::size_t maxPacketBytes=32u*1024*1024;
    std::size_t maxFrames=100000;
    FileOps fileOps{};
};
// V_MJPEG, TimestampScale=1 ns, one keyframe Cluster per supplied packet.
// Preserves irregular PTS exactly relative to first packet, without a nominal
// FPS/DefaultDuration. Original absolute PTS/sequence remain in CRC'd Void data.
// Does not guess last-frame display duration or fabricate an audio track.
class MjpegMatroskaBackend final : public runtime::Backend {
public:
    explicit MjpegMatroskaBackend(MatroskaOptions options);
    ~MjpegMatroskaBackend() override;
    void prepare() override;
    void encode(const runtime::Frame& jpegPacket) override;
    void finalize() override;
    void abort() noexcept override;
    const std::string& finalLeaf() const noexcept { return finalLeaf_; }
    const std::string& temporaryLeaf() const noexcept { return temporaryLeaf_; }
    Publication publication() const noexcept { return publication_; }
    std::size_t packetCount() const noexcept { return count_; }
private:
    MatroskaOptions options_;
    std::unique_ptr<ExclusiveFile> file_;
    std::size_t segmentSizeOffset_=0,segmentStart_=0,count_=0;
    std::uint64_t nameCounter_=0;
    std::string finalLeaf_,temporaryLeaf_;
    Publication publication_=Publication::Temporary;
    std::int64_t firstPts_=0,lastPts_=-1;
    std::optional<std::uint64_t> lastSequence_;
    bool failed_=false;
};
std::size_t recoverMatroskaPartial(const std::string& partialLeaf,MatroskaOptions recoveredOptions,
                                   std::string& recoveredFinalLeaf);
} // namespace iq4::recording
