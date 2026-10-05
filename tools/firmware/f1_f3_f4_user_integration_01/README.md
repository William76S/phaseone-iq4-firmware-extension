# Ratio Mask / JPEG capture output / LV recording native integration

This directory builds a real AArch64 User extension from frozen source objects.
It preserves the stock 340 initializers and appends one factory, original
dynamic imports and exception entries. Sixteen finite original instructions
enter the linked wrappers. It never opens an SDK, camera or Windows session.

The active specification, exact artifacts and source identities are in
`SOURCE_SHA256.json`. The guide in `deploy/F1_F3_F4_CARD_CANDIDATE_01.md`
distinguishes implemented code, host checks and outstanding camera acceptance.
Historical `INPUTS.json` and `INPUTS_FINAL_01.json` preserve earlier builds;
they are not the current functional candidate.

F3 uses the original IFM background thread, an independent complete IIQ Reader
and original full RAW renderer. It includes six output sizes, quality 1–100,
manual selected-RAW export and SD capture RAW/JPEG/RAW+JPEG. Manual export keeps
the selected IIQ. Automatic JPEG-only removes only its verified original SD RAW
after successful publication and known render cleanup; otherwise it retains RAW.
XQD automatic JPEG is not accepted. Defaults are volatile RAW/Full/95.

F4 copies original RGB before LCD composition, returns the native borrow and
encodes its own slots to VFR MJPEG Matroska. Its native page supports Start,
Stop, Stop and Exit, status and SD/XQD choice. Frame arrival observations are
not sensor timestamps or proof of 1080p60. Ratio Mask remains display only.

The actual linked contract covers own RX/RO, FDE/LSDA, immutable compiler
pointer cells, typed RTTI and exact active loader metadata. A separate bounded
native library guard verifies relocated COPY RTTI. Ordinary mutable Job,
configuration, GOT and loader debug state are not hashed. This is exact ELF
verification; target exception behavior remains untested.

To reproduce in this original local workspace, choose a new output directory:

```
python3 tools/firmware/f1_f3_f4_user_integration_01/freeze.py --verify
python3 tools/firmware/f1_f3_f4_user_integration_01/reproduce.py \
  --spec tools/firmware/f1_f3_f4_user_integration_01/INPUTS_FINAL_02.json \
  --spec-sha256 b43bea885d090504b4f9057df31e086d392469ae036f4a3ccf4cf6d24db75e0b \
  --reference-build analysis/firmware/f1_f3_f4_user_integration_build_01_final02 \
  --reference-package deploy/f1_f3_f4_card_candidate_01 \
  --output build/FRESH_F1_F3_F4_REPRODUCTION
```

The command freshly compiles all frozen target objects and both Root objects,
links, independently inspects the actual ELF, seals its immutable contract,
inspects it again, packages with the exact official stock wrapper and compares
complete sealed User/FWR/FWP bytes. Successful execution only confirms source
and container reproducibility. It does not install or execute the candidate.

The local source ZIP is a supplement to this workspace. Original licensed
firmware/library/compiler inputs and earlier object receipts are preserved
locally and are required by their hashes. No originals or private identifiers
are uploaded. Persistent writing is paused while the original mtd0 marker erase
block and an independent failed-User recovery route remain missing.
