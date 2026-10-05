# Stream export04: retain unknown JPEG cleanup

This is an ABI03-compatible derivative. Replace only jpeg_export.o and
stream_export.o from export03; all exported production names and layouts are
unchanged. ExportPixels/geometry remain frozen and compile byte-identically.
Do not link both revisions together.

If the original JPEG destructor calls error_exit/longjmp, its cleanup has not
returned. Preserve the compressor context, error/destination records and RGB24
row in a process-lifetime atomic retained list. Return CLEANUP_ERROR with zero
JPEG bytes. The checked transaction now enters UNKNOWN_HOLD rather than finite
abort: RAW, unpublished file, render/source/card/pool owners remain retained.
The coordinator must hold activity and must not clean the source or retry.
Ordinary finish/scan/write failures whose destructor returns remain finite
failures, keep RAW and close the owned unpublished output once.

Original native destroy9a2248→9a3d28 uses mem+50 self_destruct. The original
Create9a5250 sets this callback to9a4230; that callback's free_pool9a40d8 path
still invokes backing-store close callbacks. A top-level destroy without a
direct error BL is insufficient proof that cleanup cannot fail. Revision03's
free-after-longjmp behavior is preserved historically and not used for new
production integration.

Actual host62 groups pass normally and with ASan/UBSan, including both a
destructor error after a real host destroy and a destructor error before any
pool cleanup. Both latch Hold, retain context and permit no further checked
I/O/destructor retry. Six sizes×four rotations still actual encode/full
entropy decode; original RAW is not decoded in these tests. Four AArch64
objects only compile. No camera/SDK access or new firmware is performed here.

```sh
python3 tools/firmware/f3_stream_export_04/build.py --output analysis/firmware/f3_stream_export_04_fresh
python3 tools/firmware/f3_stream_export_04/freeze.py --verify
```

Geometry's2540 independent cases passed in unchanged revision03 and are not
rerun merely for this cleanup fix. No RAW deletion is introduced.
