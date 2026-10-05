# Display16 Ratio Mask opacity and seven ratios

Derived from frozen Display15, which the user reported visible on their IQ4. Register capture, original stock call, requested output +58/+5c, ROI/config guards, normal-fit/rotation0, source/LCD isolation and binary32 right/bottom clipping are preserved. Wrapper is identical after normalizing its two full symbol names; no register number changes.

Ratio modes1–7 are65:24,16:9,3:2,1:1,4:5,6:7,21:9. Bands center in full projected geometry and are intersected with the proven original write footprint. Actual user geometry remains full645x483 but only645x479 written. Row479 is never touched.

Opacity comes from separately linked UI getter. Unsigned percent0–100 converts to native alpha `(percent*255+50)/100`. Color remains black.65 produces166 exactly as Display15;0 reportsE3 and skips fill. Invalid>100 fails closed. Every hook follows the original source draw exactly once; it retains no cached masked image. No RAW/JPEG/video/HDMI source is modified. Only exact original User9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb is supported.

Normal and ASan/UBSan fixtures verify all21 UI alpha levels, monotonic pixel dimming, source and original object isolation, all7 ratios, actual479-row clip, original-vtable checks and Off. Host simulation is not camera acceptance. Unknown rotation/zoom/animation/left-top crop stays original and hides mask.
