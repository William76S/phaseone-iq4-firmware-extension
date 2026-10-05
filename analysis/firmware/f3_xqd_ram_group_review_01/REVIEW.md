# XQD first-stage RAM / final card open / group review

Level: exact stock static bytes and a point-in-time source review. No target execution, camera, Windows, SDK loading or file transfer. Stock User is 11,874,544 bytes, SHA-256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`.

## First stage is RamFileSystem

- `8de864..8de884` constructs embedded `storage+0x2c8` with `827fc4`. `827ff8..828004` installs address-point `d91c08`; its RTTI is `d91d48`, name `d91d60 = 13RamFileSystem`.
- `8df32c` is `ADD x1,x0,#0x2c8`, not a pointer load. `8df34c -> 7d8e30` saves this FS at writer `+8` (`7d8e58`).
- `7d8928` dispatches writer FS `VT+0x28`. For this embedded FS the target is `82813c`, which resets the RAM cursor/remaining/high-water fields and binds the File by `825724`. The complete body, including its logging tail, is preserved in the exact window. It never dispatches LinuxFS open.
- RAM write `828350..828454` calls `memcpy` at `828400`, into RAM cursor `+0x228`, then advances it and high-water `+0x230`. The name is diagnostic, not a directory create.
- Only `8df680..8df6b8` loads `[storage+0x2c0]`, calls its `VT+0x28`, with final File at `SP+0x60`, actual filename and three true mode arguments. The prior independent callsite review binds this FS to original Main registry ID11 (XQD).

Thus the first stage does not precreate the final card basename. The proposed final exclusive-open does not collide merely because that first stage completed. Existing files, actual EEXIST, card loss, partial open/close and any unknown owner still must fail safely; this result does not permit truncation fallback or claim capture success.

## Group/source review boundary

The exact draft source identities are in `EXACT.json`. Peer files may subsequently change; this review does not freeze or certify their future version.

- Settings and source dependencies publish before `group.live` release; card jobs read an immutable per-card mode from that acquisition snapshot.
- The original enable predicate remains called once. Actual native context weights are 1 (the other original consumer), 2 (XQD), 4 (SD); the revised hook accepts only these precise values. It observes selected destinations before their original Notify, and does not infer membership from mounted cards or user modes. The weight1 transport assignment is the next independent investigation.
- Original refsum runs once, then seals the group. Release needs seal, no Hold, no serial owner and every selected own-JPEG bit finished. A card completing before the fanout loop seals cannot prematurely release the activity.
- The revised begin-card path rechecks live state, acquisition sequence, node, activity, selected/finished bit and source dependency identity after taking the serial slot. This prevents a waiter from treating a later group as its original job.
- Serial ownership spans actual Store, checked close, complete RAW hash, synchronous native-worker ACK and all own FD/card cleanup. Unknown paths latch group/activity Hold; original Store exceptions continue unwinding.
- Executor03 double proofs allow selected-mask growth (for example 1 to 3) but require both observations to include its own card bit and keep the same sequence/group/activity identity. It does not misuse the early partial fanout mask as a sealed whole-group receipt.

No definite defect in this normal lifecycle was established in this bounded review. This is not a global race exclusion or a live dual-card acceptance result. Original scheduling, two-card callback arrival, native worker TLS/cleanup, no-card capture and actual card removal remain separate runtime observations.

Reproduce exact windows with `python3 analysis/firmware/f3_xqd_ram_group_review_01/collect.py`. No peer source is edited.
