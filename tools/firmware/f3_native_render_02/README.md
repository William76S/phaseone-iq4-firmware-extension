# Saved-IIQ full-R0 native render adapter 02

This is offline source and static ABI work with host fault tests and AArch64
ET_REL builds. No camera, original decoder/ICE execution, firmware package or
on-camera acceptance was performed. Frozen render01 and source01 are unchanged.

## Actual source chain

`bind_native_source_02` supplies the 16 fixed original Reader/Map/Tag/RawInput
functions from the pinned User image. `bind_native_render_02` supplies its 17
render/pool functions. Both read every 32-byte original function prefix and
return `Unbound` on host architectures. The deployment owner still checks the
complete installed User version/hash and the actual C++ unwind ABI before
passing `actual_cpp_unwind_verified=true`; a static prefix is not that test.

Use the actual SourceDeps01 getter for `ConstructorInputs` and a held card/source
operation lease. Construct an independent frozen Source01 `ReaderStage`, open
its own read-only native File, and use `held_native_fd()` with
`bind_native_file_ops_02`. This uses actual fstat/pread/lseek on that same fd;
the transaction's other fd cannot substitute for it. Do not call the shared
original Reader's FS setter. Reserve an exclusive encoded payload of
`payload_bytes + iq4_f3_codec8_read_ceiling_02(total_width)` bytes, initialize its
padding, and pass it to `read_candidate`. `SourceBundle::build` verifies the
entire section against the same held fd, builds its own mutable native tag map
and RawInput, and keeps rows/black/calibration/profile/WB storage alive. Source01
`ready_encoded_full_section` proves the encoded source boundary, not decoding.
The concrete getter is `../f3_source_dependencies_01/dependencies.hpp`:
`snapshot_from_ifm` / `snapshot_from_raw_manager`, then `constructor_inputs`.
Module/metadata lifetimes remain under the actual process/source/activity lease.

`persistent_pool_02()` is the retained process instance. Initialize it once with
the actual pool API, acquire its exclusive same-thread lease, and retain its
storage until process termination. Original ctor `716a84` creates workers;
`716c58` starts them. Both are used. `release_after_join(token)` performs a real
native join. No unproved native shutdown or worker destructor is called.
Initialize/acquire/run/release on one actual executing thread. Ordinary pthread
compatibility with every original helper/TLS path has not been proved by these
host tests; use a proved original task/thread executor for native integration.

Set `CombinedCompletion.read` to the bounded actual self-read function, provide
the physically held padded payload capacity and a distinct `total_height` byte
row-state reservation. Its callbacks call the exact decode receipt and frozen
Root core receipt. Use them in `Session`, with a SourceLease whose `still_held`
checks the real ReaderStage/file/card/source identity, and a physically reserved
aligned mmap arena. No caller-set completion bit exists. The seven original
BL slots must be patched to the exact wrappers in `LINK_INPUT.json`.

`Session::run` constructs original settings/generator/two CIBs, configures owned
tags and built-in profile slot0, and calls original `963a28` at scale1/R0 with
aux/crop origins0. Only actual owned row returns + decode join + reader return
+ core terminal/stage joins + normal process return admit the synchronous
RGB32 sink. The borrowed plane must exactly match valid crop dimensions, be
pixel-format5 and lie within the held arena. Original JPEG output-color enum5
is retained; its transfer is not the standard sRGB OETF. No ICC, LUT, RAW style
or RAW pixel modification is introduced. Explicit output rotation/resampling
belongs to frozen Root export03; AsStored/R0 does not assert metadata orientation.

## Bounds and cleanup

The sample storage geometry is 14308×10760; its valid crop is
(102,106,14204,10652). Native reader stack arguments are **top, left**. The
actual sample requires 308166400 decoded bytes, an 80MiB generator prefix, and
at least 2572841472 core image bytes: 2964893952 total is a lower bound, never a
working-set upper bound. A smaller arena may enter a bounded attempt if decoded
storage fits; the original pre-stage allocator capacity tests and real core
receipt reject incomplete output. No 4K fallback is presented as full size.

For pinned codec8/16-bit, the full decoder CFG gives conservative input reads
`4*(9*floor(width/8)+width%8)` (64384 bytes for width14308). Padding bounds the
physical decoder read; the post-return cursor additionally must remain inside
that encoded row. This does not prove malformed bitstream semantic validity.
The decoder writes full storage width: reject before dispatch unless its
native aligned stride from `left+valid_width` equals aligned full-storage
stride. Odd top/valid-height and other unproved formats are rejected.

Normal cleanup joins outstanding jobs, retires receipts, destroys original
CIBs/generator/settings, and then allows source teardown. Check `Session::state`
is clear before SourceBundle cleanup, checked ReaderStage shutdown, arena/FD
release, source lease release and card request release. Native constructor,
process, destructor or unknown receipt failures return `Hold`: retain dependent
source, arena, pool and native objects. Preserve RAW and do not retry a partial
destructor. A failed sink never upgrades a render to a published JPEG.

## Reproduce

Run from the project root:

```sh
build/host-venv/bin/python tools/firmware/f3_native_render_02/collect_static.py
build/host-venv/bin/python tests/f3_native_render_02/verify.py --output evidence/f3_native_render_02/fresh-run
```

Output must be fresh. `COMMANDS.json` records every actual direct-clang and Zig
0.15.2 invocation. `check07/VALIDATION.json` records 136 normal + 136 ASan/UBSan
host groups and seven AArch64 ET_REL units, each rebuilt byte-identically twice.
These are memory/event/ABI models; none execute original native functions. The
actual AArch64 disassembly also checks that the reader receipt gets the native
call SP after the wrapper's 0x240 allocation, while stack arguments are copied
from the original caller SP. The original reader's 0x140 frame is relative to
that native call SP; a wrong-frame host fault is rejected.

For CMake, add the frozen Source01 subdirectory first, then this subdirectory.
Link the existing core receipt target via `IQ4_F3_CORE_RECEIPT_TARGET`, its target
wrappers, and native_runtime01 self-read; do not instantiate another core state.
Set `IQ4_F3_RENDER02_TEST_PYTHON` to this project's host-venv Python for the fresh
offline CTest entry. The direct build is the verified build; CMake is an
integration recipe, not independently verified here.

Nonzero embedded profile parsing, actual native C++ unwind acceptance, complete
on-camera Saved-IIQ execution, actual color appearance and mmap/card performance
remain unaccepted. Device deployment belongs to the single camera executor.
