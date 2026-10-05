#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,subprocess,difflib
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/f3_native_card_bridge_build_06';ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 OUT.mkdir(parents=True,exist_ok=True);commands=[]
 def run(a):
  a=list(map(str,a));r=subprocess.run(a,cwd=ROOT,capture_output=True,text=True);commands.append(dict(argv=a,returncode=r.returncode,stdout=r.stdout,stderr=r.stderr));(OUT/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
  if r.returncode:raise RuntimeError(r.stdout+r.stderr)
 for tag,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=OUT/('async_'+tag);run(['/usr/bin/clang','-std=c11','-O1','-Wall','-Wextra','-Werror',*flags,HERE/'card.c',HERE/'test_async.c','-o',exe])
  for i in range(7):run([exe,ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin',str(i)])
 for name in ['card','fdinfo','card_linux','native_calls','fs05']:
  cpp=name=='native_calls';obj=OUT/(name+'.o');run([ZIG,'c++'if cpp else'cc','-target','aarch64-linux-gnu.2.28','-std=c++17'if cpp else'-std=c11','-O2','-g0','-ffreestanding','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror','-MMD','-MF',OUT/(name+'.d'),'-c',HERE/(name+('.cpp'if cpp else'.c')),'-o',obj]);run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',obj]);run(['/usr/bin/file',obj])
 delta=''
 for n in ['card.h','card.c','native_calls.cpp','card_linux.c','fdinfo.c','fs05.c']:
  delta+=''.join(difflib.unified_diff((ROOT/'tools/firmware/f3_native_card_bridge_05'/n).read_text().splitlines(True),(HERE/n).read_text().splitlines(True),fromfile='frozen05/'+n,tofile='new06/'+n))
 (OUT/'DELTA_05_TO06.diff').write_text(delta)
 (OUT/'BUILD.json').write_text(json.dumps(dict(schema='iq4_f3_native_card_async_build_06',commands=commands,inputs=[row(HERE/n)for n in ['card.c','card.h','native_calls.cpp','card_linux.c','fdinfo.c','fs05.c','test_async.c','signatures.inc']],outputs=[row(p)for p in sorted(OUT.iterdir())if p.is_file()and p.name!='BUILD.json'],normal_cases=7,asan_ubsan_cases=7,native_wait_executed=False,target_executed=False),indent=2)+'\n');print(json.dumps(dict(all_commands_passed=True,normal_cases=7,asan_ubsan_cases=7,wait_calls=0,target_executed=False)))
if __name__=='__main__':main()
