#pragma once

#include "iq4/image_core.hpp"

#include <vector>

namespace iq4::display {

// Display-only geometry. There is deliberately no image/pixel/buffer argument.
struct ViewMapping {
    Rect fullSource;
    Rect imageViewport;
    Affine sourceToDisplay;
    bool fullSourceMappingKnown = false;
    bool focusZoom = false;
};
struct MaskConfig {
    MaskMode mode = MaskMode::Off;
    double opacity = .65;
    bool boundary = false;
};
struct Fill {
    std::vector<Point> convexPolygon;
    double blackOpacity{};
};
struct Boundary {
    Point from, to;
    double width = 1;
};
struct DrawPlan {
    MaskHidden hidden = MaskHidden::Disabled;
    Rect imageClip{};
    Rect sourceFrame{};
    std::vector<Fill> fills;
    std::vector<Boundary> boundaries;
    bool hasCommands() const noexcept { return !fills.empty() || !boundaries.empty(); }
};

// Four NON-OVERLAPPING full-source outside bands are transformed, then clipped
// to imageViewport. Source proportions are never inferred from display buffers.
DrawPlan makeDrawPlan(const ViewMapping& mapping, const MaskConfig& config);

// Target adapters must draw in the DISPLAY COMPOSITOR overlay surface only.
// Every command carries the image clip, including stroke-width clipping.
// The compositor supplies a fresh/cleared overlay for each render; empty plans
// mean no overlay on that render. It must tear down a retained layer on exit.
// This interface has no RAW/JPEG/LV input pixels and no capture/export method.
// It cannot validate that an eventual vendor adapter obeys the surface contract.
class DisplayCanvas {
public:
    virtual ~DisplayCanvas() = default;
    virtual void fillConvexBlack(const std::vector<Point>& polygon, double opacity,
                                 Rect imageClip) = 0;
    virtual void strokeWhiteSegment(Point from, Point to, double width,
                                    Rect imageClip) = 0;
};
void draw(DisplayCanvas& canvas, const DrawPlan& plan);

// Single-executor, page-local controls only. No file writes, camera properties,
// persistent configuration or UI ABI assumptions. Destroy/recreate defaults Off.
class TemporaryMask {
public:
    const MaskConfig& config() const noexcept { return config_; }
    void select(MaskMode mode);
    void setOpacity(double opacity);
    void setBoundary(bool enabled) noexcept { config_.boundary = enabled; }
    DrawPlan plan(const ViewMapping& mapping) const { return makeDrawPlan(mapping, config_); }
    // Stop producing overlay commands; the target compositor must remove its
    // prior layer on the next repaint, then return to the original page.
    void exitToFactory() noexcept { config_ = MaskConfig{}; }
private:
    MaskConfig config_{};
};

} // namespace iq4::display
