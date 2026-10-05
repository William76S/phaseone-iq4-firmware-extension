# F1 actual User ELF append backend 02: executable CSU startup repair

This separately versioned offline backend repairs a definite omission in frozen
backend01. It never executes a target ELF, opens an SDK/camera, installs a package
or modifies Boot/EEPROM/MTD. Existing backend01, UI02 candidate and its FWP remain
unchanged. The required whole baseline is the 11,874,544-byte User SHA
`9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`.

The actual final UI02 User had a mapped 341-entry DT_INIT_ARRAY, but its executable
entry passes `0x9ef0b0` as a nonzero init callback to original libc. That CSU
function hardcodes the **original** table `0xf41da0..0xf42840` and runs only 340
constructors. Changing the dynamic tags therefore did not connect the new F1
initializer to the real main startup loop. Exact original/candidate/libc/ld body
evidence is frozen in `analysis/firmware/f1_card_boot_failure_review_01`.

## Exact change

Backend02 inherits the finite ET_REL linker, original PHDR/import/EH/TLS
preservation, three stock BL wrappers and 340+1 init-array construction. It adds
only these four original instruction mutations:

| VA | Original LE | Encoded new value |
|---|---|---|
| 0x9ef0bc | 942a00f0 | ADRP x20, actual new array end page |
| 0x9ef0c0 | 94022191 | ADD x20,x20,actual end low12 |
| 0x9ef0c8 | 952a00d0 | ADRP x21, actual new array start page |
| 0x9ef0cc | b5823691 | ADD x21,x21,actual start low12 |

The addresses are derived from the completed new RW layout. Checked signed
21-bit ADRP and unshifted ADD encodings retain x20/x21 and all other CSU bytes,
argc/argv/env forwarding, DT_INIT call, loop, unwind and return. The actual
instructions are decoded again after building: their span must equal both
DT_INIT_ARRAY and the byte-identical 340-original-then-own-initializer sequence.
All other original mutations use backend01's existing finite whitelist.

The public CLI accepts separately frozen **UI03 + display13** only. UI03 excludes
the exact CSU mutation intervals from original mapped-code hashes, retaining the
unmodified intervening word at 0x9ef0c4. Reusing UI02 would immediately reject
the correctly patched CSU RX bytes when the initializer actually runs. Display13
is an independently revised production LCD Surface binding; this backend does
not reinterpret display12's base-Surface assumption as a valid LCD binding.

## Reproduce

Run from a fresh project-shaped source tree, using the pinned Zig0.15.2 and the
payload authors' exact compiler argv replay; canonical eleven object paths and
actual new object hashes are required. Do not rerun their historical frozen
materialize/build_objects scripts. Create an honest fresh lock with:

```sh
python3 -B tools/firmware/f1_user_elf_append_02/input_lock.py --ui-revision 03 --display-revision 13 --output FRESH_LOCK.json
```

Pass its printed SHA to `elf_append.py --stock ... --payload-lock FRESH_LOCK.json
--expected-payload-lock-sha256 ... --app-version 6.3.23 --emit FRESH_USER
--report FRESH_REPORT`. All emitted files must be fresh. Without `--emit`, the
finite CLI outputs only a plan and does not produce a candidate. The actual
compiler/link/package argv and output identities will be recorded in the new
`BUILD_REPRODUCTION.json`; no original identity is translated to new bytes.

`verify_candidate.py` independently checks the actual CSU instruction pairs and
341 selected pointers as well as the inherited raw ELF preservation contract.
`test_elf_append.py` performs 25 host data tests, including the previous DT-tag-only
340-loop regression, four-word whitelist, pointer sequence/order and checked
encoding/alignment/overflow. The small own AArch64 fixture is compiled and read
as bytes; no synthetic firmware is saved and no constructor is executed.

New experimental versions are app6.03.23 / FWR6.03.20 / FWP8.02.2. Building this
repair is not camera acceptance. Actual initializer state, native owner/menu,
LCD geometry/mask behavior and target exception traversal still require target
validation. The updater also changes the MTD0 marker erase block, even for a
LinuxApp-only package; independent marker recovery remains unverified. No
installation or restoration success is inferred from the offline build.
