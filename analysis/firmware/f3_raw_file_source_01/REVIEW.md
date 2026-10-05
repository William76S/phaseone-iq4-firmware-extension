# Saved-IIQ source contract, offline revision 01

Original User is the 11874544-byte AArch64 ELF locked by SHA256
`9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`.
`static/EXACT.json` records 31 finite windows, 5035 exact checked instruction
words, 20140 original bytes and 15 independently decoded direct BL targets.
No original firmware function or device has been executed by this work.

The source layer closes an important correctness gap: native success alone does
not prove the complete input. ReadPayload 7d9630 ignores RAW seek's bool; the
general tag read 7daf50 ignores the real stream read return count. Independent
same-held-fd exact pread checks and whole-payload comparisons therefore precede
any source-ready state. Native File layout and actual fd ownership are verified
before using the borrowed descriptor; false close cannot be erased by open=0.

The original CaptureFileReader ctor is 7d92b8, nondeleting destructor 7d9390,
Open 7d9988, Close 7d9ae0, IsOpen 7d95c0, ReadPayload 7d9630 and codec query
7d9710. Its exact 0x62c80 allocation is visible at 424948..424974. CaptureFormat
is embedded at +380a0; raw length is reader+3a56c; inline rows begin at +20.
Container kind is CaptureFormat+d030 and black mode +eaec. Shifted ADD immediates
are decoded as actual offsets, not concatenated textual immediates.

Original BuildTagsFile 7ba364 uses the small tag-map operations but also writes
ICE-relative scratch near +655479a0 and +64b478c8. It cannot be called on a fake
small context. The new adapter uses the actual map ctor/dtor 7bba0c/7bba2c,
index 7bcc64, u32/float/blob assignments 7bb8e0/7bb910/7bb940, and RawInput
ctor/dtor/vector append 7bbac0/7bbafc/7bc7e4. Tag 20c is native +208, not +210
(which is tag104); both parser and BuildTags read windows close that mapping.
Blob assign stores length at +8 and pointer at +10, without a deep copy.
Owned nonmoving WB and externally reserved black/calibration buffers are held
until native worker/generator cleanup. Own native vector rows and map also stay
live; a borrowed input pointer is not a standalone resource lease.

The original worker 7b7550..7b7654 reads tag548 via reader7d9278 and capture
7ca6a8. It selects profile0 if read length is zero or first byte is zero, otherwise
constructs a native std::string and calls generator960b48 before reusing the
large scratch buffer for RAW. The new source keeps this profile section in a
separate exact-read bounded reservation. The real sample's eight profile bytes
are zero; no nonzero profile is silently interpreted as builtin0. Generator
profile parsing and sRGB binding remain a next layer, not a source claim.

The real saved IIQ is 161346810 bytes, SHA256
`f12f094ce1425d7162bcd07633971aaa637f3172e3d2a46c97c6613b9d2f53a7`.
The TIFF thumbnail is 640x480, whereas the selected IIQ full RAW section is
159899952 bytes at absolute offset512, codec8, total14308x10760 and valid crop
(102,106,14204,10652). Its 43040-byte row table has 10760 strictly increasing
entries 0..159889516. Calib tag110 is 354380 bytes. These metadata and whole
encoded bytes pass this layer under host native-function mocks; original vendor
decode and target full-pixel completion remain untested.

Memory planning must use total Bayer14308x10760. A 32-byte-aligned 16-bit Bayer
plane consumes 308166400 bytes, exceeding the conditional crop-based estimate
in the previous frozen plan. The static observed full/75% two RGB16 intermediates
need 1816123392 bytes and RGB32+planar need 756718080 bytes. Adding full Bayer and
the generator's80MiB prefix yields at least2964893952 bytes. Half native output
gives at least1035262848 bytes. These are lower bounds, not verified upper bounds;
encodedRAW159899952, reader404608, calibration, map nodes, profile data and worker
jobs live outside or in addition to those figures. Individual CIB byte fields
use signed32 arithmetic; the generator receives external base and uint64 capacity.
No static memory-kind restriction was found for that base, but file-backed mmap
page faults, storage exhaustion during native access, worker behavior and target
performance have not been measured. Thread stripe loops do not imply low-memory
tile rendering. Full R0 path and exact later output resize are separate work.

Normal62 groups and ASan/UBSan62 groups passed; both target ET_REL units built
twice with identical bytes. Host mocks are named as such in validation JSON.
No firmware patch, FWP, installation, card write, camera test or persistent
function acceptance is produced by this source-stage freeze.
