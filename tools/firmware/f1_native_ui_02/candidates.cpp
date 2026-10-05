#include "ui.hpp"
#include "entry_bytes.hpp"
#include <cstring>
namespace iq4::f1::native_ui02 {
bool resolve_static_candidates(Memory m,Address bias,Candidates&out)noexcept{
    out={};if(!m.read||bias>UINTPTR_MAX-0x710b3c)return false;
    for(const auto&e:EntryChecks){std::array<unsigned char,16>actual{};if(!m.read(m.context,bias+e.va,actual.data(),16)||actual!=e.bytes)return false;}
    out={reinterpret_cast<EventCtor>(bias+0x70f12c),reinterpret_cast<ObserverCtor>(bias+0x70fe3c),reinterpret_cast<Register>(bias+0x70fed8),reinterpret_cast<Register>(bias+0x70ff08),
         reinterpret_cast<SubMenuCtor>(bias+0x4e5744),reinterpret_cast<EventItemCtor>(bias+0x4e9d30),reinterpret_cast<Append>(bias+0x4e58b8),reinterpret_cast<SetMenu>(bias+0x4fb364),
         reinterpret_cast<Method>(bias+0x4e12c8),reinterpret_cast<Method>(bias+0x4e1320),reinterpret_cast<Invalidate>(bias+0x4ac06c),reinterpret_cast<void*(*)()>(bias+0x710b0c)};
    return true;
}
}
