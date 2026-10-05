#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,subprocess
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/f3_native_size_menu_02/build';ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 OUT.mkdir(exist_ok=True);commands=[]
 def run(argv,label):
  argv=list(map(str,argv));q=subprocess.run(argv,cwd=ROOT,capture_output=True,text=True);commands.append(dict(label=label,argv=argv,exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(OUT/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert q.returncode==0,(label,q.stderr);return q.stdout
 sdk=subprocess.check_output(['/usr/bin/xcrun','--show-sdk-path'],text=True).strip();tests=[[],*[[x]for x in ['install0','install50','pc','pin','ui','parent','title','item','dto']],*[[kind,str(n)]for kind,maxi in [('alloc',7),('ctor',7),('append',6)]for n in range(1,maxi+1)]]
 for kind,extra in [('normal',[]),('san',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=OUT/('test_'+kind);run(['/usr/bin/clang','-isysroot',sdk,'-std=c11','-O1','-Wall','-Wextra','-Werror',*extra,HERE/'test_menu.c',ROOT/'tools/firmware/f3_capture_menu_08/policy.c',ROOT/'src/codec/export_geometry.c','-o',exe],'compile_'+kind)
  for args in tests:run([exe,*args],kind+'_'+('_'.join(args)or'main'))
 flags=['cc','-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror']
 for name in ('size_menu.o','size_menu_repeat.o'):run([ZIG,*flags,'-MMD','-MF',OUT/(name+'.d'),'-c',HERE/'runtime.c','-o',OUT/name],name)
 assert (OUT/'size_menu.o').read_bytes()==(OUT/'size_menu_repeat.o').read_bytes()
 text=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-dr',OUT/'size_menu.o'],'target_inspect');(OUT/'size_menu.asm').write_text(text)
 run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',OUT/'size_menu.o'],'target_undefined')
 report=dict(schema='iq4_native_storage_size_menu_build_01',object=row(OUT/'size_menu.o'),compiler=row(ZIG),normal_cases=len(tests),san_cases=len(tests),same_target_recompiled=True,target_executed=False,camera_accessed=False)
 (OUT/'BUILD.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
if __name__=='__main__':main()
