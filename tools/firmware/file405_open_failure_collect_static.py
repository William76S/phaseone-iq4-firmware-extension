#!/usr/bin/env python3
"""Offline FileId405 path/error evidence; no SDK or target code execution."""
from pathlib import Path
import hashlib
import json
import subprocess

ROOT = Path(__file__).resolve().parents[2]
ELF = ROOT / "analysis/firmware/extracted/P1Linux_6.03.21.bin"
EXPECTED = "9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb"
OBJDUMP = "/Library/Developer/CommandLineTools/usr/bin/llvm-objdump"
OUT = ROOT / "analysis/firmware/file405_open_failure_static"
RANGES = [
    ("folder_cached_linux_owner", 0x74e454, 0x74e534),
    ("file_id_to_folder_owner", 0x74e5a8, 0x74e634),
    ("linux_relative_path_join", 0x827418, 0x82744c),
]
TABLES = [
    ("user_application_and_upgrade_entries", 0xf56030, 80, 0x410000),
    ("factory_application_and_upgrade_entries", 0xf56288, 80, 0x410000),
    ("user_factory_folders", 0xf55d38, 64, 0x410000),
    ("user_factory_path_strings", 0xc35468, 0x40, 0x400000),
    ("application_name_strings", 0xc356a0, 0x38, 0x400000),
    ("linux_fs_open_vtable", 0xd91450, 0x30, 0x400000),
]
REFERENCES = [
    ("analysis/firmware/FILE_READ_TRANSPORT_SHA256.json", [
        "analysis/firmware/read_channel_static/file_client_open.disasm.txt",
        "analysis/firmware/read_channel_static/linux_fs_open_flags.disasm.txt",
        "analysis/firmware/read_channel_static/file_read_open_start.disasm.txt",
    ]),
    ("analysis/firmware/F4_STATIC_EVIDENCE_SHA256.json", [
        "analysis/firmware/f4_static/file_manager_constructor.disasm.txt",
    ]),
]
SCRIPTS = [
    "analysis/firmware/rootfs_static/etc/init.d/p1-link-to-user-storage.sh",
    "analysis/firmware/rootfs_static/etc/init.d/p1-mount-qspi-partitions.sh",
    "analysis/firmware/rootfs_static/p1/scripts/boot_run_p1linux.sh",
]


def sha(data):
    return hashlib.sha256(data).hexdigest()


def main():
    raw = ELF.read_bytes()
    if sha(raw) != EXPECTED:
        raise SystemExit("Firmware hash mismatch")
    frozen_references = {}
    for manifest_rel, paths in REFERENCES:
        manifest = json.loads((ROOT / manifest_rel).read_text())
        if manifest["input_sha256"] != EXPECTED:
            raise SystemExit("Frozen reference input mismatch")
        for rel in paths:
            actual = sha((ROOT / rel).read_bytes())
            if manifest["files"].get(rel) != actual:
                raise SystemExit(f"Frozen reference changed: {rel}")
            frozen_references[rel] = actual
    OUT.mkdir(exist_ok=True)
    records = []
    for name, start, end in RANGES:
        data = raw[start - 0x400000:end - 0x400000]
        text = subprocess.check_output([
            OBJDUMP, "-d", f"--start-address={start:#x}",
            f"--stop-address={end:#x}", str(ELF.relative_to(ROOT)),
        ], cwd=ROOT, text=True)
        text = "\n".join(line.rstrip() for line in text.splitlines()).strip() + "\n"
        path = OUT / (name + ".disasm.txt")
        path.write_text("INPUT SHA256 " + EXPECTED +
                        "\nSTATIC ONLY: nearest-symbol labels are not private-function names.\n" + text)
        records.append({"name": name, "start_va": hex(start), "end_va_exclusive": hex(end),
                        "file_offset": hex(start - 0x400000), "bytes_hex": data.hex(),
                        "bytes_sha256": sha(data), "disassembly": str(path.relative_to(ROOT)),
                        "disassembly_sha256": sha(path.read_bytes())})
    tables = []
    for name, va, size, delta in TABLES:
        data = raw[va - delta:va - delta + size]
        tables.append({"name": name, "va": hex(va), "file_offset": hex(va - delta),
                       "size": size, "bytes_hex": data.hex(), "sha256": sha(data)})
    scripts = {rel: sha((ROOT / rel).read_bytes()) for rel in SCRIPTS}
    exact = OUT / "exact_bytes.json"
    exact.write_text(json.dumps({"input_sha256": EXPECTED, "evidence_level": "static_only",
                                "target_code_executed": False, "ranges": records,
                                "tables": tables, "unchanged_frozen_references": frozen_references,
                                "unchanged_rootfs_scripts": scripts}, indent=2) + "\n")
    files = [Path(__file__).resolve(), exact, ROOT / "analysis/firmware/FILE405_OPEN_FAILURE_STATIC.md"]
    files += [ROOT / r["disassembly"] for r in records]
    manifest = {"input_sha256": EXPECTED, "evidence_level": "static_only",
                "files": {str(p.relative_to(ROOT)): sha(p.read_bytes()) for p in files},
                "unchanged_frozen_references": frozen_references,
                "unchanged_rootfs_scripts": scripts}
    path = ROOT / "analysis/firmware/FILE405_OPEN_FAILURE_SHA256.json"
    path.write_text(json.dumps(manifest, indent=2) + "\n")
    print(f"Captured {len(records)} windows/{len(tables)} tables; manifest sha256 {sha(path.read_bytes())}")


if __name__ == "__main__":
    main()
