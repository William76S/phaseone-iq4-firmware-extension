# Captured persistent-port state fix11

This new source is a narrow derivative of frozen10 SOURCE
5793c044638b7f88a8fabae547b2b56b5c6ce17ac02c1ff23551a9048ed68b1e.
The production change is only Binding::native_current: a previously captured
Native now returns0 for the actual Binding Hold or DetachedRetained phase.
Renderer and Provider therefore reject further work after that state changes.
Ready still works after the original Module64-observation cap. No phase is reset
by production code. Observed source/owner/lease requirements are not weakened.

Runtime namespaces, public `_10` names, schema10 and all publication/layout
fields remain unchanged. Source11 and its actual SO hash/size/offsets are new.
The new module_identity.hpp binds only that SO; it must be used by the matching
Loader11. Neither a10 receipt nor a10 SO identity is relabeled11. The unchanged
transaction/controller source is copied here so its local identity include is
unambiguous; two native objects are prepared for Loader11, without another ELF.

build_prepare.py verifies all609 parent references, runs only the three owned
cap/captured-Hold/captured-DetachedRetained regression groups normally and under
ASan/UBSan, compiles/links the SO once, verifies unchanged exports/imports and
publication sizes, and checks the actual target layout and retained caller
bodies. Old transaction/UI/geometry suites are not rerun. No camera, SDK,
Windows, target SO/EXE, loader or ptrace operation is executed.

The original10 live preparation/one near mapping/defaultOFF behavior and
original-first unlock/errno/retained callback are unchanged. No preparation
input means no near allocation/configuration; this is not a claim that admitted
UI creation has no mutations. Actual loading, owner/provider/lease/full frame,
text transaction, mask display, OFF cleanup and cold recovery remain unverified.
Module/objects and near mappings remain retained until original User exit.

Existing full transaction/cache evidence stays in the frozen10 package. Read
SOURCE_DIFF.txt for the entire runtime guard delta, targeted fixtures and new
identity; BUILD_PREPARATION.json and LAYOUT.json contain actual new identities.
Build files only write this11 source/build directory. After freezing, validate.py
only checks hashes. Running build_prepare.py again after freeze is refused.
