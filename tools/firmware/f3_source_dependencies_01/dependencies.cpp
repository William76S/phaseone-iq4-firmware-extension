#include "dependencies.hpp"
#include "pins.hpp"
#include <cstring>
namespace iq4::source_dependencies_01 {
namespace {
bool pointer(std::uintptr_t p) noexcept {return p && !(p&7);}
bool read(Memory m,std::uintptr_t p,void*out,std::size_t n) noexcept {
 if(!m.read||!p||!n||p>UINTPTR_MAX-n)return false;
 return m.read(m.context,p,out,n)==1;
}
bool twice(Memory m,std::uintptr_t p,void*out,std::size_t n) noexcept {
 unsigned char second[64];return n<=sizeof(second)&&read(m,p,out,n)&&
  read(m,p,second,n)&&!std::memcmp(out,second,n);
}
bool word(Memory m,std::uintptr_t p,std::uintptr_t&v) noexcept {
 return twice(m,p,&v,sizeof(v));
}
bool equal(const Snapshot&a,const Snapshot&b) noexcept {
 return a.ifm==b.ifm&&a.original_reader==b.original_reader&&
 a.module_a==b.module_a&&a.module_b==b.module_b&&a.metadata_a==b.metadata_a&&
 a.metadata_b==b.metadata_b&&a.metadata_c==b.metadata_c;
}
Result inspect(Memory m,std::uintptr_t ifm,Snapshot&out) noexcept {
 Snapshot s{};std::uintptr_t vt=0,p=0,reader=0;
 if(!pointer(ifm)||ifm>UINTPTR_MAX-0x7e8||!word(m,ifm,vt)||vt!=0xb7ece0||
    !word(m,ifm+0x4d8,reader)||!pointer(reader)||reader>UINTPTR_MAX-0x62c80||
    !word(m,reader,vt)||vt!=0xd86708)return Result::InvalidOwner;
 s.ifm=ifm;s.original_reader=reader;
 if(!word(m,reader+0x10,p)||!pointer(p))return Result::InvalidDependencies;
 s.module_a=reinterpret_cast<void*>(p);
 if(!word(m,reader+0x8,p)||!pointer(p))return Result::InvalidDependencies;
 s.module_b=reinterpret_cast<void*>(p);
 if(!word(m,reader+0x62bf8,p)||!pointer(p))return Result::InvalidDependencies;
 s.metadata_a=reinterpret_cast<void*>(p);
 if(!word(m,reader+0x62c00,p)||!pointer(p))return Result::InvalidDependencies;
 s.metadata_b=reinterpret_cast<void*>(p);
 if(!word(m,reader+0x62c08,p)||!pointer(p))return Result::InvalidDependencies;
 s.metadata_c=reinterpret_cast<void*>(p);
 // Every dependency must actually be readable while its process owner is held.
 // We do not interpret calibration/profile/key contents or claim a native lease.
 void* borrowed[]={s.module_a,s.module_b,s.metadata_a,s.metadata_b,s.metadata_c};
 for(auto q:borrowed){
  std::uint64_t opaque=0;if(!twice(m,reinterpret_cast<std::uintptr_t>(q),&opaque,8))
   return Result::InvalidDependencies;
 }
 if(!word(m,ifm,vt)||vt!=0xb7ece0||!word(m,ifm+0x4d8,p)||p!=reader||
    !word(m,reader,vt)||vt!=0xd86708)return Result::Changing;
 out=s;return Result::Ok;
}
}
bool original_prefixes(Memory m) noexcept {
 if(!m.read)return false;
 unsigned char b[64];for(const auto&p:Pins){
  if(p.bytes>sizeof(b)||!twice(m,p.va,b,p.bytes)||std::memcmp(b,p.data,p.bytes))return false;
 }return true;
}
Result snapshot_from_ifm(Memory m,std::uintptr_t ifm,Snapshot&out) noexcept {
 out={};if(!m.read)return Result::InvalidMemory;
 if(!original_prefixes(m))return Result::WrongImage;
 Snapshot a{},b{};auto r=inspect(m,ifm,a);if(r!=Result::Ok)return r;
 r=inspect(m,ifm,b);if(r!=Result::Ok)return r;
 if(!equal(a,b))return Result::Changing;out=a;return Result::Ok;
}
Result snapshot_from_raw_manager(Memory m,std::uintptr_t manager,std::uintptr_t node,
                                Snapshot&out) noexcept {
 out={};if(!pointer(manager)||manager>UINTPTR_MAX-0x50||!pointer(node))return Result::InvalidOwner;
 std::uintptr_t current=0,nm=0,ifm=0,again=0;
 if(!word(m,manager+0x48,current)||current!=node||
  !word(m,manager+0x38,nm)||!pointer(nm)||nm>UINTPTR_MAX-0x328||
  !word(m,nm+0x320,ifm)||!pointer(ifm))return Result::InvalidOwner;
 auto r=snapshot_from_ifm(m,ifm,out);if(r!=Result::Ok)return r;
 if(!word(m,manager+0x48,current)||current!=node||
  !word(m,manager+0x38,again)||again!=nm||
  !word(m,nm+0x320,again)||again!=ifm){out={};return Result::Changing;}
 return Result::Ok;
}
Result recheck(Memory m,const Snapshot&s) noexcept {
 Snapshot fresh{};auto r=snapshot_from_ifm(m,s.ifm,fresh);if(r!=Result::Ok)return r;
 return equal(s,fresh)?Result::Ok:Result::Changing;
}
Result constructor_inputs(Memory m,const Snapshot&s,std::uintptr_t fs,
                          raw_file_source_01::ConstructorInputs&out) noexcept {
 out={};std::uintptr_t vt=0;
 if(!pointer(fs)||!word(m,fs,vt)||vt!=0xd91450)return Result::InvalidOwner;
 auto r=recheck(m,s);if(r!=Result::Ok)return r;
 out={s.module_a,reinterpret_cast<void*>(fs),s.metadata_a,s.metadata_b,
      s.metadata_c,s.module_b};return Result::Ok;
}
} // namespace iq4::source_dependencies_01
