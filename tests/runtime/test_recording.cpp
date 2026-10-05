#include "../../src/runtime/recording.hpp"
#include <cassert>
#include <cerrno>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <unistd.h>
using namespace iq4::runtime;
struct Mock final : Backend {
    int prepare_count{}, encode_count{}, finalize_count{}, abort_count{};
    bool fail_prepare{}, fail_encode{}, fail_finalize{};
    std::vector<std::int64_t> pts;
    void prepare() override { ++prepare_count; if (fail_prepare) throw std::runtime_error("prepare failure"); }
    void encode(const Frame& f) override { ++encode_count; if (fail_encode) throw std::runtime_error("write failure"); pts.push_back(f.pts_ns); }
    void finalize() override { ++finalize_count; if (fail_finalize) throw std::runtime_error("finalize failure"); }
    void abort() noexcept override { ++abort_count; }
};
template<class F> void rejects(F f) { bool caught = false; try { f(); } catch (const std::exception&) { caught = true; } assert(caught); }
Frame frame(std::int64_t pts, std::optional<std::uint64_t> sequence = {}) { return {{1,2,3}, pts, sequence}; }
int main() {
    auto backend = std::make_unique<Mock>(); auto* m = backend.get(); Recorder r(2, 10, std::move(backend));
    assert(r.start()); assert(!r.recording_indicator()); assert(!r.start()); assert(m->prepare_count == 1);
    assert(r.submit(frame(0,10))); assert(r.submit(frame(16,11))); assert(!r.submit(frame(32,13)));
    assert(r.counters().dropped_queue_full == 1); assert(r.counters().source_gaps == 1);
    assert(!r.submit(frame(32,13))); assert(r.consume_one()); assert(r.recording_indicator());
    assert(r.submit(frame(48,14))); assert(r.exit_page()); assert(r.state() == State::Idle);
    assert((m->pts == std::vector<std::int64_t>{0,16,48})); assert(m->finalize_count == 1); assert(r.stop());
    assert(r.start()); assert(r.submit(frame(1))); assert(!r.counters().source_loss_known);
    r.source_lost(); assert(r.state() == State::Error); assert(!r.recording_indicator()); assert(r.reset_error());
    m->fail_prepare = true; assert(!r.start()); assert(r.state() == State::Error); assert(!r.recording_indicator());
    assert(r.reset_error()); m->fail_prepare = false; assert(r.start()); assert(r.submit(frame(2)));
    m->fail_encode = true; assert(!r.consume_one()); assert(r.state() == State::Error); assert(r.reset_error());
    m->fail_encode = false; m->fail_finalize = true; assert(r.start()); assert(!r.stop()); assert(r.state() == State::Error);
    assert(r.reset_error()); m->fail_finalize = false;
    for (int i = 0; i < 20; ++i) { assert(r.start()); assert(r.submit(frame(1))); assert(r.stop()); }
    assert(r.start()); assert(!r.submit({std::vector<std::uint8_t>(11),1,{}})); assert(r.state() == State::Error);
    char path[] = "/tmp/iq4-runtime-XXXXXX"; assert(::mkdtemp(path)); std::filesystem::path d(path);
    const std::uint8_t bytes[] = {1,2,3,4};
    { AtomicOutput output(path,"ok.test"); output.write(bytes,4); assert(!std::filesystem::exists(d/"ok.test")); output.publish(); assert(output.publish_state() == AtomicOutput::PublishState::Complete); rejects([&]{ output.publish(); }); }
    assert(std::filesystem::file_size(d/"ok.test") == 4); assert(!std::filesystem::exists(d/"ok.test.iq4ext.partial"));
    { AtomicOutput output(path,"ok.test"); output.write(bytes,3); rejects([&]{ output.publish(); }); }
    assert(std::filesystem::file_size(d/"ok.test") == 4); assert(std::filesystem::exists(d/"ok.test.iq4ext.partial"));
    rejects([&]{ AtomicOutput stale(path,"ok.test"); });
    rejects([&]{ AtomicOutput traversal(path,"../escape"); });
    std::filesystem::create_symlink(d/"ok.test",d/"link.test");
    { AtomicOutput output(path,"link.test"); output.write(bytes,3); rejects([&]{ output.publish(); }); }
    assert(std::filesystem::file_size(d/"ok.test") == 4);
    { AtomicOutput abandoned(path,"interrupted.test"); abandoned.write(bytes,4); }
    assert(std::filesystem::exists(d/"interrupted.test.iq4ext.partial")); assert(!std::filesystem::exists(d/"interrupted.test"));
    AtomicOutput::DirectoryOps failed_sync;
    failed_sync.sync = [](int) { errno = EIO; return -1; };
    { AtomicOutput output(path,"sync_failed.test",failed_sync); output.write(bytes,4);
      rejects([&]{ output.publish(); }); assert(output.publish_state() == AtomicOutput::PublishState::FinalNameVisible);
      rejects([&]{ output.write(bytes,1); }); rejects([&]{ output.publish(); }); }
    assert(std::filesystem::file_size(d/"sync_failed.test") == 4);
    AtomicOutput::DirectoryOps failed_unlink;
    failed_unlink.unlink_leaf = [](int, const char*, int) { errno = EIO; return -1; };
    { AtomicOutput output(path,"unlink_failed.test",failed_unlink); output.write(bytes,4);
      rejects([&]{ output.publish(); }); assert(output.publish_state() == AtomicOutput::PublishState::FinalNameVisible);
      rejects([&]{ output.write(bytes,1); }); rejects([&]{ output.publish(); }); }
    assert(std::filesystem::file_size(d/"unlink_failed.test") == 4);
    assert(std::filesystem::exists(d/"unlink_failed.test.iq4ext.partial"));
    // Only this freshly created test directory is removed.
    std::filesystem::remove_all(d);
    std::cout << "PASS: host mock state transitions, owned bounded queue, PTS and source gaps, 20 cycles, failure cleanup, exclusive atomic publish, collision/symlink/interruption. No camera/codec/card claims.\n";
}
