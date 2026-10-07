# Storage Setup format menu 55

Adds `Storage Setup → XQD Storage` with `JPEG Only / IIQ Only / IIQ+JPEG` in that display order. The shared backend uses canonical values JPEG1 / IIQ0 / Both2, explicitly mapped by the UI. SD Primary and SD-only output follow this same choice; the original SD Storage policy selector is retained.

Remove the old 52 `menu.o` that adds JPEG Export / Mode / Destination. Retain the exact 54 JPEG Size `menu.o` and append `wrapper.o`: this component provides the wrapper's existing `iq4_stock_jpeg_after_menu_append_01` ABI, appending one format menu after JPEG Size. No new hook or wrapper is added. JPEG Size 4K/50% and genuine read-only Quality100 stay unchanged at their existing position. The original native SD property / enum / DTO and all original append operations remain intact. No All action, destination selection, debug page or fake readiness indication is added.

Values and Selected labels come only from `stock_storage_router_55/router.h` real getter. Setting calls the real setter, which owns busy/admission, saved settings and the per-capture output snapshot. Rejected writes do not change displayed state. A failed or invalid getter shows no value or Selected claim. UI queue, object identities, finite exact original windows and list membership are validated before construction. Construction failures retain detached partial ownership and stop retries.

`FACTORY_LAYOUT.json` records the stock root/Advanced append order and real SD composite identity: VM+1d8, getter495448/setter5b66bc, DTO+408, original six-value enum. This factory composite is separate from the new three-value backend format.

Reproduce from the project root:

```sh
python3 tools/firmware/stock_storage_menu_55/collect.py
python3 tools/firmware/stock_storage_menu_55/build.py --output analysis/firmware/stock_storage_menu_55_build
```

Build output binds exact compiler, original User, target headers, object and focused host-failure evidence. LINK requires the actual 55 backend definitions; host fixtures are not production implementations. This component alone establishes neither JPEG-only deletion safety nor an installed/hardware-accepted format. No device was accessed or written.
