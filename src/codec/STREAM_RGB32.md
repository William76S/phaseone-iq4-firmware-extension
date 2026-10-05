# F3 borrowed RGB32 → streaming JPEG

`stream_rgb32.c/h` reuses the existing verified public JPEG8 API table and headers. There is no native binding by default. Original ICE worker7b81d4 supplies a synchronous borrowed RGB32 plane and7b8250 otherwise copies channels1/2/3 to full RGB24 before destroying CImageBuffers. The new adapter retains no plane after return and uses only one W×3 conversion row plus16KiB destination, avoiding that RGB24 whole-frame copy. Original RAW rendering and its full-frame intermediate buffers remain separate requirements.

The input is X,R,G,B memory with explicit complete range/stride/dimensions. Output is baseline sequential, no optimized/progressive full-image passes requested. Original render ownership must stay pinned through return. Geometry is not full-RAW provenance; no thumbnail or preview is accepted as full RAW by the downstream render/job contract. Library-owned working memory is not claimed hard bounded by the16KiB destination. No color transform/LUT/RAW metadata is added.

The sink must be a private unpublished file transaction. Each call checks actual write count and total byte budget. A later write error, budget exhaustion, scanline suspension, library fatal or destroy failure yieldszero jpeg_bytes, even if a prefix exists. Accepted-prefix bytes are cleanup diagnostics only. Source descriptors/result overlap and row range overflow are rejected. All setjmp/longjmp/frees stay in C; callback ports must not throw through the C boundary. An unknown storage ownership condition is handled by the transaction layer, never by retrying here.

The adapter does not close, fsync, read back, publish, remove files or decide RAW retention. Packet save_transaction01 requires a full encoded span and cannot directly accept this streaming interface. Stream transaction02 must separately validate successful producer finish, length, SOF/EOI/dimensions, digest, exact card/file identity, checked close and atomic publication before JPEG-only may remove a newly captured private stage. Existing user IIQs are never eligible.

## Actual checks

`analysis/firmware/f3_stream_rgb32_host_02` records15 owned host groups plus3 full-size synthetic geometry cases, normal and15 sanitized small/failure groups. Actual JPEGs14204×10652,10653×7989,7102×5326 were encoded and completely decoded on the host; source is synthetic and this does not establish an IQ4 RAW render. RGB32 channel/stride conversion yields byte-identical JPEG to prior RGB24 adapter under the same host library. Padding/source remain unchanged. Tests cover null/unbound API, geometry/descriptor alias, budget before and after accepted chunks, later shortwrite, library start/finish/destroy fatal, scanline suspension/wrong progression and successful reuse after cleanup.

Actual API82 AArch64 ET_REL5272B SHA8ef3f8ec2e4619413838fd17557f44678b1bad795c676a26277618ae67fe5b24 is cross-compiled, never executed. Candidate06 does not contain F3. Original render/source, actual native JPEG API runtime ABI, filesystem and capture-format consumers are still not bound or camera accepted.

Reproduce with fixed host libjpeg8 normal/sanitized builds already documented in`README.md`:

```sh
python3 -B tests/codec/stream_rgb32/run.py --output analysis/firmware/f3_stream_rgb32_new
```

Fresh output is mandatory. SOURCE_SHA256 locks all direct/transitive code, public headers and licenses. Runner verifies sources and Zig executable; compiler/library execution records and hashes identify actual inputs. Vendor IJG/libjpeg-turbo copyright and license files remain unchanged.
