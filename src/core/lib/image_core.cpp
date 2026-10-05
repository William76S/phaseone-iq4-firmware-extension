#include "iq4/image_core.hpp"

#include <algorithm>
#include <atomic>
#include <cmath>
#include <fstream>
#include <limits>
#include <locale>
#include <sstream>

namespace iq4 {
namespace {
[[noreturn]] void fail(CubeError c, std::size_t line, const std::string& detail) {
    throw CubeParseError(c, line, detail);
}
bool finite(RGB v) { return std::isfinite(v.r) && std::isfinite(v.g) && std::isfinite(v.b); }
double clamp01(double n) { return std::max(0.0, std::min(1.0, n)); }
std::string_view trim(std::string_view s) {
    auto space = [](char c) { return c == ' ' || c == '\t' || c == '\r'; };
    while (!s.empty() && space(s.front())) s.remove_prefix(1);
    while (!s.empty() && space(s.back())) s.remove_suffix(1);
    return s;
}
std::string_view stripComment(std::string_view s) {
    bool quoted = false, escaped = false;
    for (std::size_t i = 0; i < s.size(); ++i) {
        if (escaped) { escaped = false; continue; }
        if (quoted && s[i] == '\\') { escaped = true; continue; }
        if (s[i] == '"') quoted = !quoted;
        else if (s[i] == '#' && !quoted) return s.substr(0, i);
    }
    return s;
}
std::vector<std::string_view> tokens(std::string_view s) {
    std::vector<std::string_view> out;
    while (!(s = trim(s)).empty()) {
        const auto end = s.find_first_of(" \t\r");
        if (end == std::string_view::npos) { out.push_back(s); break; }
        out.push_back(s.substr(0, end)); s.remove_prefix(end);
    }
    return out;
}
// Locale-independent lexical grammar: optional sign, decimal mantissa, exponent.
double number(std::string_view s, std::size_t line) {
    std::size_t i = 0, digits = 0;
    if (i < s.size() && (s[i] == '+' || s[i] == '-')) ++i;
    while (i < s.size() && s[i] >= '0' && s[i] <= '9') { ++i; ++digits; }
    if (i < s.size() && s[i] == '.') {
        ++i;
        while (i < s.size() && s[i] >= '0' && s[i] <= '9') { ++i; ++digits; }
    }
    if (digits == 0) fail(CubeError::InvalidNumber, line, "finite decimal expected");
    if (i < s.size() && (s[i] == 'e' || s[i] == 'E')) {
        ++i;
        if (i < s.size() && (s[i] == '+' || s[i] == '-')) ++i;
        const auto start = i;
        while (i < s.size() && s[i] >= '0' && s[i] <= '9') ++i;
        if (i == start) fail(CubeError::InvalidNumber, line, "incomplete exponent");
    }
    if (i != s.size()) fail(CubeError::InvalidNumber, line, "invalid decimal suffix");
    std::istringstream in{std::string(s)};
    in.imbue(std::locale::classic());
    double value{};
    if (!(in >> value) || !std::isfinite(value))
        fail(CubeError::InvalidNumber, line, "non-finite or out-of-range value");
    return value;
}
RGB triple(const std::vector<std::string_view>& t, std::size_t offset, std::size_t line) {
    if (t.size() != offset + 3) fail(CubeError::InvalidSyntax, line, "exactly three RGB values required");
    return {number(t[offset], line), number(t[offset + 1], line), number(t[offset + 2], line)};
}
bool keywordLike(std::string_view s) {
    // NaN/Inf are numeric errors; all other named entries are unsupported dialects.
    if (s == "NaN" || s == "nan" || s == "NAN" || s == "Inf" || s == "inf" || s == "INF") return false;
    return !s.empty() && ((s.front() >= 'A' && s.front() <= 'Z') || (s.front() >= 'a' && s.front() <= 'z'));
}
std::string parseTitle(std::string_view s, std::size_t line, std::size_t maxBytes) {
    s = trim(s);
    if (s.size() < 2 || s.front() != '"' || s.back() != '"')
        fail(CubeError::InvalidSyntax, line, "TITLE requires one quoted string");
    s.remove_prefix(1); s.remove_suffix(1);
    std::string out;
    for (std::size_t i = 0; i < s.size(); ++i) {
        const unsigned char ch = static_cast<unsigned char>(s[i]);
        if (ch < 32 || ch == 127 || ch == '"') fail(CubeError::InvalidSyntax, line, "invalid title character");
        if (ch == '\\') {
            if (++i == s.size() || (s[i] != '"' && s[i] != '\\'))
                fail(CubeError::InvalidSyntax, line, "unsupported title escape");
            out.push_back(s[i]);
        } else out.push_back(static_cast<char>(ch));
        if (out.size() > maxBytes) fail(CubeError::InvalidSyntax, line, "title length limit exceeded");
    }
    return out;
}
RGB mix(RGB a, RGB b, double t) {
    // Avoid b-a overflow for finite LUT values at opposite extremes.
    return {a.r * (1 - t) + b.r * t, a.g * (1 - t) + b.g * t, a.b * (1 - t) + b.b * t};
}
std::uint32_t roundedFraction(std::uint32_t n, std::uint32_t mul, std::uint32_t div) {
    const std::uint64_t product = std::uint64_t(n) * mul;
    return static_cast<std::uint32_t>((product + div / 2) / div);
}
bool validRect(Rect r) {
    return std::isfinite(r.x) && std::isfinite(r.y) && std::isfinite(r.width) && std::isfinite(r.height)
        && r.width > 0 && r.height > 0 && std::isfinite(r.x + r.width) && std::isfinite(r.y + r.height);
}
bool validMap(Affine m) {
    return std::isfinite(m.a) && std::isfinite(m.b) && std::isfinite(m.c) && std::isfinite(m.d)
        && std::isfinite(m.tx) && std::isfinite(m.ty) && std::isfinite(m.a * m.d - m.b * m.c)
        && m.a * m.d - m.b * m.c != 0;
}
std::vector<Point> clipPolygon(std::vector<Point> p, Rect r) {
    // Sutherland-Hodgman, including rotated frame edges and zoom/pan clipping.
    for (unsigned edge = 0; edge < 4 && !p.empty(); ++edge) {
        auto coord = [edge](Point v) { return edge < 2 ? v.x : v.y; };
        const double bound = edge == 0 ? r.x : edge == 1 ? r.x + r.width : edge == 2 ? r.y : r.y + r.height;
        auto inside = [&](Point v) { return edge == 0 || edge == 2 ? coord(v) >= bound : coord(v) <= bound; };
        std::vector<Point> out;
        Point previous = p.back(); bool previousInside = inside(previous);
        for (Point current : p) {
            const bool currentInside = inside(current);
            if (previousInside != currentInside) {
                const double t = (bound - coord(previous)) / (coord(current) - coord(previous));
                out.push_back({previous.x + t * (current.x - previous.x), previous.y + t * (current.y - previous.y)});
            }
            if (currentInside) out.push_back(current);
            previous = current; previousInside = currentInside;
        }
        p = std::move(out);
    }
    return p;
}
} // namespace

double RGB::operator[](std::size_t i) const {
    if (i > 2) throw std::out_of_range("RGB channel");
    return i == 0 ? r : i == 1 ? g : b;
}
CubeParseError::CubeParseError(CubeError c, std::size_t l, const std::string& d)
    : std::runtime_error("cube line " + std::to_string(l) + ": " + d), code_(c), line_(l) {}

CubeLut CubeLut::parse(std::string_view text, CubeLimits limits) {
    if (text.size() > limits.maxFileBytes) fail(CubeError::FileTooLarge, 0, "file length limit exceeded");
    if (text.size() >= 3 && text.substr(0, 3) == "\xef\xbb\xbf") text.remove_prefix(3);
    CubeLut lut;
    bool seenSize = false, seenTitle = false, seenMin = false, seenMax = false, dataStarted = false;
    std::size_t line = 0, expected = 0;
    while (!text.empty()) {
        ++line;
        const auto end = text.find('\n');
        auto raw = text.substr(0, end);
        if (raw.size() > limits.maxLineBytes) fail(CubeError::LineTooLong, line, "line length limit exceeded");
        if (raw.find('\0') != std::string_view::npos) fail(CubeError::InvalidSyntax, line, "NUL byte forbidden");
        text = end == std::string_view::npos ? std::string_view{} : text.substr(end + 1);
        const auto clean = trim(stripComment(raw));
        if (clean.empty()) continue;
        const auto t = tokens(clean); const auto key = t.front();
        if (key == "TITLE" || key == "LUT_3D_SIZE" || key == "DOMAIN_MIN" || key == "DOMAIN_MAX") {
            bool* seen = key == "TITLE" ? &seenTitle : key == "LUT_3D_SIZE" ? &seenSize : key == "DOMAIN_MIN" ? &seenMin : &seenMax;
            if (*seen) fail(CubeError::DuplicateKeyword, line, "duplicate " + std::string(key));
            if (dataStarted) fail(CubeError::InvalidSyntax, line, "header after table data");
            *seen = true;
            if (key == "TITLE") {
                lut.title_ = parseTitle(clean.substr(5), line, limits.maxTitleBytes);
            } else if (key == "LUT_3D_SIZE") {
                if (t.size() != 2 || t[1].empty() || t[1].find_first_not_of("0123456789") != std::string_view::npos)
                    fail(CubeError::InvalidGrid, line, "integer grid size required");
                // Avoid unbounded integer parsing and allocation before validation.
                if (t[1].size() > 2) fail(CubeError::InvalidGrid, line, "grid size outside 2..65");
                unsigned n = 0; for (char c : t[1]) n = n * 10 + unsigned(c - '0');
                if (n < 2 || n > 65) fail(CubeError::InvalidGrid, line, "grid size outside 2..65");
                lut.size_ = n; expected = std::size_t(n) * n * n; lut.table_.reserve(expected);
            } else if (key == "DOMAIN_MIN") lut.min_ = triple(t, 1, line);
            else lut.max_ = triple(t, 1, line);
        } else {
            if (keywordLike(key)) fail(CubeError::UnsupportedDialect, line, "unsupported LUT type or dialect: " + std::string(key));
            if (!seenSize) fail(CubeError::InvalidSyntax, line, "LUT_3D_SIZE must precede data");
            if (lut.table_.size() == expected) fail(CubeError::InvalidCount, line, "extra table data");
            lut.table_.push_back(triple(t, 0, line)); dataStarted = true;
        }
    }
    if (!seenSize) fail(CubeError::InvalidGrid, line, "missing LUT_3D_SIZE");
    for (std::size_t c = 0; c < 3; ++c) {
        const double span = lut.max_[c] - lut.min_[c];
        if (!(lut.max_[c] > lut.min_[c]) || !std::isfinite(span))
            fail(CubeError::InvalidDomain, line, "each finite domain max must exceed min without span overflow");
    }
    if (lut.table_.size() != expected) fail(CubeError::InvalidCount, line, "table requires exactly N cubed triples");
    return lut;
}

CubeLut CubeLut::fromFile(const std::string& path, CubeLimits limits) {
    if (path.size() > 4096 || path.find('\0') != std::string::npos) throw std::invalid_argument("invalid LUT path");
    std::ifstream input(path, std::ios::binary);
    if (!input) throw std::runtime_error("cannot open LUT file");
    std::string text; char buffer[8192];
    while (input) {
        input.read(buffer, sizeof(buffer)); const auto count = static_cast<std::size_t>(input.gcount());
        if (text.size() > limits.maxFileBytes || count > limits.maxFileBytes - text.size())
            fail(CubeError::FileTooLarge, 0, "file length limit exceeded");
        text.append(buffer, count);
    }
    if (!input.eof()) throw std::runtime_error("LUT read failed");
    return parse(text, limits);
}

RGB CubeLut::evaluate(RGB rgb) const {
    if (!finite(rgb)) throw std::invalid_argument("non-finite input RGB");
    std::array<unsigned, 3> lo{}, hi{}; std::array<double, 3> fraction{};
    for (std::size_t c = 0; c < 3; ++c) {
        // Clamp BEFORE subtraction so extreme finite input cannot overflow.
        const double x = std::max(min_[c], std::min(max_[c], rgb[c]));
        const double v = (x - min_[c]) / (max_[c] - min_[c]) * (size_ - 1);
        lo[c] = static_cast<unsigned>(std::floor(v)); hi[c] = std::min(lo[c] + 1, size_ - 1);
        fraction[c] = v - lo[c];
    }
    auto at = [&](unsigned r, unsigned g, unsigned b) { return table_[r + size_ * (g + size_ * b)]; };
    const RGB z0 = mix(mix(at(lo[0], lo[1], lo[2]), at(hi[0], lo[1], lo[2]), fraction[0]),
                       mix(at(lo[0], hi[1], lo[2]), at(hi[0], hi[1], lo[2]), fraction[0]), fraction[1]);
    const RGB z1 = mix(mix(at(lo[0], lo[1], hi[2]), at(hi[0], lo[1], hi[2]), fraction[0]),
                       mix(at(lo[0], hi[1], hi[2]), at(hi[0], hi[1], hi[2]), fraction[0]), fraction[1]);
    return mix(z0, z1, fraction[2]);
}

RGB JpegLutConfig::apply(RGB rgb) const {
    if (!finite(rgb)) throw std::invalid_argument("non-finite input RGB");
    if (!std::isfinite(strength) || strength < 0 || strength > 1) throw std::invalid_argument("LUT strength outside [0,1]");
    if (!enabled || !selected || strength == 0) return rgb;
    return mix(rgb, selected->evaluate(rgb), strength);
}
JpegLutStore::JpegLutStore() : current_(std::make_shared<const JpegLutConfig>()) {}
std::shared_ptr<const JpegLutConfig> JpegLutStore::snapshot() const noexcept { return std::atomic_load(&current_); }
void JpegLutStore::publish(const JpegLutConfig& config) { std::atomic_store(&current_, std::make_shared<const JpegLutConfig>(config)); }
void JpegLutStore::select(std::shared_ptr<const CubeLut> lut) {
    std::lock_guard<std::mutex> guard(writer_); auto next = *snapshot();
    next.selected = std::move(lut); ++next.generation; publish(next);
}
void JpegLutStore::importAndSelect(std::string_view text, CubeLimits limits) { select(std::make_shared<const CubeLut>(CubeLut::parse(text, limits))); }
void JpegLutStore::importAndSelectFile(const std::string& path, CubeLimits limits) { select(std::make_shared<const CubeLut>(CubeLut::fromFile(path, limits))); }
void JpegLutStore::setEnabled(bool enabled) {
    std::lock_guard<std::mutex> guard(writer_); auto next = *snapshot(); next.enabled = enabled; ++next.generation; publish(next);
}
void JpegLutStore::setStrength(double strength) {
    if (!std::isfinite(strength) || strength < 0 || strength > 1) throw std::invalid_argument("LUT strength outside [0,1]");
    std::lock_guard<std::mutex> guard(writer_); auto next = *snapshot(); next.strength = strength; ++next.generation; publish(next);
}
void JpegLutStore::clearSelection() {
    std::lock_guard<std::mutex> guard(writer_); auto next = *snapshot(); next.selected.reset(); next.enabled = false; ++next.generation; publish(next);
}
std::array<std::uint8_t, 3> quantizeSrgb8(RGB rgb) {
    if (!finite(rgb)) throw std::invalid_argument("non-finite output RGB");
    return {static_cast<std::uint8_t>(std::floor(clamp01(rgb.r) * 255 + .5)),
            static_cast<std::uint8_t>(std::floor(clamp01(rgb.g) * 255 + .5)),
            static_cast<std::uint8_t>(std::floor(clamp01(rgb.b) * 255 + .5))};
}

SizeResult jpegSize(PixelSize source, JpegSizeMode mode, bool needsEven) {
    if (!source.width || !source.height) return {false, {}, false, "invalid full RAW dimensions"};
    PixelSize out = source;
    switch (mode) {
    case JpegSizeMode::Native: break;
    case JpegSizeMode::Percent75: case JpegSizeMode::Percent50: case JpegSizeMode::Percent25: {
        const unsigned numerator = mode == JpegSizeMode::Percent75 ? 3 : mode == JpegSizeMode::Percent50 ? 2 : 1;
        out = {std::max(1u, roundedFraction(source.width, numerator, 4)), std::max(1u, roundedFraction(source.height, numerator, 4))};
        break;
    }
    case JpegSizeMode::Long3840: case JpegSizeMode::Long7680: {
        const unsigned target = mode == JpegSizeMode::Long3840 ? 3840 : 7680;
        const unsigned longEdge = std::max(source.width, source.height);
        if (longEdge < target) return {false, {}, false, "source long edge below requested pixels; upscaling prohibited"};
        if (source.width >= source.height) out = {target, std::max(1u, roundedFraction(source.height, target, longEdge))};
        else out = {std::max(1u, roundedFraction(source.width, target, longEdge)), target};
        break;
    }
    default: return {false, {}, false, "unknown JPEG size mode"};
    }
    bool adjusted = false;
    if (needsEven) {
        if (out.width < 2 || out.height < 2) return {false, {}, false, "encoder requires at least two pixels per axis"};
        adjusted = out.width % 2 || out.height % 2;
        out.width -= out.width % 2; out.height -= out.height % 2;
    }
    return {true, out, adjusted, adjusted ? "rounded down one pixel on odd axes for verified encoder constraint" : ""};
}

Point Affine::map(Point p) const { return {a * p.x + c * p.y + tx, b * p.x + d * p.y + ty}; }
MaskGeometry maskGeometry(Rect source, Rect viewport, Affine m, MaskMode mode, bool known, bool focusZoom) {
    MaskGeometry out; out.displayViewport = viewport;
    if (mode == MaskMode::Off) { out.hidden = MaskHidden::Disabled; return out; }
    if (!known) { out.hidden = MaskHidden::SourceCoordinatesUnavailable; return out; }
    (void)focusZoom; // Known zoom coordinates use the full-source frame; no re-framing.
    if (!validRect(source) || !validRect(viewport) || !validMap(m)) { out.hidden = MaskHidden::InvalidGeometry; return out; }
    double ratio;
    switch (mode) {
    case MaskMode::XPan65_24: ratio = 65.0 / 24.0; break;
    case MaskMode::Ratio16_9: ratio = 16.0 / 9.0; break;
    case MaskMode::Ratio3_2: ratio = 3.0 / 2.0; break;
    case MaskMode::Ratio1_1: ratio = 1; break;
    default: out.hidden = MaskHidden::InvalidGeometry; return out;
    }
    const double width = std::min(source.width, source.height * ratio), height = width / ratio;
    out.sourceFrame = {source.x + (source.width - width) / 2, source.y + (source.height - height) / 2, width, height};
    const auto f = out.sourceFrame;
    out.displayFrame = {m.map({f.x, f.y}), m.map({f.x + f.width, f.y}), m.map({f.x + f.width, f.y + f.height}), m.map({f.x, f.y + f.height})};
    for (auto p : out.displayFrame) if (!std::isfinite(p.x) || !std::isfinite(p.y)) { out.hidden = MaskHidden::InvalidGeometry; return out; }
    out.clippedDisplayFrame = clipPolygon({out.displayFrame.begin(), out.displayFrame.end()}, viewport);
    for (auto p : out.clippedDisplayFrame) {
        // Reject pathological arithmetic instead of exposing non-finite vertices
        // to a target renderer. Ordinary boundary roundoff has a pixel-scaled tolerance.
        const double epsilon = 1e-9 * std::max(viewport.width, viewport.height);
        if (!std::isfinite(p.x) || !std::isfinite(p.y) || p.x < viewport.x - epsilon || p.x > viewport.x + viewport.width + epsilon
            || p.y < viewport.y - epsilon || p.y > viewport.y + viewport.height + epsilon) {
            out.clippedDisplayFrame.clear(); out.hidden = MaskHidden::InvalidGeometry; return out;
        }
    }
    out.visible = true; return out;
}
} // namespace iq4
