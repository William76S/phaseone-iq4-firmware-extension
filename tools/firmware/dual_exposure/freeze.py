#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,shlex
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
BUILD=ROOT/'analysis/firmware/dual_exposure_arrow_repair/build_final'
def row(p):
    p=p.resolve();return dict(path=str(p.relative_to(ROOT)) if p.is_relative_to(ROOT) else str(p),bytes=p.stat().st_size,sha256=hashlib.sha256(p.read_bytes()).hexdigest())
members=[ROOT/'src/display/dual_exposure.cpp',ROOT/'src/display/dual_exposure_pins.h',ROOT/'tests/display/test_dual_exposure.cpp']
members+=sorted(p for p in HERE.iterdir() if p.is_file() and p.name!='SOURCE_SHA256.json')
dependencies=set()
for name in shlex.split((BUILD/'dual.d').read_text().replace('\\\n',' ').split(':',1)[1]):
    p=Path(name).resolve()
    if p not in members:dependencies.add(p)
dependencies.add(ROOT/'tools/firmware/dual_exposure_02/emulate_native.py')
dependencies.add(ROOT/'tools/firmware/f1_user_elf_append_02/elf_append.py')
receipt=dict(schema='iq4_dual_native_arrow_source_03',members=[row(p)for p in members],dependencies=[row(p)for p in sorted(dependencies)],compiler=row(ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'),object=row(BUILD/'dual.o'),build=row(BUILD/'BUILD.json'),commands=row(BUILD/'COMMANDS.json'),native_host_emulation=row(ROOT/'analysis/firmware/dual_exposure_arrow_repair/ACTUAL_A64.json'),target_executed=False,camera_accessed=False)
text=json.dumps(receipt,indent=2)+'\n';dest=HERE/'SOURCE_SHA256.json'
if dest.exists():assert dest.read_text()==text,'Frozen source identity changed'
else:dest.write_text(text)
print(row(dest))
