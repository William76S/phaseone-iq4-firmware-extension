# F3 menu05 truthful SD scope / retained RAW status

This is only a menu04 runtime-object overlay. Policy04, native constructor /
Navigator ABI, manual/coordinator/executor callbacks, hook and all other source
remain frozen. There is no new event, menu, capability, RAW action or worker.

Automatic format leaves and values now say `JPEG (SD only)` and
`RAW + JPEG (SD only)`; XQD automatic output is unsupported by the current
producer and no global JPEG-only behavior is asserted. Existing selected-RAW
manual export remains available under its real source/card admission and
continues to show `Manual: keeps RAW`.

Known ended `phase4` with actual JPEG publication, requested JPEG-only mode and
`raw_removed=0` says `JPEG saved; RAW kept`. Successful actual JPEG-only removal
or RAW+JPEG publication says `JPEG saved`. A publication flag alone no longer
implies JPEG-only completion. Error, pending and Hold behavior is unchanged.

Build only, into a fresh project-local directory:

```
python3 tools/firmware/f3_capture_menu_05/build.py --output analysis/firmware/FRESH_MENU05
```

8 focused normal/ASan+UBSan host groups pass. The normalized source is exactly
frozen runtime04 after accounting for the three include paths, two scope
strings and one retained-RAW status expression. Target undefined symbols are
identical. This does not rerun the unchanged native scheduler/policy tests or
claim hardware export acceptance. Replace only menu04 menu.o with menu05
menu.o; keep policy.o and wrapper.o unchanged. No target/SDK/device executes.
