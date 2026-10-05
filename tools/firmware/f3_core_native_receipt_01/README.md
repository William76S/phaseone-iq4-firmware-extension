# Actual native Full/R0 core receipt 01

This is concrete source for three fixed original BL replacements. It records real original stack identities and normal returns, rather than accepting a caller-supplied completed flag. It proves **one original full-scale R0 core pass**. It does not prove RAW decoding, sRGB profile, the whole PreviewProcess or a saved JPEG. It emits no FWP.

Admission compares10204 original bytes from the pinned User (full core, full PreviewProcess, full native join and the opaque pipeline-clock PLT). Exactly three BL words must instead point to this module's linked wrappers:964860→core,91a78c→native pool join,91a964→pipeline clock at the terminal block. The PreviewProcess window also permits exactly963d28→the linked decode02 reader wrapper, required for the composed native pipeline. It verifies the actual branch target rather than ignoring the instruction. Uninstalled hooks, a wrong decoder target or any changed neighbor reject. The finite collector includes original SHA and all four before bytes. No target addresses are transplanted from other cameras.

An exclusive serialized worker arms one owner with actual settings/cancel/pool/RGB32 output/arena. The supported native settings are scale1, R0, pipeline-enabled, full crop and auxiliary-output disabled. Other settings reject. The original core is called with all nine arguments, including the ninth stack argument. Join wrappers forward the original join once and record only its normal return. The terminal-clock wrapper forwards the original clock and restores its returned registers.

Actual original core SP is inspected at each join: allocator+0xe8, output+0x118, settings+0x88 and cancel+0xb8 must match. Stage+0xf0 must equal the number of preceding joined stages. At the terminal block, completed+0xf0, total+0x130 and observed joins must be equal/nonzero, worker count+0xb4 positive, and cancellation clear. Matching normal core return is mandatory. Capacity early returns, zero workers, missing stages and cancellation cannot report complete.

Unrelated stock workers inspect only an atomic published real TID and pass through the wrappers without reading mutable receipt state. Failed reads/identity contradictions/missing normal return latch Hold. A known incomplete normal return rejects, retaining the caller's RAW decision. The caller owns all native resources; this module releases no files, pools or descriptors. Exceptions retain their original unwind path via wrapper CFI; there is no forged successful return.

Reproduce into fresh directories from the project root:

```sh
python3 -B tools/firmware/f3_core_native_receipt_01/collect.py --output analysis/firmware/core_receipt_static_fresh
python3 -B tools/firmware/f3_core_native_receipt_01/build.py --output analysis/firmware/core_receipt_build_fresh
```

The collector regenerates the pins header from the immutable local original. The builder runs17 owned receipt cases plus10 syscall cases, normal and ASan/UBSan, and compiles three AArch64 ET_REL objects. No original native function, target ELF, SDK or camera is executed. Native RAW-row receipts and the final original/profile/pool adapters remain separate requirements before combining this pass into a whole render completion provider.
