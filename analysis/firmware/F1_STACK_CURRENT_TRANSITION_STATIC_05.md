# F1 stack selection and transition, static increment 05

Evidence level: exact original User bytes and host source review only. No SDK,
Windows, target executable, camera, setter, module load or deployment was run.
All previous frozen components remain unchanged.

The original selection function does **not** require a sole LV page. When its
higher-priority states are absent, it chooses the last Dialog on the normal
list. A complete `Home-class candidate -> LV` list can therefore be classified
as **normal-tail selection projected to LV** by a new read-only increment.
This does not prove that the actual device uses that Home class, that the LV is
currently painted, or that its pixels, surface or viewport have a valid lease.
The existing Geometry03/Geo04 `OwnerRejected` result remains correct until a
new component explicitly implements and observes the narrower contract below.

## Exact input and reproducibility

Input: `analysis/firmware/extracted/P1Linux_6.03.21.bin`, 11,874,544 bytes,
SHA256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`.
Addresses below are original AArch64 ELF64 little-endian ET_EXEC VAs with
file offset `VA - 0x400000`. A runtime address still requires the actual checked
image bias. The package filename does not establish the running firmware
version; Root separately reported this whole User hash matched the device.

`tools/firmware/f1_stack_current_static_05/collect_static.py` captures 20 finite
windows, 9 tables and 3 strings, and pins 8 existing source/document references.
It refuses to overwrite a collection directory. Static reproduction:

```sh
python3 tools/firmware/f1_stack_current_static_05/collect_static.py --out /tmp/iq4-stack05-new
python3 tools/firmware/f1_stack_current_static_05/collect_static.py --out /tmp/iq4-stack05-new --verify
```

Frozen evidence: `analysis/firmware/f1_stack_current_static_05/exact_bytes.json`
and its adjacent window files. Manifest/validation bind this collector,
document, exact rows and original source references. No prospective runtime
implementation was tested or claimed by this increment.

## Original Current ABI and branch order

Manager table address point `0xb8f358 + 0x18` contains `0x4e29b0`.
`Current(Manager *x0) -> Dialog *x0` is the complete window
`0x4e29b0..0x4e2bdc`. It is **not a pure getter**:

| Order | Original branch and instruction evidence | Read-only consequence |
|---|---|---|
| 0 | `0x4e29c0..0x4e29f4` checks normal wrapper `manager+0x68`; empty triggers assertion/error handling. | Reject an empty or incomplete normal list, including when an override is nonzero. |
| 1 | `0x4e29f8..0x4e2a10` returns `manager+0xc8` if nonzero. | A normal tail is not selected while this override is present. |
| 2 | `0x4e2a14..0x4e2b48` handles `manager+0xd8` using byte `+0xe0` and helper `0x4e4c5c(manager+0xe8)`. It calls Dialog slots `+0x170/+0x158` or `+0x178/+0x160`, and writes `manager+0xe0`. | Reject nonzero `+0xd8` or `+0xe0`; do not call Current to resolve the timer/auxiliary case. |
| 3 | `0x4e2b4c..0x4e2b8c` selects the priority wrapper `manager+0x40` tail when nonempty/non-null. | Require the complete priority list to be empty for a normal-tail projection. |
| 4 | `0x4e2b90..0x4e2bd0` returns the normal wrapper `manager+0x68` tail. | Under the previous exclusions, normal-list length does not change the chosen tail. |

`0x4e4e2c` passes wrapper `+8` to `0x70bcc0`; that function returns the
sentinel's previous node through `0x460394`, and `0x4e4e14` returns node `+0x18`
as Dialog. `0x46037c` and `0x460394` read node `+8` and `+0x10` respectively.
`0x70bd10` considers an empty list one whose sentinel next equals itself.
For a double-checked reciprocal graph:

| List | Wrapper | Sentinel | First | Last |
|---|---:|---:|---:|---:|
| priority | manager+0x40 | manager+0x50 | manager+0x58 | manager+0x60 |
| normal | manager+0x68 | manager+0x78 | manager+0x80 | manager+0x88 |

Wrapper/List/Sentinel address points are `0xb8f4e8`, `0xc22908`, `0xc22960`.
Dialog node is embedded at Dialog `+0x88`; node `+0x18` points back to Dialog;
Dialog `+0xb0` is its Manager. Base ctor `0x4e10c4..0x4e11c0` writes the manager
at `0x4e1148` and node's Dialog binding through `0x4e1ad4` at `0x4e1184`.
These are list/owner relations, not ownership of a pixel buffer.

## Home identity: a static candidate, not an observed scene

The original includes `UiIQ4HomeDialog`:

| Evidence | Exact value |
|---|---|
| Class name | RTTI string `0xb952b0 = 15UiIQ4HomeDialog`, referenced by typeinfo `0xb95278 +8`. |
| Source identity | `0xb94f70 = ../../Src/UiIQ4/Dialogs/UiIQ4HomeDialog.cpp`; title at `0xb94f40 = Home`. |
| Primary table | Address point `0xb94fe8`, 58 slots; preceding header at `0xb94fd8` has offset-to-top 0 and typeinfo pointer `0xb95278`. |
| Embedded node table | Address point `0xb95200`, 10 slots; header `0xb951f0` has offset-to-top `-0x88` and the same typeinfo. |
| Constructor prefix | `0x500064..0x5000f4`: calls base Dialog ctor with incoming x1 as manager, then stores primary/node address points at object `+0/+0x88` (`0x5000b4/0x5000d4`). Third incoming argument is stored at `+0xe0`; its type is not asserted here. |
| Destruction identity | `0x500780..0x500844` restores those tables and destroys its bases; node thunk `0x5007ec` adjusts x0 by `-0x88`. Sized delete uses `0xe8`, without establishing allocation lifetime on this device. |

Complete `.text` direct B/BL scanning in `home_direct_branch_refs` finds no
direct branch to `0x500064`; references to `0x500780` are its three adjustment
thunks and deleting destructor. This limited scan does not exclude indirect
construction, but it prevents claiming a known Configurator Home field or an
actual Home allocation from these bytes. A displayed home screen may use a
different original Dialog class. No candidate q+offset is filled in.

## Transition and paint boundaries

`Dialog::Show` (`0x4e12c8`) dispatches manager slot `+0x28 = 0x4e28f8`.
That wrapper calls `0x4e27bc` with the normal list. Push obtains the previous
Current, calls old Dialog slot `+0x160`, appends the new node at `0x4e2838`,
then calls the new Dialog enter/layout slots `+0x170/+0x158`, sets bounds,
invalidates and notifies the manager redraw event (`0x4e2850..0x4e28e0`).
Thus a newly appended LV tail is visible in memory **before these later calls
finish**. The old slot `+0x160` maps to `0x4e18b8` for both captured Home and LV;
its finite body only notifies the optional event at Dialog `+0xc0`. Push is not
an explicit old Dialog `+0x178` exit in this window. Transitive event effects
and arbitrary subclasses are not excluded.

Manager Close `0x4e2bdc..0x4e2dc8` calls exit and unlinks node via `0x70ba84`.
For the current-tail case it subsequently obtains Current again, updates its
layout and invalidates it (`0x4e2d68..0x4e2db4`). Mid-close topology, pending
requests and any changing sample remain rejected. Dialog byte `+0xa8` is set
by the queued request at `0x4e150c`; it is not itself a proof of completed
close. A new observation may record this byte, without using it as readiness.

Manager draw `0x4e32d4..0x4e36b8` calls Current at `0x4e3300` and the selected
Dialog draw slot `+0x98` at `0x4e33b8`. The redraw-event branch of manager
dispatch (`event == manager+0x100`) invokes draw through manager
`+0xb0 = 0x4e32d4` at `0x4e308c`. Other input paths and draw participants are
outside this finite closure. The original UI loop calls `0x70ff84` then repeats
at `0x4ef97c..0x4ef988`; the existing exact dequeue/unlock boundary is a source
epoch, not evidence that a redraw callback or fresh blit completed.

LV slots `+0x170/+0x178` map to `0x51d884/0x51d9bc`. Enter/exit manage the
LV operation; readable `LV+0x6f` visible and `LV+0x104` running do not select
the current Dialog. Neither these bits nor scale, pan, slot dimensions, a
normal tail or a queue epoch proves fresh pixels, full-source mapping or a
surface lease.

## Small implementable next increment

Keep all frozen code unchanged. First extend only diagnostic publication with
a bounded **read-only projection**, retaining original vtables and whole User
checks. Reuse `Inspector::boundary/owner_chain` and the existing complete
maximum-8-node traversal; record each prefix Dialog's primary vptr in addition
to node vptr, Dialog, manager, next/previous, and request byte. Repeat the entire
graph, override values, owner chain and source boundary and require equality.
Do not call Current, is-current (`0x4e159c` transitively calls Current), enter,
exit, paint, animated-pan getter, an event or a setter.

The finite classifier should initially distinguish:

| Stable normal shape with priority empty and c8/d8/e0 all zero | Published projection |
|---|---|
| LV | LV selected by normal-tail branch; existing case. |
| Exact captured Home-class candidate -> LV | LV selected by normal-tail branch; **new observation candidate**. |
| LV -> its exact original popup | Popup selected; LV is a lower page. |
| Exact captured Home-class candidate -> LV -> exact original popup | Popup selected; both other pages are lower. |
| Home alone, unknown prefix, duplicate/extra node, or LV not tail in an otherwise unclassified shape | Keep owner/shape rejected for LV geometry; record bounded unknown facts only. |

The two Home shapes require actual primary `bias+0xb94fe8`, node
`bias+0xb95200`, their complete exact RO headers/tables, reciprocal node/Dialog
and common Manager relations. They do not accept a prefix merely because its
name is Home or its visible bit is set. An unknown actual prefix is not
substituted with this candidate. A future overlay shadow vtable is a separate
versioned contract; never falsify a memory read to make Inspector see an
original table. Production masking/menu mutation remains OFF.

Only after actual receipts establish the new shape may a separately versioned
Geometry/UI inspector use this classifier for its **scalar collection**.
Geo04 calls the frozen Geometry03 Inspector internally, so altering only
Geo04's phase check cannot safely or correctly enable collection. Its geometry,
fresh-source, fresh-blit and surface-lease proof flags remain false. No tests of
an unimplemented shape are claimed here.

## Minimum actual observation needed

One controlled Observe session should capture at genuine UI dequeue boundaries:
checked whole User/RO bias, actual TP/TLS queue, original FP/LR chain, q/Manager/
Data/LV/popup owner, manager c8/d8/e0, both complete list graphs and primary/node
vtables, the selected **projection**, LV request/visible/running flags and
matching double-read samples. Preserve source epoch and label unknown or
changing topology. Capture a stable home screen, LV entry, stable LV, original
popup if opened, and return to home; do not manufacture absent states.

Current Entry01 publishes only after LV-at-tail qualification and omits prefix
primary vptr, so it alone cannot provide the Home-only or prefix identity
receipt. The small diagnostic-publication increment above resolves this
specific gap. Loader role/runner originals, actual mount/stock respawn and
cold recovery still need their independent receipts. This increment neither
changes those gates nor turns a successful SO link into installation proof.
