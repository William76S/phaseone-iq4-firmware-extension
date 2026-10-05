#include "owned_copy_pool.hpp"
#include "recorder_worker.hpp"
#include <algorithm>
#include <array>
#include <atomic>
#include <cassert>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <limits>
#include <new>
#include <stdexcept>
#include <thread>
#include <vector>

// The source-path guard counts C++ heap allocation on the producer thread.
// It cannot attest an unbound native callback, libc internals, or target timing.
namespace {
thread_local bool guard_source_allocation=false;
thread_local bool fail_next_allocation=false;
std::atomic<std::uint64_t> source_allocations{0};
void* test_allocate(std::size_t bytes) {
    if(guard_source_allocation) source_allocations.fetch_add(1,std::memory_order_relaxed);
    if(fail_next_allocation) { fail_next_allocation=false;throw std::bad_alloc(); }
    if(auto* p=std::malloc(bytes ? bytes : 1)) return p;
    throw std::bad_alloc();
}
}
void* operator new(std::size_t bytes) { return test_allocate(bytes); }
void* operator new[](std::size_t bytes) { return test_allocate(bytes); }
void operator delete(void* p) noexcept { std::free(p); }
void operator delete[](void* p) noexcept { std::free(p); }
void operator delete(void* p,std::size_t) noexcept { std::free(p); }
void operator delete[](void* p,std::size_t) noexcept { std::free(p); }
void* operator new(std::size_t bytes,std::align_val_t alignment) {
    if(guard_source_allocation) source_allocations.fetch_add(1,std::memory_order_relaxed);
    if(fail_next_allocation) {fail_next_allocation=false;throw std::bad_alloc();}
    void* result=nullptr;
    if(posix_memalign(&result,static_cast<std::size_t>(alignment),bytes ? bytes : 1)==0) return result;
    throw std::bad_alloc();
}
void* operator new[](std::size_t bytes,std::align_val_t alignment) {return ::operator new(bytes,alignment);}
void operator delete(void* p,std::align_val_t) noexcept {std::free(p);}
void operator delete[](void* p,std::align_val_t) noexcept {std::free(p);}
void operator delete(void* p,std::size_t,std::align_val_t) noexcept {std::free(p);}
void operator delete[](void* p,std::size_t,std::align_val_t) noexcept {std::free(p);}

namespace {
using namespace iq4::f4;
constexpr std::uintptr_t native_owner=0x112233u;
constexpr std::uint32_t mode=7;
constexpr std::uint32_t width=16,height=8;
constexpr std::size_t bytes=std::size_t(width)*height*3;
using Pixels=std::array<std::uint8_t,bytes>;
Config config(std::uint32_t slots=3) { return {width,height,mode,slots,native_owner}; }
SourceView view(Pixels& pixels,std::uint32_t id=1,std::uint64_t clock=100) {
    return {pixels.data(),pixels.size(),width,height,width*3,mode,1,id,11,clock,
            Packing::PackedThreeComponents,Color::RgbOrderVerified,
            Clock::HostObservedCompletionNs64,true,true};
}
struct ReleaseProbe {
    std::uint64_t calls{};
    bool held{true},poison{true},check_empty{},checked_empty{true};
    CopyPool* pool{};
    Pixels* pixels{};
    ReleaseResult result{ReleaseResult::Released};
    SourceLease* reenter{};
    CaptureResult reentered{CaptureResult::Published};
};
ReleaseResult release_probe(void* context,const SourceView& source) noexcept {
    auto& p=*static_cast<ReleaseProbe*>(context);
    ++p.calls;
    assert(p.held);
    assert(source.lock_cookie==11);
    if(p.check_empty) p.checked_empty=p.checked_empty && p.pool->ready_count()==0;
    if(p.reenter) p.reentered=p.pool->capture(*p.reenter);
    if(p.result==ReleaseResult::Released) {
        p.held=false;
        if(p.poison && p.pixels) p.pixels->fill(0xee);
    }
    return p.result;
}
CaptureResult capture_no_alloc(CopyPool& pool,SourceLease& lease) {
    const auto before=source_allocations.load();
    guard_source_allocation=true;
    const auto result=pool.capture(lease);
    guard_source_allocation=false;
    assert(source_allocations.load()==before);
    return result;
}
CaptureResult capture(CopyPool& pool,Pixels& pixels,SourceView v,ReleaseProbe& probe,
                      bool verified=true,Disposition d=Disposition::ExclusiveReleaseRequired,
                      std::uintptr_t thread=native_owner) {
    probe.held=true; probe.pixels=&pixels;
    SourceLease lease(v,thread,verified,d,release_probe,&probe);
    return capture_no_alloc(pool,lease);
}
template<class F> void worker(CopyPool& pool,F fn) {
    std::thread t([&]{ assert(pool.bind_worker()); fn(); });
    t.join();
}
void test_constructor_bounds() {
    for(const auto c:std::array<Config,5>{{{0,height,mode,1,native_owner},
        {width,0,mode,1,native_owner},{width,height,mode,0,native_owner},
        {width,height,mode,17,native_owner},{width,height,mode,1,0}}}) {
        bool caught=false;
        try { CopyPool pool(c); } catch(const std::invalid_argument&) { caught=true; }
        assert(caught);
    }
    bool caught=false;
    try { CopyPool pool({65536,65536,mode,1,native_owner}); }
    catch(const std::invalid_argument&) { caught=true; }
    assert(caught);
    CopyPool pool(config()); assert(pool.preallocated_bytes()==bytes*3);
}
void test_copy_release_and_owned_lifetime() {
    auto pool=std::make_unique<CopyPool>(config());
    Pixels source{}; source.fill(0x17);
    ReleaseProbe probe{}; probe.pool=pool.get();probe.check_empty=true;
    assert(capture(*pool,source,view(source),probe)==CaptureResult::Published);
    assert(probe.calls==1 && !probe.held && probe.checked_empty);
    assert(std::all_of(source.begin(),source.end(),[](auto b){return b==0xee;}));
    OwnedFrame retained;
    worker(*pool,[&]{
        assert(pool->try_pop(retained));
        assert(retained.data()!=source.data());
        assert(retained.info().bytes==bytes && retained.info().stride==width*3);
        assert(retained.info().software_completion_id==1);
        assert(retained.info().host_completion_clock_ns==100);
        assert(std::all_of(retained.data(),retained.data()+bytes,[](auto b){return b==0x17;}));
        assert(!pool->try_pop(retained)); // cannot overwrite an existing worker lease
    });
    assert(pool->counters().worker_bad_state==1);
    pool.reset(); // only an orderly end: no concurrent calls remain
    assert(retained && retained.data()[bytes-1]==0x17);
    OwnedFrame moved(std::move(retained));assert(!retained && moved);
    moved.reset(); assert(!moved && moved.data()==nullptr);
}
void test_owner_ui_and_single_release() {
    CopyPool pool(config());Pixels source{};ReleaseProbe probe{};probe.pixels=&source;
    auto v=view(source);SourceLease lease(v,native_owner,true,Disposition::ExclusiveReleaseRequired,release_probe,&probe);
    std::thread wrong([&]{assert(capture_no_alloc(pool,lease)==CaptureResult::WrongThread);});wrong.join();
    assert(lease.state()==LeaseState::Available && probe.calls==0);
    assert(capture_no_alloc(pool,lease)==CaptureResult::Published);
    assert(lease.state()==LeaseState::Released);
    assert(capture_no_alloc(pool,lease)==CaptureResult::AlreadyUsed && probe.calls==1);
    assert(capture(pool,source,view(source,2,200),probe,true,Disposition::UiRetainedBorrow)==CaptureResult::UiRetained);
    assert(probe.calls==1 && probe.held);
    assert(capture(pool,source,view(source,2,200),probe,false)==CaptureResult::BadLease);
    assert(probe.calls==1 && probe.held);
    auto bad_slot=view(source,2,200);bad_slot.slot=4;
    assert(capture(pool,source,bad_slot,probe)==CaptureResult::BadLease && probe.calls==1);
    assert(capture(pool,source,view(source,2,200),probe,true,static_cast<Disposition>(0xff))==CaptureResult::BadLease && probe.calls==1);
    assert(capture(pool,source,view(source,2,200),probe,true,
        Disposition::ExclusiveReleaseRequired,native_owner+1)==CaptureResult::WrongThread && probe.calls==1);
    assert(!pool.bind_worker());
    OwnedFrame bad;assert(!pool.try_pop(bad));
    worker(pool,[&]{OwnedFrame owned;assert(pool.try_pop(owned));assert(!pool.bind_worker());});
    assert(pool.counters().release_attempts==1);
}
void test_reentrant() {
    CopyPool pool(config());Pixels source{};ReleaseProbe probe{};probe.pool=&pool;probe.pixels=&source;
    auto v=view(source);SourceLease lease(v,native_owner,true,Disposition::ExclusiveReleaseRequired,release_probe,&probe);
    probe.reenter=&lease;
    assert(capture_no_alloc(pool,lease)==CaptureResult::Published);
    assert(probe.reentered==CaptureResult::Reentrant && probe.calls==1);
    assert(pool.counters().rejected_reentrant==1);
    worker(pool,[&]{OwnedFrame frame;assert(pool.try_pop(frame));});
}
void test_layout_span_clock() {
    CopyPool pool(config());Pixels source{};ReleaseProbe probe{};
    std::uint32_t id=1;std::uint64_t time=100;
    const auto attempt=[&](SourceView v,CaptureResult expected){
        const auto before=probe.calls;
        assert(capture(pool,source,v,probe)==expected);
        assert(probe.calls==before+1 && !probe.held);
    };
    auto v=view(source,id,time);v.width=0;attempt(v,CaptureResult::BadLayout);
    v=view(source,id,time);v.width=width+1;attempt(v,CaptureResult::BadLayout);
    v=view(source,id,time);v.mode=mode+1;attempt(v,CaptureResult::BadLayout);
    v=view(source,id,time);v.packing=Packing::Unknown;attempt(v,CaptureResult::BadLayout);
    v=view(source,id,time);v.active_mode_layout_verified=false;attempt(v,CaptureResult::BadLayout);
    v=view(source,id,time);v.stride=width*3+1;attempt(v,CaptureResult::BadSpan);
    v=view(source,id,time);v.explicit_span=bytes-1;attempt(v,CaptureResult::BadSpan);
    v=view(source,id,time);v.data=nullptr;attempt(v,CaptureResult::BadSpan);
    v=view(source,id,time);v.clock=Clock::Unknown;attempt(v,CaptureResult::BadClock);
    attempt(view(source,id,time),CaptureResult::Published);
    attempt(view(source,++id,time),CaptureResult::BadClock);
    attempt(view(source,id,time-1),CaptureResult::BadClock);
    attempt(view(source,id,++time),CaptureResult::Published);
    worker(pool,[&]{OwnedFrame a,b;assert(pool.try_pop(a));assert(pool.try_pop(b));});
    const auto counters=pool.counters();
    assert(counters.rejected_layout==5 && counters.rejected_span==3 && counters.rejected_clock==3);
    assert(counters.published==2 && counters.release_success==13);
}
void test_software_id_wrap_gap_full_and_held() {
    CopyPool pool(config(2));Pixels source{};ReleaseProbe probe{};
    assert(capture(pool,source,view(source,0xffffffffu,100),probe)==CaptureResult::Published);
    assert(capture(pool,source,view(source,0xffffffffu,100),probe)==CaptureResult::Duplicate);
    assert(capture(pool,source,view(source,0xfffffffeu,101),probe)==CaptureResult::StaleSoftwareId);
    assert(capture(pool,source,view(source,0,200),probe)==CaptureResult::Published);
    assert(capture(pool,source,view(source,2,300),probe)==CaptureResult::PoolFull);
    assert(capture(pool,source,view(source,2,300),probe)==CaptureResult::Duplicate);
    std::atomic<int> step{0};
    std::thread t([&]{
        assert(pool.bind_worker());OwnedFrame a,b;
        assert(pool.try_pop(a));assert(pool.try_pop(b));
        step.store(1,std::memory_order_release);
        while(step.load(std::memory_order_acquire)!=2) std::this_thread::yield();
        a.reset();b.reset();step.store(3,std::memory_order_release);
        while(step.load(std::memory_order_acquire)!=4) std::this_thread::yield();
        OwnedFrame c;assert(pool.try_pop(c));assert(c.info().software_completion_id==4);
    });
    while(step.load(std::memory_order_acquire)!=1) std::this_thread::yield();
    assert(pool.ready_count()==0);
    assert(capture(pool,source,view(source,3,400),probe)==CaptureResult::PoolFull); // held slots are not reusable
    step.store(2,std::memory_order_release);
    while(step.load(std::memory_order_acquire)!=3) std::this_thread::yield();
    assert(capture(pool,source,view(source,4,500),probe)==CaptureResult::Published);
    step.store(4,std::memory_order_release);t.join();
    const auto c=pool.counters();
    assert(c.published==3 && c.pool_full==2 && c.duplicate_ids==2 && c.stale_ids==1);
    assert(c.software_id_steps_skipped==1); // software ID steps only, not physical exposures
    assert(c.worker_owned_frames==3 && c.worker_released_frames==3 && probe.calls==8);
}
void test_unlock_failure_and_closed() {
    for(auto result:{ReleaseResult::Unknown,ReleaseResult::KnownStillLocked}) {
        CopyPool pool(config());Pixels source{};ReleaseProbe probe{};probe.result=result;
        auto v=view(source);SourceLease lease(v,native_owner,true,Disposition::ExclusiveReleaseRequired,release_probe,&probe);
        const auto expected=result==ReleaseResult::Unknown ? CaptureResult::UnlockUnknown : CaptureResult::UnlockFailed;
        assert(capture_no_alloc(pool,lease)==expected && pool.ready_count()==0 && probe.calls==1 && probe.held);
        assert(pool.native_release_uncertain());
        assert(capture_no_alloc(pool,lease)==CaptureResult::AlreadyUsed && probe.calls==1);
        probe.result=ReleaseResult::Released;
        assert(capture(pool,source,view(source,2,200),probe)==CaptureResult::Closed && probe.calls==2);
        worker(pool,[&]{OwnedFrame frame;assert(!pool.try_pop(frame));});
    }
    CopyPool pool(config());Pixels source{};ReleaseProbe probe{};
    pool.stop_accepting();
    assert(capture(pool,source,view(source),probe)==CaptureResult::Closed && probe.calls==1);
    assert(!pool.native_release_uncertain());
}
struct BackendProbe {
    unsigned prepared{},encoded{},finalized{},aborted{};
    std::int64_t last_pts{};
    bool throw_encode{};
    std::uint8_t expected_byte{};
    std::uint64_t* release_calls{};
    std::thread::id worker;
};
class TestBackend final : public iq4::runtime::Backend {
public:
    explicit TestBackend(BackendProbe& p):p_(p) {}
    void prepare() override { assert(std::this_thread::get_id()==p_.worker);++p_.prepared; }
    void encode(const iq4::runtime::Frame& frame) override {
        assert(std::this_thread::get_id()==p_.worker);
        assert(*p_.release_calls>0 && !frame.source_sequence);
        assert(frame.bytes.size()==bytes && frame.bytes.front()==p_.expected_byte && frame.bytes.back()==p_.expected_byte);
        if(p_.throw_encode) throw std::runtime_error("synthetic encoder failure");
        ++p_.encoded;p_.last_pts=frame.pts_ns;
    }
    void finalize() override { assert(std::this_thread::get_id()==p_.worker);++p_.finalized; }
    void abort() noexcept override { assert(std::this_thread::get_id()==p_.worker);++p_.aborted; }
private:BackendProbe& p_;
};
void test_recorder_bridge() {
    CopyPool pool(config(4));Pixels source{};ReleaseProbe release{};
    source.fill(0x35);assert(capture(pool,source,view(source,1,100),release)==CaptureResult::Published);
    auto unverified=view(source,2,200);unverified.color=Color::Unverified;
    assert(capture(pool,source,unverified,release)==CaptureResult::Published);
    auto shape=view(source,3,300);shape.height=height-1;
    assert(capture(pool,source,shape,release)==CaptureResult::Published);
    auto time=view(source,4,std::uint64_t(std::numeric_limits<std::int64_t>::max())+1);
    assert(capture(pool,source,time,release)==CaptureResult::Published);
    BackendProbe probe{};probe.release_calls=&release.calls;probe.expected_byte=0x35;
    worker(pool,[&]{
        probe.worker=std::this_thread::get_id();
        iq4::runtime::Recorder recorder(2,bytes,std::make_unique<TestBackend>(probe));
        RecorderWorker bridge(pool,recorder,{width,height,mode,width*3,bytes});
        assert(recorder.start());assert(bridge.pump_one()==PumpResult::Consumed);
        assert(bridge.pump_one()==PumpResult::RejectedColor);
        assert(bridge.pump_one()==PumpResult::RejectedShape);
        assert(bridge.pump_one()==PumpResult::RejectedClock);
        assert(bridge.pump_one()==PumpResult::Empty);
        assert(!recorder.counters().source_loss_known && recorder.counters().source_gaps==0);
        assert(bridge.counters().consumed==1 && bridge.counters().rejected_shape==1 && bridge.counters().rejected_color==1);
        assert(recorder.stop());
    });
    assert(probe.encoded==1 && probe.last_pts==100 && probe.finalized==1);
    assert(pool.counters().worker_released_frames==4);
}
void test_recorder_wrong_worker_and_encoder_failure() {
    CopyPool pool(config());Pixels source{};source.fill(0x12);ReleaseProbe release{};
    assert(capture(pool,source,view(source),release)==CaptureResult::Published);
    BackendProbe probe{};probe.release_calls=&release.calls;probe.expected_byte=0x12;probe.throw_encode=true;
    std::atomic<int> step{0};RecorderWorker* shared_bridge=nullptr;
    std::thread t([&]{
        assert(pool.bind_worker());probe.worker=std::this_thread::get_id();
        iq4::runtime::Recorder recorder(2,bytes,std::make_unique<TestBackend>(probe));
        RecorderWorker bridge(pool,recorder,{width,height,mode,width*3,bytes});
        assert(recorder.start());shared_bridge=&bridge;step.store(1,std::memory_order_release);
        while(step.load(std::memory_order_acquire)!=2) std::this_thread::yield();
        assert(bridge.pump_one()==PumpResult::RecorderRejected);
        assert(recorder.state()==iq4::runtime::State::Error && bridge.counters().recorder_rejected==1);
        assert(recorder.reset_error());
    });
    while(step.load(std::memory_order_acquire)!=1) std::this_thread::yield();
    assert(shared_bridge->pump_one()==PumpResult::WrongWorker); // does not touch Recorder/backend
    step.store(2,std::memory_order_release);t.join();
    assert(probe.encoded==0 && probe.aborted==2 && pool.counters().worker_released_frames==1);
}
void test_recorder_source_unlock_uncertain() {
    CopyPool pool(config());Pixels source{};ReleaseProbe release{};release.result=ReleaseResult::Unknown;
    assert(capture(pool,source,view(source),release)==CaptureResult::UnlockUnknown);
    BackendProbe probe{};probe.release_calls=&release.calls;
    worker(pool,[&]{
        probe.worker=std::this_thread::get_id();
        iq4::runtime::Recorder recorder(2,bytes,std::make_unique<TestBackend>(probe));
        RecorderWorker bridge(pool,recorder,{width,height,mode,width*3,bytes});
        assert(recorder.start());assert(bridge.pump_one()==PumpResult::SourceUnlockUncertain);
        assert(recorder.state()==iq4::runtime::State::Error && probe.finalized==1);
        assert(bridge.pump_one()==PumpResult::SourceUnlockUncertain && probe.finalized==1);
        assert(recorder.reset_error());
    });
    assert(probe.encoded==0 && release.calls==1);
}
void test_worker_allocation_failure() {
    CopyPool pool(config());Pixels source{};ReleaseProbe release{};
    assert(capture(pool,source,view(source),release)==CaptureResult::Published);
    BackendProbe probe{};probe.release_calls=&release.calls;
    worker(pool,[&]{
        probe.worker=std::this_thread::get_id();
        iq4::runtime::Recorder recorder(2,bytes,std::make_unique<TestBackend>(probe));
        RecorderWorker bridge(pool,recorder,{width,height,mode,width*3,bytes});
        assert(recorder.start());fail_next_allocation=true;
        assert(bridge.pump_one()==PumpResult::WorkerAllocationFailed && !fail_next_allocation);
        assert(bridge.counters().worker_allocation_failed==1 && recorder.state()==iq4::runtime::State::Error);
        assert(probe.encoded==0 && probe.finalized==1 && pool.counters().worker_released_frames==1);
        assert(recorder.reset_error());
    });
}
void test_concurrent_spsc() {
    constexpr std::uint32_t total=20000;
    CopyPool pool(config(4));Pixels source{};ReleaseProbe release{};
    std::atomic<bool> done{false};std::uint64_t consumed=0;
    std::thread t([&]{
        assert(pool.bind_worker());std::uint32_t previous=0;
        while(!done.load(std::memory_order_acquire) || pool.ready_count()) {
            OwnedFrame frame;
            if(!pool.try_pop(frame)) {std::this_thread::yield();continue;}
            const auto id=frame.info().software_completion_id;
            assert(id>previous);previous=id;
            const auto expected=static_cast<std::uint8_t>(id%251);
            assert(std::all_of(frame.data(),frame.data()+bytes,[&](auto b){return b==expected;}));
            assert(frame.info().host_completion_clock_ns==std::uint64_t(id)*1000000);
            ++consumed;
            if((id%13)==0) std::this_thread::yield(); // worker stalls outside any native lock
        }
    });
    while(!pool.worker_ready()) std::this_thread::yield();
    for(std::uint32_t id=1;id<=total;++id) {
        source.fill(static_cast<std::uint8_t>(id%251));
        const auto result=capture(pool,source,view(source,id,std::uint64_t(id)*1000000),release);
        assert(result==CaptureResult::Published || result==CaptureResult::PoolFull);
        if((id%29)==0) std::this_thread::yield();
    }
    done.store(true,std::memory_order_release);t.join();
    const auto c=pool.counters();
    assert(release.calls==total && c.release_success==total);
    assert(c.published+c.pool_full==total && consumed==c.published);
    assert(c.worker_owned_frames==consumed && c.worker_released_frames==consumed);
    assert(c.worker_bad_state==0 && c.duplicate_ids==0 && c.stale_ids==0);
}
}
int main() {
    test_constructor_bounds();test_copy_release_and_owned_lifetime();
    test_owner_ui_and_single_release();test_reentrant();test_layout_span_clock();
    test_software_id_wrap_gap_full_and_held();test_unlock_failure_and_closed();
    test_recorder_bridge();test_recorder_wrong_worker_and_encoder_failure();
    test_recorder_source_unlock_uncertain();test_worker_allocation_failure();test_concurrent_spsc();
    assert(source_allocations.load()==0);
    std::cout<<"12 host test groups passed; 20000 concurrent synthetic completions; source C++ allocations 0\n";
}
