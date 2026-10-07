#!/usr/bin/env python3
from pathlib import Path
import subprocess,json,hashlib,sys
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=Path(sys.argv[1]).resolve()
assert OUT.is_relative_to(ROOT) and not OUT.exists();OUT.mkdir(parents=True);commands=[]
def run(argv):
 argv=list(map(str,argv));r=subprocess.run(argv,cwd=ROOT,text=True,capture_output=True)
 commands.append(dict(argv=argv,exit=r.returncode,stdout=r.stdout,stderr=r.stderr));(OUT/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
 assert r.returncode==0,r.stdout+r.stderr;return r.stdout
sdk=run(['/usr/bin/xcrun','--show-sdk-path']).strip();cc='/Library/Developer/CommandLineTools/usr/bin/clang++'
for name,extra in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-sanitize-recover=all'])]:
 exe=OUT/name;run([cc,'-std=c++17','-isysroot',sdk,'-isystem',sdk+'/usr/include/c++/v1','-O2','-Wall','-Wextra','-Werror',*extra,HERE/'test.cpp','-o',exe]);print(run([exe]).strip())
zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';assert hashlib.sha256(zig.read_bytes()).hexdigest()=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
common=[zig,'c++','-target','aarch64-linux-gnu.2.28','-O2','-g0','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror']
objects=[]
for src,name,extra in [(HERE/'bridge.cpp','half_bridge.o',['-std=c++17']),(HERE/'wrappers.S','half_wrappers.o',[])]:
 obj=OUT/name;run(common+extra+['-MMD','-MF',OUT/(name+'.d'),'-c',src,'-o',obj]);objects.append(dict(path=str(obj.relative_to(ROOT)),bytes=obj.stat().st_size,sha256=hashlib.sha256(obj.read_bytes()).hexdigest()));run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',obj])
(OUT/'BUILD.json').write_text(json.dumps(dict(schema='iq4_native_half_build_01',objects=objects,host_cases=13,sanitizers_passed=True,camera_access=False,native_pixels_accepted=False),indent=2)+'\n');print(json.dumps(objects))
