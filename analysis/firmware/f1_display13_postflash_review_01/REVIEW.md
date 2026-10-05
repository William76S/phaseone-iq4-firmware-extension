# Display13: caller and coordinate-domain review after menu selection

This is a static-only review of original User `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb` and frozen display13 source. It does not execute the target, access the camera, or read any actual frame/object fields. Root reports that candidate03 exposes the native F1 menu and retains Selected; this review does not repeat or independently verify that hardware observation.

No unconditional SP/FP, metadata-pointer, animation-field, or LCD table-layout rejection was established. The strongest concrete defect candidate is an extra equality across three distinct native domains: configuration dimensions, produced RGB24 dimensions, and ROI coordinates. A host example can prove that the frozen predicate rejects a stock-algorithm-compatible geometry; it cannot establish which predicate rejected the actual camera paint.

## Exact original caller

`0x51da0c..0x51df64` allocates `0x170` bytes with `STP x29,x30,[sp,#-0x170]!` at `0x51da0c` (`fd7ba9a9`), then sets `x29=sp` at `0x51da10` (`fd030091`). No further caller SP/FP change occurs before the stock draw BL. Thus captured `caller_fp == caller_sp` is valid on this path, not a demonstrated blocker.

The old BL at `0x51ddcc` is `9b64fd97`, targeting `0x477038`; return PC is `0x51ddd0`. At that call:

| Argument | Original source |
|---|---|
| x0 | Surface retained at caller SP+0x30 |
| x1 | destination Rectangle at SP+0x110, copied from SP+0x80 |
| w2 / w3 | 0 / 0 |
| x4 | Image at SP+0xc0 |
| w5 | LV+0x1b0 rotation |
| x6 | mutable clip copy at SP+0x128 |
| x7 | 0 |
| x8 | returned projection Rectangle at SP+0xf8 |

LV itself is retained at SP+0x38. `Control::Draw` `0x4abd24..0x4ac040` saves its input Surface and passes that same pointer to the virtual paint (`0x4abe88..0x4abe90`); this call does not construct a temporary base Surface. Original projection/image draw `0x476e6c..0x477384` uses Rectangle VT `0xb73b98`, fits the RGB24 Image into destination and writes the projected Rectangle. These facts support the frozen wrapper's on-stack provenance checks but do not prove that its later coverage predicate passes on the camera.

## SP+0x168 is configuration metadata, not produced-frame size

`0x51db68` calls `0x6b614c`, and `0x51db6c` stores its result at SP+0x168. `0x6b614c..0x6b616c` loads the engine at Access+8 and calls `0x6b6dec`; the complete leaf `0x6b6dec..0x6b6e08` returns engine+0x4760. Its +4/+8 fields are the configuration dimensions used by the original source-point mapper (`0x51f59c..0x51f5c4`). Display13's local variable named `engine` is this metadata pointer. Its offset reads are consistent, but equating those values with output Image W/H is an added policy.

Positive dimension origin: `0x799600` (`43c044fc`) loads 8 bytes from the engine's +0x20c0 provider object at +0x4c. `0x79960c` (`634316fc`) copies them to engine+0x4764/+0x4768. `0x799674` / `0x799678` (`60c223fd` / `60ce23fd`) use those W/H values to initialize two configuration Rectangles. The actual provider object and its runtime field values were not read here.

The Image W/H at SP+0xc4/+0xc8 comes from the locked VideoBuffer size: `0x6b61fc → 0x6b6d44 → 0x6b6b70`. Its ROI at SP+0xa0 comes separately through `0x6b621c → 0x6b6d68 → 0x6b6be0`. Calls at `0x7876e4..0x787708` supply field IDs 0x1a6/0x1a7 to `0x77d350` and retain the results. Producer window `0x787838..0x787884` takes slot width from the retained 0x1a6 value and slot height from `min(retained 0x1a7, pending+0x5c)`, while copying pending+0x18's x/y/w/h into slot ROI. There is no equality assertion in these getter/producer windows tying the three domains together.

The caller itself then reads ROI W/H at SP+0xb0/+0xb4, divides each by LV+0x190 and truncates to the destination W/H (`0x51dbd0..0x51dc0c`). This configuration-to-display operation is independent of the Image constructor at `0x51db84..0x51dbac`, which uses the locked W/H. It is direct positive evidence of domain separation in the exact paint being patched, not only a backend assumption.

Normal local Start `0x5202a0..0x520588` constructs a 640×480 fitting rectangle, requests a full configuration-coordinate ROI, and calls Access set-config at `0x52040c` with max dimension 640 and boolean 1. Full engine set-config `0x7975d0..0x7977e0` reads metadata W/H, obtains mode W/H, scales the input ROI by mode/config ratios, and selects the original fit helper `0x7974e8..0x7975d0` when that boolean is 1. These are separate operations. This review found no positive guarantee that resulting ROI W/H equals produced pixel W/H.

Display13 `payload.c`'s SOURCE predicate requires all of the following simultaneously: locked W/H == Image W/H, configuration W/H == Image W/H, and ROI `(0,0,Image W,Image H)`. Only the first pair is directly supported by the caller's Image construction. Configuration and ROI equality require independent source-domain evidence. A finite example with configuration/ROI 1280×960, scale 2, produced pixels 640×480 and an exactly covered native projection is rejected as SOURCE13; this is a synthetic, stock-algorithm-compatible counterexample, not a measured IQ4 frame or proof of this incident's first failed gate.

The independent finite host counterexample is frozen in `analysis/firmware/f1_display13_no_effect_static_review_01`: REVIEW.md SHA `b76509af602cc56b7eadcf3352eb6fb6f3a6ffb01c9f50ff3e2105054e1e3721`, REVIEW.json SHA `ed551a47636071b7b5a75521c2ff60fc4e1b8fc187705b117120ed83f7701639`, and SHA256.json SHA `d30bdcb9eef6bde1062599ab5f342ec1d694181b2c934a6aa8a71e1a7056a07e`. It preserves the distinction between host proof and actual camera values. Replacing the wrong equality with full ROI==configuration plus an int64 aspect-ratio match is a narrow admission strategy, but the mode/config transform above means full ROI==configuration is not proven universal across every native mode; unsupported/unproven domains should continue to hide the overlay.

## Animation and scale offsets are consistent

LV contains its Pan object at +0x110. `0x4c4cc4..0x4c4ce8` adds +0x20 and calls `0x4c4fa8`; `0x4c4fb4` (`00204039`) reads byte +8. Therefore animation-active is indeed LV+0x138. The original Pan getter `0x4c4a54..0x4c4ab4` uses this boolean and may update its cached Point at object+8 (LV+0x118); it must not be called as a pure observer. No incorrect +0x138 offset was found.

Ctor `0x5176f0..0x517700` initializes both LV+0x190 and LV+0x194 to float 1.0. Normal local Start computes the larger integer ratio of configuration W/640 and H/480 at `0x520488..0x5204c8`, stores that float to +0x194 and calls SetScale `0x520814`. Its ordinary arm writes the supplied scale to +0x190. Thus scale equality can hold on normal Start; it is not proven to fail universally. Scale mismatch, active animation, countdown, unsupported rotation, or coverage checks can still legitimately suppress an individual paint.

## Native type tables and remaining actual uncertainty

`EXACT_BYTES.json` independently records all 12 LCD primary/IScreen table words at `0xb7cf80` and all 6 Draw words at `0xb7b7c8`. They match display13's pinned arrays. This static match does not establish the actual Surface pointer, manager/provider link, LCD dimensions, source/destination disjointness or fresh full coverage.

The minimal next evidence is a bounded first-rejection diagnostic from the actual hook: distinguish the early caller/object/type gates from `iq4_f1_plan_13`'s reason, and retain actual configuration W/H, Image/locked W/H, ROI, destination/projected/clip, scale bits, rotation, animation and countdown. No source pixels, RAW/JPEG config, PIN, or unbounded memory dump is needed. Preserve the original draw exactly once and do not loosen all guards merely because a synthetic fixture passes. If actual evidence confirms SOURCE13 solely because configuration/ROI are expressed in their native domain, correct that one domain contract while retaining complete-source/zoom/coverage safety; current evidence alone does not justify a blanket deletion of the SOURCE guard.

Reproduce with `python3 analysis/firmware/f1_display13_postflash_review_01/collect.py`. It pins the original whole hash, PHDR-maps every range, checks 10 instruction anchors, emits exact bytes and normalized host disassembly, and records the unmodified display13 source identities. All original and frozen files remain unchanged.
