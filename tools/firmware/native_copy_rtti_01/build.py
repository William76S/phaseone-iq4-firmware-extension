#!/usr/bin/env python3
from pathlib import Path
import subprocess,json,hashlib
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/native_copy_rtti_build_01';ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
def main():
 assert hashlib.sha256(ZIG.read_bytes()).hexdigest()=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
 OUT.mkdir(parents=True,exist_ok=True);calls=[]
 def run(args,label):
  args=list(map(str,args));r=subprocess.run(args,cwd=ROOT,capture_output=True,text=True);calls.append(dict(label=label,argv=args,exit_code=r.returncode,stdout=r.stdout,stderr=r.stderr));(OUT/'COMMANDS.json').write_text(json.dumps(calls,indent=2)+'\n');assert r.returncode==0,(label,r.stderr)
 run(['python3',HERE/'collect.py'],'collect_exact_graph')
 sdk=subprocess.check_output(['/usr/bin/xcrun','--sdk','macosx','--show-sdk-path'],text=True).strip()
 for tag,extra in [('normal',[]),('san',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=OUT/('test_'+tag);run(['/usr/bin/clang++','-std=c++17','-isysroot',sdk,'-isystem',Path(sdk)/'usr/include/c++/v1','-O1','-Wall','-Wextra','-Werror',*extra,HERE/'test_rtti.cpp',HERE/'rtti.cpp','-o',exe],'host_compile_'+tag);run([exe],'host_16_'+tag)
 run([ZIG,'c++','-target','aarch64-linux-gnu.2.28','-std=c++17','-O2','-g0','-ffreestanding','-fno-exceptions','-fno-rtti','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror','-MMD','-MF',OUT/'rtti.d','-c',HERE/'rtti.cpp','-o',OUT/'rtti.o'],'target_compile_rtti')
 run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',OUT/'rtti.o'],'target_U_rtti')
 run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-r','-t','-d',OUT/'rtti.o'],'target_inspect_rtti')
 (OUT/'BUILD.json').write_text(json.dumps(dict(commands=calls,normal_cases=16,san_cases=16,target_objects=1,target_executed=False,library_loaded=False,sdk_loaded=False),indent=2)+'\n')
 print(json.dumps(dict(normal=16,san=16,target_objects=1,target_executed=False,library_loaded=False)))
if __name__=='__main__':main()
