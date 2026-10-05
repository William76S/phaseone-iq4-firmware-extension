# Executor02 finite replacement

Replace only frozen Executor01 `executor.o`. The C API, original IFM wait wrapper, native call bridge, listener objects and actual-thread guards remain unchanged. Link the original `native_calls.o` and `wait_wrapper.o`, one shared activity object, and Coordinator07; do not link both executor implementations.

A normally completed manual mailbox is now retired on the next UI admission or SD saved admission. FINISHED→RESERVED CAS serializes UI finish and SD admission. It requires callback completion, a known result, matching task sequence and the original manual activity already released. Borrowed capture activity is not retired by that helper. Its ACK uses a separate CAS and leaves the actual RAW/card/activity owner with the capture caller. Unknown/HOLD is sticky.

A concurrent UI retirement can cause a saved request to return BUSY before enqueue. This is a known no-enqueue outcome, not success or a retry request. Coordinator07 acknowledges that limited failure while retaining RAW. The existing actual Current/VT guard rejects invocation on the same IFM worker or UI thread before Notify/wait; no host test establishes device thread identity.

`analysis/firmware/f3_native_executor_build_02/COMMANDS.json` records normal, ASan+UBSan, TSan and AArch64 compile-only success. Each host variant runs the original 17 regressions and 8 focused groups, including 32 UI/SD admission races. Native callbacks are fixtures. No SDK, library, firmware or camera was executed.

Earlier failed fixture attempts remain in sibling `_failed_fixture_01` through `_04` evidence directories. They included an incorrect enum spelling, an implicit-main return lost by fixture renaming, and an overstrong race assertion requiring enqueue when BUSY is legal. The derived `inherited_fixture_02.inc` changes only include paths, the main name and an explicit return; the actual old test assertions remain unchanged.

Verify with `python3 tools/firmware/f3_native_executor_02/freeze.py --verify`. To repeat the local build, preserve/move the existing evidence output directory, then run `python3 tools/firmware/f3_native_executor_02/build.py`. It uses Apple host clang and the external Zig executable at `build/toolchains/zig-aarch64-macos-0.15.2/zig`, SHA256 `c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c`. The frozen ZIP contains own source/header/test closure and object/evidence; it contains no vendor firmware, SDK or toolchain executable. Runtime acceptance still requires Root's actual linked-ELF/static contract and camera testing.
