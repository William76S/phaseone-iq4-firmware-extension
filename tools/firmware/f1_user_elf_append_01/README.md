# F1 actual User ELF append/link backend 01

This is an offline link backend for the exact 11,874,544-byte User SHA-256
`9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`.
The command never executes either the original or candidate and never accesses a
camera, SDK, Boot updater, EEPROM, network, or MTD. A completed link is a local
candidate, not proof of firmware acceptance, restoration or F1 camera behavior.

## Actual inputs, plan and build

The functional input set consists of nine UI ET_REL objects from the frozen
`f1_user_ui_entry_01` (or its separately frozen finite revision 02) and two display ET_REL objects from
`f1_stock_display_payload_12`. `input_lock.py` checks exact whole source-manifest,
object and supporting evidence identities. No raw shared library or synthetic
fixture can be submitted through the finite CLI. The one existing original
libstdc++ export needed by the compiler is independently inspected, never run.

With project root as the current directory:

```sh
python3 -B tools/firmware/f1_user_elf_append_01/elf_append.py \
  --stock analysis/firmware/extracted/P1Linux_6.03.21.bin \
  --report analysis/firmware/f1_user_elf_append_static_01/FRESH_PLAN.json
```

This default plan does not produce any ELF. When the authors have frozen both
real payloads, create a fresh input lock:

```sh
python3 -B tools/firmware/f1_user_elf_append_01/input_lock.py \
  --output analysis/firmware/f1_user_elf_append_static_01/ACTUAL_INPUT_LOCK.json
```

It prints the actual lock SHA; pass that exact value and a separately chosen
newer app version to `elf_append.py --payload-lock ...
--expected-payload-lock-sha256 ... --app-version ... --emit FRESH_PATH
--report FRESH_REPORT`. Outputs must be new files, distinct from the stock input.
The stock file, FWR, Boot and frozen payload sources remain unchanged. Versions
are packaging metadata; a version edit alone is not a functional candidate.
For the final revision 02, supply `input_lock.py --ui-revision 02` and a fresh
output path. Revision 01 is preserved as a provisional local candidate; it is
not silently relabelled as revision 02. The object paths, source identities and
resulting lock SHA must all change honestly where the revised source changes.

## Link and preservation contract

The backend consumes ELF64 little-endian AArch64 ET_REL. It assigns aligned
allocated read-only/executable sections to a new RX LOAD at `0x4240000` and
writable/NOBITS sections to a separate new RW LOAD. It rejects TLS additions,
RWX sections, implicit own compiler init/fini arrays, COMMON, unresolved new
imports and unsupported relocations. Debug sections and their relocations are
not deployed. It performs checked CALL/JUMP26, ADR/ADRP, ADD/LDST, GOT, ABS/PREL,
conditional/literal and bounded MOVW relocations. Every branch offset and width
is checked; original function addresses are obtained from exact stock PLT
instructions/relocations or two fixed exact-byte aliases.

The original active PHDR cannot grow in place: its 10 entries end at file
`0x270`, exactly where PT_INTERP starts. Instead the new 12-entry table is at
file `0xb31758` within an original all-zero 1,614-byte gap. Its VA is
`0xf31758`, which is `first_LOAD_bias + e_phoff`, as the packaged native
AArch64 kernel calculates AT_PHDR. The original RX extent grows only into that
padding. The active PT_PHDR and GNU_EH_FRAME entries are updated; all other old
descriptors retain their values. The original PHDR bytes at `0x40..0x270` remain
byte-for-byte present. This is not a claim that all active descriptor bytes are
unchanged. The two new LOADs follow the original complete BSS without overlap.

DT_INIT, FINI, original TLS, GNU_RELRO, all original symbol indices, PLT/GOT,
JMPREL and dependencies are retained. A new RW init array copies all original
340 entries in their exact order and appends the real UI initializer. Only
DT_INIT_ARRAY pointer/size changes; the old array body remains present. Three
original BLs change after validating exact bytes and destinations:

| VA | Original target | Original LE bytes | Actual wrapper |
|---|---|---|---|
| `0x51ddcc` | `0x477038` | `9b64fd97` | `iq4_f1_lv_draw_wrapper_12` |
| `0x6be8a8` | `0x40a730` | `a22ff597` | `iq4_f1_firmware_unlock_01` |
| `0x4eef2c` | `0x5175b8` | `a3a10094` | `iq4_f1_lv_ctor_wrapper_01` |

The `.imageHeader` app-version four bytes at file `0x9da880` are explicitly
updated. Its remaining 176 bytes remain original. The entire original file is
compared against the completed candidate; changes outside the minimal header,
active PHDR padding, dynamic metadata, three BLs and these four bytes are rejected.
The original section bodies remain, and an appended section directory describes
linked sections and symbols. Section metadata is not a loader execution proof.

## Exception and compiler-runtime handling

All original `.eh_frame`, `.eh_frame_hdr` and LSDA bytes remain. Every new object
retains actual CFI/unwind and exception table relocations. The backend decodes
linked CIE/FDEs (supported zR/zPLR/S formats), verifies new PC/ranges against new
executable sections, and constructs one sorted GNU EH index containing all
32,455 original FDE pairs plus actual new pairs. Required wrappers and initializer
must each have an FDE. PT_GNU_EH_FRAME points at this new index; entries can point
at the unchanged original and linked new FDE sections. CFI/LSDA instructions
themselves are not rewritten. Target unwind traversal has not been executed.

The UI compiler needs `_ZSt9terminatev`. It is absent from the original User
dynsym/PLT but exists as a default `GLIBCXX_3.4` export in the exact packaged
libstdc++ library. The backend admits precisely this one new import, preserving
all 545 original dynsym indices, all original dynstr/versym prefixes, version_r,
NEEDED and all 40 general RELA records. It appends one symbol and one GLOB_DAT
destination in new RW, clones the active tables in new RX, and creates a 16-byte
ADRP/LDR/BR tail thunk to the loader-resolved destination. GNU hash is rebuilt
with one bucket to keep the original symbol ordering. No substitute `abort`
alias or guessed original function address is used. The existing library/version
requirement is mandatory and static, not a new dependency.

## Verification and limits

`python3 -B .../test_elf_append.py` compiles a small own synthetic assembly object
with the already pinned Zig and performs host byte/metadata tests. It does not
execute an AArch64 ELF, and it saves no synthetic firmware candidate. Tests cover
the exact init order, PHDR/AT_PHDR mapping, EH preservation/merge, actual dynamic
symbol/version/GLOB_DAT/GNU-hash construction, checked relocations and refusal
of bad baseline, wrong ELF, TLS, unknown relocations, overflow and unauthorized
original byte changes. `collect_static.py` reproduces native-kernel windows
directly from the exact packaged Boot and existing analysis-only wrapper.

Known target limits remain the payload authors' limits: default OFF, measured
stock UI-owner admission checks, no frame/RAW/JPEG/crop writes, and display geometry
qualification. The first display payload handles only the statically closed
unrotated fit case and hides unsupported rotation/geometry. No static flag is
promoted to camera acceptance. Update-package acceptance and independent stock
recovery require separate verification; this backend does not install anything.

## Frozen actual revision

The final local candidate uses UI revision 02 and display revision 12.
`analysis/firmware/f1_user_elf_append_static_01/BUILD_REPRODUCTION.json` records
the actual eleven original compiler argument lists, object and source identities,
finite payload lock, link command and stock-wrapper02 packaging command. Replay
compilation in a fresh project-shaped tree using the same canonical object paths
and create an honest fresh lock from the new object bytes. Do not rerun historical
`materialize.py` or `build_objects.py` after their authors froze those sources.
The independent source-bundle replay tool performs this fresh compilation.

The User is 12,365,792 bytes, SHA-256
`aa9c594ac60f594ed7e14b8cc5d765c356d759b72001f1c4ec5469087aa8d115`;
the final FWP is 12,366,866 bytes, SHA-256
`7e7503101db6c046b29b15cc131f494d33b890dffff98c73bb2e374112d06658`.
The app/FWR/FWP versions are experimental 6.03.22/6.03.19/8.02.1. Two actual
links from the frozen input lock produced identical User bytes and reports.
The UI01 candidate remains a separately labelled provisional artifact.

This is an uninstalled, unaccepted candidate. The stock partial updater also
changes the MTD0 update marker erase block; packaging only LinuxApp does not
remove that side effect. Marker originals and an independent stock recovery
route have not been validated. Do not infer installation safety from the
host link, CRC, manifest or byte-preservation checks.
