# Native VFR MJPEG writer

`native_mkv.c` is a freestanding C downport of this project's existing
Matroska MJPEG writer. It avoids the desktop libc++ objects found in the
previous AArch64 C++ pool/container build. Only bounded local byte arrays,
checked append/patch ports and the frozen baseline JPEG syntax validator are
used. An existing complete JPEG packet is borrowed synchronously.

The file uses V_MJPEG, TimestampScale=1ns, one keyframe Cluster per supplied
packet, and no nominal FPS or DefaultDuration. It never creates or duplicates
frames. IQ4T Void journal version2 stores the original observed monotonic
completion time and a strictly increasing **local software** identity with
flag2. Neither is a sensor frame counter or sensor exposure timestamp.

`seal` patches only the Segment length. Native owner/epoch, checked fsync and
close, full immutable readback/identity/hash, exclusive rename and directory
sync remain required before success or return-to-factory can be reported.
Unknown writes/patches latch and reject all later muxer I/O. A partial packet
does not increase the completed-frame count.

The recovery scanner reads the original recognizable version2 partial file
read-only. It yields only complete baseline JPEG/CRC/timestamp pairs before a
truncated or corrupted tail. Recovered frames must go to a new exclusive file;
it does not repair or remove the original. Original native C++ v1 recovery
code does not understand version2 local identities and must not be used.

Reproduce with:

```
python3 tools/firmware/build_native_mkv_01.py --output analysis/firmware/native_mkv_new
```

Actual normal/ASan+UBSan host runs each passed 13 file/fault/recovery groups and
33 JPEG geometry checks. The two actual MKVs are byte-identical; ffprobe reads
128×96 MJPEG with time base1/1,000,000,000, and ffmpeg fully decodes three distinct
synthetic frames at0/0.033333333/0.078seconds. This is host-only evidence. Source
LV, native encoding, card publication, real new-frame rate and persistent
camera acceptance remain untested. The camera UI must not advertise1920×1080
or60fps based on this file or a software sequence counter.
