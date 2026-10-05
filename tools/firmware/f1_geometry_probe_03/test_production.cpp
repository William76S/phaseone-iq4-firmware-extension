#include "probe.hpp"
#include <cassert>
#include <cstdio>
using namespace iq4::f1;
namespace {
bool read(void*context,std::uintptr_t,void*,std::size_t)noexcept {
    ++*static_cast<unsigned*>(context);return false;
}
}
int main(){
    unsigned reads{};native_ui02::Selector selector;
    assert(!selector.configure({&reads,read},{},{},native_ui02::UserSHA,0,{}));
    assert(selector.build_on_ui()==native_ui02::Result::Disabled&&reads==0);
    auto port=geometry03::unavailable_geometry_port();iq4::display::ViewMapping view;
    view.fullSourceMappingKnown=true;std::uint64_t epoch=123;
    assert(!port.actual_snapshot(port.context,0,view,epoch)&&!view.fullSourceMappingKnown&&epoch==0);
    geometry03::PaintScope scope;scope.actual_fresh_blit_verified=scope.surface_lease_verified=true;
    native_overlay::Receipt receipt;receipt.actual_native_image_blit_completed=true;
    assert(!geometry03::fresh_receipt_unavailable(scope,receipt)&&!receipt.actual_native_image_blit_completed);
    std::puts("3 production guard groups; zero native reads/calls");return 0;
}
