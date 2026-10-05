# F3 held-directory unique JPEG names, revision 06

This replaces only frozen Card06 `fs05.o`; it keeps the `F3Fs` layout, `F3Ports`
and every public `_03` symbol. No new device hook, import alias, directory path,
random provider or boot identity is added. Both manual and new-capture coordinator
jobs adopt their actual independent RAW fd and use this same JPEG save port.

The old basename is candidate 0. Candidates 1–4095 add `-0001` through `-0fff`
before `.JPG` / `.jpg.tmp`. The held actual JPEG directory is used, not the RAW
directory unless the caller supplied that same held directory. A final leaf must
return exact `ENOENT` before its temp is created with existing `O_EXCL|O_NOFOLLOW`.
Any existing final type or exact temp `EEXIST` advances to another candidate;
other errors do not prove absence. No prior file is opened, adopted, truncated,
removed or overwritten. All generated names fit the existing 64-byte buffers.

After verified JPEG readback, atomic `NOREPLACE` publication can race with another
creator. Only exact `EEXIST` permits another bounded final-name choice. The same
verified temporary inode stays fixed. Success still requires directory sync and
actual final inode/device/length readback. Guard loss or uncertain completion
latches the old HOLD contract; it does not retry after unknown completion.
Exhausting 4096 choices is a known failure and keeps RAW; this is not an unbounded
uniqueness guarantee. Private RAW-stage naming is unchanged and is not used by
the current manual/captured-public-RAW coordinator route.

Reproduce in a fresh output directory:

```sh
python3 tools/firmware/f3_native_fs_unique_06/build.py --output analysis/firmware/FRESH_FS06_BUILD
python3 tools/firmware/f3_native_fs_unique_06/freeze.py --verify
```

14 normal and 14 ASan/UBSan real host-file groups cover same-generation restart,
old temp/final/symlink retention, creation and publication collisions, finite
exhaustion, non-ENOENT errors, unknown lease/partial completion, and distinct held
RAW/JPEG directories. Host publication uses atomic `linkat` followed by `unlinkat`;
this is not a camera `renameat2` test. The AArch64 object is compiled/inspected only.
No SDK, firmware ELF or camera is executed.
