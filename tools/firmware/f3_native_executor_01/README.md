# F3 original IFM background executor 01

This is a real fixed-address native executor for stock User SHA256
`9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`.
It adds one project event/listener and one immutable mailbox to the actual
`ImageFileBackgroundThread`; it does not create an ordinary pthread or borrow
the original JPEG-request event/Reader/decode arena.

The sole new BL is `49d9d0` (old LE `9fd70994`, stock `71384c`, return
`49d9d4`). Its assembly tail wrapper preserves the original caller's LR.
`iq4_f3_ifm_wait_entry_01` calls original Wait first. Unowned listeners and the
original exception pass through unchanged. Only its own listener executes the
coordinator callback, then waits for the next stock listener. The original
Wait has already consumed the own listener's pending bit. No global Wait hook
or native notification is stolen.

The worker binds by kernel self-read of queue VT `b805c0`, queue+1a8 outer VT
`b7f960`, outer+fa8 underlying IFM VT `b7ece0`, reciprocal IFM+328, and actual
native current-thread `710b0c`/`713f60` plus Linux gettid. Original constructor
`49d688`, Run `49d7c0`, listener `710524`, event `70f12c`, selected-image
integer getter `40c880`, and original pthread_self PLT `40b1d0` are pinned.
The integer getter locks the native data-object mutex; it is not pure memory.
Exact bytes, file offsets and normalized disassembly are in
`analysis/firmware/f3_native_executor_static_01/EXACT.json`.

Manual: actual UI owner -> actual selected index -> activity reservation ->
coordinator short catalog snapshot -> immutable submit -> same native worker.
The coordinator returns known success/failure only after its source, native
render workers, Reader, files and card have ended. Then a normally returned
native menu event notification and shared-activity release precede explicit UI
mailbox retirement. No reservation or partial preparation is retried on an
unknown result.

Saved capture: original SD Store's synchronous consumer provides the already
closed, exclusively-created RAW receipt and its still-live card/activity.
The executor rejects UI/self-wait, verifies real current native thread,
receipt storage VT `dbc6b8`, actual original pthread_self, successful Store and
CheckedClose, source FD and borrowed activity. It never reads manager/node
asynchronously. A fixed kernel monotonic wait observes at 10ms for at most
600s without resend or cancel. Normal ACK leaves capture activity live; the
original capture consumer subsequently closes/releases it. The storage VT
is not described as proof of a particular SD CThread class.

Mailbox capacity is one. Context/event/listener survive to process exit.
Unknown callback, notify, wait, cleanup, timeout or ownership permanently
latches Hold. A late worker return cannot clear Hold. There is no kill,
force-reset, hot-unload or unregister/free path. Shared activity is project
JPEG/Movie exclusion only and does not establish native card/source ownership.

Build only (fresh project-local output):

```
python3 tools/firmware/f3_native_executor_01/build.py --output analysis/firmware/FRESH_EXECUTOR_BUILD
```

Host normal/ASan+UBSan/TSan exercise 17 synthetic fault/concurrency groups.
Target objects are AArch64 ET_REL with real CFI/LSDA and the same original
exception rethrow. Required original alias is
`iq4_f3_original_ifm_wait_01=0x71384c`; the common self-reader uses
`iq4_native_original_syscall_01=0x40ae40`. Actual final ELF import/version/FDE/
LSDA review is Root's integration gate. None of these tests executes firmware,
proves hardware exception behavior, performs capture, or accepts JPEG output.
