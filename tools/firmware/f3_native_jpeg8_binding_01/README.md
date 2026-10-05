# F3 native JPEG82 C function binding

This supplies eight concrete original-User C entry points for the existing `src/codec/stream_rgb32.c`. It does not use the original growing memory destination or allocate/share its C++ encoder owner. Nothing runs at startup, and no firmware, SDK, camera, file, RAW or image access occurs in this module.

`native_jpeg82.h/c` uses the existing unmodified public libjpeg-turbo 1.5.3 JPEG8 headers with an explicit `IQ4_JPEG_API_VERSION=82`. The exact User demands version82 and `jpeg_compress_struct` size584; native offsets agree with the LP64 structures used by the stream. Original code contains the1.5.3 version string; this does not turn the project-generated config into the original vendor config or claim the vendor's API82 build is byte-identical to public API80.

`iq4_native_jpeg82_unadmitted_table_01()` returns the real addresses with `binding_abi_verified=0`; merely obtaining this table cannot admit encoding. Call `iq4_native_jpeg82_bind_01(originalBaselineSHA32, verifiedSelfReader, context, &api)` explicitly. It checks the baseline identity and every byte of nine complete entry bodies (eight API functions plus the destroy tail target),1932 bytes total, using at most64 bytes per read and no allocation. Any read error/code mismatch returns an empty table. The original text must remain immutable. This guard is finite code verification, not a generalized address caller or a target memory reader.

The reader and current process/module identity are the actual integration responsibility. The SHA argument identifies the original source baseline `9b611efe…032cdb`. A patched User has a different whole-file hash: it needs its own real running-module identity plus proof that these original addresses/body bytes remain present. Do not pass the old whole SHA as the patched file's identity. Guard success admits the statically closed C ABI only; target JPEG output/error/destroy behavior has not yet been tested. Host success uses an explicitly named synthetic-reader test build; its function pointers are never invoked.

After successful admission, Root's original render/capture transaction can pass the resulting `Iq4JpegApi` to `iq4_jpeg_stream_rgb32`. The plane remains borrowed only during its synchronous call; source validity/complete RAW provenance, native worker ownership, exact nearest-rounded output dimensions, color semantics and destination transaction must be proved by their separate ports. This table does not change those facts or enable the UI/capture policy by itself. No RAW retention decision, capture enum, recorder, LUT, F1 path or installation is added here.

The original RGB32 worker chain is `7b55b8 → 98cf48 → 98d0d8`, then the owner field `+0x65547928` selects VT `dce100+28 = 98d950` at `7b81d4`. The RGB32 wrapper passes input_components4, colorspace15 (`JCS_EXT_ARGB`), and the supplied stride as the ninth argument to `98d680`. The stream's row conversion `[1],[2],[3] → RGB24` uses the same channel order. API calls use independently owned compressor/error/destination objects; they never enter that original private wrapper's `setjmp` owner or expanding destination.

Reproduce from project root into fresh output directories:

```sh
python3 tools/firmware/f3_native_jpeg8_binding_01/collect.py \
  --output analysis/firmware/f3_native_jpeg8_binding_static_recheck
python3 tools/firmware/f3_native_jpeg8_binding_01/build.py \
  --output analysis/firmware/f3_native_jpeg8_binding_build_recheck
python3 tools/firmware/f3_native_jpeg8_binding_01/validate.py
```

`collect.py` reads only the exact original User and verified existing official source archive; it checks generated pins instead of changing frozen source. `--emit-code-pins` was used once before freezing and must not be used against a frozen source tree. `build.py` uses the existing pinned Zig0.15.2, runs only this project's own host fixtures, and compiles two AArch64 ET_REL objects without executing them. The native binding object has no undefined symbols. The existing stream object needs libc/setjmp functions, all already imported by original User; actual linking must still bind its exact imports, not insert desktop library addresses.

The actual build records4 unadmitted-host groups,22 synthetic mapping/fault groups and22 ASan/UBSan groups. The nine code-body corruption/read-failure cases reject with no admitted pointers. No native encoder call, target process, SDK, deployment or hardware validation occurred.

Public headers retain the upstream IJG/libjpeg-turbo licensing files. See `src/codec/vendor/libjpeg-turbo-1.5.3/LICENSE.md` and `README.ijg`.
