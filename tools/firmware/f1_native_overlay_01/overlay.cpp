#include "overlay.hpp"
#include <algorithm>
#include <cmath>
#include <cstring>
#include <limits>

namespace iq4::f1::native_overlay {
namespace {
bool valid_mode(MaskMode m) noexcept{return m==MaskMode::Off||m==MaskMode::XPan65_24||m==MaskMode::Ratio16_9||m==MaskMode::Ratio3_2||m==MaskMode::Ratio1_1;}
bool positive(const Rectangle24& r) noexcept {
    return r.width>0&&r.height>0&&static_cast<std::int64_t>(r.x)+r.width<=std::numeric_limits<std::int32_t>::max()&&static_cast<std::int64_t>(r.y)+r.height<=std::numeric_limits<std::int32_t>::max();
}
bool positive(const PixelRect& r) noexcept{return positive({0,r.x,r.y,r.width,r.height});}
bool raster(double left,double top,double right,double bottom,PixelRect& r) noexcept {
    if(!std::isfinite(left)||!std::isfinite(top)||!std::isfinite(right)||!std::isfinite(bottom)||right<left||bottom<top)return false;
    // Pixel-center coverage: half-open bounds become ceil(edge-.5). Shared
    // band edges use the same conversion, avoiding repeated alpha blending.
    const double l=std::ceil(left-.5),t=std::ceil(top-.5),rr=std::ceil(right-.5),bb=std::ceil(bottom-.5);
    constexpr auto min=std::numeric_limits<std::int32_t>::min(),max=std::numeric_limits<std::int32_t>::max();
    if(l<min||t<min||rr>max||bb>max||rr-l>max||bb-t>max)return false;
    r={static_cast<std::int32_t>(l),static_cast<std::int32_t>(t),static_cast<std::int32_t>(rr-l),static_cast<std::int32_t>(bb-t)};return true;
}
bool intersect(PixelRect a,PixelRect b,PixelRect& out) noexcept {
    if(!positive(a)||!positive(b))return false;
    const std::int64_t x=std::max(a.x,b.x),y=std::max(a.y,b.y),right=std::min(static_cast<std::int64_t>(a.x)+a.width,static_cast<std::int64_t>(b.x)+b.width),bottom=std::min(static_cast<std::int64_t>(a.y)+a.height,static_cast<std::int64_t>(b.y)+b.height);
    if(right<=x||bottom<=y)return false;
    out={static_cast<std::int32_t>(x),static_cast<std::int32_t>(y),static_cast<std::int32_t>(right-x),static_cast<std::int32_t>(bottom-y)};return true;
}
bool contains(PixelRect a,PixelRect b) noexcept {
    return positive(a)&&positive(b)&&b.x>=a.x&&b.y>=a.y&&static_cast<std::int64_t>(b.x)+b.width<=static_cast<std::int64_t>(a.x)+a.width&&static_cast<std::int64_t>(b.y)+b.height<=static_cast<std::int64_t>(a.y)+a.height;
}
bool unite(PixelRect a,PixelRect b,PixelRect& out) noexcept {
    if(!positive(a)){out=b;return !b.width||positive(b);}if(!positive(b)){out=a;return true;}
    const std::int64_t x=std::min(a.x,b.x),y=std::min(a.y,b.y),right=std::max(static_cast<std::int64_t>(a.x)+a.width,static_cast<std::int64_t>(b.x)+b.width),bottom=std::max(static_cast<std::int64_t>(a.y)+a.height,static_cast<std::int64_t>(b.y)+b.height);
    if(right-x>std::numeric_limits<std::int32_t>::max()||bottom-y>std::numeric_limits<std::int32_t>::max())return false;
    out={static_cast<std::int32_t>(x),static_cast<std::int32_t>(y),static_cast<std::int32_t>(right-x),static_cast<std::int32_t>(bottom-y)};return true;
}
}
bool fixed_plan(const display::DrawPlan& input,FixedPlan& out) noexcept {
    out={};out.hidden=input.hidden;
    if(input.hidden!=MaskHidden::None){
        if(input.hasCommands())return false;
        PixelRect clip{};if(raster(input.imageClip.x,input.imageClip.y,input.imageClip.x+input.imageClip.width,input.imageClip.y+input.imageClip.height,clip)&&positive(clip))out.image_clip=clip;
        return true;
    }
    if(!input.boundaries.empty()||input.fills.size()>4||!raster(input.imageClip.x,input.imageClip.y,input.imageClip.x+input.imageClip.width,input.imageClip.y+input.imageClip.height,out.image_clip)||!positive(out.image_clip))return false;
    bool alpha_set=false;
    for(const auto& fill:input.fills){
        if(fill.convexPolygon.size()!=4||!std::isfinite(fill.blackOpacity)||fill.blackOpacity<=0||fill.blackOpacity>1)return false;
        double l=fill.convexPolygon[0].x,r=l,t=fill.convexPolygon[0].y,b=t;
        for(auto p:fill.convexPolygon){if(!std::isfinite(p.x)||!std::isfinite(p.y))return false;l=std::min(l,p.x);r=std::max(r,p.x);t=std::min(t,p.y);b=std::max(b,p.y);}
        unsigned corners=0;
        // Only exact axis-aligned corners are admitted. An epsilon test could
        // accept a real shear and move a half-open pixel-center crop boundary.
        for(auto p:fill.convexPolygon){
            const bool left=p.x==l,right=p.x==r,top=p.y==t,bottom=p.y==b;
            if((left==right)||(top==bottom))return false;
            const unsigned corner=(right?1:0)|(bottom?2:0);if(corners&(1u<<corner))return false;corners|=1u<<corner;
        }
        if(corners!=15)return false;
        PixelRect band;if(!raster(l,t,r,b,band))return false;if(!band.width||!band.height)continue;
        if(!contains(out.image_clip,band))return false;
        const auto alpha=static_cast<std::uint8_t>(std::lround(fill.blackOpacity*255));
        if(!alpha)continue;if(alpha_set&&out.alpha!=alpha)return false;out.alpha=alpha;alpha_set=true;
        for(std::size_t i=0;i<out.count;++i){PixelRect overlap;if(intersect(out.bands[i],band,overlap))return false;}
        out.bands[out.count++]=band;
    }
    return true;
}
bool candidate_native_blit(const PaintObservation& p) noexcept{return p.original_returned_normally&&!p.pre_original_countdown&&positive(p.original_return);}
bool Adapter::configure(Memory m,Native n,Gate g) noexcept {
#if !defined(IQ4_F1_OVERLAY_SYNTHETIC_HOST)
    (void)m;(void)n;(void)g;return false;
#else
    if(configured_||!m.read||!n.fill||!n.current_thread||!n.request_stock_repaint||!g.actual_UserSHA||std::strcmp(g.actual_UserSHA,UserSHA)||!g.ui_owner||!g.LV||!g.actual_pitch||!g.actual_height||g.actual_pitch>4096||g.actual_height>4096||
      !g.actual_whole_User_and_segments||!g.actual_UI_owner_boundary||!g.actual_LV_paint_ABI||!g.actual_display_surface_owner_and_extent||!g.actual_source_geometry_and_image_viewport||!g.actual_original_blit_receipt||!g.actual_original_repaint_and_disable_restore||!g.actual_callback_lifetime)return false;
    memory_=m;native_=n;gate_=g;configured_=true;status_.phase=Phase::OffAwaitingRepaint;return true;
#endif
}
bool Adapter::on_ui() const noexcept{return configured_&&native_.current_thread&&native_.current_thread(native_.context)==gate_.ui_owner;}
void Adapter::hold() noexcept{status_.phase=Phase::Hold;}
Result Adapter::select_on_ui(MaskMode mode,const display::ViewMapping& mapping,std::uint64_t epoch) noexcept {
    if(!configured_)return Result::Disabled;if(!on_ui())return Result::WrongThread;
    if(in_paint_||disabling_||status_.phase==Phase::Hold||status_.phase==Phase::FactoryRestored||!valid_mode(mode)||!epoch||status_.generation==std::numeric_limits<std::uint64_t>::max())return Result::Rejected;
    try{
        display::TemporaryMask next=mask_;next.select(mode);FixedPlan next_plan;
        if(!fixed_plan(next.plan(mapping),next_plan)){++status_.rejected;return Result::Rejected;}
        PixelRect needed{};if(!unite(required_clean_,next_plan.image_clip,needed)){++status_.rejected;return Result::Rejected;}
        mask_=next;plan_=next_plan;required_clean_=needed;geometry_epoch_=epoch;++status_.generation;status_.mode=mode;status_.factory_repaint_confirmed=false;
        status_.phase=mode==MaskMode::Off?Phase::OffAwaitingRepaint:Phase::MaskAwaitingRepaint;
        if(!native_.request_stock_repaint(native_.context,gate_.LV)){hold();return Result::Hold;}
        return Result::Pending;
    }catch(...){hold();return Result::Hold;}
}
bool Adapter::surface_valid(const Receipt& r,Rectangle24& bounds) const noexcept {
    if(!r.surface||r.surface>std::numeric_limits<Address>::max()-0x38||gate_.load_bias>std::numeric_limits<Address>::max()-0xb7b7d8)return false;
    std::array<unsigned char,0x38> bytes{};
    if(!memory_.read(memory_.context,r.surface,bytes.data(),bytes.size()))return false;
    Address v=0,draw=0;std::int32_t pitch=0,height=0;
    std::memcpy(&v,bytes.data(),8);std::memcpy(&draw,bytes.data()+8,8);std::memcpy(&pitch,bytes.data()+0x14,4);std::memcpy(&height,bytes.data()+0x18,4);std::memcpy(&bounds,bytes.data()+0x20,24);
    if(v!=gate_.load_bias+0xb7b780||!draw||pitch!=static_cast<std::int32_t>(gate_.actual_pitch)||height!=static_cast<std::int32_t>(gate_.actual_height)||bounds.address_point!=gate_.load_bias+0xb73b98||bounds.x||bounds.y||bounds.width!=pitch||bounds.height!=height||!positive(bounds)||r.clip.address_point!=gate_.load_bias+0xb73b98||!positive(r.clip))return false;
    if(!memory_.read(memory_.context,draw,&v,8)||v!=gate_.load_bias+0xb7b7d8)return false;
    return true;
}
Result Adapter::after_original_paint_on_ui(const Receipt& r) noexcept {
    if(!configured_)return Result::Disabled;if(!on_ui())return Result::WrongThread;
    if(in_paint_||status_.phase==Phase::Hold||status_.phase==Phase::FactoryRestored){++status_.rejected;return Result::Rejected;}
    if(!r.UI_paint_serial||r.UI_paint_serial<=last_paint_){++status_.duplicate_paints;return Result::Rejected;}
    // This is UI repaint accounting, never a capture-frame/FPS counter.
    last_paint_=r.UI_paint_serial;
    if(r.LV!=gate_.LV||!r.LV_still_current||!r.display_owner_lease_live||!r.original_returned_normally){hold();return Result::Hold;}
    if(!r.actual_native_image_blit_completed)return Result::Pending;
    if(r.geometry_epoch!=geometry_epoch_||r.configuration_generation!=status_.generation){++status_.rejected;return Result::Rejected;}
    Rectangle24 bounds{};if(!surface_valid(r,bounds)){hold();return Result::Hold;}
    // The first stage admits only complete stock restoration of the prior/new
    // image region. Partial tiled paint is deliberately not claimed as clean.
    const PixelRect clip{r.clip.x,r.clip.y,r.clip.width,r.clip.height};
    if(positive(required_clean_)&&(!contains(r.actual_stock_repaint_coverage,required_clean_)||!contains(clip,required_clean_)))return Result::Pending;
    if(status_.mode==MaskMode::Off||plan_.hidden!=MaskHidden::None||!plan_.count){
        required_clean_=plan_.image_clip;
        status_.factory_repaint_confirmed=true;status_.phase=disabling_?Phase::FactoryRestored:status_.mode==MaskMode::Off?Phase::OffClean:Phase::MaskShown;return Result::Ok;
    }
    PixelRect viewport_clip{},active_clip{};
    if(!intersect(plan_.image_clip,{bounds.x,bounds.y,bounds.width,bounds.height},viewport_clip)||!intersect(viewport_clip,{r.clip.x,r.clip.y,r.clip.width,r.clip.height},active_clip)){++status_.rejected;return Result::Rejected;}
    std::array<PixelRect,4> clipped{};std::size_t count=0;
    for(std::size_t i=0;i<plan_.count;++i){PixelRect band;if(intersect(plan_.bands[i],active_clip,band))clipped[count++]=band;}
    in_paint_=true;
    try{
        const Color4 black{plan_.alpha,0,0,0};
        // Callback-local native objects only. Wrapper makes its own mutable
        // clip clone; the incoming clip remains unchanged for other controls.
        const Rectangle24 clip{r.clip.address_point,active_clip.x,active_clip.y,active_clip.width,active_clip.height};
        for(std::size_t i=0;i<count;++i){
            const auto band=clipped[i];const Rectangle24 draw{r.clip.address_point,band.x,band.y,band.width,band.height};
            native_.fill(reinterpret_cast<void*>(r.surface),&draw,&clip,&black);++status_.fills;
        }
        // A full stock repaint has now cleaned the outstanding historical
        // viewport union. Future paints only need the currently drawn region.
        required_clean_=plan_.image_clip;
        in_paint_=false;status_.phase=Phase::MaskShown;return Result::Ok;
    }catch(...){in_paint_=false;hold();return Result::Hold;}
}
Result Adapter::disable_on_ui() noexcept {
    if(!configured_)return Result::Disabled;if(!on_ui())return Result::WrongThread;
    if(in_paint_||status_.phase==Phase::Hold||status_.phase==Phase::FactoryRestored||disabling_||status_.generation==std::numeric_limits<std::uint64_t>::max())return Result::Rejected;
    mask_.exitToFactory();plan_={};status_.mode=MaskMode::Off;status_.factory_repaint_confirmed=false;++status_.generation;disabling_=true;status_.phase=Phase::OffAwaitingRepaint;
    if(!native_.request_stock_repaint(native_.context,gate_.LV)){hold();return Result::Hold;}
    return Result::Pending;
}
}
