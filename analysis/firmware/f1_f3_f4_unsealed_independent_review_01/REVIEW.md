# Actual combined User62, unsealed attempt02: independent offline review

This review is bound to the actual 13,218,984-byte User SHA256
`37bc1cddbbbdccdf0376ed931fdaffe559a9b074259e451702f56fdb31cb9a30`
and INPUTS SHA256
`d595a0de71eee4cba57aa410d07598f2d8998e3335803d4e6dd755f42ee854f6`.
The review reads bytes and source; it never loads the target, SDK, or device.
`ACTUAL_BYTES.json` records independent ELF/symbol/pin results; fourteen saved
objdump windows contain actual instruction bytes and register flow.

## Result

No additional deterministic hook/ABI/prefix rejection was found within this
finite review. This exact intermediate User nevertheless cannot initialize F3:
its linked-contract reservation at `0x4279230` has an all-zero header. The actual
initializer calls `iq4_linked_contract_current_01` at `0x42788f0`, receives failure,
and stores installation_state=3 at `0x4278958..95c`. This is the advertised
**unsealed** build state, not a functional candidate or an unexpected new defect.
The final COPY-RTTI guard, unwind overlay, relink, and seal are outside this
62-object identity and require their own final actual-byte review.

Root's current initialize.c changed after this artifact was built to add the
COPY-RTTI guard. Its current text is not used as the identity of this older
initialize.o. BUILD.json records the older source SHA `d2be1992...0358c6`; the
review of this initializer is bound to the actual object's SHA and saved actual
machine code. No old source identity was reassigned to the newer source.

## Actual replacements and original-byte scope

All 62 input objects were read and matched their reported lengths and SHA256s.
Menu05 `menu.o`, Entry03 `entry.o`, SourceDeps02 `dependencies.o`, and shared
activity01 `activity.o` each occur exactly once. Replaced Menu04 runtime,
Entry02 runtime, and SourceDeps01 runtime are not simultaneously linked. Policy04
and menu wrapper04 remain the intended unchanged objects.

The final symbol table was parsed independently; all sixteen actual branch
words resolve to the named actual symbol, comprising thirteen BLs, one B replacing
STR, and two BLs replacing BLR. All 288 changed bytes within the original file
extent lie inside the explicit patch/header/version/active-table whitelist.
This is byte-scope validation, not a claim about target acceptance.

| Original VA | Original word | Actual branch target / purpose |
|---|---|---|
| `0x8dc4c0` | `012400f9` STR x1,[x0,#0x48] | B `0x426eb48`, acquired wrapper |
| `0x8e0618` | `e0003fd6` BLR x7 | BL `0x426dd10`, SD Store wrapper |
| `0x7d8994` | `c0003fd6` BLR x6 | BL `0x426e308`, FileSystem open wrapper |
| `0x49d9d0` | `9fd70994` BL 0x71384c | BL `0x4270c90`, IFM wait wrapper |
| `0x4f0d34` | `e1d2ff97` BL 0x4e58b8 | BL `0x4273e20`, FileSettings append wrapper |
| `0x4fb454` | `14b2ff97` BL 0x4e7ca4 | BL `0x4248428`, native pop wrapper |

The remaining ten hooks (F1 settings/draw, four decode, three core, and checked
RAW close) are recorded with exact words and file offsets in ACTUAL_BYTES.json.

## Startup: actual original340 plus appended341

The actual active dynamic init-array is `[0x4367700,0x43681a8)`, 2,728 bytes,
341 entries. The original 340 entries are an exactly equal byte prefix. Its final
entry is `iq4_extensions_initialize_01=0x4278880`.

Actual CSU words decode to precisely the same range:

- `0x9ef0bc`: `d4cb01b0 94a20691` = ADRP+ADD x20, end `0x43681a8`.
- `0x9ef0c8`: `d5cb0190 b5021c91` = ADRP+ADD x21, start `0x4367700`.
- The intervening original word at `0x9ef0c4` is preserved.
- Original DT_INIT=`0x409b90` is unchanged.

The original executable's libc startup callback is still CSU `0x9ef0b0`. This
actual range repair addresses the earlier dynamic-tag-only omission; it is not
an assumption that changing DT_INIT_ARRAY alone changes the executable's CSU.

## STR replay and BLR contracts

The acquired wrapper's actual first instruction at `0x426eb48` is the original
STR word `012400f9`. It saves original LR, x0..x18, q0..q31, NZCV/FPCR/FPSR around
the bounded acquired notification; the actual last instruction at `0x426ec64`
is B `0x8dc4c4`. The original instruction executes once before notification, and
the original caller's continuation/LR is retained.

At the original SD callsite, x0=storage, x1=node, x2=filesystem, x3/x4/x5 are the
three metadata dependencies, x6=name format, and x7 is the original Store target.
The new C wrapper has these seven original parameters plus the original target
as its eighth parameter. Actual nonselected dispatch restores the frame and
executes BR x7 at `0x426e04c`; it does not substitute a guessed Store address.
Selected processing verifies x7=`0x8dcf98` and forwards the original seven args.
The injected direct BL therefore supplies the original x7 target as a normal
AAPCS argument rather than losing it.

At the original open callsite, x0=filesystem, x1=original File, x2=actual concrete
name, w3=1, w4=1, w5=0, and x6 is the original filesystem-open target. The wrapper
has those six original parameters plus x6 target. Actual fallback rebuilds
x0..x5 and BR x6 at `0x426e4b8`. Selected processing additionally verifies the
closed/owned File and O_EXCL-created public RAW before native File binding.
This review confirms argument/dispatch preservation, not a successful capture.

## Native execution, completion, and activity

Original IFM Run `0x49d7c0` reaches the hook with its actual queue pointer in x0
and timeout0 in w1 (`0x49d9c8..d0`). The actual four-byte wrapper tail-B transfers
to `iq4_f3_ifm_wait_entry_01=0x426fd1c` while retaining original return49d9d4.
The entry restores original x0/w1 and calls original Wait `0x71384c` at
`0x426fd84`. A non-owned listener is returned unchanged; the original pending
listener dispatch remains in the original Run. Source executor.cpp lines139–169
also preserve original Wait exceptions by rethrow; own task exceptions produce
Hold rather than masquerading as a successful stock notification.

Own registration is restricted to native current-thread710b0c/TP+10 matching
queue VTb805c0, outer IFM VTb7f960, reciprocal IFM VTb7ece0. Listener and event
are retained process-lifetime allocations with original ctors and pending-node
identity. This is a concrete registration path; the runtime instance/readability
and dispatch remain unmeasured.

The actual worker run call is indirect at `0x426fdcc`. Known end publishes
FINISHED, notifies the actual UI event at `0x426fe98`, releases the same shared
JPEG ticket at `0x426fec8`, then publishes in_callback=0. UI mailbox retirement
requires FINISHED, matching sequence, callback0, and the retired ticket. The
borrowed saved-capture ticket takes the separate branch at `0x426fe14` and is
not released by this executor; normal synchronous ACK returns it to capture
cleanup. Unknown retains ownership and prohibits reuse.

F4 Entry03 acquires the shared Movie activity before source/card preparation;
it releases only after actual UI Idle+owner-released publication and source
fence. F3 manual and saved paths use the same one activity object. RAW mode0
returns from acquisition policy before activity acquisition. This establishes
the finite source/code path, not an actual concurrent-card test.

The actual Back wrapper checks exact Recording-menu identity before requesting
stop. Its unowned branch at `0x42484d0..e0` tail-transfers to the uncaught original
pop passthrough. It does not send ordinary menu exceptions through the F4
catch/Hold path. Owned Stop remains asynchronous; it is not described as an
already sealed/published movie.

## No self-patch conflict in reviewed factories or source dependencies

119 registered pin spans were checked against actual mapped User bytes:
SourceDeps02, captured RAW native factory, gallery mutex factory, native executor,
FileSettings, F4 source, render/source API tables, decode and core receipts.
There are no mismatches outside each original receipt's explicitly excluded
hook words. All excluded hooks independently match their actual wrapper target.
No active RELA target falls inside these checked spans; this does not prove all
external COPY RTTI contents or all dynamic-loader state.

SourceDeps02 specifically preserves its `0x8dc494` 44-byte original prefix up
to but excluding `0x8dc4c0`, then requires an actual B to the linked acquired
wrapper. Candidate `a249e614` resolves to `0x426eb48`; it does not test for the
removed original STR. Runtime manager+48/current node, manager+38/native manager,
native manager+320/IFM, original Reader and dependencies are double-read/rechecked
instead of claiming that a caller boolean proves ownership. Core/decode guards
likewise exclude exactly their composed hook words and require linked targets.

After a seal, factory prefix checks alone introduce no demonstrated permanent
readyfalse. Initial registration failure is intentionally sticky: initializer
installation_state=3 and coordinator attempted=1 prevent blind partial retries.
A final runtime self-read, actual owner/layout, native allocation/card/dispatch,
and exception restoration failure can still reject/Hold; none was executed in
this review. The current unsealed identity must not be used to claim acceptance,
JPEG output, recording, FPS, or recovery.

Reproduce the read-only byte review from the project root:
`python3 analysis/firmware/f1_f3_f4_unsealed_independent_review_01/collect.py`.
