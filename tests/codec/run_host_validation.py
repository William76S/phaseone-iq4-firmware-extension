#!/usr/bin/env python3
"""Fresh real encode/decode CTest runner, no image fixtures from a camera."""
import argparse
import hashlib
import json
import pathlib
import shutil
import subprocess
import sys
import tempfile

parser = argparse.ArgumentParser()
parser.add_argument("--test-executable", required=True)
parser.add_argument("--host-library", required=True)
parser.add_argument("--evidence-root", required=True)
args = parser.parse_args()
evidence = pathlib.Path(args.evidence_root).resolve()
evidence.mkdir(parents=True, exist_ok=True)
run = pathlib.Path(tempfile.mkdtemp(prefix="host_validation_", dir=evidence))
for tool in ("ffmpeg", "ffprobe"):
    if not shutil.which(tool):
        raise SystemExit(f"Required real decoder unavailable: {tool}; no success claim")
test = subprocess.run([args.test_executable, str(run / "outputs")], capture_output=True, text=True)
(run / "test.log").write_text(test.stdout + test.stderr)
print(test.stdout, end="")
if test.returncode:
    print(test.stderr, file=sys.stderr)
    raise SystemExit(test.returncode)
decode = subprocess.run([sys.executable, str(pathlib.Path(__file__).with_name("verify_decode.py")), str(run / "outputs")], capture_output=True, text=True)
(run / "decode.log").write_text(decode.stdout + decode.stderr)
print(decode.stdout, end="")
if decode.returncode:
    print(decode.stderr, file=sys.stderr)
    raise SystemExit(decode.returncode)
summary = json.loads([line[len("RESULT_JSON "):] for line in test.stdout.splitlines() if line.startswith("RESULT_JSON ")][-1])
summary.update({"real_decode_passed": True, "run_directory": str(run),
                "test_executable_sha256": hashlib.sha256(pathlib.Path(args.test_executable).read_bytes()).hexdigest(),
                "host_library_sha256": hashlib.sha256(pathlib.Path(args.host_library).read_bytes()).hexdigest(),
                "decoder": subprocess.run(["ffmpeg", "-version"], capture_output=True, text=True, check=True).stdout.splitlines()[0]})
(run / "verification.json").write_text(json.dumps(summary, indent=2) + "\n")
print("HOST_VERIFICATION_JSON " + str(run / "verification.json"))
