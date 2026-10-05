# Preserve a genuine software completion ID of zero

This ABI-compatible revision replaces one `native_mkv.o`. The frozen original writer and scanner rejected a zero local sequence even though the F4 source admits a real uint32 software ID of zero. A recording that started with that value could fail on its first valid frame.

The derivative changes exactly two predicates, in addition to its relative header include: packet checks require a nonzero original observed completion timestamp instead of a nonzero local sequence; scanner checks require a nonzero original observed timestamp instead of a nonzero identity. Header bytes, version2 journal layout, flag2, CRC, EBML sizes, API, structs, order checks and worker extension are unchanged. Scanner still accepts **only flag2**, which declares a software completion identity. Sensor or undeclared identity flags are still rejected. A zero ID is not an ExposureCounter or evidence of a sensor frame.

The first software ID is recorded unchanged, including zero. Subsequent extended IDs and timestamps must strictly increase. The existing worker uses uint32 modular delta and extends an actual `ffffffff -> 0 -> 1` into `ffffffff -> 100000000 -> 100000001`; each journal ID's low32 bits exactly recover the actual original software ID. Gaps are retained, no frame or identity is invented, and duplicate/reversed deltas remain rejected. `frames`, rather than `last_local_sequence != 0`, is the initialization sentinel in both writer and scanner.

From the repository root, use a fresh output directory:

```sh
build/host-venv/bin/python tools/firmware/f4_mkv_software_zero_01/build.py --output analysis/firmware/f4_mkv_software_zero_build_fresh
```

`build.py` records actual argv and exit statuses, source/library/compiler hashes, direct normal and ASan/UBSan tests, complete ffmpeg decoding, and two AArch64 Linux ET_REL builds with identical bytes. The tests use official host JPEG8, the new cleanup worker and codec, and modeled source callbacks. Native source locking/card ownership are not executed by these tests.

Fourteen groups passed in each host mode. They cover original ID0 followed by1 and a real gap; uint32 wrap through the actual worker arithmetic; CRC-checked scanner receipts; immutable-source recovery into a separate new writer; checksum-valid wrong identity flags0/1/3, zero completion timestamp, duplicate sequence and duplicate timestamp; bad CRC; incomplete final cluster; read UNKNOWN retained as HOLD without retry; read failure; and direct writer timestamp/order rejection. Three distinct entropy RGB frames are genuinely encoded and fully decoded. Six generated MKV files are fully decoded by ffmpeg (18 frames) and independently probed with original relative VFR times `0`, `0.033333333`, `0.078`. No output's nominal frame rate is used as a source-rate claim.

`LINK_OVERLAY.json` pins the exact one original object and replacement object. Apply it in addition to the two-object `f4_codec_cleanup_01` overlay; do not link both implementations of the same symbols. The scanner symbol in the same replacement object is also used by movie readback/finalization, so recovery and publication do not retain the former zero-ID rejection.

This is an offline source/host revision and target build, not a camera execution, card publication test, supported recording-mode claim or accepted frame-rate measurement. The original sources remain frozen.
