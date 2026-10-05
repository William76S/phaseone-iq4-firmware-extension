# Coordinator07 finite replacement

Replace only frozen Coordinator06 `coordinator.o`; keep its original `public_raw.o`. All public `_06` signatures, storage layout, manual/render/codec/file/deletion paths and original source/card ownership rules remain unchanged. Use Executor02, FS06 and Arena02 in the combined implementation; no original object is edited.

Executor BUSY or REJECTED is acknowledged only when the saved job was not enqueued and still has no Reader, bundle, render, pool, source, arena, export or file owners. The captured RAW, actual card and borrowed activity must remain valid. The coordinator publishes FAILED_RAW_RETAINED and releases only its empty reservation. The original Capture02 caller then performs the real checked RAW/card/activity cleanup. This callback itself neither closes nor releases the RAW/card/activity.

Unknown or any impossible BUSY/REJECTED state with an owned resource retains the reservation and latches HOLD. The original queued-task timeout and sink Unknown paths remain unchanged. An Executor OK result does not manufacture JPEG success; it retains the worker's actual outcome. Manual existing IIQ is never deleted. JPEG-only deletion remains the original exact-inode/whole-hash quarantine procedure after normal render cleanup while source/card leases are still held.

`analysis/firmware/f3_save_coordinator_build_07/COMMANDS.json` records 11 focused tests in normal and ASan+UBSan configurations plus one successful compile-only AArch64 object. Tests exercise the actual new routing body. No SDK/target/camera was executed. Earlier fixture compile failures remain in `_failed_fixture_01` and `_02`; they are not passing evidence.

Verify with `python3 tools/firmware/f3_save_coordinator_07/freeze.py --verify`. To repeat the local build, preserve/move the existing evidence output directory, then run `python3 tools/firmware/f3_save_coordinator_07/build.py`. Apple host clang and the exact external Zig executable/hash specified in Executor02 are required. The source ZIP includes the actual MMD header closure, old API headers and focused fixtures. It is not a standalone firmware installation or acceptance result.
