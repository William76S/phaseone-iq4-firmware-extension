# Display14 SOURCE rejection: native configured-output pair

Offline review only, bound to original User SHA `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`. No SDK, Windows, camera, target execution, or frozen-source modification. The geometry below was reported by Root from the user's display; this agent did not acquire a hardware receipt.

Root reports RGB **640×480**, config **14204×10652**, ROI **(0,0,14204,10652)**, rotation 0, animation 0, countdown 0, and E34/N775/F0. Frozen display14 reports `30 + plan_reason`; enum SOURCE is 4. Its exact aspect guard requires `configW*ImageH == configH*ImageW`. The reported values yield **6,817,920 != 6,817,280**, a difference of 640. This predicate definitely rejects those reported values, even with complete ROI. It does not mean a hardware sampling failure, and it is unnecessary on the native local-LV path described below.

## Exact local-LV output size source

`0x520364..0x520378` constructs Rectangle `(0,0,640,480)`. `0x520384` calls Access metadata getter `0x6b614c`; its complete leaf chain `0x6b6dec` returns **engine+0x4760**, an inline resident configuration block, not an allocated temporary.

`0x52038c` reads 640 from the local rectangle's width, `0x520390` reads 480 from its height, and `0x520398` calls the complete pair constructor `0x431760..0x431794`, which writes two U32 words at the caller-owned output object. `0x5203a0` reads this packed pair; **`0x5203a4: STR x1,[x0,#0x58]`, LE bytes `012c00f9`**, stores it at metadata+0x58/+0x5c. These are exactly **engine+0x47b8/+0x47bc**. This directly establishes the native requested output pair 640×480 independently of sensor/configuration aspect.

`0x5203ac..0x5203cc` separately constructs the complete configuration ROI `(0,0,metadata[4],metadata[8])`. At `0x5203f8` the original sets boolean 1 and calls Access set-config at `0x52040c`. Access verifies its owner/client and then sends this boolean as w3 to engine `0x7975d0` at `0x6b642c`.

Engine `0x7976f4..0x797740` takes the boolean-1 fit arm, then branches to `0x797764`. It **skips** the separate boolean-0 block `0x797744..0x797760` that clamps an aspect-derived size and stores a downward-4-aligned output pair. Thus the local path retains its explicitly written 640×480 pair. It is incorrect to apply the IQP boolean-0 four-pixel rule to this boolean-1 local display consumer.

## Producer consumes the same block

Original producer caller `0x7972c8..0x7972e4` passes x2=**engine+0x4760** to `0x787578`. `0x787590: MOV x23,x2` (`f70302aa`) retains that exact configuration pointer. Later **`0x787840: LDR w5,[x23,#0x5c]` (`e55e40b9`)** reads the height of the pair just described; `0x787850..0x78786c` publishes the smaller of that requested height and the field-0x1a7 read. Slot width is separately the field-0x1a6 read. ROI x/y/w/h is copied from the same configuration block's +0x18 at `0x787874..0x787880`.

This is a positive pointer chain from the local native request to the same block used for production, not a hypothetical wire contract. Hardware output can still differ from the requested pair: the producer explicitly limits height and obtains width from a hardware field. Any new guard must read **actual** requested pair and still require it to match actual locked/Image W/H, hiding when they disagree. It must not blindly fill requestedW/H with hardcoded 640/480.

## Minimal new read contract

At the already-proven draw call, caller SP+0x168 is the result of the same metadata getter (`0x51db68..0x51db6c`). Borrow that pointer only inside this original callback. Read exactly **8 bytes at pointer+0x58**, interpreting LE U32 requestedW then requestedH; the last byte is pointer+0x5f, so the existing inline block span required is **0x60 bytes**. The original local Start writes that span and the original producer reads it. It is not stack storage, a destroyed return object, or a frame-pixel pointer. Do not retain it across paint callbacks, call a getter, or write it.

The pointer is inline in the engine reachable from the original Access object used by the original paint and by the native producer. This static residence establishes the field layout and borrow scope. It does not prove no concurrent reconfiguration or indefinite pointer validity. Compare the freshly sampled pair with the frame being painted; a change or mismatch hides the overlay rather than borrowing an unrelated configuration. There is no need to fabricate a separate lifetime boolean or broaden the read to all metadata.

Minimal SOURCE contract for the current implementation:

1. Retain actual packed RGB24/stride validation and `lockedW/H == ImageW/H`.
2. Retain positive bounded config dimensions and full ROI `(0,0,configW,configH)` as this version's conservative domain admission.
3. Add positive bounded **actual** requestedW/H from +0x58/+0x5c and require `ImageW/H == requestedW/H`.
4. Remove the erroneous exact config/Image cross-product equality. Do not replace it with an invented hardware rounding rule.
5. Retain normal scale, animation/countdown, rotation, native LCD/provider tables, memory separation, exact native projection and complete clip/Surface coverage guards.

This resolves the particular wrong guard demonstrated by the reported geometry, but does not establish that every later guard will pass or that masks have been accepted on hardware. Formatting the requested pair in the status allows the next actual observation to distinguish request/output mismatch from later geometry rejection.

## Rounding boundaries, for reference only

Engine `0x797604..0x797644` computes binary32 ROI aspect. For width≥height it computes provisional width=maxDimension and height=`FCVTZU(f32(maxDimension * f32(1/aspect)))`; for the portrait arm `0x7977b4..0x7977c0`, height=maxDimension and width=`FCVTZU(f32(maxDimension * aspect))`. Boolean 0 then clamps each against the transformed ROI and applies `AND #0xfffc`, which both truncates to the low U16 domain and rounds down to a multiple of 4. Boolean 1 bypasses those stores and uses the explicit configured pair during fit. These CPU rules do not define the hardware field-0x1a6/0x1a7 rounding algorithm.

The native ROI is also not universally equal to metadata: `0x7976a0..0x7976dc` transforms ROI by descriptorModeW/configW and descriptorModeH/configH with binary32 arithmetic and signed truncation. `0x7974e8` can adjust height/Y, and `0x797774..0x797794` aligns X down to 4 before adding the mode origin. Full-ROI equality is a conservative supported-case guard, not an assertion that every native mode satisfies it. The user's reported complete ROI does satisfy it in this case.

The ratio example's ideal short dimension is about 479.95494, whereas the native local request is independently 480. A subpixel tolerance could be modeled, but is not required when the actual native request pair is directly available. This review deliberately does not claim floor, ceiling or nearest-round is the unique hardware rule.

Reproduce: `python3 analysis/firmware/f1_display14_requested_pair_review_01/collect.py`. It validates the original whole hash, PHDR-maps 15 exact windows, verifies 10 instruction anchors, records frozen input identities and emits normalized host disassembly and exact byte manifests. It does not build or install a new functional payload.
