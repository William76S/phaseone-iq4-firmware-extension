#!/usr/bin/env python3
"""Capture narrow IQ4 LV size negotiation evidence; offline bytes only."""
from pathlib import Path
import hashlib
import json
import struct
import subprocess

ROOT = Path(__file__).resolve().parents[2]
ELF = ROOT / "analysis/firmware/extracted/P1Linux_6.03.21.bin"
EXPECTED = "9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb"
OBJDUMP = "/Library/Developer/CommandLineTools/usr/bin/llvm-objdump"
OUT = ROOT / "analysis/firmware/f4_dimension_static"
RANGES = [
    ("parsed_common_class_forward", 0x86a290, 0x86a2b4),
    ("common_class_type_byte_stores", 0x84b73c, 0x84b778),
    ("class_and_configuration_dispatch", 0x86a390, 0x86a484),
    ("capability_dimension_1024", 0x8699a4, 0x8699c0),
    ("default_configuration_1024", 0x86aa24, 0x86aa50),
    ("unsupported_default_zero", 0x86aaa4, 0x86ab10),
    ("configuration_request_validation", 0x86ab28, 0x86acd0),
    ("configuration_crop_and_dimension_min", 0x86acd0, 0x86ad14),
    ("unsigned_min_reference", 0x4335e8, 0x433620),
    ("configuration_apply_debounce", 0x86af80, 0x86afec),
    ("set_engine_dimension_arguments", 0x86bc10, 0x86bc88),
    ("live_view_access_set_config", 0x6b639c, 0x6b6460),
    ("engine_aspect_and_alignment", 0x7975d0, 0x7977e0),
    ("capabilities_reply_copy_call", 0x86a67c, 0x86a6b4),
    ("capabilities_reply_class_type", 0x86d1d8, 0x86d1ec),
    ("capabilities_reply_dimension_copy", 0x86d474, 0x86d484),
    ("configuration_reply_copy_call", 0x86a8c8, 0x86a900),
    ("configuration_reply_class_type", 0x86d29c, 0x86d2ac),
    ("configuration_reply_dimension_copy", 0x86d544, 0x86d58c),
    ("frame_size_from_locked_slot", 0x86be3c, 0x86be7c),
    ("frame_size_header_fields", 0x86c078, 0x86c0b4),
    ("access_locked_size_getter", 0x6b61fc, 0x6b621c),
    ("engine_locked_size_getter", 0x6b6d44, 0x6b6d68),
    ("waiting_property_default", 0x8696e8, 0x869708),
    ("waiting_timer_frame_event_gate", 0x86c6f8, 0x86c7a4),
]
TABLES = [("waiting_property_name", 0xda5ce0, 0x1c),
          ("waiting_timer_name", 0xda5d00, 0x19),
          ("engine_configuration_source_name", 0xda6748, 0x34)]
REFERENCES = {
    "analysis/firmware/F4_STATIC_EVIDENCE_SHA256.json": [
        "analysis/firmware/f4_static/video_buffer_lock_metadata.disasm.txt",
        "analysis/firmware/f4_static/frame_producer.disasm.txt",
    ],
    "analysis/firmware/F4_UI_STATIC_EVIDENCE_SHA256.json": [
        "analysis/firmware/f4_ui_static/lv_start_stop.disasm.txt",
    ],
}


def sha(data):
    return hashlib.sha256(data).hexdigest()


def main():
    raw = ELF.read_bytes()
    if sha(raw) != EXPECTED:
        raise SystemExit("Input firmware hash mismatch; refusing capture")
    references, manifests = {}, {}
    for manifest_rel, paths in REFERENCES.items():
        p = ROOT / manifest_rel
        frozen = json.loads(p.read_text())
        if frozen["input_sha256"] != EXPECTED:
            raise SystemExit("Frozen evidence input mismatch")
        manifests[manifest_rel] = sha(p.read_bytes())
        for rel in paths:
            actual = sha((ROOT / rel).read_bytes())
            if frozen["files"].get(rel) != actual:
                raise SystemExit(f"Frozen evidence changed: {rel}")
            references[rel] = actual
    OUT.mkdir(exist_ok=True)
    records = []
    for name, start, end in RANGES:
        data = raw[start - 0x400000:end - 0x400000]
        dis = subprocess.check_output([
            OBJDUMP, "-d", f"--start-address={start:#x}",
            f"--stop-address={end:#x}", str(ELF.relative_to(ROOT)),
        ], cwd=ROOT, text=True)
        dis = "\n".join(line.rstrip() for line in dis.splitlines()).strip() + "\n"
        p = OUT / (name + ".disasm.txt")
        p.write_text("INPUT SHA256 " + EXPECTED +
                     "\nSTATIC ONLY: nearest-symbol labels are not private-function names.\n" + dis)
        records.append({"name": name, "start_va": hex(start),
                        "end_va_exclusive": hex(end), "file_offset": hex(start - 0x400000),
                        "bytes_hex": data.hex(), "bytes_sha256": sha(data),
                        "disassembly": str(p.relative_to(ROOT)),
                        "disassembly_sha256": sha(p.read_bytes())})
    tables = []
    for name, va, size in TABLES:
        data = raw[va - 0x400000:va - 0x400000 + size]
        tables.append({"name": name, "va": hex(va), "file_offset": hex(va - 0x400000),
                       "size": size, "bytes_hex": data.hex(), "sha256": sha(data)})
    # Bounded instruction-pattern inventory, not a proof against aliases or indirect writes.
    direct_accesses = []
    for va in range(0x869584, 0x86dbb0, 4):
        word = struct.unpack_from("<I", raw, va - 0x400000)[0]
        opcode = word & 0xffc00000
        if opcode in (0xb9000000, 0xb9400000, 0xbd000000, 0xbd400000):
            offset = ((word >> 10) & 0xfff) * 4
            if offset in (0xd6c, 0xdac):
                direct_accesses.append({"va": hex(va), "word_hex": f"{word:08x}",
                                        "offset": hex(offset),
                                        "operation": "store" if opcode in (0xb9000000, 0xbd000000) else "load"})
    exact = OUT / "exact_bytes.json"
    exact.write_text(json.dumps({
        "input_sha256": EXPECTED, "target_code_executed": False,
        "evidence_level": "static_instruction_and_bytes",
        "address_model": "linked AArch64 ET_EXEC; code/rodata file offset=VA-0x400000",
        "ranges": records, "tables": tables,
        "bounded_direct_offset_access_inventory": {"start_va": "0x869584", "end_va_exclusive": "0x86dbb0", "accesses": direct_accesses},
        "unchanged_frozen_references": references,
    }, indent=2) + "\n")
    paths = [Path(__file__).resolve(), exact,
             ROOT / "analysis/firmware/F4_DIMENSION_NEGOTIATION_STATIC.md"]
    paths += [ROOT / rec["disassembly"] for rec in records]
    manifest = {"input_sha256": EXPECTED, "evidence_level": "static_only",
                "files": {str(p.relative_to(ROOT)): sha(p.read_bytes()) for p in paths},
                "unchanged_frozen_references": references,
                "unchanged_frozen_manifests": manifests}
    dest = ROOT / "analysis/firmware/F4_DIMENSION_NEGOTIATION_SHA256.json"
    dest.write_text(json.dumps(manifest, indent=2) + "\n")
    print(f"Captured {len(records)} instruction windows and {len(tables)} byte tables; "
          f"manifest sha256 {sha(dest.read_bytes())}")


if __name__ == "__main__":
    main()
