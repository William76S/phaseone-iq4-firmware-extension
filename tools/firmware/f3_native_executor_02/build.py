#!/usr/bin/env python3
"""Owned scheduler fixtures + compile-only single executor replacement."""
from pathlib import Path
import subprocess,json,hashlib
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f3_native_executor_build_02';ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
def main():
 assert not OUT.exists();assert hashlib.sha256(ZIG.read_bytes()).hexdigest()=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c';OUT.mkdir(parents=True);calls=[]
 def run(args,label):
  args=list(map(str,args));r=subprocess.run(args,cwd=ROOT,capture_output=True,text=True);calls.append(dict(label=label,argv=args,exit_code=r.returncode,stdout=r.stdout,stderr=r.stderr));(OUT/'COMMANDS.json').write_text(json.dumps(calls,indent=2)+'\n');assert r.returncode==0,(label,r.stderr)
 sdk=subprocess.check_output(['/usr/bin/xcrun','--show-sdk-path'],text=True).strip()
 for tag,extra in [('normal',[]),('san',['-fsanitize=address,undefined','-fno-omit-frame-pointer']),('tsan',['-fsanitize=thread'])]:
  flags=['-O1','-Wall','-Wextra','-Werror',*extra];activity=OUT/('activity_'+tag+'.o');exe=OUT/('test_'+tag)
  run(['/usr/bin/clang','-std=c11',*flags,'-DIQ4_ACTIVITY_SYNTHETIC_HOST','-c',ROOT/'tools/firmware/native_activity_01/activity.c','-o',activity],'compile_activity_'+tag)
  run(['/usr/bin/clang++','-std=c++17','-isysroot',sdk,'-isystem',Path(sdk)/'usr/include/c++/v1',*flags,'-DIQ4_F3_EXECUTOR_SYNTHETIC_HOST','-DIQ4_ACTIVITY_SYNTHETIC_HOST',HERE/'test_executor.cpp',activity,'-o',exe],'compile_actual_executor_'+tag);run([exe],'run_actual_executor_'+tag)
 run([ZIG,'c++','-target','aarch64-linux-gnu.2.28','-std=c++17','-O2','-g0','-Wall','-Wextra','-Werror','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-fexceptions','-MMD','-MF',OUT/'executor.d','-c',HERE/'executor.cpp','-o',OUT/'executor.o'],'target_compile_only')
 run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',OUT/'executor.o'],'target_undefined');run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-r','-t',OUT/'executor.o'],'target_relocations')
 (OUT/'BUILD.json').write_text(json.dumps(dict(commands=calls,focused_groups=8,inherited_regression_groups=17,finish_SD_race_repetitions=32,configurations=['normal','asan_ubsan','tsan'],target_objects=1,target_executed=False,sdk_loaded=False),indent=2)+'\n');print('executor02 PASS')
if __name__=='__main__':main()
