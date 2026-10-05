#!/usr/bin/env python3
"""Fresh isolated CTest runner; synthetic JPEG input, full decode/PTS checks."""
import argparse
import base64
import hashlib
import json
import pathlib
import shutil
import subprocess
import sys
import tempfile

parser=argparse.ArgumentParser()
parser.add_argument("--test-executable",required=True)
parser.add_argument("--evidence-root",required=True)
args=parser.parse_args()
here=pathlib.Path(__file__).resolve().parent
evidence=pathlib.Path(args.evidence_root).resolve()
evidence.mkdir(parents=True,exist_ok=True)
run=pathlib.Path(tempfile.mkdtemp(prefix="host_validation_",dir=evidence))
fixtures=run/"fixtures"
fixtures.mkdir()
try:
    from PIL import Image,ImageDraw
    for index in range(1,13):
        image=Image.new("RGB",(96,64),(30+index*10,60,180-index*7))
        draw=ImageDraw.Draw(image)
        draw.rectangle((index*4,12,index*4+20,44),fill=(240,200,30))
        image.save(fixtures/f"host_fixture_{index:02d}.jpg",format="JPEG",quality=90,progressive=False)
    origin="Pillow synthetic RGB chart 96x64, no camera"
except ImportError:
    packet=base64.b64decode((here/"fixture_jpeg.base64").read_bytes(),validate=False)
    for index in range(1,13):
        (fixtures/f"host_fixture_{index:02d}.jpg").write_bytes(packet)
    origin="stdlib decoded checked-in host synthetic 96x64 baseline JPEG; identical static input, no camera"
for tool in ("ffmpeg","ffprobe"):
    if not shutil.which(tool):
        raise SystemExit(f"Required actual decode tool unavailable: {tool}; no success claim")
test=subprocess.run([args.test_executable,str(fixtures),str(run/"outputs")],capture_output=True,text=True)
(run/"test.log").write_text(test.stdout+test.stderr)
print(test.stdout,end="")
if test.returncode:
    print(test.stderr,file=sys.stderr)
    raise SystemExit(test.returncode)
decode=subprocess.run([sys.executable,str(here/"verify_media.py"),str(fixtures),str(run/"outputs"),str(run/"media_checks")],capture_output=True,text=True)
(run/"decode.log").write_text(decode.stdout+decode.stderr)
print(decode.stdout,end="")
if decode.returncode:
    print(decode.stderr,file=sys.stderr)
    raise SystemExit(decode.returncode)
result=[line[len("RESULT_JSON "):] for line in test.stdout.splitlines() if line.startswith("RESULT_JSON ")]
summary=json.loads(result[-1])
summary.update({"all_decode_and_pts_checks_passed":True,"fixture_origin":origin,"run_directory":str(run),"fixture_sha256":{f.name:hashlib.sha256(f.read_bytes()).hexdigest() for f in fixtures.glob("*.jpg")},"decoder":subprocess.run(["ffmpeg","-version"],capture_output=True,text=True,check=True).stdout.splitlines()[0]})
(run/"verification.json").write_text(json.dumps(summary,indent=2)+"\n")
print("HOST_VERIFICATION_JSON "+str(run/"verification.json"))
