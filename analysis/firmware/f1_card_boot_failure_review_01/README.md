# UI02 card candidate: definite omitted main-executable startup path

This review binds the exact local User `aa9c594ac60f594ed7e14b8cc5d765c356d759b72001f1c4ec5469087aa8d115` (12,365,792 bytes). It does not execute target code, connect to a camera or modify any frozen candidate. The parent reports the photographed camera displays LinuxApp 6.03.22, IQ 6.03.19 and system 8.02.1, with no F1 button; those runtime facts are not independently collected here.

The candidate's four LOADs, appended initializer at `0x4240080`, DT_INIT_ARRAY `0x42a1ba8`, 2,728-byte array and exact 340-entry original prefix are present and mapped. All five candidate stock code-window hashes also match the runtime verifier. Those facts did not prove the main executable actually uses the new dynamic array.

The definite omission is in the main startup call chain:

1. User entry `_start` `0x40b38c..0x40b3dc` sets x3 to `0x9ef0b0`, and calls `__libc_start_main@plt` at `0x40b3d4`.
2. Exact packaged libc SHA `0618e1d7f7731c5e07a201cb89e6a9e62db34ff0ee96e80fee781ac4193437dd`, `__libc_start_main` `0x20c00..0x20dd8`: `0x20c18` retains x3 in x19; nonzero x19 is called at `0x20c88`. It then invokes main at `0x20ce0`.
3. Provided User CSU function `0x9ef0b0..0x9ef12c` hardcodes start `0xf41da0` and end `0xf42840`. It calls original DT_INIT code `0x409b90` once, then executes `(end-start)/8 = 340` function pointers from the original array in order. These instructions are unchanged in the candidate. They do not consult DT_INIT_ARRAY.
4. Exact packaged ld SHA `9be1d9704ad489d8d573f6a9fb851d4522f92481de5795d9defee99ba96dce8f`, entry `0x1040`, calls its init walker at `0x10c0 → 0xd8a8`. The per-object init function `0xd770..0xd8a4` reads object name at +8 and type flags at +31c. An empty name with type bits 0 returns at `0xd880`, before either dynamic init or init-array calls. This is the normal main-executable case; nonzero types take the other path. We do not claim the live link_map was read.

Consequently, merely extending dynamic tags did not connect the appended F1 initializer to this executable's real normal startup loop. The new `initialized` flag remains false on that path: UI unlock processing returns immediately and the mode getter stays OFF. This can explain both absence of the F1 button and absence of masks. Runtime state/failure codes have not been read, so other target admission conditions remain unobserved.

The smallest new-source repair is to update precisely four validated CSU instructions to the actual linked 341-entry table:

| VA | Original LE bytes | Function |
|---|---|---|
| 0x9ef0bc | 942a00f0 | ADRP x20, old end page |
| 0x9ef0c0 | 94022191 | ADD x20,x20,old end low12 |
| 0x9ef0c8 | 952a00d0 | ADRP x21, old start page |
| 0x9ef0cc | b5823691 | ADD x21,x21,old start low12 |

For the reviewed UI02 layout alone, new start/end would be `0x42a1ba8`/`0x42a2650`. The repair must derive both from the next actual link, not copy those addresses. A separately versioned UI verifier must exclude these additional exact mutation spans from its stock window hashes; otherwise correctly activating the initializer would immediately reject the modified CSU text. Original 340 call order, DT_INIT, argc/argv/env forwarding, CSU loop and unwind body remain intact.

`collect.py` and `REVIEW.json` preserve exact file offsets/window hashes and full disassembly. All camera acceptance, restoration and target-execution facts remain outside this offline review.
