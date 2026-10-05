# F3 capture completion and checked JPEG save

All results are static or host-only. Exact original: P1Linux_6.03.21.bin, 11874544 bytes, SHA256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`. No SDK, target, camera, Windows or network execution. Exact byte windows, file-backed ELF mapping, finite direct-call incoming scan and filesystem tables are in `f3_save_transaction_static_01`.

## Actual RAW-save successor

`8dcc7c` takes the storage queue's current node (model+988), calls its Store virtual+40, and distinguishes result 0 success, 1 failure, 2 retry. Only success publishes model+1150 and model+a70=true. Completion dispatch `8db4b4..8db508` reads that bool and calls `8dbf58`; on a successful context+13f2-enabled task it gets the current node, context+13f3 flag, and calls `8c5d98`. That bridge uses node+d8 and manager+320 IFM to call `496784`. Flag 2 adds pending bit 0x100 when IFM+fb5 is enabled and sets IFM+778 ImageStoredOnXQD; its event is +780. JPEG worker `8e0b18` subscribes it and arms a 600 ms retry timer. This is a usable native post-save hook and task ownership chain; the notification alone does not independently prove durable RAW bytes.

The generic full RAW content writer `8dcf98` acquires the RAW descriptor/capture metadata and calls `7d8bc8` on its actual raw data/dimensions with 14 bits. It checks that result, `7d8c10` finalization, and `7d8a38` virtual final return. The latter dispatches the underlying writer virtual+10; its complete durable implementation remains an integration prerequisite, not assumed fsync. XQD writer `8df1a0` checks its 4096-byte header and remaining payload write counts; normal destruction closes File objects but does not consume Close's bool, so event success is not a substitute for a checked-close adapter.

## Definite old JPEG failure

`8e1d70..8e1f7c` encodes into the fixed 100 MiB buffer. False filename selection, failed Open, short/failed Write and failed Close do not produce an ordinary false result: the common normal return `8e1f38` sets w19=1. The Write (`8258b8`) and Close (`82580c`) return values are ignored. The 4K task `8e17c8` then treats true as success and marks JPEG flag 0x10/removes pending. A JPEG-only policy must not delete RAW based on that return.

Name selection `8e1f7c` uses `DCIM/%dPHASE/` (100..999), `%s.JPG` then `%s_%u.JPG`; the Exists check is separate from truncating Open, therefore has no non-replacement proof. Main `424b80` explicitly selects filesystem id10. The original registry identifies id10 `/run/media/sdcard/`, id11 `/run/media/xqdcard/`; these static names do not establish actual mount/card availability.

## Recovered native filesystem ABI

These signatures are inferred from complete call and implementation windows bound to this exact User. They are not exported headers or runtime-validated ABI. File object is 24 bytes: vptr+0, filesystem pointer+8, fd+10, open byte+14, dirty byte+15. ctor `825770`, dtor `8257b4`. Linux FileSystem vtable d91450, constructed by `825c0c`.

| Operation | Caller and concrete target | AArch64 inputs / result |
|---|---|---|
| Open | FS virtual+28 → `825ed4` | x0 FS, x1 File, x2 filename, w3 write, w4 readwrite, w5 synchronous; bool w0 |
| Write | `8258b8` → FS virtual+f8 → `826e04` | wrapper x0 File,x1 borrowed data,w2 U32 length; concrete x0 FS,x1 data,w2 length,x3 File; U32 actual bytes |
| Read | `82586c` → FS virtual+f0 → `826d6c` | same shape as Write, mutable destination; U32 actual bytes |
| Close | `82580c` → FS virtual+e8 → `826ca8` | wrapper x0 File; concrete x0 FS,x1 File; bool w0 |
| Sync | dirty File → FS virtual+128 → `82721c` | x0 FS,x1 File; bool from actual fsync result |

Open write arm uses O_CLOEXEC|O_WRONLY|O_CREAT|O_TRUNC = 0x80241, mode0600; the synchronous argument adds 0x10000. No O_EXCL in this path. Readwrite read arm is O_CLOEXEC|O_RDWR; read-only arm is O_CLOEXEC|O_RDONLY. Read/write errno failures fold to return0; positive values are actual byte counts, so zero read is not independently verified EOF. `82580c` clears the open byte before dispatch, preventing the dtor's second native Close. Concrete Close checks dirty→fsync and close, and returns false if either fails. It cannot prove directory publication durability.

## Implemented checked boundary and remaining binding

Own `tools/firmware/f3_save_transaction_01/transaction.{c,h}` separates verified JPEG completion from RAW deletion. Forty meaningful host groups passed normal and ASan+UBSan; an AArch64 relocatable object was compiled, 4920 bytes, SHA256 `14fae1d7baf71858b155d7f4880c06d9e204af3174cc964679f287b3b9bda503`, with no undefined imports. Tests include short write, short read, corruption, inode/length change, each phase's failure/unknown, manual old-IIQ retention, invalid source/dimensions/EOI, and the shared hold refusing the next capture. These are own synthetic files/bytes, not camera acceptance or entropy decoding.

The exact native filesystem adapters still need actual storage owner/path/card-epoch verification, durable full-RAW stage identity, exclusive create, held actual fd/stat readback, non-replacing publication and checked directory sync, and deletion restricted to a new private stage created by this capture. Unknown removal must not be reported as known RAW retained. No catalogue index, filename guess, or native JPEG bool meets these contracts. The full-RAW renderer/capacity binding is separate: current original shared RGB24 storage is 2×3840² buffers and cannot hold 14204×10652 RGB24. This boundary accepts complete encoded bytes, not a thumbnail enlarged to requested SOF dimensions.

For Root's streaming RGB32→JPEG encoder, a separate begin/write/finish completion contract is required: successful joined-row encoding and encoder finish, incremental encoded hash/SOF/EOI/length, checked Close, complete independent readback hash, then publish/remove. No existing span API may be falsely labelled streaming; transaction02 implements that next increment without changing this freeze.
