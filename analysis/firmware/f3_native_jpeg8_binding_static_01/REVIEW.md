# Original JPEG82 API binding, static only

Original User11874544B SHA256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`. Every address below belongs to this User. `EXACT.json` preserves20 normalized original windows, PHDR-derived file offsets, complete hex bytes/hashes, dependency inventory and cached official-source identities. No target, SDK or camera was executed/accessed.

| C API | Actual VA | ABI supported by native calls/body |
|---|---:|---|
| jpeg_std_error | 9a20f0 | x0 error_mgr*, returns unchanged x0; writes168B layout |
| jpeg_CreateCompress | 9a2148 | x0 compressor*, w1 version, x2 size_t; requires82/584 |
| jpeg_destroy_compress | 9a2248 | x0 compressor*, tail→9a3d28; mem+8 self_destruct+50, clears mem/state |
| jpeg_set_defaults | 9a34b8 | x0 compressor*, precision+58=8, tail→9a33d0 uses colorspace+3c |
| jpeg_set_quality | 9a2fc8 | x0 compressor*, w1 quality, w2 boolean force_baseline |
| jpeg_start_compress | 9a39e0 | x0 compressor*, w1 boolean; err+20 reset, dest+10 init, scanline+154=0 |
| jpeg_write_scanlines | 9a3a88 | x0 compressor*, x1 row-pointer array, w2 count; returns w0 actual rows and increments+154 |
| jpeg_finish_compress | 9a22f0 | x0 compressor*; checks image_height+34 against scanline+154, dest+20 term, then abort pools |

These are direct linked User RX functions, not PLT/imported jpeg symbols or a library located by string search. Original ctor98d134 BL9a20f0; full encoder98d6cc BL9a2148 with literal x2=584/w1=82. Inside Create, **9a214c `3f480171` compares82**, **9a218c `bf2209f1` compares584**. The caller and callee agree; API80 must not be passed to this native Create. Static version string at VA dd27d0/file9d27d0 is `libjpeg-turbo version 1.5.3 (build 0)`. Original dynamic dependencies contain no libjpeg, and no jpeg dynamic symbols occur. Public1.5.3 cached archive is SHA b24890e2…592523; verified source functions explain each positive body, but the vendor's version82 build is not claimed identical to public API80 or an independently recovered vendor configuration.

RGB32 ownership/callback chain is positive: ICE ctor **7b55b8 `645e0794` →98cf48**, stores returned encoder at owner+65547928 (7b55cc). Factory allocates0x480 (1152) bytes and ctor98d0f0..fc installs primaryVT dce100. Its+28 pointer is98d950; original **7b81d4 `60023fd6`** calls that slot synchronously. Arguments:

- x0=that encoder; x1=9043c8(plane of stack CImageBuffer sp+e0)+signed offset sp+608.
- w2/w3=meta(sp+448)+4/+8, w4=quality sp+474, x5=meta+10 output.
- w6=capacity sp+42c, w7=904468(source actual stride).

98d950 forwards to98d680 with w7=4 components and ninth stack argument=the caller's actual stride. 98d680 writes width/height at compressor+30/+34, components4 at+38, colorspace15 at+3c (`JCS_EXT_ARGB`), then calls those same defaults/quality/start/scanline/finish/destroy addresses. Thus stream_rgb32's memory bytes[1,2,3]→RGB24 channel conversion agrees with native layout. It does not prove full-RAW render, sRGB, or safe ownership after this synchronous callback returns.

The new `tools/firmware/f3_native_jpeg8_binding_01/native_jpeg82.c` does **not** instantiate that shared encoder or call its private longjmp/destination. It produces an explicit nonempty unadmitted table, then admits only after caller-supplied verified self-read matches all eight complete API bodies plus the destroy tail1932B, each read≤64B. It contains no constructor, allocation, automatic lookup, generic native call or deployment. The original source SHA is a baseline identifier: the patched running User needs its own identity and immutable mapping proof; passing the old SHA cannot make the new whole file equal the original. These code guards do not validate every transitively called library function or replace that actual identity proof.

API82 LP64 static assertions cover compressor584/error168/dest40, pointer/size_t8, boolean/JDIMENSION4, JSAMPLE1; original direct offsets err0/mem8/client24/state36/dest40/width48/height52/components56/colorspace60/precision88/next_scanline340 and destination/error callback offsets match. C-only error handling stays in Root's own stream: setjmp is established before Create, error_exit is replaced with its own callback before any native allocation, and destroy uses the library memory owner. No original C++ encoder lifecycle is borrowed. Native warning text, fatal/cleanup behavior and memory pressure remain target acceptance work.

Actual own-host tests:4 unadmitted architecture/arguments groups plus22 finite synthetic code mapping/fault groups, repeated22 under ASan/UBSan. All native function pointers were inspected only. AArch64 `native_jpeg82.o` has no undefined symbols; Root's unchanged stream_rgb32.c also compiles under82. Its six imports map to original PLT: _setjmp40a140, memset40a1a0, malloc40a5e0, calloc40a760, longjmp40b060, free40b120. Actual linker must bind them explicitly and retain the original runtime library; no desktop JPEG address is valid here.

Before an actual JPEG call, Root must separately admit current modified User/process/immutable code and render owner, complete source geometry/span/stride/lifetime, target libc/setjmp link, private sink transaction, and measured API82 output/error/destroy validation. Table availability is not capture mode acceptance or an installed F3 function. No FWP or camera claim is produced by this increment.
