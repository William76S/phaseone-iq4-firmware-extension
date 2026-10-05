# F3 native POSIX filesystem adapter 03

Offline C source and actual host-file verification, not installed or executed in the camera. Packet01 and Stream02 remain frozen. `fs.c` supplies Stream02's real filesystem ports. `native_linux.c` implements them through the original IQ4 AArch64 Linux/glibc syscall and errno PLT; it is cross-compiled only. There is no new SDK, C++ private ABI, device command, or dynamic import lookup.

Call `f3_fs_prepare_03` only with actual directory descriptors held by the native capture/card lease, capture/task identity and a real card-epoch observer. The context itself generates its exclusive temporary/stage/final leaves; it never accepts an absolute destination or arbitrary directory path. Creation is O_EXCL|O_NOFOLLOW, never an Exists-before-O_TRUNC emulation. Fstat of each held directory, held file and no-follow path must match actual device/inode/type. Directory link count is intentionally not immutable: even normal host file creation changes it on APFS.

A newly-owned RAW stage can only be created by `f3_fs_create_stage_03`. Root's actual complete RAW producer must write this specific capture stage and return normally before `f3_fs_seal_stage_03`: checked fsync, actual exact length, complete SHA256 readback, repeat metadata and directory sync. Completion=1 must come from real full-IIQ completion, never UI bool, thumbnail/render dimensions or catalogue pending. Actual RAW-format/full-detail decoding is outside this filesystem adapter. The producer and source file/lease remain pinned. Owned-stage RAW checks rehash the entire source even if size/mtime are unchanged; capture source acquisition, RAW writing and failure fallback to the stock fullRAW save still need the native task binder.

Only an internally-created, sealed stage is removable; manual existing IIQs are retained. `f3_fs_manual_raw_03` takes ownership of a separately opened fd on success, not a borrowed native File/catalogue-reader fd. JPEG publication is target `renameat2(RENAME_NOREPLACE)` followed by checked directory fsync and exact final inode/length. ENOSYS/unsupported/nonreplacement failure retains RAW. No silent Linux fallback is used. Failure after unlink or publication/directory-sync uncertainty is UNKNOWN, not a false claim RAW still has a path; the source fd remains held. Close is never repeated after an uncertain return. UNKNOWN blocks `release_raw` and all further port operations.

`owner_guard.c` verifies the original two PLT instruction windows, the complete 38-slot Linux FileSystem vtable, and two identical id10 registry records containing the supplied actual owner. It only uses a bounded own-memory reader; it never calls the factory. Actual own-memory reads, native card owner and epoch have not been observed on this device. The guard must be the real callback used by the consumer, not a test constant. Production integration remains unbound at these specific lease/task inputs, not at the POSIX operations.

## Original ABI and target objects

`ORIGINAL_BINDINGS.json` is derived from original dynsym/rela.plt/actual PLT bytes of stock User SHA `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`. `iq4_f3_original_syscall_03` binds to decimal4238912 / VA0x40ae40; `iq4_f3_original_errno_location_03` binds to4236512 / VA0x40a4e0. The objects declare the correct ordinary C `long syscall(long,...)` and `int* __errno_location(void)` contracts. No numeric syscall body is hand-packeted. Actual target headers assert stat128 and its fields, and AArch64 openat56/newfstatat79/fstat80/pread6467/renameat2276/unlinkat35. Target root/card paths remain the original factory's configured mount and actual held fds.

`fs.o` 17840 bytes SHA `4174c811744b8763d67dc6fcce41f3178cbdf092f5b9b441c3ee47e355d2f07a`; `owner_guard.o` 2680 bytes SHA `e9eb62bf3332309fb3ab7cd9fb2fa76bac55e6b5fe9ec2f94a0c047b0a4ba686`; `native_linux.o` 5984 bytes SHA `0bd82a72c22583f202e0be68f13843f406c5994b21dd1775caec7fe334322a82`. Undefined symbols are existing memcpy/memset and the two exact original PLT aliases only. No target object was executed.

## Verified host behavior

Normal and ASan+UBSan each pass 13 actual private host POSIX groups and 7 own-memory guard groups. Real files test EEXIST temporary/final nonreplacement, successful checked publication/readback, JPEG-only newstage removal, RAW+JPEG retention, existing-IIQ retention, fsync/unsupported failure, loss of the synthetic lease, changed RAW with restored mtime, wrong RAW hash, and symlink refusal. Failure after unlink retains the source fd and latches UNKNOWN; its test harness disposes only known-owned host injection descriptors after assertion, not a production recovery route. The raw/scan bytes are synthetic; there is no actual camera RAW or card capability claim.

Mac host publication uses a separate, explicitly labelled atomic `linkat` then `unlinkat` adapter. It is not a test of target Linux renameat2 or FAT directory-sync support. Target Linux has no fallback. The first host fault exposed an overstrict directory nlink invariant; this was removed only for directory identity, while file nlink=1/metadata checks stay.

## Concrete native binder gaps

The capture source hook is original RAW-success `8dcc7c` → completion `8dbf58` → node manager `8c5d98` → IFM `496784`, documented in F3_SAVE_TRANSACTION_STATIC_01. Task/RAW/filename ownership must be held through conversion. Original JPEG task `8e17c8` obtains device2/id=self+1ec and device1/id=self+1e8 leases through `8ca598`/`8ca888`, timeout6000; its constructor `8e0928` stores lease owners at+1d8/+1e0 and acquires request IDs at8ca3ec. Frozen `analysis/firmware/f4_static/storage_lease.disasm.txt` contains the exact windows. Reuse that native lease; a hard-coded epoch or host receipt is not its replacement.

The actual id10 registry entry is VAf55e18, owner field+10, with LinuxFS VTd91450. The factory `74e454(manager,id10,true)` also calls `74fcc4(owner,true)`; therefore this adapter does not invoke it just to observe. JPEG root/static `/run/media/sdcard/` and RAW source/card directory must be actually resolved under this native task/lease. Held fd/device/inode verifies same filesystem object, not complete card-hotplug generation. Binding the true availability/lease epoch listener remains specifically unresolved. Full native RAW renderer/selected manual export, UI save-mode/scale and task serialization are separate Root/image-core work.

Local replay runs only own host tests and compiles ET_REL:

```
python3 tools/firmware/f3_native_fs_adapter_03/validate.py
python3 tools/firmware/f3_native_fs_adapter_03/build.py
```

External exact User/Zig are not distributed. No source function installs, deploys or controls a device.
