# F1 read-only stack observation 05

This new SO preserves frozen Entry01, Geometry03, UI02 and Geo04. It adds a
1192-byte own scalar publication `iq4_f1_stack_observed_05` after the same real
original-first unlock boundary, plus a strict SDK-free decoder. It does not
paint, read pixels, subscribe, change a vptr, create a page, call native Current,
set a property, or install a module. Production mask is OFF.

```sh
python3 tools/firmware/f1_observe_stack_05/build_validate.py
python3 tools/firmware/f1_observe_stack_05/freeze.py --verify
```

After freezing, the build command intentionally refuses to overwrite evidence.
The retained default-OFF AArch64 SO is an offline compile/link/inspect artifact;
it was never loaded. No enabled Role02 branch or installer is emitted. Role02
does not authenticate or bind this new module's hash. The default environment
contains no `IQ4_F1_MODULE_ENTRY_01=OBSERVE`. OFF still preserves the original
interposed unlock; an unsupported original provider holds rather than inventing
a return code. Actual module removal requires the independently validated stock
process exit/recovery route.

`Collector` copies the actual Entry before/after snapshot pair without changing
its phase or epoch. A fresh Entry dispatch must advance exactly once. An actual
popup dequeue can use only a prior, already-seen Entry owner anchor and is
explicitly labelled `prior_entry_owner_anchor`, never a new Entry dispatch.
Both captures independently validate the actual original FP/TLS/owner boundary
and double-read the complete normal graph and primary/node vtables.

Recognized shapes are sole LV, the exact captured Home-class candidate then LV,
LV then its original popup, or Home-class candidate/LV/popup. The selected Dialog
is a projection of the original normal-tail branch with c8/d8/e0 absent and
priority empty; the original side-effectful Current function is never called.
Unknown prefixes and pending requests remain unsupported; failures publish no
stale graph. Two identical reads do not establish object lifetime, completed
layout, paint, full-source mapping or a surface lease.

See `analysis/sdk_reference/F1_OBSERVE_STACK_05.md` for exact build evidence,
limitations and the minimum future actual observation. The target wrapper uses
the same checked User/RO/provider gates and adds no camera control.
