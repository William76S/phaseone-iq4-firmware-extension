#!/usr/bin/env python3
"""Capture the IQ4 LV event chain offline; never loads or executes target code."""
from pathlib import Path
import hashlib
import json
import subprocess

ROOT = Path(__file__).resolve().parents[2]
ELF = ROOT / "analysis/firmware/extracted/P1Linux_6.03.21.bin"
EXPECTED = "9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb"
OBJDUMP = "/Library/Developer/CommandLineTools/usr/bin/llvm-objdump"
OUT = ROOT / "analysis/firmware/f4_source_event_static"
RANGES = [
    ("main_irq_setup_and_lv_registration", 0x422578, 0x422640),
    ("main_irq_thread", 0x422758, 0x4227d8),
    ("lv_event_member_getter", 0x42fa84, 0x42fa9c),
    ("lv_event_engine_getter", 0x42fbc8, 0x42fbec),
    ("lv_manager_constructor", 0x798038, 0x798164),
    ("lv_manager_engine_binding", 0x7995b4, 0x7995e0),
    ("lv_manager_wait_filter", 0x79e240, 0x79e314),
    ("lv_manager_producer_gate", 0x79e710, 0x79e738),
    ("pl_irq_constructor", 0x7896d4, 0x789728),
    ("pl_irq_dispatch", 0x789728, 0x789918),
    ("pl_irq_mask", 0x789918, 0x789a8c),
    ("pl_irq_registration", 0x789a8c, 0x789acc),
    ("uio_constructor", 0x76e6c0, 0x76e75c),
    ("uio_wait", 0x76e7c0, 0x76e8bc),
    ("event_observer_notify", 0x70f474, 0x70f4b8),
    ("listener_constructor_owner", 0x710548, 0x710588),
    ("listener_notify_and_pending_clear", 0x710820, 0x710880),
    ("queue_post", 0x713c6c, 0x713d40),
    ("pending_test_set", 0x714490, 0x7144d4),
    ("queue_pop_clear", 0x713918, 0x713978),
    ("producer_dispatch_clock", 0x797278, 0x79738c),
]
TABLES = [
    ("uio_vtable_and_type", 0xc40b48, 0xa8),
    ("pl_irq_vtable_and_type", 0xc46988, 0x50),
    ("lv_manager_vtable", 0xd73050, 0x28),
    ("lv_manager_typeinfo", 0xd72fb0, 0x10),
    ("lv_manager_type_name", 0xd72f98, 0x18),
    ("event_listener_vtable", 0xc23c80, 0x28),
    ("uio_device_and_thread_names", 0x9f5708, 0x28),
    ("lv_manager_and_event_names", 0xd739e0, 0x20),
]
FROZEN_REFERENCES = [
    "analysis/firmware/f4_static/frame_producer.disasm.txt",
    "analysis/firmware/f4_static/video_buffer_lock_metadata.disasm.txt",
    "analysis/firmware/f4_static/native_clock.disasm.txt",
]


def sha(data):
    return hashlib.sha256(data).hexdigest()


def main():
    raw = ELF.read_bytes()
    if sha(raw) != EXPECTED:
        raise SystemExit("Input firmware hash mismatch; refusing capture")
    frozen_path = ROOT / "analysis/firmware/F4_STATIC_EVIDENCE_SHA256.json"
    frozen = json.loads(frozen_path.read_text())
    if frozen["input_sha256"] != EXPECTED:
        raise SystemExit("Frozen evidence input mismatch")
    references = {}
    for rel in FROZEN_REFERENCES:
        actual = sha((ROOT / rel).read_bytes())
        if frozen["files"].get(rel) != actual:
            raise SystemExit(f"Frozen evidence changed: {rel}")
        references[rel] = actual
    OUT.mkdir(exist_ok=True)
    records = []
    for name, start, end in RANGES:
        data = raw[start - 0x400000:end - 0x400000]
        disassembly = subprocess.check_output([
            OBJDUMP, "-d", f"--start-address={start:#x}",
            f"--stop-address={end:#x}", str(ELF.relative_to(ROOT)),
        ], cwd=ROOT, text=True)
        disassembly = "\n".join(line.rstrip() for line in disassembly.splitlines()).strip() + "\n"
        header = "INPUT SHA256 " + EXPECTED + "\nSTATIC ONLY: nearest-symbol labels are not private-function names.\n"
        path = OUT / (name + ".disasm.txt")
        path.write_text(header + disassembly)
        records.append({"name": name, "start_va": hex(start), "end_va_exclusive": hex(end),
                        "file_offset": hex(start - 0x400000), "bytes_hex": data.hex(),
                        "bytes_sha256": sha(data), "disassembly": str(path.relative_to(ROOT)),
                        "disassembly_sha256": sha(path.read_bytes())})
    tables = []
    for name, va, size in TABLES:
        data = raw[va - 0x400000:va - 0x400000 + size]
        tables.append({"name": name, "va": hex(va), "file_offset": hex(va - 0x400000),
                       "size": size, "bytes_hex": data.hex(), "sha256": sha(data)})
    exact = OUT / "exact_bytes.json"
    exact.write_text(json.dumps({"input_sha256": EXPECTED, "evidence_level": "static_instruction_and_bytes",
                                "target_code_executed": False,
                                "address_model": "linked AArch64 ET_EXEC; code/rodata file offset=VA-0x400000",
                                "ranges": records, "tables": tables,
                                "unchanged_frozen_references": references}, indent=2) + "\n")
    paths = [Path(__file__).resolve(), exact,
             ROOT / "analysis/firmware/F4_SOURCE_EVENT_STATIC.md",
             ROOT / "analysis/firmware/f4_source_event_decompile_targets.txt"]
    paths += [ROOT / rec["disassembly"] for rec in records]
    manifest = {"input_sha256": EXPECTED, "evidence_level": "static_only",
                "files": {str(p.relative_to(ROOT)): sha(p.read_bytes()) for p in paths},
                "unchanged_frozen_references": references,
                "frozen_manifest_sha256": sha(frozen_path.read_bytes())}
    dest = ROOT / "analysis/firmware/F4_SOURCE_EVENT_SHA256.json"
    dest.write_text(json.dumps(manifest, indent=2) + "\n")
    print(f"Captured {len(records)} instruction windows and {len(tables)} byte tables; "
          f"manifest sha256 {sha(dest.read_bytes())}")


if __name__ == "__main__":
    main()
