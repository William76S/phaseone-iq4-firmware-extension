// Reuse the frozen source-boundary host fixture, including its mock native
// containers/reader. This executes neither original RAW decode nor ICE.
#define main frozen_source_test_main
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wreturn-type"
#include "../f3_raw_file_source_01/test_source.cpp"
#pragma clang diagnostic pop
#undef main
#include "adapter.hpp"
#include <sys/wait.h>
namespace nr = iq4::native_render_02;
namespace {
unsigned fault=0, source_checks=0, sink_calls=0, join_calls=0, abort_calls=0;
unsigned settings_dtors=0, generator_dtors=0, image_dtors=0, constructions=0;
nr::Owner current_owner{};
bool held(void*,const void* input,void* tags,std::uint64_t id){++source_checks;return input&&tags&&id==77&&fault!=3&&!(fault==21&&source_checks>=3);}
bool pool_held(void*,const void* p){return p==reinterpret_cast<void*>(0x8888)&&fault!=4;}
void settings_ctor(void* p){++constructions;if(fault==22)throw 1;std::memset(p,0,0x2c8);put(p,0x150,std::uint32_t(0));put(p,0x58,std::uint64_t(0xfedcba9876543210));}
void settings_dtor(void* p){assert(*reinterpret_cast<std::uint64_t*>(static_cast<std::uint8_t*>(p)+0x58)==UINT64_C(0xfedcba9876543210));if(fault==29)throw 1;++settings_dtors;}
void gen_ctor(void* p,void* base,std::uint64_t n){++constructions;if(fault==23)throw 1;put(p,0x198,n-nr::PrefixBytes);put(p,0x1a0,reinterpret_cast<std::uintptr_t>(base)+nr::PrefixBytes+(fault==7?32:0));}
void gen_dtor(void*){if(fault==28)throw 1;++generator_dtors;}
void image_ctor(void* p){++constructions;if(fault==24)throw 1;std::memset(p,0,0x58);}
void image_dtor(void*){if(fault==27)throw 1;++image_dtors;}
void configure_source(void*,std::uint32_t sensor,void* tags){assert(sensor==31&&maps.count(tags));if(fault==25)throw 1;}
void configure_profile(void*,void* s,std::uint32_t slot){assert(slot==0);if(fault==26)throw 1;if(fault==8)put(s,0,std::uint32_t(0x3f000000));}
std::uint32_t process(void*,const void*,void* rgb,void*,void*,void*,const std::uint8_t*){
 if(fault==30)throw 1;
 auto* pixels=current_owner.arena+nr::PrefixBytes+192;
 for(unsigned i=0;i<128;++i)pixels[i]=static_cast<std::uint8_t>(i*13+5);
 put(rgb,0,pixels);put(rgb,8,current_owner.geometry.valid_width+(fault==15?1:0));
 put(rgb,12,current_owner.geometry.valid_height);put(rgb,16,std::uint32_t(fault==16?1:32));
 put(rgb,20,std::uint32_t(fault==17?3:5));
 if(fault==18)put(rgb,0,current_owner.arena+current_owner.capacity-4);
 if(fault==19)*const_cast<std::uint8_t*>(current_owner.cancel)=1;
 return fault==14?0:1;
}
void join(void*){++join_calls;if(fault==31)throw 1;}
const std::uint8_t* plane(const void* p){if(fault==32)throw 1;const std::uint8_t*v;std::memcpy(&v,p,8);return v;}
std::uint32_t get(const void*p,unsigned at){std::uint32_t v;std::memcpy(&v,static_cast<const std::uint8_t*>(p)+at,4);return v;}
std::uint32_t iw(const void*p){return get(p,8);}std::uint32_t ih(const void*p){return get(p,12);}
std::uint32_t istride(const void*p){return get(p,16);}std::uint32_t iformat(const void*p){return get(p,20);}
nr::Result begin(void*,const nr::Owner& o){current_owner=o;assert(o.input&&o.settings&&o.pool&&o.rgb32!=o.planar);return fault==9?nr::Result::Unbound:nr::Result::Ok;}
nr::Result end(void*,const nr::Owner& o,std::uint32_t actual,nr::Receipt& r){assert(o.generator==current_owner.generator);(void)actual;
 r={fault!=10,fault!=11,fault!=12,fault!=13,true};
 if(fault==31)r.decode_workers_joined=false;
 return fault==33?nr::Result::Hold:nr::Result::Ok;
}
nr::Result abort_joined(void*,const nr::Owner&){++abort_calls;return fault==33?nr::Result::Hold:nr::Result::Ok;}
f3_result sink(void*,const f3_plane* p){++sink_calls;assert(p->identity==77&&p->width==6&&p->height==4&&p->bytes_per_pixel==4);
 for(unsigned y=0;y<4;++y)for(unsigned x=0;x<24;++x)assert(p->allocation[p->plane_offset+y*p->stride+x]==static_cast<std::uint8_t>((y*32+x)*13+5));
 return fault==20?F3_NATIVE_FAILURE:F3_OK;
}
nr::NativeApi render_api(){return {fault!=1,true,settings_ctor,settings_dtor,gen_ctor,gen_dtor,image_ctor,image_dtor,
 configure_source,configure_profile,process,join,plane,iw,ih,istride,iformat};}
void one(unsigned f,const std::string& path,std::uint8_t* arena,std::uint64_t cap){
 fault=f;Session file(path);SourceBundle source(objects());assert(source.build(io,fd_for_open,file.info,file.stage,file.candidate,buffers())==SourceResult::Ok);
 const auto original_payload=payload;
 nr::SourceLease lease{&source,file.candidate,77,nullptr,held};
 nr::PoolLease pool{reinterpret_cast<void*>(0x8888),nullptr,pool_held};
 nr::Completion receipt{nullptr,true,begin,end,abort_joined};nr::Session render(render_api(),receipt);
 std::uint8_t cancel=0;
 if(f==6)lease.geometry.payload_bytes--;
 if(f==35){auto* raw=const_cast<NativeRawInputLayout*>(static_cast<const NativeRawInputLayout*>(source.raw_input()));
  raw->payload=arena;lease.geometry.payload=arena;}
 auto r=render.run(lease,pool,31,arena+(f==5?1:0),f==2?nr::PrefixBytes:cap,&cancel,sink,nullptr);
 auto state=render.state();
 nr::Result expected=nr::Result::Ok;
 if(f==1||f==9)expected=nr::Result::Unbound;
 if(f==2||f==7)expected=nr::Result::Capacity;
 if(f==3||f==8||f==21)expected=nr::Result::SourceLost;
 if(f==4||f==5)expected=nr::Result::Argument;
 if(f==35)expected=nr::Result::Argument;
 if(f==6)expected=nr::Result::Geometry;
 if(f==34)expected=nr::Result::UnsupportedProfile;
 if(f>=10&&f<=14)expected=nr::Result::Incomplete;
 if(f>=15&&f<=18)expected=nr::Result::Plane;
 if(f==19)expected=nr::Result::Incomplete;
 if(f==20)expected=nr::Result::Sink;
 if(f>=22&&f<=33)expected=nr::Result::Hold;
 if(r!=expected){std::cerr<<"adapter fault "<<f<<" got "<<int(r)<<" expected "<<int(expected)<<'\n';std::abort();}
 assert(payload==original_payload); // source material immutable through sink/failure
 if(r==nr::Result::Hold){assert(state.quarantined&&state.source_held);assert(render.cleanup()==nr::Result::Hold);}
 else{assert(!state.generator_alive&&!state.rgb32_alive&&!state.planar_alive&&!state.settings_alive&&!state.join_needed&&!state.source_held);assert(render.cleanup()==nr::Result::Ok);}
 if(f>=10&&f<=18)assert(sink_calls==0);
 if(f==0)assert(sink_calls==1&&image_dtors==2&&generator_dtors==1&&settings_dtors==1&&join_calls==0);
 if(f==12)assert(join_calls==1);
 if(f==31)assert(join_calls==1&&state.join_needed);
 if(f==35)assert(constructions==0&&sink_calls==0); // prefix must not clobber source
 // Host mocks own their synthetic objects; quarantined source dependencies
 // are deliberately retained rather than imitating a native target teardown.
 if(r!=nr::Result::Hold)assert(source.cleanup()==SourceResult::Ok);
}
}
int main(int argc,char**argv){assert(argc==2);
 nr::Attempt plan;Candidate actual{14308,10760,102,106,14204,10652,8,159899952,nullptr,nullptr};
 assert(nr::bounded_attempt(actual,2964893952ULL,plan)==nr::Result::Ok);
 assert(plan.decoded_reservation==308166400&&plan.lower_bound==2964893952ULL&&plan.core_min==2572841472ULL);
 assert(nr::bounded_attempt(actual,nr::PrefixBytes+308166400-1,plan)==nr::Result::Capacity);
 // A minimal mapping admits an attempted native call; it does not claim the
 // >=2.96GB core lower bound fits that mapping.
 assert(nr::bounded_attempt(actual,nr::PrefixBytes+308166400,plan)==nr::Result::Ok&&plan.mapped_bytes<plan.lower_bound);
 actual.valid_width=65500;assert(nr::bounded_attempt(actual,UINT64_MAX,plan)==nr::Result::Geometry);
 void* mem=nullptr;const std::uint64_t bytes=nr::PrefixBytes+1024*1024;assert(posix_memalign(&mem,32,bytes)==0);
 for(unsigned i=0;i<36;++i){pid_t pid=fork();assert(pid>=0);if(!pid){one(i,std::string(argv[1])+(i==34?"/custom-profile.iiq":"/little.iiq"),static_cast<std::uint8_t*>(mem),bytes);_exit(0);}int status=0;assert(waitpid(pid,&status,0)==pid);if(!WIFEXITED(status)||WEXITSTATUS(status)){std::cerr<<"adapter group "<<i<<" failed\n";return 1;}}
 free(mem);std::cout<<"{\"groups\":40,\"host_only\":true,\"native_vendor_code_executed\":false,\"camera_accessed\":false}\n";
}
