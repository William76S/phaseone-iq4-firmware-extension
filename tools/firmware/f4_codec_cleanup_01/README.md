# F4 unknown JPEG cleanup: two-object revision

This revision replaces only the linked `bounded_jpeg.o` and F4 `worker.o`. Public symbols, JPEG structures, API82 binding, worker layout and the original session remain unchanged. It does not run on the camera or establish a recording mode or frame rate.

The exact original User is SHA256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`. Its JPEG CreateCompress requires version82 and a **584-byte** LP64 compressor. The existing `f3_native_jpeg8_binding_01` guards these functions and the destroy tail. Its table is retained; the unsafe private JPEG mem-destination wrapper is not used.

Native destroy reaches the memory manager's `self_destruct` callback, which frees pools and can call virtual backing-store close callbacks. The finite original windows collected by this revision verify that chain. They do not prove that every transitive cleanup callback can never invoke `error_exit`. This is a conditional error-handling repair, not evidence of an observed camera failure.

If destroy invokes `error_exit`, the encoder returns `IQ4_JPEG_CLEANUP_ERROR`, reports zero JPEG bytes and keeps its heap context, native pools, error owner and destination reachable for process lifetime. It never retries a partial destroy. Further bounded-encoder calls in that process return the same cleanup error before creating another context or writing a packet. Normal cleanup and ordinary capacity failures retain their previous behavior.

The worker treats this status as `IQ4_F4_WORKER_HOLD`. It keeps the claimed owned RGB slot, skips packet publication and refuses later pumping or sealing. The unchanged session already routes WORKER_HOLD into its HOLD state, stops source production and prevents finish, card release and restart. The packet buffer, API table, source/session and their leases must remain alive; the two replacement objects are intended for this held F4 ownership graph. This is conservative retention, not a checked recovery or hot-unload API. Recovery requires restarting/restoring the process through the deployment's established route.

Run host tests and cross-build into a fresh directory from the repository root:

```sh
build/host-venv/bin/python tools/firmware/f4_codec_cleanup_01/build.py --output analysis/firmware/f4_codec_cleanup_build_fresh
```

`build.py` records every actual argv, compiler/library/source hash and exit status. Tests use the project's existing official host JPEG8 build, never the original firmware library: five codec groups include complete RGB-to-JPEG decoding, channel/geometry checks, input immutability, output-capacity guards, a fatal error **before** real destroy while native host pools remain live, and retry refusal. Three callback-model worker groups cover cleanup HOLD, ordinary capacity failure and normal packet/release ordering. Normal and ASan/UBSan runs passed all eight groups each. This does not claim a model callback test is a native session test.

Two AArch64 Linux API82 ET_REL objects are each built twice with identical bytes. `LINK_OVERLAY.json` pins both exact original object hashes and replacement hashes; integration must replace those two entries, not add duplicate implementations. There are no new unresolved aliases. `BUILD.json` and `EXACT.json` are in `analysis/firmware/f4_codec_cleanup_build_01`; independent review is in `analysis/firmware/f4_cleanup_review_01`.

No target execution, camera access, card write, FPS measurement, recording acceptance or firmware installation occurs in this revision. Existing source RGB24/LCD disjointness, timestamp semantics and file-publication checks are unchanged.
