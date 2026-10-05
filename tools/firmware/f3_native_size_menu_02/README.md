# Native JPEG Size replacement 02

Reuses the frozen 01 native submenu, six choices, original DTO preservation and
the same policy06 API. The only target behavior change is a constructor-stage
gate: `iq4_extensions_installation_stage_02() == 100` must hold before replacing
the original Storage Setup JPEG Size child. Stage 0 or failed stage 50 returns
the original child with no allocation or setting change. Runtime coordinator
Hold does not revert the menu to an unrelated old enum.

The choices are 4K (long edge 3840), 8K (long edge 7680), 75%, 50%, 25%, 100%.
Percentages apply to both dimensions of the complete RAW. No Thumbnail option,
preview enlargement, original enum expansion, or duplicate policy state exists.

Build uses policy08 (quality default 100) with the same policy06 public ABI.
30 normal and 30 ASan/UBSan host processes pass; the target object rebuilt twice
is byte-identical. This is host/static evidence only, not camera acceptance.

```
python3 tools/firmware/f3_native_size_menu_02/collect.py
python3 tools/firmware/f3_native_size_menu_02/build.py
python3 tools/firmware/f3_native_size_menu_02/freeze.py --verify
```

Replace size01's object, keep its exact BL hook. Link the initializer05 stage API.
Legacy JPEG worker unification is still required for the successful-init path;
this component alone cannot change the old JPEG writer into a full-RAW exporter.
The unreleased storage bridge draft is not an accepted dependency or installable
artifact. Root must integrate a completed unification before delivery.
