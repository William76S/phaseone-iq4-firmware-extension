# F1 native LV overlay adapter 01

This is an offline, production-disabled source stage. It reuses the existing `src/display` mask geometry for OFF/native, 65:24, 16:9, 3:2 and 1:1. It receives geometry and a callback-local display Surface; it has no capture pixel, RAW, JPEG, recording, SDK, security or storage API. No camera or original function was executed.

`overlay.hpp/cpp` implements a bounded four-rectangle post-paint adapter. Native Rectangle is 24 bytes including its address point; Color is alpha followed by three channels. Only positive, exact axis-aligned, nonoverlapping pixel-center rectangles are accepted. The native fill wrapper clones its clip. Non-quarter-turn geometry that produces slanted bands is rejected. Unknown full-source/zoom mapping hides the mask.

The owner must supply an actual receipt that this callback restored the whole outstanding prior/current image region. A positive return rectangle from original LV paint is insufficient: original paint can skip its image blit. Likewise the dirty-rectangle union is not a pixel clear. Until that receipt arrives, the adapter does not repeat translucent filling or claim OFF/disable restoration. Successful restoration retires the historical viewport union. Duplicate UI paint serials, wrong epochs, owner changes, invalid native Surface layouts and reentry are rejected. UI serials have no capture-frame/FPS meaning.

`configure()` is unconditionally false in production. `IQ4_F1_OVERLAY_SYNTHETIC_HOST` enables only the owned synthetic test fixture. The gate booleans are placeholders for evidence; they are not target discovery or an installer. No setter writes a vptr, global table, original file or persistent configuration. The returned `FactoryRestored` state means a supplied stock pixel-repaint receipt succeeded; it does not mean a native callback was detached or a module can be unloaded. Context/module ownership remains retained.

Static addresses are bound solely to User SHA256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`. The minimal next candidate is a per-instance private RAM copy of the native LV primary table, changing only paint slot +0xa0 and forwarding the original paint exactly once before drawing. This candidate is documented, not installed. Actual instance/UI owner, geometry, fresh-blit coverage, native ABI/lifetime, native five-choice selector and disable/detach/stock return must be verified before any enabled build exists.

From the project root:

```sh
python3 tools/firmware/f1_native_overlay_01/collect_static.py
python3 tools/firmware/f1_native_overlay_01/build_validate.py
python3 tools/firmware/f1_native_overlay_01/freeze.py
python3 tools/firmware/f1_native_overlay_01/validate.py
```

The build uses the existing pinned Zig 0.15.2 and compiles two AArch64 Linux ET_REL objects without running them. The compile-only return probe verifies that the own C++ Rectangle24 forwarder leaves x8 intact; it does not validate the vendor C++ object lifetime or runtime calling contract. Host normal and ASan/UBSan runs cover 19 groups, four ratios and four quarter-turn directions with 1,048,576 independent pixel comparisons. Production tests make zero native reads/calls. The public source ZIP excludes original firmware and target objects.
