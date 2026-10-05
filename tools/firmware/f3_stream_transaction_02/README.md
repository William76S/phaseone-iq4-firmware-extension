# F3 streaming checked transaction 02

Own offline C implementation; no target execution, camera API, or automatic native binding. Transaction01 remains frozen. This increment connects Root's synchronous `src/codec/stream_rgb32.c` encoder through a real checked sink, without accumulating a full encoded packet or copying a full RGB24 image.

Call `f3_stream_begin_02` with a fresh zero-initialized context, the serialized session, actual RAW/full-render identity, verified ports, byte budget and 64 KiB scratch. All encoded/span fields must be zero. `f3_stream_encode_rgb32_02` borrows the actual rendered RGB32 rows and supplies the encoder's 16 KiB sink. The encoder must normally return success, all output rows, finish and destroy before finish may publish. Alternatively a synchronous producer may use sink/finish directly, with completion fields populated solely from actual returns. A complete prefix or an attempted finish is not a success receipt.

Each accepted chunk has an exact Write count, incremental SHA256, and incremental baseline single-scan JPEG marker grammar. Finish requires SOF0 dimensions, three components, one correctly shaped SOS and exact terminal EOI with no trailing bytes. It checks fsync/Close, held read identity and exact file length, full independent readback SHA256 and marker grammar, repeat identity/size, and read Close. Only then can non-replacing durable publication occur. JPEG-only removes exclusively its own newly-created capture stage after a fresh RAW check; existing manual-export IIQs are always retained. This is structural verification plus byte integrity, not an entropy decoder or proof of real RAW resolution.

Known failures wait until the synchronous producer returns before closing its private file. UNKNOWN latches the shared session, preserves handles and source owner, and rejects writes/finish/abort/next jobs; no cancellation, retry, forced Close, or reused context clears it. The native adapter must retain actual owners and classify partial unlink or unknown remove acknowledgement as UNKNOWN, not known RAW retained. The own context is single-threaded and serialized; no concurrent callback/reset is permitted. A failed transaction leaves its private JPEG temporary for the owner to handle; it never deletes old files.

SHA256 is mechanically reused from frozen `f4_ui_bootstrap_02/sha256.h`; only the include guard and `static` function linkage to `static inline` differ. Empty, abc, 56-byte two-block and million-a standard vectors passed. Normal and ASan+UBSan each passed 50 owned failure groups and 6 actual host-codec integration groups. The latter entropy-decodes 256 rows of a synthetic 384×256 RGB32 source, checks its input unchanged, and injects short/unknown writes, finish/destroy failure and readback corruption. They do not prove camera RAW provenance, full-size native capacity or device file operations.

Local replay:

```
python3 tools/firmware/f3_stream_transaction_02/validate.py
python3 tools/firmware/f3_stream_transaction_02/build.py
```

The builder executes only our host tests and host libjpeg, then compiles two AArch64 ET_REL objects; it does not execute target/SDK. Existing external host libjpeg archives and Zig are pinned in BUILD.json, not bundled. Original standard imports of target stream.o are memcpy/memset; bridge.o needs our stream functions and Root's iq4_jpeg_stream_rgb32. No native filesystem functions or owner addresses are guessed. Actual exclusive-create/publication/native card/task binding is implemented separately; no device deployment or JPEG-only acceptance is asserted.
