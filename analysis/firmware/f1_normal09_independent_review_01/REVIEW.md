# Normal09 independent production ingress review

Scope: existing frozen source and linked ELF only. No target build, SDK, Windows,
network, camera, module load, approval or original receipt was produced. All 516
manifest rows (19 source members, 474 frozen references, 23 artifacts) matched.

Source manifest SHA256:
`1271de60d10c04ca6ed580bd93ebf4bbdd8544e401e98a9ee581e2f17e3e69cb`.
Authenticated load-only SO: 111024 bytes, SHA256
`1cf41b8bb0478caa968dc884bed7fd25f919536a40e98c2e7f26dbc6fb541e0f`.
Its schema9 publication is 496 bytes at relative VA301224. The actual SO retains
the fixed planner, producer, renderer, configuration body and scaler wrapper;
the ELF inspection also verified one original-unlock BLR, errno preservation,
unchanged stripped/unstripped body, bind-now and exact dynamic symbols/imports.
This repairs 08's missing linked drawing bodies, but does not complete masking.

## Definite persistence bug to fix in a new derivative

`normal_fit.cpp:121` binds Renderer to `m.selector_ports()`;
`integration.hpp:10,20` similarly bind/configure Provider with those ports.
`f1_module_entry_01/module.cpp:59–61` returns a Native whose context is Module
and current-thread thunk is `Module::current`. At line49 that thunk returns0
when `image_.enabled` is false. At line82, 64 qualified observation boundaries
call `stop_observing`; line112 sets precisely that flag false. The admitted
Entry still keeps `runtime_linux.cpp:188` running after this cap, but Renderer
`on_ui` (normal_fit.cpp:39) and Provider readiness/dispatch (provider.hpp:30,
provider.cpp:115) consequently reject. A persistent menu may remain visible
while selection/rendering no longer works.

Minimal source reproduction is: bind these ports, perform the real Module
`stop_observing()` cap transition, then call the captured `current_thread`.
It returns0 even on the original UI thread. No runtime timing assumption is
needed. Preserve the observation cap. The new derivative must use the same
retained, validated persistent UI current/listener ports for Renderer and both
Provider bind paths. Entry07 already has that implementation at binding.cpp:83–94;
its Native is private (binding.hpp:43–65), so the frozen header offers no public
accessor. Expose it only in the new derivative, with owner and lifetime checks.

## Shortest remaining temporary production connection

1. **Load this identity, not 08.** Loader08 contract.py:7–10,36–45 and
   generate.py:9–12 bind the old e569/97000/schema8/VA287208 identity. It rejects
   09 correctly. Derive a finite new loader identity/read decoder and ui09.entry
   marker; preserve the existing restore-original-runner-inode-before-exec
   behavior. Actual runner originals, current User/maps/env and RAM recovery
   facts still have to be obtained on the camera. Linking is not that proof.
2. **Configure on the actual UI boundary.** Runtime lines230–234 only invoke
   observation. No runtime caller supplies the ActualProviderContract.
   integration.cpp:5 is merely a retained hidden local configuration body,
   absent from all9 dynamic exports. Therefore ordinary loading/dlsym cannot
   enable it. Connect a finite, protected same-UI-thread configuration caller
   using the persistent ports above. Obtain the actual manager+108 provider,
   getter/present targets, their loaded-module/complete-body ownership and
   inline Surface lifetime from real observation, not hash-shaped placeholders.
3. **Build and verify forwarding before the first patch.** scaler_bridge.S:29–31
   reads `iq4_f1_scaler_trampoline_09` then unconditionally BLR; lines109–114
   initialize this8-byte own value to0, confirmed in the linked ELF. Set it to
   the actual original trampoline and verify that value before redirecting
   0x47f910. A patch while this value remains0 crashes the first scaler call.
   provider.cpp:66–68 verifies route instructions but not that own global value.
   The external finite installer must also cover actual near mappings,
   quiescence, text/cache synchronization, unwind and exact unpatch. No installer
   is present in09; hook_plan.py is a static byte planner only.
4. **Let a genuine OFF stock frame establish readiness, then select.**
   Provider dispatch requires the exact RGB24/zero-rotation full-source return
   and live inline lease (provider.cpp:74–122). Only the resulting PaintToken
   establishes Renderer.actual_geometry_known (normal_fit.cpp:77–105);
   non-OFF choices before it are rejected at line62. No input pixels or RAW crop
   are changed by this adapter. Confirm actual five-mode selection, restored
   stock OFF coverage and ordinary toolbar/menu behavior in the same session.

Default OFF is not “no mutations”: the admitted ui09.entry creates its own
button/menu and registers six events via Entry07. Frozen binding.cpp:163 closes
the own popup before invoking selection, so the menu callback does not itself
violate Renderer's LV-at-tail condition. Stock tags1/8 and stock popup remain
separate. Zero-rotation normal-fit is the current supported drawing subset;
zoom/pan/rotation and dirty shrinking require actual stock cleanup, not a fake
coverage receipt. Keep the module, consumer and objects alive until User exits.
No source here authorizes live SO unload or turns a host cleanup into restored
stock UI evidence.

The concrete 64-boundary defect and missing production caller were sent to Root
and the new10 implementer. The existing09 frozen files remain untouched.
