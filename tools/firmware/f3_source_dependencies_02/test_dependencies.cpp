#include "../f3_source_dependencies_01/dependencies.hpp"
#include "pins.hpp"
#include <cassert>
#include <cstdio>
#include <cstring>
#include <map>
#include <vector>
using namespace iq4::source_dependencies_01;
static constexpr std::uintptr_t IFM=0x1000000,Reader=0x1100000,FS=0x1200000,Manager=0x1300000,NM=0x1400000,Node=0x1500000;
struct Fixture {
 std::map<std::uintptr_t,std::vector<unsigned char>> sections;
 int scenario=0;unsigned field_reads=0;
 void put(std::uintptr_t a,std::uint64_t v){auto&b=sections[a];b.resize(8);std::memcpy(b.data(),&v,8);}
 Fixture(){for(const auto&p:Pins)sections[p.va]={p.data,p.data+p.bytes};
  put(0x8dc4c0,uint32_t(0x14000000u|((0x4240000-0x8dc4c0)/4)));
  put(IFM,0xb7ece0);put(IFM+0x4d8,Reader);put(Reader,0xd86708);put(Reader+0x18,0xdeadbeef);
  const std::size_t offsets[]={0x10,8,0x62bf8,0x62c00,0x62c08};
  for(unsigned i=0;i<5;++i){put(Reader+offsets[i],0x1600000+i*0x1000);put(0x1600000+i*0x1000,100+i);}
  put(FS,0xd91450);put(Manager+0x48,Node);put(Manager+0x38,NM);put(NM+0x320,IFM);
 }
 static int read(void*ctx,std::uintptr_t a,void*out,std::size_t n){auto&f=*static_cast<Fixture*>(ctx);
  if(f.scenario==6&&a==IFM+0x4d8&&++f.field_reads>3)f.put(IFM+0x4d8,Reader+0x1000);
  auto i=f.sections.upper_bound(a);if(i==f.sections.begin())return 0;--i;
  if(a<i->first||a-i->first>i->second.size()||n>i->second.size()-(a-i->first))return 0;
  std::memcpy(out,i->second.data()+(a-i->first),n);return 1;
 }
 Memory memory(){return {this,read};}
};
int main(){unsigned tests=0;
 for(int case_id=0;case_id<12;++case_id){Fixture f;f.scenario=case_id;Snapshot s{};
  if(case_id==1)f.sections[Pins[0].va][0]^=1;
  if(case_id==2)f.put(IFM,0xb7e030);
  if(case_id==3)f.put(Reader,0xd90410);
  if(case_id==4)f.put(Reader+0x62c00,0);
  if(case_id==5)f.sections.erase(0x1602000);
  auto r=snapshot_from_ifm(f.memory(),IFM,s);
  if(case_id>=1&&case_id<=6){assert(r!=Result::Ok);assert(!s.original_reader);}
  else{
   assert(r==Result::Ok&&s.original_reader==Reader&&s.ifm==IFM);
   iq4::raw_file_source_01::ConstructorInputs inputs{};
   assert(constructor_inputs(f.memory(),s,FS,inputs)==Result::Ok);
   assert(inputs.filesystem==reinterpret_cast<void*>(FS)&&inputs.module_a==s.module_a&&inputs.module_b==s.module_b);
   if(case_id==7){f.put(Manager+0x48,Node+8);assert(snapshot_from_raw_manager(f.memory(),Manager,Node,s)!=Result::Ok);}
   else if(case_id==8){f.put(Reader+0x62bf8,0x1604000);assert(recheck(f.memory(),s)==Result::Changing);}
   else if(case_id==9){f.put(Reader+0x18,0xaaaaaaaa);assert(recheck(f.memory(),s)==Result::Ok);assert(constructor_inputs(f.memory(),s,FS,inputs)==Result::Ok&&inputs.filesystem==reinterpret_cast<void*>(FS));}
   else if(case_id==10){f.put(FS,0xd90410);assert(constructor_inputs(f.memory(),s,FS,inputs)==Result::InvalidOwner&&!inputs.filesystem);}
   else if(case_id==11){assert(snapshot_from_ifm(f.memory(),UINTPTR_MAX-7,s)!=Result::Ok);assert(snapshot_from_raw_manager(f.memory(),Manager,Node,s)==Result::Ok);}
   else assert(snapshot_from_raw_manager(f.memory(),Manager,Node,s)==Result::Ok);
  }++tests;
 }
 for(unsigned i=0;i<5;++i){Fixture f;Snapshot out{};
  if(i==0)f.put(0x8dc4c0,uint32_t(0x14000000u|((0x4240004-0x8dc4c0)/4)));
  if(i==1)f.put(0x8dc4c0,uint32_t(0x94000000u|((0x4240000-0x8dc4c0)/4)));
  if(i==2)f.put(0x8dc4c0,uint32_t(0xf9002401));
  if(i==3)f.sections.erase(0x8dc4c0);
  if(i==4)f.sections[Pins[7].va][43]^=1;
  assert(snapshot_from_ifm(f.memory(),IFM,out)==Result::WrongImage&&!out.ifm);++tests;
 }
 std::printf("{\"cases\":%u,\"passed\":true,\"memory_and_native_owners_are_fixtures\":true,\"native_calls\":0,\"target_executed\":false}\n",tests);
}
