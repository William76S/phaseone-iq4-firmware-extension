# F3 owned native render adapter 01

This increment provides callable, host-tested source and AArch64 ET_REL objects for owned generator/CImageBuffer orchestration. It does not include a target address binder, a proved complete-RAW source builder, a whole-render completion provider, or an installed camera feature. No original code was executed and no device was accessed.

`render_plan` uses complete RAW provenance plus its full valid rectangle, nearest `(dimension * percent + 50) / 100` for 100/75/50%, checked sizes and an exclusive reserved budget. Insufficient or unproved upper bounds reject the request and keep RAW ownership. Geometry and boolean attestations are not RAW provenance; a verified source builder must supply them.

`native_render_adapter` owns separate 0x1f0 generator and two 0x58 CImageBuffer storage areas, calls original constructors through checked functions, requires exclusive mutable tags/native-constructed settings and a private worker pool, validates the returned RGB32 plane, and lends it to a synchronous sink before destroying descriptors and generator. Unjoined/failed cleanup retains owners. It never deletes RAW, publishes a file or changes the stock 0.49 clamp.

`native_api_bridge` is a concrete checked-call bridge over an explicitly injected original function table, including the recovered seven-argument PreviewProcess call. It catches C++ exceptions, rejects changed lifecycle identities, and quarantines a thrown destructor/join instead of repeating its unknown partial effects. Target C++ unwind compatibility and constructor unwind ownership are unverified; mandatory table attestations must remain unset until verified. Its AArch64 imports include `__cxa_begin_catch`, `__cxa_end_catch`, and `__gxx_personality_v0`.

`core_receipt` models one original 919d58 pass: exact request/thread/settings/cancel/allocator/output/frame identity; the four actual PreviewProcess return PCs; all nonzero stages completed; nonzero worker count; no cancel; matching return. 91a950 also has cancellation predecessors. No native hook is installed. A receipt for one pass cannot prove RAW decode, additional passes, 75% resampling, rotation or the whole render transaction. The bridge needs a separately proved completion provider covering those paths.

Initialize all jobs, adapters, bridges and receipts to zero and use a single serialized executor. Do not mutate/reinitialize their tables or native objects during a job. The caller must hold independently allocated source/settings/tag/worker/arena owners until cleanup returns OK; aliasing those opaque native objects into the output backing is forbidden by the binder contract, not inspected by this model. No async retention of borrowed plane pixels is permitted.

## Verification

Run from the handoff project root:

```
build/host-venv/bin/python tools/firmware/f3_render_plan_01/collect_static.py
build/host-venv/bin/python tests/f3_render_plan_01/test_collector.py
build/host-venv/bin/python tests/f3_render_plan_01/verify_host.py
build/host-venv/bin/python tests/f3_render_plan_01/verify_target.py
```

The host script records every actual compiler/test argv and stdout/stderr in `evidence/f3_render_plan_01/HOST.json` and `COMMANDS.json`; 80 normal plus 80 ASan/UBSan assertions across four tests passed. Collector tests: 6/6. These fixtures simulate lifecycle and geometry; no IIQ is decoded. Target verification produces four ELF64 little-endian AArch64 ET_REL units, two fresh byte-identical copies each, with undefined-symbol inspection. It does not link, load or execute them.

A standalone CMake subdirectory is provided (`add_subdirectory(tools/firmware/f3_render_plan_01)`), with library `iq4_f3_render_plan_01` and four optional CTest entries. CMake was not available in this child's PATH; direct clang/zig verification is the observed evidence. Do not attach these tests to a target cross build without turning `IQ4_F3_RENDER_PLAN_TESTS` OFF. The raw API bridge uses C++17; the other three units use C11.

For Root's bounded RGB32 JPEG sink, pass `allocation + plane_offset`, remaining `allocation_bytes - plane_offset`, explicit stride/W/H and quality to `iq4_jpeg_stream_rgb32` during the synchronous callback. A successful JPEG encode cannot repair missing complete-RAW provenance or a missing render receipt. The private output transaction must still check/close/sync/publish or clean up; RAW deletion remains outside this interface.

See `analysis/firmware/f3_full_raw_native_adapter_01/REVIEW.md` for exact-original call shapes, capacity numbers and the finite next source-builder/tile questions.
