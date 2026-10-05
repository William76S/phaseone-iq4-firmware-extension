# Updater consumer evidence 01

Input: only stock User ELF and original 6.03.18 FWR. `targets.txt` lists 84 unique
complete unwind ranges, each with a provisional role derived from exact bodies.
`evidence/exact_bytes.json` records offsets, full bytes and hashes; disassembly
normalizes each line with rstrip and a retained newline. No firmware or SDK code
is executed. ZIP20 inventory and original XML contain no new device observations.
The runner reference is static rootfs content and is not an actual backup.

```sh
python3 -B tools/firmware/firmware_package_acceptance_collect_static_01.py \
  --output-directory build/FRESH_UPDATER_EVIDENCE_DIRECTORY
python3 -B tools/firmware/user_only_package_01/validate.py --recollect
```

The output directory must be fresh. Default writes `evidence/` only when empty;
validation recreates evidence independently and compares exact file hashes.
Private Ghidra decompilation is a local aid, excluded from the source manifest
and ZIP. Complete selected native functions can be decompiled with the existing
`DecompileIQ4.java` and this target list using Ghidra read-only/noanalysis; its
inferred C types are not a substitute for the included instructions.

Read `../FIRMWARE_PACKAGE_ACCEPTANCE_STATIC_01.md` before interpreting generated
packages. Same-version skip, marker erase-block writes, debug side effects and
destructive Revert remain part of the native installation route.
