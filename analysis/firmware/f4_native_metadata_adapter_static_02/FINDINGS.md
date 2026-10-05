# First native Access adapter: metadata only

Evidence: original static byte/ABI analysis, 30 synthetic host fault groups under normal and ASan/UBSan, and three AArch64 relocatable objects. Target/vendor execution, SDK access, camera operation, copied native pixels, encoding, recording and deployment are all zero. This is additive source; existing Bootstrap02, frame-adapter and CopyPool freezes remain unchanged.

## Native implementation and exact binding

`tools/firmware/f4_native_metadata_adapter_01` contains the actual C++ metadata sampler and a target-only Linux preparation function. It is a component, not a preload launcher or installed page. There is no constructor, automatic preparation/capture, new client, AcquireOwner, ReleaseOwner, second LV, observer installation, direct VideoBuffer call or SaveLvFrame command.

Preparation reads only self-process files. It hashes all 11,874,544 actual `/proc/self/exe` bytes against original User SHA `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`, requires fixed ET_EXEC/AArch64 and zero load bias, verifies actual readonly mapping coverage and all nonwritable mapped PT_LOAD bytes against that original file. Production Native Operations are set internally only after these checks. No public boolean whole-image or hardware-ready parameter is accepted.

The original thread function is invoked only when the caller explicitly requests a sample; its actual returned queue derives the owner through Bootstrap02's queue/manager/UiData/LV/Access/engine double links, original queue/manager/LV/Access/event VT values, LV running state, client 0..4, original registered `UI` name pointer and actual matching Access owner ID. Subsequent sampling/release must retain that original queue and object chain. No caller-supplied owner is accepted in production. Root must still establish the actual UI dispatch integration, callback/lifetime and independent disable/recovery route; this source does not assert those runtime receipts.

| Original method | Complete byte interval / ABI proved from original instructions |
|---|---|
| CurrentThread | 0x710b0c..0x710b20; no arguments, returned native thread/queue pointer. |
| Access Lock | 0x6b618c..0x6b61fc; x0=Access, w1=actual client; checks +0xb0, returns CPU pointer. |
| Access Unlock | 0x6b6250..0x6b62c0; same x0/w1; mismatched owner returns 0, original engine unlock then returns 1. The sampler additionally verifies actual locked index became 4. |
| Access Size | 0x6b61fc..0x6b621c; x0=Access, returns packed two-u32 W/H in x0. No guessed Rectangle/hidden-x8 ABI. |
| Access ID | 0x6b62c0..0x6b62dc; x0=Access, returns u32 locked software ID. |
| Engine wrappers | Lock 0x6b6d1c..0x6b6d44 (CPU=true); Size 0x6b6d44..0x6b6d68; Unlock 0x6b6da0..0x6b6dc8; ID 0x6b6dc8..0x6b6dec. Each uses the same embedded VideoBuffer at engine+0x2170. |

`exact_static.json` records 14 complete original .eh_frame-delimited function byte intervals, exact hex/hash/disassembly and six original VT/name windows. It includes the VideoBuffer functions and 0x793540..0x7939c0 video storage initializer for the raw configuration field provenance. Private names shown by a nearest disassembler label are not treated as symbols or ABI proof.

## Ownership and exact release behavior

The sampler rejects LV+0x188 nonzero and LV+0x1c0 retained flag before Lock, even if the source is otherwise valid. It never borrows an original UI-held frame, clears those fields or calls Unlock for them. It separately rejects VideoBuffer+0xe8 !=4, preventing the original lock's existing-lock diagnostic path.

The original Access Lock is used once with the existing actual client. The sampler then compares same-slot CPU pointer `+0x10+8*lockedIndex`, size `+0x50+8*lockedIndex`, locked index `+0xe8`, locked software ID `+0xf4`, original Size/ID getter returns and the current owner chain. It accepts only bounded nonzero W/H metadata. No pixel is read and no unverified source span is passed to memcpy.

Known-owned success or metadata rejection calls original Access Unlock once. Before that call, owner/client/slot/ID must still match. A true return must be followed by observed locked index 4. On owner change, thrown Lock, malformed post-Lock state, false/thrown Unlock or missing post-release readback, the adapter enters Hold and preserves state. It never retries, forces Unlock, releases another owner, unloads storage or uses a destructor to hide an uncertain release. A partially completed native call therefore remains an explicit runtime recovery boundary; these synthetic tests are not proof that original UI can safely resume/exit after every such failure. Root's eventual integration must honor Hold and its independently verified recovery route.

Timestamp is this module's actual 64-bit CLOCK_MONOTONIC observation after inspecting a completed locked slot. It is not an exposure/hardware timestamp. The original ID is a delayed software completion sequence. Duplicate/stale IDs are rejected and wrap follows u32 half-range ordering; neither new ID nor callback count proves new sensor pixels or real 60fps.

## Layout/capacity honesty and CopyPool boundary

The sampler returns raw original component-map U32s at VideoBuffer+0..0xc, configured W/H at +0xd0/+0xd4, calculated byte budget at +0xd8 and channel count at +0xfc. The initializer positively establishes the declared original field/default relationship. Reading their current values does not establish actual packed rows, RGB/BGR semantics, sRGB/range, sensor/pipeline mode or DMA allocation/mapping capacity. In particular +0xd8 is a calculated span, not a trusted allocation boundary.

Production mode is explicitly Unbound. `request_pixel_copy()` returns NeedsHardwareReceipts unconditionally; production has no receipt issuer or flag accepting synthetic/human boolean true. Thus even matching raw 0/1/2/255 and channel count 3 cannot enable pixel copy. Actual layout/color/mapping-range/allocation capacity evidence must be implemented and accepted in a later additive version before native pixel capture. This source does not advertise a complete clean-frame recorder.

The new synthetic-only bridge connects the frozen preallocated `OwnedCopyPool` to this adapter's original paired-release path. It is compiled out of the production AArch64 object. Full queue drops/release, unverified color rejection and failed-release suppression of publication are tested with owned synthetic pixels; none are hardware receipts. Encoding and queue consumption remain outside source ownership. No duplicate recorder/publisher is created.

## Validation result and next bounded work

30/30 normal and 30/30 ASan/UBSan synthetic groups pass. They cover dormant production intent, retained pointer/flag, wrong owner/thread/name/VT, already locked/invalid slot/null CPU pointer, zero/oversized shape, missing raw metadata, ID mismatch/duplicate/stale/wrap, unavailable clock, reentrancy, thrown/partially completed Lock, getter failure with paired release, false/thrown/partially observed Unlock, owner change, CopyPool full, unverified color and copy suppression after failed release. Host fixtures intentionally bypass original image proof under a separate compile macro and never call original code.

Three ELF64LE AArch64 relocatables compile under the locked existing Zig 0.15.2 aarch64-linux-gnu.2.28 toolchain. Production symbols contain no `copy_synthetic` or `configure_synthetic`. No target executable/shared module is produced or run. Original C++ runtime integration and real target ABI execution remain unverified; relocatable object success does not settle those issues.

Next integration should reuse Root's actual Bootstrap02 UI context to invoke only this metadata stage, accepting a real original unlock/readback result before proceeding. Pixel/encoder/Card AVI/Matroska stages must consume genuine independent owned frames after release and keep their already existing exclusive publication/error recovery code. Exact native active mode/layout/color/mapping/capacity receipts and target entry/lifetime remain specific unfinished contracts, not invented capabilities.
