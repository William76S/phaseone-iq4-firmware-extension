#!/usr/bin/env python3
"""Own host fixtures + compile-only AArch64 object; never run the target."""
import hashlib,json,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
SRC=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f3_source_dependencies_build_01'
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
ZSHA='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
def sha(b):return hashlib.sha256(b).hexdigest()
def main():
 assert sha(ZIG.read_bytes())==ZSHA;OUT.mkdir(parents=True,exist_ok=True);commands=[]
 def run(argv,label):
  r=subprocess.run([str(x)for x in argv],cwd=ROOT,capture_output=True,text=True)
  commands.append(dict(label=label,argv=[str(x)for x in argv],exit_code=r.returncode,stdout=r.stdout,stderr=r.stderr))
  if r.returncode:raise RuntimeError(label+': '+r.stderr)
 sdk=subprocess.check_output(['/usr/bin/xcrun','--sdk','macosx','--show-sdk-path'],text=True).strip()
 for name,extra in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=OUT/('test_'+name);run(['/usr/bin/clang++','-isysroot',sdk,'-isystem',str(Path(sdk)/'usr/include/c++/v1'),'-std=c++17','-O1','-Wall','-Wextra','-Werror',*extra,SRC/'dependencies.cpp',SRC/'test_dependencies.cpp','-o',exe],'build_'+name)
  run([exe],'run_'+name)
 run([ZIG,'c++','-target','aarch64-linux-gnu.2.28','-std=c++17','-O2','-fno-exceptions','-fno-rtti','-mno-outline-atomics','-funwind-tables','-fno-omit-frame-pointer','-MMD','-MF',OUT/'dependencies.d','-c',SRC/'dependencies.cpp','-o',OUT/'dependencies.o'],'compile_target_not_execute')
 run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-r','-t',OUT/'dependencies.o'],'inspect_target')
 members=[dict(path=p.relative_to(ROOT).as_posix(),bytes=p.stat().st_size,sha256=sha(p.read_bytes()))for p in sorted(OUT.iterdir())if p.is_file()and p.name!='BUILD.json']
 (OUT/'BUILD.json').write_text(json.dumps(dict(schema='iq4_f3_source_dependencies_build_01',commands=commands,members=members,target_executed=False,sdk_loaded=False,device_connected=False),indent=2)+'\n')
 print(json.dumps(dict(host_cases_normal=12,host_cases_asan_ubsan=12,target_compile_exit0=True,target_executed=False,build_sha256=sha((OUT/'BUILD.json').read_bytes()))))
if __name__=='__main__':main()
