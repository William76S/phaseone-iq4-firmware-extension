# Canonical native RGB24 source admission, revision 03

This is one ABI02-compatible replacement `source.o`. Link it instead of the
frozen source02 `source.o`; keep the other eight source02/menu03 objects exactly
as frozen. No new entry address, native call, thread, queue, codec, card method,
stop/fence behavior, metadata layout or exported symbol is introduced.

The sample admission now requires the actual four words at `engine+2170` to be
`[0,1,2,255]`, and the existing actual channel count to be three. Six wrong
mapping cases are refused both by measurement and after Start; each normally
returned native borrow is paired with one verified unlock before refusal.
Noncanonical mapping is never silently converted or labeled RGB24. The RGB
copy test uses unequal byte values and verifies their original order survives
owned-copy handoff. It is a synthetic copy test, not a hardware color chart.

Static byte-transfer evidence is in `analysis/firmware/f4_native_source_03/static`:

- `79386c..7938b8` writes native canonical map `[0,1,2,255]` and derives three
  components/capacity. The original four CPU buffer pointers are separate
  fields starting at `engine+2180`; the corresponding DMA pointers start at
  `engine+21a0`. Map and buffer address tables must not be conflated.
- Original format0 paint enters `47552c -> 47f910 -> 47e930 -> 9e9598`. The leaf
  LD3s source bytes0/1/2, then ST4s `[255,byte0,byte1,byte2]`; there is no R/B
  exchange in that transfer. Original encoder `98d8a8 -> 98d680` passes three
  components, writes `in_color_space=2` (native JPEG82 JCS_RGB), and passes each
  input row directly to native `9a3a88`. Its four-component alternative writes
  enum15 (native JPEG82 alpha/R/G/B extension). Together these establish the
  stock byte interpretation as R,G,B for canonical three-component format0.
- The 36-byte `798508` mode block is a separate 3x3 float color matrix:
  `796aa4..796ab4 -> 783360` converts nine floats and writes hardware fields
  `155,154,156,157,159,158,15a,15b,15c`. It does not establish that ColorMode
  changes the four map words, and that earlier inference is withdrawn.
- `7962f8 -> 787210` configures held DMA addresses from the native VB object;
  `797278 -> 787578` updates actual slot dimensions/ROI after hardware frame
  processing. Neither these windows nor the map establish a sensor clock or
  experimentally verified output colorimetry. Source metadata remains native
  software completion ID and UI-observed monotonic completion time.

Frozen source02 README's phrase “opaque native bank-mapping configuration” is
not a sufficient RGB provenance argument. This derivative replaces that broad
admission with the canonical actual map guard and records the precise stock
byte-transfer evidence. Other maps' complete hardware semantics are not
claimed. Device color fidelity, actual dimensions, frame duplication/source
rate, and card recordings remain untested here. No fixed60 or 1080p claim is
made; no sRGB transfer inference is made.

Reproduce into a fresh project output directory:

```
python3 tools/firmware/f4_native_source_03/build.py --output analysis/firmware/f4_native_source_build_03_repro
```

This runs only own host synthetic tests and cross-compiles AArch64 ET_REL. It
never loads SDK or executes firmware. `freeze.py --verify` verifies the saved
source/object/static identities without target execution.
