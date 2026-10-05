# F3 capture menu and per-node settings snapshot 01

This is actual C/AArch64 source for the original **File Settings** SubMenu, using the SubMenu/EventItem ABI already exercised by F1 menu04. It is a source/object stage. No firmware candidate is emitted; production menu attachment is **EN0** until the real capture-source/card coordinator consumes this policy. Neither selecting a synthetic leaf nor building an object proves a photo was saved in that format.

`runtime.c` builds one owned `Capture Output` SubMenu with RAW / JPEG / RAW + JPEG leaves mapped to **F3_RAW0 / F3_JPEG_ONLY2 / F3_RAW_JPEG1**, plus nested JPEG Size Full / 75% / 50%. It clones all native vtable header/slots and replaces only title/value text callbacks and leaf activation. SubMenu/EventItem VT+70, RTTI and Navigator enter/return behavior remain original. Existing IIQ encoding/File Format and SD storage enums are unchanged. Allocation-null before attachment retains detached owned allocations and latches same-boot installation off; native throwing-new exceptions retain the original unwind propagation. This matches the conservative F1 menu construction policy; it does not claim a native allocator recovery mechanism.

`wrapper.S` is a concrete wrapper candidate for **BL4f0d34→4e58b8, old LE e1d2ff97**. It calls that original append exactly once with the original arguments, saves its result register state, calls the project append function with the original actual root and return PC4f0d38, then restores results and returns. It has CFI/FDE metadata for both original and project calls. It has not been inserted into a User ELF. The native window/hash contract in `NATIVE_CONTRACT.json` is checked by the build.

`policy.c` is the single owner of the two independent selections. A packed atomic word makes their combined snapshot coherent; field CAS updates do not overwrite the other selection. `iq4_f3_policy_begin_01` is the **only capture-path read** of current selection. It snapshots once into a new serialized coordinator-owned slot. All later worker/card/backup/render decisions must read that immutable slot rather than re-read the UI state. Output dimensions use bounded uint64 percentage arithmetic and floor per axis; no pixel resize is performed here. RAW has want_raw only, RAW+JPEG wants both, JPEG-only wants JPEG and forbids RAW backup publication. Destination selection and required/optional/fallback policies remain for the actual native coordinator.

The source-token/boot/capture IDs supplied to this own ABI are identities, **not proof that a native lease is retained**. Policy finish merely changes its own slot status. It makes no native retain/release, file write/delete, notification, EEPROM or device call. A terminal DONE/FAIL may be supplied only after the coordinator has resolved actual ownership. UNKNOWN retains this slot as Hold and forbids reuse/further policy transitions; it does not cancel a native operation. A new struct cannot be manufactured to circumvent an outstanding coordinator hold.

## Exact next source binding boundary

The frozen static evidence is `analysis/firmware/f3_native_save_settings_static_01`: original RawStorage manager selects a queue item at8dc4a0, reads item+8 as its node, then stores **manager+48=current node at8dc4c0**. The next original loop from8dc4cc fans that node to selected StorageGroups; queue call8dc570 is43ede4(group+988,node). The new native binder should establish its complete-RAW source lease and call policy begin once after acquiring that specific node and before fanout. The semantic boundary is exact; **no guessed private callsite wrapper or native owner reconstruction is present in this module**. The original node+88 RAW pool/reference ABI is still Root's independent task.

All native raw groups nonbusy →8dc1a4 calls8c5990 and then clears manager+48. The zero-active-group branch can also retire at8dc6a4. Before permitting JPEG-only, the actual binder must retain full RAW through render and JPEG checked commit/failure cleanup, rather than disabling groups then allowing those retirement calls to free its source. It must never fake ImageStoredOnXQD or a RAW file success. For RAW+JPEG, both requested outputs must resolve before native source release. UI state should continue to affect only subsequent captures.

The original native SD JPEGOnly setting is a separate SD policy: mode2→SD RAW0/JpegMode1/Backup0. Its proven new-pending route relies on successful XQD flag2 notification. It is not the global three-format implementation delivered by this source.

## Reproduce this source stage

From the project root run:

```sh
python3 tools/firmware/f3_capture_menu_01/build.py --output analysis/firmware/f3_capture_menu_build_01_fresh
```

The script uses the already cached pinned Zig0.15.2, runs only self-owned host fixtures (normal and ASan/UBSan), and cross-compiles AArch64 ET_REL objects. A separate EN1 **inspection-only** menu object retains the concrete native-call body for static inspection; it is not linked or installed. Undefined external helpers/imports, TLS and dynamic sections are rejected. No SDK or target binary is executed. Actual full-RAW renderer, private-source ownership, card lease/commit, reboot/restore and capture-format acceptance all remain unverified.
