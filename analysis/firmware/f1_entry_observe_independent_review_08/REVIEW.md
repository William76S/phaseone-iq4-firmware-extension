# Independent Observe08 / Loader08 review

The finite new runtime and loader identities are consistent. This is a static
source/actual-ELF review, not an installation or hardware approval. No old or
new build, SDK, Windows, network or target module was executed. `collect.py`
verified all 473 Observe08 reference rows; `collect_loader.py` verified all 525
final Loader08 rows. The original 41 loader host controls were read, not rerun.

Observe08 SOURCE is `88000455d0116e075aa6be69476508cc3d1a4b6bb4cefa4365ba034c18652d52`.
The authenticated LOAD_SO is 97,000 bytes, SHA
`e569a6c391a4e3d37439d32f774f74dede3c1863d751250d2939abfaaa935f99`.
Its ET_DYN/AArch64 dynsym has the expected nine exports and exact undefined
symbol set. The publication `iq4_f1_normal_fit_ingress_observed_08` is VA
287208, size 496, wholly file-backed in one RW LOAD. Actual stripped/unstripped
dynsym and program headers match, and the linked unlock body is byte equal.
The authenticated init array remains `prepare` then `role_constructor`.

The runtime change adds one concrete `UI08Bridge` and one caller after the
original unlock and real Module/Entry07 boundary. `runtime_linux.cpp:186` calls
the original unlock once; `:184–187` preserves incoming and original errno;
`:188–193` filters original LR `0x6be8ac`/result/TLS/recursion before own work;
`:233–235` calls UI08. Linked body VA0x23238 has its sole original-pointer
`blr x22` at0x23298, errno restore/save at0x23290/0x232a0, return restore at
0x238c4, and UI08 call at0x23824. Unsupported provider resolution retains the
inherited Hold behavior; default OFF is not a promise that a loaded interposer
can never stall on a mismatched libpthread.

OFF has two boundaries. No `IQ4_F1_MODULE_ENTRY_01=OBSERVE` leaves constructor
diagnostics dormant (`runtime_linux.cpp:161`). Actual entry admission also
requires authenticated role status4 and the exact root-owned0700 directory /
0600 single-link `ui08.entry` (`:142–155`); UI07 markers cannot satisfy it.
Once admitted, the inherited Entry07 binder can construct and attach its own
button, popup, menu items and six queued event subscriptions. Therefore this
stage includes finite UI/registry mutations. It does not replace toolbar tags1/8
or the embedded stock popup. `UI_entry_installation_authorized` is separate
from `native_pixel_write_authorized` in final Loader08 staging metadata.

`integration.hpp:8–13` waits for Entry07 Ready, installs the selection consumer,
binds the actual observed owner, and samples only provider/Surface scalar
candidates. `provider.cpp:20–42` reads manager+0x108, pointer/VT/getter/present
instruction candidates, derived inline Surface, bounds and LV scale/pan cache.
It never calls those unknown getter/present targets. It does not gather a
full source rectangle, actual blit, frame sequence, clean pixels or Surface
lease. `Renderer::select` (`normal_fit.cpp:60–62`) rejects each non-Off ratio
while actual geometry is unknown. The Observe runtime never configures the
provider contract, installs a text hook, issues a PaintToken or calls a fill.
The production scaler/render-issuer bodies were collected from this SO; their
separate frozen ET_REL existence cannot count as loaded mask implementation.

Final Loader08 SOURCE is 102,141 bytes, SHA
`10a9e1c48081ebbb4b77c8cc2d768e7e8183ed55aab3c38ea4c0d2e73e3fa3be`.
The C launcher/restorer body differs from Loader07 only in `ui08.entry` and the
constructor-status schema v8; copied-reader lifetime/map checks differ only in
their schema v8. Preview remains F4_ENABLED0. The previously observed104-byte
plan metadata was corrected before freeze: `bind_stage_identity` now pins the
actual new SO, 97,000 bytes, exact symbol, relative VA287208 and496-byte extent.
Both preview config and target decoder-layout assertions use496.

`entry_read.inc:15–42` requires fixed module path/device/inode/private maps and
the actual LOAD VA/file-offset relation. `:48–59` reads only that publication:
two complete496-byte copies bracketed by matching even sequence, PID/startticks,
User identity, module file identity/hash and second map/address verification.
The decoder requires exact scalar-only results and zero native-return/raw,
paint, geometry-epoch and source claims. This copied-read provenance still
requires Root's held actual receipt; decoder success alone is not hardware
authentication or a new-frame/FPS measurement.

`entry.c:110–116` restores by rename of the saved original inode, then fsync
and original inode/hash readback. `launch():231–251` performs restoration before
parent/old-PID/env checks and before either exec. The preload failure fallback
uses the saved original environment; the independent supervisor/disable route
does not signal User and does not claim module unload. Registry objects and
the SO remain retained until original User exit. Actual original runner double
copies, RAM/mount identity, stock respawn/cold recovery, protected input/placement,
quiescence and source/owner receipts remain required; this review creates none.

Remaining finite risks are explicit: original libpthread and User mappings must
match the fixed hashes/ABI; C++ exception imports rely on the stock loaded
runtime (ELF DT_NEEDED names only libc/libpthread, so package export availability
alone is insufficient); UI placement and lifecycle/forwarding need the actual
single-owner run; the copied publication's scalar snapshots establish neither
full-source coverage nor buffer lifetime. The current old SDK Hold must not be
cancelled, bypassed or treated as a fresh epoch by this module/loader review.
No mask paint or persistent F1 acceptance is claimed.
