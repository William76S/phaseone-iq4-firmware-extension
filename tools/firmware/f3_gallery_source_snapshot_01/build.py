#!/usr/bin/env python3
from pathlib import Path
import subprocess,json,hashlib
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f3_gallery_source_snapshot_build_01'
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
def main():
 assert hashlib.sha256(ZIG.read_bytes()).hexdigest()=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
 OUT.mkdir(parents=True,exist_ok=True);calls=[]
 def run(args,label):
  args=list(map(str,args));r=subprocess.run(args,cwd=ROOT,capture_output=True,text=True);calls.append(dict(label=label,argv=args,exit_code=r.returncode,stdout=r.stdout,stderr=r.stderr));(OUT/'COMMANDS.json').write_text(json.dumps(calls,indent=2)+'\n');assert r.returncode==0,(label,r.stderr)
 run(['python3',HERE/'collect_static.py'],'finite_original_collect')
 sdk=subprocess.check_output(['/usr/bin/xcrun','--sdk','macosx','--show-sdk-path'],text=True).strip()
 for tag,extra in [('normal',[]),('san',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=OUT/('test_'+tag);run(['/usr/bin/clang++','-std=c++17','-DIQ4_SOURCE_DEPS_SYNTHETIC_02','-isysroot',sdk,'-isystem',Path(sdk)/'usr/include/c++/v1','-O1','-Wall','-Wextra','-Werror',*extra,HERE/'test_gallery.cpp',HERE/'gallery.cpp',ROOT/'tools/firmware/f3_source_dependencies_02/dependencies.cpp','-o',exe],'host_compile_'+tag);run([exe],'host_13_'+tag)
 for name in ['gallery','native_factory']:
  run([ZIG,'c++','-target','aarch64-linux-gnu.2.28','-std=c++17','-O2','-g0','-ffreestanding','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror','-MMD','-MF',OUT/(name+'.d'),'-c',HERE/(name+'.cpp'),'-o',OUT/(name+'.o')],'target_compile_'+name)
  run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',OUT/(name+'.o')],'target_U_'+name)
 (OUT/'BUILD.json').write_text(json.dumps(dict(commands=calls,normal_cases=13,san_cases=13,target_objects=2,target_executed=False),indent=2)+'\n')
 print(json.dumps(dict(normal=13,san=13,target_objects=2,target_executed=False)))
if __name__=='__main__':main()
