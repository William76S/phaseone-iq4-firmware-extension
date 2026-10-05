# Ratio Mask + native LV Recording, offline candidate 02

This links actual AArch64 code into the pinned stock User. It preserves
Ratio Mask/opacity and adds native LV Recording, owned pre-LCD RGB copying,
native JPEG82 encoding, VFR Matroska writing, checked finalization and stock
exit. It has no F3 RAW-to-JPEG capture/export feature. No target execution,
color/frame-rate measurement, successful card recording or restoration is
claimed by an ELF/FWP build.

The sole baseline is stock P1Linux_6.03.21.bin SHA256
`9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`.
The backend is frozen f1_user_elf_append_02. Source02's nine frozen objects
are consumed once, with source03 replacing only source.o. Cleanup01 replaces
bounded_jpeg and worker; SoftwareZero01 replaces native_mkv. Root compiles
17 actual dependencies. No F3 capture menu or EN0 placeholder is installed.

Three exact original BL instructions are replaced: LCD paint 51ddcc,
LV Settings 4eea58, native menu pop 4fb454. The shared Settings wrapper calls
F1 then F4, preserving original arguments before tail-calling stock SetMenu
exactly once. Non-owned menu pops preserve stock bool and exception behavior.
All 340 original startup functions and 32455 original EH entries remain;
one F1 initializer is added. F4 allocation/worker initialization is lazy.

## Fresh source reproduction

Run from the project root; every output directory must be new. Original
firmware/SDK inputs and the pinned Zig0.15.2 compiler stay local. The repository
keeps text build receipts and source hashes; generated .o and firmware binaries
are local artifacts. Rebuild frozen objects into a new directory rather than
overwriting original build receipts. The artifact remap still requires every
fresh object to match the locked original object size and SHA256.

```sh
python3 tools/firmware/f1_f4_user_integration_01/rebuild_inputs.py --output analysis/firmware/f1_f4_inputs_fresh
python3 tools/firmware/f1_f4_user_integration_01/build.py --output analysis/firmware/f1_f4_User_fresh --f4-build analysis/firmware/f4_native_source_build_02_release_complete/BUILD.json --f4-source-overlay tools/firmware/f4_native_source_03/LINK_OVERLAY.json --cleanup-overlay tools/firmware/f4_codec_cleanup_01/LINK_OVERLAY.json --mkv-overlay tools/firmware/f4_mkv_software_zero_01/LINK_OVERLAY.json --app-version 6.03.29 --artifact-map analysis/firmware/f1_f4_inputs_fresh/ARTIFACT_MAP.json
python3 tools/firmware/f1_f4_user_integration_01/verify_user.py --build analysis/firmware/f1_f4_User_fresh
python3 tools/firmware/native_linked_unwind_01/verify.py --build analysis/firmware/f1_f4_User_fresh
python3 tools/firmware/user_only_package_stock_wrapper_02/package.py --user-payload analysis/firmware/f1_f4_User_fresh/P1Linux_RatioMask_LVRecording_6.03.29.bin --expected-user-sha256 070cd01d88fa7a7a8b15cf8e40df886508018b0d552394478a2a52738df2a9c8 --system-version 8.02.8 --release-version 6.03.26 --app-version 6.03.29 --emit-candidate-directory deploy/f1_f4_candidate_fresh
```

Actual all-source reconstruction is recorded in
analysis/firmware/f1_f4_user_integration_build_02_repro03. All 15
dependency objects were freshly compiled from locked source (three are only
freeze checks); all 17 Root objects were freshly compiled. The 26 linked
objects produced exactly the same 12362448-byte User as build02 attempt02. The separate
inspection decodes all three BL destinations and the wrapper's two calls and
one stock tail. Packaging checks only the official wrapper, nested manifests,
CRC, versions and exact embedded User; it is not device acceptance.

Candidate01 is historical and superseded: it lacked the retained fatal-cleanup
route. Candidate02 retains codec context, native pools and the worker slot on
unknown destroy outcome and blocks restart. The journal accepts actual software
identity zero with a nonzero observation timestamp; it does not fabricate an
identity or claim a sensor counter. All-source rebuilding and independent
wrapper reconstruction produced identical User, FWR and FWP bytes. The current
FWP is 12363522 bytes, SHA256
`3dd3885dadeb8866d87de5636aa1b2d01434bb295ec7b0ce26eff94217726beb`.

The first reconstruction incorrectly retained -MF's old dependency-metadata
output paths. No firmware/source bytes changed. Original metadata was restored
and source03's exact frozen hash verified; the corrected tool relocates both
-o and -MF. The failure and correction are retained in
analysis/firmware/f1_f4_inputs_recompiled_01/DEPENDENCY_OUTPUT_FAILURE_01.json.

Device installation remains separately gated by the original mtd0 marker
erase-block backup and independently verified failed-User recovery.
