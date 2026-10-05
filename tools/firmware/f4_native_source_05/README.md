# Native recording source 05

Replaces source04 and native_calls02, retaining their C ABI and frame ownership.
`exact_triple` now acquires the same original recursive registry mutex used by
native Subscribe (`712790 -> 71242c`, mutex `f553c0`). Ordinary `EBUSY` is no longer
misclassified as permanent initialization failure. This lock is acquired only
outside the native pixel borrow. Original lock exceptions, corrupt lists and
unknown unlock outcomes remain failures; no ownership check is bypassed.

Five new original-byte windows bind the blocking lock and its helpers. The old
source rejects a real pthread contention case; the new source passes contention,
recursive ownership, exception, corrupt-list, unknown-unlock and copy/fence tests.
The C++ exception barrier is tested separately. Ten new groups pass in normal and
ASan/UBSan builds; native camera methods remain explicit fixtures.

Final build: `analysis/firmware/f4_native_source_build_05_final02`.
Root corrected two test/build setup errors (missing page guard and host C++ include
path); earlier failure logs remain under `f4_native_source_build_05_root` and
`f4_native_source_build_05_final`. No target code was invoked.

This is a proven code defect and repair, not proof of the user's specific Hold
cause. Full integration reproduction replays the recorded target compile
commands without rewriting the frozen source manifest.
