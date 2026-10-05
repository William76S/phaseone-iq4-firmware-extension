#include "fixture.hpp"
#include <cassert>
#include <cstdio>
#include <fstream>
#include <limits>
using namespace iq4::f1::observe04;
namespace entry01=iq4::f1::entry01;
namespace native_ui02=iq4::f1::native_ui02;
namespace geometry03=iq4::f1::geometry03;
using iq4::f1::observe04::test::Fixture;
namespace {
unsigned groups{};template<class F>void group(F f){f();++groups;}
entry01::Observation source(Fixture&f,unsigned n=1){
    native_ui02::Boundary b{};assert(native_ui02::Inspector(f.memory(),0).boundary(f.input,b));
    entry01::Observation s{};s.sequence=2*n;s.phase=2;s.dispatch_epoch=s.qualified_boundaries=n;s.native_original_calls=n;
    s.queue=f.queue;s.manager=f.manager;s.data=Fixture::a(f.data);s.lv=f.live;s.popup=f.popup;s.popped_observer=b.popped_observer;
    s.caller_pc=f.input.caller_pc;s.frame_pointer=f.input.frame_pointer;s.thread_pointer=f.input.thread_pointer;s.mutex=f.input.mutex;
    s.local_bounds={0xb73b98,10,20,800,480};s.pan_x=-4;s.pan_y=7;s.scale=4;s.visible=s.running=1;
    assert(entry01::observe_stack(f.memory(),0,b.owner,s.original_stack));return s;
}
bool zero_facts(const Metadata&m){WireFacts zero{};return !std::memcmp(&zero,&m.facts,sizeof zero)&&!m.access&&!m.engine&&!m.buffer&&!m.scalar_present;}
void proofs_zero(const Metadata&m){assert(!m.paint_scope_called&&!m.full_source_mapping_verified&&!m.fresh_blit_verified&&!m.surface_lease_verified&&!m.reserved);}
}
int main(int argc,char**argv){
  group([]{Fixture f;Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,source(f),4,m));assert(m.result==0&&m.scalar_present==1&&m.attempts==1&&m.geometry_epoch==1&&m.source_dispatch_epoch==1&&m.successes==1&&!m.rejected);assert(m.engine==Fixture::a(f.engine)&&m.buffer==f.buffer&&m.access==Fixture::a(f.access));assert(m.facts.config_width==3200&&m.facts.config_height==2400&&m.facts.pan_x==-4&&m.facts.locked_slot==4&&m.facts.consistent_double_read==1&&f.forbidden==0);proofs_zero(m);});
  group([]{Fixture f;f.slot();Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,source(f),4,m)&&m.facts.locked_slot==1&&m.facts.locked_metadata_present==1&&m.facts.slot_width==1024&&m.facts.slot_height==764&&m.facts.software_completion_id==17&&m.facts.locked_roi.width==3200&&f.forbidden==0);proofs_zero(m);});
  group([]{Fixture f;auto s=source(f);Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,s,4,m));Metadata unchanged=m;assert(!c.capture(f.input,s,4,m)&&!std::memcmp(&m,&unchanged,sizeof m));});
  group([]{Fixture f;Collector c(f.memory(),0);Metadata m;assert(!c.capture(f.input,source(f,2),4,m));});
  group([]{Fixture f;Collector c(f.memory(),0);Metadata m;assert(!c.capture(f.input,source(f),0,m)&&f.forbidden==0);});
  group([]{Fixture f;auto s=source(f);s.sequence|=1;Collector c(f.memory(),0);Metadata m;assert(!c.capture(f.input,s,4,m));});
  group([]{Fixture f;auto s=source(f);s.mask_enabled=1;Collector c(f.memory(),0);Metadata m;assert(!c.capture(f.input,s,4,m));});
  group([]{Fixture f;auto s=source(f);s.native_mutating_calls=1;Collector c(f.memory(),0);Metadata m;assert(!c.capture(f.input,s,4,m));});
  group([]{Fixture f;auto s=source(f);s.caller_pc++;Collector c(f.memory(),0);Metadata m;assert(!c.capture(f.input,s,4,m));});
  group([]{Fixture f;auto s=source(f);f.input.original_result=1;Collector c(f.memory(),0);Metadata m;assert(!c.capture(f.input,s,4,m));});
  group([]{Fixture f;auto s=source(f);f.input.frame_pointer=0;Collector c(f.memory(),0);Metadata m;assert(!c.capture(f.input,s,4,m));});
  group([]{Fixture f;auto s=source(f);Fixture::put(f.thread+0x10,0);Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,s,4,m)&&m.result==1&&zero_facts(m));});
  group([]{Fixture f;auto s=source(f);Fixture::put(f.live,0x999999);Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,s,4,m)&&m.result==1&&zero_facts(m));});
  group([]{Fixture f;auto s=source(f);Fixture::put(f.input.frame_pointer,0);Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,s,4,m)&&m.result==1&&zero_facts(m));});
  group([]{Fixture f;auto s=source(f);Fixture::put(Fixture::a(f.data)+0x118,0);Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,s,4,m)&&m.result==2&&zero_facts(m));});
  group([]{Fixture f;auto s=source(f);f.changing=true;Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,s,4,m)&&m.result==3&&zero_facts(m));});
  group([]{Fixture f;auto s=source(f);Fixture::value(f.live+0x190,std::numeric_limits<float>::quiet_NaN());Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,s,4,m)&&m.result==4&&zero_facts(m));});
  group([]{Fixture f;auto s=source(f);Fixture::value(f.buffer+0xe8,std::uint32_t(5));Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,s,4,m)&&m.result==4&&zero_facts(m));});
  group([]{Fixture f;Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,source(f),4,m));f.changing=true;assert(c.capture(f.input,source(f,2),4,m)&&m.result==3&&m.attempts==2&&m.geometry_epoch==1&&m.successes==1&&m.rejected==1&&zero_facts(m));});
  group([]{Fixture f;auto s=source(f);Fixture::value(f.live+0x118,geometry03::Point8{-3,7});Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,s,4,m)&&m.result==3&&zero_facts(m));});
  group([]{Fixture f;auto s=source(f);s.scale=2;Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,s,4,m)&&m.result==3&&zero_facts(m));});
  group([]{Fixture f;Collector c(f.memory(),0);Metadata m;for(unsigned i=1;i<=64;++i)assert(c.capture(f.input,source(f,i),4,m));assert(m.attempts==64&&m.successes==64&&m.geometry_epoch==64&&!c.capture(f.input,source(f,65),4,m));});
  group([]{Fixture f;auto s=source(f);s.queue=UINTPTR_MAX-7;Collector c(f.memory(),0);Metadata m;assert(!c.capture(f.input,s,4,m));});
  group([]{Fixture f;auto s=source(f);s.original_stack.dialogs[7]=f.live;Collector c(f.memory(),0);Metadata m;assert(!c.capture(f.input,s,4,m));});
  group([]{Fixture f;Fixture::put(f.live+0x188,0xdeadbeef);Fixture::value(f.live+0x1c0,std::uint8_t(1));Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,source(f),4,m)&&m.facts.borrowed_pointer_present==1&&m.facts.retain_borrowed==1&&f.forbidden==0);const auto*p=reinterpret_cast<const unsigned char*>(&m);for(std::size_t n=0;n+8<=sizeof m;++n){std::uint64_t v{};std::memcpy(&v,p+n,8);assert(v!=0xdeadbeef);}proofs_zero(m);});
  group([]{Fixture f;auto s=source(f);/* Separate owned LV-array leaf models Home below LV. */const auto dialog=f.live+0x1000,node=dialog+0x88;Fixture::put(dialog,0x555550);Fixture::put(dialog+0xb0,f.manager);Fixture::put(node,0x666660);Fixture::put(node+8,f.live+0x88);Fixture::put(node+16,f.manager+0x78);Fixture::put(node+24,dialog);Fixture::put(f.manager+0x80,node);Fixture::put(f.live+0x98,node);native_ui02::Boundary b;assert(native_ui02::Inspector(f.memory(),0).boundary(f.input,b));assert(entry01::observe_stack(f.memory(),0,b.owner,s.original_stack));s.phase=3;Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,s,4,m)&&m.result==1&&zero_facts(m)&&m.source.original_stack.normal_count==2);});
  group([]{Fixture f;Fixture::put(f.live+8,0x777777);Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,source(f),4,m)&&m.result==0&&!m.facts.recursive_bounds_candidate_present);proofs_zero(m);});
  group([]{Metadata m;assert(m.bytes==744&&m.result==8&&m.exact_user_bytes==11874544&&zero_facts(m));Published p;assert(p.bytes==760&&p.schema==4&&p.sequence.load()==0);});
  group([]{Fixture f;auto s=source(f);struct Moving {Fixture*f{};unsigned engine_reads{};static bool read(void*p,Address a,void*b,std::size_t n)noexcept{auto&v=*static_cast<Moving*>(p);if(!Fixture::read(v.f,a,b,n))return false;if(a==Fixture::a(v.f->access)+8&&n==8&&++v.engine_reads==4){const Address changed=Fixture::a(v.f->engine)+16;std::memcpy(b,&changed,8);}return true;}}moving{&f,0};Collector c({&moving,Moving::read},0);Metadata m;assert(c.capture(f.input,s,4,m)&&m.result==3&&zero_facts(m)&&moving.engine_reads==4);});
  group([]{Fixture f;auto s=source(f);s.manager+=16;Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,s,4,m)&&m.result==3&&zero_facts(m));});
  group([]{Fixture f;const auto s=source(f);Collector c({},0);Metadata m;const auto count=f.reads;assert(!c.capture(f.input,s,4,m));assert(f.reads==count);proofs_zero(m);});
  group([]{Fixture f;Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,source(f),4,m));f.changing=true;assert(c.capture(f.input,source(f,2),4,m)&&m.result==3&&zero_facts(m));f.changing=false;assert(c.capture(f.input,source(f,3),4,m)&&m.result==0&&m.geometry_epoch==2&&m.source_dispatch_epoch==3&&m.attempts==3&&m.rejected==1);});
  if(argc==2){Fixture f;f.slot();Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,source(f),4,m));Published p;p.sequence.store(2);p.metadata=m;std::ofstream out(argv[1],std::ios::binary);out.write(reinterpret_cast<const char*>(&p),sizeof p);assert(out.good());}
  std::printf("%u Geo04 scalar/source/epoch/failure groups PASS; vendor/target execution zero\n",groups);return 0;
}
