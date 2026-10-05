#!/usr/bin/env python3
"""Fresh-directory runner for the actual host RGB->codec->container source chain."""
import argparse
import hashlib
import json
import pathlib
import shutil
import subprocess
import sys
import tempfile

p = argparse.ArgumentParser()
p.add_argument("--test-executable", required=True)
p.add_argument("--evidence-root", required=True)
args = p.parse_args()
root = pathlib.Path(args.evidence_root).resolve()
root.mkdir(parents=True, exist_ok=True)
run = pathlib.Path(tempfile.mkdtemp(prefix="rgb_chain_", dir=root))
for tool in ("ffmpeg", "ffprobe"):
    if not shutil.which(tool):
        raise SystemExit(f"Required actual decoder unavailable: {tool}")
test = subprocess.run([args.test_executable, str(run / "outputs")], capture_output=True, text=True)
(run / "test.log").write_text(test.stdout + test.stderr)
print(test.stdout, end="")
if test.returncode:
    print(test.stderr, file=sys.stderr)
    raise SystemExit(test.returncode)
decode = subprocess.run([sys.executable, str(pathlib.Path(__file__).with_name("verify_rgb_backend.py")), str(run / "outputs")], capture_output=True, text=True)
(run / "decode.log").write_text(decode.stdout + decode.stderr)
print(decode.stdout, end="")
if decode.returncode:
    print(decode.stderr, file=sys.stderr)
    raise SystemExit(decode.returncode)
summary = json.loads([line[len("RESULT_JSON "):] for line in test.stdout.splitlines() if line.startswith("RESULT_JSON ")][-1])
summary.update({"real_decode_and_pts_passed": True, "run_directory": str(run),
                "test_executable_sha256": hashlib.sha256(pathlib.Path(args.test_executable).read_bytes()).hexdigest(),
                "decoder": subprocess.run(["ffmpeg", "-version"], capture_output=True, text=True, check=True).stdout.splitlines()[0]})
(run / "verification.json").write_text(json.dumps(summary, indent=2) + "\n")
print("HOST_VERIFICATION_JSON " + str(run / "verification.json"))
