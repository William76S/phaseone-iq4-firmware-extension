#!/usr/bin/env python3
"""Offline IQ4 F4 instruction/byte capture. Does not execute target code."""
from pathlib import Path
import hashlib
import json
import subprocess

ROOT = Path(__file__).resolve().parents[2]
ELF = ROOT / "analysis/firmware/extracted/P1Linux_6.03.21.bin"
EXPECTED = "9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb"
OBJDUMP = "/Library/Developer/CommandLineTools/usr/bin/llvm-objdump"
RANGES = [
    ("lv_access", 0x6b618c, 0x6b6300),
    ("video_buffer_lock_metadata", 0x6b6a3c, 0x6b6d70),
    ("video_buffer_reset", 0x787210, 0x787458),
    ("frame_producer", 0x787578, 0x787d40),
    ("lv_setup", 0x787e38, 0x788248),
    ("high_memory_layout", 0x793540, 0x7939c0),
    ("producer_dispatch_clock", 0x797278, 0x797350),
    ("native_clock", 0x717284, 0x71749c),
    ("jpeg_factory", 0x98cf48, 0x98cf94),
    ("jpeg_constructor", 0x98d0d8, 0x98d1dc),
    ("jpeg_rgb24_encode", 0x98d680, 0x98d950),
    ("jpeg_mem_dest", 0x9a2658, 0x9a2a18),
    ("jpeg_destructor", 0x98ddd0, 0x98ddf4),
    ("jpeg_storage_main_bind", 0x424b80, 0x424bd4),
    ("jpeg_storage_constructor", 0x8e0928, 0x8e0aa8),
    ("jpeg_storage_task", 0x8e17c8, 0x8e1d70),
    ("jpeg_storage_write", 0x8e1d70, 0x8e1f7c),
    ("jpeg_storage_choose_file", 0x8e1f7c, 0x8e22d4),
    ("file_manager_constructor", 0x74d888, 0x74db38),
    ("file_manager_folder_resolve", 0x74e454, 0x74e5a8),
    ("file_system_resolver", 0x6aff60, 0x6b106c),
    ("storage_lease", 0x8ca598, 0x8ca9f4),
    ("file_stream", 0x825770, 0x825a24),
    ("linux_fs_open", 0x825ed4, 0x826010),
    ("linux_fs_rename", 0x8267dc, 0x8268a4),
    ("linux_fs_close_write", 0x826ca8, 0x826ea4),
    ("linux_fs_fsync", 0x82721c, 0x82728c),
    ("lv_page_paint", 0x51da0c, 0x51df3c),
    ("lv_page_start_stop", 0x5202a0, 0x520684),
]

def sha(data):
    return hashlib.sha256(data).hexdigest()

def main():
    raw = ELF.read_bytes()
    if sha(raw) != EXPECTED:
        raise SystemExit("Input firmware hash mismatch; refusing evidence capture")
    out = ROOT / "analysis/firmware/f4_static"
    out.mkdir(exist_ok=True)
    records = []
    for name, start, end in RANGES:
        data = raw[start - 0x400000:end - 0x400000]
        text = subprocess.check_output([
            OBJDUMP, "-d", f"--start-address={start:#x}",
            f"--stop-address={end:#x}", str(ELF.relative_to(ROOT)),
        ], cwd=ROOT, text=True)
        # These are stripped private functions. Nearest-symbol labels can mislead.
        text = "INPUT SHA256 " + EXPECTED + "\nSTATIC ONLY: nearest private-function symbol labels are not authoritative.\n" + text
        path = out / (name + ".disasm.txt")
        path.write_text(text)
        records.append({"name": name, "start_va": hex(start), "end_va_exclusive": hex(end),
                        "file_offset": hex(start - 0x400000), "bytes_hex": data.hex(),
                        "bytes_sha256": sha(data), "disassembly": str(path.relative_to(ROOT)),
                        "disassembly_sha256": sha(path.read_bytes())})
    tables = []
    for name, va, size, delta in [
        ("jpeg_vtable", 0xdce100, 0x40, 0x400000),
        ("linux_fs_vtable", 0xd91450, 0x140, 0x400000),
        ("file_manager_folders", 0xf55cb8, 19 * 32, 0x410000),
        ("rgb_channel_defaults", 0xd732f8, 8, 0x400000),
    ]:
        data = raw[va - delta:va - delta + size]
        tables.append({"name": name, "va": hex(va), "file_offset": hex(va-delta),
                       "size": size, "bytes_hex": data.hex(), "sha256": sha(data)})
    record = {"input_sha256": EXPECTED, "evidence_level": "static_instruction_and_bytes",
              "address_model": "linked AArch64 ET_EXEC; code/rodata offset=VA-0x400000, initialized data offset=VA-0x410000",
              "target_code_executed": False, "ranges": records, "tables": tables}
    (out / "exact_bytes.json").write_text(json.dumps(record, indent=2) + "\n")
    paths = [Path(__file__).resolve(), out / "exact_bytes.json"]
    paths += sorted(out.glob("*.disasm.txt"))
    paths += [ROOT / "analysis/firmware/F4_NATIVE_RECORDING.md"]
    for directory in ["decompiled_f4", "decompiled_f4_card", "decompiled_f4_card_fs"]:
        paths += sorted((ROOT / "analysis/firmware" / directory).glob("*.c"))
    paths += sorted((ROOT / "analysis/firmware").glob("f4*_decompile_targets.txt"))
    manifest = {"input_sha256": EXPECTED, "evidence_level": "static_only",
                "files": {str(p.relative_to(ROOT)): sha(p.read_bytes()) for p in paths if p.exists()}}
    dest = ROOT / "analysis/firmware/F4_STATIC_EVIDENCE_SHA256.json"
    dest.write_text(json.dumps(manifest, indent=2) + "\n")
    print(f"Captured {len(records)} instruction windows and {len(tables)} byte tables; manifest sha256 {sha(dest.read_bytes())}")

if __name__ == "__main__":
    main()
