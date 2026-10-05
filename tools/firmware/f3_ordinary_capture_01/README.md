# Ordinary capture receipt 01

This is an offline-built replacement for **only** the frozen `f3_saved_raw_capture_03/runtime.o`, plus two exact-site AArch64 thunks in one additional object. It gates extension JPEG export on a positive native ordinary-capture receipt. It does not replace, suppress, relink, or manufacture the native RAW queue, calibrations, or Black Reference work.

Stock input: `analysis/firmware/extracted/P1Linux_6.03.21.bin`, 11,874,544 bytes, SHA-256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`.

Integration is described by `LINK_OVERLAY.json` and `ORIGINAL_BINDINGS.json`. Keep every other capture03 object/hook and all its existing dependencies. Do not link both old and replacement runtime objects. `build.py` verifies the frozen capture03 source, generates the replacement with precisely two insertions (configuration/prefix check and consume-before-export), and compiles/tests it.

| Original call site | Original callee | Replacement |
| --- | --- | --- |
| `0x79d300` | calibration queue `0x8c58e8` | enqueue thunk, supplies original `x19` CaptureManager as third argument |
| `0x8c7184` | normal mutex-guard release `0x411bf4` | unlock thunk, reads saved queue/link and actual insertion bool from original frame |
| `0x8c5844` | node reserve notification `0x8c32d8` | invalidate project receipt, then call original once |
| `0x8c5c54` | node dispose notification `0x8c32d8` | invalidate project receipt, then call original once |

The historical internal symbol name `original_node_reset` means the reserve/dispose notification at the two exact sites above. `0x8c32d8` itself forwards a node notification; it is not evidence of a universal hard reset routine. No notification semantics are altered.

The ordinary entry validates native CaptureManager/pool/node ownership; production, compare, abort and first-black states; and copied metadata. The receipt binds pool, node, raw resource, metadata resource, metadata pointer, native capture number (including zero), BlackControl, project serial and invalidation epoch. It is pending until actual native queue insertion succeeds and the expected node link is reachable from the queue head, is the tail, has null next, has the correct owner pointer, and the original mutex guard still names the queue mutex. The table is bounded at 64. Contention/overflow/unknown/read errors reject only the extension operation.

Ready is published immediately before normal native queue mutex release. This avoids depending on the outer void enqueue returning before a consumer runs. Notification reentry while pending fails closed. The native exception-release site remains untouched; a notification exception cannot promote a receipt. No receipt lock is held while invoking the original queue, notification or mutex release. Wrappers rethrow native exceptions. A consumed receipt cannot be reused; reserve/dispose, a new same-node observation, identity mismatch or contention epoch invalidate stale receipts.

Reproduce from the project root:

```sh
python3 tools/firmware/f3_ordinary_capture_01/build.py
python3 tools/firmware/f3_capture_kind_01/collect.py
build/dual-exposure-host-venv/bin/python tools/firmware/f3_capture_kind_01/emulate_gate.py analysis/firmware/f3_capture_kind_01/ORIGINAL_A64_SAVE_GATE.json
build/dual-exposure-host-venv/bin/python tools/firmware/f3_capture_kind_01/emulate_queue.py analysis/firmware/f3_capture_kind_01/ORIGINAL_A64_QUEUE.json
build/dual-exposure-host-venv/bin/python tools/firmware/f3_capture_kind_01/emulate_resources.py analysis/firmware/f3_capture_kind_01/ORIGINAL_A64_RESOURCE_REUSE.json
```

Validation: 39 host fixture groups and the same 39 under ASan/UBSan; 112 original A64 gate combinations; 5 original queue/compiled-thunk cases; 4 original node getter/resource reuse cases. See `analysis/firmware/f3_capture_kind_01/REVIEW.md` for precise evidence and fixture boundaries. This module is **not camera-tested or persistently accepted**. Full normal image/calibration processing is not emulated. A change in identity on a yet-unobserved native path will skip extension JPEG while preserving original RAW behavior. No-card input ownership and Capture One JPEG acceptance remain separate unfinished work.
