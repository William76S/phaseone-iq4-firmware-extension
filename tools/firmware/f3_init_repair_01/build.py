#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,subprocess,sys
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f3_init_repair_01/build';ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 OUT.mkdir(exist_ok=True);calls=[]
 def run(argv,label):
  q=subprocess.run(list(map(str,argv)),cwd=ROOT,capture_output=True,text=True);calls.append(dict(label=label,argv=list(map(str,argv)),exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(OUT/'COMMANDS.json').write_text(json.dumps(calls,indent=2)+'\n');assert not q.returncode,(label,q.stderr)
 sdk=subprocess.check_output(['/usr/bin/xcrun','--sdk','macosx','--show-sdk-path'],text=True).strip()
 flags=['-std=c++17','-isysroot',sdk,'-isystem',Path(sdk)/'usr/include/c++/v1','-O1','-Wall','-Wextra','-Werror']
 for name,src in [('old',ROOT/'tools/firmware/native_copy_rtti_01/rtti.cpp'),('new',HERE/'rtti.cpp')]:
  run(['/usr/bin/clang++',*flags,'-dynamiclib',src,'-o',OUT/(name+'.dylib')],name+'_host_C_verifier')
 run([sys.executable,HERE/'verify_loaded.py',OUT],'actual_ELF_loaded_model')
 for tag,extra in [('normal',[]),('san',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=OUT/('regression_'+tag);run(['/usr/bin/clang++',*flags,*extra,HERE/'test_page_bias.cpp',HERE/'rtti.cpp','-o',exe],'compile_regression_'+tag);run([exe],'256_page_bias_regressions_'+tag)
 target=['c++','-target','aarch64-linux-gnu.2.28','-std=c++17','-O2','-g0','-ffreestanding','-fno-exceptions','-fno-rtti','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror']
 for name in ('rtti.o','rtti_repeat.o'):run([ZIG,*target,'-c',HERE/'rtti.cpp','-o',OUT/name],name)
 assert (OUT/'rtti.o').read_bytes()==(OUT/'rtti_repeat.o').read_bytes()
 run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',OUT/'rtti.o'],'target_undefined')
 run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-dr',OUT/'rtti.o'],'target_inspect')
 (OUT/'BUILD.json').write_text(json.dumps(dict(schema='iq4_rtti_loader_bias_repair_build_01',object=row(OUT/'rtti.o'),compiler=row(ZIG),source=row(HERE/'rtti.cpp'),regressions_normal=256,regressions_san=256,actual_ELF_model_cases=27,repeated_target_object_identical=True,target_executed=False,camera_accessed=False),indent=2)+'\n')
 print(json.dumps(row(OUT/'rtti.o')))
if __name__=='__main__':main()
