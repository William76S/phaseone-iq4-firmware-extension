# Original LV prepaint background: conditional rectangle fill exists

This is an offline static result bound to the unmodified User ELF, 11,874,544 bytes, SHA256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`. No target code, SDK, camera, or remote session was executed. No production source or previous frozen evidence was modified.

The complete LV paint callback `0x51da0c..0x51df64` and image Draw `0x477038..0x477384` do not themselves contain a preceding background clear. **That local observation does not establish absence of a clear in the complete LV draw path.** The original LV vtable at `0xb9a9d8`, slot `+0x98`, is `0x4e1360`; it performs a conditional rectangle fill before invoking Control::Draw and the LV paint callback. This corrects the earlier partial-chain stop point reported to Root.

## Exact prepaint path

`0x4e1360` stores its input Surface, bounds, clip, and force flag, then queries original LV vtable `+0xb0`. At `0x4e13a4..0x4e13d8`, the fill predicate is `(dirty OR force) AND LV byte +0xb8`. The native base ctor `0x4e10c4` initializes that byte to one at `0x4e1150..0x4e1154`. The original LV ctor calls that base ctor at `0x517600` and installs its primary vtable at `0x51763c`. This is constructor evidence, not a readback of the current instance or a proof that no subsequent path can change the byte.

When the predicate succeeds, `0x4e13e0..0x4e1418` copies the input clip, copies a color from global `0x3ea53b0`, and calls `0x46f184` with:

| Register | Argument at `0x4e1418` |
| --- | --- |
| x0 | Original input Surface (`sp+0x40`) |
| x1 | Original input bounds pointer (`sp+0x38`) |
| x2 | Mutable local copy of input clip (`sp+0x50`) |
| x3 | Local color copied from `0x3ea53b0` (`sp+0x68`) |

After this call completes, `0x4e145c` calls `0x4abd24` Control::Draw. Its original LV `+0xa0` virtual call at `0x4abe90` reaches `0x51da0c`, whose source-image draw is `0x51ddcc -> 0x477038`. Thus the fill is ordered before the source-image draw, on the same original Surface passed down the chain.

## What the fill actually does

The complete `0x46f184..0x46f370` body reads inclusive rectangle endpoints, clips the requested region against both the mutable input clip and `Surface+0x20` bounds, then loops through every included row. At `0x46f2e4` it loads the destination pixel base from `Surface+0x38`. `0x46f2ec..0x46f308` computes `base + 4 * (row * Surface.pitch_at_0x14 + x)`. `0x46f34c` calls Surface's actual backend (`Surface+0x8`, virtual slot zero) with this row destination, copied color, and inclusive row width. This is a rectangle fill path, not an outline.

Its existence does **not** prove an opaque black, complete-LCD clear on every actual frame. This review does not observe the current dirty predicate, force argument, `LV+0xb8`, actual wrapper bounds/clip, or the current color/alpha at `0x3ea53b0`; neither does it reopen the backend's color semantics. A fill clipped to a subregion cannot be promoted to a whole-panel clear receipt.

## Other primitives are not a background-clear receipt

Control::Draw has a separate optional `Control+0x6c` branch: `0x4abde4 -> 0x45ac38 -> 0x46f0c4 -> 0x46ed20`. The latter calls horizontal line primitives for top and bottom (`0x46ef30`, `0x46ef74`) and vertical line primitives for left and right (`0x46efe0`, `0x46f024`). It is a rectangle outline. It must not be confused with the earlier UiControl prepaint fill.

`0x4abecc -> 0x46ce24` updates the dirty rectangle at `Surface+0x40`; it copies a first rectangle or takes its union using `0x47e194`. It does not write pixel data. Manager::Draw `0x4e32d4..0x4e36b8` obtains the Surface and invokes root/overlay Draw methods; its complete body has no separate unconditional full-Surface clear. Its virtual children and the conditional UiControl wrapper determine actual preceding paint, so the manager body alone cannot prove or disprove a full-LCD clear.

## Boundary for the reported 645×483 projection

Root reports the actual projected rectangle `(77,0,645,483)`, clip `(0,0,800,480)`, LCD `800×480`, rotation zero, format zero. Arithmetic rectangle intersection is `(77,0,645,480)`; the last three projected rows lie outside the panel. This arithmetic is not a receipt for all those rows being written by the native sampler. SDK reference research owns the exact `0x47552c` forward-loop write and clip proof; this review does not duplicate it. Root's new Display15 conservatively uses that proved native write rectangle (reported `645×479`) and does not need this conditional fill to broaden mask admission.

No pixels outside the independently proved native write rectangle should be admitted as fresh solely because this conditional fill exists. No additional clearing, production changes, or device probes are proposed by this review.

Reproduce this evidence with `python3 analysis/firmware/f1_lv_background_clear_review_01/collect.py`. The collector verifies the original whole ELF hash, PHDR-backed exact windows, 11 instruction anchors, and the two vtable bindings; it only disassembles and reads local files. `EXACT_BYTES.json` contains every raw byte span and file offset. `manifest.json` freezes all generated listings, this review, and the collector.
