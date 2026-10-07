This component fixes one conflict in the 6.03.52 JPEG route: the factory SD
composite observer writes its JPEG Mode on every storage notification, even
when JPEG Destination selects XQD independently of the SD composite mode.

The new constructor wrapper calls the frozen 52 constructor once with its
original arguments and caller SP. Only after that binding succeeds does it
publish the actual SD-group JPEG property identity. Six precise virtual setter
call sites then retain the separately selected XQD Mode. SD destination,
unbound initialization, foreign property, or a different virtual setter use the
original virtual call. Direct user Off/New/All changes still use the original
setter. RAW and backup setters remain in the original policy.

The policy does not repeatedly test requester masks: they change during
capture. A held core remains held; retaining its selected Mode does not enable
a JPEG writer or bypass recovery checks. This component adds no GUI or size
option, and keeps the 52 Thumbnail/4K encoder and quality 90.

Rebuild with `python3 tools/firmware/stock_jpeg_policy_01/build.py`, run the
independent `analysis/firmware/stock_jpeg_mode_reset_audit_01/prove_fixed.py`
using the project's Unicorn Python, then run `freeze.py` and `freeze.py --verify`.
Replace the 52 hook at 0x424bcc with this constructor target and apply the six
auxiliary BL hooks in LINK.json. Keep all four frozen 52 core objects.

The original counterexample and new object execution are offline A64 evidence.
They do not establish actual card writing, physical JPEG production, or saved
Mode behavior after a reboot; those require camera acceptance.
