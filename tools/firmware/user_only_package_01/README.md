# Offline User-only package candidate 01

This tool implements a reproducible **host container review and packaging step**.
It does not patch User, call the SDK, run firmware, install a package, or establish
F1 support. No real patched User payload is present in this source package. An
explicit version-only fixture is identified as such and never called a feature.

The exact baseline is the local original `.fwr` SHA
`a52758ffb163023e5323297e450450f91002175b69bed7590fe2cd037c2ab300`
and its User SHA
`9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`.
Only baseline identity is constrained to 11,874,544 bytes. Candidate extent,
program count, LOAD count and `.imageHeader` file offset may change. The candidate
is reviewed as bounded ELF64 LE AArch64 ET_EXEC, an entry in an executable LOAD,
ordinary section/program tables, nonoverlapping LOAD memory extents, original
interpreter, and one loaded 180-byte `.imageHeader` with matching explicit
U8/U8/U16 version. These are host review policies; **they are not proof of target
kernel loading, runtime ABI, memory capacity, or updater ELF validation**. Growing
a User ELF still needs a separate implementation and runtime binder review.

The ZIP path is standard stored ZIP32, fixed timestamps, flat short names, correct
full CRCs, no ZIP64/descriptors/encryption/extra/comment. The app must fit the
positive signed return of the original extraction function; this is a representable
size boundary, not an established target memory limit. `.fwr` has exactly
`manifest.xml` and LinuxApp bytes. The XML preserves stock target model/hardware
and minimum version. The `.fwp` wraps that `.fwr` with a `system_package` XML whose
schema is reconstructed from the exact consumer, **not verified against an actual
stock `.fwp` sample or accepted by a camera**. Renaming `.fwr` to `.fwp` is invalid.

Default invocation only prints a plan (all device acceptance/recovery/F1 claims
false):

```sh
python3 tools/firmware/user_only_package_01/package.py \
  --user-payload PATH_TO_SEPARATELY_REVIEWED_USER_ELF \
  --expected-user-sha256 WHOLE_PAYLOAD_SHA256 \
  --release-version EXPLICIT_RELEASE_VERSION \
  --app-version EXPLICIT_MATCHING_IMAGEHEADER_VERSION
```

To save two **offline, unaccepted** candidate archives, add
`--emit-candidate-directory build/FRESH_DIRECTORY`. The directory must not exist,
its parent must exist under this project, and both explicit versions must be
newer than the fixed baseline. This stricter generation policy avoids the observed
same-version skip; it is not a claim that the device enforces monotonic versions.
All output files are local, mode 0600 within a mode 0700 directory. The tool never
changes a version inside the input, selects a version automatically, or overwrites
an existing file. No generated candidate is included in the source ZIP.

```sh
python3 -B tools/firmware/user_only_package_01/test_package.py
python3 -B tools/firmware/user_only_package_01/validate.py
```

The 13 meaningful host tests use in-memory fixtures only, covering stock plan,
version-only honesty, XML/member scope, deterministic ZIPs, hash/version mismatch,
growth/new LOAD/relocated header, malformed ELF, overlap, missing header, corrupt
CRC and version bounds. No fixture target code is executed or saved.

Actual installation remains gated by the exact running User→User partial mode,
backups of all modified files/configuration/signature state, actual User full
original when replacing it persistently, the marker erase-block original and
restore contract, plus an independent recovery entry that works with a failed
User. The selected update path may start installation automatically. Debug is not
a proved read-only acceptance test. RevertToFactory deletes User files/signatures
and cannot demonstrate non-destructive slot switching.

The detailed body/offset evidence is in
`analysis/firmware/FIRMWARE_PACKAGE_ACCEPTANCE_STATIC_01.md` and
`analysis/firmware/firmware_package_acceptance_static_01/evidence/`.
