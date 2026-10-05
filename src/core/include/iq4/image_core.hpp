#pragma once

#include <array>
#include <cstdint>
#include <memory>
#include <mutex>
#include <stdexcept>
#include <string>
#include <string_view>
#include <vector>

namespace iq4 {

// Values at this boundary are nonlinear sRGB RGB, with no implicit gamma transform.
struct RGB {
    double r{}, g{}, b{};
    double operator[](std::size_t i) const;
};

enum class CubeError {
    FileTooLarge, LineTooLong, InvalidSyntax, UnsupportedDialect,
    DuplicateKeyword, InvalidGrid, InvalidNumber, InvalidDomain, InvalidCount
};
class CubeParseError : public std::runtime_error {
public:
    CubeParseError(CubeError code, std::size_t line, const std::string& detail);
    CubeError code() const noexcept { return code_; }
    std::size_t line() const noexcept { return line_; }
private:
    CubeError code_;
    std::size_t line_;
};

struct CubeLimits {
    std::size_t maxFileBytes = 32u * 1024u * 1024u;
    std::size_t maxLineBytes = 4096;
    std::size_t maxTitleBytes = 256;
};

// Immutable after construction; index = r + N * (g + N * b), red varies fastest.
class CubeLut {
public:
    static CubeLut parse(std::string_view text, CubeLimits limits = {});
    static CubeLut fromFile(const std::string& path, CubeLimits limits = {});
    RGB evaluate(RGB nonlinearSrgb) const;
    unsigned size() const noexcept { return size_; }
    const std::string& title() const noexcept { return title_; }
    RGB domainMin() const noexcept { return min_; }
    RGB domainMax() const noexcept { return max_; }
    std::size_t tableBytes() const noexcept { return table_.size() * sizeof(RGB); }
private:
    CubeLut() = default;
    unsigned size_{};
    std::string title_;
    RGB min_{0, 0, 0}, max_{1, 1, 1};
    std::vector<RGB> table_;
};

struct JpegLutConfig {
    std::shared_ptr<const CubeLut> selected;
    bool enabled = false;
    double strength = 1.0; // [0,1], numerical RGB mixture in nonlinear sRGB.
    std::uint64_t generation = 0;
    RGB apply(RGB nonlinearSrgb) const;
};

// Parse outside the lock, then publish a complete immutable configuration.
// Invalid imports/settings leave the current configuration unchanged.
// A JPEG job takes one snapshot for its entire export, never once per pixel.
class JpegLutStore {
public:
    JpegLutStore();
    std::shared_ptr<const JpegLutConfig> snapshot() const noexcept;
    void importAndSelect(std::string_view text, CubeLimits limits = {});
    void importAndSelectFile(const std::string& path, CubeLimits limits = {});
    void setEnabled(bool enabled);
    void setStrength(double strength);
    void clearSelection();
private:
    void select(std::shared_ptr<const CubeLut> lut);
    void publish(const JpegLutConfig& next);
    std::shared_ptr<const JpegLutConfig> current_;
    std::mutex writer_;
};

// Final JPEG quantization clamps LUT overshoots only here, not at interpolation.
std::array<std::uint8_t, 3> quantizeSrgb8(RGB value);

enum class JpegSizeMode { Native, Percent75, Percent50, Percent25, Long3840, Long7680 };
struct PixelSize { std::uint32_t width{}, height{}; };
struct SizeResult {
    bool available = false;
    PixelSize pixels{};
    bool encoderAdjusted = false;
    std::string reason;
};
// Full valid RAW source dimensions, not thumbnail dimensions. Half-up rounding.
// Long-edge modes are disabled if the source is shorter than the requested edge.
SizeResult jpegSize(PixelSize source, JpegSizeMode mode, bool encoderNeedsEven = false);

struct Point { double x{}, y{}; };
struct Rect { double x{}, y{}, width{}, height{}; };
struct Affine {
    // [ a c tx; b d ty; 0 0 1 ] maps full source coordinates to display pixels.
    double a = 1, b = 0, c = 0, d = 1, tx = 0, ty = 0;
    Point map(Point p) const;
};
enum class MaskMode { Off, XPan65_24, Ratio16_9, Ratio3_2, Ratio1_1 };
enum class MaskHidden { None, Disabled, SourceCoordinatesUnavailable, InvalidGeometry };
struct MaskGeometry {
    bool visible = false;
    MaskHidden hidden = MaskHidden::None;
    Rect sourceFrame{};
    // Clockwise in source coordinates; display rotation is retained by the polygon.
    std::array<Point, 4> displayFrame{};
    std::vector<Point> clippedDisplayFrame;
    Rect displayViewport{};
};
// The target frame is always based on the full sensor/effective-source bounds.
// Crop, zoom, pan and orientation are expressed by the SAME source-to-display map.
// Unknown full-source coordinates hide the mask (including focus zoom).
MaskGeometry maskGeometry(Rect fullSource, Rect imageViewport, Affine sourceToDisplay,
                          MaskMode mode, bool fullSourceMappingKnown, bool focusZoom);

} // namespace iq4
