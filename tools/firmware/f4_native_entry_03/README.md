# F4 shared JPEG/Movie activity entry 03

This is a single-object derivative of frozen native_source02 `entry.c`.
It preserves `iq4_f4_native_menu_entry_02` and all source/session/card/movie
ABI02. Replace only entry.o; do not link both definitions. Source03 and the
Root/image_core codec/worker unknown-destroy fixes remain separate overlays.

At Start, the actual native UI callback acquires the sole shared activity01
MOVIE ticket before source initialization or a native card request. A busy or
held JPEG actor returns a refusal without allocating, subscribing or changing
a mode. One live movie ticket spans preparing, recording and finalizing. A
later Start may reuse that exact still-valid movie ticket; it never reacquires
or overwrites somebody else's lease. Capture RAW-only does not use this gate.

The actual session UI view releases the ticket only at Idle, with no held card
request, actual published-and-owners-released or known-empty-cancelled-and-
released, and an independently successful source owned-copy/admission fence.
Those session completion receipts follow its real original card release and
serial worker completion. This entry does not manufacture those receipts.
Normal original control completion already refreshes the native menu and
therefore calls this view; release does not require a new image notification.

Unknown initialization/control/view, underlying Hold, source fence or ticket
release permanently holds this owner and refuses subsequent Start. An error
in an unrelated JPEG actor is never cleared by this entry. Known Start
refusal/error without the complete Idle release receipt retains the movie
lease conservatively; a verified later stock Movie Start/cleanup or process
exit is required. No Error phase is treated as proof that owners ended. There
is no forced release, counter reset, kill, retry-on-unknown or new SDK call.

The original control-event args, asynchronous Stop/Exit, real measured modes,
card choice, buffer capacities and existing UI/native ownership checks are
unchanged. This is project activity exclusion, not native card/source ownership
or hardware acceptance. It does not claim 1080p/60fps, native frame timestamps
or completed F3 functionality.

Build into a fresh local directory:

```
python3 tools/firmware/f4_native_entry_03/build.py --output analysis/firmware/FRESH_ENTRY03
```

11 normal/ASan+UBSan/TSan synthetic cases each exercise actual control/view
arguments, busy JPEG refusal before initialization, retained unknowns, Idle
without card/receipt/source-fence proof, known empty cancellation, exact ticket
release and reuse. The real activity01 atomic implementation is used by these
own-memory fixtures. Only one AArch64 ET_REL object is produced; no target,
SDK, camera or firmware package is executed/produced by this build.
