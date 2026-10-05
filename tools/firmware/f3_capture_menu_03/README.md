# F3 capture menu and immutable policy 03

Concrete native **File Settings → Capture Output** source, using the already exercised original SubMenu/EventItem ABI. This source stage does not emit a firmware. Production attachment remains disabled until the native capture producer and save coordinator consume it. The separate enabled object is for static inspection, not installation.

The native menu contains RAW / JPEG / RAW + JPEG, six JPEG sizes (Full, 75%, 50%, 25%, long edge 3840, long edge 7680), and JPEG Quality 1–100 with decrease/increase/reset 95 actions. Percentage dimensions are independently rounded to nearest; long-edge sizes preserve the aspect ratio and reject upsampling. RAW mode has no JPEG output geometry (0,0), so selecting an unavailable JPEG size cannot block a RAW capture. Existing stock IIQ compression and SD JPEG settings are unchanged.

Mode, size and quality occupy one atomic word. Field CAS updates preserve the other settings. The capture owner takes one snapshot with `iq4_f3_policy_begin_01`; subsequent saves use that immutable snapshot. JPEG modes request automatic post-capture conversion. Manual existing-IIQ selection and export actions are not connected by this menu module. Source identity tokens are not native leases. UNKNOWN latches the slot and forbids reuse; it does not release any native or file owner.

The concrete wrapper at original BL4f0d34→4e58b8 (`e1d2ff97`) forwards the last original append once, appends the project menu, and restores the original result registers. The original SubMenu/EventItem enter and navigation slots remain unchanged. Detached allocations are retained after construction failure, with no retry this boot. The exact original code windows and private native class layouts are locked in `NATIVE_CONTRACT.json`.

The required capture boundary remains manager+48=current RAW node at8dc4c0 before storage-group fanout. The real consumer must hold that exact full RAW through rendering, checked JPEG commit and final cleanup. Global JPEG-only requires interception of the actual RAW publication, not just deleting a private copy. Existing user IIQs are never discarded by this module.

Rebuild from the project root into a fresh local directory:

```sh
python3 -B tools/firmware/f3_capture_menu_03/build.py --output analysis/firmware/f3_capture_menu_build_03_fresh
```

This runs owned normal/ASan/UBSan fixtures and cross-compiles five AArch64 ET_REL objects. It executes no target, original firmware, SDK or camera. Native menu presence, capture behavior and card acceptance remain unverified.
