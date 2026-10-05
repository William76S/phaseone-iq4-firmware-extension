#!/usr/bin/env python3
from pathlib import Path
import subprocess,json,hashlib,sys
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
out=Path(sys.argv[1]).resolve();assert out.is_relative_to(ROOT) and not out.exists();out.mkdir(parents=True);commands=[]
def run(a):
 a=list(map(str,a));q=subprocess.run(a,cwd=ROOT,text=True,capture_output=True);commands.append(dict(argv=a,exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert q.returncode==0,q.stderr;return q.stdout.strip()
sdk=run(['/usr/bin/xcrun','--show-sdk-path']);cc='/Library/Developer/CommandLineTools/usr/bin/clang++'
for tag,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-sanitize-recover=all'])]:
 exe=out/tag;run([cc,'-std=c++17','-isysroot',sdk,'-isystem',sdk+'/usr/include/c++/v1','-O2','-Wall','-Wextra','-Werror',*flags,HERE/'test_runtime.cpp','-o',exe]);print(run([exe]))
zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';assert hashlib.sha256(zig.read_bytes()).hexdigest()=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
obj=out/'dual.o';run([zig,'c++','-target','aarch64-linux-gnu.2.28','-std=c++17','-O2','-g0','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror','-MMD','-MF',out/'dual.d','-c',HERE/'runtime.cpp','-o',obj]);run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',obj]);print(hashlib.sha256(obj.read_bytes()).hexdigest())
