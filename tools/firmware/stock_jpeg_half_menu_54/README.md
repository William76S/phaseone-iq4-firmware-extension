#54 JPEG Size integration

Reuse the frozen Half menu payload from `stock_jpeg_half_menu_build_02`. In
Storage Setup the original JPEG Size position becomes 4K / 50%, with a read-only
JPEG Quality row driven by the genuine quality getter. Mode and Destination stay
in the existing JPEG Export submenu. No Ready, diagnostic or duplicate Size menu
is added. Native JPEG Size remains1; the production extension owns choice0/1,
busy refusal, durable setting, full-RAW source and quality100.

Run `python3 tools/firmware/stock_jpeg_half_menu_54/prepare.py` once to verify the
locked component sources, interfaces and53 baseline, then emit `GUI_LINK.json`.
The two target objects are reused without recompilation. Prior focused tests are
17 normal,17 sanitizer and2 actual A64 wrapper cases; producer APIs were explicit
host fixtures in those menu tests. No device acceptance is claimed here.

Before adding this LINK, remove exactly the old52 wrapper object and original
`4f0528` hook named in `removes_objects` / `replaces_BL_sites`. Retain52 `menu.o`
and its after-append function, catalog routing, and53 policy objects/six setter
hooks/constructor wrapper. The generic cleanup preparer does not itself consume
these removal metadata fields. The new wrapper calls the original native append
once with the replacement child, then calls the existing after-append helper
using the retained original PropertyEnum. Never add both wrappers at the site.

Final54 linking requires genuine producer implementations of both extended-size
APIs and the quality getter. This component does not create a production stub,
decode IIQ or generate a firmware package.
