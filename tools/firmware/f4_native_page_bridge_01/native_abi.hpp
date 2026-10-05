#pragma once
#include <cstddef>
#include <cstdint>
namespace iq4::f4::page::native_static {
// Static types only. No casts from addresses, constructor, hook or calls.
// Linked VA are labels for the exact User SHA, not a runtime binder.
inline constexpr char UserSHA[]="9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb";
struct Rectangle24 { const void* address_point; std::int32_t x,y,width,height; };
static_assert(sizeof(Rectangle24)==24&&offsetof(Rectangle24,x)==8&&offsetof(Rectangle24,width)==16);
using DialogConstruct=void (*)(void*,const char*,void*);
using DialogShowClose=void (*)(void*);
using Paint=Rectangle24 (*)(void*,void*,const Rectangle24*,Rectangle24*);
// AAPCS64 Rectangle24 return uses x8. Rectangle has its native address point;
// caller cannot substitute a four-int struct or void-returning paint.
using ControlNotify=void (*)(void*,void*,const void*,std::uint32_t);
using KeyDown=bool (*)(void*,std::uint32_t,std::uint64_t);
using KeyUpRepeat=bool (*)(void*,std::uint32_t,std::uint64_t,std::uint32_t,std::uint32_t);
using MenuLabel16=void (*)(void*,const void*);
inline constexpr std::uintptr_t DialogCtorVA=0x4e10c4,DialogShowVA=0x4e12c8,DialogCloseVA=0x4e1320;
inline constexpr std::uintptr_t ControlObserverVA=0x4ac590,PaintLVVA=0x51da0c,MenuLabel16VA=0x4e8578;
inline constexpr std::size_t DialogBaseBytes=0xd0,NativeLVBytes=0x1310,IconButtonBytes=0xc8;
// Base size does not establish custom-page vtable, child ownership, title/
// resource ABI, full simple Button size, Undo or allocator. No instantiation.
}
