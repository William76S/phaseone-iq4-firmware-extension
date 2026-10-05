#!/usr/bin/env python3
"""Offline IQ4 User-only FWR/FWP candidate. Never installs or edits its inputs."""
from __future__ import annotations
import argparse
import hashlib
import io
import json
from pathlib import Path
import re
import struct
import xml.etree.ElementTree as ET
import zipfile
import zlib

FWR_SHA = "a52758ffb163023e5323297e450450f91002175b69bed7590fe2cd037c2ab300"
USER_SHA = "9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb"
USER_NAME = "P1Linux_6.03.21.bin"
USER_SIZE = 11874544
HEADER_SIZE = 180
RELEASE = (6, 3, 18)
APP = (6, 3, 21)
INNER_NAME = "iq4-user-only.fwr"
ROOT = Path(__file__).resolve().parents[3]
DEFAULT_FWR = ROOT.parent / "Firmware-BP-IQ4-IQ4_6.03.18.fwr"

def sha(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()

def version(text: str) -> tuple[int, int, int]:
    if not re.fullmatch(r"[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,5}", text):
        raise ValueError("version must be explicit decimal major.minor.patch")
    result = tuple(int(x) for x in text.split("."))
    if result[0] > 255 or result[1] > 255 or result[2] > 65535:
        raise ValueError("version exceeds original U8/U8/U16 fields")
    return result

def text_version(v: tuple[int, int, int]) -> str:
    return f"{v[0]}.{v[1]:02d}.{v[2]}"

def elf_layout(data: bytes) -> dict:
    """Host review, not a claim that the updater validates or boots arbitrary ELF."""
    if len(data) < 64 or len(data) > 0x7fffffff or data[:7] != b"\x7fELF\x02\x01\x01":
        raise ValueError("ELF64 little-endian body must fit positive signed extractor result")
    fields = struct.unpack_from("<HHIQQQIHHHHHH", data, 16)
    if fields[0:3] != (2, 183, 1):
        raise ValueError("payload must target AArch64 ET_EXEC")
    ph, sh = fields[4], fields[5]
    phsize, phcount, shsize, shcount = fields[8], fields[9], fields[10], fields[11]
    if fields[7] != 64 or phsize != 56 or not phcount or shsize != 64 or not shcount:
        raise ValueError("ordinary bounded ELF tables required; extended numbering is not supported by this host tool")
    if ph + phsize * phcount > len(data) or sh + shsize * shcount > len(data):
        raise ValueError("ELF table bounds")
    programs = [struct.unpack_from("<IIQQQQQQ", data, ph + phsize * i) for i in range(phcount)]
    loads, interp = [], []
    for kind, flags, offset, va, _pa, filesz, memsz, align in programs:
        if offset + filesz > len(data):
            raise ValueError("program body extends beyond candidate")
        if kind == 1:
            if filesz > memsz or va + memsz > 0xffffffffffffffff:
                raise ValueError("PT_LOAD extent")
            if align not in (0, 1) and (align & (align - 1) or (va - offset) % align):
                raise ValueError("PT_LOAD alignment")
            loads.append({"flags": flags, "offset": offset, "va": va, "file_size": filesz,
                          "memory_size": memsz, "alignment": align})
        if kind == 3:
            body = data[offset:offset + filesz]
            if not body.endswith(b"\0") or b"\0" in body[:-1]:
                raise ValueError("PT_INTERP not a single terminated path")
            interp.append(body[:-1].decode("ascii"))
    if len(interp) != 1 or not loads or not any(p["flags"] & 1 and p["va"] <= fields[3] < p["va"] + p["memory_size"] for p in loads):
        raise ValueError("one target interpreter and entry within executable PT_LOAD required")
    # GNU RELRO and other program ranges may overlap LOAD; reject only overlapping
    # LOAD memory extents. A new, disjoint LOAD and a larger file remain allowed.
    ordered = sorted(loads, key=lambda p: p["va"])
    if any(a["va"] + a["memory_size"] > b["va"] for a, b in zip(ordered, ordered[1:])):
        raise ValueError("overlapping PT_LOAD memory extents")
    sections = [struct.unpack_from("<IIQQQQIIQQ", data, sh + shsize * i) for i in range(shcount)]
    names_index = fields[12]
    if not 0 < names_index < shcount:
        raise ValueError("section-name string table index")
    names_section = sections[names_index]
    names = data[names_section[4]:names_section[4] + names_section[5]]
    if len(names) != names_section[5] or names_section[1] != 3:
        raise ValueError("section-name table bounds/type")
    headers = []
    for section in sections:
        name_offset, kind, flags, va, offset, size, _link, _info, _align, _entsize = section
        if name_offset >= len(names) or b"\0" not in names[name_offset:]:
            raise ValueError("unterminated section name")
        name = names[name_offset:].split(b"\0", 1)[0]
        if kind != 8 and offset + size > len(data):
            raise ValueError("section body extends beyond candidate")
        if name == b".imageHeader":
            if kind != 1 or not flags & 2 or size != HEADER_SIZE or not any(
                p["offset"] <= offset and offset + size <= p["offset"] + p["file_size"] and
                va == p["va"] + offset - p["offset"] for p in loads):
                raise ValueError(".imageHeader must be the complete loaded 180-byte PROGBITS section")
            headers.append((offset, va))
    if len(headers) != 1:
        raise ValueError("one explicitly located .imageHeader required")
    offset, va = headers[0]
    h = data[offset:offset + HEADER_SIZE]
    if h[:4] != bytes.fromhex("cefa1400"):
        raise ValueError("unknown .imageHeader magic")
    return {"entry": fields[3], "program_count": phcount, "section_count": shcount,
            "loads": loads, "interpreter": interp[0], "image_header_offset": offset,
            "image_header_va": va, "image_header_size": HEADER_SIZE,
            "header_version": [h[16], h[17], struct.unpack_from("<H", h, 18)[0]],
            "host_elf_review_only": True, "target_memory_capacity_or_boot_verified": False}

def load_stock(path: Path) -> tuple[bytes, bytes, dict]:
    data = path.read_bytes()
    if sha(data) != FWR_SHA:
        raise ValueError("unknown original FWR whole SHA-256")
    with zipfile.ZipFile(io.BytesIO(data)) as archive:
        if len(archive.infolist()) != 20 or archive.comment or archive.testzip():
            raise ValueError("original ZIP20/CRC contract")
        if any(i.flag_bits != 0 for i in archive.infolist()):
            raise ValueError("original ZIP flags")
        user = archive.read(USER_NAME)
        manifest = archive.read("manifest.xml")
    if sha(user) != USER_SHA or len(user) != USER_SIZE:
        raise ValueError("original User component mismatch")
    root = ET.fromstring(manifest)
    if root.tag != "release" or root.attrib != {
        "compatible_version": "5", "name": "IQ4", "model_ids": "0x125,0x126,0x122",
        "hw_revisions": "1,2,3", "release_version": "6.03.18",
        "release_date": "2022-07-18", "minimum_update_version": "2.00.14",
    }:
        raise ValueError("original release attributes mismatch")
    linux = [c for c in root if c.tag == "component" and c.attrib == {"type": "LinuxApp"}]
    if len(linux) != 1 or len(linux[0]) != 1 or linux[0][0].attrib != {"version": "6.03.21"}:
        raise ValueError("original LinuxApp component mismatch")
    elf_layout(user)
    return user, manifest, dict(root.attrib)

def check_payload(stock: bytes, payload: bytes, expected_sha: str,
                  app: tuple[int, int, int]) -> dict:
    if not re.fullmatch(r"[0-9a-f]{64}", expected_sha) or sha(payload) != expected_sha:
        raise ValueError("payload must match caller-specified whole SHA-256")
    original, candidate = elf_layout(stock), elf_layout(payload)
    if candidate["interpreter"] != original["interpreter"]:
        raise ValueError("candidate requires an unreviewed target interpreter")
    if tuple(candidate["header_version"]) != app:
        raise ValueError("manifest version differs from payload .imageHeader actual bytes")
    return candidate

def manifests(attributes: dict, release: tuple[int, int, int], app: tuple[int, int, int]) -> tuple[bytes, bytes, str]:
    inner = ET.Element("release", attributes)
    inner.set("release_version", text_version(release))
    comp = ET.SubElement(inner, "component", {"type": "LinuxApp"})
    name = f"P1Linux_{text_version(app)}.bin"
    ET.SubElement(comp, "firmware_file", {"version": text_version(app)}).text = name
    outer = ET.Element("system_package", {
        "compatible_version": "2", "name": "IQ4", "version": text_version(release),
        "date": attributes["release_date"], "minimum_update_version": attributes["minimum_update_version"],
    })
    ET.SubElement(outer, "firmware_package", {
        "model_ids": attributes["model_ids"], "hw_revisions": attributes["hw_revisions"],
        "version": text_version(release), "minimum_update_version": attributes["minimum_update_version"],
    }).text = INNER_NAME
    # Original root parser requires an XML declaration. The updater adds its own NUL.
    render = lambda e: ET.tostring(e, encoding="utf-8", xml_declaration=True) + b"\n"
    return render(inner), render(outer), name

def stored_zip(entries: list[tuple[str, bytes]]) -> bytes:
    """No compression library variability, ZIP64, descriptors, extras or comments."""
    out = io.BytesIO()
    with zipfile.ZipFile(out, "w", compression=zipfile.ZIP_STORED, allowZip64=False) as archive:
        for name, data in entries:
            if not re.fullmatch(r"[A-Za-z0-9_.-]{1,63}", name):
                raise ValueError("flat fixed basename only")
            info = zipfile.ZipInfo(name, (1980, 1, 1, 0, 0, 0))
            info.create_system = 0
            info.create_version = 20
            info.extract_version = 20
            info.compress_type = zipfile.ZIP_STORED
            info.external_attr = 0x20
            archive.writestr(info, data)
    return out.getvalue()

def verify_zip(data: bytes, expected: list[tuple[str, bytes]]) -> list[dict]:
    with zipfile.ZipFile(io.BytesIO(data)) as archive:
        infos = archive.infolist()
        if [i.filename for i in infos] != [n for n, _ in expected] or archive.comment or archive.testzip():
            raise ValueError("candidate exact member/order/CRC contract")
        result = []
        for info, (name, body) in zip(infos, expected):
            if info.flag_bits or info.extra or info.comment or info.compress_type != 0:
                raise ValueError("candidate unsupported metadata")
            if archive.read(name) != body or info.CRC != zlib.crc32(body):
                raise ValueError("candidate byte/CRC mismatch")
            result.append({"name": name, "size": len(body), "sha256": sha(body), "crc32": f"{info.CRC:08x}"})
    return result

def build(stock: bytes, payload: bytes, payload_sha: str, attributes: dict,
          release: tuple[int, int, int], app: tuple[int, int, int]) -> tuple[dict, bytes, bytes]:
    candidate_elf = check_payload(stock, payload, payload_sha, app)
    inner_xml, outer_xml, name = manifests(attributes, release, app)
    fwr_entries = [("manifest.xml", inner_xml), (name, payload)]
    fwr = stored_zip(fwr_entries)
    fwp_entries = [("manifest.xml", outer_xml), (INNER_NAME, fwr)]
    fwp = stored_zip(fwp_entries)
    if len(fwr) > 0x7fffffff or len(fwp) > 0x7fffffff:
        raise ValueError("nested ZIP components must fit positive signed extractor result")
    modified = payload_sha != USER_SHA
    eligible = modified and release > RELEASE and app > APP
    only_version_change = False
    if len(payload) == len(stock):
        start = candidate_elf["image_header_offset"] + 16
        only_version_change = payload[:start] == stock[:start] and payload[start + 4:] == stock[start + 4:]
    plan = {
        "schema": "iq4_offline_user_only_package_candidate_v1",
        "evidence_level": "host_container_validation_only",
        "original_fwr_sha256": FWR_SHA, "original_user_sha256": USER_SHA,
        "payload_sha256": payload_sha, "payload_size": len(payload),
        "payload_elf_host_review": candidate_elf,
        "candidate_extent_differs_from_stock": len(payload) != len(stock),
        "candidate_elf_layout_differs_from_stock": {
            k:v for k,v in candidate_elf.items() if k != "header_version"
        } != {k:v for k,v in elf_layout(stock).items() if k != "header_version"},
        "added_loads_or_growth_is_not_a_device_acceptance_claim": True,
        "release_version": text_version(release), "component_version": text_version(app),
        "original_release_date_retained_as_candidate_base": attributes["release_date"],
        "payload_modified_from_stock": modified,
        "payload_changes_limited_to_image_header_version": modified and only_version_change,
        "both_versions_strictly_newer_than_fixed_baseline": release > RELEASE and app > APP,
        "offline_candidate_generation_scope_passed": eligible,
        "fwr": {"size": len(fwr), "sha256": sha(fwr), "entries": verify_zip(fwr, fwr_entries)},
        "fwp": {"size": len(fwp), "sha256": sha(fwp), "entries": verify_zip(fwp, fwp_entries)},
        "fwp_outer_schema_reconstructed_from_static_consumer_not_stock_sample": True,
        "static_target_files": ["User/manifest.xml", "User/p1linux.bin"],
        "additional_fwp_package_manifest_state_requires_independent_closure": True,
        "static_other_side_effects": ["FileManager component signature events", "firmware flags", "User boot image marker clear/reestablish through /dev/mtd0 erase-block read/erase/write", "upgrade-mode state", "reboot/runner consumes p1linux.bin"],
        "required_install_mode": "actual running User and install-as-User, partial update",
        "contains_boot_fpga_igloo_sensorprofile_language_calibration_or_keys": False,
        "device_acceptance_observed": False, "device_recovery_verified": False,
        "f1_feature_implementation_or_acceptance_proven": False,
        "camera_or_sdk_access_performed": False, "installation_authorized_by_this_tool": False,
    }
    return plan, fwr, fwp

def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--original-fwr", type=Path, default=DEFAULT_FWR)
    ap.add_argument("--user-payload", type=Path, required=True)
    ap.add_argument("--expected-user-sha256", required=True)
    ap.add_argument("--release-version", required=True)
    ap.add_argument("--app-version", required=True)
    ap.add_argument("--emit-candidate-directory", type=Path)
    args = ap.parse_args()
    stock, _, attributes = load_stock(args.original_fwr)
    plan, fwr, fwp = build(stock, args.user_payload.read_bytes(), args.expected_user_sha256,
                           attributes, version(args.release_version), version(args.app_version))
    if args.emit_candidate_directory:
        if not plan["offline_candidate_generation_scope_passed"]:
            raise ValueError("emit requires changed payload and both explicitly newer matching versions")
        directory = args.emit_candidate_directory.resolve()
        if ROOT not in directory.parents:
            raise ValueError("candidate directory must be a fresh child of this project")
        directory.mkdir(mode=0o700, parents=False, exist_ok=False)
        for name, content in ((INNER_NAME, fwr), ("iq4-user-only-candidate.fwp", fwp),
                              ("PLAN.json", (json.dumps(plan, indent=2) + "\n").encode())):
            with (directory / name).open("xb") as target:
                target.write(content)
            (directory / name).chmod(0o600)
    print(json.dumps(plan, indent=2))

if __name__ == "__main__":
    main()
