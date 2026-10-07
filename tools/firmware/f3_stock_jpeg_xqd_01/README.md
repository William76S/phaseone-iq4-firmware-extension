# Stock JPEG destination bridge, revision 01

Reuses the single original JPEG worker, original IFM Thumbnail/4K RGB images,
original encoder (quality **90**), original Off/New Images/All Images/Size
properties, and each card's original requester/filesystem. Destination selects
SD (10) or XQD (11). RAW capture, compression, saving and deletion remain native.
This first stage is **Thumbnail/4K only**, not full resolution or JPEG-only.

Exact original User: `P1Linux_6.03.21.bin`, 11874544 bytes,
SHA256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`.
`collect.py` binds seven original BL words; `pins.h` excludes those hook words.
GUI and the flag16-only catalog filesystem/path selectors are separate components.
The selector component is required for XQD catalog rescan; do not link this alone.

The stock worker retains card requests across pending images. Destination remains
on the selected task fields across those jobs, and changes only when its own
requests are clear. A separate output client shares the native XQDWrite owner
with its native source client. Actual original A64 requester execution shows
client masks 1→3→2→0 with a ready=1 event fixture; it does not wait for source to
release before accepting the output client.

A destination change obtains its selected native card request, verifies actual
mounted root identity, then uses original catalog clear(bit16 only) and .JPG scan
on original paths. SD RAW flag4 and XQD RAW flag2 keep their original selectors.
Original New/All pending100 scheduling and native directory scope remain intact;
changing destination is not a promise to export every old RAW or every DCIM folder.
A loaded XQD destination refreshes its catalog before its first JPEG job.

The original writer always returned true, even after failure. The bridge instead
checks encoder bytes/JPEG boundaries, resolves its relative name with the original
LinuxFilesystem resolver, stages with O_EXCL, writes/syncs/closes, and publishes
with Linux renameat2(RENAME_NOREPLACE). Any failure is withheld from native done16.
Existing files are not truncated; unknown close/card/commit state pauses this
extension and retains evidence rather than guessing cleanup. Hardware support for
renameat2 on the actual card filesystem is still untested.

Destination alone uses a separate checked atomic `/mnt/qspi/iq4-stock-jpeg.cfg`
namespace with its own magic and backup. Native Mode/Size use original setters.
No EEPROM, security, keys, calibration, RAW style metadata or boot scripts change.

Reproduce: `python3 tools/firmware/f3_stock_jpeg_xqd_01/build.py`, then `freeze.py`.
Evidence: `analysis/firmware/f3_stock_jpeg_xqd_01/EXACT.json`, requester/filesystem
A64 receipts, and build/COMMANDS.json. Focused host cases cover SD absent and
inactive SD disabled, XQD routing, retained jobs, native unwind, failed publish,
existing-file collision, ENOSPC, fsync failure and close/card uncertainty.
External event/OS fixtures are named in receipts. No camera was controlled; these
are static/host/A64 emulation results, not temporary or persistent camera acceptance.
