#!/usr/bin/env python3
"""Actual narrow no-enqueue routing fault fixtures + compile-only replacement."""
from pathlib import Path
import subprocess,json,hashlib,difflib
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f3_save_coordinator_build_08_attempt04';ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
def main():
 assert not OUT.exists();assert hashlib.sha256(ZIG.read_bytes()).hexdigest()=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c';OUT.mkdir(parents=True);calls=[]
 def run(args,label):
  args=list(map(str,args));r=subprocess.run(args,cwd=ROOT,capture_output=True,text=True);calls.append(dict(label=label,argv=args,exit_code=r.returncode,stdout=r.stdout,stderr=r.stderr));(OUT/'COMMANDS.json').write_text(json.dumps(calls,indent=2)+'\n');assert r.returncode==0,(label,r.stderr)
 sdk=subprocess.check_output(['/usr/bin/xcrun','--show-sdk-path'],text=True).strip()
 for tag,extra in [('normal',[]),('san',['-fsanitize=address,undefined','-fno-omit-frame-pointer','-fno-sanitize-recover=all'])]:
  for fixture in ('test_saved_route','test_lifecycle'):
   exe=OUT/(fixture+'_'+tag);run(['/usr/bin/clang++','-std=c++17','-isysroot',sdk,'-isystem',Path(sdk)/'usr/include/c++/v1','-O1','-Wall','-Wextra','-Werror','-ffunction-sections','-fdata-sections','-Wl,-dead_strip',*extra,HERE/(fixture+'.cpp'),'-o',exe],'compile_actual_'+fixture+'_'+tag);run([exe],'run_actual_'+fixture+'_'+tag)

 run([ZIG,'c++','-target','aarch64-linux-gnu.2.28','-std=c++17','-O2','-g0','-ffreestanding','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror','-MMD','-MF',OUT/'coordinator.d','-c',HERE/'coordinator.cpp','-o',OUT/'coordinator.o'],'target_compile_only')
 target=calls[-1]['argv'];repeat=list(target);repeat[repeat.index('-MF')+1]=str(OUT/'coordinator_repeat.d');repeat[repeat.index('-o')+1]=str(OUT/'coordinator_repeat.o');run(repeat,'target_repeat_compile_only')
 assert (OUT/'coordinator.o').read_bytes()==(OUT/'coordinator_repeat.o').read_bytes()
 (OUT/'DELTA.diff').write_text(''.join(difflib.unified_diff((ROOT/'tools/firmware/f3_save_coordinator_07/coordinator.cpp').read_text().splitlines(True),(HERE/'coordinator.cpp').read_text().splitlines(True),fromfile='f3_save_coordinator_07/coordinator.cpp',tofile='HERE/coordinator.cpp')))
 run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',OUT/'coordinator.o'],'target_undefined');run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-r','-t',OUT/'coordinator.o'],'target_relocations')
 (OUT/'BUILD.json').write_text(json.dumps(dict(commands=calls,focused_route_groups=18,actual_saved_prepare_groups=5,inherited_no_enqueue_groups=11,actual_cleanup_sink_groups=16,configurations=['normal','asan_ubsan'],target_objects=2,canonical_target_objects=1,target_repeated_bytes_equal=True,target_executed=False,sdk_loaded=False),indent=2)+'\n');print('coordinator08 PASS')
if __name__=='__main__':main()
