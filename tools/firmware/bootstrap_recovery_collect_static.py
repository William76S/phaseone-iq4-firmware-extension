#!/usr/bin/env python3
"""IQ4 bootstrap/recovery narrow evidence capture. No target/SDK code execution."""
from pathlib import Path
import hashlib
import importlib.util
import json
import stat
import struct
import subprocess

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "analysis/firmware/bootstrap_recovery_static"
BOOT = "analysis/firmware/extracted/Boot_4.00.13.bin"
APP = "analysis/firmware/extracted/P1Linux_6.03.21.bin"
DISK = "analysis/firmware/P1_ramdisk.ext2"
BOUND = {
    BOOT: "7a3a3d6f62c61e7d627a9f55d844d74be9111b26eb7a7fa42f5bdd7be7dabe9e",
    APP: "9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb",
    DISK: "2ca2a497fb22cb3b16009f5dab2aad1f744982aaafb6c928ac688c0a3f9dbccb",
    "analysis/firmware/boot_inventory.json": "d75acf1247e82b20c867a5d9affd15e514a5f143ef8a260d0fd40f0141c0aace",
    "analysis/firmware/boot_environment.static.txt": "1291372f254498774b68cc66bcb0a094958e448cb70cabc33a71d34ac74556f7",
}
FROZEN = {
    "analysis/firmware/EXECUTION_CHANNEL_STATIC.md": "ef9a1e1c525e8effd673360b0ef7b7cd9ea8760fa9fe7ae7236325074dc943cb",
    "analysis/firmware/FILE405_OPEN_FAILURE_STATIC.md": "e6f832044457206eac5718f7e184bf3640df0ae4c088f284d5398d75c1be4683",
}
OBJDUMP = "/Library/Developer/CommandLineTools/usr/bin/llvm-objdump"
FSBL_OFFSET = 0x222E0
FSBL_SIZE = 0x1E3F8
FSBL_BASE = 0xFFFC0000
FSBL_RANGES = [
    ("fsbl_main_gpio_owner", 0xFFFD0B44, 0xFFFD0B80),
    ("fsbl_factory_user_environment_and_gpio17", 0xFFFD11B4, 0xFFFD13AC),
    ("fsbl_reset_writer_complete", 0xFFFC8B30, 0xFFFC8BAC),
    ("fsbl_gpio_pin_bank_bit", 0xFFFC1054, 0xFFFC10D8),
    ("fsbl_gpio_configure_direction", 0xFFFC36DC, 0xFFFC3770),
    ("fsbl_gpio_owner_configure", 0xFFFC381C, 0xFFFC38E0),
    ("fsbl_environment_strlen", 0xFFFD0A00, 0xFFFD0B40),
    ("fsbl_environment_copy", 0xFFFD0840, 0xFFFD0900),
]
SOURCES = [
    "/etc/inittab", "/etc/init.d/p1-rcS", "/etc/init.d/rcS",
    "/etc/init.d/p1-mdev.sh", "/etc/mdev.conf", "/etc/fstab",
    "/p1/scripts/mdev_hotplug_tracking.sh",
    "/etc/init.d/p1-mount-qspi-partitions.sh",
    "/etc/init.d/p1-link-to-user-storage.sh",
    "/etc/init.d/p1-create-user-or-factory-state.sh",
    "/etc/init.d/userhook.sh", "/etc/init.d/p1-late-userhook.sh",
    "/etc/init.d/p1-release-userapp.sh", "/p1/scripts/boot_run_p1linux.sh",
    "/etc/init.d/p1-setup-debug-network.sh", "/p1/scripts/setup-network.sh",
    "/etc/init.d/p1-enable-dev-services-if-debug-board.sh",
    "/etc/init.d/p1-create-zynqmp-pl-links.sh",
    "/p1/scripts/zynq_mio.functions", "/sbin/init_shell", "/etc/ld.so.conf",
]


def sha(data):
    return hashlib.sha256(data).hexdigest()


def write_json(path, obj):
    path.write_text(json.dumps(obj, indent=2, ensure_ascii=False) + "\n")


def fsbl_view(raw):
    """Section-only synthetic ELF for static decoding, not a loadable image."""
    names = b"\0.text\0.shstrtab\0"
    noff = 0x100 + FSBL_SIZE
    shoff = (noff + len(names) + 7) & ~7
    blob = bytearray(shoff + 3 * 64)
    ident = b"\x7fELF\x02\x01\x01" + bytes(9)
    blob[:64] = struct.pack("<16sHHIQQQIHHHHHH", ident, 2, 183, 1,
                           FSBL_BASE, 0, shoff, 0, 64, 0, 0, 64, 3, 2)
    blob[0x100:0x100 + FSBL_SIZE] = raw[FSBL_OFFSET:FSBL_OFFSET + FSBL_SIZE]
    blob[noff:noff + len(names)] = names
    struct.pack_into("<IIQQQQIIQQ", blob, shoff + 64,
                     1, 1, 6, FSBL_BASE, 0x100, FSBL_SIZE, 0, 0, 4, 0)
    struct.pack_into("<IIQQQQIIQQ", blob, shoff + 128,
                     7, 3, 0, 0, noff, len(names), 0, 0, 1, 0)
    return bytes(blob)


def main():
    inputs = {}
    for path, expected in {**BOUND, **FROZEN}.items():
        actual = sha((ROOT / path).read_bytes())
        if actual != expected:
            raise SystemExit("Unknown/changed source: " + path)
        inputs[path] = actual
    boot = (ROOT / BOOT).read_bytes()
    app = (ROOT / APP).read_bytes()
    if (ROOT / "analysis/firmware/boot_environment.static.txt").read_bytes() != boot[0x44891C0:0x448986B]:
        raise SystemExit("Environment does not match exact Boot bytes")
    # Mapping arithmetic from exact Boot header/partition words, not a live map.
    words = {hex(off): hex(struct.unpack_from("<I", boot, off)[0])
             for off in [0x2C, 0x30, 0x34, 0x3C, 0x1100, 0x1108, 0x1110, 0x1120]}
    assert struct.unpack_from("<I", boot, 0x2C)[0] == FSBL_BASE
    assert sum(struct.unpack_from("<II", boot, 0x30)) == FSBL_OFFSET
    assert struct.unpack_from("<I", boot, 0x3C)[0] == FSBL_SIZE
    assert 0x2800 + struct.unpack_from("<I", boot, 0x1100)[0] * 4 == FSBL_OFFSET + FSBL_SIZE
    OUT.mkdir(exist_ok=True)
    view = OUT / "fsbl_view.elf"
    view.write_bytes(fsbl_view(boot))
    ranges = []
    for name, start, end in FSBL_RANGES:
        offset = start - FSBL_BASE + FSBL_OFFSET
        data = boot[offset:offset + end - start]
        text = subprocess.check_output([OBJDUMP, "-d", f"--start-address={start:#x}",
                                       f"--stop-address={end:#x}", str(view.relative_to(ROOT))],
                                      cwd=ROOT, text=True)
        text = "\n".join(line.rstrip() for line in text.splitlines()).strip() + "\n"
        dest = OUT / (name + ".disasm.txt")
        dest.write_text("STATIC ONLY; synthetic section view, not a target executable.\n"
                        "SOURCE BOOT SHA256 " + BOUND[BOOT] + "\n" + text)
        ranges.append({"name": name, "boot_file_offset": hex(offset),
                       "proposed_va": hex(start), "end_proposed_va_exclusive": hex(end),
                       "bytes_hex": data.hex(), "bytes_sha256": sha(data),
                       "disassembly": str(dest.relative_to(ROOT)),
                       "disassembly_sha256": sha(dest.read_bytes())})
    tables = []
    for name, offset, size in [
        ("boot_header", 0x20, 0x80), ("boot_first_partition_header", 0x1100, 0x40),
        ("factory_user_strings", 0x362AC, 0x34),
        ("force_factory_and_jtag_strings", 0x36523, 0x43),
        ("gpio_configuration_table", 0x3FCE0, 0x18),
        ("fsbl_gpio_assert_source_name", 0x351FA, 0xA),
    ]:
        data = boot[offset:offset + size]
        tables.append({"name": name, "boot_file_offset": hex(offset), "size": size,
                       "bytes_hex": data.hex(), "sha256": sha(data)})
    write_json(OUT / "fsbl_exact_bytes.json", {
        "evidence_level": "static_bytes_and_instructions", "target_code_executed": False,
        "source_sha256": BOUND[BOOT], "header_words": words,
        "static_view_mapping": {"file_offset": hex(FSBL_OFFSET), "size": hex(FSBL_SIZE),
                                "proposed_va_base": hex(FSBL_BASE),
                                "runtime_mapping_verified": False,
                                "view_sha256": sha(view.read_bytes()),
                                "view_is_installable": False},
        "ranges": ranges, "tables": tables,
    })
    spec = importlib.util.spec_from_file_location("iq4_boot_static", ROOT / "tools/firmware/inspect_boot.py")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    disk = module.Ext2((ROOT / DISK).read_bytes())
    inventory = json.loads((ROOT / "analysis/firmware/boot_inventory.json").read_text())
    entries = {item["path"]: item for item in inventory["ramdisk"]["files"]}
    rootfs = []
    for path in SOURCES:
        item = entries[path]
        node = disk.inode(item["inode"])
        content, blocks = disk.contents(node)
        assert stat.S_ISREG(node["mode"]) and sha(content) == item["sha256"]
        rootfs.append({**item, "content_hex": content.hex(),
                       "text_lines": content.decode().splitlines()})
    rc_links = [{**item} for path, item in entries.items()
                if path.startswith("/etc/rcS.d/") and "symlink_target" in item]
    absent = [p for p in ["/etc/ld.so.preload", "/etc/ld.so.conf.d", "/etc/rc5.d"] if p not in entries]
    write_json(OUT / "rootfs_exact_sources.json", {
        "source_ramdisk_sha256": BOUND[DISK], "inventory_sha256": BOUND["analysis/firmware/boot_inventory.json"],
        "regular_files": rootfs, "rcS_original_symlinks": sorted(rc_links, key=lambda x: x["path"]),
        "absent_inventory_paths": absent,
    })
    trees = []
    for offset in [0x86430, 0xDD4440]:
        data, tree = module.device_tree(boot, offset)
        tree["properties"] = [p for p in tree["properties"]
                              if "gpio" in p["path"] or p["name"] in ["gpio-line-names", "bootargs"]
                              or "button" in p["path"] or "keys" in p["path"]]
        tree["device_tree_all_nodes_have_no_gpio_keys_or_line_names"] = not any(
            "gpio-keys" in p["path"] or p["name"] == "gpio-line-names"
            for p in module.device_tree(boot, offset)[1]["properties"])
        trees.append(tree)
    write_json(OUT / "gpio_device_tree_evidence.json", trees)
    # Full fixed-name whitelist; table itself is init-data (VA-file delta 0x410000).
    whitelist = []
    for index in range(86):
        offset = 0xB45F18 + index * 40
        rec = struct.unpack_from("<IIQIIIIQ", app, offset)
        strings = []
        for va in [rec[2], rec[7]]:
            pos = va - 0x400000
            end = app.index(0, pos)
            strings.append({"va": hex(va), "file_offset": hex(pos),
                            "bytes_hex": app[pos:end + 1].hex(),
                            "value": app[pos:end].decode()})
        whitelist.append({"index": index, "record_va": hex(offset + 0x410000),
                          "file_offset": hex(offset), "bytes_hex": app[offset:offset + 40].hex(),
                          "fields": list(rec), "name": strings[0], "description": strings[1]})
    write_json(OUT / "managed_fixed_file_table.json", {
        "input_sha256": BOUND[APP], "records": whitelist,
        "arbitrary_path_execution_contract": "not established",
    })
    paths = [Path(__file__).resolve(), ROOT / "analysis/firmware/BOOTSTRAP_RECOVERY_INCREMENT.md"]
    paths += sorted(p for p in OUT.iterdir() if p.is_file() and p.name != "fsbl_view.elf")
    write_json(ROOT / "analysis/firmware/BOOTSTRAP_RECOVERY_SHA256.json", {
        "evidence_level": "static_only", "input_sha256": inputs,
        "files": {str(p.relative_to(ROOT)): sha(p.read_bytes()) for p in paths},
        "private_disassembly_view_sha256": sha(view.read_bytes()),
    })
    print(f"Captured {len(ranges)} FSBL windows, {len(tables)} Boot tables, "
          f"{len(rootfs)} original rootfs files, {len(rc_links)} symlinks, 2 DT GPIO subsets, 86 file records.")


if __name__ == "__main__":
    main()
