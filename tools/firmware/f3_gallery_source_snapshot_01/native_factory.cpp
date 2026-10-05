#include "gallery.hpp"
#include "pins.inc"
#include <cstring>
extern "C" void iq4_f3_gallery_guard_construct_01(void*,void*);
extern "C" void iq4_f3_gallery_guard_destroy_01(void*);
extern "C" void* iq4_f3_gallery_current_thread_01();
namespace iq4::gallery_source_01 {
bool native_factory(Memory m,NativeMutexApi&out) noexcept {
 out={};if(!m.read)return false;unsigned char a[64],b[64];
 for(const auto&p:GalleryPins01)if(p.bytes>64||m.read(m.context,p.va,a,p.bytes)!=1||
  m.read(m.context,p.va,b,p.bytes)!=1||std::memcmp(a,b,p.bytes)||std::memcmp(a,p.data,p.bytes))return false;
 out={iq4_f3_gallery_guard_construct_01,iq4_f3_gallery_guard_destroy_01,iq4_f3_gallery_current_thread_01,true};return true;
}
}
