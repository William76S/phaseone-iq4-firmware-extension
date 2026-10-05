# F3 native File Settings menu 04

This derivative replaces menu03's permanently disabled inspection stub with a
real linked production request route. It does not produce a firmware package
or claim that capture/export has passed on the camera.

Exact stock User is `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`.
The original BL `4f0d34 ->4e58b8` (old LE `e1d2ff97`, return `4f0d38`) is
forwarded once before the owned menu is appended. It receives actual File
Settings SubMenu VT `b8f9b8`, title391. Kernel self-read verifies the real
UiIQ4Configurator current thread, manager reciprocal chain, intact stock
vtable/call windows and parent child-list. It never treats a property-enum
proxy as a SubMenu. No F1/Grid/LV/crop/native card configuration is changed.

The owned `Capture Output` menu contains RAW/JPEG/RAW+JPEG (modes0/2/1), six
JPEG dimensions Full/75%/50%/25%/long3840/long7680, quality1..100, and actual
`Export selected RAW`, `Export status`, `Output size`. Cloned native SubMenu
and EventItem headers/RTTI and VT+70 remain untouched. Original Navigator
handles setting leaf activation; manual export returns0 to retain the page.
No new GUI, Back hook, timer or fake capture enum is introduced.

Settings use one packed atomic word. `iq4_f3_settings_snapshot_04` captures
mode/size/quality with one atomic load. The actual capture producer must take
this once; there is no late settings change in an already-owned job. RAW-only
preserves the stock RAW path and does not wait for JPEG activity or geometry.
Settings callbacks reject changes during JPEG/Movie/Hold activity. Public
percentage dimensions use nearest per axis; full export uses complete RAW,
not a thumbnail. These selections alone do not establish source/file safety.

Manual action reads the actual IFM BackgroundThread's selected integer using
its native mutex getter, reserves shared JPEG activity, calls the real
coordinator06's short UI catalog snapshot and submits one immutable task to
executor01. All source/card/Reader/native render/publish work executes on the
original IFM background thread. Manual always retains the existing RAW,
regardless capture-output selection. Coordinator status/dimensions and
published flag are read through its real atomic view; no synthetic success,
capability or fixed-size claim is rendered.

The actual coordinator factory must be installed before original FileSettings
construction reaches this once-only hook. Runtime `ready_06` is the real
installed function-table/linked-ELF state, not an enable boolean. Factory
registration must not initialize a native pool or acquire a card before the
native background task. Root owns exact final ELF import/version/CFI/LSDA and
actual producer integration; the UI itself supplies no positive vendor proof.
Known preparation rejection without an owned job cancels the reservation and
may be retried. Unknown preparation, submission or notification permanently
holds the executor/activity; no retry, cancel, kill or hot free is provided.
A completed task mailbox can be reused only after its actual callback fence
and activity release. Native heap/append failure retains partial objects and
forbids a second install during that boot.

Build (fresh local output; target never executed):

```
python3 tools/firmware/f3_capture_menu_04/build.py --output analysis/firmware/FRESH_F3_MENU_BUILD
```

27 meaningful synthetic runs per normal/ASan+UBSan/TSan variant cover native
vtable/VT+70 preservation, actual request arguments/sequence, reservation
refusal, callback fence, immutable settings, shared Movie exclusion, quality
bounds, all six sizes, partial native allocations and unknown ownership.
Three AArch64 ET_REL objects are produced: policy, menu, wrapper. Link exactly
one policy implementation; do not also link frozen menu03/policy.o. Existing
export_geometry is a separate shared dependency, not duplicated here.
Actual source/card/render/output acceptance remains outstanding.
