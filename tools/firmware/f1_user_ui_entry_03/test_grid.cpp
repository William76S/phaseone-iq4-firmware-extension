#include "entry_binding_10.hpp"
#include "display_grid.hpp"
#include <cassert>
#include <cstring>
#include <map>
using namespace iq4::f1::native_ui02;
namespace {
struct OwnedMemory{
 std::map<Address,unsigned char>bytes;
 template<class T>void put(Address a,T v){const auto*p=reinterpret_cast<const unsigned char*>(&v);for(unsigned i=0;i<sizeof v;++i)bytes[a+i]=p[i];}
 void word(Address a,Address v){put(a,v);}
 static bool read(void*v,Address a,void*p,std::size_t n)noexcept{
  auto&m=*static_cast<OwnedMemory*>(v);auto*out=static_cast<unsigned char*>(p);
  for(std::size_t i=0;i<n;++i){auto it=m.bytes.find(a+i);if(it==m.bytes.end())return false;out[i]=it->second;}return true;
 }
};
OwnedMemory*active{};
bool read_self(void*,Address a,void*p,std::size_t n)noexcept{return OwnedMemory::read(active,a,p,n);}
using iq4::f1::entry10::Placement;
#include "runtime_placement_fixture.inc"
constexpr Address LV=0x10000,Grid=0x20000,Button=0x30000;
void child(OwnedMemory&m,Address a,Address parent,Address prev,Address next,Rectangle24 r,unsigned char visible){
 m.word(a+8,parent);m.word(a+0x10,0);m.word(a+0x18,prev);m.word(a+0x20,next);m.put(a+0x28,r);m.put(a+0x6f,visible);m.put(a+0x41,static_cast<unsigned char>(0));m.put(a+0x42,static_cast<unsigned char>(0));m.word(a+0x60,0);
}
OwnedMemory base(unsigned char visible=1){
 OwnedMemory m;m.put(LV+0x28,Rectangle24{0xb73b98,0,0,512,512});m.word(LV+0x10,Grid);m.word(LV+0xd48,Grid);
 child(m,Grid,LV,0,0,{0xb73b98,0,0,512,512},visible);m.word(Grid,0xba6540);m.word(0xba6540+0x140,0x4ac32c);m.word(0xba6880+0x140,0x4ac32c);
 const Address first=0x40000;m.word(Grid+0x10,first);
 for(unsigned i=0;i<5;++i){Address a=first+0x100*i;m.word(Grid+0xa0+i*8,a);child(m,a,Grid,i?a-0x100:0,i==4?0:a+0x100,{0xb73b98,0,0,512,1},1);m.word(a,0xba6880);}
 return m;
}
}
namespace iq4::f1::entry10 {
struct OwnedFixture{
 static bool clear(Binding&b,Memory m,Address lv,Placement pos){b.memory_=m;b.owner_.lv=lv;b.placement_=pos;return b.free_placement();}
};
}
int main(){
 Owner o{};o.lv=LV;Placement out{};iq4::f1::entry10::Binding b;
 auto verify=[&](OwnedMemory&m,bool pass,int x=0,int y=0){active=&m;out={};bool found=free_placement(o,out);assert(found==pass);if(pass){assert(out.x==x&&out.y==y);assert(iq4::f1::entry10::OwnedFixture::clear(b,{&m,OwnedMemory::read},LV,out));}};
 auto m=base();verify(m,true); // Grid on: real full-image Rect is display only.
 m=base(0);verify(m,true); // Grid off leaves original visibility unchanged.
 m=base();m.word(Grid+0x20,Button);child(m,Button,LV,Grid,0,{0xb73b98,0,0,128,128},1);verify(m,true,128,0);
 assert(!iq4::f1::entry10::OwnedFixture::clear(b,{&m,OwnedMemory::read},LV,{0,0}));
 m.put(Button+0x28,Rectangle24{0xb73b98,0,0,512,512});verify(m,false); // Other full-image controls remain occupied.
 m=base();m.put(Grid+0x41,static_cast<unsigned char>(1));verify(m,false);
 m=base();m.put(0x40000+0x42,static_cast<unsigned char>(1));verify(m,false);
 m=base();m.word(Grid+0x60,0x60000);verify(m,false);
 m=base();m.word(0x40000+0x60,0x60000);verify(m,false);
 m=base();m.word(Grid,0xba6880);verify(m,false);
 m=base();m.word(LV+0xd48,Grid+8);verify(m,false);
 m=base();m.word(0x40400+0x20,0x50000);verify(m,false); // No uninspected sixth child.
 m=base();m.word(0x40000+0x10,0x50000);verify(m,false); // No uninspected descendant.
 m=base();m.word(0x40100+0x18,0);verify(m,false);
 m=base();m.word(Grid+0xb0,0x40000);verify(m,false);
 m=base();m.word(0xba6880+0x140,0x4ac32c+4);verify(m,false);
 m=base();m.bytes.erase(0x40000+0x41);verify(m,false);
 // Production mode 2 is deliberately not inferred from flags41/42.
}
