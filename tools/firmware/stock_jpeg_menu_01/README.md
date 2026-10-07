# Stock JPEG export settings

Adds Storage Setup → JPEG Export → Mode (Off / New / All) and Destination
(SD / XQD). Mode uses the original stock JPEG enum/getter/setter; destination
uses the separate stock-JPEG bridge. RAW saving is unchanged. The existing
native JPEG Size property, DTO and event are retained and appended as usual.
This first stage has only stock Thumbnail / 4K sizes; it does not claim full-size
JPEG or JPEG-only capture.

The exact `4f0528 → 4e58b8` append runs once before this independent native menu
is attached. Native constructors, vtables, list ownership and UI queue identity
are checked. Partial objects are retained after failure, never freed or retried
in an unknown state. No old F3 capture menu/diagnostic source is imported.

Run `collect.py` against the pinned stock User, then `build.py --output
<fresh-analysis-directory>`. The resulting `LINK.json` is appended to the JPEG
restart spec alongside the new stock-JPEG bridge's LINK. Host enum/list/failure
fixtures and A64 compilation are separate from hardware acceptance.

No firmware package, device control or persistent installation occurs here.
Menu visibility and SD/XQD export require later hardware acceptance. The mtd0
backup and independent failed-User recovery gaps remain; no safe-flash claim.
