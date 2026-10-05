#include "../native_copy_rtti_01/rtti.h"
#include "../native_copy_rtti_01/rtti_pins.inc"
#include <map>
#include <vector>
#include <cstring>
#include <cassert>
#include <cstdio>
static uintptr_t Base;
struct Fixture{
 std::map<uintptr_t,std::vector<unsigned char>>mem;int calls=0,fault=0,anchor_reads=0;
 Fixture(){for(const auto&s:RttiSpans01){auto&a=mem[s.address+(s.mode?Base:0)];a={s.data,s.data+s.bytes};
  for(uint32_t i=0;i<s.count;++i){const auto&r=s.relocs[i];uintptr_t value=r.address+(r.mode?Base:0)+r.addend;memcpy(a.data()+r.offset,&value,8);}
 }}
 void pointer(uintptr_t address,uintptr_t value){memcpy(mem.at(address).data(),&value,8);}
 static int read(void*v,uintptr_t a,void*out,size_t n){auto&f=*static_cast<Fixture*>(v);++f.calls;assert(n<=512);
  if(f.fault==13&&a==0xf429d8&&++f.anchor_reads==2)return 0;
  auto i=f.mem.upper_bound(a);if(i==f.mem.begin())return 0;--i;
  if(a-i->first>i->second.size()||n>i->second.size()-(a-i->first))return 0;
  memcpy(out,i->second.data()+a-i->first,n);if(f.fault==14&&a==0xf42a70&&f.calls%2==0)((unsigned char*)out)[0]^=1;return 1;
 }
};
static unsigned one_bias(){unsigned cases=0;for(int id=0;id<15;++id){Fixture f;f.fault=id;
 if(id==1)f.mem.erase(0xf429c8);if(id==2)f.mem.erase(0xf42ae0);if(id==3)f.mem.erase(0xf42a70);
 if(id==4)f.pointer(0xf429c8,1);if(id==5)f.mem[0xf429c8][8]^=1;if(id==6)f.mem[0xf429c8][24]^=4;
 if(id==7)f.mem[Base+0x8ee38][0]^=1;if(id==8)f.mem[Base][18]^=1;
 if(id==9)f.mem[Base+0x130d90][0]^=1; // exact int type-name symbol
 if(id==10)f.mem[0xf42a70][0]^=8;
 if(id==11){uintptr_t bad=Base+0x8ee39;memcpy(f.mem[0xf429c8].data()+16,&bad,8);}
 if(id==12)f.mem[0xf42ae0][24]^=1;
 int r=iq4_native_copy_rtti_current_01(&f,Fixture::read);assert(r==(id==0));++cases;
 }
 assert(!iq4_native_copy_rtti_current_01(nullptr,nullptr));++cases;
 return cases;
}
int main(){unsigned cases=0;for(unsigned page=0;page<16;++page){Base=UINT64_C(0x7000000000)+page*4096;cases+=one_bias();}
 printf("{\"cases\":%u,\"page_aligned_biases\":16,\"passed\":true,\"synthetic_loaded_memory\":true,\"target_executed\":false}\n",cases);
}
