# F3 checked save transaction 01

Offline implementation; no camera integration or device execution. `transaction.c` is a C-only checked completion boundary for a pinned, complete encoded JPEG span. It is not a streaming encoder sink. Native ports are deliberately unbound.

`f3_checked_save_01` checks source identity and actual full-RAW render provenance, JPEG SOF dimensions and terminal EOI; creates an exclusive private JPEG temporary; checks every returned byte count; checks sync/close; reopens the same identity and exact length; compares every encoded byte through 64 KiB scratch; checks size/identity again; closes; then permits non-replacing publication. Only JPEG-only for a newly created, owned stage of this capture may invoke `remove_owned_raw_stage`. A manual export of an existing IIQ always retains it. RAW mode has no JPEG operations.

Ports are our contracts, not guessed native declarations. `check_raw=DONE` means the complete RAW remains durably stored with the bound identity, not merely a catalogue flag. A publication port must implement non-replacement and checked directory durability. A deletion port's FAIL means the RAW is positively known still present; partial unlink, directory-sync failure after unlink, or unknown completion is UNKNOWN. UNKNOWN latches the session, retains open owners, and refuses all later calls. Do not translate an unknown exception or lost acknowledgement to ordinary FAIL. The native binder must retain the actual handles and pinned producer/source lifetime; stack-only mock context is not a runtime owner.

SOF/EOI checks are structural and do not decode entropy or prove full RAW detail. The host JPEG fixtures contain synthetic scan bytes. Actual decoder provenance, source resolution/detail, returned RGB dimensions, and successful encoder finish must be established separately. The 256 MiB encoded-span limit is our bound, not measured camera capacity.

Build/review locally:

```
python3 tools/firmware/f3_save_transaction_01/validate.py
python3 tools/firmware/f3_save_transaction_01/build.py
python3 tools/firmware/f3_save_transaction_01/collect.py
```

`build.py` runs only our host tests and compiles an AArch64 ET_REL; it never launches target/vendor code. Local compiler and exact original User paths are in BUILD.json and the collector. External original User and Zig binary are not distributed in this source directory.

Native integration prerequisites and exact old failure evidence are in `analysis/firmware/F3_SAVE_TRANSACTION_STATIC_01.md`. In particular, the existing JPEG writer's normal true return is not completion evidence. Unbound exclusive-create/publish/owned-delete keeps RAW; never use Exists-before-O_TRUNC as exclusive creation.
