# IQ4 6.03.18 User-only package route — static increment 01

This phase provides a host package generator and closes the exact User updater
consumer. **No modified package has been offered to or accepted by the camera;
there is no patched F1 User payload or persistent F1 acceptance.** All addresses
below belong only to User SHA
`9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`
(11,874,544 bytes, AArch64 ET_EXEC). Complete functions, bytes, file offsets and
hashes are in `firmware_package_acceptance_static_01/evidence/exact_bytes.json`.
Nearest exported objdump labels are not names or inferred prototypes of private
functions. Function roles below come from calls, field access and exact bodies.

The original FWR is 78,351,289 bytes/SHA
`a52758ffb163023e5323297e450450f91002175b69bed7590fe2cd037c2ab300`.
It is ZIP20, flags zero, no archive comment, correct CRCs. Original manifest is
2,742 bytes/SHA
`2c459e434b14e86c1b8b1d4277f5902d6252c86482debff96b7b6bfc6e251be4`.
Its release is `6.03.18`, LinuxApp is `6.03.21`, model IDs
`0x125,0x126,0x122`, hardware revisions `1,2,3`, minimum update `2.00.14`.
Container CRC is distinct from cryptographic authentication.

## Positive acceptance path and its bounds

| Exact complete User function | Positive consumer evidence |
|---|---|
| `0x769e94–0x76a0ac`, `0x76a0ac–0x76a2b0` | Distinct FWR/FWP preparation, extension and buffer/state setup. |
| `0x7553cc–0x755fb8` | FWR event/state dispatcher: manifest parse then install mode, minimum version, hardware/model match, component plan, nonzero selected count/buffer and upgrade mode before install. A disk request can automatically proceed; a completed transfer is not a read-only validation probe. |
| `0x756968–0x756ae8`, `0x764764–0x76495c`, `0x764fac–0x765368` | Extracts `manifest.xml`, allocates size+1 and appends NUL. Requires XML declaration and a parseable `release`. Parses target/minimum/version fields and only the supplied component children. Adds a Manifest component automatically from its known filename. There is no requirement here to supply all 20 stock ZIP members. |
| `0x765604–0x76573c`, `0x76573c–0x765864`, `0x765a18–0x765b5c` | Parses component type plus firmware filename/version/optional selectors. A filename is copied into a 64-byte field; version is represented as U8/U8/U16. |
| `0x756ae8–0x756bc4` | Updater `+0xa133` is the install-as-Factory configuration value; target-User `+0xa132` is its inverse. Full mode `+0xa134` is true if current-User `+0xa130` is false or install-as-Factory is true. This is a real mode branch, not a host evidence boolean. |
| `0x7573bc–0x757890` | Builds only supplied eligible components, size/selector checks, then version/signature decisions. A full install with no selected Boot component is rejected. Partial User→User does not require Boot here. |
| `0x758c58–0x7591c8` | LinuxApp type 3 maps in User mode to destination FileId 6, signature FileId 5, folder 4; Manifest type 1 maps to destination/signature FileId 4, folder 4. Factory uses different IDs/folder. |
| `0x75c198–0x75c27c`, `0x75c27c–0x75c544` | Decompress into owned buffer, open destination through FileSystem VT+0x28 with `w3=1,w4=1,w5=0`, write the complete declared component byte count, require exact returned count, close and invalidate folder cache, then generate component signature. It stages `User/p1linux.bin`, not the active executable directly. |

Fixed file records at `0xf55fe0`, `0xf56030`, `0xf56058` bind `manifest.xml`,
`p1linux`, `p1linux.bin`; folder 4's record/path binds
`/run/media/storage/User/`. These are compiled aliases, not measurements of the
current canonical runtime path. Root separately accepted a read-only canonical
`/mnt/qspi/User/p1linux` identity with stock whole SHA; that does not establish a
complete device-original backup or an independent recovery entry.

The packaged runner `/p1/scripts/boot_run_p1linux.sh`, whole SHA
`fe57b899f3a583e1058e4e856cf80704d902d6989b802154d02e77bc93305e88`,
lines 98–122 detects `p1linux.bin`: a gzip body is decompressed over `p1linux`,
synced, removed and synced; an uncompressed body is moved over it and synced,
then chmod +x. This happens before starting the app. The generator emits raw ELF
bytes as the LinuxApp component. The runner evidence is the packaged rootfs,
**not the actual runner original/restore receipt**, and multi-file update is not
atomic or already proved recoverable under power loss.

## Same-version skip and ComponentSignature

`0x759afc–0x75a1fc` checks the installed destination/signature/current disk MD5
and installed/new version equality. A valid current signature and matching disk
MD5 plus equal versions returns skip. It does **not** compute the new ZIP payload
MD5 at that decision. Manifest has its own release version; changing app bytes
while retaining both stock versions may skip the app and/or manifest.
`0x5079f0–0x507a20` is exact U32 version equality. The generator requires explicit
newer release and app versions for saved candidates; monotonicity is its host
policy, not an inferred universal device rule or an F1 implementation.

`0x75c544–0x75c6e4` passes decompressed bytes and component `+0x490` size into
`0x7a4c24–0x7a4ed0` (MD5 constants/padding), formats the 16-byte digest as hex via
`0x7a5334–0x7a53c4`, and constructs a record at
`0x75bf3c–0x75bf8c`: file ID, packed version, 33-byte terminated MD5 text.
`0x74ec98–0x74ed78` writes the registered component-signature event through its
native setter. This record is generated by the installer, rather than a package
publisher signature that must be copied from stock. **The closed ordinary
LinuxApp path does not demonstrate a cryptographic signer gate; it also does not
prove that other boot/transport/UI layers or another firmware lack authentication.**
The component-signature events and firmware flag persistence backend are not
fully closed here; no claim that EEPROM is unchanged is made.

## ZIP validation and FWP wrapper

`0x98c630–0x98c8c4` checks local/central/end ZIP framing and bounds.
`0x763520–0x7635e4` resolves member size; `0x7635e4–0x7636a0` calls extraction
`0x98ca6c–0x98ccd8`. The latter opens memory ZIP, locates the name, verifies
destination capacity against uncompressed size and calls minizip read. A negative
signed read result fails; positive bytes are its result. It calls
`0x9d909c–0x9d9198`, which compares computed/header CRC on fully consumed
non-raw files and returns -105 on mismatch, **but this extraction caller ignores
the close return** (`0x98ccbc–0x98cccc`). This bounded observation is not used to
bypass CRC; all generated member CRCs and full bytes are checked on the host.
ZIP32/U32 and positive signed extractor results are representability bounds;
the real target free-memory budget and supported largest payload remain unknown.

FWP is a separate outer ZIP containing `manifest.xml` and the inner FWR, not a
suffix rename. `0x76495c–0x764b6c` parses `system_package` or `system_package2`;
`0x765c5c–0x765e58` and `0x765e58–0x765fd0` consume version/date/minimum and
firmware_package model/hardware/version/minimum/filename.
`0x75e30c–0x75e424` accepts compatible version below 4.
`0x75f5f0–0x75f95c` chooses matching model/hardware/minimum entries;
`0x75f95c–0x76025c` skips absent non-back payloads, and
`0x75efb4–0x75f2c8` extracts the chosen back FWR and feeds the same FirmwareUpdater
events. Other system/group state is also changed. The generator uses outer
compatible version 2 based on these consumers, not a verified original FWP
sample. Additional package-manifest handling and card UI entry are not proved by
that generated ZIP. Card loading a modified candidate has not been tested.

## Installation modifies more than User files

`0x757890–0x757bf8` in non-debug mode writes native install/verification flags
via `0x5de9d8–0x5dea04` and `0x5de938–0x5de964`, then clears the User boot marker
via `0x768de0–0x768ec8`. The marker backend
`0x768f44–0x769364` opens static `/dev/mtd0` (`0xc3e070`) with 0x80002, reads an
erase block, inserts marker bytes, issues ioctls 0x40084d06/0x40084d02 and writes
the entire block. Exact runtime offset/block original and independent restore
have not been demonstrated. After component installation, missing User marker
can be recreated through `0x768cf8–0x768de0`; this check/set is outside the initial
debug branch. Debug mode therefore is **not established as read-only**.
Full mode also removes target folders and may perform other boot operations.

`0x758b30–0x758ba4` RevertToFactory clears User signatures and calls
`0x7689f8–0x768ae8`. That helper clears the User boot marker, resets boot version
events and calls `0x74f74c–0x74f7f0` for folders 15 and 4. Their paths are User
SensorProfiles and the whole User directory; FileManager recursively removes
contents then calls filesystem RemoveFolder VT+0x58. It subsequently changes
firmware flags/reboots. **Revert is destructive to User, not a temporary selector
that preserves a modified or stock User for return.** The separate Boot GPIO
selector evidence does not establish an externally reachable, tested recovery
button; no guessed GPIO/MMIO action is proposed.

## Concrete deliverable and next experiment limits

`tools/firmware/user_only_package_01/package.py` accepts an independently reviewed
payload SHA, builds deterministic two-member FWR and reconstructed FWP, or only
prints a plan by default. Baseline size/layout/hash are separated from candidate
ELF bounds. New LOAD/growth/relocated header are allowed and listed; candidate
version is read from the actual section, while native version use is bound by
`0x752114–0x7522ac` (header +16 U8, +17 U8, +18 U16). ELF host validation is not
an observed updater architecture validator or target runtime proof. Thirteen
in-memory host tests include growth/new LOAD and malformed/CRC/version cases.
No test fixture or candidate target firmware is published or run.

The shortest next useful actual steps remain **read-only backup and recovery
establishment**, not sending an update to "see whether it accepts": complete
actual User bytes/metadata/EOF/whole digest; actual affected manifests and native
flag/signature origins; actual runner originals; then a separately reviewed
marker-block read/restore and an independent recovery entry exercised without
depending on the new User. Only after those receipts, a real F1 binary patch and
separate target binding review can support a finite candidate install/restore
experiment. This phase does not authorize it. It also does not replace the RAM
F1 observation/loading work or call a changed version an implemented mask.

Reproduction: run the collector into a fresh project-local directory and compare
its evidence manifest; run the generator's `validate.py --recollect` for frozen
file hashes, exact function bytes, ZIP20, thirteen host tests and independent
collector reproduction. All private Ghidra pseudocode is excluded from the source
ZIP; the public derivative is bounded exact instruction/data evidence.
