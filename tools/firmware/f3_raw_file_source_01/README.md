# Saved-IIQ encoded RAW source builder 01

This is an offline, callable C++17 adapter for the original CaptureFileReader and
small map/RawInput APIs. All original functions are injected. No camera, SDK,
deployment, target function invocation, or JPEG/decoded-pixel success is claimed.

`reader_stage.hpp` provides the native reader lifecycle. `source_builder.hpp`
provides an independent, nonmoving 0x30 native tag map and 0x30 RawInput. The
adapter does not call BuildTagsFile with its enormous ICE-relative scratch
offsets. It reproduces the finite observed scalar/blob assignments using the
original map/value methods; blob assignment borrows its pointer.

## Source proof and admission

The caller exclusively holds aligned 0x62c80 reader storage, the native reader's
constructor dependencies/filesystem, an encoded payload reservation and row,
black, calibration and optional embedded-profile reservations. Native functions
and C++ unwinding compatibility must have been independently verified before
the API-table attestation fields may be enabled. `ORIGINAL_BINDING_INPUT.json`
records exact original address/prefix inputs; it does not bind or execute them.

1. Construct and open one reader. Paths are bounded before the native 256-byte
   snprintf call. Open uses the observed `(extra=true, fileFlag=false)` arguments.
2. Obtain the reader's held fd after exact File/FS vtable, owner, open and dirty
   checks. Injected FileOps must inspect this same read-only regular fd. They
   must not close it; the native reader owns it.
3. `inspect_saved_iiq` verifies finite directory/section bounds, exact pread
   return counts, full/crop geometry and supported encoded formats. It accepts
   RawC/T/B at base 0 or TIFF MakerNote base 8, one directory and at most 200
   entries. Other inputs are rejected rather than interpreted as full RAW.
4. Reserve the entire encoded payload before native ReadPayload: its capacity
   assertion is not a recoverable buffer error. Native ReadPayload must return
   the exact section length and stable dimensions.
5. `SourceBundle::build` independently reads the same held fd, compares every
   payload byte in bounded chunks, verifies the end file offset, exact metadata
   and every native row offset, and reads owned black/calibration/WB/profile
   sections with exact byte counts. The original generic metadata read helper
   ignores its read return count; its bool is never used as completeness proof.
6. Construct the owned map and native vector only after those checks. Validate
   vector size and contents before storing original encoded format, payload
   pointer and payload length in RawInput. `ready_encoded_full_section()` is
   derived from these checks. It proves this encoded section and ownership
   contract under injected callbacks, not successful Bayer decode/render/JPEG.

Rows must be within payload extent and strictly increasing. This is a finite
admission policy, not a claim that every valid original encoding has this form.
Type-1 profile blobs at tag 0x548 require a proven out-of-line section (>4 bytes).
No section, or its first byte zero, follows the observed original profile-slot-0
branch. Nonzero profile bytes remain owned and are exposed by `profile()` for the
real generator parser; this adapter does not silently replace that profile.

The six output sizes are not inferred from the TIFF thumbnail. The current real
sample has total Bayer 14308x10760, effective crop (102,106,14204,10652), encoded
RAW 159899952 bytes at file offset 512, and a separate 640x480 TIFF thumbnail.
Public resize rounding remains HANDOFF nearest; output rendering/resize receipts
are separate from this source adapter.

## Ownership and failure

Call `SourceBundle::cleanup()` only after the real renderer has completed/joined
and destroyed native generator/images. Then call `ReaderStage::shutdown()` and
check its result. Only then may caller buffers and independent source/card leases
be released. Map/input destruction does not close the reader or release a lease.
Native tag blobs borrow WB member storage and external black/calibration buffers;
the source object cannot move while those pointers are in use.

Native exceptions or partial destructor failures quarantine the live objects.
Retain their dependencies/storage and stop that path; do not retry a partial
destructor. Native Open's failure-close result is discarded internally, and
native Close clears its open byte before returning a possible close failure.
Neither a false open byte nor a successful helper bool overrides a failed close.
These classes intentionally perform no automatic native cleanup on destruction.

## Build and evidence

From the repository root:

```sh
build/host-venv/bin/python tests/f3_raw_file_source_01/verify.py
build/host-venv/bin/python tools/firmware/f3_raw_file_source_01/collect_static.py
```

`verify.py` generates clearly synthetic IIQ-shaped boundary fixtures, records
actual direct-clang commands, runs normal and ASan/UBSan checks, and builds each
target unit twice with fixed Zig 0.15.2 as AArch64 Linux GNU 2.28 ET_REL. It also
reads the user's real saved IIQ, compares its full encoded section using host
mock native reader/object methods, checks all 10760 rows and profile bytes, and
verifies its hash is unchanged. No vendor function runs in those tests.

`host_posix.cpp` is only a host test FileOps provider. Target FileOps require a
separately verified AArch64 syscall/errno adapter for the borrowed native fd.
Root CMake may add this directory to build the two source units; host tests use
the script and must not expose host_posix as the target filesystem binding.

Actual results and target dependencies are in
`evidence/f3_raw_file_source_01/VALIDATION.json` and `COMMANDS.json`. Static
instruction words are individually checked against original User SHA256
9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb.

Target constructor dependency provenance, native execution, complete render
receipts, profile parser/configuration, sRGB output, full arena upper bounds,
performance and device cleanup remain unverified here. This source adapter is
the actual next input-building layer; these limitations are not a success flag.
