#include "observe.hpp"
#include "../f1_observe_stack_05/fixture.hpp"
#include <cassert>
#include <cstdio>
#include <cerrno>
#include <cstring>
#include <fstream>
using namespace iq4::f1;
namespace d=display06;
using namespace native_ui02;
struct Fixture:stack05::test::Fixture {
 alignas(16)std::array<unsigned char,32>provider{},provider_vt{},wrapper{},resource{};
 alignas(16)std::array<unsigned char,0x90>header{};
 Address shadow{};bool corrupt_original{},corrupt_shadow{},deny_provider{},partial_prefix{};unsigned provider_reads{};bool changing_provider{};
 Fixture(){add(provider);add(provider_vt);add(wrapper);add(resource);add(header);
  put(manager+0x108,a(provider));put(queue+0x9c8,a(provider));put(a(provider),a(provider_vt));put(a(provider_vt)+0x18,0x456780);put(a(provider_vt)+0x10,0x456790);
  put(manager+0x788,a(wrapper));put(live+0xf0,a(wrapper));put(a(wrapper)+0x10,a(resource));put(a(resource),0x778880);
  put(popup+0xe0,a(header));value(a(header)+0x88,std::uint32_t(42));
 }
 static bool read06(void*p,Address at,void*out,std::size_t n)noexcept {
  auto&f=*static_cast<Fixture*>(p);
  if(at==0xb9a9c8&&n==488){auto words=d::OriginalLVTable;if(f.corrupt_original)++words[8];std::memcpy(out,words.data(),n);return true;}
  if(f.shadow&&at>=f.shadow-16&&n<=488&&at-(f.shadow-16)<=488-n){std::memcpy(out,reinterpret_cast<const void*>(at),n);if(f.corrupt_shadow&&at==f.shadow-16&&n==488)static_cast<Address*>(out)[3]^=8;return true;}
  if(at==a(f.provider_vt)+0x18&&n==8){if(f.deny_provider)return false;if(f.changing_provider&&++f.provider_reads==2){Address v=0x456788;std::memcpy(out,&v,8);return true;}}
  if(at==0x456780&&n==16&&f.partial_prefix){std::memset(out,0xa5,8);return false;}
  return stack05::test::Fixture::read_stack(p,at,out,n);
 }
 Memory memory(){return {this,read06};}
 stack05::Metadata source_meta(){stack05::Collector c(memory(),0);stack05::Metadata s{};assert(c.capture(input,waiting(),source(),4,s)&&s.result==1);return s;}
 void permit_shadow(d::Collector&c){shadow=c.shadow_address_point();assert(shadow);}
};
namespace {
unsigned groups{},calls{};bool throw_original{},mutate_provider{};Fixture* active{};
Rectangle24 original(void*lv,void*surface,const Rectangle24*draw,Rectangle24*clip){
 assert(active&&lv==reinterpret_cast<void*>(active->live)&&surface==reinterpret_cast<void*>(Fixture::a(active->surface))&&draw==reinterpret_cast<Rectangle24*>(active->paint.draw_rectangle)&&clip==reinterpret_cast<Rectangle24*>(active->paint.clip_rectangle));
 ++calls;errno=73;if(mutate_provider)Fixture::put(Fixture::a(active->provider_vt)+0x18,0x4567a0);if(throw_original)throw 17;return {0xb73b98,1,2,3,4};
}
Rectangle24 run(Fixture&f,d::Collector*c,d::Published*p=nullptr){active=&f;return d::forward_once(original,reinterpret_cast<void*>(f.live),reinterpret_cast<void*>(Fixture::a(f.surface)),reinterpret_cast<Rectangle24*>(f.paint.draw_rectangle),reinterpret_cast<Rectangle24*>(f.paint.clip_rectangle),c,&f.paint,p);}
template<class F>void group(F f){f();++groups;}
void no_claims(const d::Metadata&m){assert(!m.mask_enabled&&!m.full_source_mapping_verified&&!m.fresh_blit_verified&&!m.surface_lease_verified&&!m.native_provider_getter_called&&!m.native_fill_called&&!m.native_ui_mutation_called);}
void bind(Fixture&f,d::Collector&c){f.permit_shadow(c);d::Metadata m{};assert(c.capture_boundary(f.input,f.source_meta(),m)&&m.result==1&&m.owner_present&&m.geometry_present);no_claims(m);}
}
int main(int argc,char**argv){
 group([]{Fixture f;d::Collector c(f.memory(),0,0x333330);bind(f,c);auto m=c.snapshot();assert(m.owner_after.provider==Fixture::a(f.provider)&&m.owner_after.getter_target==0x456780&&m.owner_after.provider_alias_equal&&m.owner_after.resource_alias_equal&&m.owner_after.popup_title==42&&m.geometry_after.scalars.locked_slot==4&&m.geometry_after.config_point_model_valid);assert(f.forbidden==0);});
 group([]{Fixture f;f.chain({Fixture::a(f.home),f.live});d::Collector c(f.memory(),0,0x333330);bind(f,c);assert(c.snapshot().owner_after.stack_shape==2&&c.snapshot().geometry_present);});
 group([]{Fixture f;f.slot();d::Collector c(f.memory(),0,0x333330);bind(f,c);auto g=c.snapshot().geometry_after;assert(g.scalars.locked_metadata_present&&g.config_equals_roi&&!g.slot_equals_roi&&!g.config_equals_slot);});
 group([]{Fixture f;f.corrupt_original=true;d::Collector c(f.memory(),0,0x333330);d::Metadata m{};assert(!c.shadow_address_point()&&c.capture_boundary(f.input,f.source_meta(),m)&&m.result==8&&!m.owner_present);});
 group([]{Fixture f;d::Collector c(f.memory(),1,0x333330);assert(!c.shadow_address_point());});
 group([]{Fixture f;d::Collector c(f.memory(),0,0x333330);bind(f,c);d::Metadata m{};assert(c.capture_boundary(f.input,f.source_meta(),m)&&m.result==7&&!m.geometry_present);});
 group([]{Fixture f;d::Collector c(f.memory(),0,0x333330);auto s=f.source_meta();s.full_source_mapping_verified=1;d::Metadata m{};assert(c.capture_boundary(f.input,s,m)&&m.result==7&&!m.geometry_present);no_claims(m);});
 group([]{Fixture f;f.deny_provider=true;d::Collector c(f.memory(),0,0x333330);f.permit_shadow(c);d::Metadata m{};assert(c.capture_boundary(f.input,f.source_meta(),m)&&m.result==3&&!m.owner_present&&!m.geometry_present);});
 group([]{Fixture f;f.changing_provider=true;d::Collector c(f.memory(),0,0x333330);f.permit_shadow(c);d::Metadata m{};assert(c.capture_boundary(f.input,f.source_meta(),m)&&m.result==4&&!m.owner_present);});
 group([]{Fixture f;d::Collector c(f.memory(),0,0x333330);bind(f,c);calls=0;d::Published p;errno=31;auto r=run(f,&c,&p);assert(calls==1&&errno==73&&r.x==1&&r.y==2&&r.width==3&&r.height==4&&p.metadata.paint_present&&p.metadata.paint.original_returned_normally&&p.metadata.paint.surface_metadata_equal&&p.metadata.paint.geometry_equal_before_after);no_claims(p.metadata);assert(f.forbidden==0);});
 group([]{Fixture f;d::Collector c(f.memory(),0,0x333330);bind(f,c);Fixture::put(f.live,c.shadow_address_point());calls=0;d::Published p;(void)run(f,&c,&p);assert(calls==1&&p.metadata.paint_present&&p.metadata.owner_before.shadow_instance&&p.metadata.owner_after.shadow_instance);no_claims(p.metadata);});
 group([]{Fixture f;d::Collector c(f.memory(),0,0x333330);bind(f,c);Fixture::put(f.live,c.shadow_address_point());f.corrupt_shadow=true;calls=0;d::Published p;(void)run(f,&c,&p);assert(calls==1&&!p.metadata.paint_present&&p.metadata.result==2);});
 group([]{Fixture f;d::Collector c(f.memory(),0,0x333330);bind(f,c);f.paint.caller_pc+=4;calls=0;d::Published p;(void)run(f,&c,&p);assert(calls==1&&!p.metadata.paint_present&&p.metadata.result==6);});
 group([]{Fixture f;d::Collector c(f.memory(),0,0x333330);bind(f,c);Fixture::put(f.manager_frame+0x148,0x111110);calls=0;d::Published p;(void)run(f,&c,&p);assert(calls==1&&!p.metadata.paint_present);});
 group([]{Fixture f;d::Collector c(f.memory(),0,0x333330);bind(f,c);Fixture::value(f.live+0x1b8,std::uint32_t(2));calls=0;d::Published p;(void)run(f,&c,&p);assert(calls==1&&p.metadata.paint_present&&p.metadata.geometry_before.scalars.countdown==2);no_claims(p.metadata);});
 group([]{Fixture f;d::Collector c(f.memory(),0,0x333330);bind(f,c);calls=0;mutate_provider=true;d::Published p;(void)run(f,&c,&p);mutate_provider=false;assert(calls==1&&p.metadata.result==4&&!p.metadata.paint_present&&p.metadata.paint.original_returned_normally);no_claims(p.metadata);});
 group([]{Fixture f;d::Collector c(f.memory(),0,0x333330);bind(f,c);calls=0;throw_original=true;d::Published p;bool caught=false;try{(void)run(f,&c,&p);}catch(int n){caught=n==17;}throw_original=false;assert(caught&&calls==1&&errno==73&&!p.metadata.paint_present&&!p.metadata.paint.original_returned_normally&&p.metadata.result==5);});
 group([]{Fixture f;d::Collector c(f.memory(),0,0x333330);bind(f,c);calls=0;for(unsigned j=0;j<65;++j)(void)run(f,&c);assert(calls==65&&c.snapshot().paint_attempts==64);no_claims(c.snapshot());});
 group([]{Fixture f;calls=0;errno=44;auto r=run(f,nullptr);assert(calls==1&&errno==73&&r.width==3);});
 group([]{Fixture f;d::Collector c(f.memory(),0,0x333330);bind(f,c);Fixture::value(f.live+0x190,0.0F);calls=0;d::Published p;(void)run(f,&c,&p);assert(calls==1&&!p.metadata.paint_present&&p.metadata.result==5);});
 group([]{Fixture f;f.partial_prefix=true;d::Collector c(f.memory(),0,0x333330);bind(f,c);auto o=c.snapshot().owner_after;unsigned char zero[16]{};assert(!o.getter_prefix_present&&!std::memcmp(o.getter_first16,zero,16));});
 if(argc==2){Fixture f;d::Collector c(f.memory(),0,0x333330);bind(f,c);d::Published p;(void)run(f,&c,&p);std::ofstream out(argv[1],std::ios::binary);out.write(reinterpret_cast<const char*>(&p),sizeof p);assert(out.good());}
 std::printf("%u display06 owned boundary/paint/forwarding/fault groups PASS; native/target execution zero\n",groups);return 0;
}
