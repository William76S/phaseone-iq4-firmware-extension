#include "iq4/image_core.hpp"

#include <atomic>
#include <cmath>
#include <functional>
#include <iostream>
#include <limits>
#include <locale>
#include <random>
#include <sstream>
#include <thread>

using namespace iq4;
namespace {
unsigned passed = 0, failed = 0;
std::vector<std::string> failedNames;
void require(bool value, const std::string& message = "requirement failed") {
    if (!value) throw std::runtime_error(message);
}
void near(double value, double expected, double tolerance = 1e-8) {
    if (std::abs(value - expected) > tolerance || !std::isfinite(value)) {
        std::ostringstream msg; msg << value << " differs from " << expected; throw std::runtime_error(msg.str());
    }
}
void nearRgb(RGB value, RGB expected, double tolerance = 1e-8) {
    near(value.r, expected.r, tolerance); near(value.g, expected.g, tolerance); near(value.b, expected.b, tolerance);
}
void test(const std::string& name, const std::function<void()>& body) {
    try { body(); ++passed; std::cout << "PASS " << name << '\n'; }
    catch (const std::exception& e) { ++failed; failedNames.push_back(name); std::cerr << "FAIL " << name << ": " << e.what() << '\n'; }
}
std::string generated(unsigned n, const std::function<RGB(RGB)>& function,
                      const std::string& header = "") {
    std::ostringstream out; out.imbue(std::locale::classic()); out.precision(17);
    out << "LUT_3D_SIZE " << n << '\n' << header;
    for (unsigned b = 0; b < n; ++b) for (unsigned g = 0; g < n; ++g) for (unsigned r = 0; r < n; ++r) {
        const auto v = function({double(r) / (n - 1), double(g) / (n - 1), double(b) / (n - 1)});
        out << v.r << ' ' << v.g << ' ' << v.b << '\n';
    }
    return out.str();
}
std::string identity(unsigned n = 2) { return generated(n, [](RGB v) { return v; }); }
std::string invert() { return generated(2, [](RGB v) { return RGB{1-v.r, 1-v.g, 1-v.b}; }); }
void reject(const std::string& data, CubeError expected, CubeLimits limits = {}) {
    try { (void)CubeLut::parse(data, limits); }
    catch (const CubeParseError& e) { require(e.code() == expected, e.what()); return; }
    throw std::runtime_error("invalid cube accepted");
}
void pixels(PixelSize source, JpegSizeMode mode, PixelSize expected) {
    const auto result = jpegSize(source, mode); require(result.available);
    require(result.pixels.width == expected.width && result.pixels.height == expected.height, "pixel size differs");
}
struct CommaDecimal : std::numpunct<char> { char do_decimal_point() const override { return ','; } };
}

int main(int argc, char** argv) {
    if (argc != 2) { std::cerr << "usage: iq4_core_tests <fixture-lut-directory>\n"; return 2; }
    const std::string fixtures = argv[1];
    for (unsigned n : {17, 33, 65}) {
        test("fixture identity " + std::to_string(n) + " grid and RGB error", [&] {
            const auto lut = CubeLut::fromFile(fixtures + "/identity_" + std::to_string(n) + ".cube");
            require(lut.size() == n); require(lut.tableBytes() == std::size_t(n)*n*n*sizeof(RGB));
            std::mt19937 random(0x1a4); std::uniform_real_distribution<double> channel(0,1);
            for (unsigned i = 0; i < 1000; ++i) {
                const RGB x{channel(random),channel(random),channel(random)};
                nearRgb(lut.evaluate(x), x, 1.0/255);
                const auto original = quantizeSrgb8(x), actual = quantizeSrgb8(lut.evaluate(x));
                for (unsigned c = 0; c < 3; ++c) require(std::abs(int(original[c])-int(actual[c])) <= 1);
            }
        });
    }
    test("fixture inversion catches sign and interpolation", [&] {
        const auto lut = CubeLut::fromFile(fixtures + "/invert_17.cube");
        nearRgb(lut.evaluate({.123,.456,.789}), {.877,.544,.211});
    });
    test("fixture red-green swap catches channel and axis order", [&] {
        const auto lut = CubeLut::fromFile(fixtures + "/swap_rg_17.cube");
        nearRgb(lut.evaluate({.13,.61,.89}), {.61,.13,.89});
    });
    test("fixture custom domain scales and clamps each axis", [&] {
        const auto lut = CubeLut::fromFile(fixtures + "/domain_17.cube");
        nearRgb(lut.evaluate({.3,.5,.7}), {.25,.5,.75});
        nearRgb(lut.evaluate({-.7,2,.5}), {0,1,.5});
    });
    test("fixture truncated rejected", [&] {
        try { (void)CubeLut::fromFile(fixtures + "/invalid_truncated.cube"); }
        catch (const CubeParseError& e) { require(e.code()==CubeError::InvalidCount); return; }
        throw std::runtime_error("fixture accepted");
    });
    test("fixture NaN rejected", [&] {
        try { (void)CubeLut::fromFile(fixtures + "/invalid_nan.cube"); }
        catch (const CubeParseError& e) { require(e.code()==CubeError::InvalidNumber); return; }
        throw std::runtime_error("fixture accepted");
    });
    test("BOM CRLF comments scientific decimals and title hash", [] {
        auto text = identity(); const auto at = text.find("0 0 0"); text.replace(at, 5, "+0e0 .0E+2 0.0e-3 # row");
        text = "\xef\xbb\xbf# leading comment\n\nTITLE \"test # title\" # trailing comment\n" + text;
        std::string crlf; for (char c : text) { if (c=='\n') crlf += '\r'; crlf += c; }
        const auto lut = CubeLut::parse(crlf); require(lut.title()=="test # title"); nearRgb(lut.evaluate({.2,.4,.8}),{.2,.4,.8});
    });
    test("title escaped quote and backslash", [] {
        const auto lut = CubeLut::parse("TITLE \"A \\\"B\\\" \\\\ C\"\n" + identity()); require(lut.title()=="A \"B\" \\ C");
    });
    test("numeric parser ignores process comma-decimal locale", [] {
        const auto previous = std::locale(); std::locale::global(std::locale(previous, new CommaDecimal));
        try { nearRgb(CubeLut::parse(identity()).evaluate({.15,.33,.78}),{.15,.33,.78}); }
        catch (...) { std::locale::global(previous); throw; }
        std::locale::global(previous);
    });
    test("all eight corners and random multi-affine function", [] {
        const auto lut = CubeLut::parse(generated(2, [](RGB v) { return RGB{v.r*v.g,v.g*v.b,v.b*v.r}; }));
        std::mt19937 random(731); std::uniform_real_distribution<double> channel(0,1);
        for (unsigned i=0; i<1000; ++i) {
            const RGB x{channel(random),channel(random),channel(random)}; nearRgb(lut.evaluate(x),{x.r*x.g,x.g*x.b,x.b*x.r}, 1e-12);
        }
        for (unsigned b=0;b<2;++b) for(unsigned g=0;g<2;++g) for(unsigned r=0;r<2;++r)
            nearRgb(lut.evaluate({double(r),double(g),double(b)}),{double(r*g),double(g*b),double(b*r)},1e-12);
    });
    test("distinct axis domains and out of range input", [] {
        const auto lut = CubeLut::parse(generated(2, [](RGB v){return v;}, "DOMAIN_MIN -1 10 100\nDOMAIN_MAX 1 20 300\n"));
        nearRgb(lut.evaluate({0,12.5,250}),{.5,.25,.75}); nearRgb(lut.evaluate({-9,99,250}),{0,1,.75});
    });
    test("unclamped LUT outputs preserved until JPEG quantization", [] {
        const auto lut=CubeLut::parse(generated(2, [](RGB v){return RGB{2*v.r-.5,3*v.g-1,4*v.b-2};}));
        nearRgb(lut.evaluate({0,1,.5}),{-.5,2,0});
        require(quantizeSrgb8({-.5,2,.5})==std::array<std::uint8_t,3>{0,255,128});
    });
    const std::vector<std::pair<std::string,CubeError>> invalid = {
        {"LUT_3D_SIZE 1\n",CubeError::InvalidGrid}, {"LUT_3D_SIZE 66\n",CubeError::InvalidGrid},
        {"LUT_3D_SIZE 99999999999999999999\n",CubeError::InvalidGrid}, {"LUT_3D_SIZE 2.0\n",CubeError::InvalidGrid},
        {"LUT_3D_SIZE -2\n",CubeError::InvalidGrid}, {"LUT_3D_SIZE 2 extra\n",CubeError::InvalidGrid},
        {"LUT_1D_SIZE 17\n",CubeError::UnsupportedDialect}, {"LUT_3D_INPUT_RANGE 0 1\n",CubeError::UnsupportedDialect},
        {"LUT_1D_INPUT_RANGE 0 1\n",CubeError::UnsupportedDialect}, {"LUT_3D_SIZE 2\nUNSUPPORTED_KEY 2\n",CubeError::UnsupportedDialect},
        {"LUT_3D_SIZE 2\nNaN 0 0\n",CubeError::InvalidNumber}, {"LUT_3D_SIZE 2\nInf 0 0\n",CubeError::InvalidNumber},
        {"LUT_3D_SIZE 2\n-inf 0 0\n",CubeError::InvalidNumber}, {"LUT_3D_SIZE 2\n1e309 0 0\n",CubeError::InvalidNumber},
        {"LUT_3D_SIZE 2\n1e 0 0\n",CubeError::InvalidNumber}, {"LUT_3D_SIZE 2\n0,5 0 0\n",CubeError::InvalidNumber},
        {"LUT_3D_SIZE 2\n0 0\n",CubeError::InvalidSyntax}, {"LUT_3D_SIZE 2\n0 0 0 0\n",CubeError::InvalidSyntax},
        {identity()+"0 0 0\n",CubeError::InvalidCount}, {"LUT_3D_SIZE 2\n0 0 0\n",CubeError::InvalidCount},
        {"LUT_3D_SIZE 2\nLUT_3D_SIZE 2\n",CubeError::DuplicateKeyword},
        {"TITLE \"one\"\nTITLE \"two\"\n"+identity(),CubeError::DuplicateKeyword},
        {"DOMAIN_MIN 0 0 0\nDOMAIN_MIN 0 0 0\n"+identity(),CubeError::DuplicateKeyword},
        {"DOMAIN_MAX 1 1 1\nDOMAIN_MAX 1 1 1\n"+identity(),CubeError::DuplicateKeyword},
        {"DOMAIN_MIN 1 0 0\n"+identity(),CubeError::InvalidDomain},
        {"DOMAIN_MAX -1 1 1\n"+identity(),CubeError::InvalidDomain},
        {"DOMAIN_MIN -1e308 0 0\nDOMAIN_MAX 1e308 1 1\n"+identity(),CubeError::InvalidDomain},
        {"DOMAIN_MIN nan 0 0\n"+identity(),CubeError::InvalidNumber},
        {"TITLE unquoted\n"+identity(),CubeError::InvalidSyntax},
        {"TITLE \"unfinished\n"+identity(),CubeError::InvalidSyntax},
        {identity()+"DOMAIN_MIN 0 0 0\n",CubeError::InvalidSyntax},
        {"0 0 0\n",CubeError::InvalidSyntax}, {"# empty\n",CubeError::InvalidGrid},
        {"TITLE \""+std::string(257,'x')+"\"\n"+identity(),CubeError::InvalidSyntax},
        {std::string(4097,'#')+"\n"+identity(),CubeError::LineTooLong},
        {std::string("LUT_3D_SIZE 2\0",14)+"\n",CubeError::InvalidSyntax}
    };
    for (std::size_t i=0;i<invalid.size();++i) test("strict invalid cube case "+std::to_string(i+1),[&]{reject(invalid[i].first,invalid[i].second);});
    test("text file-byte allocation limit", [] { auto limits=CubeLimits{};limits.maxFileBytes=8;reject(identity(),CubeError::FileTooLarge,limits); });
    test("streamed file limit cannot be bypassed", [&] {
        auto limits=CubeLimits{}; limits.maxFileBytes=10;
        try { (void)CubeLut::fromFile(fixtures+"/identity_65.cube",limits); }
        catch(const CubeParseError& e){require(e.code()==CubeError::FileTooLarge);return;} throw std::runtime_error("accepted oversized file");
    });
    test("mid-file BOM rejected", [] { reject("TITLE \"x\"\n\xef\xbb\xbf"+identity(),CubeError::InvalidSyntax); });
    test("finite extreme input safely clamps", [] { nearRgb(CubeLut::parse(identity()).evaluate({-1e308,1e308,.3}),{0,1,.3}); });
    test("nonfinite pixel input rejected", [] {
        try {(void)CubeLut::parse(identity()).evaluate({std::numeric_limits<double>::infinity(),0,0});}
        catch(const std::invalid_argument&){return;}throw std::runtime_error("infinity accepted");
    });
    test("configuration on off strengths and immutable snapshots", [] {
        JpegLutStore store; store.importAndSelect(invert()); const auto disabled=store.snapshot();
        nearRgb(disabled->apply({.2,.4,.9}),{.2,.4,.9}); store.setEnabled(true);store.setStrength(.25);
        nearRgb(store.snapshot()->apply({.2,.4,.9}),{.35,.45,.7});nearRgb(disabled->apply({.2,.4,.9}),{.2,.4,.9});
        store.setStrength(0);nearRgb(store.snapshot()->apply({.2,.4,.9}),{.2,.4,.9});
        store.setStrength(1);nearRgb(store.snapshot()->apply({.2,.4,.9}),{.8,.6,.1});
        store.setEnabled(false);nearRgb(store.snapshot()->apply({.2,.4,.9}),{.2,.4,.9});
    });
    test("failed import preserves entire published config", [] {
        JpegLutStore store;store.importAndSelect(invert());store.setEnabled(true);store.setStrength(.75);
        const auto before=store.snapshot(); try{store.importAndSelect("LUT_3D_SIZE 2\nNaN 0 0\n");}catch(const CubeParseError&){}
        require(store.snapshot()==before);nearRgb(before->apply({.2,.4,.8}),{.65,.55,.35});
    });
    test("failed file open preserves selection", [] {
        JpegLutStore store;store.importAndSelect(identity());const auto before=store.snapshot();
        try{store.importAndSelectFile("/definitely_missing_iq4_fixture.cube");}catch(const std::runtime_error&){}
        require(store.snapshot()==before);
    });
    test("invalid strength never publishes", [] {
        JpegLutStore store;const auto before=store.snapshot();
        for(double s : {-1.,1.1,std::numeric_limits<double>::quiet_NaN()}) {try{store.setStrength(s);}catch(const std::invalid_argument&){} require(store.snapshot()==before);}
    });
    test("direct malformed config rejects nonfinite strength", [] {
        JpegLutConfig config; config.strength=std::numeric_limits<double>::quiet_NaN();
        try{(void)config.apply({0,0,0});}catch(const std::invalid_argument&){return;}throw std::runtime_error("malformed direct config accepted");
    });
    test("concurrent imports publish whole immutable tables", [] {
        JpegLutStore store; store.importAndSelect(identity());store.setEnabled(true);
        const auto old=store.snapshot();std::atomic<bool> done{false};std::atomic<bool> bad{false};
        std::thread reader([&]{while(!done.load()){const auto snap=store.snapshot();const auto v=snap->apply({.1,.3,.8});
            const bool original=std::abs(v.r-.1)<1e-9&&std::abs(v.g-.3)<1e-9&&std::abs(v.b-.8)<1e-9;
            const bool inverted=std::abs(v.r-.9)<1e-9&&std::abs(v.g-.7)<1e-9&&std::abs(v.b-.2)<1e-9;if(!original&&!inverted)bad=true;}});
        for(unsigned i=0;i<250;++i)store.importAndSelect(i%2?identity():invert());
        done=true;reader.join();require(!bad);nearRgb(old->apply({.1,.3,.8}),{.1,.3,.8});
        store.clearSelection();require(!store.snapshot()->enabled&&!store.snapshot()->selected);
    });
    const PixelSize raw{14204,10652};
    test("six exact example dimensions", [&] {
        pixels(raw,JpegSizeMode::Native,raw);pixels(raw,JpegSizeMode::Percent75,{10653,7989});pixels(raw,JpegSizeMode::Percent50,{7102,5326});
        pixels(raw,JpegSizeMode::Percent25,{3551,2663});pixels(raw,JpegSizeMode::Long3840,{3840,2880});pixels(raw,JpegSizeMode::Long7680,{7680,5759});
    });
    test("portrait preserves orientation and full ratio", [] {pixels({10652,14204},JpegSizeMode::Long7680,{5759,7680});pixels({10652,14204},JpegSizeMode::Percent75,{7989,10653});});
    test("percentage half-up ties and minimum one pixel", [] {pixels({5,7},JpegSizeMode::Percent50,{3,4});pixels({2,6},JpegSizeMode::Percent25,{1,2});pixels({1,1},JpegSizeMode::Percent25,{1,1});});
    test("long edge never upsamples source or Sensor+", [] {require(!jpegSize({3000,2000},JpegSizeMode::Long3840).available);require(!jpegSize({7102,5326},JpegSizeMode::Long7680).available);pixels({3840,2160},JpegSizeMode::Long3840,{3840,2160});});
    test("dimension products do not overflow 32bit", [] {const auto n=std::numeric_limits<std::uint32_t>::max();pixels({n,n},JpegSizeMode::Percent75,{3221225471u,3221225471u});pixels({n,n},JpegSizeMode::Long7680,{7680,7680});});
    test("even encoder adjustment explicit without upscaling", [] {const auto r=jpegSize({5,7},JpegSizeMode::Native,true);require(r.available&&r.encoderAdjusted&&r.pixels.width==4&&r.pixels.height==6);require(!jpegSize({1,7},JpegSizeMode::Native,true).available);});
    test("zero and invalid size mode rejected", [] {require(!jpegSize({0,10},JpegSizeMode::Native).available);require(!jpegSize({10,10},static_cast<JpegSizeMode>(99)).available);});
    for(PixelSize screen : {PixelSize{640,480},PixelSize{1920,1440}}) {
        for(const auto mode : {MaskMode::XPan65_24,MaskMode::Ratio16_9,MaskMode::Ratio3_2,MaskMode::Ratio1_1}) {
            test("centered source frame "+std::to_string(screen.width)+" mask "+std::to_string(int(mode)),[&]{
                const auto result=maskGeometry({0,0,4000,3000},{20,30,double(screen.width),double(screen.height)},
                    {double(screen.width)/4000,0,0,double(screen.height)/3000,20,30},mode,true,false);
                require(result.visible);const auto f=result.sourceFrame;near(f.x+f.width/2,2000);near(f.y+f.height/2,1500);
                const double ratio=mode==MaskMode::XPan65_24?65./24:mode==MaskMode::Ratio16_9?16./9:mode==MaskMode::Ratio3_2?1.5:1;
                near(f.width/f.height,ratio,1e-12);near((result.displayFrame[0].x+result.displayFrame[2].x)/2,20+screen.width/2.);
                near((result.displayFrame[0].y+result.displayFrame[2].y)/2,30+screen.height/2.);require(result.clippedDisplayFrame.size()==4);
            });
        }
    }
    test("exact XPan rational differs from approximate 2.7", [] {const auto r=maskGeometry({0,0,4000,3000},{0,0,4000,3000},{},MaskMode::XPan65_24,true,false);near(r.sourceFrame.height,4000*24./65,1e-10);require(std::abs(r.sourceFrame.height-4000/2.7)>4);});
    test("four camera orientations map the same sensor frame", [] {
        const std::array<Affine,4> matrices={Affine{.1,0,0,.1,0,0},Affine{0,.1,-.1,0,300,0},Affine{-.1,0,0,-.1,400,300},Affine{0,-.1,.1,0,0,400}};
        for(unsigned i=0;i<4;++i){const auto r=maskGeometry({0,0,4000,3000},i%2?Rect{0,0,300,400}:Rect{0,0,400,300},matrices[i],MaskMode::Ratio3_2,true,false);
            require(r.visible);near(r.sourceFrame.height,4000/1.5);const auto p=matrices[i].map({0,(3000-4000/1.5)/2});near(r.displayFrame[0].x,p.x);near(r.displayFrame[0].y,p.y);
            const auto first=r.displayFrame[0],next=r.displayFrame[1];if(i%2)near(first.x,next.x);else near(first.y,next.y);}
    });
    test("focus zoom and pan preserve full source frame", [] {
        const auto native=maskGeometry({0,0,4000,3000},{0,0,800,600},{.2,0,0,.2,0,0},MaskMode::XPan65_24,true,false);
        const auto zoom=maskGeometry({0,0,4000,3000},{0,0,800,600},{.4,0,0,.4,-400,-300},MaskMode::XPan65_24,true,true);
        require(zoom.visible);near(zoom.sourceFrame.height,native.sourceFrame.height);near(zoom.displayFrame[0].x,-400);
        near(zoom.displayFrame[0].y,native.sourceFrame.y*.4-300);
        for(auto p:zoom.clippedDisplayFrame)require(p.x>=-1e-8&&p.x<=800+1e-8&&p.y>=-1e-8&&p.y<=600+1e-8);
    });
    test("hardware crop offset maps full effective-source coordinates", [] {
        const auto r=maskGeometry({100,200,4000,3000},{50,60,800,600},{.2,0,0,.2,-170,-180},MaskMode::Ratio1_1,true,true);
        near(r.sourceFrame.x,600);near(r.sourceFrame.y,200);near(r.displayFrame[0].x,-50);near(r.displayFrame[0].y,-140);
    });
    test("unknown focus zoom source coordinates hide mask", [] {const auto r=maskGeometry({0,0,4000,3000},{0,0,800,600},{},MaskMode::Ratio16_9,false,true);require(!r.visible&&r.hidden==MaskHidden::SourceCoordinatesUnavailable);});
    test("off mode disables geometry", [] {const auto r=maskGeometry({0,0,4000,3000},{0,0,800,600},{},MaskMode::Off,true,false);require(!r.visible&&r.hidden==MaskHidden::Disabled);});
    test("invalid matrix and viewport never produce visible polygon", [] {
        require(!maskGeometry({0,0,4000,3000},{0,0,0,600},{},MaskMode::Ratio1_1,true,false).visible);
        require(!maskGeometry({0,0,4000,3000},{0,0,800,600},{0,0,0,0,0,0},MaskMode::Ratio1_1,true,false).visible);
        require(!maskGeometry({0,0,4000,3000},{0,0,800,600},{1,0,0,1,std::numeric_limits<double>::infinity(),0},MaskMode::Ratio1_1,true,false).visible);
    });
    std::cout << "RESULT_JSON {\"level\":\"host_validation\",\"camera_connected_by_test\":false,\"passed\":" << passed << ",\"failed\":" << failed << "}\n";
    return failed?1:0;
}
