This independent UI07 source implements a private native entry, not another
geometry observer. Nothing was run on Windows, SDK or camera. No frozen source
was changed. The prepared binaries are not deployment authorization.

binding.cpp provides the real native route:

* Original TextButtonCtor 545cf0, retained 128x128/font5/text/0/1/stack1 ABI.
* Its own 8-byte native ControlObserver plus a retained extension and table.
  The four-argument callback accepts only this owned sender, tag 0x463107 and
  event kind1. Original tags1/8 and other kinds are rejected. The borrowed input
  pointer is never retained; only a unique owned Open OsEvent is queued.
* The native 24-byte QueueObserver with its own extension receives the Open
  event later. Only that UI callback invokes SetMenu/Show on a separate native
  0x4b8 Popup; it never opens a dialog in pointer dispatch.
* A retained 0x118 private root and five native EventItems choose Off/native,
  XPan65:24,16:9,3:2,1:1. Names, labels, events, roots, observers and button are
  module storage retained until User exits. Six listener triples, all five
  exact item fields/list nodes, popup navigator and resource aliases are checked.
* Original toolbar tag1/8, its complete LV table slots and LV+588 stock popup
  remain unchanged. This avoids requiring the stock popup's no-op exit to clear
  its Navigator root. Every close/reset operates on the private popup only.

Default Selection is absent. Native Off selection works without a mask. Other
four choices remain rejected in the open menu until a concrete normal-fit
display adapter is installed once through install_selection_once_on_ui. This
is a single callable own-code port, not a full/fresh/lease boolean. It closes
the private popup before applying a display mode and tracks request generation.
The concrete adapter must hide its mask during native zoom/pan, restore through
actual original paint, and return to drawing in verified normal fit. The source
does not request new sensor frames, exposure, encoding, HDMI or F4 frame rates.
RAW/JPEG settings are not read or written.

Future actual stock paint receipt means a current original image blit covering
the requested display viewport under a live Surface lease, with exact owner,
generation and new UI paint serial. An unchanged bitmap software ID is allowed;
new sensor-frame freshness is not required. Original paint's returned Rectangle
or UiIQ4Redraw request alone is still insufficient. No fill/provider getter is
called by this binder and no unknown proof was set true.

The production bind takes a real Module observation of the same architectural
unlock boundary, exact owner/frame/thread/mutex, original resource wrapper
aliases and preserved stock popup fields. It permits sole LV or an exact Home
node below LV, plus this instance's private popup when open. The finite tree
check rejects an occupied/outside 128x128 placement after inspecting <=512 direct
children. This is a direct-child bound check; Root must review actual native
clipping/hit-test/input capture for descendants before admitting that placement.
No position is guessed or auto-deployed. Unsupported stack/owner fails closed.

After initial binding, TLS and the frozen bounded listener inspector have
independent own lifetime and actual original pthread lock/unlock ports. They do
not depend on Module's 64-observation limit. Current owner reads accept original
LV table or this exact Display06 Collector instance's entire private table,
bound to this actual LV with all slots preserved except paint. No Memory adapter
pretends an altered native object still has its old table. Later unlock scope
is checked directly using the original complete saved-frame/callee relationships.

Detach unbinds only the own button, calls original Detach and unsubscribes six
owned events. Original Detach retains Parent+8; later real sibling traversal
must prove the node unreachable. In-flight inputs and queued callbacks are not
deleted or assumed cancelled. The module, button, popup, listener callbacks and
native event registrations stay mapped/allocated until User exit; no hot unload.
Off restoration must precede detach if the supplied display adapter drew masks.

bridge.hpp and new runtime_linux.cpp provide actual runtime integration after
original pthread unlock exactly once. The default module does no UI mutation.
The authenticated candidate admits entry ONLY after role_ctor_status==4 and a
new UI07 Root-admitted protected root:root0600/nlink1 marker in the protected
root:root0700 state directory. The fixed canonical content is
`IQ4_F1_UI07_ENTRY_ONLY <nonnegative-x> <nonnegative-y>\n`.
The marker is read O_RDONLY/O_NOFOLLOW and bounded to <96 bytes, with fd/path
metadata and exact formatting checked. It is never created by this source.
It represents Root's separately held constructor review, registry quiescence,
RAM recovery and retained-lifetime admission. It does not itself prove those
facts or authorize rendering. It must be staged by a NEW UI07 finite loader
contract with actual private proof/sole controller. Loader06's proof explicitly
forbids UI admission and pins a different SO; it cannot load this candidate or
stage this marker by renaming old evidence. A bad placement requires independent
held-owner recovery/restart review; no blind re-arm or guessed cleanup occurs.

New data-only export iq4_f1_entry_binding_observed_07 is 104 bytes with a 96-byte
own status and even-sequence two-copy protocol. mask_state_known=0 explicitly
means this entry binder cannot attest renderer state; selected is request mode.
UI mutation attempts are recorded. Once private objects are attempted, the
Display06 publication native_ui_mutation_called becomes1 at the boundary, so
its old zero-mutation decoder refuses that activated record. Future paint-hook
version must retain this accounting; this entry-only source installs no table.

Build and freeze only once:

    python3 -B tools/firmware/f1_native_entry_binding_07/build_validate.py
    python3 -B tools/firmware/f1_native_entry_binding_07/freeze.py

10 new owned native-port/queue/restore fault groups run normally and ASan/UBSan;
15 malformed copied-status checks run without any process access. AArch64
objects and default/authenticated SOs are compiled, linked and statically read.
All ALLOC and load material is strip-preserved with the same explicit section-
directory ELF-header exception as Loader06. The additional unresolved symbol
__isoc99_sscanf has a positive original libc static provider, not actual loader
resolution. Actual new module hash and symbol/load offsets must bind the future
loader and reader independently; no old offset, hash or startup result transfers.

Remaining concrete display port: full original normal-fit viewport/source aspect
from actual paint/Surface/provider geometry, actual current original clipped
coverage, and live Surface ownership through the fill call. Display06's config/
ROI/corner/scalar equality and normal paint return help select that experiment,
but do not close those three gates. Once the actual adapter closes them, only
install_selection_once_on_ui and its real paint receipt feed need connection;
the native entry/button/popup/choice/repaint-generation route already exists.
