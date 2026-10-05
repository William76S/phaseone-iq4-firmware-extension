# Original LiveView Settings recording submenu 03

Owned native SubMenu/EventItems use the already observed F1 ABI. There is no
replacement GUI, independent toolbar, Grid hook, constructor-time UI creation,
stock page vptr replacement or RAW/crop modification. `menu.c` copies the whole
native vtable header and table, preserving RTTI and native change-event +70.
Only own name/value/activate methods are changed. IDs are UINT_MAX to use
original null-resource-text fallback. Native constructors allocate0x118/0x38.

Original root has title604, SubMenu VTb8f9b8; selector VTb931b0 and manager
VTb8f358 belong to actual Configurator VTb91f48. Entry is SetMenu BL4eea58
old43320094 ->4fb364 with return4eea5c. The integrating Root wrapper appends
both F1 and F4 and calls original SetMenu once. Additional Back BL4fb454
old14b2ff97 ->4e7ca4 is owned by `iq4_f4_menu_native_pop_wrapper_03`.
Production pins omit exactly that one patched Back word, retaining every other
instruction in its stock handler. Immutable-byte admission is not an actual
page or lifetime receipt; page inspector checks selector/manager stack and
embedded Navigator current menu on each interaction.

Native `LV Recording` contains Start, Stop, Stop and Exit, Mode, Status,
Encoded, Dropped, Notifications and Card. Mode shows actual measured W/H and
VFR; no observed FPS or optical distinctness is invented. Card is SD10 or
XQD11, switchable only in Idle. `(held)` denotes real native request ownership,
not a newly proved card-capability mode. Early construction binds a lazy own
coordinator; first Start finds the actual later LV owner. Actual source/page
connection is mandatory before frame admission.

Stop and Exit remains pending until actual source/worker/file/card fences, then
one original selector Close4e1320. Queued completion supplies the exit without
another frame or user click. Normal Back first requests stopped admission when
the current menu is proven owned, then forwards one original Pop result. For
other menus or unknown read inspection it uses an uncaught native passthrough
and preserves stock exceptions. Native objects/partial allocations and unknown
owners remain retained until process exit. No hot-unload or forced cleanup is
offered. Hardware behavior has not been tested in this increment.

Build and evidence are shared with `f4_native_source_02/build.py`; frozen source
identities remain separate. Exact ABI/static bytes are in
`analysis/firmware/f4_native_menu_03/static/EXACT.json`.
