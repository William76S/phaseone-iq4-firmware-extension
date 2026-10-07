# JPEG restart integration

This offline integration removes the previous F3 renderer/export/coordinator,
JPEG File Settings diagnostics and custom Storage JPEG Size/output substitutions.
The stock JPEG Off/New/All task and stock Size entries are restored. It does not
implement full-size JPEG, JPEG-only RAW deletion, or claim accepted XQD output.
The new stock-JPEG destination component supplies its locked LINK input separately.

Input22 contributes 32 retained precompiled objects and 12 retained hook sites.
39 old F3 objects and 31 old sites are excluded. Shared F4 card/filesystem,
bounded/native JPEG, activity and repaired RTTI objects remain. Archived release
objects and original firmware are retained for exact rollback.

`initialize.c` checks the sealed linked contract (stage 10), repaired native RTTI
(stage 20), then records stage 100. These are admission checks, not JPEG capability
tests. Ratio settings/menu initialization stays connected even on admission failure.
No old F3 storage binding, reader/pool/TLS/arena creation runs at startup. Preserved
F4 resources remain lazy on the existing UI/worker path.

Create a fresh spec with `prepare.py --output <fresh-analysis-dir>`; append each
new `--link-input <locked-LINK.json>` as needed. Identical symbol/address/original
byte aliases are reused; conflicting bindings and duplicate hook sites reject.
Link via `build.py --spec <spec> --spec-sha256 <sha> --output <fresh-build-dir>
--app-version <version>`. `check.py` verifies the 31 removed sites against stock,
absence of removed definitions, retained hooks/startup, and honest report flags.
The result is an unsealed User ELF only; the root task owns final sealing/package.

No camera control or persistent write occurs here. Hardware behavior, XQD output,
and recovery remain unaccepted. The original mtd0 erase-block backup and independent
failed-User recovery gaps prevent describing a candidate as safe to flash.
