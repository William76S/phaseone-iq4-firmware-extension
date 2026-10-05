# Firmware information Date — exact original release-manifest chain

The firmware information **Date** row is supplied by the installed inner
`manifest.xml` release's `release_date` attribute. The closed original consumer
maps `2026-10-05` to the display string **05.10.2026**. The outer FWP
`system_package@date` is parsed into another package record; it is not the field
read by this Date row. No RTC fallback or ImageHeader compiler date needs to be
patched for this route.

All addresses below refer only to the original AArch64 User ELF,
11,874,544 bytes, SHA256
`9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`.
`EXACT.json` contains original bytes, SHA256 and ELF LOAD-based file offsets.
Function names describe recovered roles, not the nearest objdump symbol label.

| Original byte window | Closed dataflow |
|---|---|
| `0x41c5d0–0x41c658`, `0x751b2c–0x751b70` | Main constructs the firmware-manager object with the mode flag in `w1`; the constructor preserves that flag at `this+0` and `sp+0x47`. |
| `0x751cb4–0x751d1c` | Constructs two installed manifest records. The same flag chooses `this+0x9a18` or `this+0x2e9c8` and stores the selected record address at `this+0x53978`. |
| `0x751e24–0x751efc` | Flag-true path loads internal FileId 4 into `this+0x9a18`; flag-false path loads FileId 14 into `this+0x2e9c8`. Exact fixed records bind FileId 4 to User `manifest.xml`/folder 4 and FileId 14 to Factory `manifest.xml`/folder 5. |
| `0x753464–0x75365c` | Resolves that FileId's native filesystem and basename, reads the exact declared file size into a terminated owned buffer, then calls `0x764b6c` with the installed record as `x3`. |
| `0x764b6c–0x764d1c` | Parses installed XML, selects `release` (`0xc3dd40`) and passes **installed-record + 8** as `x2` to `0x765368`. |
| `0x765368–0x765604` | At `0x765478–0x7654ac`, gets attribute `release_date` (`0xc3de90`), passes destination **record-body + 0x47c** to date parser `0x7661bc`. Thus the actual destination is installed-record **+0x484/+0x488/+0x48c**. |
| `0x7661bc–0x7663a8` | Parses three decimal components separated by `-`, requires string termination, and writes year/month/day at output `+0/+4/+8`. This parser does not establish calendar-validity checks; wrapper03 separately validates the supplied ISO calendar date. |
| `0x751fd4–0x752030` | Reads active installed record `+0x48c/+0x488/+0x484` as day/month/year and calls `sprintf` with `%02u.%02u.%04u` (`0xc37830`), output `this+0x539b4`. |
| `0x752368–0x752388`, `0x504620–0x504650` | Getter returns `this+0x539b4`; firmware UI reads owner at `this+0x130`, calls that exact getter and uses literal `Date` at `0xb96090`. |
| `0x765c5c–0x765e58` | The independent outer package parser reads `date` (`0xc3df28`) into its destination `+0x48`; this is a distinct record, not the active inner-release offset above. |

The existing frozen package-acceptance evidence closes installation of Manifest
type 1 to User internal FileId 4, including complete write/close and folder
cache invalidation (`FIRMWARE_PACKAGE_ACCEPTANCE_STATIC_01.md`,
`firmware_package_acceptance_static_01/evidence`). This review closes the missing
boot-time installed-record parser to UI mapping. Updating only the outer date
would not establish an update of this Date row.

The root-owned wrapper03 source observed by this review explicitly changes both
inner `release_date` and outer `date` and preserves other stock selectors. Its
inputs remain explicit dates; it does not consult or change the camera clock.
The original input ELF and frozen project sources were only read.

This is a static consumer conclusion. It depends on the new inner manifest
actually being installed and selected during normal User boot. Installation
acceptance and the actual displayed Date after flashing were not measured by
this review. There was no device, Windows, SDK, network or target-code execution.
The two separate embedded Jul-18 timestamp consumers identified by Root are
outside this chain and were not modified.

Recheck bounded bytes without executing target code:

```sh
python3 analysis/firmware/firmware_release_date_review_01/collect.py
```
