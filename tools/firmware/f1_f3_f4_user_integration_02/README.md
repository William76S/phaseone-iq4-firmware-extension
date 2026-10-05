# IQ4 XQD capture integration 02 — offline stage

This stage replaces the frozen integration 01 capture producer, executor,
coordinator and menu. SD and XQD each expose RAW, JPEG or RAW+JPEG. The actual
original XQD RAM writer, final card open, checked close and consumer fanout are
bound to their exact stock bytes. Existing Ratio Mask and recording code are
retained. It does not repair the user-reported recording Hold or implement
Capture One JPEG transfer without a card.

All licensed stock inputs and binaries remain local. This package has not run
on the camera. The marker erase-block backup and independent failed-User
recovery remain unverified; this stage is not an approved installation.

Run from the repository root with the existing local toolchain and inputs:

```sh
python3 tools/firmware/f1_f3_f4_user_integration_02/freeze.py --verify
python3 tools/firmware/f1_f3_f4_user_integration_02/reproduce.py \
  --spec tools/firmware/f1_f3_f4_user_integration_02/INPUTS_XQD_01.json \
  --spec-sha256 b75536c84d4c95966f3f765e10eb93447676e5a694bf84614b0330708ac49627 \
  --reference-build analysis/firmware/f1_f3_f4_user_integration_build_02_xqd01 \
  --reference-package deploy/f1_f3_f4_card_candidate_02_xqd_stage01 \
  --output analysis/firmware/f1_f3_f4_full_reproduction_02_xqd_next
```

The output directory must be new. The reproduction recompiles every target
object from locked source and compares the complete sealed User, FWR and FWP.
Original instructions, 22 actual hooks, initializer order, C++ loader bindings,
unwind metadata, archive selectors and package checksums are also checked.
These are static and host checks, not target execution or recovery evidence.

See `deploy/F1_F3_F4_XQD_STAGE_01.md` for exact artifacts and limitations.
