# Normal fit display 08 — source preparation

This new directory implements the UI07 selection port, four-ratio render body,
OFF/zoom restoration bookkeeping, an actual native-row callback verifier and a
production `ProvenProviderAdapter` token issuer. It changes no frozen source.
The stage produces AArch64 ET_REL objects, never a loaded/active target module.
No SDK, Windows, network, camera, target EXE or SO was executed. All actual
full-source/write/lifetime/deployment qualifiers remain unknown/false. The old
strict startup failures remain independent and unchanged.

`normal_fit.cpp` installs the exact frozen
`Binding::install_selection_once_on_ui` port. An active selection requests the
original invalidate; it does not paint in an event callback. A callback-local
sealed token then validates current owner, original Surface/Draw metadata,
complete actual stock pixel coverage and clip. It uses the existing display
plan/fixed-plan functions and native 24B Rectangle/4B Color fill ABI to draw up
to four disjoint black bands. It changes no source pixels, RAW/JPEG/property,
toolbar actions 1/8 or embedded stock popup. There is no overlay01 fixture
macro in the target build and no promotion of its always-false configure gate.

`ProvenProviderAdapter::dispatch_scaler_return_on_ui` is the real production issuer,
not a caller boolean/rectangle shim. The first supported branch is original
RGB24, zero rotation: return PC 475908; captured x0 Draw, w1=0, w3=2,
w5=0, w6/w7 clipped source W/H, incoming stack [0]=source stride,
[8]/[16]=destination W/H, [24]=display stride, [32]=nullable auxiliary.
Surface/clip are **not** invented from x0 or stack [32]. They come from the
still-live 47552c frame at FP+58/FP+38 and are matched against LV FP+30,
Control FP+40 and Manager FP+148. Source bitmap [0,16) contains metadata only;
the source/pixel pointer at +10 or Surface pixel pointer +38 is never read.

The verifier checks the original saved frame chain 47552c→477038 (47718c),
477038→LV (51ddd0), LV→Control (4abe94), Control→Manager (4e33bc), TP+10,
current owner, positive input/output dimensions and original Draw VT b7b7d8 /
VT+18=47e9d0. It rejects no-write dimension guards and unsupported formats/
rotations/sites. The saved complete scaler body selects the RGB24 row function
47e930→9e9598 and completes every destination row before this callback; the
same default Draw VT comparison is retained. Metadata additionally binds the
original full bitmap rectangle, clipped source rectangle, actual slot W/H and
ROI in the LV frame, Access/data alias, and actual engine configured W/H. All
source/config/slot/ROI W/H must agree, with original ROI origin zero. Partial
source clipping can supply real clean pixels for hiding, but cannot produce a
normal full-view mapping.

The actual provider lifetime contract is intentionally specific. Root must
review and bind the actual `Manager+108` provider class ownership and retention
through the original paint/present scope. The protected contract carries that
actual review SHA, a distinct actual hook-quiescence receipt SHA, actual owner/
provider/VT/getter/present addresses and inline Surface offset. Hash syntax
alone is not evidence: the Root caller must validate the actual referenced
receipts before invoking this own-code port. Supported getters are exactly
`ADD x0,x0,#offset;RET` (8B) or the original O0 stack-store/load, ADD, stack
restore, RET (24B); all current bytes and Surface==provider+offset are checked.
No getter or present method is invoked. LDR/external-pointer getters, unknown
ownership/lifetime, changed aliases or unsupported bodies reject. Observing a
getter address or its ADD instruction does not prove provider retention.

`integration.hpp/.cpp` provides the finite runtime calls after the existing
original-first UI boundary: install selection, bind observer to the actual
Module owner, register the immutable retained consumer pair; separately bind
the actual Root provider contract before any text patch. `hook_capture.cpp`
uses that pair from the real assembly post-return callback. At that original UI
boundary, `sample_boundary_scalars_on_actual_ui` reads provider/VT/getter/present,
copies getter candidate words and present words, recognizes only the exact
8/24B ADD-inline getter, derives the Surface address without invoking a getter,
and reads finite Surface/Draw/bounds/pitch plus LV scale/normal/pan/rotation.
Its `BoundaryObserved` result has no paint serial, source extent, clean coverage,
token, fill, or lifetime qualification; it needs no text hook. Unreadable current
fields produce `ReadFailed`, and unsupported getter candidates `UnknownLease`.
Observer-only
`observe_scaler_return_on_ui` gathers actual frames/scalars without minting a
token, filling, or setting geometry qualification. New own publication
`iq4_f1_normal_fit_ingress_observed_08` has stable sequence/size and actual
schema/last facts. `PUBLICATION_LAYOUT.json` binds its host/AArch64 496B size and
offsets. Readers must distinguish current result BoundaryObserved/Observed/Emitted with stable
copies; a later failed result cannot reuse old `last` facts as current proof.
No new SO has been linked, so no actual loaded module address is asserted.

OFF or a hidden zoom view clears the pending old-viewport obligation **only
after** actual stock writes cover all prior own bars, and the next plan writes
zero bands. A verified expanded zoom viewport may clean the old normal fit,
hide, then return to a smaller normal fit and redraw because no own pixels
remain. A shrink/rotation while bars still exist waits for actual full old
coverage; this revision does not promise that a boundary rectangle or partial
paint restores those bars. Unsupported quarter turns keep the source gate
closed; close the mask before such an operation until its write path is bound.
The exact new 45ac38→46f0c4→46ed20 evidence requests point/line/perimeter
operations, not a proven full interior clear. Control+6c is never promoted to
full clean coverage. `stock_clean_coverage` is separate from image viewport;
the current issuer only fills it with the actual native image pixel writes.

`scaler_bridge.S` is a compile-only ABI prototype. Entry 47f910 starts exactly
with d10403ff `SUB SP,SP,#0x100`, which has no PC-relative relocation. An 8B
near trampoline executes that word and a signed-range B to 47f914. A 16B near
entry veneer LDR/BR/literal reaches own bridge without changing argument
x0..x8 or vector inputs. The bridge copies all five incoming stack words,
leaves original FP semantics, calls that original trampoline once, preserves
x0..x18, q0..q31, x8 result, FP/LR, NZCV/FPCR/FPSR and errno after its own
callback, and supplies .eh_frame CFI (saved W29 CFA-888 / W30 CFA-880). Original
exceptions skip the post-return callback and unwind through that frame.
Trampoline pointer defaults NULL, never invoked or installed here.

The first instruction is relocatable; installation is **not** proved safe.
`hook_plan.py` only emits synthetic byte plans and an explicit requires-actual
list. Actual near mmap return/availability, mapped inode/whole executable bytes,
page permissions and W→RX policy, all-thread quiescence, one aligned atomic
instruction write, AArch64 D/I-cache maintenance across relevant cores, actual
unwind registration, original-word restoration with no in-flight trampoline
call, and retained module lifetime remain Root deployment gates. No text write,
mmap/mprotect, target-loader or independent unpatch action is provided here.
Modifying Draw VT+18 is avoided because it changes the original scaler fastpath.

First OFF data needed: actual UI owner/Manager, provider+VT/getter/present,
getter complete 8/24B body or explicit unsupported body, actual Surface/Draw
VT/bounds/pitch, the captured native FP/return chain, source metadata/full and
clipped rectangles, actual slot/ROI/config dimensions, scale/normal scale/pan/
countdown/rotation, destination row extent and current actual clip. These are
finite source ports today. Scalar observations close layout/write-route checks;
the actual provider ownership review and safe hook installation do not come
from those scalars alone. After admission of an exact new derivative module,
the default OFF UI boundary port can observe provider/Surface candidates without
patching text. Native write-route observations additionally require Root to
independently approve and perform the native hook deployment. The frozen UI07
90,480B module does not contain this new publication or these producer bodies.

`build_validate.py` runs only 11 new owned host groups (normal and ASan/UBSan),
15 pure byte-plan checks, and pinned Zig compile/static inspection. Positive
production-issuer fixtures use wholly owned simulated bytes/frames/getter
patterns; they are not actual native/SDK/device receipts. Frozen originals are
hash-checked and never rebuilt or modified. `freeze.py` freezes this new source
and finite evidence only; `validate.py` performs read-only hash verification.
