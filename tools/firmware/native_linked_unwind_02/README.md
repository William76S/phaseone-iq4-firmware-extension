# Exact linked unwind revision02

This is an offline revision of the frozen `native_linked_unwind_01` reader. It keeps that revision unchanged and closes the indirect data dependencies of the actual CIE/LSDA/RTTI graph. It does not execute the firmware, load an original library, control the camera, or establish target throw/catch acceptance.

The previous seal selected only appended non-writable sections. Actual CIE personality indirection points to a compiler `DW.ref.__gxx_personality_v0` cell in a writable ELF segment. The actual F3 coordinator additionally has two LSDA type cells at `.data+0x75440/+0x75448`, immediately after the complete 480320-byte Job object, and one 16-byte own Retain RTTI. Hashing the CIE/LSDA encodings without these cells leaves their decoded targets outside the runtime byte contract.

`verify.py` retains the original finite FDE/PC, CFI encoding, LSDA/action and original-personality checks. `dependencies.py` reconstructs the locked ET_REL placement/relocations, compares actual allocated bytes, and records only relevant immutable dependencies:

- A CIE personality cell must be the exact compiler DW.ref object, one ABS64 relocation to the original personality PLT, and no dynamic relocation write target.
- A typed LSDA cell must be the actual encoded indirection target with one ABS64 relocation. It cannot overlap an ordinary STT_OBJECT. A plain `.data` cell must lie after the complete mutable object extents in its input section. The actual Job is never sealed.
- Own RTTI must be a named `_ZTI` object in `.data.rel.ro`, with the finite 16-byte class or 24-byte single-base layout, exact corresponding `_ZTS` bounded immutable name, and recursively closed base identity. Unknown inheritance/type layouts are refused.
- Dynamic relocation write widths are limited to the actual admitted AArch64 COPY/GLOB_DAT/JUMP_SLOT/RELATIVE contracts. COPY uses full symbol extent. An immutable dependency cannot intersect any such write.

Original `_ZTIi`, class_type_info and si_class_type_info are **loader R_AARCH64_COPY outputs**. Their original file reservations contain zeros which the loader replaces. They are emitted as separate `loader_COPY_dependencies`; their zeros are never called runtime immutable data. The exact active COPY relocation records, dynsym entries, version indices and `libstdc++.so.6 / CXXABI_1.3` requirement/name records become immutable metadata dependencies. A separate native COPY/libstdc++ callback must validate the loaded values and library graph.

The finite active `.dynamic` selector records for those tables and relocation write extents are also recorded. These fixed ET_EXEC pointer/size records are kept separate from DT_DEBUG and ordinary writable dynamic state. Each admitted selector has exactly one original tag record and no dynamic relocation targeting its 16-byte extent.

The updated, initially unfrozen `native_linked_contract_01/seal.py` consumes this revision's exact review and rechecks the cell/RTTI provenance. It permits only those proven finite spans in writable program segments. It never includes a whole writable segment, Job object or GOT. For typed COPY dependencies it requires the frozen `native_copy_rtti_01/ABI_PROOF.json`, its exact linked guard object and original-library/source identity. It also checks the actual global `iq4_extensions_contract_current_01` function's two direct calls and its conditional failure branch: the seal guard must run first and reject before the native COPY guard. Original COPY import zero-byte windows are replaced by this active metadata and native callback contract.

For a fresh final build directory, run sequentially:

```
build/host-venv/bin/python tools/firmware/native_linked_unwind_02/verify.py --build BUILD_DIRECTORY
build/host-venv/bin/python tools/firmware/native_linked_contract_01/seal.py --build BUILD_DIRECTORY --loader-proof tools/firmware/native_copy_rtti_01/ABI_PROOF.json
build/host-venv/bin/python tools/firmware/native_linked_unwind_02/verify.py --build BUILD_DIRECTORY
```

The sealer preserves the unsealed review, changes only its own pre-reserved 131072-byte RO span, then the final linked file is independently reviewed again. A pure F4 build without typed COPY dependencies does not need the loader proof. Blank manifests, unknown dependencies or incomplete native callback composition refuse sealing.

The 64-character header identity is the SHA256 of `LINKED_UNWIND_SEMANTIC_IDENTITY.json`, encoded with sorted JSON keys and compact ASCII syntax. It binds the complete unsealed review, complete pre-seal link report, ordered actual ET_REL byte identities, addresses, code/CFI/LSDA/indirection contents, imports, exact loader proof contents and actual two-guard callback. Only artifact `path` fields with their own size/hash identities and proven input-object `label` fields are omitted. An object provenance path is replaced by its actual input index/size/hash. Unknown object references or unqualified semantic `path` fields are rejected. A fresh output directory therefore does not change the sealed User. The raw review/proof file SHA256 values and all omitted locations remain separate receipt evidence, outside the firmware identity. `test_identity.py` verifies location-only equivalence and meaningful semantic mutations.

`readback.py` invokes the host C contract verifier against the actual sealed ELF bytes, mapping the host reserved-array address to the target ELF reservation. It never executes an AArch64 function. Its new cases cover the actual writable personality/type/RTTI cells, RX/FDE mutation, blank seal, nonexact reads, and unchanged approval when genuine ordinary mutable data changes. This tests the seal byte contract; it does not execute the separate native library guard or prove firmware behavior.

```
build/host-venv/bin/python tools/firmware/native_linked_unwind_02/readback.py --build BUILD_DIRECTORY --library HOST_CONTRACT_DYLIB
```

FDE/LSDA decoding and preservation are static evidence. Compiler-generated unwind state, a native loaded-library ABI guard, host byte tests, and target unwind execution remain distinct levels of evidence. File-backed render memory, image/source owners and runtime allocator state are outside this immutable metadata contract and retain their separate checked lifecycle/receipt requirements.
