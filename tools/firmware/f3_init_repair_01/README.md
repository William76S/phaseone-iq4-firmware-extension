# F3 native installation repair 01

This replaces only `native_copy_rtti_01/rtti.cpp`'s object while preserving its C ABI. Do not edit the frozen old directory. The actual original loader and kernel permit a libstdc++ load bias aligned to 4 KiB but not 64 KiB. The old verifier incorrectly derived a 64 KiB runtime bias requirement from ELF `PT_LOAD.p_align`, and rejected an otherwise exact runtime RTTI graph before JPEG installation.

The replacement changes the low-bit check from `0xffff` to `0xfff`. It retains the actual copy-slot-derived base, all 42 exact relocated/header/metadata spans, both repeated reads, final stable anchor, and the surrounding current linked ELF seal. No dynamic loader API, file, thread, object construction, arbitrary memory reader, or device call is added.

`analysis/firmware/f3_init_repair_01/LOADER_STATIC.json` binds three exact original loader windows and the original kernel config. At loader `0x5944..0x59ec`, p_align checks file virtual-address/offset congruence. At `0x5738..0x57c4`, ET_DYN uses the first mmap result directly for bias. The syscall wrapper `0x166c8..0x16718` checks a 4 KiB file offset and invokes mmap. There is no post-mmap 64 KiB adjustment in that first-mapping path. This is an actual code defect; the user's current ASLR bias is unknown, so it is not established as the unique cause of the reported unavailable state.

Reproduce from repository root:

```sh
python3 tools/firmware/f3_init_repair_01/collect.py
python3 tools/firmware/f3_init_repair_01/build.py
python3 tools/firmware/f3_init_repair_01/freeze.py
```

`verify_loaded.py` independently loads PT_LOAD bytes from actual candidate 6.03.33 and the original libstdc++, then applies ELF relocation records and executable COPY symbol resolution. It does not use generated verifier pin bytes to construct its model. All sixteen possible 4 KiB biases within a 64 KiB interval pass the new C verifier; only one passes the old one. Six non-page-aligned and five corrupt-state cases still fail. This is a host model, not execution of an AArch64 loader or the actual camera. The synthetic graph regression checks all old sixteen cases at each of sixteen biases: 256 normal and 256 ASan/UBSan executions pass. The AArch64 object is independently compiled twice with identical bytes.

An additional exact candidate audit passes all 61 Gallery, render/source/syscall, capture and JPEG82 installation code windows. These static inputs do not explain another guaranteed installation rejection. The complete installation also depends on successful self process_vm_readv and the current composed seal; those have not been observed in this task on the actual device. Initial collection incorrectly counted 52 windows because its parser omitted JPEG's cast/sizeof syntax; fixed parser reads all 61, and did not report an actual byte mismatch.

Use `LINK_INPUT.json`'s single object and `ABI_PROOF.json` in the next integration. Re-run the integration's actual linked ELF seal with this new ABI proof; the proof still includes all three native COPY bindings. This repair does not grant JPEG-only deletion, claim full RAW conversion success, enable no-card transfer, or establish persistent recovery.
