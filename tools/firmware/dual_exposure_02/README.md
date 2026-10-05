# Dual Exposure exact-third long-tick derivative 02

This local-only module replaces `dual_exposure_01`'s one `dual.o`. It keeps the
original 01 public symbols and their two UI hooks. Add one BL hook at stock
`0x538540` (LE `b18c0794`, original target `0x71b804`) to
`iq4_dual_long_tick_wrapper_02`, and the explicit code alias
`iq4_stock_dual_quantize_02=0x71b804`. Do not link both dual objects.

At the exact stock call the live stock frame has dialog at SP+0x18, base tick at
SP+0x4c, product seconds in S0 and selected ratio in S1. The new wrapper's 32-byte
CFI-described frame loads the former two at +56/+108; the floating arguments
remain untouched. Nine recognized ratios return base−4*n, n=1..9, with the actual
UI graph/current owner, short-current and ratio-current checks. It deliberately
ignores the extension's `busy` flag because the cycle calls stock update while
busy=1. Invalid/unknown parameters call the original seconds quantizer. No
hardware method, calibration record, integration register or ratio setter is
added by this helper.

All instructions after 0x538544 remain stock: original configured min/max,
long-status setter and EXP formatting. Original readout-dependent base bounds
and original callback busy check remain unchanged; the module does not enlarge
the original 0.8s basic-shutter limit. Pins split the previous range across the
one patched 4-byte instruction. The shared activity gate from 01 is unchanged.

Build in a fresh directory:

```
python3 tools/firmware/dual_exposure_02/generate_pins.py
python3 tools/firmware/dual_exposure_02/build.py analysis/firmware/dual_exposure_build_02_repro
```

The pin generator only verifies existing frozen outputs. `LINK_INPUT.json`
contains exact object, original bytes, added alias and hook identities. The
host-only Unicorn receipt executes the linked module and original label
listener/dispatcher, getters, float and long setters, stock update, native
shutter math and clamp arithmetic. It covers 18 cycles while own busy=1,
639 table cases including half-stop bases, two original/extension busy refusals,
unknown-ratio fallback and both native clamps. Model pointers/native-thread
identity, mutex/notification delivery, configured min/max methods and UI text
sinks are fixtures. No target execution or hardware exposure is claimed.

Hardware Ratio is independently documented in
`analysis/firmware/dual_exposure_backend_01`: the actual normal controller reads
status+0x1140 (Ratio object's current float) and passes it to sensor VT+0x80.
It does not derive that call's float from the UI long tick. The notification
fixture does not establish all other asynchronous side effects; hardware and
Black Reference acceptance remain outstanding. The stock busy property was
positively named RunningSequence, but its relationship to Black Reference must
be proved by its producer rather than inferred from that name.
