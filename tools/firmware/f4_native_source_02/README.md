# Native LV recording source, worker and entry 02

This is concrete, version-bound in-process source and an entry point for the
original LiveView Settings menu. It is not a camera test result. No target
executable, SDK or camera was run while producing this increment. Existing
versions are unchanged. Linux/AArch64 production calls are available after
actual immutable-byte, original UI owner, live-client, lease and card checks;
there is no permanently disabled port or fabricated capability receipt.

`iq4_f4_native_menu_entry_02(selector, root, 0x4eea5c, 10)` installs the owned
`LV Recording` submenu and lazy production coordinator at the existing
`0x4eea58` SetMenu callsite. Root must combine this with F1 in one wrapper and
call the original `0x4fb364` once. Default ID10 is SD, ID11 is XQD. The Card
leaf changes only recording destination, in Idle; photographic card settings
are not changed. Both Card06 IDs are the selected ID, deduplicating one native
register/request/release. The unselected card need not be mounted or ready.

The first Start allocates two 8MiB owned RGB slots, one bounded 16MiB JPEG
packet, independent 64KiB hash scratch, native event/observer and coordinator.
All are retained for the process lifetime, including partial allocation or
unknown failure. No allocation, encoding, card IO or wait occurs under the
original source lock. Admission never changes original LV configuration.

The actual UI owner chain is native-current `b91f48` Configurator -> manager
`+1c8`, UiData `+9b8`, LV `+8c0`, UiData `+118`/LV `+108` RGB access -> engine.
Source binds the engine frame event `+640`. Observer registration is checked
as the exact event/queue/observer triple under the original recursive mutex.
The native access methods are Lock6b618c, Size6b61fc, ID6b62c0, Unlock6b6250.
Bank state `engine+2170` must expose a valid locked slot, matching pointer,
dimensions, ID and configured capacity. The four `component_map` words are
opaque native bank-mapping configuration, not color-channel provenance.
Original format0/3-component LV consumes tightly packed 3*W rows. Mode is
actual W/H, never an upscaled 1080p claim or a fixed-rate request.

Every successful borrow is copied into one preallocated owned slot and paired
with a verified original unlock before publication to the SPSC worker. UI
retained leases are never stolen or unlocked. Duplicate/stale completion IDs,
queue full, invalid layout/capacity and nonmonotonic observation clocks are
counted/rejected. ID is an original software completion ID; monotonic time is
when this UI observer sampled completion, not sensor exposure/capture time.
This source does not establish sensor FPS or prove distinct optical content.

The ordinary worker is created once with original pthread_create PLT40a220;
its private futex waits/wakes use AArch64 Linux syscall98. It never masquerades
as a native CThread. Native card request/poll/release stays on actual UI.
The worker receives only owned RGB, calls the real JPEG82 binder and bounded
RGB24 codec, releases its RGB slot before writing a complete JPEG packet, then
writes Root's native VFR MJPEG Matroska into Movie01. It never uses a display
Surface or compositor/mask pixels. Native display RGB interpretation is the
input contract; no new sRGB calibration or RAW LUT metadata is asserted.

Start -> asynchronous native request/poll -> worker opens exclusive part and
binds JPEG82 -> fresh same-mode UI sample -> admission/Recording. Stop and
Back stop admission, detach the exact frame listener, drain queued/current
owned frames, and let the same persistent worker finalize serially. Movie01
seals once, syncs/closes, hashes/scans the whole file, then publishes no-replace
and syncs the directory. Worker closes held dirs, then actual UI releases the
native requests once. A normal zero-frame cancel preserves/abandons its part
without claiming a published movie. Unknown keeps every owner, without
retry, repair, kill, forced release or unload.

Worker ControlEvent notifications use the explicit registered UI queue, not
the sender's native TLS. Listener710820 -> queue713c6c protects its pending
list and calls original condition_variable.notify_all40ad80. Debug tracing
may read nativeCurrentThread but records its pointer without dereferencing it.
Owned event log level is zero in native constructor70f180. The full static
chain is recorded in `analysis/firmware/f4_native_source_02/static/EXACT.json`.
The worker posts control every200ms while preparing/recording/stopping, so a
normal page departure requests Stop even if LV emits no further frame.

Dedicated Stop and Exit waits for actual source fence, files closed/published
or known empty cancellation, and original card release before original selector
Close4e1320. Normal native Back uses the new BL4fb454 wrapper. For the owned
recording page it requests Stop before one original Pop. Every other page and
unknown read inspection uses original Pop with unchanged exception propagation;
only a positively owned recording page has an exception-to-Hold barrier.

The persistent worker normally stays asleep in Idle. Whole-thread shutdown has
an actual returned cookie and original pthread_join PLT40a8c0, called by a
non-UI reaper; UI never waits/joins. Source/event/menu memory remains retained;
source fence and serial finalizer do not claim safe hot-dlclose or OS join.

Build from project root into a fresh directory:

```sh
python3 tools/firmware/f4_native_source_02/build.py --output analysis/firmware/f4_native_source_build_02_reproduction
python3 tools/firmware/f4_native_source_02/freeze.py --verify
```

The build runs only synthetic own host functions and emits 9 AArch64 ET_REL
objects, preserving synchronous unwind. Frozen `LINK_INPUT.json` binds the
actual object identities and dependency versions. No raw SO is appended.
Root's ELF backend must relocate allocated sections and merge EH metadata.

Actual hardware remains to verify: source notifications/borrow/unlock, pixel
layout/color, measured mode/time/drop data, one-card requests and held root,
real encode/card throughput, native menu/Back/StopExit, file publication and
error/power recovery. Successful static binding and host tests are not those
receipts. No 1920x1080/60fps or completed installed recording is claimed.
