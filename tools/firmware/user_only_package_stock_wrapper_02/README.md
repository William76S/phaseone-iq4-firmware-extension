# User-only FWP wrapper 02 — actual stock sample

This offline source binds the actual official `XFSystem8.02.0.fwp` sample, then reuses the frozen `user_only_package_01` ELF/FWR validation. It does not change that source, the input FWR, User, Boot, or the original FWP. It makes no SDK/device call or installation. A new F1 payload must come from an independently reviewed implementation; a version-only payload cannot be emitted by 02.

Original FWP: 80,158,711 bytes, SHA-256 `3dfb12c9417d60a0838a5abbfe3adccba2f242a79bab5f9ffa312be097571252`. Original outer XML: 492 bytes, SHA-256 `29081a1b7be5753e91648f00abe2b478e3c040ced65b11c963361d296e96f575`. Its embedded IQ4 FWR is **byte identical** to the given 78,351,289-byte FWR `a52758ffb163023e5323297e450450f91002175b69bed7590fe2cd037c2ab300`, including stock User `9b611efe...032cdb`.

The original FWP is a ZIP4 with zero flags, DEFLATE and correct member CRCs. Its root is `system_package`, compatible version 2, name `XFSystem`, version `8.02.0`, date `2022-07-21`. The back child carries model IDs `0x125,0x126,0x122`, hardware revisions `1,2,3`, version `6.03.18`. Neither root nor child has minimum_update_version. 02 preserves these root/back attributes except explicitly supplied versions and the selected inner filename; it removes the XF body and XT lens packages. Inner FWR retains the original release selectors and minimum `2.00.14`, includes only LinuxApp plus manifest, and binds the explicit app version to actual `.imageHeader` bytes.

The sample download is advertised by the [official XF/XT firmware category](https://www.phaseone.com/download-categories/bp-xt-xf-camera/) and [download page](https://www.phaseone.com/downloads/xf-xt-8-02-0-firmware/). The source HTML actually contains the CDN link; it was not guessed. The [official IQ4 category](https://www.phaseone.com/download-categories/bp-iq4-digital-back/) separately advertises the matching 6.03.18 FWR. `analysis/firmware/stock_fwp_sample_review_01/SAMPLE_REVIEW.json` retains the provenance, member sizes/offsets/whole hashes and CRCs. Vendor firmware bytes stay local and are excluded from the source ZIP.

Reproduce file inspection:

```sh
python3 tools/firmware/user_only_package_stock_wrapper_02/inspect_stock.py --original-fwp analysis/firmware/vendor_downloads/stock_fwp_01/XFSystem8.02.0.fwp --output-directory analysis/firmware/stock_fwp_sample_review_01/FRESH_REVIEW
python3 -m unittest discover -s tools/firmware/user_only_package_stock_wrapper_02 -p test_package.py -v
```

Default packaging is a plan only. Supply an actual independent payload and whole hash, three explicit versions, and the exact local original FWP/FWR. Only an explicit fresh project `--emit-candidate-directory` writes a candidate. The system/release/app versions must be newer than stock for this host tool's same-version-skip precaution; this is a host policy, not a proved device monotonicity rule. Payload growth/new LOADs and relocated `.imageHeader` are permitted by the original checker; stock size is an identity check, not a required new-payload size. FWR/ELF/header/CRC checks are container checks, not proof of an implemented mask or bootable extension.

```sh
python3 tools/firmware/user_only_package_stock_wrapper_02/package.py --user-payload ACTUAL_REVIEWED_USER --expected-user-sha256 ACTUAL_WHOLE_SHA --system-version EXPLICIT_SYSTEM_VERSION --release-version EXPLICIT_RELEASE_VERSION --app-version ACTUAL_HEADER_VERSION
```

The native partial User→User consumer, signature generation and extra install effects remain those in `FIRMWARE_PACKAGE_ACCEPTANCE_STATIC_01.md` and its exact function windows. The partial path does not require Boot but still changes component-signature/firmware state and clears/reestablishes a User marker through a complete `/dev/mtd0` erase-block operation. Factory/full mode requires Boot and may delete folders. RevertToFactory deletes User rather than providing an independently tested non-destructive recovery. Neither package acceptance nor recovery has been tested here, and no F1 candidate or installed feature is claimed. **No installation instructions or authorization follow from the saved host candidate.**

`inspect_stock.py` additionally reports exact baseline ELF PHDR/INIT/INIT_ARRAY/pthread relocation metadata for the independent offline User patch work. Original PHDR table ends exactly at the interpreter offset: there is no spare contiguous PHDR slot. No slot is overwritten and no ELF code executes in this tool.
