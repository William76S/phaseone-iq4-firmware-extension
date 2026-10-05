# F1 native UI adapter 02 — production EN0

Offline source stage for the existing LV native menu selector and frozen display-only overlay01. Original firmware/device calls occur only as owned synthetic host fixture functions; no SDK or camera is opened. F4, RAW/JPEG/crop/recording, file/config/security writes are outside this source.

`ui.hpp/.cpp` implements finite actual-memory UI-owner inspection, private five-item native menu, original popup Show/Close/SetMenu return, unique action events, repaint generation/receipt tracking, and retained unsubscribe/later-boundary cleanup. `OverlaySelectionBridge` directly calls frozen overlay01 only with an independently observed full-source display mapping/epoch. The candidate LV geometry reader supplies fields, not that mapping. Native selector use requires an empty original popup; existing stock menu sessions are never displaced.

`candidates.cpp` checks twelve exact first16-byte entry signatures and resolves typed static pointers without invoking them. This is not a whole-image or actual owner/lifetime proof. `Selector::configure()` is unconditionally false in production, with zero native reads/calls in its guard test. There is no target entry, constructor, interposer, installer, vptr/global-menu write or enabled artifact. Native user action registration and actual triple/geometry/fresh-display receipt ports remain unbound.

The original `4e14bc` / `4e4820` path is now positively identified as `UiIQ4Redraw`, not Close; it forces dirty UI draw but does not guarantee LV image writes. A positive original paint return cannot satisfy the fresh full-image receipt. OFF/disable cleanup only succeeds after actual stock coverage and original UI return/subscription readback.

Run from project root:

```sh
python3 tools/firmware/f1_native_ui_02/freeze.py
python3 tools/firmware/f1_native_ui_02/validate.py
```

Normal and ASan/UBSan each validate30 finite own-code groups. AArch64 builds are ET_REL compile-only using the existing pinned Zig0.15.2. No target/runtime acceptance is implied. See `analysis/firmware/F1_NATIVE_UI_ADAPTER_02.md` for exact ABI windows, naming correction, native entry gap and specific readonly observations needed before any enabled RAM increment.
