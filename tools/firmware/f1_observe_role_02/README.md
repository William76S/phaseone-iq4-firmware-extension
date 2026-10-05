# F1 fixed Observe role 02

This new revision composes the frozen F1 Entry01 Observe SO with the frozen RAM
Entry02 restorer/launcher. No frozen file is changed. There is no mask, UI
subscription, menu insertion, recording, PIN read/write or persistent profile.
All code/build/fixture evidence here is offline; neither SO nor launcher has run
on the camera.

The default command is local compile/link/inspection only:

```
python3 tools/firmware/f1_observe_role_02/generate.py
python3 tools/firmware/f1_observe_role_02/test_role.py
python3 tools/firmware/f1_observe_role_02/test_ctor.py
```

`preview_package` has EN0, an inert launcher and zero staging commands. The
separate constructor-enabled SO and launcher ET_REL object are **review
artifacts**, not a supplied installation. No tool invokes the target outputs.

`--emit-enabled --proof FILE --runner-a FILE --runner-b FILE` may only be used
after Root establishes the actual recovery proof. Its schema is
`iq4_f1_observe_role_gate_v2`, profile `RAM_F1_observe_once`. The 18 original
recovery gates remain, with the constructor review gate renamed to this role.
The generator validates exact original bytes/metadata and receipt hashes;
Root must establish their device meaning, private owner/DACL, held inputs and
current sole-executor lease. Host JSON booleans do not establish hardware facts.
No proof or enabled package was provided or generated for this revision.

The fixed owned paths are `/run/iq4_f1_observe02`, `/run/f1launch`,
`/p1/scripts/.iq4_f1_original02`, `/p1/scripts/.iq4_f1_candidate02`.
The unchanged User must hash to `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`.
The modified RAM runner requires two complete independent actual originals
(5105 bytes, `fe57b899f3a583e1058e4e856cf80704d902d6989b802154d02e77bc93305e88`).
An unchanged User requires its full-file/exe/PID/tick baseline; complete User
export is not required by this role. Any future persistent User modification
requires its complete actual original.

The launcher first restores and verifies the original runner inode, then
revalidates stock parent, old User exit, flags, mounts, whole User, module and
tool identities. It preserves the original private argv/environment/umask.
Only its authenticated preload branch appends `LD_PRELOAD` and exactly
`IQ4_F1_MODULE_ENTRY_01=OBSERVE`; an existing key disables that branch. Exec
failure removes both appended values before the same untouched stock User
fallback. It never signals or restarts User itself. A cold reboot destroys the
RAM entry; a prior actual cold-boot recovery receipt is therefore mandatory,
and cannot be obtained merely by linking this package.

FD198 is the launcher's inherited Unix seqpacket connection. The constructor
checks the exact Observe environment, protected directory/socket, socket type,
kernel root peer credentials, peer executable path/inode/whole hash, protected
saved own PID/tick, and two own `/proc/PID/stat` samples. It rechecks peer/staged
path and FD inode. It sends exactly one 16-byte F1S2 status and closes only the
authenticated descriptor. A detected replacement is retained (status 8).
POSIX compare-then-close is not atomic: the process-start constructor-only
descriptor lease still needs actual validation; concurrent foreign FD mutation
would refuse deployment. Unknown ownership is not inferred or force-closed.

The supervisor authenticates the pre-exec launcher PID/tick and then the same
post-exec User PID/tick. `marker.observed` records ctor startup 0–7 and always
`ui_ready=false`, `mask_enabled=false`. Startup 4 proves only the Entry01 image
gate; an authenticated status, delivery or ACK does not prove cleanup, UI owner,
paint, geometry, source frames or masks. The separate published role status must
be 4; send/close failure or status 8 remains failure even if a packet arrived.
The old supervisor remains independent, deadline-based, restores the runner,
and never kills User or unloads the module.

Runtime observation must use the exact loaded SO symbol/inode/mappings and two
identical bounded copies of Entry01's 440-byte publication. Actual target API
resolution, constructor lease, UI thread/TLS/queue epoch, current LV stack,
geometry, full-source blit and surface lease remain unverified. Preserve stock
menus and toolbar tags 1/8. The native button/popup ports remain inactive;
computer-triggered diagnostics are not a daily in-camera mask selector.

Local results: 24 role/recovery checks, 22 production-helper syscall fault
fixtures, and 26 fixed-packet checks pass. macOS syscall fixtures explicitly
map Linux `/proc` and root credentials to temporary host data; they do not prove
actual camera ownership. Both linked AArch64 SOs and the inert PIE are inspected
only. Candidate init_array order is prepare → authenticated role constructor.
Static original-rootfs symbol availability does not prove runtime ABI/resolution.
