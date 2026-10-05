#!/usr/bin/env python3
"""Freeze finite local source and actual host/A64 build inputs; never hardware."""
from pathlib import Path
import hashlib,json,shlex
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
BUILD=ROOT/'analysis/firmware/dual_exposure_build_02';LINK=ROOT/'analysis/firmware/dual_exposure_link_dev_02'
def row(p):
 p=Path(p).resolve();assert p.is_relative_to(ROOT);b=p.read_bytes()
 return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
paths=sorted(p for p in HERE.iterdir()if p.is_file()and p.name!='SOURCE_SHA256.json')
deps=set()
for name in shlex.split((BUILD/'dual.d').read_text().replace('\\\n',' ').split(':',1)[1]):
 p=Path(name).resolve()
 if not p.is_relative_to(HERE):deps.add(p)
j=dict(schema='iq4_dual_exposure_exact_thirds_source_02',members=[row(p)for p in paths],dependencies=[row(p)for p in sorted(deps)],compiler=row(ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'),commands=row(BUILD/'COMMANDS.json'),object=row(BUILD/'dual.o'),actual_A64_emulation=row(BUILD/'ACTUAL_UI_MATH_EMULATION.json'),test_link_inputs=row(BUILD/'INPUTS_DEV_02.json'),test_link_build=row(LINK/'BUILD.json'),test_link_report=row(LINK/'LINK_REPORT.json'),target_executed=False,camera_accessed=False)
p=HERE/'SOURCE_SHA256.json';data=json.dumps(j,indent=2)+'\n'
if p.exists():assert p.read_text()==data,'frozen source identity changed'
else:p.write_text(data)
print(row(p))
