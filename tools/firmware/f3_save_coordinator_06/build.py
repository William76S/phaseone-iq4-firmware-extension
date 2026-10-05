#!/usr/bin/env python3
"""Only owned host tests and compile-only AArch64 production objects."""
from pathlib import Path
import subprocess,json,hashlib
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f3_save_coordinator_build_06';ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
def main():
 assert hashlib.sha256(ZIG.read_bytes()).hexdigest()=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
 OUT.mkdir(parents=True,exist_ok=True);calls=[]
 def run(args,label):
  args=list(map(str,args));r=subprocess.run(args,cwd=ROOT,capture_output=True,text=True);calls.append(dict(label=label,argv=args,exit_code=r.returncode,stdout=r.stdout,stderr=r.stderr));(OUT/'COMMANDS.json').write_text(json.dumps(calls,indent=2)+'\n');assert r.returncode==0,(label,r.stderr)
 sdk=subprocess.check_output(['/usr/bin/xcrun','--sdk','macosx','--show-sdk-path'],text=True).strip()
 for tag,extra in [('normal',[]),('san',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=OUT/('test_public_'+tag);run(['/usr/bin/clang','-std=c11','-O1','-Wall','-Wextra','-Werror',*extra,HERE/'test_public_raw.c',HERE/'public_raw.c','-o',exe],'compile_public_'+tag);run([exe],'run_public_16_'+tag)
  exe=OUT/('test_lifecycle_'+tag);run(['/usr/bin/clang++','-std=c++17','-isysroot',sdk,'-isystem',Path(sdk)/'usr/include/c++/v1','-O1','-Wall','-Wextra','-Werror','-ffunction-sections','-fdata-sections','-Wl,-dead_strip',*extra,HERE/'test_lifecycle.cpp','-o',exe],'compile_actual_lifecycle_'+tag);run([exe],'run_actual_lifecycle_16_'+tag)
 for name,lang,std in [('coordinator','c++','c++17'),('public_raw','cc','c11')]:
  ext='cpp'if lang=='c++'else'c';run([ZIG,lang,'-target','aarch64-linux-gnu.2.28','-std='+std,'-O2','-g0','-ffreestanding','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror','-MMD','-MF',OUT/(name+'.d'),'-c',HERE/(name+'.'+ext),'-o',OUT/(name+'.o')],'target_compile_'+name)
  run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',OUT/(name+'.o')],'undefined_'+name)
  run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-r','-t',OUT/(name+'.o')],'relocations_'+name)
 (OUT/'BUILD.json').write_text(json.dumps(dict(commands=calls,public_real_mac_posix_cases=16,actual_cleanup_sink_cases=16,configurations=['normal','asan_ubsan'],target_objects=2,target_executed=False,sdk_loaded=False,device_connected=False),indent=2)+'\n')
 print(json.dumps(dict(public=16,lifecycle=16,normal_and_sanitized=True,target_objects=2,target_executed=False)))
if __name__=='__main__':main()
