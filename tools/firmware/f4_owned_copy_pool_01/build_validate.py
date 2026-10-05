#!/usr/bin/env python3
"""Build/test the owned-copy pool; never opens a camera or runs target code."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import struct
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def run(argv):
    result = subprocess.run([str(x) for x in argv], cwd=ROOT, text=True,
                            stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    if result.returncode:
        sys.stderr.write(result.stdout)
        raise SystemExit(f"command failed ({result.returncode}): {argv[0]}")
    return result.stdout


def artifact(path):
    return {"sha256": sha(path), "bytes": path.stat().st_size}


def require_aarch64(path):
    raw = path.read_bytes()
    if raw[:6] != b"\x7fELF\x02\x01" or struct.unpack_from("<H", raw, 18)[0] != 183:
        raise SystemExit(f"not ELF64 little-endian AArch64: {path}")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=ROOT / "analysis/firmware/f4_owned_copy_pool_01/build")
    parser.add_argument("--zig", type=Path, required=True)
    parser.add_argument("--host-cxx", type=Path, default=Path("/usr/bin/clang++"))
    args = parser.parse_args()
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=True)
    zig = args.zig.resolve()
    lock_path = ROOT / "tools/target/toolchain.lock.json"
    lock = json.loads(lock_path.read_text())
    if sha(zig) != lock["zig_binary_sha256"] or run([zig, "version"]).strip() != lock["version"]:
        raise SystemExit("Zig does not match existing toolchain lock; no download is performed")
    sources = [HERE / "owned_copy_pool.cpp", HERE / "recorder_worker.cpp", ROOT / "src/runtime/recording.cpp"]
    test = HERE / "test_owned_copy_pool.cpp"
    headers = [HERE / "owned_copy_pool.hpp", HERE / "recorder_worker.hpp", ROOT / "src/runtime/recording.hpp"]
    inputs = [*sources, test, *headers, HERE / "CMakeLists.txt", Path(__file__).resolve(),
              HERE / "README.md", lock_path,
              ROOT / "analysis/firmware/f4_frame_adapter_increment_01/adapter_contract.json"]
    commands = []
    host_results = {}
    host_common = [args.host_cxx, "-std=c++17", "-O2", "-g0", "-Wall", "-Wextra", "-Wpedantic", "-Werror",
                   "-UNDEBUG", "-pthread", "-ffile-prefix-map=" + str(ROOT) + "=."]
    if sys.platform == "darwin":
        sdk = Path(run(["xcrun", "--show-sdk-path"]).strip())
        host_common += ["-isystem", sdk / "usr/include/c++/v1"]
    for name, flags in [("normal", []), ("asan_ubsan", ["-fsanitize=address,undefined", "-fno-omit-frame-pointer"]),
                        ("tsan", ["-fsanitize=thread", "-fno-omit-frame-pointer"])]:
        binary = output / ("host_" + name)
        cmd = [*host_common, *flags, *sources, test, "-o", binary]
        run(cmd);commands.append([str(x) for x in cmd])
        report = run([binary]);commands.append([str(binary)])
        expected = "12 host test groups passed; 20000 concurrent synthetic completions; source C++ allocations 0\n"
        if report != expected:
            raise SystemExit("host test output did not match the complete suite receipt")
        report_path = output / (name + ".txt")
        report_path.write_text(report)
        host_results[name] = {"passed": True, "exit_code": 0, "binary": artifact(binary),
                              "receipt": artifact(report_path), "output": report.rstrip("\n")}
    target_common = [zig, "c++", "-target", lock["target"], "-std=c++17", "-O2", "-g0", "-fPIC",
                     "-pthread", "-Wall", "-Wextra", "-Wpedantic", "-Werror",
                     "-ffile-prefix-map=" + str(ROOT) + "=."]
    objects = []
    for source in sources:
        obj = output / (source.stem + ".aarch64.o")
        cmd = [*target_common, "-c", source, "-o", obj]
        run(cmd);commands.append([str(x) for x in cmd]);require_aarch64(obj);objects.append(obj)
    # Compile the existing RGB-to-JPEG decorator against the same target. No
    # addresses/table are supplied, and no unresolved codec call is executed.
    rgb = ROOT / "src/recording/rgb_jpeg_backend.cpp"
    rgb_obj = output / "rgb_jpeg_backend.compatibility.aarch64.o"
    cmd = [*target_common, "-DIQ4_JPEG_API_VERSION=82", "-c", rgb, "-o", rgb_obj]
    run(cmd);commands.append([str(x) for x in cmd]);require_aarch64(rgb_obj)
    inputs += [rgb, ROOT / "src/recording/rgb_jpeg_backend.hpp", ROOT / "src/codec/bounded_jpeg.h"]
    inputs += sorted((ROOT / "src/codec/vendor").rglob("*.h"))
    archive = output / "libiq4_f4_owned_copy.a"
    if archive.exists():
        archive.unlink()  # Rebuild product only: exclude stale archive members.
    # New component archive contains only pool/bridge. Root links its existing
    # iq4_runtime_core; including another Recorder implementation would obscure
    # that ownership when using whole-archive or a shared integration target.
    pool_objects = objects[:2]
    cmd = [zig, "ar", "rcsD", archive, *pool_objects]
    run(cmd);commands.append([str(x) for x in cmd])
    validation = output / "iq4_f4_owned_copy_validation.aarch64"
    cmd = [*target_common, "-UNDEBUG", *objects, test, "-o", validation]
    run(cmd);commands.append([str(x) for x in cmd]);require_aarch64(validation)
    glibc = sorted(set(x.decode() for x in re.findall(rb"GLIBC_\d+\.\d+", validation.read_bytes())),
                   key=lambda v: tuple(map(int, v.split("_")[1].split("."))))
    if not glibc or any(tuple(map(int, v.split("_")[1].split("."))) > (2, 28) for v in glibc):
        raise SystemExit("target validation exceeds glibc 2.28 baseline")
    manifest = {
        "schema_version": 1,
        "evidence_level": "host_fault_concurrency_sanitizers_and_cross_compile",
        "source_sha256": {str(p.relative_to(ROOT)): sha(p) for p in sorted(set(inputs))},
        "compiler_lock": lock,
        "host_cxx_version": run([args.host_cxx, "--version"]).rstrip("\n"),
        "host_results": host_results,
        "target_artifacts": {p.name: artifact(p) for p in [*objects, rgb_obj, archive, validation]},
        "archive_members": [p.name for p in pool_objects],
        "target_validation_glibc_versions": glibc,
        "target_validation_executed": False,
        "camera_operations_performed": False,
        "native_source_binding_verified": False,
        "native_mode_rgb_color_clock_card_ui_verified": False,
        "software_completion_ids_are_sensor_frames": False,
        "measured_source_fps": None,
        "commands": commands,
    }
    manifest_path = output.parent / "build_validation.json"
    manifest_path.write_text(json.dumps(manifest, indent=2) + "\n")
    print(json.dumps({"host_groups_per_run": 12, "synthetic_completions_per_run": 20000,
                      "sanitizers": ["ASan+UBSan", "TSan"], "target": lock["target"],
                      "archive_sha256": sha(archive), "manifest_sha256": sha(manifest_path),
                      "manifest": str(manifest_path), "camera_operations_performed": False}))


if __name__ == "__main__":
    main()
