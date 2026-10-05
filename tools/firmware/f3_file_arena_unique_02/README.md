# F3 owned scratch collision selection, revision 02

This replaces only frozen FileArena01 `arena.o`, retaining its header, layout and
four public `_01` functions. Native allocator/mapping wrappers, arena capacity,
loan and normal release contracts are unchanged. Source and render callers can
retain their existing generation/nonce arguments.

The old fixed scratch leaf is candidate 0; 1–4095 append `-0001` through `-0fff`
before `.tmp`. Every choice uses the actual held directory and the unchanged
exclusive/no-follow open. Only exact `EEXIST` permits another choice. An old
regular file, symlink or directory is never adopted, mapped, truncated or removed.
Successful creation records the actual fd/inode before reservation and mapping.
All later loan/release checks use that newly-created name and inode. Normal
release removes only this task's own file after its real native-use fence.

This tolerates finite old scratch remnants after a synthetic restart without
pretending they are safe to clean up. Namespace exhaustion, quota/full-card and
other I/O errors still reject work. Unknown lease/owner state retains owners;
no next candidate or cleanup is attempted after unknown completion. The current
coordinator must still check the returned status and preserve RAW on failure.

```sh
python3 tools/firmware/f3_file_arena_unique_02/build.py --output analysis/firmware/FRESH_ARENA02_BUILD
python3 tools/firmware/f3_file_arena_unique_02/freeze.py --verify
```

17 normal and 17 ASan/UBSan groups retain the 10 original map/loan/reservation/
release faults and add real host scratch remnants, racing exclusive creation,
finite exhaustion, unrelated errors, lease loss and non-regular leftovers.
The host injector owns cleanup of synthetic abandoned test files; that is not a
device HOLD recovery route. Target ET_REL is compiled/inspected, never executed.
