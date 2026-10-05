#!/usr/bin/env python3
"""Record SHA-bound offline adapter evidence. No firmware patch or device access."""
import argparse
import hashlib
import json
import shutil
import struct
import subprocess
from pathlib import Path

EXPECTED = "9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb"
TEXT_START, TEXT_END = 0x40B230, 0x9EF158

ROLES = {
    0x5175B8: ("f1_ui_lv_constructor", "UiLvConstructor.c"),
    0x51B768: ("f1_ui_lv_property_event", "UiLvPropertyEvent.c"),
    0x51DA0C: ("f1_ui_lv_paint", "UiLvPaint.c"),
    0x51EA88: ("f1_ui_lv_input_event", "UiLvInputEvent.c"),
    0x5202A0: ("f1_ui_lv_start", "UiLvEnter.c"),
    0x520590: ("f1_ui_lv_stop", "UiLvStop.c"),
    0x520684: ("f1_ui_lv_transient_overlay_show", "UiLvShowTransientOverlay.c"),
    0x5473E4: ("f1_ui_lv_overlay_constructor", "UiLvOverlayConstructor.c"),
    0x547C60: ("f1_ui_lv_overlay_property_event", "UiLvOverlayPropertyEvent.c"),
    0x54803C: ("f1_ui_lv_overlay_rotation", "UiLvOverlayShowLayout.c"),
    0x64270C: ("f1_ui_overlay_event_objects_constructor", "UiOverlayObjects.c"),
    0x45AE84: ("f1_hdmi_overlay_controller", "HdmiOverlayEvents.c"),
    0x48C394: ("f2_f3_raw_jpeg_request", "RawJpegRequest.c"),
    0x48F390: ("f3_scale_clamp", "ScaleClamp.c"),
    0x4959EC: ("f3_ifm_objects_constructor", "IfmObjectsConstructor.c"),
    0x496AB0: ("f3_ifm_generate_jpeg_image", "IfmGenerateJpegImage.c"),
    0x4979D0: ("f3_ifm_jpeg_buffer_lock", "IfmLockJpegBuffer.c"),
    0x497A9C: ("f3_ifm_jpeg_buffer_unlock", "IfmUnlockJpegBuffer.c"),
    0x49D7C0: ("f3_ifm_background_worker", "IfmBackgroundWorker.c"),
    0x701D34: ("f3_original_shell_ifm_commands", "ShellIfmCommands.c"),
    0x7B749C: ("f2_f3_ice_jpeg_request_worker", "IceJpegRequestWorker.c"),
    0x7B982C: ("f2_f3_ice_rgb32_to_rgb24_copy", "IceCopyRgbToJpeg.c"),
    0x8E0B18: ("f3_jpeg_storage_event_worker", "JpegStorageEvents.c"),
    0x8E17C8: ("f3_4k_jpeg_task", "Jpeg4kTask.c"),
    0x8E1D70: ("f3_jpeg_encode_task", "JpegEncodeTask.c"),
    0x903F70: ("ic_image_buffer_attach", "IcImageBufferAttach.c"),
    0x9043C8: ("ic_image_buffer_valid_plane", "IcImageBufferPlane.c"),
    0x904448: ("ic_image_buffer_valid_width", "IcImageBufferValidWidth.c"),
    0x904450: ("ic_image_buffer_valid_height", "IcImageBufferValidHeight.c"),
    0x904468: ("ic_image_buffer_row_stride", "IcImageBufferRowStride.c"),
    0x904478: ("ic_image_buffer_total_width", "IcImageBufferWidth.c"),
    0x904480: ("ic_image_buffer_total_height", "IcImageBufferHeight.c"),
    0x975558: ("srgb_transfer_encode_math", "Transfer_975558.c"),
    0x975648: ("srgb_transfer_decode_math", "Transfer_975648.c"),
    0x9756A0: ("rgb2rgb_colorspace_convert_candidate", "RgbColorSpaceConvert.c"),
    0x6B618C: ("f4_lv_lock_owner", "LiveViewLock.c"),
    0x6B6250: ("f4_lv_release_owner", "LiveViewRelease.c"),
    0x6B6A3C: ("f4_lv_buffer_lock", "VideoBufferLock.c"),
    0x6B6C80: ("f4_lv_locked_id", "VideoBufferId.c"),
    0x863028: ("iqp_development_dispatch", None),
    0x8728C8: ("iqp_development_shell_handler", None),
    0x75C7B4: ("firmware_verify", None),
}

SNIPPETS = {
    "ui_paint": (0x51DA0C, 0x51DF64),
    "ui_start_stop": (0x5202A0, 0x520724),
    "ui_vtable_control_show": (0x4AB898, 0x4AB8FC),
    "ui_overlay_events": (0x547C60, 0x547F5C),
    "jpeg_objects_constructor": (0x4959EC, 0x495FB0),
    "jpeg_request": (0x496AB0, 0x496B5C),
    "jpeg_lock_unlock": (0x4979D0, 0x497AEC),
    "jpeg_scale_clamp_site": (0x48C674, 0x48C948),
    "jpeg_worker_copy_site": (0x7B7F08, 0x7B8340),
    "jpeg_rgb_copy": (0x7B982C, 0x7B9948),
    "ic_image_buffer_reference": (0x903F70, 0x904488),
    "raw_pool_owner": (0x8C25C0, 0x8C26D8),
    "raw_pool_refcount": (0x6F07CC, 0x6F0A9C),
    "srgb_transfers": (0x975558, 0x9756A0),
    "rgb2rgb_enum_tables": (0x9756A0, 0x975830),
}


def signed(v, bits):
    return v - (1 << bits) if v & (1 << (bits - 1)) else v


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("binary", type=Path)
    p.add_argument("--out", required=True, type=Path)
    p.add_argument("--objdump", type=Path)
    a = p.parse_args()
    b = a.binary.read_bytes()
    digest = hashlib.sha256(b).hexdigest()
    if digest != EXPECTED:
        raise SystemExit("Unknown input SHA-256; no output created")
    executable = a.objdump or Path("/Library/Developer/CommandLineTools/usr/bin/llvm-objdump")
    if not executable.is_file():
        fallback = shutil.which("llvm-objdump")
        if not fallback:
            raise SystemExit("llvm-objdump unavailable")
        executable = Path(fallback)
    a.out.mkdir(parents=True, exist_ok=True)
    direct_calls = []
    for va in range(TEXT_START, TEXT_END, 4):
        w = struct.unpack_from("<I", b, va - 0x400000)[0]
        if w & 0xFC000000 == 0x94000000:
            direct_calls.append({"pc": hex(va), "target": hex(va + (signed(w & 0x3FFFFFF, 26) << 2)), "instruction": hex(w)})
    incoming = {hex(v): [c for c in direct_calls if c["target"] == hex(v)] for v in ROLES}
    evidence = {
        "evidence_level": "static_analysis",
        "input_sha256": digest,
        "device_actions": 0,
        "runtime_abi_verified": False,
        "pseudocode_caution": "Private function prototypes and C++ hidden result arguments are unverified; use instructions for claims. Some shared tail code expands beyond unwind boundaries.",
        "ui_vtable": {"linked_va": "0xb9a9d8", "file_offset": "0x79a9d8", "slots": {}},
        "direct_bl_incoming": incoming,
        "ifm_initial_jpeg_descriptors": {
            "constructor": "0x4959ec", "width": 3840, "height": 3840, "format_code": 0,
            "packed_rgb24_stride": 11520, "descriptor_offsets": ["0x3fa6e10", "0x7f4cc28"],
            "backing_offsets": ["0x1010", "0x3fa6e28"], "request_capacity_bytes": 0x3FA5E00,
            "lock_count_offset": "0x7f4cc40", "mutex_offset": "0xfb8",
            "capacity_caution": "Descriptor initial sizes and inline buffer budget only; no measured render limit, full RAW capability or available RAM claim."
        },
        "image_descriptor_fields": {"0x0": "format code", "0x4": "width", "0x8": "height", "0xc": "byte row stride", "0x10": "pixel pointer"},
        "ic_image_buffer_fields": {"0x0": "reference flag; nonreference destructor frees base", "0x4": "total width including border", "0x8": "total height including border", "0xc": "top border", "0x10": "left border", "0x14": "valid width", "0x18": "valid height", "0x1c": "pixel format code", "0x20": "alignment parameter", "0x24": "byte row stride", "0x28": "backing base pointer", "0x30": "total byte size"},
        "srgb_math_identification": {
            "formal_enum_name_recovered": False, "mathematical_enum_candidate": 0,
            "encode_function": "0x975558", "decode_function": "0x975648",
            "decode_threshold": 0.04045, "encode_threshold": 0.003130805,
            "encode_table": [hex(v) for v in struct.unpack_from("<6Q", b, 0xDCCB58 - 0x400000)],
            "decode_table": [hex(v) for v in struct.unpack_from("<6Q", b, 0xDCCB28 - 0x400000)],
            "enum_0_rgb_to_xyz_d50_matrix": list(struct.unpack_from("<9d", b, 0xDCCE30 - 0x400000)),
            "jpeg_rgb24_domain_confirmed": False,
            "pipeline_caution": "Generic transfer existence does not prove current JPEG RGB24 buffer is sRGB; thread dispatch 0x962ee8 has no found direct BL callers."
        },
        "objdump_version": subprocess.check_output([str(executable), "--version"], text=True).strip(),
        "snippets": {},
    }
    for slot in (0xA0, 0x108, 0x170, 0x178, 0x1C8):
        got = struct.unpack_from("<Q", b, 0xB9A9D8 - 0x400000 + slot)[0]
        evidence["ui_vtable"]["slots"][hex(slot)] = hex(got)
    assert evidence["ui_vtable"]["slots"]["0xa0"] == "0x51da0c"
    assert evidence["ui_vtable"]["slots"]["0x108"] == "0x51ea88"
    assert [c["pc"] for c in incoming["0x48f390"]] == ["0x48c7d4"]
    assert [c["pc"] for c in incoming["0x48c394"]] == ["0x496b4c"]
    for name, (start, stop) in SNIPPETS.items():
        output = subprocess.check_output([str(executable), "-d", f"--start-address={start}", f"--stop-address={stop}", str(a.binary)], text=True)
        path = a.out / ("adapter_" + name + ".disasm.txt")
        path.write_text("# Static only; misleading nearest exported symbol labels are not function names.\n# Input SHA256 " + digest + "\n" + output)
        evidence["snippets"][name] = {"file": path.name, "start_linked_va": hex(start), "stop_linked_va_exclusive": hex(stop), "sha256": hashlib.sha256(path.read_bytes()).hexdigest()}
    (a.out / "adapter_evidence.json").write_text(json.dumps(evidence, indent=2) + "\n")
    old = json.loads((a.out / "ENTRYPOINTS.json").read_text())
    old["entries"] = [dict(label=label, linked_va=hex(v), file_offset=hex(v - 0x400000), pseudocode=("decompiled/" + pseudocode if pseudocode else None), evidence_level="static_analysis", runtime_abi_verified=False, temporary_device_verified=False, persistent_acceptance=False) for v, (label, pseudocode) in sorted(ROLES.items())]
    old["role_corrections"] = {"0x51ea88": "touch/input event, not rendering", "0x51b768": "property event, not constructor", "0x520684": "transient overlay, not stop", "0x520590": "actual LV stop", "0x4959ec": "constructor, not request", "0x496ab0": "generate request, not release", "0x497a9c": "actual JPEG buffer unlock"}
    for blocker in old["blockers"]:
        if blocker["id"] == "full_raw_jpeg":
            blocker["evidence"] = "scale [0.01,0.49], two 3840x3840 initial descriptors, 66739712-byte request budget; automatic and shell JPEG share request; full render/memory/owner/cancel contract unverified"
    old["blockers"].append({"id": "jpeg_srgb_domain", "status": "unknown", "evidence": "sRGB transfer math exists, but actual raw-JPEG RGB24 color domain and conversion call chain not proven"})
    # Idempotently collapse a prior run's repeated blockers.
    old["blockers"] = list({x["id"]: x for x in old["blockers"]}.values())
    (a.out / "ENTRYPOINTS.json").write_text(json.dumps(old, indent=2) + "\n")
    print(json.dumps({"input_sha256": digest, "entrypoints": len(ROLES), "snippets": len(SNIPPETS), "device_actions": 0}))


if __name__ == "__main__":
    main()
