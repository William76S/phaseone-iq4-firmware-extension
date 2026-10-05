#!/usr/bin/env python3
from pathlib import Path
import subprocess,json,hashlib
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f3_saved_raw_capture_build_02';ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
def main():
 assert hashlib.sha256(ZIG.read_bytes()).hexdigest()=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
 OUT.mkdir(parents=True,exist_ok=True);calls=[]
 def run(args,label):
  args=list(map(str,args));r=subprocess.run(args,cwd=ROOT,capture_output=True,text=True);calls.append(dict(label=label,argv=args,exit_code=r.returncode,stdout=r.stdout,stderr=r.stderr));(OUT/'COMMANDS.json').write_text(json.dumps(calls,indent=2)+'\n');assert r.returncode==0,(label,r.stderr)
 sdk=subprocess.check_output(['/usr/bin/xcrun','--sdk','macosx','--show-sdk-path'],text=True).strip()
 for tag,extra in [('normal',[]),('san',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=OUT/('test_'+tag);run(['/usr/bin/clang++','-std=c++17','-isysroot',sdk,'-isystem',Path(sdk)/'usr/include/c++/v1','-O1','-Wall','-Wextra','-Werror','-ffunction-sections','-fdata-sections','-Wl,-dead_strip',*extra,HERE/'test_snapshot.cpp','-o',exe],'host_compile_'+tag);run([exe],'host_8_'+tag)
 run([ZIG,'c++','-target','aarch64-linux-gnu.2.28','-std=c++17','-O2','-g0','-ffreestanding','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror','-MMD','-MF',OUT/'runtime.d','-c',HERE/'runtime.cpp','-o',OUT/'runtime.o'],'target_compile_runtime')
 run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',OUT/'runtime.o'],'target_U_runtime')
 old=(ROOT/'tools/firmware/f3_saved_raw_capture_01/runtime.cpp').read_text();new=(HERE/'runtime.cpp').read_text();start=new.index('static int policy(');end=new.index('extern "C" int f3_capture_configure_01',start)
 a=old.index('static int policy(');b=old.index('extern "C" int f3_capture_configure_01',a)
 normalized=new[:start]+old[a:b]+new[end:];normalized=normalized.replace('../f3_saved_raw_capture_01/capture.h','capture.h').replace('../f3_capture_menu_04/policy.h','../f3_capture_menu_03/policy.h');assert normalized==old
 (OUT/'BUILD.json').write_text(json.dumps(dict(commands=calls,normal_cases=8,san_cases=8,target_objects=1,normalization_all_other_bytes_equal=True,target_executed=False),indent=2)+'\n')
 print(json.dumps(dict(normal=8,san=8,target_objects=1,normalization_all_other_bytes_equal=True,target_executed=False)))
if __name__=='__main__':main()
