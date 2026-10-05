# Native Storage Setup JPEG Size replacement 01

One exact BL replacement at original `4f0528` (LE `e4d4ff97`, target `4e58b8`) substitutes the child pointer passed to the original SubMenu Append. A single object contains the AArch64 wrapper and bounded C selection/menu code. No new allocation ABI, property-enum extension, event setter, or original structure layout is invented.

The original Storage Setup parent must have VT `b8f9b8` and title389. The original child must have PropertyEnum VT `b8fd40`; its +18 property must have JPEG size DTO VT `bbf3f8`. The current native UI queue/manager and ten finite code/table windows must match. It then creates a native SubMenu with six leaves: `4K`, `8K`, `75%`, `50%`, `25%`, `100%`. These map to the existing F3 policy scales `[4,5,1,2,3,0]`; no duplicate state exists. The current value and Selected marker reflect that policy.

The wrapper preserves original arguments except x1 (the child), preserves q0–q7, x8 and NZCV, restores its stack/frame/link register, and tail branches to original `4e58b8` exactly once. The original pre-created child and its original DTO/event remain untouched and retained for this UI lifetime. Allocation/constructor/append failure keeps the incomplete replacement detached, latches this component and returns the original child. A changed caller/object/UI/pin likewise falls back to the original. It does not free objects through an unproven destructor path.

This component replaces only the **UI selection**, and must be integrated with removal of Capture Output's duplicate size control. It does not alone replace or suppress the independent original JPEG-to-SD worker. That worker still uses its original size enum0/1 and must be unified or suppressed before this component can be presented as a complete camera-wide setting. The new full-RAW backend receives all six sizes through its existing once-per-capture policy snapshot. Do not write these values into the old enum.

28 normal and 28 ASan/UBSan host cases cover six real shared-policy selections and geometry, intact mode/quality, busy/UI rejection, wrong native objects/pins, seven allocation/constructor failures and six child-append failures. Original child/DTO bytes remain unchanged. Native calls are fixtures. Two AArch64 compiles produce identical objects. No device actions or target acceptance.

Reproduce:

```sh
python3 tools/firmware/f3_native_size_menu_01/collect.py
python3 tools/firmware/f3_native_size_menu_01/build.py
python3 tools/firmware/f3_native_size_menu_01/freeze.py
```
