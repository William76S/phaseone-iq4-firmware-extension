# Full-size JPEG quality100 capacity

The real host JPEG8 encoder generated a 299,235,877-byte file from a 14204x10652 deterministic RGB-noise fixture at quality100; full entropy decode passed. The previous 256 MiB output ceiling would reject this legal output. 75% and 50% noise fixtures decoded too, with all JPEG quantizers confirmed equal to one. This is a synthetic host codec test, not a camera RAW conversion.

The new build overlay preincludes limits.h for the two active consumers: stream_export04 and coordinator08. It raises the checked *file length* ceiling to 1 GiB without changing any struct, native ABI, allocation size, row buffer or ownership/RAW-retention behavior. The old inactive transaction module and frozen sources are unchanged. Files larger than 1 GiB still fail safely; no claim that this ceiling accepts every theoretically possible JPEG is made.

Boundary regressions reject the 299 MB budget in the old implementation and accept it and exactly 1 GiB in the new one; 1 GiB+1 is rejected before opening a file. The original 62 JPEG/lifecycle groups are rerun for each old/new/sanitized variant. Build logs are the authoritative actual count. Early build setup failures (expected three active consumers instead of two, then a fixture return-type edit) remain recorded; neither changed a camera or old sources.

Rebuild with `python3 tools/firmware/f3_jpeg_capacity_01/build.py --output analysis/firmware/f3_jpeg_capacity_build_next`. Future Host sender integration must use the same limit.
