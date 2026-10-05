# Ordinary capture versus Black Reference — offline evidence 01

All addresses below refer to the exact stock P1Linux 6.03.21 ELF (11,874,544 bytes), SHA-256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`. `COLLECTION.json` contains file offsets, byte hashes, commands and 27 disassembly windows. This is static analysis and explicit host emulation; no device was opened or modified.

## Why StoreQueue alone cannot identify a photograph

NodeManager vtable is `0xdb4980`. Its queue objects are Capture `+0x8`, Calibration `+0x98`, UI `+0x128`, Store `+0x1b8`, Recycle `+0x248`. Direct callers of Calibration enqueue `0x8c58e8` include diagnostics `0x6eeb58`, compare-only `0x797c14`, and ordinary save `0x79d300`. Store enqueue `0x8c5958` also has a diagnostic caller (`0x6eecb0`) alongside the UI path (`0x4929ec`). RawManager fanout `0x8dc278` selects destinations, not ordinary-versus-calibration identity. Consequently `.IIQ`, membership in StoreQueue, or a non-null RAW node are insufficient positive evidence.

## The positive native ordinary branch

At `0x79cd98` CaptureManager `+0x80f8` selects the ProductionTool event group. With ProductionToolEnable (`group+0x1a0`) false, first-black (`CM+0x2708`) true skips the ordinary save. The path through `0x79d13c` additionally excludes CmAbortCapture (`CM+0xc08`) and BlackControl 5 (`CM+0x26fc`). The production path uses its own first-black/abort/DontSaveCapture conditions. The extension deliberately accepts only production-disabled normal saves.

Native ordinary save at `0x79cdc0` copies the native counter to `CM+0x2330` and then the `0x24e8`-byte parameter block beginning at `CM+0x2278` into the node's metadata payload (`0x79ce6c..0x79ce78`). Payload `+0xb8` is the native capture number; `+0x484` is BlackControl; byte `+0x490` is first-black. Node `+0x90` owns the metadata resource, whose `+0x40` is the payload. Node `+0x88` is the RAW resource. The receipt requires CM values and node metadata to agree twice, with owner rechecks.

`CompareImageTestMode` is the event object at ProductionTool group `+0x13c8`; its value lies at event `+0xc0`, hence group `+0x1488`. Constructor `0x5d7530..0x5d754c` supplies default 0 and name string `0xbc6148`. Native `0x79cecc..0x79ced4` already branches on zero toward `0x79d2a0` and ordinary queue call `0x79d300`; nonzero goes to the compare-only path instead. The guard's explicit zero check therefore matches the original entry condition, not an invented default requirement.

Native counter arithmetic includes incrementing the prior value (`0x79ce24` and following stores); a 32-bit wrap or native initial zero must not accidentally disable export. Receipt matching **allows zero** and uses actual node/resource identity plus native lifetime invalidation and project serial/epoch. The host positive-zero test passes. There is no unconditional “skip first picture” rule.

`ORIGINAL_A64_SAVE_GATE.json` executes the actual `0x79cd98` branch graph to the save/skip terminal for 112 combinations of production, first-black, abort, DontSave and BlackControl 0..6 using synthetic memory. All outcomes match the documented native gate. Unknown BlackControl 6 may pass native normal save; the extension rejects unknown values rather than assigning invented semantics.

## Identified Black Reference routes

`ParameterizedBlackCalibrationSequence` constructor is `0x7a2dec`, vtable `0xd755a0`, source-path string `0xd75380`; CaptureMode 7 registration occurs at `0x422a64`. Its Begin `0x7a30a8` enables ProductionTool (`0x7a31e4`), ForceBlackCalibration (`0x7a31f8`) and DontSaveCapture (`0x7a3284`). The extension never writes these events and excludes production-enabled captures.

Timelapse first-black logic at `0x7a1d30` first clears the metadata first-black byte and then, when its first-black condition applies, writes BlackControl 1 plus `+0x490 = 1`. Subsequent ordinary branches use BlackControl 2 or 4 with first-black false. BlackControl alone must therefore not be treated as “1 means ordinary” or “all nonzero means calibration.” The combined native route and metadata receipt make that distinction.

The BlackControl settings mapper `0x6a951c` maps method 2 to 4; generation 0/1/2/3 to values 0/3/1/2. Settings reside at `+0xf28`; CaptureParameters accessor `0x58ef14` leads to its `+0x49c`, which is payload `+0x484` after the object prefix. The extension accepts only the observed enum range, first-black false and the positive ordinary save callsite.

## Queue timing and exception behavior

`0x8c709c` acquires the native queue mutex through guard constructor `0x411bc0`. Its actual append (`0x8c7804`) returns a bool. Notifications occur while the mutex remains held. On the normal exit, the bool is preserved in `w19` and the mutex is released at `0x8c7184`. Outer Calibration enqueue `0x8c58e8` discards the bool and returns void, so observing the outer return cannot prove insertion.

The queue link at `node+0x78` is singly linked: next at `+0`, node owner at `+8`, initialized by `0x8c35c0`. Queue head/tail are `+8/+0x10`. There is no evidenced previous-link member. The implementation therefore walks head to the exact link, bounded at 64 and rejecting cycles, checks tail/next/owner, then rechecks head/tail. It also checks that the guard being released names `queue+0x20`. It never edits the list.

The compiled unlock thunk supplies saved queue (`[sp+0x28]`), link (`[sp+0x20]`) and actual bool (`w19`) to the wrapper. Ready publication occurs under the still-held native mutex, before the original release. A consumer may thus run before the outer enqueue returns and still obtain a receipt. Reentry during earlier notification sees Pending and declines extension export. Original exception release at `0x8c7198` remains intact. Wrapper exceptions remove unconsumed receipts and are rethrown; native queue functions are called exactly once.

`ORIGINAL_A64_QUEUE.json` runs stock queue/link/RAII code with the actual compiled A64 thunk for empty, nonempty, already-linked, null-link and notification-exception-entry cases. OS mutex/event/logging are explicit fixtures; the C++ wrapper is an observation fixture here and is independently tested as real C++ in the 39 host groups. The exception case injects the original landing-pad entry; it does not implement an entire C++ unwinder or prove hardware exceptions.

## Resource identity through ordinary processing

The ordinary branch reaches CalibrationQueue before image processing. The additional identity requirements must survive that processing:

* ICE worker `0x7b8410` pops Calibration (`0x7b8438`); entry `+8` becomes the node and is stored once at `[sp+0x5f0]` (`0x7b8454`). The same saved node is passed to metadata lease `0x495204`, raw lease `0x4950e8`, and UI enqueue `0x8c5920` at `0x7b95ac`.
* UI worker `0x492598` pops UI (`0x4925b4`); entry `+8` is stored once at `[sp+0x58]` (`0x4925d0`). It uses the same leases and passes that saved node to Store enqueue `0x8c5958` at `0x4929ec`.
* Raw getter `0x8c25c0` passes existing node `+0x88` to `0x6f07cc`; metadata getter `0x8c2750` passes existing node `+0x90` to `0x8c36c0`. Both helpers branch immediately on non-null existing resource (`0x6f07f4` / `0x8c36e8`), bypass allocation/initialization, increment the same resource's reference count at `+0x18`, and return the same address. The getter writes back that same address; metadata payload pointer is retained.
* Lease destructors use reference release `0x8c2668` / `0x8c27e0`, which do not clear node resource members. Distinct hard-release functions `0x8c26d8` and `0x8c2850` clear raw/metadata members (`0x8c2740` / `0x8c28b8`) on recycle/disposal paths. Those paths are handled by identity rejection and lifetime receipt invalidation.

`ORIGINAL_A64_RESOURCE_REUSE.json` executes both complete stock getters and existing-resource retain branches with initial reference counts 1 and 7. All four cases preserve node resource, payload pointer and return identity while incrementing the actual reference field. Mutex and active-list bookkeeping are fixtures. This is concrete evidence for the normal lease path, not a whole-program proof of every virtual callee and not execution of ICE calibration. If an unobserved mode changes identity, the guard skips extension JPEG and leaves native RAW/Black Reference untouched.

The reserve and dispose callsites `0x8c5844` / `0x8c5c54` invoke `0x8c32d8`, which forwards a node notification via NodeManager. They are chosen lifetime boundaries for invalidating only project RAM receipts. The historical implementation symbol contains `reset`; it must not be read as claiming that `0x8c32d8` itself performs a hard resource reset.

## Build and remaining limits

`tools/firmware/f3_ordinary_capture_01/LINK_OVERLAY.json` gives the one-object capture03 replacement, extra thunk and exact original bindings. Host validation has 39 groups (normal and ASan/UBSan), including ordinary/black/production/unknown, zero counter, duplicate, reuse, changed resource, overflow, malformed/disconnected/cyclic queue, pending reentry, consumer-before-enqueue-return, failed insertion and exception cleanup. Build evidence is in `analysis/firmware/f3_ordinary_capture_build_01/BUILD.json` and `COMMANDS.json`.

The guard is ready for integration review, not camera-accepted. It preserves the original RAW fanout and never changes security, calibration, queue storage or capture-mode events. It does not solve the separate no-card full RAW source lifetime, available RAM, native decoder source ABI, or Capture One final JPEG acceptance. Frozen Host sender01 remains a transport adapter only and must adopt Root's newer streaming byte ceiling at future integration; the frozen 256 MiB setting is insufficient for measured maximum-resolution quality-100 output.
