#include "overlay.hpp"
// Compile-only own ABI probe: no constructor, addresses, installer or execution.
// The input function pointer is a type witness; no original function is supplied.
iq4::f1::native_overlay::Rectangle24 iq4_f1_Rectangle24_return_probe(
    iq4::f1::native_overlay::LVPaint original,void* LV,void* surface,
    const iq4::f1::native_overlay::Rectangle24* draw,
    iq4::f1::native_overlay::Rectangle24* clip) {
    return original(LV,surface,draw,clip);
}
