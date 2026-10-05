#include "adapter.hpp"
#include <cassert>
#include <cstring>
#include <iostream>
#include <map>
#include <stdexcept>
#include <thread>
#include <vector>
using namespace iq4::f4;
using namespace iq4::f4::native_metadata;
namespace {
struct Sim {
    static Sim*active;
    std::map<Address,std::uint8_t>mem;
    std::vector<std::uint8_t>pixels=std::vector<std::uint8_t>(8*6*3,37);
    Address q=0x100000,m=0x200000,d=0x300000,lv=0x400000,ac=0x500000,en=0x600000;
    std::uint64_t ns=100;unsigned locks=0,unlocks=0;bool throw_lock=false,partial_lock=false,throw_size=false;
    bool false_unlock=false,throw_unlock=false,partial_release_read=false,owner_changes=false,bad_id=false,reenter=false;
    Adapter*a{};Result nested=Result::Disabled;Address denied=0;
    template<class T>void put(Address p,T value){const auto*b=reinterpret_cast<const std::uint8_t*>(&value);for(std::size_t i=0;i<sizeof(T);++i)mem[p+i]=b[i];}
    template<class T>T get(Address p){T v{};auto*b=reinterpret_cast<std::uint8_t*>(&v);for(std::size_t i=0;i<sizeof(T);++i)b[i]=mem.at(p+i);return v;}
    Address vb()const{return en+0x2170;}
    Sim(){active=this;put(q,Address(0xb91f48));put(q+0x1c8,m);put(m,Address(0xb8f358));put(m+8,q);
        put(q+0x9b8,d);put(m+0x790,d);put(q+0x8c0,lv);put(lv,Address(0xb9a9d8));put(d+0x118,ac);
        put(lv+0x108,ac);put(ac,Address(0xc07da8));put(ac+8,en);put(en+0x640,Address(0xc237a0));put(en+0x6d8,Address(0x700000));
        put(lv+0x100,std::int32_t(2));put(lv+0x104,std::uint8_t(1));put(ac+0xb0,std::int32_t(2));put(ac+0xc8,Address(0xb9a4e0));
        put(lv+0x188,Address(0));put(lv+0x1c0,std::uint8_t(0));put(vb()+0xe8,std::uint32_t(4));put(vb()+0xe4,std::uint32_t(0));
        put(vb()+0x10,reinterpret_cast<Address>(pixels.data()));shape(8,6);put(vb()+0xf0,std::uint32_t(1));put(vb()+0xf4,std::uint32_t(0));
        for(unsigned i=0;i<4;++i)put(vb()+4*i,std::uint32_t(i==3?255:i));put(vb()+0xd0,std::uint32_t(1920));put(vb()+0xd4,std::uint32_t(1080));put(vb()+0xd8,std::uint32_t(6220800));put(vb()+0xfc,std::uint32_t(3));}
    void shape(std::uint32_t w,std::uint32_t h){put(vb()+0x50,std::uint64_t(w)|(std::uint64_t(h)<<32));}
    static bool read(void*p,Address address,void*out,std::size_t n)noexcept{
        auto&s=*static_cast<Sim*>(p);if(address==s.denied)return false;auto*b=static_cast<std::uint8_t*>(out);
        for(std::size_t i=0;i<n;++i){auto it=s.mem.find(address+i);if(it==s.mem.end())return false;b[i]=it->second;}return true;}
    static void*current(){return reinterpret_cast<void*>(active->q);}
    static const std::uint8_t*lock(void*access,std::int32_t client){auto&s=*active;assert(reinterpret_cast<Address>(access)==s.ac&&client==2);++s.locks;
        if(s.throw_lock&&!s.partial_lock)throw std::runtime_error("synthetic");s.put(s.vb()+0xe8,std::uint32_t(0));s.put(s.vb()+0xf4,s.get<std::uint32_t>(s.vb()+0xf0));
        if(s.throw_lock)throw std::runtime_error("synthetic");return s.pixels.data();}
    static bool unlock(void*access,std::int32_t client){auto&s=*active;assert(reinterpret_cast<Address>(access)==s.ac&&client==2);++s.unlocks;
        if(s.throw_unlock)throw std::runtime_error("synthetic");if(s.false_unlock)return false;s.put(s.vb()+0xe8,std::uint32_t(4));
        if(s.partial_release_read)s.denied=s.vb()+0xe8;return true;}
    static std::uint64_t size(void*){auto&s=*active;if(s.throw_size)throw std::runtime_error("synthetic");if(s.owner_changes)s.put(s.ac+0xb0,std::int32_t(1));
        if(s.reenter){Metadata m;s.nested=s.a->sample_metadata(m);}return s.get<std::uint64_t>(s.vb()+0x50);}
    static std::uint32_t id(void*){return active->get<std::uint32_t>(active->vb()+0xf4)+(active->bad_id?1:0);}
    static std::uint64_t clock(void*p)noexcept{return static_cast<Sim*>(p)->ns;}
    void configure(Adapter&adapter){a=&adapter;adapter.configure_synthetic({this,read,current,lock,unlock,size,id,clock});}
    void synthetic_lock(std::uint32_t id){put(vb()+0xe8,std::uint32_t(0));put(vb()+0xf4,id);}
    SourceView view(std::uint32_t id) {return {pixels.data(),pixels.size(),8,6,24,3,0,id,1,++ns,
        Packing::PackedThreeComponents,Color::RgbOrderVerified,Clock::HostObservedCompletionNs64,true,true};}
};
Sim*Sim::active=nullptr;
}
int main(){unsigned count=0;Metadata out;
    {Adapter a;assert(a.sample_metadata(out)==Result::Disabled);assert(a.request_pixel_copy()==Result::NeedsHardwareReceipts);++count;}
    {Sim s;Adapter a;s.configure(a);assert(a.sample_metadata(out)==Result::MetadataReleased);assert(out.width==8&&out.height==6&&out.software_completion_id==1&&out.observed_completion_ns==100);assert(out.raw_buffer.channels==3&&out.raw_buffer.calculated_bytes==6220800&&out.raw_buffer.component_map[3]==255);assert(!out.pixels_copied&&!out.sensor_counter&&!out.hardware_timestamp&&!out.real_60fps_proven);assert(s.unlocks==1);++count;}
    {Sim s;Adapter a;s.configure(a);s.put(s.lv+0x188,Address(123));assert(a.sample_metadata(out)==Result::UiRetained);assert(!s.locks&&!s.unlocks);++count;}
    {Sim s;Adapter a;s.configure(a);s.put(s.lv+0x1c0,std::uint8_t(1));assert(a.sample_metadata(out)==Result::UiRetained);assert(!s.locks&&!s.unlocks);++count;}
    {Sim s;Adapter a;s.configure(a);s.put(s.ac+0xb0,std::int32_t(1));assert(a.sample_metadata(out)==Result::InvalidOwner);assert(!s.locks);++count;}
    {Sim s;Adapter a;s.configure(a);s.put(s.ac+0xc8,Address(0));assert(a.sample_metadata(out)==Result::InvalidOwner);assert(!s.locks);++count;}
    {Sim s;Adapter a;s.configure(a);assert(a.sample_metadata(out)==Result::MetadataReleased);s.q=0x900000;assert(a.sample_metadata(out)==Result::WrongThread);assert(s.unlocks==1);++count;}
    {Sim s;Adapter a;s.configure(a);s.put(s.vb()+0xe8,std::uint32_t(0));assert(a.sample_metadata(out)==Result::AlreadyLocked);assert(!s.locks&&!s.unlocks);++count;}
    {Sim s;Adapter a;s.configure(a);s.put(s.vb()+0xe4,std::uint32_t(4));assert(a.sample_metadata(out)==Result::NoCompletedSlot);assert(!s.locks);++count;}
    {Sim s;Adapter a;s.configure(a);s.put(s.vb()+0x10,Address(0));assert(a.sample_metadata(out)==Result::NoCompletedSlot);assert(!s.locks);++count;}
    {Sim s;Adapter a;s.configure(a);s.shape(0,6);assert(a.sample_metadata(out)==Result::BadMetadata);assert(s.unlocks==1);++count;}
    {Sim s;Adapter a;s.configure(a);s.shape(10000,10000);assert(a.sample_metadata(out)==Result::BadMetadata);assert(s.unlocks==1);++count;}
    {Sim s;Adapter a;s.configure(a);s.put(s.ac,Address(0));assert(a.sample_metadata(out)==Result::InvalidOwner);assert(!s.locks);++count;}
    {Sim s;Adapter a;s.configure(a);s.bad_id=true;assert(a.sample_metadata(out)==Result::BadMetadata);assert(s.unlocks==1);++count;}
    {Sim s;Adapter a;s.configure(a);s.ns=0;assert(a.sample_metadata(out)==Result::ClockUnavailable);assert(s.unlocks==1);++count;}
    {Sim s;Adapter a;s.configure(a);s.denied=s.vb()+0xd8;assert(a.sample_metadata(out)==Result::BadMetadata);assert(s.unlocks==1&&!a.held_uncertain());++count;}
    {Sim s;Adapter a;s.configure(a);assert(a.sample_metadata(out)==Result::MetadataReleased);++s.ns;assert(a.sample_metadata(out)==Result::Duplicate);assert(s.unlocks==2);++count;}
    {Sim s;Adapter a;s.configure(a);assert(a.sample_metadata(out)==Result::MetadataReleased);++s.ns;s.put(s.vb()+0xf0,std::uint32_t(0x80000001));assert(a.sample_metadata(out)==Result::StaleId);assert(s.unlocks==2);++count;}
    {Sim s;Adapter a;s.configure(a);s.put(s.vb()+0xf0,std::uint32_t(0xfffffffe));assert(a.sample_metadata(out)==Result::MetadataReleased);++s.ns;s.put(s.vb()+0xf0,std::uint32_t(2));assert(a.sample_metadata(out)==Result::MetadataReleased);assert(s.unlocks==2);++count;}
    for(bool partial:{false,true}){Sim s;Adapter a;s.configure(a);s.throw_lock=true;s.partial_lock=partial;assert(a.sample_metadata(out)==Result::NativeException);assert(a.held_uncertain()&&!s.unlocks);assert(a.sample_metadata(out)==Result::Hold);++count;}
    {Sim s;Adapter a;s.configure(a);s.throw_size=true;assert(a.sample_metadata(out)==Result::NativeException);assert(s.unlocks==1&&!a.held_uncertain());++count;}
    {Sim s;Adapter a;s.configure(a);s.false_unlock=true;assert(a.sample_metadata(out)==Result::UnlockUnknown);assert(s.unlocks==1&&a.unlock_attempts()==1&&a.held_uncertain());assert(a.sample_metadata(out)==Result::Hold);++count;}
    {Sim s;Adapter a;s.configure(a);s.throw_unlock=true;assert(a.sample_metadata(out)==Result::UnlockUnknown);assert(s.unlocks==1&&a.held_uncertain());assert(a.sample_metadata(out)==Result::Hold);++count;}
    {Sim s;Adapter a;s.configure(a);s.partial_release_read=true;assert(a.sample_metadata(out)==Result::UnlockUnknown);assert(s.unlocks==1&&a.held_uncertain());assert(a.sample_metadata(out)==Result::Hold);++count;}
    {Sim s;Adapter a;s.configure(a);s.owner_changes=true;assert(a.sample_metadata(out)==Result::UnlockUnknown);assert(!s.unlocks&&a.held_uncertain());++count;}
    {Sim s;Adapter a;s.configure(a);s.reenter=true;assert(a.sample_metadata(out)==Result::MetadataReleased);assert(s.nested==Result::Reentrant&&s.unlocks==1);++count;}
    {Sim s;Adapter a;s.configure(a);assert(a.sample_metadata(out)==Result::MetadataReleased);CopyPool pool({8,6,3,1,s.q});
        s.synthetic_lock(2);assert(a.copy_synthetic(pool,s.view(2))==CaptureResult::Published);assert(pool.ready_count()==1&&s.unlocks==2);
        s.synthetic_lock(3);assert(a.copy_synthetic(pool,s.view(3))==CaptureResult::PoolFull);assert(s.unlocks==3&&pool.ready_count()==1);++count;}
    {Sim s;Adapter a;s.configure(a);assert(a.sample_metadata(out)==Result::MetadataReleased);CopyPool pool({8,6,3,1,s.q});
        s.synthetic_lock(2);auto v=s.view(2);v.color=Color::Unverified;assert(a.copy_synthetic(pool,v)==CaptureResult::BadLayout);assert(s.unlocks==2&&!pool.ready_count());++count;}
    {Sim s;Adapter a;s.configure(a);assert(a.sample_metadata(out)==Result::MetadataReleased);CopyPool pool({8,6,3,1,s.q});
        s.synthetic_lock(2);s.false_unlock=true;assert(a.copy_synthetic(pool,s.view(2))==CaptureResult::UnlockFailed);assert(!pool.ready_count()&&pool.native_release_uncertain()&&s.unlocks==2);++count;}
    std::cout<<count<<" synthetic adapter fault groups passed; zero device/vendor execution\n";
}
