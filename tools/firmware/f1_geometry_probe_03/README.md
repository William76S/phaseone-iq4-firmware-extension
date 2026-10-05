# F1 geometry / paint observation 03

This is a bounded read-only C++ port for a future own RAM Observe module. It
does not install a callback, write a vptr, subscribe an event, call a native
getter, acquire/release a capture buffer, read pixels, change crop/RAW/JPEG,
or enable the frozen overlay or five-choice Selector. No SDK/device operation
is part of these tools. Frozen overlay01 and UI02 are unchanged.

The exact static input is the 11,874,544-byte User ELF SHA256
`9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`.
Linked VAs are file offsets plus 0x400000. A local firmware match is not a
device-original backup or runtime identity receipt.

## Linkable finite interfaces

Construct `Probe(Memory, bias)`, then call
`collect_boundary(BoundaryInput, Observation&)` with architectural state
captured after the original pthread unlock. It invokes the frozen UI02
Inspector to validate TP+0x10, UI queue/current primary LV, actual saved-frame
shape and owner aliases. It then reads the finite scalar set twice. Matching
reads are consistency evidence, not an atomic source lock or hardware frame.

`collect_paint_scope(Memory, bias, PaintInput, PaintScope&)` is callable only
from an own paint wrapper inside the original Control::Draw call. Capture
the wrapper's own FP, LR/callerPC, TP and incoming LV/Surface/draw/clip values
before helpers obscure them. The function validates the original Control and
Manager saved-frame shape and their actual stored arguments. It does not
create such a wrapper or prove that the callback is installed. An Observe SO
which has no paint callback cannot manufacture this input from an idle UI
boundary; it can currently use `collect_boundary` only.

Both retain the **original** LV vptr requirement `bias+0xb9a9d8`. They reject
an installed shadow table. A later installation increment must validate that
same actual instance's complete own header+59 slots, original table receipt
and phase, rather than faking Memory reads to look like the original vptr.

Finite records:

| Fact | Exact static field / constraint |
|---|---|
| LV local Rectangle24 | +0x28; candidate, not full-image viewport |
| Pan object / cached Point8 / animation | **+0x110 / +0x118 / +0x138**, respectively |
| Actual / normal-fit scale | f32 +0x190 / +0x194; finite, positive |
| Quarter-turn / countdown | i32 +0x1b0 / u32 +0x1b8 |
| Running / visible / retained borrow | U8 +0x104 / +0x6f / +0x1c0 |
| Borrow presence | +0x188 pointer tested for null only; address not exported |
| Access binding | LV+0x108 == CoreUiData+0x118; VT c07da8, engine+8 |
| Owner candidates | LV i32+0x100 and Access i32+0xb0; mismatch never grants lease |
| LV config candidates | engine i32+0x4764/+0x4768; not RAW/sensor dimensions |
| Buffer slot metadata | engine+0x2170; +0xe8 in [0,4]; only slots0..3 read size pair+0x50+8*i, ROI24+0x70+24*i, software ID+0xf4 |
| Surface metadata | VT b7b780; Draw at+8 with VT b7b7d8; pitch pixels+0x14, height+0x18, Rectangle24+0x20 |

There are no reads of buffer slot pointer region `[+0x10,+0x50)` or Surface
pixel pointer+0x38. Scalar records do not include pixel bytes, capture pixel
addresses or security fields. The software completion ID is never called a
sensor frame number, timestamp, new sensor frame, or FPS.

Parent traversal is bounded to16 objects, rejects cycles, requires the exact
parent/bounds/transform vtable entries and models alignment on own copies.
Native recursive bounds may write local width/height; unknown helpers retain
other facts but mark the recursive candidate unavailable. Pan getter may
write cached Point8; it is never invoked. `point_candidate`, `fit_candidate`
and `parent_transform` are pure instruction models, not native calls or
enabled mapping ports.

## Actual observations still required

Root's sole device executor must establish actual runtime User whole hash,
load segments/bias, bounded self-read access and the original-first UI
architectural boundary before using the probe. First capture the above
fields at ordinary native LV, then compare stock zoom/pan/quarter-turn states
with actual source-to-screen semantics. Preserve each UI/geometry epoch and
changing/unknown result; two equal reads alone do not settle provenance.

For a future original-first paint probe, capture the actual wrapper arguments
and frames described above, and record provider `manager+0x108`'s actual type
and VT+0x18 getter target using a separate finite read. Current evidence ends
at this dynamic getter: its lifetime/aliasing and display-only ownership are
not yet closed. Never use an arbitrary caller bool as a Surface lease.

Trace the actual native inner display-write path and its clipped coverage,
normal return, Surface identity, dimensions/format and request generation.
Original LV paint and 0x477038 return rectangles are insufficient. A native
Draw VT+0x18 observer is not yet a transparent option: replacing that entry
changes the 0x47f910 default fastpath. Do not install one from this source.
No pixel reading or capture-buffer ownership change is needed for the first
scalar-only observations.

`full_source_mapping_verified`, `fresh_blit_verified` and
`surface_lease_verified` remain false in all successful observations.
`unavailable_geometry_port()` clears ViewMapping/epoch and returns false;
`fresh_receipt_unavailable()` clears Receipt and returns false even if a
caller supplies fabricated positive booleans. Only a separately completed
actual proof may replace these disabled ports in a new increment.

## Reproduce

From the project root run:

```
python3 tools/firmware/f1_geometry_probe_03/freeze.py
python3 tools/firmware/f1_geometry_probe_03/validate.py
```

Freeze runs the exact-window collector and own host tests, uses the existing
pinned Zig0.15.2, builds an AArch64 ET_REL and a link-only ET_DYN SO, and makes
a deterministic public-source ZIP. Both target artifacts remain ignored,
unexecuted and noninstallable. The link-only SO does not have an entry,
constructor/interpose in the own probe object, installer or target loader
compatibility receipt; its actual dependencies/imports are reported. The SO
link excludes the compiler's default C++ runtime; unresolved dependency
symbols are not evidence of acceptance by the camera's loader.

Private Ghidra pseudocode is ignored and not included in the source ZIP or
manifest. Public exact instruction bytes, file offsets, table words and
disassembly hashes are collected from the fixed input. Every line is rstrip
normalized, each file ends with one newline.
