#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,subprocess
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/stock_storage_router_55';ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
PYTHON=ROOT/'build/dual-exposure-host-venv/bin/python'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def emit(p,x):p.write_text(json.dumps(x,indent=2)+'\n')
def main():
 OUT.mkdir(parents=True,exist_ok=True);commands=[]
 def run(argv,label):
  p=subprocess.run(list(map(str,argv)),cwd=ROOT,capture_output=True,text=True)
  commands.append(dict(label=label,argv=list(map(str,argv)),exit=p.returncode,stdout=p.stdout,stderr=p.stderr));emit(OUT/'COMMANDS.json',commands)
  assert p.returncode==0,(label,p.stdout,p.stderr);return p.stdout
 run(['python3',HERE/'collect.py'],'exact_original55_bindings')
 sdk=subprocess.check_output(['xcrun','--show-sdk-path'],text=True).strip();exe=OUT/'test_runtime'
 run(['/usr/bin/clang++','-isysroot',sdk,'-isystem',Path(sdk)/'usr/include/c++/v1','-std=c++17','-O1','-Wall','-Wextra','-Werror','-DIQ4_STOCK_JPEG_TEST','-x','c++',HERE/'runtime.cpp',HERE/'plan.c',HERE/'test_runtime.cpp','-o',exe],'host_compile_router')
 cases=['xqd','sd_only','archive','mirror_failure','jpeg_only','format_busy','pending_busy','receipt_busy','save_failure','jpeg_gate','native_exception','half_render_failure','archive_all_reject','archive_all_normalize']
 for case in cases:run([exe,case],'router_'+case)
 run(['/usr/bin/clang','-std=c11','-O1','-Wall','-Wextra','-Werror',HERE/'plan.c',HERE/'test_plan.c','-o',OUT/'test_plan'],'host_plan_compile');run([OUT/'test_plan'],'route_plan')
 run(['/usr/bin/clang','-std=c11','-O1','-Wall','-Wextra','-Werror','-DIQ4_STORAGE55_SETTINGS_HOST',HERE/'settings.c',HERE/'test_settings.c','-o',OUT/'test_settings'],'atomic_namespace_compile');run([OUT/'test_settings'],'atomic_namespace_roundtrip')
 flags=['-target','aarch64-linux-gnu.2.28','-DIQ4_JPEG_API_VERSION=82','-O2','-g0','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror']
 objects=[]
 for src,driver,std in [('runtime.cpp','c++','-std=c++17'),('settings.c','cc','-std=c11'),('plan.c','cc','-std=c11'),('policy.cpp','c++','-std=c++17'),('ctor_wrapper.S','cc',None),('delete_lookup.S','cc',None),('inner_wait.S','cc',None)]:
  obj=OUT/(Path(src).stem+'.o');run([ZIG,driver,*flags,*([std]if std else[]),'-c',HERE/src,'-o',obj],src)
  objects.append(row(obj));(OUT/(obj.name+'.asm')).write_text(run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-dr',obj],src+'_inspect'))
  run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',obj],src+'_undefined')
 run([PYTHON,HERE/'prove_delete_lookup.py'],'actual_A64_delete_lookup')
 run([PYTHON,HERE/'prove_half_wait.py'],'actual_A64_half_inner_wait')
 emit(OUT/'BUILD.json',dict(schema='iq4_stock_storage_router_build_55',objects=objects,
  host_runtime_cases=cases,actual_A64_delete_lookup=row(OUT/'A64_DELETE_LOOKUP.json'),actual_A64_half_inner_wait=row(OUT/'A64_HALF_WAIT.json'),host_route_plan_cases=12,
  codec_filesystem_receipt_normalizer_in_host_are_explicit_fixtures=True,
  atomic_config_real_host_files=True,raw_formats={'0':'IIQ','1':'JPEG','2':'IIQ+JPEG'},
  quality=100,half_dimensions=[7102,5326],camera_accessed=False,target_device_executed=False))
 print('PASS 55 router targeted build, namespace, route plan and actual A64 safe-clear boundary')
if __name__=='__main__':main()
