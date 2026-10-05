# Finite argv preservation candidate after native Sys parsing

A fixed three-digit octal format can preserve a needed equals sign **until
after** the original two native parsing passes. The exact packaged BusyBox
printf then creates `=` and LF; the packaged xargs ordinary reader treats the
equals sign as data and LF as a separator. This is a positive static argv
candidate with a host synthetic printf-sink demonstration. It is not an EEPROM
restore implementation or a verified camera execution route.

No camera was accessed, no SDK was loaded, no camera packet was generated, no
actual EEPROM destination/record offset/original 16-byte value was used, and no
EEPROM write command was created. The old frozen Shell, Stage2, Stage3,
SYS_EEPROM_RANGE_RESTORE and source-model materials are unchanged. This increment
only adds exact packaged-tool evidence and ten constant host sink tests.

## Source lock and reproduction

- User parsing evidence: exact candidate SHA256
  `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`,
  bound by SHELL_INPUT_GUARD_STATIC and SYS_EEPROM_RANGE_RESTORE_STATIC.
- Rootfs: `analysis/firmware/P1_ramdisk.ext2`, SHA256
  `2ca2a497fb22cb3b16009f5dab2aad1f744982aaafb6c928ac688c0a3f9dbccb`.
- Extracted `/bin/busybox.nosuid`: 719,432 bytes, SHA256
  `bf695c8a770fc3fb0d47b3daf46b5c5841e538b3df17054e73660399d221597d`.
- `/bin/sh`, `/bin/dd`, `/usr/bin/printf`, `/usr/bin/xargs` are rootfs symlinks
  to that same BusyBox. Inventory inode/mode/uid/gid/target/hash and actual
  ext2 content are checked. This does not establish runtime presence, mounted
  rootfs identity, credentials, tool permissions or an EEPROM provider path.
- Run `python3 -B tools/firmware/sys_exact16_argv_collect_static.py`.
  `sys_exact16_argv_static/exact_bytes.json` records every linked BusyBox VA,
  section-derived file offset, exact bytes and range SHA. The derived analysis
  ELF is ignored and can be regenerated; it is never installed or executed.

## Native passes and fixed host demonstration

Literal `=` is a separator in native plain tokens. Native single quotes remain
ordinary bytes. The native quote scanner retains backslashes and does not
implement shell escaped-double-quote semantics. Therefore nesting an escaped
double quote is not a certified preservation method.

The neutral fixture instead contains only printable ASCII, the known outer
double quotes, a single-quoted **fixed format with no spaces**, retained
backslashes and no literal equals sign. The actual 256-byte Shell line model is
used, including the `IqpDevelRaw` prefix, per-readline zero tail and both passes.
The input is strictly below the separate 242-byte text bound. The fixed model
and host `/bin/sh` then execute only printf → xargs → printf, producing:

```
<alpha=beta>
<count=16>
```

The payload words are synthetic and carry no actual record data or destination.
The host shell's single-quote/pipeline behavior is a host observation; this
increment does not execute target ash or completely reverse its parser. A
finite target printf-only readback remains required before using this candidate
as an actual command encoder. It does not authorize a general command selector.

## Exact packaged printf behavior

The verified applet table maps `printf` index 118 to VA `0x69ef4`; the complete
function ends at `0x6a444`.

- `0x69f90..0x69f94` branches on backslash; `0x6a03c..0x6a048` advances the
  format pointer past that backslash and distinguishes the special `c` case.
- `0x6a3cc..0x6a3e4` invokes helper `0x8f354` with a pointer to the current
  format cursor, masks the returned result to one byte, calls `0xdb4c`, and
  resumes from the helper's updated cursor.
- `0x8f358` selects base 8 by default. `0x8f370..0x8f388` checks the current
  digit against that base. `0x8f3b0..0x8f3b8` accumulates and checks the value
  against 255; `0x8f3e0..0x8f400` consumes at most three digits and returns the
  accumulated byte with the advanced cursor.
- `0xdb4c..0xdb88` writes the byte through stdout or its overflow path.

Thus the exact three-digit octal forms `075` and `012`, each following a retained
backslash, select byte 61 (`=`) and byte 10 (LF) **inside printf after native
parsing**. The finite model rejects shorter/non-octal/overflow forms, arbitrary
format conversions in the producer, interpolation and caller-selected formats.

## Exact packaged xargs behavior and missing options

The applet table maps `xargs` index 193 to VA `0x84968`; complete main ends at
`0x84c6c`. Its option string at VA `0xa2ff0` is:

```
+trn:s:e::E:I:i::P:+a:
```

There is **no `-0` or `-d` option** in this build. A host xargs version supporting
NUL/custom delimiters cannot be used as evidence that the target does. The
candidate uses only LF-delimited fixed printable operands with no internal
whitespace, NUL, quote or backslash.

- `0x849f8` sets default delimiter byte 10; `0x84a00` sets max processes 1.
- `0x84b34..0x84b38` selects ordinary reader `0x845bc` when no replacement
  options are requested, and `0x84b70` calls that reader.
- Reader `0x84614..0x84624` classifies ASCII space and bytes 9..13 as whitespace.
  Byte 61 takes the ordinary data-storage path `0x84628..0x8462c`.
- On completed operand, `0x84678` writes NUL and `0x846c0..0x846c4` appends it
  with `0x843e4`. That helper grows/stores an argv pointer; it does not parse a
  second native `=` separator.
- The option order gives `r` bit1. `0x84b84..0x84ba4` checks whether new operands
  are empty and skips execution with that flag. Without a fixed destination
  command, main's fallback would be echo; no restoration adapter may rely on
  that fallback.
- `0x84bec` invokes launcher `0x84740`. The default max-processes=1 branch
  passes the assembled argv to wrapper `0x94064`, then spawn `0x93fdc`.
  `0x94014` calls `execvp` with argv[0]/argv. It is not another `sh -c` layer.
  The complete launch/wait paths are retained in the exact windows.
- Main bounds its ordinary argument input capacity using the platform limit
  capped at 32,768, minus 2,048 and the initial argv byte count
  (`0x84a78..0x84ad8`). Any future finite adapter still needs its own much
  smaller count/length limits and exactly one intended invocation.

These static paths do not certify successful exec, permissions, command exit,
kernel effects or post-write readback on the camera.

## Conditions still required for a same-original-16-byte restore adapter

The existing kernel/dd report provides the relevant byte-write primitive and
failure behavior, but no actual write route is complete yet. The candidate
would be scoped to **the original already backed-up record1's existing offset
and length exactly 16**, never a selected credential, key, counter, security
level, calibration block or whole EEPROM rewrite. Before an adapter could be
implemented or executed, all of the following must be concrete:

1. Exact running User/kernel/rootfs identity, a successful finite original Sys
   printf-only preservation probe and runtime tool identity/help/behavior.
2. The actual dynamic EEPROM provider path, byte extent, owner/mode, and two
   complete protected original backups with matching full-image hashes and
   independently validated opaque record location. No PIN decoding is needed.
3. A verified temporary owned source containing **only the existing original
   16 bytes**, exact size, permissions, owner and byte equality; its creation,
   removal and original-file restoration routes. This increment creates no
   such RAM file or payload.
4. Fixed executable selection, fixed finite operand keys, exact original
   offset/length and decimal field guards, no output truncation/extension, and
   no alternative destination. The assembled xargs argv must be proven as a
   neutral sink before it becomes a writer; unknown fields reject execution.
5. Complete command reply and independent full EEPROM rereads plus metadata
   after a same-byte trial. at24 can program earlier chunks before a later
   error; its last successful write has no trailing ready polling or readback.
   The sysfs provider's `fsync` is a noop success, not persistence proof.
6. Native cache consistency, reload/normal restart and post-reconnect identity
   plus full EEPROM checks before security recovery can be claimed. The
   existing `Refresh` helper writes logical state and is not a raw reload.

The original record bytes must stay private; no individual credential/body/raw
response or low-entropy value hash is emitted by these fixtures. This increment
closes the equals/argv obstacle at static and synthetic levels; it leaves
runtime discovery, same-byte restoration, failure rollback, cache reload and
actual persistent recovery unverified.

## Verification

Ten new host-only tests pass, including actual owned-line reparse, retained
octals/quotes, constant printf sink, precise generated argv, rejection of NUL
mode/quotes/escapes, overflow octal and whitespace-containing operands. Old
frozen source/model hashes are checked as references. No firmware address,
EEPROM value or write packet is included in executable test fixtures.
