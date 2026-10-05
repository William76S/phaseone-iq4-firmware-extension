# Recorder cleanup after original LV client release

This revision retains source05 frame acquisition, copying, source identifiers and
unlock logic. It adds a UI-only, double-read query of the verified original LV
object's `+0x104` client-ownership byte. Original Stop at `0x520590` releases the
client at `0x520658`, then clears that byte at `0x520660`. A lack of new frames by
itself does not imply release.

The existing periodic recorder control event now requests normal recorder Stop
when the original client has been released, even if the recorder page is still
present. It drains only already-owned copies and uses the existing checked
finalizer and single card release. An unknown object, non-Boolean value or
inconsistent read retains resources and reports error 323. It never calls the
original LV Start/Stop, changes Black Reference settings, or writes calibration.

Reproduce local tests and target objects:

```
python3 tools/firmware/f4_native_stop_06/build.py --output analysis/firmware/f4_native_stop_rebuild
```

Final evidence is `analysis/firmware/f4_native_stop_build_06_final/`: the old
session fails three new counterexamples; the repaired session passes all 17
scenarios normally and with ASan/UBSan. Eight ownership-query cases and the
source05 registry-lock regression also pass in both variants. Native objects,
card and codec ports are explicit fixtures. These tests are not camera execution
or acceptance of Black Reference compatibility.
