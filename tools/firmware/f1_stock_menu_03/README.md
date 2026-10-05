# F1 native requested-size candidate05

Uses the existing stock Configure Grid / LiveView Settings F1 Mask entry. Five ratio choices plus nine read-only diagnostic rows, including LV requested size. Startup Off; mode not persisted.

Display15 binds RGB dimensions to the original metadata requested output pair at +0x58/+0x5c and to locked dimensions, with complete configuration ROI. It removes Display14's incorrect exact config/RGB aspect test. Original local Start requests640x480 independently from14204x10652 config. Actual user geometry also has a645x483 projection clipped by the800x480 LCD; final display clipping handling and evidence are documented in the card guide and source README.

## Rebuild

Run from a fresh source root with pinned macOS ARM64 Zig0.15.2 and three original private inputs. Use absolute compiler and input paths:

```sh
python3 -B tools/firmware/f1_stock_menu_03/build.py \
  --output build/f1_native_size_rebuild_new \
  --zig /absolute/path/to/zig-aarch64-macos-0.15.2/zig \
  --stock /absolute/path/to/P1Linux_6.03.21.bin \
  --original-fwr /absolute/path/to/Firmware-BP-IQ4-IQ4_6.03.18.fwr \
  --original-fwp /absolute/path/to/XFSystem8.02.0.fwp
```

The output must be a new project-local directory. Exact source and stock hashes/native interface bytes are checked before four actual AArch64 cross compiles, ELF append/init/EH linking and User-only stock packaging. No target ELF or camera SDK is executed.

```sh
python3 -B tools/firmware/f1_stock_menu_03/validate_host.py --output build/f1_native_size_host_new
```

All callbacks return char* and write at most31 ASCII characters plus NUL. Diagnostic entries are read-only. E/N/F are reason, hook calls and returned native fill calls; never FPS or visible-output proof. Detailed values are scalar snapshots, not an atomic frame record. No file/device/security API is added.

Experimental versions: P1Linux6.03.26 / IQ6.03.23 / System8.02.5. Marker entire eraseblock original and independent failed-User restore remain unverified. Host/source pass is not hardware acceptance, and the project does not execute persistent writes with this recovery gap.
