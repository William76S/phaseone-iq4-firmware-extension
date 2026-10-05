# IQ4 integration 03 — XQD, recording diagnostics, release date

Extends frozen XQD integration02 with four exact recording object replacements.
Retains all previous source/session/menu ABIs and native lifecycle guards. Hold
keeps the observed scalar view and exposes Entry/Source/Session stage and error.
This fixes missing diagnostics; the user's recording Start failure is not yet
attributed to a specific target stage or accepted as fixed.

Package release date is explicitly **2026-10-05**, displayed by the normal User
firmware information path as **05.10.2026** after loading the new manifest.
Neither RTC nor the original fallback build timestamp is changed. The date is
recorded in package inputs and passed explicitly during reproduction.

Local licensed stock firmware/libraries and toolchain are required. Run from
the repository root; use a new output directory:

```sh
python3 tools/firmware/f1_f3_f4_user_integration_03/freeze.py --verify
python3 tools/firmware/f1_f3_f4_user_integration_03/reproduce.py \
  --spec tools/firmware/f1_f3_f4_user_integration_03/INPUTS_DIAG_DATE_01.json \
  --spec-sha256 8f25230b4d7b5b22926fc4ef63bddcd7db558210b17952bee1844b9ed57db5c2 \
  --reference-build analysis/firmware/f1_f3_f4_user_integration_build_03_diag_date_01 \
  --reference-package deploy/f1_f3_f4_card_candidate_03_diag_date_01 \
  --output analysis/firmware/f1_f3_f4_full_reproduction_03_diag_date_next
```

Every target object is recompiled; the complete sealed User, FWR and FWP must
match byte for byte. Static inspections verify 22 real hooks and native C++
loader/unwind bindings. These checks do not execute the camera code.

See `deploy/F1_F3_F4_DIAGNOSTIC_DATE_CANDIDATE_03.md` for exact identities,
menu readings and the unresolved target/recovery boundaries.
