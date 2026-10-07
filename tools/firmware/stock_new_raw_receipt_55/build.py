#!/usr/bin/env python3
from pathlib import Path
import json,hashlib,subprocess
R=Path(__file__).resolve().parents[3];D=Path(__file__).resolve().parent;O=R/'analysis/firmware/stock_new_raw_receipt_55';B=O/'build';B.mkdir(exist_ok=True);Z=R/'build/toolchains/zig-aarch64-macos-0.15.2/zig';commands=[]
def row(p):return dict(path=str(p.relative_to(R)),bytes=p.stat().st_size,sha256=hashlib.sha256(p.read_bytes()).hexdigest())
def run(a,label):
 a=list(map(str,a));q=subprocess.run(a,cwd=R,text=True,capture_output=True);commands.append(dict(label=label,argv=a,exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(B/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert q.returncode==0,(label,q.stdout,q.stderr)
run(['python3',D/'collect.py'],'exact_original_hooks_and_pin_windows')
sdk='/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk'
for mode,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
 exe=B/('test_receipt_'+mode);run(['/usr/bin/clang++','-isysroot',sdk,'-isystem',sdk+'/usr/include/c++/v1','-std=c++17','-O1','-Wall','-Wextra','-Werror',*flags,D/'test_receipt.cpp','-o',exe],'host_build_'+mode);run([exe],'host_focused_'+mode)
for stem,ext in [('receipt','cpp'),('wrappers','S')]:
 a=[Z,'c++'if ext=='cpp'else'cc','-target','aarch64-linux-gnu.2.28','-Os','-g0','-fPIC','-ffreestanding','-mno-outline-atomics','-funwind-tables','-fno-stack-protector']
 if ext=='cpp':a+=['-std=c++17','-fexceptions','-fno-rtti','-Wall','-Wextra','-Werror']
 run(a+['-MMD','-MF',B/(stem+'.d'),'-c',D/(stem+'.'+ext),'-o',B/(stem+'.o')],'target_compile_'+stem)
 run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',B/(stem+'.o')],'target_undefined_'+stem)
 run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-r','-t',B/(stem+'.o')],'target_relocations_'+stem)
for script in ['prove_native.py','prove_storage_modes.py']:
 run([R/'build/dual-exposure-host-venv/bin/python',D/script],script)
(B/'BUILD.json').write_text(json.dumps(dict(schema='iq4_new_raw_receipt_55_build',stock_sha256='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb',objects=[row(B/'receipt.o'),row(B/'wrappers.o')],commands=row(B/'COMMANDS.json'),source=[row(p) for p in [D/'receipt.cpp',D/'receipt.h',D/'pins.h',D/'wrappers.S',D/'test_receipt.cpp',D/'collect.py',D/'build.py',D/'prove_native.py',D/'prove_storage_modes.py']],host_fixture_groups=26,host_test_pixel_pipeline=False,camera_accessed=False),indent=2)+'\n')
print('PASS normal + ASAN/UBSAN focused file ownership tests and exact AArch64 objects')
