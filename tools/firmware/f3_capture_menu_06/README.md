# F3 native File Settings — independent SD/XQD output

This is a new source revision. Frozen menu05, policy04, their objects and the original User remain unchanged. The build emits exactly two ET_REL replacements: menu06 replaces menu05; policy06 replaces policy04. The original File Settings wrapper04 and its one BL at `0x4f0d34` remain unchanged. No additional object, original call site, alias, native crop setting, original card configuration, security record or calibration write is introduced here.

The actual native File Settings SubMenu retains its complete vendor vtable and Navigator slots. Its own Capture Output subtree contains SD output and XQD output, each with RAW / JPEG / RAW + JPEG. UI order maps to actual F3 modes 0 / 2 / 1. JPEG Size and JPEG Quality are shared. Six sizes are Full, 75%, 50%, 25%, long edge 3840 and 7680; quality is 1–100. Boot BSS means RAW / RAW / Full / 95. All values are process-local selections. They do not modify native selected-card or backup configuration.

`f3_capture_backend_capabilities_03()` is a real external producer03 function. Bit0 means SD backend successfully installed and exact native code pins verified; bit1 means the same for XQD. A missing bit displays Backend unavailable and refuses that card's mode action. Unknown bits refuse both. This mask is not card insertion, mounting, RAW-close success or JPEG success. Those still require actual acquisition and checked producer/card/file receipts. No empty local capability implementation exists in this module.

One atomic packed word holds both modes, common size and quality. `iq4_f3_settings_snapshot_06()` reads it once. At actual node acquisition, producer03 must take exactly one Snapshot06 and use `iq4_f3_settings_for_card_06(snapshot, actual_fs_id, out04)` for each actual card (10=SD, 11=XQD). The immutable snapshot survives later UI changes; UI mode does not create a native selected-card mask. Native fanout context weight2=XQD and weight4=SD, with exact original evidence in `analysis/firmware/f3_native_fanout_mask_review_01`. The existing `_04` snapshot and `_01` mode/policy APIs remain explicitly SD-only compatibility. They cannot substitute for the new dual-card producer path. Never link both policy objects.

Manual Export selected RAW still uses the actual native IFM selection and same native executor. It passes RAW+JPEG semantics regardless of either automatic mode: existing RAW is always retained. The asynchronous completion event, reservation sequence, original coordinator `_06` ABI, shared activity gate and Unknown Hold behavior are retained. Latest export status reports the current or most recent serialized task; the existing status ABI has no card field, so this module does not invent per-card success indicators. JPEG-only with a published JPEG but preserved RAW remains `JPEG saved; RAW kept`.

Settings changes require actual UI ownership and Idle shared activity. Heap/list failures retain partial native objects and refuse retry for this boot. Completion/notification/submit uncertainty enters Hold; it is not converted to success or an owner release. Menu labels are functional bindings only when producer03, coordinator08 and executor03 are actually linked and installed; this source has not been executed on a camera.

Reproduce in a fresh project output directory:

```
python3 tools/firmware/f3_capture_menu_06/build.py --output analysis/firmware/FRESH_MENU06_BUILD
python3 tools/firmware/f3_capture_menu_06/freeze.py --verify
```

The `--build` freeze operation is a one-time authoring step for an unfrozen source directory; it is not part of replay after the manifest exists. The recorded build runs 59 policy groups (including four concurrent atomic writers), 35 native-menu fixture cases per normal/ASan+UBSan variant, then cross-compiles the two target objects with pinned Zig 0.15.2. Host fixtures model vendor objects; they are not camera acceptance. `SOURCE_SHA256.json` and `LINK_OVERLAY.json` identify the exact actual objects and dependencies for Root's final linker. The production integration must remove old menu05/policy04 and retain the stock wrapper exactly once.
