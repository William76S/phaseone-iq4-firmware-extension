# F1 card candidate source closure 01

This local tool packages the actual project-owned compilation closure for UI02
and display12, the finite ELF append backend and stock wrapper02. It never
accesses an SDK, camera, remote computer or network, and never executes an
AArch64 object, User or firmware package. A source ZIP is not device acceptance
or a recovery test.

`bundle.py` defaults to a file-only plan. The nine actual UI `.d` files identify
all local translation-unit/header dependencies. Zig's 720 referenced standard
headers are supplied by the exact external Zig 0.15.2 toolchain, rather than
silently copied into this project source ZIP. Display12 originally produced no
`.d`; its complete local quoted-include closure is inspected separately and
reported with that limitation. The actual eleven compiler argv records are
retained. UI01, UI02 and the necessary previous derivation sources are included
as provenance, together with core/display headers and `toolchain.lock.json`.

The vendor User, FWR, FWP, rootfs, Boot, pthread, libstdc++ and SDK binaries are
excluded. Required local OEM inputs have exact bytes/SHA-256 in the plan;
other vendor references are classified as historical input rows. No opaque
EEPROM backup or device-private output is a source member. No third-party Zig
archive or runtime binary is redistributed by this tool.

From the existing project root, create a fresh plan:

```sh
python3 -B tools/firmware/f1_card_source_bundle_01/test_bundle.py
python3 -B tools/firmware/f1_card_source_bundle_01/bundle.py \
  --plan-output build/f1_card_source_bundle_01/FRESH_PLAN.json
```

This reports the final UI02 manifest hash and a canonical digest over the
entire included backend source set. After Root has confirmed those exact
identities, produce a fresh source-only ZIP using both printed hashes:

```sh
python3 -B tools/firmware/f1_card_source_bundle_01/bundle.py \
  --expected-ui-source-sha256 ACTUAL_UI02_SOURCE_SHA \
  --expected-backend-source-set-sha256 ACTUAL_BACKEND_SOURCE_SET_SHA \
  --emit-zip build/f1_card_source_bundle_01/FRESH_SOURCE.zip
```

The ZIP contains the original relative paths plus `BUNDLE_MANIFEST.json`.
Every member has an exact bytes/hash record; ZIP dates/order are deterministic.
The entire original manifests remain included. `reference_dispositions` names
each omitted historical row explicitly. **The old full freeze/materialize
validators are not claimed runnable from this ZIP alone:** some demand OEM
rootfs, all toolchain headers, prior artifacts or older study packages. The
bundle's own verifier validates its complete source set. The actual backend
finite input lock and wrapper02 still perform their own exact input checks.

## Recompile and package on this Mac

Extract into a fresh project-shaped directory. Keep the unmodified source tree
and original metadata. Put the exact OEM User at
`analysis/firmware/extracted/P1Linux_6.03.21.bin`, the exact original libstdc++ at
`analysis/firmware/f1_user_ui_entry_01/libstdcxx_original_ANALYSIS_ONLY.elf`, the
stock FWP at the listed vendor-download path, and the stock FWR at
`../Firmware-BP-IQ4-IQ4_6.03.18.fwr`. These remain separate local inputs, never
source ZIP members. Reuse the local Zig whose binary SHA is
`c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c`.
The full Zig installation beside that executable must match the archive SHA
in `tools/target/toolchain.lock.json`; a bare executable is insufficient.
The replay preflight checks every actual referenced standard header and the
compiler against the retained original manifest rows, even when Zig is reused
from a different absolute directory.

Do not run the historical `materialize.py` or `build_objects.py`: they are
pre-freeze derivation recipes and deliberately reject a frozen source tree.
The new replay driver runs only the actual eleven compiler invocations, first
requiring every expected `.o` destination to be absent. It does not run tests
or firmware, and does not rewrite any bundled sources, `.d` or build metadata.

```sh
python3 -B tools/firmware/f1_card_source_bundle_01/bundle.py \
  --verify-bundle BUNDLE_MANIFEST.json
python3 -B tools/firmware/f1_card_source_bundle_01/replay_objects.py \
  --zig /ABSOLUTE/EXISTING/ZIG/zig
python3 -B tools/firmware/f1_card_source_bundle_01/replay_objects.py \
  --zig /ABSOLUTE/EXISTING/ZIG/zig --compile-objects
python3 -B tools/firmware/f1_card_source_bundle_01/replay_objects.py \
  --make-payload-lock analysis/firmware/f1_card_source_replay_01/ACTUAL_INPUT_LOCK.json
```

The last command reviews the real rebuilt ET_REL hashes and original library
export through the unchanged finite backend validator. It prints the actual
new lock SHA. Use it with an explicit app version chosen by Root:

```sh
python3 -B tools/firmware/f1_user_elf_append_01/elf_append.py \
  --stock analysis/firmware/extracted/P1Linux_6.03.21.bin \
  --payload-lock analysis/firmware/f1_card_source_replay_01/ACTUAL_INPUT_LOCK.json \
  --expected-payload-lock-sha256 ACTUAL_REPLAY_LOCK_SHA \
  --app-version EXPLICIT_APP_VERSION \
  --emit build/f1_card_source_replay_01/FRESH_User.bin \
  --report build/f1_card_source_replay_01/FRESH_LINK_REPORT.json
```

Then independently compare the emitted whole User SHA with Root's final
candidate record. Package that exact User with the unchanged stock wrapper02:

```sh
python3 -B tools/firmware/user_only_package_stock_wrapper_02/package.py \
  --user-payload build/f1_card_source_replay_01/FRESH_User.bin \
  --expected-user-sha256 ACTUAL_EMITTED_USER_SHA \
  --app-version EXPLICIT_APP_VERSION --release-version EXPLICIT_RELEASE_VERSION \
  --system-version EXPLICIT_SYSTEM_VERSION \
  --emit-candidate-directory build/FRESH_CARD_REPRO_DIRECTORY
```

All output paths must be new. Use the exact versions from the final Root
guide; this helper does not invent a release/version identity. UI objects
contain DWARF source paths, so extracting to another absolute directory can
change whole `.o` hashes. The unchanged linker excludes nonallocated debug
sections; equivalent final User bytes must be checked, not assumed. Exact
whole-object reproduction uses the original absolute project root and original
compiler flags. This package preparation has not rebuilt the final User in a
fresh extraction or loaded a camera.
