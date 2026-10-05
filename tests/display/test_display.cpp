#include "iq4/display_mask.hpp"

#include <algorithm>
#include <cmath>
#include <functional>
#include <iostream>
#include <limits>
#include <stdexcept>

using namespace iq4;
using namespace iq4::display;
namespace {
unsigned passed{}, failed{};
std::uint64_t checkedPixels{}, maskedPixels{};
void check(bool ok, const char* reason = "check failed") { if (!ok) throw std::runtime_error(reason); }
void near(double a, double b, double epsilon=1e-8) { check(std::isfinite(a) && std::abs(a-b)<=epsilon, "geometry differs"); }
void test(const std::string& name, const std::function<void()>& body) {
    try { body(); ++passed; std::cout << "PASS " << name << '\n'; }
    catch (const std::exception& error) { ++failed; std::cerr << "FAIL " << name << ": " << error.what() << '\n'; }
}
template<class Function> void rejects(Function f) {
    try { f(); } catch (const std::invalid_argument&) { return; }
    throw std::runtime_error("invalid configuration accepted");
}
double area(const std::vector<Point>& p) {
    double result=0; for(std::size_t i=0;i<p.size();++i) { const auto j=(i+1)%p.size();result+=p[i].x*p[j].y-p[j].x*p[i].y; }
    return result/2;
}
bool inRect(Point p, Rect r) { return p.x>=r.x && p.x<r.x+r.width && p.y>=r.y && p.y<r.y+r.height; }
bool insideConvex(Point p, const std::vector<Point>& polygon) {
    // Strict interior raster coverage; edge ownership/antialiasing belongs to
    // the real compositor. Shared edges are never alpha-blended twice here.
    if(polygon.size()<3) return false;
    for(std::size_t i=0;i<polygon.size();++i) {
        const auto a=polygon[i],b=polygon[(i+1)%polygon.size()];
        if ((b.x-a.x)*(p.y-a.y)-(b.y-a.y)*(p.x-a.x)<=1e-10) return false;
    }
    return true;
}
struct Pixel { double r,g,b; };
bool same(Pixel a,Pixel b) { return a.r==b.r&&a.g==b.g&&a.b==b.b; }
std::vector<Pixel> material(unsigned width,unsigned height) {
    std::vector<Pixel> p; p.reserve(std::size_t(width)*height);
    for(unsigned y=0;y<height;++y)for(unsigned x=0;x<width;++x)p.push_back({.2+.7*x/width,.1+.8*y/height,.3+.4*((x+y)%29)/29.});
    return p;
}
std::uint64_t materialChecksum(const std::vector<Pixel>& p) {
    std::uint64_t value=1469598103934665603ULL;
    const auto* bytes=reinterpret_cast<const unsigned char*>(p.data());
    for(std::size_t i=0;i<p.size()*sizeof(Pixel);++i) { value^=bytes[i];value*=1099511628211ULL; }
    return value;
}
// Host-only test compositor. This class owns a COPY of its software surface;
// it is never passed to CameraSDK, capture, JPEG or recorder code.
class SoftwareCanvas final : public DisplayCanvas {
public:
    SoftwareCanvas(unsigned w,unsigned h,const std::vector<Pixel>& background):width(w),height(h),pixels(background),coverage(background.size(),0) {
        check(pixels.size()==std::size_t(w)*h);
    }
    void fillConvexBlack(const std::vector<Point>& polygon,double opacity,Rect clip) override {
        ++fillCalls;
        check(polygon.size()>=3&&area(polygon)>0,"positive convex polygon required");
        for(std::size_t i=0;i<polygon.size();++i){const auto a=polygon[i],b=polygon[(i+1)%polygon.size()];check(a.x!=b.x||a.y!=b.y,"zero-length polygon edge");}
        for(auto p:polygon)check(std::isfinite(p.x)&&std::isfinite(p.y)&&p.x>=clip.x-1e-7&&p.x<=clip.x+clip.width+1e-7&&p.y>=clip.y-1e-7&&p.y<=clip.y+clip.height+1e-7,"vertex outside image viewport");
        for(unsigned y=0;y<height;++y)for(unsigned x=0;x<width;++x) {
            const Point p{double(x)+.5,double(y)+.5}; if(!inRect(p,clip)||!insideConvex(p,polygon))continue;
            const auto index=std::size_t(y)*width+x;++coverage[index];auto& v=pixels[index];v.r*=1-opacity;v.g*=1-opacity;v.b*=1-opacity;
        }
    }
    void strokeWhiteSegment(Point a,Point b,double lineWidth,Rect clip) override {
        ++strokeCalls;const double dx=b.x-a.x,dy=b.y-a.y,length2=dx*dx+dy*dy;
        check(length2>0&&lineWidth>0);
        for(unsigned y=0;y<height;++y)for(unsigned x=0;x<width;++x) {
            const Point p{double(x)+.5,double(y)+.5};if(!inRect(p,clip))continue;
            const double t=std::max(0.,std::min(1.,((p.x-a.x)*dx+(p.y-a.y)*dy)/length2));
            const double ex=p.x-(a.x+t*dx),ey=p.y-(a.y+t*dy);
            if(ex*ex+ey*ey<=lineWidth*lineWidth/4)pixels[std::size_t(y)*width+x]={1,1,1};
        }
    }
    unsigned width,height,fillCalls{},strokeCalls{};
    std::vector<Pixel> pixels;
    std::vector<unsigned> coverage;
};
Point inverse(Affine m,Point p) {
    const double determinant=m.a*m.d-m.b*m.c;p.x-=m.tx;p.y-=m.ty;
    return {(m.d*p.x-m.c*p.y)/determinant,(-m.b*p.x+m.a*p.y)/determinant};
}
double ratio(MaskMode mode) {
    return mode==MaskMode::XPan65_24?65./24:mode==MaskMode::Ratio16_9?16./9:mode==MaskMode::Ratio3_2?1.5:1;
}
bool closeToEdge(Point p,Rect r) {
    return std::abs(p.x-r.x)<1e-6||std::abs(p.x-r.x-r.width)<1e-6||std::abs(p.y-r.y)<1e-6||std::abs(p.y-r.y-r.height)<1e-6;
}
void verifyCoverage(const ViewMapping& mapping,MaskMode mode,unsigned width,unsigned height) {
    const auto input=material(width,height);const auto before=materialChecksum(input);
    const auto plan=makeDrawPlan(mapping,{mode,.65,false});check(plan.hidden==MaskHidden::None);
    SoftwareCanvas canvas(width,height,input);draw(canvas,plan);
    // Independent inverse-coordinate reference: a display pixel is masked iff
    // it comes from full source outside the centered ratio frame. This catches
    // wrong matrix order, rotated display proportions and re-framing on zoom.
    const auto s=mapping.fullSource;const double frameWidth=std::min(s.width,s.height*ratio(mode)),frameHeight=frameWidth/ratio(mode);
    const Rect expected{s.x+(s.width-frameWidth)/2,s.y+(s.height-frameHeight)/2,frameWidth,frameHeight};
    for(unsigned y=0;y<height;++y)for(unsigned x=0;x<width;++x) {
        const auto i=std::size_t(y)*width+x;const Point screen{double(x)+.5,double(y)+.5};
        check(canvas.coverage[i]<=1,"overlapping bands caused double opacity");
        if(!inRect(screen,mapping.imageViewport)){check(canvas.coverage[i]==0&&same(canvas.pixels[i],input[i]),"toolbar/letterbox altered");continue;}
        const auto source=inverse(mapping.sourceToDisplay,screen);
        if(closeToEdge(source,s)||closeToEdge(source,expected))continue;
        const bool masked=inRect(source,s)&&!inRect(source,expected);
        check(canvas.coverage[i]==unsigned(masked),"raster mask differs from full-source inverse reference");
        if(masked) { near(canvas.pixels[i].r,input[i].r*.35);near(canvas.pixels[i].g,input[i].g*.35);near(canvas.pixels[i].b,input[i].b*.35);++maskedPixels; }
        else check(same(canvas.pixels[i],input[i]),"inside frame was dimmed");
        ++checkedPixels;
    }
    check(materialChecksum(input)==before,"input material changed");
}
} // namespace

int main() {
    const ViewMapping fit{{0,0,400,300},{64,32,400,300},{1,0,0,1,64,32},true,false};
    test("default Off produces zero canvas commands",[&] {
        TemporaryMask session;near(session.config().opacity,.65);check(session.config().mode==MaskMode::Off);
        const auto input=material(512,384);SoftwareCanvas canvas(512,384,input);const auto plan=session.plan(fit);
        check(plan.hidden==MaskHidden::Disabled&&!plan.hasCommands());draw(canvas,plan);check(!canvas.fillCalls&&!canvas.strokeCalls);check(canvas.pixels.size()==input.size());
        for(std::size_t i=0;i<input.size();++i)check(same(canvas.pixels[i],input[i]));
    });
    for(auto mode:{MaskMode::XPan65_24,MaskMode::Ratio16_9,MaskMode::Ratio3_2,MaskMode::Ratio1_1}) {
        test("viewport raster isolation mode "+std::to_string(int(mode)),[&]{verifyCoverage(fit,mode,512,384);});
        test("band area equals source exterior mode "+std::to_string(int(mode)),[&]{
            const auto plan=makeDrawPlan(fit,{mode,.65,false});double total=0;for(const auto& fill:plan.fills)total+=area(fill.convexPolygon);
            near(total,400*300-plan.sourceFrame.width*plan.sourceFrame.height,1e-7);check(plan.fills.size()<=4);near(plan.sourceFrame.width/plan.sourceFrame.height,ratio(mode),1e-12);
        });
        test("second display scale raster isolation mode "+std::to_string(int(mode)),[&]{
            verifyCoverage({{0,0,400,300},{16,12,160,120},{.4,0,0,.4,16,12},true,false},mode,200,160);
        });
    }
    const std::array<Affine,4> orientations={Affine{1,0,0,1,64,32},Affine{0,1,-1,0,332,56},Affine{-1,0,0,-1,464,332},Affine{0,-1,1,0,32,456}};
    for(unsigned i=0;i<4;++i)for(auto mode:{MaskMode::XPan65_24,MaskMode::Ratio16_9,MaskMode::Ratio3_2,MaskMode::Ratio1_1}) {
        test("four orientations source ratio "+std::to_string(i)+" mode "+std::to_string(int(mode)),[&]{
            const Rect viewport=i%2?Rect{32,56,300,400}:fit.imageViewport;
            verifyCoverage({fit.fullSource,viewport,orientations[i],true,false},mode,512,512);
        });
    }
    for(auto mode:{MaskMode::XPan65_24,MaskMode::Ratio16_9,MaskMode::Ratio3_2,MaskMode::Ratio1_1}) {
        test("focus zoom plus pan retains full frame mode "+std::to_string(int(mode)),[&]{
            ViewMapping zoom=fit;zoom.focusZoom=true;zoom.sourceToDisplay={2,0,0,2,-238,-102};
            verifyCoverage(zoom,mode,512,384);const auto full=makeDrawPlan(fit,{mode,.65,false}),cropped=makeDrawPlan(zoom,{mode,.65,false});
            near(full.sourceFrame.x,cropped.sourceFrame.x);near(full.sourceFrame.y,cropped.sourceFrame.y);near(full.sourceFrame.width,cropped.sourceFrame.width);near(full.sourceFrame.height,cropped.sourceFrame.height);
        });
    }
    test("crop and full-source origin offset map correctly",[&]{verifyCoverage({{100,200,400,300},fit.imageViewport,{1.3,0,0,1.3,-120,-305},true,true},MaskMode::Ratio1_1,512,384);});
    test("non-axis affine preserves disjoint convex coverage",[&]{verifyCoverage({fit.fullSource,{20,20,470,340},{.9,.11,.18,.88,24,21},true,false},MaskMode::XPan65_24,512,384);});
    test("viewport clipping exactly through a transformed band corner",[&]{verifyCoverage({fit.fullSource,{200,40,220,220},{.5,.5,-.5,.5,200,40},true,false},MaskMode::XPan65_24,512,384);});
    test("reflection reverses winding but coverage remains valid",[&]{verifyCoverage({fit.fullSource,fit.imageViewport,{-1,0,0,1,464,32},true,false},MaskMode::Ratio1_1,512,384);});
    test("viewport width never defines source aspect",[&]{
        const auto p=makeDrawPlan({{0,0,4000,3000},{0,0,1920,1080},{.4,0,0,.4,160,-60},true,false},{MaskMode::XPan65_24,.65,false});
        near(p.sourceFrame.width,4000);near(p.sourceFrame.height,4000*24./65,1e-9);check(p.hasCommands());
    });
    test("unknown focus zoom hides all commands",[&]{auto mapping=fit;mapping.focusZoom=true;mapping.fullSourceMappingKnown=false;
        const auto p=makeDrawPlan(mapping,{MaskMode::Ratio16_9,.65,true});check(p.hidden==MaskHidden::SourceCoordinatesUnavailable&&!p.hasCommands());});
    test("known focus zoom stays enabled",[&]{auto mapping=fit;mapping.focusZoom=true;check(makeDrawPlan(mapping,{MaskMode::Ratio16_9,.65,false}).hasCommands());});
    test("Off ignores even invalid mapping and boundary toggle",[]{
        const auto p=makeDrawPlan({{0,0,0,0},{0,0,0,0},{},false,true},{MaskMode::Off,.65,true});check(p.hidden==MaskHidden::Disabled&&!p.hasCommands());});
    test("viewport wholly inside retained source frame needs no fill",[&]{
        const auto p=makeDrawPlan({fit.fullSource,fit.imageViewport,{10,0,0,10,-1800,-1300},true,true},{MaskMode::Ratio16_9,.65,false});check(p.hidden==MaskHidden::None&&!p.hasCommands());});
    test("viewport wholly in top band is dimmed exactly once",[&]{
        const auto p=makeDrawPlan({fit.fullSource,{0,0,100,20},{1,0,0,1,0,0},true,true},{MaskMode::XPan65_24,.65,false});
        near(p.sourceFrame.height,400*24./65);check(p.fills.size()==1);near(area(p.fills[0].convexPolygon),2000);
    });
    test("opacity zero produces no fills while keeping optional boundary",[&]{
        const auto p=makeDrawPlan(fit,{MaskMode::Ratio16_9,0,false});check(!p.hasCommands());
        const auto b=makeDrawPlan(fit,{MaskMode::Ratio16_9,0,true});check(b.fills.empty()&&!b.boundaries.empty());
    });
    test("boundary follows original frame edges and clips to image",[&]{
        const auto p=makeDrawPlan(fit,{MaskMode::Ratio16_9,.65,true});check(p.boundaries.size()==4);
        const auto input=material(512,384);SoftwareCanvas canvas(512,384,input);draw(canvas,p);check(canvas.strokeCalls==4);
        for(unsigned y=0;y<384;++y)for(unsigned x=0;x<512;++x)if(!inRect({double(x)+.5,double(y)+.5},fit.imageViewport))check(same(canvas.pixels[std::size_t(y)*512+x],input[std::size_t(y)*512+x]),"border touched toolbar");
        const auto zoom=makeDrawPlan({fit.fullSource,fit.imageViewport,{2,0,0,2,-136,-118},true,true},{MaskMode::Ratio16_9,.65,true});
        for(const auto& b:zoom.boundaries)check(b.from.x>=64-1e-8&&b.from.x<=464+1e-8&&b.from.y>=32-1e-8&&b.from.y<=332+1e-8,"boundary not clipped");
    });
    test("exit resets temporary settings and emits no commands",[&]{
        TemporaryMask s;s.select(MaskMode::Ratio1_1);s.setOpacity(.9);s.setBoundary(true);check(s.plan(fit).hasCommands());s.exitToFactory();
        check(s.config().mode==MaskMode::Off&&!s.config().boundary);near(s.config().opacity,.65);check(!s.plan(fit).hasCommands());
        TemporaryMask recreated;check(!recreated.plan(fit).hasCommands());
        const auto input=material(512,384);SoftwareCanvas factoryRepaint(512,384,input);draw(factoryRepaint,s.plan(fit));
        for(std::size_t i=0;i<input.size();++i)check(same(input[i],factoryRepaint.pixels[i]));
    });
    test("all five temporary modes can be switched without persistence",[&]{
        TemporaryMask s;for(auto mode:{MaskMode::Off,MaskMode::XPan65_24,MaskMode::Ratio16_9,MaskMode::Ratio3_2,MaskMode::Ratio1_1,MaskMode::Off}){s.select(mode);check(s.config().mode==mode);check(s.plan(fit).hasCommands()==(mode!=MaskMode::Off));}
    });
    test("invalid settings rejected without changing active configuration",[&]{
        TemporaryMask s;s.select(MaskMode::Ratio3_2);for(double opacity:{-1.,1.1,std::numeric_limits<double>::quiet_NaN()})rejects([&]{s.setOpacity(opacity);});
        rejects([&]{s.select(static_cast<MaskMode>(99));});check(s.config().mode==MaskMode::Ratio3_2);near(s.config().opacity,.65);
    });
    test("invalid geometry hides rather than drawing toolbar",[&]{
        auto m=fit;m.imageViewport.width=0;check(!makeDrawPlan(m,{MaskMode::Ratio1_1,.65,true}).hasCommands());
        m=fit;m.sourceToDisplay={0,0,0,0,0,0};check(!makeDrawPlan(m,{MaskMode::Ratio1_1,.65,true}).hasCommands());
        m=fit;m.sourceToDisplay.tx=std::numeric_limits<double>::infinity();check(!makeDrawPlan(m,{MaskMode::Ratio1_1,.65,true}).hasCommands());
    });
    test("hidden plans never emit commands even if caller inserted polygon",[&]{
        DrawPlan p;p.hidden=MaskHidden::SourceCoordinatesUnavailable;p.fills.push_back({{{0,0},{10,0},{10,10},{0,10}},.65});
        const auto input=material(16,16);SoftwareCanvas canvas(16,16,input);draw(canvas,p);check(!canvas.fillCalls);
    });
    std::cout<<"RESULT_JSON {\"level\":\"host_validation\",\"camera_control\":false,\"target_surface_adapter\":\"unverified\",\"passed\":"<<passed<<",\"failed\":"<<failed<<",\"independent_reference_pixels_checked\":"<<checkedPixels<<",\"masked_pixels_checked\":"<<maskedPixels<<"}\n";
    return failed?1:0;
}
