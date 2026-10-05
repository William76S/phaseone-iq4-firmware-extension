# IQ4 integration 04 — recording Start fixes, XQD default, visible JPEG menu

P1Linux 6.03.33 / IQ 6.03.30 / System 8.02.12 / 2026-10-05.
Replaces six objects: source05, native_calls05, session05, movie_binding05,
LV Settings wrapper with default FS11, and Capture Output menu07. The remaining
57 objects preserve the existing Ratio Mask and JPEG implementations.

Repairs actual registry-contention Hold, canonical-empty card-busy Hold, and
finite pre-start resource retention. Menu07 displays backend unavailability
instead of suppressing the entire Capture Output menu. It retains every real
backend/action guard. Actual camera success is not established by these changes.

From the original local workspace (licensed original inputs remain local):

```sh
python3 tools/firmware/f1_f3_f4_user_integration_04/freeze.py --verify
python3 tools/firmware/f1_f3_f4_user_integration_04/reproduce.py \
  --spec tools/firmware/f1_f3_f4_user_integration_04/INPUTS_RECORDING_REPAIR_01.json \
  --spec-sha256 e05125a63239d91b0a637c3d749d4812736c0b6ac44219d19572b5c5399d288d \
  --reference-build analysis/firmware/f1_f3_f4_user_integration_build_04_recording_repair_01 \
  --reference-package deploy/f1_f3_f4_card_candidate_04_recording_repair_01 \
  --output analysis/firmware/f1_f3_f4_full_reproduction_04_next
```

All 63 objects are compiled from their exact recorded source commands, followed
by link, native unwind validation, immutable-region seal and original wrapper.
Final sealed User, FWR and FWP must match byte for byte. No camera is accessed.
See `deploy/F1_F3_F4_RECORDING_REPAIR_CANDIDATE_04.md` for scope and remaining
acceptance. No-card Capture One JPEG and adjustable Dual Exposure are not in
this build. Their later work must not silently change this frozen candidate.
