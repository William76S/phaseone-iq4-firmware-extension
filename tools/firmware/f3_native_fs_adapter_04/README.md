# F3 native POSIX filesystem adapter 04

Independent correction of frozen FS03. Packet01, Stream02 and FS03 are unchanged. The C API and exact original aliases retain their `_03` names; FS04 is selected by its new source/artifact hashes. Only own host files/tests were executed. All camera objects were cross-compiled as AArch64 ET_REL and never executed or installed.

`fs.c` supplies Stream02 filesystem ports. Once a RAW or JPEG owner exists, loss of the native owner/card epoch is UNKNOWN. Owners are retained, RAW is not declared safely retained by path, and close/delete/release are refused. This includes raw-check entry, whole-source readback, the interval between check_raw and open_exclusive, JPEG I/O boundaries, publication and pre-removal. `remove_owned_raw_stage` propagates UNKNOWN instead of downgrading it to FAIL. An uncertain close is never repeated. Normal reported FAIL still requires a known source identity/owner and no unresolved mutation.

The native POSIX layer is usable source, not an inferred private C++ ABI. `native_linux.c` calls the exact original C syscall and errno PLT. Its target headers assert Linux AArch64 stat layout and syscall numbers. The published JPEG uses renameat2(RENAME_NOREPLACE), checked directory fsync and same-inode/length confirmation. ENOSYS and unsupported operations fail with RAW retained when that state is known; there is no silent target fallback. Host macOS uses an explicitly separate linkat-then-unlinkat test implementation and does not demonstrate camera renameat2/card filesystem support.

## Ownership and inputs

Call `f3_fs_prepare_03` with actual held native capture/card directory fds, capture/task identity, and a real native card epoch callback. A constant epoch or caller-supplied boolean is not a production replacement. The context generates fixed exclusive private leaf names and never accepts an arbitrary destination path. O_EXCL, O_NOFOLLOW and actual fd/path device/inode/type are checked. Directory nlink is not held invariant; normal APFS creation changes it. Regular files require nlink=1.

Only `f3_fs_create_stage_03` can establish a newly-owned removable RAW stage. The real complete RAW producer must write that exact stage and return normally before seal: exact complete byte count, whole SHA256 readback, stable identity/metadata, fsync and directory sync. Full-IIQ source/render completeness is not proved by this FS adapter. Owned sealed RAW is rehashed in full even when size and mtime are unchanged. Existing manual IIQs are never removed. Manual attachment uses a separately-owned fd, not a borrowed native reader fd. If attachment/seal encounters an owner loss after an fd has been adopted, inspect `F3Fs.hold` and preserve that context; a false int result alone does not authorize closing it.

The private stage namespace must be serialized under the sole actual capture/task owner for the entire transaction. stat followed by unlink is not an atomic inode-conditional unlink: the checks cannot prevent a concurrent name replacement. No unrelated actor may replace or remove these leaves. Post-unlink sync/epoch uncertainty is UNKNOWN; the path may already be gone while its source fd remains held. The adapter does not label that state FAILED_RAW_RETAINED.

## Native render integration order

A native renderer calls its synchronous sink before all its own cleanup. Therefore its sink must use internal RAW_JPEG to finish/verify/publish the JPEG while retaining RAW. The public RAW/JPEG/RAW+JPEG selection remains immutable and separate. After the native generator/CIB/render objects and actual render workers have returned and completed normal cleanup, the coordinator may inspect public JPEG_ONLY and perform a second, fresh check plus removal of this capture's owned stage. The source lease and card lease must remain held throughout those checks, deletion, and final file/source FD cleanup. They must not be destroyed before deletion.

Stream02's codec cleanup/destroy proof covers the C JPEG encoder only; it is not evidence that native render objects/workers are stopped or that borrowed RAW users have released the stage. FS04 does not silently change mode or implement this coordinator. Passing JPEG_ONLY directly to Stream02 inside the native sink would delete too early and is forbidden for that integration. On native cleanup uncertainty, owner/lease loss or any UNKNOWN result, retain every relevant owner and stop the subsequent deletion/cleanup operations. RAW producer/source binder, render cleanup ownership and actual lease listener must be connected by the consumer before camera use.

## Original bindings and remaining native gaps

`ORIGINAL_BINDINGS.json` pins stock User 11874544 bytes / SHA 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb. The exact syscall alias is decimal4238912 / VA0x40ae40; errno alias is4236512 / VA0x40a4e0. Correct ordinary C signatures are `long syscall(long,...)` and `int* __errno_location(void)`. Target openat56, newfstatat79, fstat80, pread6467, renameat2276 and unlinkat35 come from the actual AArch64/glibc2.28 compile headers.

The bounded own-memory owner guard checks the two PLT instruction windows, complete38-slot LinuxFS vtable and two equal id10 registry records (VAf55e18, owner+10, VTd91450). It does not call factory74e454, which also writes state through74fcc4. The guard has not observed actual device memory. Held fd/device/inode verifies a filesystem object, not a card hotplug generation.

Actual native RAW-success8dcc7c -> completion8dbf58 -> node8c5d98 -> IFM496784 is documented in F3_SAVE_TRANSACTION_STATIC_01. The original JPEG task8e17c8 requests device2/self+1ec and device1/self+1e8 leases through8ca598/8ca888, timeout6000; constructor8e0928 stores owners+1d8/+1e0 and obtains IDs8ca3ec. Frozen storage_lease.disasm.txt contains these windows. Its real availability/lease epoch observer, full capture/source task ownership and actual mount/directory resolution remain unbound. Static SD/XQD roots are not actual runtime mount evidence. No production fake epoch or permanent caller-owned actual flag is introduced.

## Verification and reproduction

Normal and ASan+UBSan each pass17 actual local POSIX failure groups plus7 own-memory guard groups. The new groups cover post-publication epoch loss, removal-entry epoch loss, lost owner after sealing, and loss between raw check and JPEG creation. They assert UNKNOWN, no RAW deletion, no production release and retained fds. Existing cases cover real EEXIST/nonreplacement, successful whole readback, RAW+JPEG retention, manual-IIQ retention, fsync/unsupported failure, post-unlink uncertainty, source mutation with restored mtime, wrong RAW hash and symlink refusal. Test cleanup owns only controlled synthetic host injection fds; it is not an UNKNOWN camera recovery route.

RAW bytes, scan bytes and memory/lease observations are synthetic. Source format/full sensor detail and camera card operations are not tested. `BUILD.json` records every real host/cross-compile command, its result and outputs. Target undefined symbols remain memcpy/memset plus the two original PLT aliases only. `DELTA_03_TO_04.json` records exact lineage, same API/native files and the source changes.

Run from the project root with the external original User and fixed Zig already present:

```
python3 tools/firmware/f3_native_fs_adapter_04/validate.py
python3 tools/firmware/f3_native_fs_adapter_04/build.py
```

Build executes only our host tests and compiles target ET_REL. It never initializes SDK or invokes any device/target code. Exact external User and Zig are not distributed.
