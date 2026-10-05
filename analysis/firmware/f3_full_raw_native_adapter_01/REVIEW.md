# F3 full RAW render ABI and owned adapter: bounded offline increment 01

Original: `analysis/firmware/extracted/P1Linux_6.03.21.bin`, 11,874,544 bytes, SHA-256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`. `static/EXACT.json` contains file-backed PT_LOAD offsets, exact raw bytes and per-window hashes. The collector verifies 33 finite windows / 9,722 instructions, 26 fixed words, 17 direct BL targets and the 20-format bpp table. Instruction bytes govern ABI conclusions; decompiler types/names are provisional. `NativeRawReaderJobManager.c` at 9225c0 is the std::function manager operation handler, not the decoding job body. It proves no row worker ABI.

## Concrete entry and ownership

| Fixed original VA | Recovered invocation / behavior |
|---|---|
| 48c394 | x0 manager, w1 catalog index, x2 primary Image, w3 U32 output capacity, x4 secondary Image. 496b4c calls it with the IFM-owned pair and 66,739,712-byte limit. |
| 48c768..48c7dc | Request-local scale clamped to binary32 .01..49 via 48f390. 48c938 copies a task (48ed70); **48c948** is the queue call (48fff8). Owned output Image alone does not remove this clamp or the shared arena. |
| 962058 / 9622a8 | generator construct `(self, backing, uint64 bytes)` / destroy `(self)`. Own 0x1f0 storage; constructor fields reach +1e8. Original caller 7b53e0 supplies 0x3b600000 = 950 MiB. |
| 904550 / 903ca8 | CImageBuffer construct / destroy `(self)`, 0x58 storage including native string. Fresh storage must be zero: constructor reads prior ref flag and may free prior +28. Referenced backing is not freed by descriptor destruction. |
| 960478 | `(generator, sensorIdU32, tagsMap*)`. RawSourceFactory944e88 uses inserting map access and can add defaults. Tags must be newly constructed/copied exclusive mutable native storage, not a cast of const shared metadata. |
| 961208 | `(generator, settings*, profileIdU32)`, verified head captures x1 and w2. The settings/profile path may modify the owned settings and allocate caches. |
| 963a28 | x0 generator, x1 NativeRawInput, x2 primary CIB, x3 planar CIB, x4 native Settings, x5 private worker pool, x6 cancellation byte. Actual call 7b7ed0 preserves this seven-argument shape. |
| 9043c8 / 904448 / 904450 / 904468 / 9043a0 | CIB plane / valid W / valid H / stride / pixel format getters. Plane is `base + top * stride + left * bpp`; fmt5 is 4-byte RGB32. |
| 7b81d4 | Original synchronous encoder VT+28 borrows RGB32 with explicit W/H/quality/output capacity/stride. 7b8318/20 destroy CIBs afterward. 7b982c copies RGB32 bytes +1/+2/+3 to RGB24. No separate complete RGB24 copy is required for Root's row sink. |

Native CIB fields: +0 reference flag; +4/+8 total dimensions incl border; +c/+10 top/left; +14/+18 valid W/H; +1c format; +24 stride; +28 base; +30 signed U32 size; +38 native string. Format table dc4628: fmt3 RGB16 = 6 bytes/pixel, fmt5 RGB32 = 4, fmt12 planar = 1. `903f70` uses its explicit alignment argument; original whole render CIB calls pass 32. Individual native byte-size getters are signed 32 bit; the plan refuses >INT32_MAX even when summed arena bytes are 64 bit.

Native Settings must be constructed with 7bbc54 and destroyed with 7bbf44, minimum 0x2c8 bytes. It includes native containers, not only floats. Known selected-output fields: +0 scale; +4/+8 source valid W/H floats; +c rotation; +20 requested format5; +2b8/+2bc ROI relative valid left/top; +2c0/+2c4 valid ROI W/H. The adapter checks complete valid ROI and exact selected dimensions. NativeRawInput is **0x30**: +0 raw format; +8 begin/end/cap uint32 offset vector; +20 payload pointer; +28 payload lengthU32. +30/+34 in the ICE allocation are adjacent profile fields, not NativeRawInput members. Constructor7bbac0 initializes that vector; 7bbafc destroys it. The source builder must not fabricate zeroed vectors or use the original allocation as writable scratch.

## RAW source boundary

The complete original worker distinguishes file-reader request+38 from pool payload request+40/node+48. File branch7b769c invokes7d9630 into the 620,000,000-byte input cache. 7d9630 checks native reader open state at+62c10 and payload extent+3a56c; insufficient capacity enters assert/abort, rather than a recoverable return. Read uses stream VT+18 after positioning7cc180 and returns0 for a short read. The source builder must check trusted whole-payload extent BEFORE invoking this API, construct a separate native reader and hold its file/metadata/row table through processing.

In-memory branch7b7810 acquires node+88 via8c25c0; 495094 reads pool+40 into payload. 7b7834 acquires node+90 via8c2750; 4950ac reads pool+40 into metadata. 7b78f8 passes payload and metadata to7baadc BuildTags. Root's independent symbol evidence calls +88 `mTestBuffer` and +90 `mFrameBuffer`; names neither prove nor disprove complete RAW. SDK agent's independent `f3_save_transaction_static_01` shows the same payload structure consumed by native full-RAW card save. That is producer-consumer evidence, not an independent completeness proof.

Pool payload+0 is the raw byte pointer; +10 native uint32 offset vector; +2d888 lengthU32. BuildTags maps metadata+58/+5c to tags108/109 total W/H, +60/+64 to10a/10b left/top, +68/+6c to10c/10d valid W/H. Capture producer writes of byte extent/offset vector, their compression-format semantics and completeness are not closed here. Declared dimensions, successful RAW save, TestBuffer/FrameBuffer names, or an initialized native Image cannot set `complete_payload_verified`. The checked source object in the tests is explicitly synthetic and never offered as this target binder.

**Shortest next actual binder:** independent native file-reader manual IIQ path. Already concrete: 7d9630 payload length+3a56c, file row count reader+380a4, row table reader+380a0→7bba90(+24d8), raw format getter7d9710→7b6314, BuildTags7ba364 from reader. Close reader construction/open/destruction and parser section selection (full RAW versus thumbnail), row-offset extent/compression interpretation and complete decoded-valid rectangle before any call. These are finite calls in Worker_complete 7b76b8..7b77bc. Current adapter does not pretend this source-building gap is implemented.

## Actual capacity constraint, rather than global clamp patch

9621e4..962200 reserve 0x5000000 (80 MiB), then store generator remaining size+198 and base+1a0. Stock generator backing950MiB therefore leaves870MiB = 912,261,120 bytes. 963d5c..963d80 subtracts whole decoded RAW byte size9222d0 from that remaining arena before core allocator construction. Raw reader922170 rounds 16-bit rows to32-byte alignment and9222d0 computes stride*height; native actual crop/border must still be included in a proved upper bound.

The following is the tested **host model for 14204×10652 valid RAW and at least two core stages**. These dimensions were supplied as host examples, not a proof of this camera's actual RAW effective area. Stage count, stage ROI bounds, borders, native caches/scratch and allocations outside the backing remain target prerequisites. Each value is optimistic whole-frame/aligned-row geometry, not a sufficient budget.

| selected public dimensions | RGB32 + planar | two whole RGB16 intermediates | native arena minimum model | + whole Bayer16 minimum model |
|---|---:|---:|---:|---:|
| full14204×10652 | 756,718,080 | 1,816,123,392 | 2,572,841,472 | 2,875,528,704 |
| 75%10653×7989 | full-frame render first | same full-frame pair | 2,572,841,472 (max render/resample phases) | 2,875,528,704 |
| 50%7102×5326 | 189,187,456 | 454,022,912 | 643,210,368 | 945,897,600 |

The conditional 50% minimum already exceeds stock870MiB before other storage. A 50% packed RGB24 output alone is113,475,756 bytes, above IFM's66,739,712-byte backing. Owned generator/CIB plus synchronous RGB32 JPEG rows avoids that IFM constraint and extra RGB24 allocation, but does not prove camera RAM or core budget. The plan requires an actually held reservation and verified upper bounds; a free-RAM observation or these minima cannot satisfy admission. OOM/unknown budget must keep RAW; no 4K fallback satisfies the selected mode.

75% PreviewProcess temporarily forces scale1 at963ed0, then resamples RGB32/planar at964468/484. Native output conversion963f8c/90 is FCVTPS (ceil); public HANDOFF target remains nearest `(w*p+50)/100`. Host counterexample139×101@75%: public104×76, native105×76. Native mismatch is rejected until exact full-frame resize is closed. It cannot be repaired by cropping a column or relabeling the selected dimensions.

## Success is not PreviewProcess bool1

Core919d58 attaches output/planar and, for count>1 (919eec..ef4), allocates two complete fmt3 buffers at91ae6c..91aeec before checking capacity. 91aef4 logs capacity failure and exits via91af14/91aa10..20 without processing stages. PreviewProcess nevertheless has a normal bool1 return at9641e0/9641fc. Returned dimensions or initialized pixels therefore cannot prove valid rendered pixels.

Core success/cancel convergence91a950 is usable only with strict guards: completedStagesSP+f0 equals totalSP+130 and bothnonzero; threadCountSP+b4nonzero; cancel*[SP+b8]==0; exact request/thread/settings/allocator/output/frame/arena identity. Join BL91a78c→716e60 precedes the completion counter. 91a940 branches to91a950 on equality, but cancellation also reaches it (919f74 and91a944..94c), so an unguarded hook would be false success. Capacity failure does not reach it. `core_receipt` tests this narrow contract and the four original return PCs963f48/964358/964420/964864. It installs no native hook. Proof for raw-reader decode, all required core calls, any orientation/75% resample and final output remains a separate whole-render completion provider. The raw API bridge does not set completed from bool1; its provider is mandatory and target-unbound.

## Stripe/tile boundary and the next narrow investigation

Existing worker subdivision is height/thread-count rounded up to8 rows at91a3a4..91a3ec. Each0xd0 job receives region-adjusted CIB views from whole backing (904010/904018), while complete intermediate buffers have already been attached. Thus this exact path does not reduce arena residency.

916e38 returns per-stage input ROI;916e78 per-stage output ROI;916fa8 configures all stages and back-propagates regions/borders via stage VT+30/+38. 919b10 dispatches stage VT+18 with native tuples; neither decompiler manager9225c0 nor VT+40 is the stage-processing entry. Independent tiles could require CFA phase/even coordinates, halo beyond the requested output, global settings and stage-local memory. No whole-frame-free alternate entry is proved here. Next finite windows:916ef8 aggregate region,916f80 final format,904018 region translation, individual factory stage VT+18/+30/+38 implementations reached by916fa8; close every stage's absolute-origin and boundary/halo behavior before exposing a row sink. Do not reinterpret 8-row thread jobs as an accepted low-memory renderer.

## Delivered state

Actual source: `tools/firmware/f3_render_plan_01` (three C units and concrete raw-function-table C++ bridge). Tests: `tests/f3_render_plan_01`. Evidence: `evidence/f3_render_plan_01`, 80 normal +80 ASan/UBSan assertions; collector6/6; four AArch64 ET_REL objects each built twice byte-identically. No IIQ decoded, no original/private function called, no hook installed, no camera read/write, no installer/capability claim. The API bridge target imports3 C++ exception-runtime symbols and requires original ABI/unwind proof before binding. This increment provides implementation building blocks and precise blockers; F3 native full-RAW export is still incomplete.
