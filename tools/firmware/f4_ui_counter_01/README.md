# F4 UI queue counter 01

This is a project-owned, counter-only ABI adapter candidate. It registers one
extended OsEventHandler-compatible observer on the **existing UI queue** and the
original completed-frame event. It has no ELF constructor, automatic SDK/camera
initialization, frame read, LV Start/Stop, encoding, card write, PIN operation,
menu insertion, loader, or device runner.

Build and validate locally:

```
python3 tools/firmware/f4_ui_counter_01/build_validate.py
```

The script runs only its SDK-free synthetic macOS binary. It then emits an
AArch64/glibc-2.28 relocatable object with the existing exact Zig toolchain;
it does not execute that object or build an installable camera package.
`IQ4_F4_SYNTHETIC_HOST` bypasses absolute native address checks exclusively in
the host tests. The target object is compiled without that define.

Integration requires the independent loader/binder to hash the actual User,
validate the mapped complete function bytes, safe owner-chain reads, actual
UI dispatch and sole dispatcher, and stable native lifetimes. It must supply
an actual bounded inspector of the exact queue/event/observer triple plus a
strictly increasing epoch from observed UI dispatch boundaries. Neither
inspector nor epoch provider has been implemented by this increment. Gate
booleans are an integration contract, not automatic runtime verification.

Only the exact User SHA256 in counter.hpp is accepted. Four native function
addresses and base RTTI must additionally equal their recovered linked VA plus
the **verified** load bias. The counter checks the original current-thread
getter returns the same UiIQ4Configurator object as its queue owner. Native
constructor parameters are `(observer*, persistent_name*, queue*)`; Subscribe
and Unsubscribe take `(observer*, event*)`; the queued callback is
`(observer*, event*)` at VT+0x10. No vendor STL object crosses this ABI.

Allocate the Counter in stable storage before attachment. Register/Unregister
return void; normal return alone is insufficient. Registration exceptions,
unknown triple, wrong-thread callbacks, unexpected destruction, or a callback
after detachment put it in Hold. Do not automatically destroy the object,
unload the SO, call native cleanup again, or force the process/thread in Hold.
Unexpected native destructor/deleting-destructor slots retain the caller's
storage; they do not free it or pretend to perform orderly unregistration.

Detach only in a distinct control callback of the same UI dispatch thread,
outside this frame observer's in-flight callback. Keep all storage and code
until an independently observed **later** UI dispatch epoch also sees the
triple absent and no callback in flight. This finite guard relies on the
verified sole dispatcher; it is not a general cross-thread cancellation proof.

Snapshot.notifications counts delivered, possibly merged notifications. It
does not count captures, completed DMA slots, copied frames, losses, or FPS.
The existing owned-copy pool can be connected only in a later increment after
actual owner/lock/span/RGB order validation; its UI-retained-borrow rejection
must stay intact. See F4_UI_QUEUE_COUNTER_01.md for the native page plan and
the concrete runtime binding still required.
