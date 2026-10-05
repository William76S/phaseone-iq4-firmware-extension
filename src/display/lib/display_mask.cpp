#include "iq4/display_mask.hpp"

#include <algorithm>
#include <cmath>
#include <stdexcept>

namespace iq4::display {
namespace {
bool validMode(MaskMode mode) {
    return mode == MaskMode::Off || mode == MaskMode::XPan65_24 || mode == MaskMode::Ratio16_9
        || mode == MaskMode::Ratio3_2 || mode == MaskMode::Ratio1_1;
}
bool finite(Point p) { return std::isfinite(p.x) && std::isfinite(p.y); }
std::vector<Point> clip(std::vector<Point> input, Rect viewport) {
    for (unsigned edge = 0; edge < 4 && !input.empty(); ++edge) {
        auto coordinate = [edge](Point p) { return edge < 2 ? p.x : p.y; };
        const double boundary = edge == 0 ? viewport.x : edge == 1 ? viewport.x + viewport.width
            : edge == 2 ? viewport.y : viewport.y + viewport.height;
        auto inside = [&](Point p) { return edge == 0 || edge == 2 ? coordinate(p) >= boundary : coordinate(p) <= boundary; };
        std::vector<Point> result;
        Point previous = input.back(); bool previousInside = inside(previous);
        for (const auto current : input) {
            const bool currentInside = inside(current);
            if (currentInside != previousInside) {
                const double fraction = (boundary - coordinate(previous)) / (coordinate(current) - coordinate(previous));
                auto intersection = Point{previous.x * (1 - fraction) + current.x * fraction,
                                          previous.y * (1 - fraction) + current.y * fraction};
                if (edge < 2) intersection.x = boundary; else intersection.y = boundary;
                result.push_back(intersection);
            }
            if (currentInside) result.push_back(current);
            previous = current; previousInside = currentInside;
        }
        input = std::move(result);
    }
    // A clip through an existing vertex can append both the intersection and
    // that same vertex. Remove zero-length edges before sending convex geometry
    // to the compositor (or a strict rasterizer would reject the entire shape).
    std::vector<Point> compact;
    for (auto point : input) {
        if (compact.empty() || point.x != compact.back().x || point.y != compact.back().y) compact.push_back(point);
    }
    if (compact.size() > 1 && compact.front().x == compact.back().x && compact.front().y == compact.back().y) compact.pop_back();
    return compact;
}
double signedArea(const std::vector<Point>& polygon) {
    // Translate to the first vertex to reduce cancellation for offset viewports.
    if (polygon.size() < 3) return 0;
    const auto origin = polygon.front(); double area = 0;
    for (std::size_t i = 1; i + 1 < polygon.size(); ++i) {
        area += (polygon[i].x - origin.x) * (polygon[i+1].y - origin.y)
            - (polygon[i].y - origin.y) * (polygon[i+1].x - origin.x);
    }
    return area / 2;
}
bool within(Point p, Rect v) {
    const double epsilon = 1e-9 * std::max(v.width, v.height);
    return finite(p) && p.x >= v.x - epsilon && p.x <= v.x + v.width + epsilon
        && p.y >= v.y - epsilon && p.y <= v.y + v.height + epsilon;
}
bool clipSegment(Point& a, Point& b, Rect v) {
    // Liang-Barsky; true only if part of this original edge is visible. No
    // substitute rectangle is created at crop/viewport boundaries.
    const double dx = b.x - a.x, dy = b.y - a.y;
    if (!std::isfinite(dx) || !std::isfinite(dy)) return false;
    const double p[] = {-dx, dx, -dy, dy};
    const double q[] = {a.x - v.x, v.x + v.width - a.x, a.y - v.y, v.y + v.height - a.y};
    double enter = 0, exit = 1;
    for (unsigned i = 0; i < 4; ++i) {
        if (p[i] == 0) { if (q[i] < 0) return false; continue; }
        const double t = q[i] / p[i];
        if (p[i] < 0) enter = std::max(enter, t); else exit = std::min(exit, t);
        if (enter > exit) return false;
    }
    const auto origin = a;
    a = {origin.x + enter * dx, origin.y + enter * dy};
    b = {origin.x + exit * dx, origin.y + exit * dy};
    return within(a, v) && within(b, v) && (a.x != b.x || a.y != b.y);
}
} // namespace

DrawPlan makeDrawPlan(const ViewMapping& mapping, const MaskConfig& config) {
    if (!validMode(config.mode) || !std::isfinite(config.opacity) || config.opacity < 0 || config.opacity > 1)
        throw std::invalid_argument("invalid temporary mask configuration");
    DrawPlan plan; plan.imageClip = mapping.imageViewport;
    const auto geometry = maskGeometry(mapping.fullSource, mapping.imageViewport, mapping.sourceToDisplay,
                                       config.mode, mapping.fullSourceMappingKnown, mapping.focusZoom);
    plan.hidden = geometry.hidden;
    if (!geometry.visible) return plan;
    plan.sourceFrame = geometry.sourceFrame;
    const auto s = mapping.fullSource; const auto f = geometry.sourceFrame;
    const Rect bands[] = {
        {s.x, s.y, s.width, f.y - s.y},
        {s.x, f.y + f.height, s.width, s.y + s.height - f.y - f.height},
        {s.x, f.y, f.x - s.x, f.height},
        {f.x + f.width, f.y, s.x + s.width - f.x - f.width, f.height}
    };
    for (const auto band : bands) {
        if (band.width <= 0 || band.height <= 0 || config.opacity == 0) continue;
        std::vector<Point> polygon = {
            mapping.sourceToDisplay.map({band.x, band.y}),
            mapping.sourceToDisplay.map({band.x + band.width, band.y}),
            mapping.sourceToDisplay.map({band.x + band.width, band.y + band.height}),
            mapping.sourceToDisplay.map({band.x, band.y + band.height})
        };
        for (auto point : polygon) if (!finite(point)) {
            plan.fills.clear(); plan.boundaries.clear(); plan.hidden = MaskHidden::InvalidGeometry; return plan;
        }
        polygon = clip(std::move(polygon), mapping.imageViewport);
        for (auto point : polygon) if (!within(point, mapping.imageViewport)) {
            plan.fills.clear(); plan.boundaries.clear(); plan.hidden = MaskHidden::InvalidGeometry; return plan;
        }
        const auto area = signedArea(polygon);
        if (!std::isfinite(area)) { plan.fills.clear(); plan.hidden = MaskHidden::InvalidGeometry; return plan; }
        if (area == 0) continue;
        if (area < 0) std::reverse(polygon.begin(), polygon.end());
        plan.fills.push_back({std::move(polygon), config.opacity});
    }
    if (config.boundary) {
        for (unsigned i = 0; i < 4; ++i) {
            auto from = geometry.displayFrame[i], to = geometry.displayFrame[(i+1) % 4];
            if (clipSegment(from, to, mapping.imageViewport)) plan.boundaries.push_back({from, to, 1});
        }
    }
    return plan;
}

void draw(DisplayCanvas& canvas, const DrawPlan& plan) {
    // Hidden plans have no commands even if a caller manually populated vectors.
    if (plan.hidden != MaskHidden::None) return;
    for (const auto& fill : plan.fills) canvas.fillConvexBlack(fill.convexPolygon, fill.blackOpacity, plan.imageClip);
    for (const auto& boundary : plan.boundaries) canvas.strokeWhiteSegment(boundary.from, boundary.to, boundary.width, plan.imageClip);
}
void TemporaryMask::select(MaskMode mode) {
    if (!validMode(mode)) throw std::invalid_argument("invalid temporary mask mode");
    config_.mode = mode;
}
void TemporaryMask::setOpacity(double opacity) {
    if (!std::isfinite(opacity) || opacity < 0 || opacity > 1) throw std::invalid_argument("mask opacity outside [0,1]");
    config_.opacity = opacity;
}
} // namespace iq4::display
