#include "adapter.hpp"
#include <limits>
namespace iq4::f4::native_metadata {
namespace {
bool ptr(Address p) noexcept {return p>=4096 && p<=UINTPTR_MAX-0x5000 && (p&7)==0;}
bool same(const Owner&a,const Owner&b) noexcept {return a.queue==b.queue&&a.manager==b.manager&&a.ui_data==b.ui_data&&a.lv==b.lv&&a.access==b.access&&a.engine==b.engine&&a.frame_event==b.frame_event;}
}
bool Adapter::read(Address a,void*out,std::size_t n) const noexcept {
    return operations_.read&&a>=4096&&n&&n<=4096&&a<=UINTPTR_MAX-n&&operations_.read(operations_.context,a,out,n);
}
bool Adapter::word(Address a,Address&v) const noexcept {return read(a,&v,8);}
bool Adapter::owner_chain(Address q,Owner&o) const noexcept {
    // Mechanically reuse Bootstrap02's self-derived double-linked owner chain.
    Address vt{},m{},d{},lv{},access{},engine{},v{},p{};
    if(!ptr(q)||!word(q,vt)||vt!=0xb91f48||!word(q+0x1c8,m)||!ptr(m)||!word(m,vt)||vt!=0xb8f358||
       !word(m+8,v)||v!=q||!word(q+0x9b8,d)||!ptr(d)||!word(m+0x790,v)||v!=d||
       !word(q+0x8c0,lv)||!ptr(lv)||!word(lv,vt)||vt!=0xb9a9d8||!word(d+0x118,access)||!ptr(access)||
       !word(lv+0x108,v)||v!=access||!word(access,vt)||vt!=0xc07da8||!word(access+8,engine)||!ptr(engine)||
       !word(engine+0x640,vt)||vt!=0xc237a0||!word(engine+0x6d8,p)||!ptr(p))return false;
    o={q,m,d,lv,access,engine,engine+0x640};return true;
}
bool Adapter::live_owner(Owner&o,std::int32_t&client,Address&retained) noexcept {
    Address q{};try {q=reinterpret_cast<Address>(operations_.current());}catch(...){return false;}
    if(queue_&&q!=queue_)return false;
    Owner again{};std::int32_t owner=-1;std::uint8_t running{},keep{};Address name{};
    if(!owner_chain(q,o)||!read(o.lv+0x100,&client,4)||client<0||client>=5||!read(o.lv+0x104,&running,1)||running!=1||
       !read(o.access+0xb0,&owner,4)||owner!=client||!word(o.access+0xb8+8*static_cast<unsigned>(client),name)||name!=0xb9a4e0||
       !word(o.lv+0x188,retained)||!read(o.lv+0x1c0,&keep,1)||!owner_chain(q,again)||!same(o,again))return false;
    if(keep)retained=1; // preserve native pointer/flag; never clear either
    return true;
}
bool Adapter::same_owner(const Owner&o,std::int32_t client) noexcept {
    Owner now{};std::int32_t c{};Address retained{};
    return live_owner(now,c,retained)&&same(o,now)&&c==client&&retained==0;
}
ReleaseResult Adapter::release() noexcept {
    if(!own_lock_||attempted_unlock_||!same_owner(locked_owner_,client_)){hold_=true;return ReleaseResult::Unknown;}
    const Address vb=locked_owner_.engine+0x2170;std::uint32_t slot{},id{};
    if(!read(vb+0xe8,&slot,4)||slot!=slot_||!read(vb+0xf4,&id,4)||id!=id_){hold_=true;return ReleaseResult::Unknown;}
    attempted_unlock_=true;++unlock_attempts_;
    bool returned=false;try{returned=operations_.unlock(reinterpret_cast<void*>(locked_owner_.access),client_);}catch(...){hold_=true;return ReleaseResult::Unknown;}
    if(!returned){hold_=true;return ReleaseResult::KnownStillLocked;}
    std::uint32_t after{};
    if(!read(vb+0xe8,&after,4)||after!=4){hold_=true;return ReleaseResult::Unknown;}
    own_lock_=false;return ReleaseResult::Released;
}
ReleaseResult Adapter::release_bridge(void*p,const SourceView&) noexcept {return static_cast<Adapter*>(p)->release();}
Result Adapter::finish(Result why) noexcept {return release()==ReleaseResult::Released?why:Result::UnlockUnknown;}
Result Adapter::sample_metadata(Metadata&out) noexcept {
    out={};if(!ready_)return Result::Disabled;if(hold_)return Result::Hold;
    if(sampling_.test_and_set(std::memory_order_acquire))return Result::Reentrant;
    struct Guard{std::atomic_flag&f;~Guard(){f.clear(std::memory_order_release);}}guard{sampling_};
    Owner o{};std::int32_t client{};Address retained{};
    if(!live_owner(o,client,retained))return queue_?Result::WrongThread:Result::InvalidOwner;
    if(retained)return Result::UiRetained;
    const Address vb=o.engine+0x2170;std::uint32_t old_lock{},latest{},software{};Address pixels{},size{};
    if(!read(vb+0xe8,&old_lock,4)||old_lock!=4)return Result::AlreadyLocked;
    if(!read(vb+0xe4,&latest,4)||latest>=4||!word(vb+0x10+latest*8,pixels)||!pixels||
       !word(vb+0x50+latest*8,size)||!read(vb+0xf0,&software,4))return Result::NoCompletedSlot;
    queue_=o.queue;locked_owner_=o;client_=client;attempted_unlock_=false;own_lock_=false;
    const std::uint8_t*data{};
    // A thrown Lock can have changed native state without returning ownership.
    // Preserve everything; never infer a completed lock or force paired unlock.
    try{data=operations_.lock(reinterpret_cast<void*>(o.access),client);}catch(...){hold_=true;return Result::NativeException;}
    if(!read(vb+0xe8,&slot_,4)||slot_>=4||!read(vb+0xf4,&id_,4)){hold_=true;return Result::Hold;}
    own_lock_=true;locked_pixels_=reinterpret_cast<Address>(data);
    std::uint64_t packed{};std::uint32_t reported_id{};
    try{packed=operations_.size(reinterpret_cast<void*>(o.access));reported_id=operations_.id(reinterpret_cast<void*>(o.access));}
    catch(...){return finish(Result::NativeException);}
    Address actual_pixels{},actual_size{};std::uint32_t check_slot{},check_id{};
    if(!same_owner(o,client)||!word(vb+0x10+slot_*8,actual_pixels)||actual_pixels!=locked_pixels_||!data||
       !word(vb+0x50+slot_*8,actual_size)||actual_size!=packed||!read(vb+0xe8,&check_slot,4)||check_slot!=slot_||
       !read(vb+0xf4,&check_id,4)||check_id!=id_||reported_id!=id_)return finish(Result::BadMetadata);
    const auto w=static_cast<std::uint32_t>(packed),h=static_cast<std::uint32_t>(packed>>32);
    if(!w||!h||w>65535||h>65535||static_cast<std::uint64_t>(w)*h*3>CopyPool::max_slot_bytes)return finish(Result::BadMetadata);
    RawBufferConfiguration raw{};
    if(!read(vb,raw.component_map,sizeof(raw.component_map))||!read(vb+0xd0,&raw.configured_width,4)||
       !read(vb+0xd4,&raw.configured_height,4)||!read(vb+0xd8,&raw.calculated_bytes,4)||!read(vb+0xfc,&raw.channels,4))return finish(Result::BadMetadata);
    const std::uint64_t ns=operations_.clock(operations_.context);
    if(!ns||(seen_&&ns<=last_ns_))return finish(Result::ClockUnavailable);
    if(seen_){const auto delta=std::uint32_t(id_-last_id_);if(!delta)return finish(Result::Duplicate);if(delta>=0x80000000u)return finish(Result::StaleId);}
    const auto result=finish(Result::MetadataReleased);
    if(result==Result::MetadataReleased){out.width=w;out.height=h;out.slot=slot_;out.software_completion_id=id_;out.observed_completion_ns=ns;out.raw_buffer=raw;seen_=true;last_id_=id_;last_ns_=ns;}
    return result;
}
#ifdef IQ4_F4_ADAPTER_SYNTHETIC_HOST
CaptureResult Adapter::copy_synthetic(CopyPool&pool,SourceView view) noexcept {
    // Test-only simulation bypass. It is absent from production objects and is
    // explicitly never a hardware/layout/color/mapping receipt.
    own_lock_=true;attempted_unlock_=false;slot_=view.slot;id_=view.software_completion_id;
    view.active_mode_layout_verified=view.active_mode_layout_verified&&view.color==Color::RgbOrderVerified;
    SourceLease lease(view,queue_,true,Disposition::ExclusiveReleaseRequired,release_bridge,this);
    return pool.capture(lease);
}
#endif
}
