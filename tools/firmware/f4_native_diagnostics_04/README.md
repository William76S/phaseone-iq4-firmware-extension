# F4 stage diagnostics 04

This replaces precisely `source.o` (Source03), `session.o` (Source02),
`entry.o` (Entry03) and `menu.o` (Menu03). Public source/session ABI `_02`
and menu ABI `_03`, every existing native call, card/file/worker ownership
contract, RGB24 bounds/map admission and Unknown Hold remain unchanged.
No original source or frozen manifest was edited. No target/SDK was executed.

The confirmed defect is display of evidence: Menu03 immediately returned a
zero view whenever `held` became true; Entry03 also zeroed its view after a
failure. That erased the actual selected card and previously observed mode,
frame counts and native failure. It did **not** prove no frames or no native
subscription. This version preserves actual normally returned scalar views,
overlays terminal Hold, and retains the explicitly selected destination as
`SD target`/`XQD target`. These labels do not claim the card is mounted. If a
current scalar view cannot be obtained, only the last valid snapshot remains.
Entry zeroes newly allocated **owned** memory before initializing it; no
native object/flag/pixel/vptr is rewritten by this change.

There are fourteen native items: the old nine plus `Entry stage/error`,
`Source stage/error`, `Session stage/error`, `First detail`, `Diagnostic ABI`.
The first three show `stage/error`; detail shows `entry/source/session`.
All data are owned atomic uint32 words, not addresses or original private
contents. Value callbacks retain the original char* ABI and bounded NUL
termination; these diagnostics are not proof that target code ran.

## Codes

Entry: 101 source storage, 102 session storage, 103 two RGB slots, 104 JPEG
packet, 105 hash scratch, 106 movie storage, 107 source init, 108 movie init,
109 session init, 110 page/source connection or scalar view, 111 initialized,
112 action/view returned Unknown. Allocation failures retain partials exactly
as previously; Unknown does not retry or call cleanup.

Source: 200 code pin (detail is 1-based pin index); 201 owner chain (detail 1
current UI, 2 manager, 3 data, 4 LV, 5 access, 6 engine/event/allocator).
202 initialized; 210 pre-subscribe membership; 211 frame observer constructor
(detail 1 exception barrier, 2 queue mismatch); 212 control event/observer;
213 control registry membership; 214 frame subscription/membership; 215
attached. 220 frame admission: detail 10 client invalid, 11 LV+104 not 1,
12 access client differs, 13 client name differs, 14 retained fields unreadable,
2 retained native UI frame, 3 slot already locked/no valid latest slot.
221 native Lock unknown; 222 Unlock failed/unknown/unverified.

Session: 301 attach/handoff; 302 pthread create (detail numeric returned rc
or missing handle); 303 initialized; 320 Start attach/measurement; 321 card
acquire/poll; 330 worker prepare; 331 worker codec Unknown; 332 finalization
Unknown. Codes identify only covered rejection sites; zero is not an
assertion that all indirect SDK/native effects succeeded. Stage may advance
while first error/detail remain latched. No publication changes ownership.

## Native live-view boundary

The existing source `_02` Start only admits copies of an **already running**
stock LV client; it does not call native `0x5202a0`. The exact original Start
and Stop were reviewed separately. This diagnostic package does not insert
an unreviewed lifecycle or claim that activating recording starts the native
producer. Source 220/detail11 makes this actual distinction observable.
A reported HOLD cannot currently be attributed to a particular stage from
old all-zero menu values. Source/observer/card/worker failure, native-LV-off,
and hardware version mismatch must be distinguished using actual new values.

## Reproduce without target execution

```
python3 tools/firmware/f4_native_diagnostics_04/build.py \
  --output analysis/firmware/f4_native_diagnostics_build_04_NEW
```

Only owned host fixtures run. Four target AArch64 Linux glibc2.28 ET_REL
objects are compiled/disassembled and never launched. External compiler is
fixed Zig0.15.2 with SHA recorded in BUILD.json. SDK-free host fixtures are
not evidence of native subscription, real card availability or recording.
The source ZIP includes the direct compilation header closure; referenced
historical manifests are locked as files, not a claim their complete external
vendor or historical output trees are bundled.
