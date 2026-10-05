# Native Dual Exposure Ratio: forward consumer and limits

Binding: original User 11,874,544 bytes, SHA256
`9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`.
All conclusions below are static original-byte evidence. No device/SDK or
firmware execution. `exact/EXACT.json` records file offsets, bytes and hashes.

The actual normal sensor Ratio consumer is status `+0x1080`'s current float
at `+0xc0`, therefore status `+0x1140`. Main creates the StatusGroup in
`0x41a118..41a12c`; `5c1e24` creates its Ratio with default 8, and `5c1e64`
creates the separate long-shutter U32 at `+0x1160` (default 80).

Main constructs IMX461/411 sensors at `41e5a4`/`41e5fc`, keeps the sensor in
SP+0x6f0, then passes it as x3 to controller constructor `7988e0`. The constructor
moves incoming x3 to x27 (`798934`) and stores it at controller+0x20c8 (`799304`).
Main's stack argument 0 comes from the same StatusGroup (SP+0x1cb8 at `41e984`);
`799398..799410` stores that pointer at controller+0x80e8.
`79955c..799570` registers controller against the Ratio event at status+0x1088.

Initial setup `793bf8..793c10` reads that StatusGroup's float at +0x1140 and
passes it in s0 directly to sensor VT+0x80. The normal event handler
`79cb44..79cb54` compares against status+0x1088; equal branch
`79cb98..79cbac` repeats the same float load and sensor VT+0x80 dispatch.
Neither call obtains its float from the long-shutter U32 or the UI quantizer.

All five exact original Sony/IMX sensor vtables in the collector have +0x80
=`80e794`. This method stores s0 >= 1 unchanged at sensor+0x138, converts
0 < s0 < 1 to its reciprocal, and substitutes 1 for s0 <= 0. The finite complete
setter body has no upper clamp. IMX411 `822adc..822af4` and IMX461
`81c1c0..81c1d8` multiply an integration input by the float at sensor+0x138 and
convert the long integration with FCVTZU. This proves a float-driven hardware
parameter path; it is not measurement of actual exposure accuracy/rounding or
Black Reference behavior.

The original UI update `5384cc..538684` reads base tick, converts it with
`71b538`, reads Ratio, multiplies seconds and calls `71b804` at `538540`.
It then clamps to the long configuration's native minimum/maximum, sets the
separate status+0x1160 using `40c8b4`, and formats `(base−long)/12` EV.
The two proven sensor consumer paths read Ratio, so changing only the result
of this UI conversion does not replace their input with a quantized long tick.
The collection is not an exclusion proof for every asynchronous subscriber:
notification delivery/other consumers are not all emulated. New module 02
itself has no Ratio write in its long-tick helper and the actual full update
emulation retains Ratio for all 639 cases.

The ratio config at +0x1370 has the stock four-entry table (2,4,8,16), backed by
status+0x1080; its enum setter sends the selected float to the native float
property setter `44136c`. The float setter writes +0xc0 and notifies +8 without
an additional float clamp. Config+0x1468 is the separate long-shutter selector.
`DualExpToolEvHandler` is a generic wake/start-capture handler, not this float
consumer. Offsets on unrelated SettingsGroup objects (for example +0x1468
SensorRotation) are not interchangeable with this DualExposure configuration.

The original callback has an actual busy guard: dialog+0x380 points to
CoreUiData+0x278→SequencerEventGroup+0x298. Main `41a1cc` constructs that group
with `5f9d3c`; `5f9dc0..5f9dd8` creates the boolean named RunningSequence with
default false. Main SP+0x248→CoreUiData+0x278 is exact in the collector.
`537904..537924` reads this native boolean and returns before tag dispatch when
true. It remains unmodified. The name alone does not establish every automatic
or explicit Black Reference producer path; that separate finite review is
required before claiming calibration mutual exclusion.
