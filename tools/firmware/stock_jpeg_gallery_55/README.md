# JPEG-only native catalog / LCD consumer 55

Independent bounded registry (1024 genuine `.JPG` records), exact native
catalog/node/name/card identities and native catalog mutex. Original RAW and
RAW+JPEG records retain their original renderer, flags and queue paths.

Cold/card refresh enumerates actual JPEG files through the original card FS;
metadata uses the actual JPEG dimensions and EXIF orientation. No EXIF means
orientation 1. Mirrored/unknown orientation is refused before RAW retirement.
JPEG preview and zoom decode the actual JPEG file into the native caller's
checked pool. Standard integer EXIF inverse ROI precedes IDCT/fit reduction;
rotation uses only an already reduced LCD scratch, bounded to 32 MiB.

Before RAW retirement, `prepare` completes the on-card JPEG entropy stream
into a private 97,200-byte 180x180 RGB scratch. Success requires a complete
result, valid actual EXIF and the same native photo/card identity. Failed
decoding preserves RAW. `commit` occurs after the caller's exact RAW clear,
never while that caller holds the catalog mutex. Sorting between these steps
can cause an exact-identity refusal/HOLD after the published JPEG exists;
cold enumeration can rebuild the genuine JPEG record. This is a code path,
not a camera-validated recovery claim. No hidden RAW or fake RAW presence bit.

Reproduce with:

```
python3 tools/firmware/stock_jpeg_gallery_55/build.py --output analysis/firmware/stock_jpeg_gallery_55_build_repro
```

Host catalog/LCD tests use explicitly identified native-service and decoder
fixtures. Real compressed entropy/file decoding has separate Root decoder
evidence. Focused original A64 wrapper/Rectangle evidence does not execute
the full native LCD functions or physical display. Registry capacity, card
hot-swap/node reconstruction, mirrored EXIF, visual fit and JPEG-only capture
remain hardware acceptance items. No camera access or firmware deployment.
