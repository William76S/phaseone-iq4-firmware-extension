#!/usr/bin/env python3
"""Offline, immutable-input review. Never executes the original/target ELF."""
import hashlib
import json
from pathlib import Path
import subprocess

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
STOCK = ROOT / "analysis/firmware/extracted/P1Linux_6.03.21.bin"
CANDIDATE = ROOT / "build/f1_native_menu_candidate_02/P1Linux_F1_NativeMenu_6.03.24.bin"
DISPLAY = ROOT / "tools/firmware/f1_stock_display_payload_13"
MENU = ROOT / "tools/firmware/f1_stock_menu_01/runtime.c"
OBJDUMP = Path("/Library/Developer/CommandLineTools/usr/bin/llvm-objdump")
BUILD = ROOT / "build/f1_display13_no_effect_static_review_01"
BUILD.mkdir(parents=True, exist_ok=True)


def identity(p):
    b = p.read_bytes()
    return {"path": str(p.relative_to(ROOT)), "bytes": len(b),
            "sha256": hashlib.sha256(b).hexdigest()}


inputs = [STOCK, CANDIDATE, DISPLAY / "payload.c", DISPLAY / "payload.h",
          DISPLAY / "wrapper.S", MENU]
before = [identity(p) for p in inputs]
assert before[0]["sha256"] == "9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb"
assert before[1]["sha256"] == "c2ee83dcad9529e1fb61af5a989b8a1f8f3f6c07c1ec2d2742a662d032404443"
commands = []
windows = []


def run(argv):
    p = subprocess.run([str(a) for a in argv], cwd=ROOT,
                       capture_output=True, text=True)
    commands.append({"argv": [str(a) for a in argv], "exit": p.returncode,
                     "stdout": p.stdout, "stderr": p.stderr})
    assert p.returncode == 0, p.stderr
    return p.stdout


for name, source, start, end in [
    ("LV_lock_dimensions_metadata_roi", STOCK, 0x51db50, 0x51dc10),
    ("LV_actual_draw_call", STOCK, 0x51dd78, 0x51de30),
    ("LV_access_methods", STOCK, 0x6b614c, 0x6b6244),
    ("VideoBuffer_locked_dimensions_roi_metadata", STOCK, 0x6b6b70, 0x6b6e10),
    ("PlFunctions_actual_FPGA_dimensions", STOCK, 0x787578, 0x787708),
    ("PlFunctions_publish_slot_dimensions_roi", STOCK, 0x787820, 0x78789c),
    ("LV_metadata_provider_writes", STOCK, 0x7995e0, 0x799698),
    ("LV_config_coordinate_projection", STOCK, 0x51f50c, 0x51f5ec),
    ("LV_normal_scale_setup", STOCK, 0x520488, 0x520504),
    ("LV_scale_setter", STOCK, 0x520814, 0x5208a0),
    ("Native_image_full_source_and_projection", STOCK, 0x477038, 0x477158),
    ("Linked_mode_get_set", CANDIDATE, 0x4240000, 0x4240038),
    ("Linked_native_leaf_activate", CANDIDATE, 0x424092c, 0x4240a30),
    ("Linked_after_stock_getter_call", CANDIDATE, 0x4241440, 0x4241470),
]:
    output = run([OBJDUMP, "-d", f"--start-address={start}",
                  f"--stop-address={end}", source])
    path = HERE / f"{name}.txt"
    path.write_text(output, encoding="utf-8")
    windows.append({"name": name, "source": str(source.relative_to(ROOT)),
                    "start_va": hex(start), "end_va_exclusive": hex(end),
                    "file": identity(path)})

common = ["/usr/bin/clang", "-std=c11", "-O2", "-ffp-contract=off",
          "-fno-strict-aliasing", "-Wall", "-Wextra", "-Werror",
          "-DIQ4_F1_DISPLAY13_HOST", "-I", DISPLAY, DISPLAY / "payload.c",
          HERE / "domain_counterexample.c"]
host_results = []
for name, extra in [("normal", []), ("asan_ubsan", ["-g", "-fsanitize=address,undefined",
                                                    "-fno-omit-frame-pointer"])]:
    executable = BUILD / name
    run(common + extra + ["-o", executable])
    result = json.loads(run([executable]))
    assert result["passed"] == result["case_count"] == 11
    (HERE / f"HOST_{name}.json").write_text(json.dumps(result, indent=2) + "\n")
    host_results.append({"name": name, "executable": identity(executable),
                         "case_count": result["case_count"], "passed": result["passed"],
                         "native_executed": False, "camera_access": False})

after = [identity(p) for p in inputs]
assert after == before
record = {"schema": "iq4_f1_display13_no_effect_static_review_run_01",
          "input_identity_before": before, "input_identity_after": after,
          "frozen_inputs_unchanged": True, "native_executed": False,
          "camera_access": False, "windows": windows,
          "host_results": host_results, "commands": commands}
(HERE / "RUN.json").write_text(json.dumps(record, indent=2) + "\n")
print(json.dumps({"cases_per_host_build": 11, "host_builds": 2,
                  "all_commands_exit_zero": True, "inputs_unchanged": True}))
