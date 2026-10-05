#!/usr/bin/env python3
"""Freeze narrow LV owner/frame-adapter evidence; never execute target code."""
from pathlib import Path
import bisect
import hashlib
import json
import shutil
import subprocess

ROOT = Path(__file__).resolve().parents[2]
ELF = ROOT / "analysis/firmware/extracted/P1Linux_6.03.21.bin"
INPUT_SHA = "9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb"
OUT = ROOT / "analysis/firmware/f4_frame_adapter_increment_01"
# Full C++ functions use next .eh_frame-derived function start as the end.
FUNCTIONS = [
    ("access_constructor", 0x6b56ec),
    ("register_client", 0x6b58e0),
    ("get_client_name", 0x6b5998),
    ("validate_client", 0x6b59fc),
    ("acquire_owner", 0x6b5a6c),
    ("release_owner", 0x6b5c44),
    ("access_frame_property", 0x6b612c),
    ("access_lock", 0x6b618c),
    ("access_size", 0x6b61fc),
    ("access_crop_hidden_x8", 0x6b621c),
    ("access_unlock", 0x6b6250),
    ("access_frame_id", 0x6b62c0),
    ("video_buffer_lock", 0x6b6a3c),
    ("video_buffer_unlock", 0x6b6b30),
    ("video_buffer_size", 0x6b6b70),
    ("video_buffer_crop", 0x6b6be0),
    ("video_buffer_frame_id", 0x6b6c80),
    ("engine_frame_property", 0x6b6d04),
    ("engine_lock", 0x6b6d1c),
    ("owner_mutex_trylock", 0x71208c),
    ("owner_mutex_unlock_thread_check", 0x712204),
    ("mutex_native_trylock", 0x712360),
    ("mutex_trylock_wrapper", 0x7123f4),
    ("mutex_trylock_boolean", 0x712464),
    ("frame_dispatch_and_postproduce_signal", 0x797278),
    ("observer_register", 0x70fed8),
    ("observer_unregister", 0x70ff08),
    ("iqp_frame_event_callback", 0x869ce4),
    ("iqp_lock_and_duplicate_rejection", 0x86b690),
    ("iqp_frame_header_packed_stride", 0x86bd58),
    ("iqp_frame_finish_unlock", 0x86c288),
    ("image_descriptor_constructor", 0x45fe8c),
    ("native_lv_paint", 0x51da0c),
    ("native_lv_start", 0x5202a0),
    ("native_lv_stop", 0x520590),
    ("save_lv_bmp_packed_source_rows", 0x7b2488),
    ("native_command_dispatch_complete", 0x7b2610),
    ("cache_range_wrapper", 0x78bd64),
    ("cache_range_pointer_end", 0x78bdb4),
    ("rgb24_to_display_wrapper", 0x47e930),
    ("surface_unrotated_source_stride", 0x47552c),
    ("surface_format_conversion_dispatch", 0x47f910),
]
# Windows are explicitly labelled; no claim that these are whole functions.
WINDOWS = [
    ("main_live_view_access_binding", 0x41ef48, 0x41efe8),
    ("ui_access_origin", 0x517698, 0x5176b8),
    ("ui_client_registration", 0x517b68, 0x517b8c),
    ("hdmi_client_registration", 0x57aa50, 0x57aa74),
    ("third_client_registration", 0x82b814, 0x82b83c),
    ("iqp_client_and_frame_observer_registration", 0x869810, 0x869874),
    ("fifth_client_registration", 0x8ce1e8, 0x8ce210),
    ("rgb24_display_dispatch", 0x47fbe8, 0x47fc44),
    ("save_lv_command_registration", 0x7b2274, 0x7b2294),
]
ASSEMBLY_FUNCTIONS = [
    # No unwind entries. End is the return plus any immediate alignment nop.
    ("cache_clean_invalidate_civac_dsb", 0x9ef058, 0x9ef0b0),
    ("rgb24_to_display_argb_bytes", 0x9e9598, 0x9e9700),
]
TABLES = [
    ("access_names_diagnostics", 0xc079a8, 0x280),
    ("ui_live_view_client_name", 0xb9a4e0, 0x40),
    ("hdmi_client_name", 0xbb0758, 0x40),
    ("third_client_name", 0xd920d0, 0x40),
    ("save_lv_command_names", 0xd83a98, 0x38),
    ("save_bmp_modes_and_path_prefix", 0xd83b28, 0x40),
    ("command_jump_table_s16", 0xd831d8, 28 * 2),
]
FROZEN_REFERENCES = [
    "analysis/firmware/F4_NATIVE_RECORDING.md",
    "analysis/firmware/F4_NATIVE_UI.md",
    "analysis/firmware/F4_SOURCE_EVENT_STATIC.md",
    "analysis/firmware/F4_DIMENSION_NEGOTIATION_STATIC.md",
    "analysis/firmware/UI_JPEG_ABI.md",
    "analysis/firmware/F4_STATIC_EVIDENCE_SHA256.json",
    "analysis/firmware/F4_SOURCE_EVENT_SHA256.json",
]


def sha(data):
    return hashlib.sha256(data).hexdigest()


def main():
    raw = ELF.read_bytes()
    if len(raw) != 11874544 or sha(raw) != INPUT_SHA:
        raise SystemExit("Exact module identity mismatch; refusing capture")
    objdump = Path("/Library/Developer/CommandLineTools/usr/bin/llvm-objdump")
    if not objdump.is_file():
        located = shutil.which("llvm-objdump")
        if not located:
            raise SystemExit("llvm-objdump unavailable; preserve source and install no tool")
        objdump = Path(located)
    unwind_path = ROOT / "analysis/firmware/unwind_functions.json"
    unwind = json.loads(unwind_path.read_text())["functions"]
    ranges = []
    for name, start in FUNCTIONS:
        i = bisect.bisect_left(unwind, start)
        if i == len(unwind) or unwind[i] != start:
            raise SystemExit(f"Missing exact function boundary: {name}")
        ranges.append((name, start, unwind[i + 1], "complete_unwind_function"))
    ranges += [(name, start, end, "partial_instruction_window")
               for name, start, end in WINDOWS]
    ranges += [(name, start, end, "complete_leaf_assembly_return_boundary")
               for name, start, end in ASSEMBLY_FUNCTIONS]
    OUT.mkdir(exist_ok=True)
    records = []
    for name, start, end, scope in ranges:
        data = raw[start - 0x400000:end - 0x400000]
        dis = subprocess.check_output([
            str(objdump), "-d", f"--start-address={start:#x}",
            f"--stop-address={end:#x}", str(ELF.relative_to(ROOT)),
        ], cwd=ROOT, text=True)
        dis = "\n".join(line.rstrip() for line in dis.splitlines()).strip() + "\n"
        path = OUT / (name + ".disasm.txt")
        path.write_text("INPUT SHA256 " + INPUT_SHA + "\n"
                        "STATIC ONLY: nearest-symbol labels are not private-function names.\n"
                        "SCOPE " + scope + "\n" + dis)
        records.append({"name": name, "scope": scope, "start_va": hex(start),
                        "end_va_exclusive": hex(end), "file_offset": hex(start - 0x400000),
                        "byte_length": len(data), "bytes_hex": data.hex(),
                        "bytes_sha256": sha(data), "disassembly": str(path.relative_to(ROOT)),
                        "disassembly_sha256": sha(path.read_bytes())})
    tables = []
    for name, va, size in TABLES:
        data = raw[va - 0x400000:va - 0x400000 + size]
        tables.append({"name": name, "va": hex(va), "file_offset": hex(va - 0x400000),
                       "size": size, "bytes_hex": data.hex(), "sha256": sha(data)})
    jump = raw[0xd831d8 - 0x400000:0xd831d8 - 0x400000 + 56]
    id25 = int.from_bytes(jump[50:52], "little", signed=True)
    if 0x7b265c + 4 * id25 != 0x7b3d44:
        raise SystemExit("SaveLvFrame command mapping mismatch")
    refs = {rel: sha((ROOT / rel).read_bytes()) for rel in FROZEN_REFERENCES}
    evidence = {"input_sha256": INPUT_SHA, "input_bytes": len(raw),
                "evidence_level": "static_instruction_and_bytes", "target_code_executed": False,
                "camera_access": False, "address_model": "linked AArch64 ET_EXEC; code/rodata offset=VA-0x400000",
                "unwind_source_sha256": sha(unwind_path.read_bytes()),
                "ranges": records, "tables": tables,
                "save_lv_command_id": 25, "save_lv_case_target_va": "0x7b3d44",
                "existing_reference_hashes_at_capture": refs}
    exact = OUT / "exact_bytes.json"
    exact.write_text(json.dumps(evidence, indent=2) + "\n")
    files = [Path(__file__).resolve(), exact, OUT / "README.md", OUT / "adapter_contract.json"]
    files += [ROOT / r["disassembly"] for r in records]
    manifest = OUT / "SHA256.json"
    manifest.write_text(json.dumps({"input_sha256": INPUT_SHA,
                                  "evidence_level": "static_only", "target_code_executed": False,
                                  "files": {str(p.relative_to(ROOT)): sha(p.read_bytes()) for p in files},
                                  "existing_reference_hashes_at_capture": refs}, indent=2) + "\n")
    print(f"Captured {len(records)} complete functions/windows and {len(tables)} tables; "
          f"manifest SHA256 {sha(manifest.read_bytes())}")


if __name__ == "__main__":
    main()
