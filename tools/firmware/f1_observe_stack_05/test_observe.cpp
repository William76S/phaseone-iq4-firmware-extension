#include <cassert>
#include "fixture.hpp"
#include <cstdio>
#include <fstream>
using namespace iq4::f1::stack05;
using test::Fixture;
namespace {
unsigned groups{};template<class F>void group(F f){f();++groups;}
bool absent(const Metadata&m){Facts zero{};return !m.graph_present&&!m.actual_popped_observer&&!m.normal_tail_dialog&&!m.selected_dialog_projection&&!std::memcmp(&zero,&m.facts,sizeof zero);}
void no_claims(const Metadata&m){assert(!m.native_current_called&&!m.paint_called&&!m.full_source_mapping_verified&&!m.fresh_blit_verified&&!m.surface_lease_verified&&!m.actual_scene_verified&&!m.reserved);}
bool first(Fixture&f,Metadata&m){Collector c(f.memory(),0);return c.capture(f.input,Fixture::waiting(),f.source(),4,m);}
}
int main(int argc,char**argv){
 group([]{Fixture f;Metadata m;assert(first(f,m)&&m.result==1&&m.shape==1&&m.graph_present&&m.source_relation==1&&m.facts.count==1&&m.selected_dialog_projection==f.live&&f.forbidden==0);no_claims(m);});
 group([]{Fixture f;Collector c(f.memory(),0);auto s=f.source();Metadata m;assert(c.capture(f.input,Fixture::waiting(),s,4,m));const auto prior=m;assert(!c.capture(f.input,Fixture::waiting(),s,4,m)&&!std::memcmp(&prior,&m,sizeof m));});
 group([]{Fixture f;f.chain({Fixture::a(f.home),f.live});auto s=f.source();Metadata m;Collector c(f.memory(),0);assert(s.phase==3&&c.capture(f.input,Fixture::waiting(),s,4,m)&&m.result==1&&m.shape==2&&m.source.phase==3&&m.facts.nodes[0].primary_vtable==0xb94fe8&&m.facts.nodes[0].kind==2);iq4::f1::observe04::Collector old(f.memory(),0);iq4::f1::observe04::Metadata g;assert(old.capture(f.input,s,4,g)&&g.result==1&&!g.scalar_present);no_claims(m);});
 group([]{Fixture f;Collector c(f.memory(),0);auto before=f.source();Metadata m;assert(c.capture(f.input,Fixture::waiting(),before,4,m));f.chain({f.live,f.popup});auto after=before;++after.rejected_boundaries;Fixture::put(Fixture::a(f.listener)+0x40,0x888880);assert(c.capture(f.input,before,after,4,m)&&m.result==1&&m.shape==3&&m.source_relation==2&&m.source_dispatch_epoch==1&&m.prior_source_dispatch_epoch==1&&m.snapshot_epoch==2&&m.source.phase==2&&m.source.original_stack.normal_count==1&&m.facts.count==2&&m.selected_dialog_projection==f.popup&&m.actual_popped_observer==0x888880);no_claims(m);});
 group([]{Fixture f;f.chain({Fixture::a(f.home),f.live});Collector c(f.memory(),0);auto s=f.source();Metadata m;assert(c.capture(f.input,Fixture::waiting(),s,4,m));f.chain({Fixture::a(f.home),f.live,f.popup});auto after=s;++after.rejected_boundaries;assert(c.capture(f.input,s,after,4,m)&&m.shape==4&&m.selected_dialog_projection==f.popup&&m.source.phase==3&&m.source_relation==2);});
 group([]{Fixture f;f.chain({Fixture::a(f.home),f.live});Fixture::put(Fixture::a(f.home),0x333330);Metadata m;assert(first(f,m)&&m.result==2&&m.graph_present&&m.shape==0&&m.facts.nodes[0].kind==0&&m.selected_dialog_projection==f.live);});
 group([]{Fixture f;f.chain({Fixture::a(f.home),f.live});Fixture::put(Fixture::a(f.home)+0x88,0x333330);Metadata m;assert(first(f,m)&&m.result==2&&m.facts.nodes[0].kind==0);});
 group([]{Fixture f;f.chain({Fixture::a(f.home),f.live});auto s=f.source();f.deny_home_table=true;Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,Fixture::waiting(),s,4,m)&&m.result==4&&absent(m));});
 group([]{Fixture f;f.chain({Fixture::a(f.home),f.live});auto s=f.source();f.deny_primary=true;Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,Fixture::waiting(),s,4,m)&&m.result==4&&absent(m));});
 group([]{Fixture f;f.chain({Fixture::a(f.home),f.live});auto s=f.source();f.move_primary=true;Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,Fixture::waiting(),s,4,m)&&m.result==5&&absent(m));});
 for(Address off:{0xc8,0xd8})group([off]{Fixture f;auto s=f.source();Fixture::put(f.manager+off,0x111110);Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,Fixture::waiting(),s,4,m)&&m.result==3&&absent(m));});
 group([]{Fixture f;auto s=f.source();Fixture::value(f.manager+0xe0,std::uint8_t(1));Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,Fixture::waiting(),s,4,m)&&m.result==3&&absent(m));});
 group([]{Fixture f;auto s=f.source();Fixture::put(f.manager+0x58,f.live+0x88);Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,Fixture::waiting(),s,4,m)&&m.result==3&&absent(m));});
 group([]{Fixture f;auto s=f.source();Fixture::put(f.live+0x98,0);Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,Fixture::waiting(),s,4,m)&&m.result==6&&absent(m));});
 group([]{Fixture f;auto s=f.source();Fixture::put(f.live+0x90,f.live+0x88);Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,Fixture::waiting(),s,4,m)&&m.result==6&&absent(m));});
 group([]{Fixture f;auto s=f.source();Fixture::put(f.manager+0x80,f.manager+0x78);Fixture::put(f.manager+0x88,f.manager+0x78);Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,Fixture::waiting(),s,4,m)&&m.result==6&&absent(m));});
 group([]{Fixture f;for(auto&e:f.extra)f.dialog(Fixture::a(e),0x444440,0x555550);f.chain({Fixture::a(f.extra[0]),Fixture::a(f.extra[1]),Fixture::a(f.extra[2]),Fixture::a(f.extra[3]),Fixture::a(f.extra[4]),Fixture::a(f.extra[5]),Fixture::a(f.extra[6]),f.live});Metadata m;assert(first(f,m)&&m.facts.count==8&&m.result==2);});
 group([]{Fixture f;auto s=f.source();for(auto&e:f.extra)f.dialog(Fixture::a(e),0x444440,0x555550);f.chain({Fixture::a(f.home),Fixture::a(f.extra[0]),Fixture::a(f.extra[1]),Fixture::a(f.extra[2]),Fixture::a(f.extra[3]),Fixture::a(f.extra[4]),Fixture::a(f.extra[5]),Fixture::a(f.extra[6]),f.live});Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,Fixture::waiting(),s,4,m)&&m.result==6&&absent(m));});
 group([]{Fixture f;auto s=f.source();Fixture::value(f.live+0xa8,std::uint8_t(1));Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,Fixture::waiting(),s,4,m)&&m.result==2&&m.graph_present&&m.shape==0&&m.facts.nodes[0].request_pending==1);});
 group([]{Fixture f;auto s=f.source();Fixture::value(f.live+0xa8,std::uint8_t(2));Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,Fixture::waiting(),s,4,m)&&m.result==6&&absent(m));});
 group([]{Fixture f;auto s=f.source();Fixture::put(f.input.frame_pointer,0);Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,Fixture::waiting(),s,4,m)&&m.result==3&&absent(m));});
 group([]{Fixture f;auto s=f.source();Fixture::put(f.thread+0x10,0);Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,Fixture::waiting(),s,4,m)&&m.result==3&&absent(m));});
 group([]{Fixture f;auto s=f.source();s.manager+=16;Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,Fixture::waiting(),s,4,m)&&m.result==5&&absent(m));});
 group([]{Fixture f;auto s=f.source();s.original_stack.node_vtables[0]+=8;Collector c(f.memory(),0);Metadata m;assert(c.capture(f.input,Fixture::waiting(),s,4,m)&&m.result==5&&absent(m));});
 for(unsigned mutation:{0,1,2,3,4})group([mutation]{Fixture f;auto s=f.source();if(mutation==0)s.sequence|=1;if(mutation==1)s.mask_enabled=1;if(mutation==2)s.native_mutating_calls=1;if(mutation==3)s.caller_pc+=4;if(mutation==4)s.dispatch_epoch=s.qualified_boundaries=2;Collector c(f.memory(),0);Metadata m;const auto n=f.reads;assert(!c.capture(f.input,Fixture::waiting(),s,4,m)&&f.reads==n);});
 group([]{Fixture f;auto s=f.source();Collector c(f.memory(),0);Metadata m;assert(!c.capture(f.input,Fixture::waiting(),s,0,m));auto before=s;before.phase=1;assert(!c.capture(f.input,before,s,4,m));});
 group([]{Fixture f;Collector c(f.memory(),0);Metadata m;auto before=Fixture::waiting();for(unsigned i=1;i<=64;++i){auto after=f.source(i);assert(c.capture(f.input,before,after,4,m));before=after;}assert(m.attempts==64&&!c.capture(f.input,before,f.source(65),4,m));});
 group([]{Fixture f;Collector c(f.memory(),0);Metadata m;auto s=f.source();assert(c.capture(f.input,Fixture::waiting(),s,4,m));Fixture::put(f.live+0x90,f.live+0x88);auto after=s;++after.rejected_boundaries;assert(c.capture(f.input,s,after,4,m)&&m.result==6&&absent(m)&&m.snapshot_epoch==1&&m.attempts==2);});
 if(argc==2){Fixture f;f.chain({Fixture::a(f.home),f.live});Collector c(f.memory(),0);Metadata m;const auto anchor=f.source();assert(c.capture(f.input,Fixture::waiting(),anchor,4,m));Published p;p.sequence.store(2);p.metadata=m;{std::ofstream out(argv[1],std::ios::binary);out.write(reinterpret_cast<const char*>(&p),sizeof p);assert(out.good());}
   f.chain({Fixture::a(f.home),f.live,f.popup});auto after=anchor;++after.rejected_boundaries;assert(c.capture(f.input,anchor,after,4,m));p.sequence.store(4);p.metadata=m;
   std::ofstream out(std::string(argv[1])+".prior.bin",std::ios::binary);out.write(reinterpret_cast<const char*>(&p),sizeof p);assert(out.good());}
 std::printf("%u Stack05 graph/source/relation/fault groups PASS; vendor/target execution zero\n",groups);return 0;
}
