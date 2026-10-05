# F1 card candidate source closure 02

This source-only bundle closes UI03 + Display13 + ELF append backend02 and the unchanged stock wrapper02. All previous sources/candidates stay frozen. The two substantive fixes are native csu consumer redirection to the actual341-item init array (with four exact original-word exclusions in UI03), and the positively identified LCD-derived Surface admission in Display13. Default mode remains OFF; host reproduction is not camera acceptance.

`bundle.py` defaults to local plan. It reads nine actual UI03 dependency files and two actual Display13 MMD dependency files; their project-owned source/header closure, actual eleven compiler argv records, UI01/UI02/UI03 provenance, necessary module/Binding derivation sources, core/display headers and toolchain.lock are included. Exact referenced Zig runtime headers remain external dependencies. Vendor User/FWR/FWP/rootfs/Boot/pthread/libstdc++/SDK binaries and private camera backups are never source members.

```sh
python3 -B tools/firmware/f1_card_source_bundle_02/test_bundle.py
python3 -B tools/firmware/f1_card_source_bundle_02/bundle.py \
  --plan-output build/f1_card_source_bundle_02/FRESH_PLAN.json
python3 -B tools/firmware/f1_card_source_bundle_02/bundle.py \
  --expected-ui-source-sha256 ACTUAL_UI03_SOURCE_SHA \
  --expected-display-source-sha256 ACTUAL_DISPLAY13_SOURCE_SHA \
  --expected-backend-source-set-sha256 ACTUAL_BACKEND02_SOURCE_SET_SHA \
  --emit-zip build/f1_card_source_bundle_02/FRESH_SOURCE.zip
```

The manifest records exact member bytes/hashes plus dispositions of every historical reference row. Original full freeze/materialize validators may still need omitted research/toolchain/vendor artifacts; this bundle does not falsely claim those validators are independently runnable. The provided verifier checks its complete actual bundled set. The new replay driver does **not** call old materialize/build_objects/freeze recipes or rewrite bundled dependency files/metadata.

Extract into a fresh project-shaped directory. Copy only the exact OEM User to `analysis/firmware/extracted/P1Linux_6.03.21.bin` and original libstdc++ to `analysis/firmware/f1_user_ui_entry_01/libstdcxx_original_ANALYSIS_ONLY.elf`. Sizes and SHA-256 are in BUNDLE_MANIFEST. Reuse the full external Zig0.15.2 installation whose executable and all referenced files pass the frozen toolchain checks; a standalone zig executable is insufficient. FWR/FWP remain separate exact originals and are passed with full absolute paths to packaging below.

```sh
python3 -B tools/firmware/f1_card_source_bundle_02/bundle.py \
  --verify-bundle BUNDLE_MANIFEST.json
python3 -B tools/firmware/f1_card_source_bundle_02/replay_objects.py \
  --zig /ABSOLUTE/EXISTING/ZIG/zig
python3 -B tools/firmware/f1_card_source_bundle_02/replay_objects.py \
  --zig /ABSOLUTE/EXISTING/ZIG/zig --compile-objects
python3 -B tools/firmware/f1_card_source_bundle_02/replay_objects.py \
  --make-payload-lock analysis/firmware/f1_card_source_replay_02/ACTUAL_INPUT_LOCK.json
```

Each `.o` output must initially be absent. Replay writes honest rebuilt object hashes and a new input lock validated by backend02's finite original-library and 9+2 object role checks. Other absolute source roots can change DWARF paths and whole object hashes; exact final User/package bytes must be independently compared, never assumed.

```sh
python3 -B tools/firmware/f1_user_elf_append_02/elf_append.py \
  --stock analysis/firmware/extracted/P1Linux_6.03.21.bin \
  --payload-lock analysis/firmware/f1_card_source_replay_02/ACTUAL_INPUT_LOCK.json \
  --expected-payload-lock-sha256 ACTUAL_REPLAY_LOCK_SHA \
  --app-version 6.03.23 \
  --emit build/f1_card_source_replay_02/FRESH_User.bin \
  --report build/f1_card_source_replay_02/FRESH_LINK_REPORT.json
python3 -B tools/firmware/user_only_package_stock_wrapper_02/package.py \
  --original-fwr /ABSOLUTE/Firmware-BP-IQ4-IQ4_6.03.18.fwr \
  --original-fwp /ABSOLUTE/XFSystem8.02.0.fwp \
  --user-payload build/f1_card_source_replay_02/FRESH_User.bin \
  --expected-user-sha256 ACTUAL_EMITTED_USER_SHA \
  --app-version 6.03.23 --release-version 6.03.20 --system-version 8.02.2 \
  --emit-candidate-directory build/FRESH_CARD_REPRO_DIRECTORY
```

All outputs must be new. These commands compile AArch64 ET_REL and parse/link/package bytes locally; they never execute target ELF/SDK or access a camera. Stock interface preservation, actual F1 mask button/mode operation, normal-fit display, OFF/native and disable/recovery remain hardware acceptance items in Root's deployment guide. Fresh reproduction evidence generated after freezing this source is separate, not a retroactive claim of camera validation.
