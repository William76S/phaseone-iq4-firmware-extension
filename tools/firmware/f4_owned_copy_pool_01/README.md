# F4 bounded owned-copy handoff, increment 01

This independent C++17 component implements the missing source-buffer-to-worker ownership boundary. It contains no SDK loading, camera I/O, target addresses, ABI calls, installer, UI replacement or storage path. Evidence is host validation and AArch64 cross compilation only. It does not establish IQ4 recording, source resolution, RGB ordering, sRGB transfer/range, exposure timestamps or real 60 fps.

It consumes the source-side obligations frozen in `analysis/firmware/f4_frame_adapter_increment_01/adapter_contract.json`. That contract is a static candidate for the local User ELF; a displayed firmware version or Factory ELF cannot identify the executing User ELF. A real adapter must independently verify the running image, owner and all input claims before setting the verification flags.

## Source side

Construct `CopyPool` on the actual original native owner thread, outside any native source lock. Construction allocates every fixed-size slot and validates the total budget. Default caller choices are deliberately absent: dimensions, active mode, pool count and native thread identity are explicit. Limits are 16 slots, 128 MiB per slot and 256 MiB total. `max_width`/`max_height` size the owned allocation; they do not advertise a supported IQ4 mode.

For each already acquired, completed original slot, the binding supplies `SourceView` and one-use `SourceLease`. Required facts are current original native owner, completed lock slot 0..3, nonzero lock identity, actual W/H, active mode/layout, explicit readable span, exact packed stride `3*W`, software completion U32 and an actual locally observed completion clock U64 in nanoseconds. The clock refers to the software completion observed by the application processor; it is not a sensor/IRQ capture timestamp. A first timestamp of zero is permitted; later timestamps must increase. No timestamp or rate is fabricated.

`capture()` performs finite validation, at most 16 slot claims, one bounded `memcpy`, the supplied original paired release and lock-free publication. It has no allocation, encoder, card call, sleep, condition wait, mutex, unbounded retry or original acquire call. All source-path atomics must be always lock-free; compilation rejects other targets. The binding's release callback must itself satisfy the original owner/lifetime contract and be bounded, `noexcept`, allocation-free and free of codec/file/wait work. The library cannot prove an external callback's implementation.

Publication occurs only after the callback reports `Released`. The callback is invoked exactly once for a verified exclusive lease, including bad layout/span/clock, duplicate, full-pool and closed rejection. It is never invoked for an unverified lock, wrong owner, UI-retained borrow or repeated attempt. An unverified source pointer is never dereferenced. Invalid pointer ranges cannot be proved by this library: `explicit_span` must come from an actual validated original allocation/owner; an invented span is not accepted evidence.

`UiRetainedBorrow` rejects without copying or unlocking. It represents the original page's retained lease; the adapter must allow that page's existing path to resolve it. `SourceLease` has no destructor unlock. `BadLease` and `UiRetained` explicitly leave original ownership with the binding; consuming the wrapper is not a release. Wrong-thread rejection leaves the wrapper available to its original owner. Reentry is rejected before consuming the reentrant wrapper. A known-still-locked or unknown release result halts further acceptance, publishes no copied frame from that attempt and never retries the original unlock. The binding must stop acquiring and resolve original ownership through its verified native path; stopping this pool is not a native unlock.

Software completion IDs use U32 serial arithmetic: equal IDs are duplicates; backward or half-range-ambiguous IDs are stale; `UINT32_MAX -> 0` is accepted. This requires the binding to verify a single uninterrupted native completion-ID epoch. Recreate the session after owner/program/mode/ID reset. A valid ID/clock is marked seen before a full-pool drop, preventing a dropped completion from being resubmitted later. `software_id_steps_skipped` measures software ID steps only. It cannot measure missed sensor exposures. No IDs are assigned to Recorder's `source_sequence`.

## Worker and Recorder

Bind exactly one distinct C++ worker with `bind_worker()`. `try_pop()` is restricted to it and returns an `OwnedFrame` over preallocated independent bytes. It never returns the original pixel pointer, original release callback or native lock context. An outstanding worker lease holds its slot until reset/destruction; a full pool drops rather than waits or overwrites it. The SPSC ring is at most the configured pool count; slots held by workers may make available capacity smaller. Counters are atomic snapshots; `ready_count()` is an observational queue estimate during concurrency, not an admission/ownership decision.

`OwnedFrame` is movable and read-only. Its shared storage survives orderly destruction of the pool while an already obtained owned lease remains, but `CopyPool` itself must outlive all concurrent method calls and source callbacks. Owned leases can be released without a native call. Shut down by stopping the original producer from acquiring, resolving its native lease, stopping acceptance on that owner, and draining/releasing owned copies on the worker. The component does not implement the original native start/stop/destroy lifecycle.

Construct/use `RecorderWorker` only on the bound worker. `RecordingShape` is fixed per session and must equal the explicit `RgbJpegOptions` width, height, mode, packed stride and input span selected by the binding. All Recorder lifecycle methods remain serial on that same executor; UI posts events to it. A runtime mode/shape change is rejected and requires a separately validated session restart. `Color::Unverified` may be copied for diagnostics but the Recorder bridge rejects it; only independently established component RGB order is encoded. `RgbOrderVerified` says nothing about sRGB, transfer/range or output quality.

The bridge copies the owned pool bytes into Recorder's owned `Frame` on the worker, releases the pool lease, then submits/consumes that frame. It passes the measured completion-clock nanoseconds unchanged after an `INT64_MAX` guard and leaves `source_sequence` absent. It adds no resizing, repeated frames, CFR retiming or advertised fps. Root can supply the existing `RgbJpegBackend` as Recorder's backend; its downstream container/card adapter and JPEG function table retain their own verification gates. This bridge does not authorize a POSIX path as the IQ4 CFexpress/XQD filesystem.

Unknown original release reports call Recorder's existing `source_lost()` at most once from the worker; no further pool frames are encoded. Worker allocation failure releases the owned pool lease and calls `source_lost()` on the worker. The existing Recorder handles codec/downstream failures. If finalization/error handling itself throws (for example persistent out-of-memory), the executor must catch it and stop the session; nothing retries an original source release. The previously copied but unencoded pool frames may be discarded after source uncertainty; Recorder's already queued owned frames follow its existing finalization path.

Minimal worker integration (all arguments are measured/proven by a future binding):

```cpp
// On original native owner, outside the source lock:
iq4::f4::CopyPool pool({actualWidth, actualHeight, actualMode,
                       boundedPoolCount, originalThreadIdentity});
// On a separately created single recording worker:
pool.bind_worker();
// codecTable/nativeCardBackend have independent verified contracts.
auto backend = std::make_unique<iq4::recording::RgbJpegBackend>(
    iq4::recording::RgbJpegOptions{actualWidth, actualHeight, 3*actualWidth,
                                  actualPackedSpan, quality, jpegBudget},
    codecTable, std::move(nativeCardBackend));
iq4::runtime::Recorder recorder(queueLimit, actualPackedSpan, std::move(backend));
iq4::f4::RecorderWorker worker(pool, recorder,
    {actualWidth, actualHeight, actualMode, 3*actualWidth, actualPackedSpan});
// start/pump_one/stop all remain on this worker; source owner only calls capture.
```

## Reproduction and evidence

Run from the project root, using only the existing locked compiler:

```sh
python3 tools/firmware/f4_owned_copy_pool_01/build_validate.py \
  --zig build/toolchains/zig-aarch64-macos-0.15.2/zig
```

The script checks the Zig executable SHA/version against `tools/target/toolchain.lock.json`, performs the complete host suite with normal, ASan+UBSan and TSan builds, cross-compiles the pool, bridge and existing Recorder, compiles existing `RgbJpegBackend` for type/target compatibility, creates a deterministic archive, and links but never runs the AArch64 validation executable. It checks ELF machine 183 and linked GLIBC requirements <=2.28. Products are under `analysis/firmware/f4_owned_copy_pool_01/build`; `build_validation.json` contains input/artifact hashes, commands, receipts and explicit unverified device fields. CMake is also provided for Linux/macOS hosts; direct-script builds are the recorded validation.

The archive contains only the new pool and bridge objects. Link it with the existing `iq4_runtime_core`; the standalone validation links a separately compiled Recorder object. `RgbJpegBackend` target compatibility is an object compile, not a verified codec call or RGB-to-JPEG packet test through an actual camera table. Lock-free atomics and bounded source work do not establish a target worst-case execution time; scheduling, cache/memory bandwidth and original release latency require measurement.

Twelve host groups cover constructor bounds; independent bytes and release-before-publication with immediate original-buffer poison; thread ownership/UI borrowing/single release; reentry; shape/span/clock rejection; software wrap/gaps/full queue/held slots; failed/unknown unlock and closed cleanup; Recorder shape/color/clock gates; wrong-worker and codec faults; uncertain native release; worker allocation failure; and 20,000 concurrent synthetic completions. A replacement C++ allocator counts source-thread allocations, including aligned allocation. This is a host guard, not a target timing measurement or attestation of an unbound original release callback.

No temporary camera test, persistent acceptance, install file or 60 fps result is claimed. Remaining target prerequisites are exact current User identity and callable ABI, owner/lease lifecycle, readable allocation bounds, actual mode/stride/color/clock epoch, UI retained-lock handling, tested original release, native worker lifecycle, JPEG binding, real card backend and native recording page/error/exit restoration.
