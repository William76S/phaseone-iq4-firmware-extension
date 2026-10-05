# F1 restore baseline 03 — fixed readonly collection

This prepares the remaining actual recovery inputs for frozen F1 Observe Role02.
It does not run a camera, SDK, injector, installer or setter. The current device
User whole digest/length and working Sys transport are useful actual evidence;
they are not runner originals, a cold-boot recovery test or an actual UI owner.

`contract.py` renders only sixteen added fixed profiles, plus three unchanged
process-identity/User-metadata profiles. `profiles.hpp` repeats the renderer in
C++; the original nine-field Plan parser, 242-byte line guard, SDK readiness,
full LE32 receiver, callbacks and cleanup are reused. Python and C++ were
checked against 23 exact synthetic plans. No runtime SDK ABI is added.

`workflow.py` takes a reviewed transport and an exclusive private saving
callback. It requires exact source/EXE/build/controller/echo/serial pins and
strict booleans for the existing private-schema/owner-DACL/final-cleanup/idle
review. It reconstructs complete original raw records and checks request and
capture hashes; it does not treat formatter text or a supplied PID as proof.
The boundary must be backed by the held private receipt reviewer, not values
entered by a caller. No actual Windows adapter/controller execution is added.

The collector reads the actual User `/proc/PID/stat`, executable readlink,
whole executable hash and regular size before collection, and checks ticks /
parent / executable whole hash again after. It saves runner and inittab as two
independent complete originals, checking metadata around each pass, exact
hexdump rows, a last-byte crossing EOF probe and an independent device whole
SHA. Static expected hashes are recorded separately, never substituted for
actual captures. First originals are kept if the second pass fails.

Proc argv/environment use a single `hexdump -v -b -n 4097` without `-s`, twice.
Only a complete terminal address strictly below the cap (at most 4096 bytes)
and a final NUL are accepted. Size zero from proc metadata is not an extent.
4097 bytes, empty/malformed vectors, duplicate environment keys or different
passes stop review. Environment values, argv, modules, addresses and all raw
records stay private. The JSON result itself is private.

`syscall_facts.c` is a separate fixed-path readonly libc helper, with no arguments,
creation, overwrite, signal, ioctl or device-control call. It observes 26 lstat
results, two followed alias-parent stat results and fd-based runner xattr-list
length. Real errno distinguishes ENOENT from EACCES/other failures. It neither
reads xattr values nor interprets PIN/EEPROM. Kernel atime/internal filesystem
effects of ordinary reads have not been excluded. It is not staged. Its
AArch64 review-only executable is not an installation artifact.

The exact native derivative lives in `tools/sdk/f1_restore_baseline_native_03`.
Only three native lines change from frozen readonly octets; one build action
changes. Existing octet executables/controllers cannot accept the sixteen new
labels. Before any device run, Root must derive a new Read-only controller
whitelist/schema/source pin, verify its private inputs, compile this derivative
once, and review actual PE/map/OBJ plus retained startup. The existing actual
EEPROM octet build/run is unaffected. This package adds no runtime launch
entry and has no default device execution.

Run only the SDK-free verification locally:

```
python3 -B tools/firmware/f1_restore_baseline_03/validate_host.py
python3 -B tools/firmware/f1_restore_baseline_03/freeze.py --verify
```

The validation compiles/runs only the own host profile formatter (normal and
ASan/UBSan), parses PowerShell syntax and cross-compiles/inspects the readonly
AArch64 helper. It never starts the SDK-linked Read EXE or target helper.

A private saver can be the unchanged WindowsPrivateSaver `save_path`, called
with a fixed output name in its verified directory. Its returned Path is
normalized as a path string, never promoted into a DACL proof. Filenames for
repeated stat observations include the transaction index to preserve both.
Private summaries and raw argv/environment should not be printed or exported.
