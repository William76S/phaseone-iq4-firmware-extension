# F1 native LiveView menu candidate

This module adds `F1 Mask` to the stock `Configure Grid` and `LiveView Settings` selectors. Its
five entries are Off / Native, XPan 65:24, 16:9, 3:2 and 1:1. The selection
uses the native menu navigator and a direct leaf callback. The existing
display13 payload reads the same private mode and paints only the LCD LV
destination. Startup defaults to Off; selection is not saved across restart.

The bindings are the original `SetMenu` calls at `0x4ee780` and `0x4eea58`, while the original
UI builds selectors with title resources 727 (`Configure Grid`) and 604 (`LiveView Settings`).
In LV, swipe inward from the right edge, then long-press the grid icon to open
the existing grid menu. `F1 Mask` is appended after the existing entries. This
release adds menu rows inside the native settings; it does not add a new icon
beside the peaking/grid/horizon icons in the drawer. Each selector gets a
separate SubMenu and five separate leaves; only the private mode is shared. It does
not depend on the previous independent button, free-space detection, queue
observer, `/proc` mapping scan or TLS stack inspection. The native SubMenu and
EventItem objects use their original constructors and full original vtables
with only text and leaf activation entries replaced in private copies.
The original navigator, native event propagation and parent menu remain.

`0x51fe08` and `0x520218` are explicitly excluded: they open property-enum
menus with different object types and cannot receive arbitrary SubMenu items.
The new hook calls the original SetMenu exactly once, with original arguments.

## Rebuild

Run from the project root with Python 3 and the pinned macOS ARM64 Zig 0.15.2
compiler. Supply the exact privately retained original inputs:

```sh
python3 -B tools/firmware/f1_stock_menu_01/build.py \
  --output build/f1_native_menu_rebuild_new \
  --zig /absolute/path/to/zig-aarch64-macos-0.15.2/zig \
  --stock /absolute/path/to/P1Linux_6.03.21.bin \
  --original-fwr /absolute/path/to/Firmware-BP-IQ4-IQ4_6.03.18.fwr \
  --original-fwp /absolute/path/to/XFSystem8.02.0.fwp
```

The output directory must not exist. Actual compiler commands and results,
the original-byte checks, linked symbols, new exception frames and original
body preservation are recorded alongside User, FWR and FWP outputs.

## Scope and acceptance

Only rotation 0 / normal fit / the proven 800x480 LCD destination is supported
by display13. Unknown rotation or zoom keeps stock rendering. No RAW/JPEG
pixels, RAW style metadata, security property, PIN, recording or storage
configuration are accessed by this runtime. Off stops added painting; the
next stock LV draw restores the display. Restart initializes Off.

Source and host validation do not demonstrate camera execution. The candidate
is unaccepted until its real menu, all four ratios, Off, restart and image
isolation have been observed on the IQ4. Exact rollback remains incomplete:
the stock update modifies the complete `/dev/mtd0` marker erase block and its
original backup plus independent recovery from a failed User are still absent.
The project does not perform persistent device writing on this basis.
