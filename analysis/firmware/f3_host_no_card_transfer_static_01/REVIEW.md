# No-card Host RAW / Capture One IQP contract, static revision 01

Finite read-only review; no device/SDK/Windows access and no executable loaded
or run. Stock User: 11,874,544 bytes,
`9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`.
Local Capture One **16.7.7.19** framework: 30,528,080 bytes,
`bfda616e927594f2a316c0d051fdd1c4003bbb4cb5986b15b1abf9965c21a3f2`.
Capture One addresses below belong only to its arm64 Mach-O slice (whole-file
offset 15,925,248), not the camera. `EXACT.json` provides original function
bytes/file offsets/hashes/disassembly, vtables/strings and SDK header identities.

## Positive complete RAW route

The camera has a separate **IqpStorageDevice** Host consumer, without requiring
SD/XQD RAW storage to finish first:

| Original User location | Positive evidence |
| --- | --- |
| Main `425344..4253d0` | Allocates 0x300; uses context array element 0; calls ctor `8ddd54` at `4253ac`; stores consumer element 0 and calls native Start `411b78`. Name `9f5cc0` is `IqpStorage`. |
| `8ddd54..8ddf0c` | Primary VT `dbb8f0`, RTTI `16IqpStorageDevice`. Saves metadata at `+1b8/+1c0/+1c8`, link interfaces `+1e8/+1f0`, corresponding original transfer FS objects `+2f0/+2f8`. |
| `8de084..8de114` | VT+30 FS getter checks second link VT+40 boolean, then first link; returns corresponding original FS or null, without an SD/XQD root. Physical USB/Ethernet designation is not established by this window. |
| `8de400..8de510` | VT+40 native task saves actual node at `+1d0`; rejects absent/paused link; calls Store at `8de4b8`, format `dbb8d0 = P%07u.IIQ`. Success/failure uses original status/retry behavior. |
| `8dcf98..8dd534` | Constructs writer `7d8e30`, opens `7d8928`, writes metadata `7d8a78`, supplies actual RAW source `7d8ac0`, writes image payload `7d8bc8`, finishes `7d8c10`, and **checks Close** `7d8a38` at `8dd440`. Only then returns true. |

Store `8de4b8` arguments are exactly `x0=IqpStorage this, x1=actual RAW node,
x2=selected original transfer FS, x3/x4/x5=constructor metadata dependencies,
x6=P%07u.IIQ`. This is a future native hook boundary, not a new hook or Host
JPEG consumer implemented here.

`8dd004 -> 4951ec -> 495094` supplies the metadata handle;
`8dd020 -> 495204; 8dd02c -> 4952b8 -> 4950ac` supplies the RAW source object,
passed to `7d8ac0` at `8dd23c`. Writer `8dd350` takes native source `+10` data and
`+4/+8` dimensions via the native node handle. These are complete-capture inputs,
not LV/thumbnail data. No arbitrary pointer is declared a decoded plane, regular
POSIX FD or independent lease; original native handles/task cleanup remain required.

Separately frozen `f3_native_fanout_mask_review_01` proves context weights:
Host **1**, XQD **2**, SD **4**. Original selection/weighted reference accounting
decides actual consumers. Host flag 1 is genuine IIQ membership/result, not a
JPEG capability. No new flags are set here.

## Real native transfer FS, with native-thread waits

Handler ctor `85ec00` installs VT `da37c0` and embedded FS at `handler+6c0`,
VT `da3988`. Dispatcher `85f2d0..85f438` handles class **68**: type 1 status,
2 enable `85f438`, 3 Host storage capacity `85f4b4`, 4 request-image `85f51c`
(last body not fully reviewed). Enable reads Common+10 U8 into `+718`; capacity
reads Common+10 U32 into `+71c`. This is IQP, not PTP ObjectFormat.

* Open FS VT+28 `860358` adjusts this by `-6c0` then enters `85fd44`:
  `(whole handler, File*, name, CreateAlways, ReadWrite, direct)`.
  CreateAlways/ReadWrite must be true, original link VT+40 true, `+718` enabled,
  `+738` not busy, and `+8f4` state admissible. Stores **borrowed** name at `+8e8`,
  enters state 1, uses native current thread `710b0c`, Listener `710524`/wait
  `713a18`; binds File generation `+958`, returns true only at state **2**.
  This does not prove plain pthread/UI-safe synchronous invocation.
* Whole-handler Write `860360`: `(handler, borrowed buffer, U32 count, File*)`.
  Requires state 2 and matching File generation; checks declared capacity,
  stores pending count `+95c` and **borrowed** pointer `+968`, then native waits.
  Retain exact bytes through completion. Exceeding capacity causes original
  abort/error, not accepted implicit growth.
* File Close `82580c` calls FS VT+e8 `86116c`, then `861098 -> 8611ac(...,true)`.
  It checks generation/state/busy, enters state **3**, notifies handler VT+50,
  waits, resets state/increments generation, returns true only when completed
  state was **4** (`861534..861568`). Normal timeout 180,000ms; original debug
  flag may select indefinite wait. Link loss/timeout cannot be treated as save.

PrepareOutgoingTransfer `85f994` returns original name and `+8f0` announced
capacity at state 1/2. Capacity is not independently final file length. The
native endpoint writes file bytes, but the reviewed **Host task produces IIQ**.
A general filesystem interface does not prove JPEG filename/capability admission.

## Capture One full receive / opaque save / RAW parser boundary

DataBegin `3c7b24` expects class **02/type01**, 0x38 header: filename length
Common+30 U16, transfer ID +14 U32, announced size +20 U64 (must fit U32), timeout
+2c U32. Receive enable/state must admit it. DataEnd `3c8108` expects **02/type02**,
0x20 header: ID Common+10 must match; +18 U64 must equal **actual received bytes**
`agent+2c1c` before completed state 3 (`3c8220..3c8240`). No packet is generated.

DeliverThread `3c57c8` holds BufferPtr/name while calling registered receiver
at `3c59a0..3c59bc` with actual package ID, data, count, filename. Camera
ImageReceiver `381a88` sends enum type 1 only to LV. Other types require nonnull,
nonzero file data and construct IQP CaptureImage with the received name. It
allocates the complete received length, `memcpy`s **exactly that length**
(`382034..3820a4`), calls Finalize and appends the capture object to its image list.
No JPEG ObjectFormat branch is present in this examined complete-capture entry.

IQP CaptureImage **SaveToFile `395e2c`** is a positive opaque complete-file save
method: uses `+30` full buffer/`+3c` actual U32 count, opens application-supplied
path in **wb** mode (`87a5ac`), checked `fwrite` every byte in at-most-16MiB blocks,
checked `fclose`. No image parse/resize/IIQ-to-JPEG conversion occurs in this body.
It does not prove the application actually chooses to save a JPEG capture object.

Finalize `3970b8` calls RawCaptureImage Attach/InitializeTags/thumbnail/properties.
RAW TIFF parser `3e1e70` requires **49 49 2a 00**, rejects JPEG FF D8 and unsupported
big-endian TIFF. This is a **metadata parser** constraint. Finalize also has
catch/recovery edges `3972a4..3972d4 -> 397144` and `3972e0..397310 -> 39713c`.
Exact exception type/call-site LSDA mapping and application save policy remain
unclosed. Therefore neither “Capture One definitely saves IQP JPEG” nor “RAW
metadata parse failure prevents every opaque save” is proved. The actual native
sender reviewed above produces an IIQ, so it satisfies the positive normal route.

Correction: property **012f0008** at `39745c/397460` is
**kCaptureImageProperty_TetherConnection**, proved by pair `9c5720` and UTF-32LE
name `79d29c`. Value 20 is **not RAW/JPEG ObjectFormat evidence**. Capture One's
PTP JPEG ObjectFormat table is a separate namespace and proves no IQ4 IQP endpoint.

Vendor SDK complete-capture contract describes IIQ (`P1CameraCamera.hpp:48`),
receiving prerequisite (`246`) and Host capacity (`267..283`). Its whole-image
interface and DeviceMask (`C_P1CameraCommonStructs.h:460..520`) define Host bit 1
and separate SD/XQD JPEG bits, no Host JPEG bit. This proves the public contract,
not absence of every private endpoint.

## Exact remaining implementation / acceptance gaps

1. Native no-card **complete RAW** path exists; reuse original selected transfer
   FS, native task/handles and checks. Actual Capture One no-card full-IIQ save
   with whole-file identity remains a separate sole-controller test.
2. Current card JPEG producer does not implement Host JPEG. Never turn flag 1
   into JPEG or suppress/discard RAW before an actual complete JPEG send/save.
3. Current full-R0 renderer needs approximately **2,964,893,952 bytes** as a lower
   bound plus encoded RAW/source reservations and uses exclusive card-backed
   scratch. Independent Reader requires a real held regular FD. Original RAW
   handles are valid native IIQ Store inputs, not yet that saved-file source API.
   Complete RAM source/resource binding is owned by the parallel narrow audit.
4. New JPEG transfer must close native name/capacity/Write/Close ownership, retain
   raw lifetime, then prove actual Capture One filename/admission/full decode.
   RAW+JPEG means two completed objects, not relabeled IIQ. PTP capability,
   preview, thumbnail, host export or software flags cannot substitute.

Reproduce static collection with `python3
analysis/firmware/f3_host_no_card_transfer_static_01/collect.py`, requiring exact
local vendor framework. `validate.py` checks frozen members and original window
bytes without running either executable.
