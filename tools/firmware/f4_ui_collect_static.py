#!/usr/bin/env python3
"""Hash-bound offline native IQ4 UI evidence; never execute target code."""
from pathlib import Path
import hashlib
import json
import re
import subprocess

ROOT = Path(__file__).resolve().parents[2]
ELF = ROOT / "analysis/firmware/extracted/P1Linux_6.03.21.bin"
EXPECTED = "9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb"
OBJDUMP = "/Library/Developer/CommandLineTools/usr/bin/llvm-objdump"
RANGES = [
    ("dialog_constructor_destructor", 0x4e10c4, 0x4e1270),
    ("dialog_show_close_request", 0x4e1270, 0x4e151c),
    ("close_delegate", 0x4e18b8, 0x4e194c),
    ("manager_top_levels", 0x4e21b4, 0x4e24e8),
    ("manager_stack_lifecycle", 0x4e24e8, 0x4e2dc8),
    ("manager_hardware_keys", 0x4e3b78, 0x4e4110),
    ("manager_close_request", 0x4e4820, 0x4e4898),
    ("menu_base_submenu", 0x4e5718, 0x4e5834),
    ("menu_append", 0x4e58b8, 0x4e5990),
    ("dialog_menu_item", 0x4e8400, 0x4e875c),
    ("native_menu_callsite", 0x4f1f08, 0x4f1f40),
    ("lv_allocation_registration", 0x4eeee0, 0x4eef70),
    ("control_lifecycle_placement", 0x4ab740, 0x4ab9d8),
    ("control_touch_binding", 0x4ac590, 0x4ac740),
    ("control_pointer_down_up", 0x4ac774, 0x4ac8c8),
    ("event_kind_pointer", 0x4acc5c, 0x4acc94),
    ("simple_button", 0x4cf9f8, 0x4cfc90),
    ("icon_button", 0x4d3ef0, 0x4d3ffc),
    ("icon_button_base", 0x4aee7c, 0x4aef54),
    ("native_icon_button_bind", 0x518ed0, 0x518f70),
    ("lv_enter_exit", 0x51d884, 0x51da0c),
    ("lv_paint_return_abi", 0x51da0c, 0x51da70),
    ("lv_pointer_down_up", 0x51e1f8, 0x51e3d4),
    ("lv_hardware_keys_thunks", 0x51f184, 0x51f338),
    ("lv_control_observer", 0x51f9fc, 0x5202a0),
    ("lv_start_stop", 0x5202a0, 0x520684),
    ("lv_destroy", 0x521118, 0x5212a4),
    ("intrusive_control_attach", 0x70c600, 0x70c784),
    ("intrusive_control_detach", 0x70c9bc, 0x70ca84),
]
TABLES = [
    ("dialog_primary_vtable", 0xb8eca8, 0x1b0),
    ("dialog_manager_vtable", 0xb8f358, 0xb8),
    ("lv_primary_vtable", 0xb9a9d8, 0x1d8),
    ("lv_hardware_key_vtable", 0xb9abc0, 0x28),
    ("lv_stack_node_vtable", 0xb9abf8, 0x50),
    ("lv_property_observer_vtable", 0xb9ac58, 0x18),
    ("lv_control_observer_vtable", 0xb9ac80, 0x18),
    ("dialog_menu_item_vtable", 0xb901d8, 0xa0),
    ("submenu_item_vtable", 0xb8f9b8, 0x98),
    ("simple_button_vtable", 0xb8b260, 0x148),
    ("icon_button_vtable", 0xb8c7b0, 0x180),
    ("lv_class_source", 0xb9a598, 0x60),
    ("menu_class_source", 0xb90108, 0x98),
    ("lv_object_name", 0xb918a0, 0x10),
]


def sha(data):
    return hashlib.sha256(data).hexdigest()


def main():
    raw = ELF.read_bytes()
    if sha(raw) != EXPECTED:
        raise SystemExit("Input firmware mismatch; refusing UI evidence capture")
    out = ROOT / "analysis/firmware/f4_ui_static"
    out.mkdir(exist_ok=True)
    records = []
    for name, start, end in RANGES:
        data = raw[start-0x400000:end-0x400000]
        disassembly = subprocess.check_output([
            OBJDUMP, "-d", f"--start-address={start:#x}",
            f"--stop-address={end:#x}", str(ELF.relative_to(ROOT)),
        ], cwd=ROOT, text=True)
        # Private nearest-symbol labels are not function identities.
        lines = [line.split(" <")[0].split(" //")[0].rstrip() for line in disassembly.splitlines()
                 if re.match(r"  [0-9a-f]+:", line)]
        text = "INPUT SHA256 " + EXPECTED + "\nSTATIC ONLY; private names and recovered types are provisional.\n"
        text += "\n".join(lines) + "\n"
        path = out / (name + ".disasm.txt")
        path.write_text(text)
        records.append({"name": name, "start_va": hex(start),
                        "end_va_exclusive": hex(end), "file_offset": hex(start-0x400000),
                        "bytes_hex": data.hex(), "bytes_sha256": sha(data),
                        "disassembly": str(path.relative_to(ROOT)),
                        "disassembly_sha256": sha(path.read_bytes())})
    tables = []
    for name, va, size in TABLES:
        data = raw[va-0x400000:va-0x400000+size]
        tables.append({"name": name, "va": hex(va), "file_offset": hex(va-0x400000),
                       "size": size, "bytes_hex": data.hex(), "sha256": sha(data)})
    exact = {"input_sha256": EXPECTED, "evidence_level": "static_instruction_and_bytes",
             "address_model": "AArch64 ELF64 ET_EXEC; these code/rodata offsets=VA-0x400000",
             "target_code_executed": False, "ranges": records, "tables": tables}
    (out / "exact_bytes.json").write_text(json.dumps(exact, indent=2) + "\n")
    paths = [Path(__file__).resolve(), out / "exact_bytes.json",
             ROOT / "analysis/firmware/f4_ui_decompile_targets.txt",
             ROOT / "analysis/firmware/F4_NATIVE_UI.md"]
    paths += sorted(out.glob("*.disasm.txt"))
    paths += sorted((ROOT / "analysis/firmware/decompiled_f4_ui").glob("*.c"))
    manifest = {"input_sha256": EXPECTED, "evidence_level": "static_only",
                "files": {str(p.relative_to(ROOT)): sha(p.read_bytes()) for p in paths if p.exists()}}
    dest = ROOT / "analysis/firmware/F4_UI_STATIC_EVIDENCE_SHA256.json"
    dest.write_text(json.dumps(manifest, indent=2) + "\n")
    print(f"Captured {len(records)} UI instruction windows and {len(tables)} byte tables; "
          f"manifest sha256 {sha(dest.read_bytes())}")


if __name__ == "__main__":
    main()
