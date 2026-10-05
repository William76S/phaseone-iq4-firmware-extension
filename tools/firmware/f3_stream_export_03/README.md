# Complete-plane JPEG export 03

This source consumes a borrowed complete valid-RAW rendered XRGB32 plane, resamples actual pixels and writes a checked JPEG transaction. It implements Full, 75%, 50%, 25%, long edge3840 and7680 with the shared geometry rules. Width and height round to nearest integer, half up. Upscaling rejects. Explicit output rotation0/90/180/270 is a user policy;0 means stored pixel orientation and does not claim that the RAW orientation metadata is zero.

The exact area filter uses integer overlap weights and one RGB24 output row. It handles odd dimensions, padded stride and rotation without allocating a second full RGB image or modifying source pixels. It averages the original renderer's code values; this is not a linear-light filter or a proved color-space transform. It applies no LUT and embeds no asserted sRGB profile.

Actual baseline JPEG8 encoding uses an explicitly bound C function table, quality1–100 and the checked finish/destruction contract. The native JPEG82 binder is a separate frozen dependency. The file layer checks the exact borrowed source identity, geometry, complete encoded row count, JPEG syntax, whole SHA256 readback, close and non-replacing publication. Short/error operations retain RAW. Unknown operations hold ownership and allow no retries.

**This layer never removes RAW**, even for a new JPEG-only capture. It stores the immutable requested mode and runs the file layer internally as RAW+JPEG. Only the later actual capture coordinator can delete a proven newly created RAW after native renderer cleanup, file publication and a fresh capture/file identity check. Manual existing IIQs are always retained. This layer cannot manufacture a full-RAW provenance receipt: the real source, decoder and renderer must provide it.

Reproduce normal/ASan+UBSan host checks and four AArch64 ET_REL objects into a fresh directory:

```sh
python3 -B tools/firmware/f3_stream_export_03/build.py --output analysis/firmware/f3_export_fresh
```

The independent small-pixel reference covers2540 area/rotation/stride cases per host variant plus six bad-input groups. Real host JPEG8 encoding and full entropy decoding cover six sizes×four rotations of an8193×127 synthetic XRGB plane. Full/R0 bytes equal the frozen old direct-plane JPEG encoder. Each variant also tests checked-file faults, short writes, corrupt readback, identity changes, encoder finish/destruction failures and UNKNOWN refusal. This is synthetic RGB and fixture file I/O, not an actual IIQ decode, camera run, global JPEG-only capture acceptance or a firmware installation.
