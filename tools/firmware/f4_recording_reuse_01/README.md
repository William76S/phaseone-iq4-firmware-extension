# Existing F4 recording chain: bounded reuse check 01

This increment adds a source-locked **build script only**. It copies the three frozen production metadata/pool AArch64 objects, compiles the five existing worker/Recorder/RGB-JPEG/bounded-C-JPEG/container sources, and creates one deterministic eight-member archive. It does not add an encoder, publisher, native callback, page, worker launcher, codec function table, card path, installer or executable entry. No target object is loaded or executed. Prior host tests and decoding receipts are reused; they are not rerun or upgraded to hardware acceptance.

From the project root:

```sh
python3 tools/firmware/f4_recording_reuse_01/build_reuse.py \
  --zig build/toolchains/zig-aarch64-macos-0.15.2/zig \
  --output build/f4_recording_reuse_host_01
```

The output directory must be fresh. The source lock binds all direct and transitive project headers, the metadata object receipt and objects, the old host-validation records and the existing compiler lock. Target compilation explicitly uses JPEG API82. Each object must be AArch64 ET_REL and have no nonempty `.preinit_array`, `.init_array` or `.fini_array`; those section checks do not establish a final linked process startup contract. The archive is checked for exact eight member names and absence of test-only native bypass symbols. It is a reusable link input, not an installable camera extension.

The useful existing connection is:

```text
actual original Access owner / same UI thread
  -> metadata adapter (production currently metadata-only)
  -> [future independently proven pixel/layout/color/span receipt]
  -> existing CopyPool: bounded copy, original paired release, then publication
  -> existing RecorderWorker on one distinct bound worker
  -> existing Recorder -> RgbJpegBackend -> MjpegMatroskaBackend
  -> existing ExclusiveFile: exclusive partial, fsync, NOREPLACE rename, directory fsync
```

`RecorderWorker` already enforces fixed width/height/mode, packed stride `3*width`, exact owned span, `RgbOrderVerified` and `INT64_MAX` for the observed-completion nanosecond clock. It leaves `Frame.source_sequence` absent because the software completion ID is not a sensor exposure counter. All Recorder lifecycle calls belong on that same worker. Variable observation intervals fit the existing Matroska backend; strict-CFR AVI deliberately rejects nonrepresentable PTS and must not be used to invent a nominal source FPS.

The frozen metadata adapter's `ModeBinding::Unbound`, raw component map, raw channels and calculated `+d8` bytes cannot satisfy the pixel-copy/worker input obligations. Production `request_pixel_copy()` still always refuses. Do not convert those fields into `SourceView.active_mode_layout_verified`, allocation capacity, `RgbOrderVerified` or an sRGB assertion. An actual source allocation boundary, readable mapping, three-component row packing/color proof, uninterrupted completion epoch and bounded original release are required first.

The existing bounded JPEG layer has a hard caller-owned output capacity and all `longjmp` cleanup in C; its target function table is still unbound. Static API82/584-byte matches do not replace a real target ABI call/cleanup test. The old original C++ wrapper can replace its destination allocation without returning the new pointer and is not a capacity-safe substitute. `Iq4JpegApi.binding_abi_verified` is a caller assertion, not a hardware receipt issuer. No default table is supplied here.

Reuse `src/recording/ExclusiveFile`, not the separate older `runtime::AtomicOutput`, for this chain. The recording implementation already uses Linux `renameat2(RENAME_NOREPLACE)` and contains no hardlink fallback. It preserves partials and distinguishes final-name visibility from confirmed directory durability. Real kernel/filesystem support, actual mounted card directory, permissions/space and the original storage-manager write lease remain independent target prerequisites. A POSIX directory string does not acquire an original card lease. Original FileSystem open can truncate, and ordinary original rename can overwrite; neither replaces the existing exclusive publisher.

The next executable integration needs the real native UI/event worker start-stop/error/exit contract plus the independently verified gates above. It must stop source acquisition and resolve native ownership before draining owned frames on the worker. `Hold` from the metadata adapter requires that integration to preserve unresolved original ownership; it is not proof that every partial failure returns the original page to normal. No mode, real 60fps, recording or restoration acceptance is asserted by this build.
