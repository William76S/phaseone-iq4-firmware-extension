# F1 native menu candidate04

Uses the same stock Configure Grid / LiveView Settings entries as candidate03. Five original choices remain, followed by eight read-only LV diagnostic rows. Default Off; no persisted mode.

Display14 corrects the proven distinction between configuration-space full ROI and the sampled RGB image. The original full LCD/normal fit/rotation0 and clipping conditions remain. The correction is not proof of the actual user's no-mask cause. Diagnostic counters and fields help identify any remaining rejection on the target without host or device control APIs.

## Rebuild

Run from this source root with the pinned macOS ARM64 Zig 0.15.2 installation and exact original private inputs:

```sh
python3 -B tools/firmware/f1_stock_menu_02/build.py \
  --output build/f1_mask_status_rebuild_new \
  --zig /absolute/path/to/zig-aarch64-macos-0.15.2/zig \
  --stock /absolute/path/to/P1Linux_6.03.21.bin \
  --original-fwr /absolute/path/to/Firmware-BP-IQ4-IQ4_6.03.18.fwr \
  --original-fwp /absolute/path/to/XFSystem8.02.0.fwp
```

Output must be a new project-local directory. The script verifies the combined source lock, original whole hashes and original interface regions, compiles four AArch64 objects, appends actual code/data/EH/init entries and packages an IQ4 User-only stock-wrapper candidate. No target ELF or camera SDK is executed.

Host verification:

```sh
python3 -B tools/firmware/f1_stock_menu_02/validate_host.py --output build/f1_mask_status_host_new
```

Native callbacks use char* results and at most31 ASCII characters plus NUL. Diagnostic entries return0 on activation and never change the mode. E/N/F values are diagnostic code, hook calls and returned native fill calls; they are not visible-output or FPS evidence. Unknown fields show Not captured. Selection first sets waiting, then the next real LV draw publishes observations. Values are scalar snapshots, not an atomic frame record.

The candidate versions are P1Linux6.03.25, IQ6.03.22, System8.02.4. They are experimental identifiers, not vendor release declarations. Recovery remains incomplete because the original entire /dev/mtd0 marker erase block and independent failed-User restoration are unverified. The project does not perform persistent writes with this gap. Source/host pass is not camera acceptance.
