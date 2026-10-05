#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,subprocess
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/f3_native_storage_bridge_01/build';ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 OUT.mkdir(exist_ok=True);commands=[]
 def run(argv,label):
  argv=list(map(str,argv));q=subprocess.run(argv,cwd=ROOT,capture_output=True,text=True);commands.append(dict(label=label,argv=argv,exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(OUT/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert q.returncode==0,(label,q.stderr,q.stdout);return q.stdout
 sdk=subprocess.check_output(['/usr/bin/xcrun','--show-sdk-path'],text=True).strip()
 tests=[[],*[[x]for x in ['install-pending','install-failed','badpin','baddto','badflag','unbound','exception','readback','protect','ui','backend','cap','busy']],*[[k,str(i)]for k,maximum in [('alloc',4),('ctor',4),('append',3)]for i in range(1,maximum+1)]]
 for kind,extra in [('normal',[]),('san',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=OUT/('test_'+kind);run(['/usr/bin/clang','-isysroot',sdk,'-std=c11','-DIQ4_STORAGE_MUTEX_SYNTHETIC_HOST','-O1','-Wall','-Wextra','-Werror',*extra,HERE/'test_bridge.c',HERE/'mutex.c',ROOT/'tools/firmware/f3_capture_menu_08/policy.c',ROOT/'tools/firmware/native_activity_01/activity.c',ROOT/'src/codec/export_geometry.c','-o',exe],'compile_'+kind)
  for args in tests:run([exe,*args],kind+'_'+('_'.join(args)or'main'))
  concurrent=OUT/('test_concurrent_'+kind);run(['/usr/bin/clang','-isysroot',sdk,'-std=c11','-DIQ4_STORAGE_MUTEX_SYNTHETIC_HOST','-O1','-Wall','-Wextra','-Werror',*extra,HERE/'test_concurrency.c',HERE/'mutex.c',ROOT/'tools/firmware/f3_capture_menu_08/policy.c',ROOT/'tools/firmware/native_activity_01/activity.c',ROOT/'src/codec/export_geometry.c','-o',concurrent],'concurrent_compile_'+kind);run([concurrent],'concurrent_'+kind)
  exc=OUT/('test_native_'+kind);run(['/usr/bin/clang++','-isysroot',sdk,'-isystem',Path(sdk)/'usr/include/c++/v1','-std=c++17','-O1','-Wall','-Wextra','-Werror',*extra,HERE/'test_native_calls.cpp','-o',exc],'exception_compile_'+kind);run([exc],'exception_'+kind)
 mutex_test=OUT/'test_mutex';run(['/usr/bin/clang','-isysroot',sdk,'-std=c11','-O1','-Wall','-Wextra','-Werror',HERE/'test_mutex.c','-o',mutex_test],'mutex_compile')
 for case in ['success','lock','unlock','pending']:run([mutex_test,case],'mutex_'+case)
 outputs=[]
 flags=['-target','aarch64-linux-gnu.2.28','-O2','-g0','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror']
 for source,name,driver,standard in [('runtime.c','storage_bridge.o','cc','-std=c11'),('native_calls.cpp','storage_native_calls.o','c++','-std=c++17'),('wrappers.S','storage_wrappers.o','cc',None),('mutex.c','storage_mutex.o','cc','-std=c11')]:
  target=OUT/name
  for suffix in ['', '.repeat']:
   dest=Path(str(target)+suffix);run([ZIG,driver,*flags,*([standard]if standard else []),'-MMD','-MF',str(dest)+'.d','-c',HERE/source,'-o',dest],name+suffix)
  assert target.read_bytes()==Path(str(target)+'.repeat').read_bytes()
  text=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-dr',target],name+'_inspect');(OUT/(name+'.asm')).write_text(text)
  run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',target],name+'_undefined');outputs.append(row(target))
 emu=ROOT/'build/dual-exposure-host-venv/bin/python'
 run([emu,HERE/'emulate_wrappers.py'],'actual_A64_wrappers')
 run([emu,HERE/'prove_mutex.py'],'actual_stock_pthread_ABI')
 result=dict(schema='iq4_native_storage_bridge_build_01',objects=outputs,compiler=row(ZIG),normal_process_cases=len(tests),san_process_cases=len(tests),native_exception_cases_each=9,pthread_interleavings_each=300,mutex_initializer_cases=4,actual_A64_wrapper_cases=108,stock_pthread_fastpath_cycles=3,reproducible=True,target_executed=False,camera_accessed=False)
 (OUT/'BUILD.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result))
if __name__=='__main__':main()
