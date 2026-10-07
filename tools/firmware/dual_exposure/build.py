#!/usr/bin/env python3
from pathlib import Path
import subprocess, json, hashlib, sys
ROOT=Path(__file__).resolve().parents[3]
out=Path(sys.argv[1]).resolve()
glyph_only=len(sys.argv)==3 and sys.argv[2]=='--glyph-only'
assert out.is_relative_to(ROOT) and not out.exists()
out.mkdir(parents=True); commands=[]
def run(args):
    args=list(map(str,args)); q=subprocess.run(args,cwd=ROOT,text=True,capture_output=True)
    commands.append(dict(argv=args,exit=q.returncode,stdout=q.stdout,stderr=q.stderr))
    (out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
    assert q.returncode==0,q.stderr
    return q.stdout.strip()
sdk=run(['/usr/bin/xcrun','--show-sdk-path'])
cc='/Library/Developer/CommandLineTools/usr/bin/clang++'
test=ROOT/'tests/display/test_dual_exposure.cpp'
for name,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-sanitize-recover=all'])]:
    exe=out/name
    run([cc,'-std=c++17','-isysroot',sdk,'-isystem',sdk+'/usr/include/c++/v1','-O2','-Wall','-Wextra','-Werror',*flags,test,'-o',exe])
    print(run([exe,*(['--glyph-only'] if glyph_only else [])]))
zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
assert hashlib.sha256(zig.read_bytes()).hexdigest()=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
obj=out/'dual.o'
run([zig,'c++','-target','aarch64-linux-gnu.2.28','-std=c++17','-O2','-g0','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror','-MMD','-MF',out/'dual.d','-c',ROOT/'src/display/dual_exposure.cpp','-o',obj])
run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',obj])
sources=['src/display/dual_exposure.cpp','src/display/dual_exposure_pins.h','tests/display/test_dual_exposure.cpp','tests/display/dual_exposure_factory_times.h','tools/firmware/dual_exposure/generate_pins.py','tools/firmware/dual_exposure/generate_factory_times.py','tools/firmware/dual_exposure/PINS.json','tools/firmware/dual_exposure/build.py']
receipt=dict(schema='iq4_dual_exposure_arrow_build_03',sources=[dict(path=p,bytes=(ROOT/p).stat().st_size,sha256=hashlib.sha256((ROOT/p).read_bytes()).hexdigest()) for p in sources],objects=[dict(path=str(obj.relative_to(ROOT)),bytes=obj.stat().st_size,sha256=hashlib.sha256(obj.read_bytes()).hexdigest())],hardware_executed=False)
(out/'BUILD.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps(receipt['objects']))
