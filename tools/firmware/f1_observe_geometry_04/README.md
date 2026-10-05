# F1 Observe geometry 04

New offline scalar-only integration of frozen Entry01, Geometry03 and UI02.
It is an actually linked AArch64 SO; it has not been loaded on IQ4 and does not
implement a mask, page, menu, paint hook or installation. Root remains the sole
device executor. All frozen source files and baseline/pipeline03 stay unchanged.

The runtime keeps the exact provider/file/inode/mapped-code checks from Entry01:
User 11874544 bytes, SHA256
`9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`;
ET_EXEC User bias0; libpthread-2.28.so 105736 bytes, SHA256
`9305ff30980749a3f64b3e445764db2bc378d14d1ef8bbe004d0ecc768d00f77`.
The original unlock runs exactly once first, with its original result/errno.
Only caller6be8ac/result0/actual diagnostic-ready qualifies for the own TLS
recursion check, original FP/TP capture, Entry01 owner/dispatch validation and
Geometry03 collect_boundary. Wrong or unavailable owner remains a rejection.

Constructor opt-in remains exactly `IQ4_F1_MODULE_ENTRY_01=OBSERVE`; the default
environment is absent/OFF. Even OFF, a loaded interposer forwards unlocks, so
the original provider/recovery checks must precede any future loading. Failure
to resolve the original provider retains the unsupported scope as Entry01 does;
no fake unlock result, force exit, retry or unload is added.

The actual compiler required one concrete correction: on the default Zig
target, a saved d8 moved the own FP to SP+8, rejected by frozen Inspector's
16-byte FP predicate. Only the new runtime TU uses
`-mcpu=generic-neon-fp_armv8`; its actual prologue saves x29/x30 at SP and sets
x29=SP. It passes only integer/pointer/aggregate-memory arguments across TUs.
The ignored `-mgeneral-regs-only` experiment is not the claimed fix. Target
inspection records one original-unlock BLR followed by the owned thread_local
TLSDESC BLR; two indirect calls are not two unlocks. Disabled diagnostics now
test the ready bit before own TLS. No native instruction address is guessed.

The previous 440-byte `iq4_f1_entry_observed` remains intact for Role02.
New data-only symbol `iq4_f1_geometry_observed_04` is exactly760 bytes. Only
those two publications, `pthread_mutex_unlock`, and the unchanged Role02 status
word are exported. Pointer-based menu/fill/button/observer integration exports
are absent; the actual linked image contains no collect_paint_scope function.

Each new record binds its copied Entry01 observation to a consecutive actual
dispatch epoch and the exact User source hash. The scalar source fields must
agree with the independently double-read geometry: local rect, cache pan,
scale, rotation, countdown, running and visible. Access/engine/buffer-metadata
identities are checked before/after the frozen Probe. Geometry failures clear
all new context/facts even after a previous success. Geometry epoch counts
successful scalar snapshots; attempts/source epoch count qualified dispatches.
None of them is a source-frame counter. Software completion ID is opaque,
may be zero/repeated, and is never interpreted as FPS or a sensor sequence.

There are at most64 geometry publications and64 original TLS getter attempts;
the new runtime disables subsequent diagnostics once either limit is reached.
Startup/invalid-frame rejections before the original getter remain Entry01
finite per-call reads, without allocating events or changing User state.

Captured finite fields include recursive bounds candidate, cached pan and
animation, both scales, quarter-turn, visibility/running/countdown, config
dimensions, owner IDs, locked slot index/size/ROI/software ID and borrow
presence/retention booleans. Buffer pixel pointers and pixel data are unread;
the borrow pointer address is never exported. No Surface or paint input is
manufactured. full_source_mapping_verified/fresh_blit_verified/
surface_lease_verified and paint_scope_called are always0. OFF stays OFF.

## Exact bytes and runtime gaps

`PUBLICATION_LAYOUT.json` and decode_observation.py define all offsets. The
decoder accepts only two identical760-byte copies, even sequences, exact User
binding, epoch accounting, allowed result codes, boolean flags and zero
failure fields. Optional two old440-byte copies must match the embedded
metadata and startup exactly. Stable copies do not prove lifetime, quiescence,
fresh source coverage or actual geometry. No tool reads a target process.

Entry01 permits an original Home→LV stack prefix; frozen Geometry03/UI02
requires sole normal LV. The new module publishes OwnerRejected and the
original stack instead of inventing readiness. Original LV VT b9a9d8 remains
mandatory; overlay01's shadow VT would be rejected. No Memory callback spoofs
the old VT, and this increment does not enable overlay01 or Selector.

The default composed SO includes Role02 ctor EN0; the compiler removes its
inactive constructor slot. An independent ctor-EN1 review candidate actually
links the unchanged authenticated Role02 constructor/stat parser after prepare.
Its init_array order is verified, but no role proof, enabled launcher or
installation is emitted. Existing Role02 generator pins Entry01's old source
and SO and cannot silently accept this new artifact. A later Root-authorized
role increment must bind this exact source/SO plus its actual constructor,
runner/env/FD198/mount/stock-respawn/cold-recovery receipts. FD198 delivery
continues to mean startup only, never current LV or geometry. No hot unload
route is added: original-first forwarding stays resident until stock User exit.

Minimum first Observe receipts, after Root completes original recovery gates:

1. Actual User/exe/PID/start_ticks, original runner dual originals, actual
   boot/respawn flags/mounts/argv/env, original libpthread and cold recovery.
   Baseline03 supplies finite reads for these; its paths/actual results still
   decide the gates. This module does not fabricate them from a local ELF.
2. Exact loaded SO inode/hash/mappings and its dynsym-derived data RVAs,
   authenticated Role02 constructor status and one observed real UI boundary.
   Module base comes from actual mappings, separately from User bias0.
3. Two stable copies each of760 and440 bytes from that same owned mapping,
   then decode with pairing. Preserve failure/unknown and source/geometry epochs.
   Observe ordinary native LV first; Home prefix or missing FP/TLS remains off.
4. Later compare native stock pan/zoom/rotation with scalar candidates. A future
   actual paint wrapper/Surface ownership/fresh coverage and full59-slot shadow
   VT receipt are separate work. Geometry success cannot authorize mask drawing.

## Reproduce offline

Before freeze, build_validate.py runs SDK-free C++ host tests normal+ASan/UBSan,
the exact decoder controls, and target compile/link/inspection. It never loads
the target SO, vendor executable or SDK. After freeze, use `freeze.py --verify`
to check bytes without rewriting outputs. To rebuild, copy the source closure
to a separate output checkout and remove only its copied lock.

```
python3 tools/firmware/f1_observe_geometry_04/build_validate.py
python3 tools/firmware/f1_observe_geometry_04/freeze.py
python3 tools/firmware/f1_observe_geometry_04/freeze.py --verify
```

Target artifacts are ignored local review outputs and not in the source ZIP.
Package-rootfs symbol availability is checked; actual loader resolution,
constructor FD lease, runtime geometry and recovery are unverified.
