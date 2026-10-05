# Exclusive own activity lease

This C-only shared gate excludes own JPEG work (actor3) and own movie work
(actor4). It never establishes native source, card, file or thread ownership.
Link `activity.o` exactly once into a combined application. No target fixture
reset function is exported. Acquire is a bounded CAS loop with no allocation,
wait, native callback or TLS dependency.

A successful acquire returns a generation+actor ticket and its immutable own
context pointer. Request producers retain that ticket while preparing, queued,
running or finishing. Busy refuses the second task without touching stock card
configuration. A stale/foreign ticket is refused. UNKNOWN sets a permanent
held bit: no retry, new acquire or automatic release is available. Release
requires the exact current ticket after actual source/file/card cleanup;
returning a menu state to Idle alone is insufficient. ActorRAW-only is not
included: a stock RAW capture need not wait for own JPEG geometry admission.

For F4, a new entry derivative must acquire Movie before actual Start, keep the
lease through Stop/finalization, and release only after worker files/held card
FDs are closed and native UI requests are released. Source02/03 and existing
entry02 are unchanged and do not yet call this gate. F3 capture/manual queued
work must acquire JPEG before accepting the immutable request, and keep it
until coordinator cleanup is proven; an old manual RAW is never deleted.
This gate by itself is not an integrated task or device acceptance result.

The own host tests exercise wrong actor/owner, overlapping tasks, stale ticket,
permanentUNKNOWN, generation exhaustion, and two real host threads racing
20000 total generations. Normal, ASan/UBSan and TSan are supported. Actual
AArch64 ET_REL has no undefined symbols, native calls or TLS. No camera/SDK
access or target execution occurs.
