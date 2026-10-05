#include "native_api_bridge.h"
#include <array>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <string>
#include <vector>
static std::vector<std::string> passed;
static void check(bool v,const char *n) { if(!v){std::cerr<<n<<'\n';std::exit(1);}passed.emplace_back(n); }
struct Fake {
    bool throw_ctor=false,throw_dtor=false,throw_process=false,throw_join=false;
    bool proof=false,joined=true,identity_ok=true;
    unsigned ctor=0,dtor=0,process=0,joins=0,begins=0,ends=0;
    uint32_t vendor=1,claim_vendor=1;
    std::array<const void *,7> tuple{};
} f;
static void gc(void *,void *,uint64_t) { ++f.ctor;if(f.throw_ctor)throw 3; }
static void gd(void *) { ++f.dtor;if(f.throw_dtor)throw 4; }
static void ic(void *v) {
    for(unsigned i=0;i<F3_NATIVE_IMAGE_BUFFER_BYTES;++i)if(static_cast<uint8_t *>(v)[i])throw 5;
}
static void id(void *) { ++f.dtor;if(f.throw_dtor)throw 4; }
static void cs(void *,uint32_t,void *t) { ++*static_cast<int *>(t); }
static void cp(void *,void *,uint32_t) {}
static uint32_t process(void *g,const void *r,void *i,void *p,void *s,void *t,const uint8_t *c) {
    ++f.process;if(f.throw_process)throw 6;
    f.identity_ok=f.tuple==std::array<const void *,7>{g,r,i,p,s,t,c};return f.vendor;
}
static void join(void *) { ++f.joins;if(f.throw_join)throw 7; }
static const uint8_t *plane(const void *v) { return static_cast<const uint8_t *>(v); }
static uint32_t w(const void *) {return 3;} static uint32_t h(const void *) {return 2;}
static uint32_t stride(const void *) {return 32;} static uint32_t fmt(const void *) {return 5;}
static f3_result begin(void *,void *g,const void *r,void *i,void *p,void *s,void *t,const uint8_t *c) {
    ++f.begins;f.tuple={g,r,i,p,s,t,c};return F3_OK;
}
static f3_result end(void *,void *g,const void *r,void *i,void *p,void *s,void *t,const uint8_t *c,
                     uint32_t,f3_native_process_outcome *o) {
    ++f.ends;f.identity_ok=f.identity_ok&&f.tuple==std::array<const void *,7>{g,r,i,p,s,t,c};
    *o={f.claim_vendor,static_cast<uint32_t>(f.proof),static_cast<uint32_t>(f.joined)};return F3_OK;
}
int main() {
    f3_raw_api raw{1,1,gc,gd,ic,id,cs,cp,process,join,plane,w,h,stride,fmt};
    f3_completion_provider provider{nullptr,1,begin,end};f3_native_bridge b{};f3_native_ops o{};
    raw.cpp_unwind_verified=0;
    check(f3_native_bridge_init(&b,&raw,&provider,&o)==F3_NATIVE_UNBOUND&&f.ctor==0,
          "unverified C++ unwind cannot bind raw table");raw.cpp_unwind_verified=1;
    provider.all_paths_and_identity_verified=0;
    check(f3_native_bridge_init(&b,&raw,&provider,&o)==F3_NATIVE_UNBOUND,
          "one core receipt cannot attest whole process");provider.all_paths_and_identity_verified=1;
    check(f3_native_bridge_init(&b,&raw,&provider,&o)==F3_OK,"explicit table binds without resolving private address");
    union f3_generator_storage g{};union f3_image_storage i{},p{};std::array<uint8_t,32> backing{};
    f.throw_ctor=true;
    check(o.generator_construct(o.context,g.bytes,backing.data(),backing.size())==F3_NATIVE_FAILURE&&!b.live_generators,
          "constructor exception contained without complete-object destructor");f.throw_ctor=false;
    check(o.generator_construct(o.context,g.bytes,backing.data(),backing.size())==F3_OK&&
          f3_native_bridge_init(&b,&raw,&provider,&o)==F3_BAD_STATE,
          "active bridge cannot rebind API table");
    std::memset(i.bytes,0xa5,sizeof(i.bytes));std::memset(p.bytes,0xa5,sizeof(p.bytes));
    check(o.image_construct(o.context,i.bytes)==F3_OK&&o.image_construct(o.context,p.bytes)==F3_OK,
          "fresh native CIB ctor receives zero prior ref pointer");
    int tags=0,settings=0,pool=0,input=0;uint8_t cancel=0;
    check(o.configure_source(o.context,g.bytes,2,&tags)==F3_OK&&tags==1&&
          o.configure_profile(o.context,g.bytes,&settings,3)==F3_OK,
          "mutable owned tags forwarded into actual source configuration");
    f3_native_process_outcome outcome{};
    auto call=[&](){return o.process(o.context,g.bytes,&input,i.bytes,p.bytes,&settings,&pool,&cancel,&outcome);};
    check(call()==F3_NATIVE_FAILURE&&outcome.vendor_return==1&&!outcome.pixels_completed&&f.identity_ok,
          "native bool1 with attached descriptor cannot invent completion");
    f.proof=true;f.vendor=0;
    check(call()==F3_NATIVE_FAILURE&&outcome.vendor_return==0&&!outcome.pixels_completed,
          "completion provider cannot replace actual failed vendor return");f.vendor=1;
    check(call()==F3_OK&&outcome.pixels_completed==1&&outcome.workers_joined==1&&f.identity_ok,
          "all exact seven arguments retained between proof and raw call");
    f.joined=false;
    check(call()==F3_NATIVE_FAILURE&&!outcome.pixels_completed&&!outcome.workers_joined,
          "completed pixels without worker join cannot reach sink");f.joined=true;f.throw_process=true;
    unsigned before=f.ends;
    check(call()==F3_NATIVE_FAILURE&&f.ends==before&&!outcome.pixels_completed&&
          o.join_after_failure(o.context,&pool)==F3_OK,
          "thrown process requires explicit join and no end receipt");f.throw_process=false;
    int other=0;
    check(o.join_after_failure(o.context,&other)==F3_BAD_STATE,
          "foreign worker pool cannot be joined by this bridge");
    const uint8_t *pixels=nullptr;uint32_t width=0,height=0,s=0,format=0;
    check(o.plane(o.context,i.bytes,&pixels,&width,&height,&s,&format)==F3_OK&&
          pixels==i.bytes&&width==3&&height==2&&s==32&&format==5,
          "raw getters produce explicit plane contract");
    check(o.image_destroy(o.context,g.bytes)==F3_BAD_STATE&&o.generator_destroy(o.context,g.bytes)==F3_BAD_STATE,
          "foreign destruction and premature generator destruction rejected");
    check(o.image_destroy(o.context,p.bytes)==F3_OK&&o.image_destroy(o.context,i.bytes)==F3_OK&&
          o.generator_destroy(o.context,g.bytes)==F3_OK&&!b.live_images&&!b.live_generators,
          "image descriptors destroyed before their owned generator");
    check(o.generator_construct(o.context,g.bytes,backing.data(),backing.size())==F3_OK,
          "clean bridge can begin a subsequent serialized job");f.throw_dtor=true;
    before=f.dtor;
    check(o.generator_destroy(o.context,g.bytes)==F3_CLEANUP_FAILURE&&b.quarantined&&
          o.generator_destroy(o.context,g.bytes)==F3_CLEANUP_FAILURE&&f.dtor==before+1&&b.live_generators,
          "partial destructor throw quarantines retains and never repeats");
    std::cout<<"{\"schema\":\"iq4_f3_raw_api_bridge_host_fake_01\",\"passed\":"<<passed.size()
             <<",\"native_called\":false,\"raw_decoded\":false,\"cases\":[";
    for(size_t n=0;n<passed.size();++n)std::cout<<(n?",":"")<<'"'<<passed[n]<<'"';
    std::cout<<"]}\n";
}
