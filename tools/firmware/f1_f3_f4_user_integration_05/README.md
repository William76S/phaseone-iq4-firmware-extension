# Internal integration 05

This directory contains development integration specifications, not a delivered
firmware release. `INPUTS_JPEG_DEV_02.json` was fully rebuilt from source into the
same sealed User ELF in `analysis/firmware/jpeg_repair_reproduce_dev_02/`.
It includes the 4 KiB RTTI repair, visible quality 100, the original Storage Setup
JPEG Size replacement and preliminary Dual Exposure UI. It does not include the
subsequent native storage bridge, larger JPEG file ceiling or native-LV-stop
cleanup. Its Dual long-shutter display still has known quantization differences.
Do not use that development ELF as a completed feature release.

`build.py` verifies exact source manifests, compiler and objects. The versioned
append03 linker permits at most 96 objects; all original bounds and permissions
remain. `reproduce_user_only.py` recompiles each recorded object and compares the
complete sealed User with a reference, without producing a FWP. It uses the
loader ABI proof pinned in the specification. The full `reproduce.py` is reserved
for a future approved release with an existing reference package.

Device execution, full-RAW rendering, recording, no-card Capture One JPEG,
Black Reference compatibility and persistent recovery remain separate acceptance
requirements. An exact reproduction is not camera acceptance.

`INPUTS_JPEG_DEV_03.json` adds the quality-100 1 GiB streaming file ceiling
and original-LV-client-release recorder cleanup; its full source reproduction
also matches byte for byte. It remains internal and does not yet contain the
storage bridge, Black Reference ordinary-capture guard, or Dual02 correction.
`verify_runtime_pins.py` can additionally check recorder, card and RAW dependency
headers; `verify_loaded_rtti.py` runs the existing 27-case actual-ELF relocation
model against the specified sealed User without changing frozen sources.
