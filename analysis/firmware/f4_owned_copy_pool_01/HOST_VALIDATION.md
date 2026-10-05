# F4 preallocated owned-copy implementation — host stage

Completed an independent source-copy pool and Recorder worker bridge under `tools/firmware/f4_owned_copy_pool_01`. No frozen analysis, root status document, SDK stage3 source or existing core implementation was changed. No camera/SDK/network operation was performed.

The source path is fixed-budget, one original owner and one consumer: validate actual completed-slot claims, copy packed `3*W*H` bytes into a preallocated slot, invoke the original paired unlock once, then publish only on confirmed release. It rejects UI-retained locks, wrong owners, incomplete/unverified leases, malformed mode/span/stride/clock, duplicate/stale software IDs, pool exhaustion, reentry and repeat attempts. Unknown/still-held release results stop acceptance, suppress publication and require the original binding to resolve native ownership. The pool never acquires, guesses or retries a native lock.

The worker receives independent owned bytes and metadata only. It has no original pixel pointer, original callback or native context. Recorder integration runs allocation, JPEG/backend work and finalization on the worker, leaves `source_sequence` absent and preserves the observed U64 completion clock after range checks. Actual RGB order is required for this bridge to encode; unknown order can be copied only for diagnostics. sRGB, hardware capture timestamps and sensor frame rate remain unverified.

Recorded validation:

| Layer | Result |
| --- | --- |
| Normal host test suite | 12 groups passed; 20,000 concurrent synthetic completions |
| ASan + UBSan | Same complete suite passed, no reported sanitizer failure |
| TSan | Same complete suite passed, no reported race |
| Source C++ allocation guard | 0 counted allocation across tested source paths, including aligned allocation |
| Fault/lifetime verification | Original pixel poison after release; no source pointer reaches worker; full/held slots remain immutable; allocation/codec/unlock faults tested |
| AArch64 objects/archive | ELF64 little-endian machine 183, target `aarch64-linux-gnu.2.28` |
| Existing RgbJpegBackend | Compiled for target with API82 headers; no codec table or device binding supplied |
| Target validation executable | Linked and ELF/GLIBC inspected, never run |
| Temporary/persistent camera acceptance | Not performed |

The exact local compiler was checked against `tools/target/toolchain.lock.json`: Zig 0.15.2, executable SHA256 `c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c`. Target linked GLIBC version requirements are listed in `build_validation.json` and do not exceed 2.28. This is a build baseline, not proof of the current device loader or ABI.

Two consecutive unchanged full build/test runs produced the same validation manifest SHA256 `0a7004b7c6cea469a018cdabc6280ba439f2885fd805d9aaade762109e144a36` and target archive SHA256 `e11cac6f640d642b7216807b11f91b9d02a81c71a8147a25ac1ce9a3023dcb00`. Source hashes, build commands, host receipts, compiler version and artifact hashes are in that manifest. The archive contains only the new pool/bridge and links against Root's existing runtime core; the separately compiled Recorder object is used in standalone validation. Generated binaries remain build products under `build/` in this independent evidence directory; they are not an installer.

Reproduce from the project root:

```sh
python3 tools/firmware/f4_owned_copy_pool_01/build_validate.py \
  --zig build/toolchains/zig-aarch64-macos-0.15.2/zig
```

The exact integration contract, rejection/ownership rules, limits and shutdown prerequisites are in the source directory's `README.md`. Remaining target work is to prove current User identity and callable original ABI; initialize this pool on the actual owner outside a native lock; establish the allocation/span/active mode/ID epoch/color/clock claims; verify original release/UI-retained lifecycle; and connect the tested worker to real native JPEG, card and page controls. Software completion IDs and synthetic test timestamps are never hardware capability or 60 fps evidence.
