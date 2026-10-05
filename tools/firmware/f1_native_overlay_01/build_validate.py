#!/usr/bin/env python3
"""F1 own-code raster/fault tests and compile-only AArch64 ABI probes."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2];OUT=ROOT/'analysis/firmware/f1_native_overlay_01'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def run(cmd):
 r=subprocess.run(list(map(str,cmd)),cwd=ROOT,text=True,capture_output=True)
 if r.returncode:raise SystemExit(r.stdout+r.stderr)
 return r.stdout
def main():
 OUT.mkdir(exist_ok=True);(OUT/'.gitignore').write_text('*.o\n*.elf\n*.zip\n')
 build=ROOT/'build/f1_native_overlay01_host';build.mkdir(exist_ok=True)
 sdk=run(['xcrun','--show-sdk-path']).strip()
 common=['/usr/bin/clang++','-std=c++17','-O2','-Wall','-Wextra','-Wpedantic','-Werror','-isystem',sdk+'/usr/include/c++/v1','-I',ROOT/'src/core/include','-I',ROOT/'src/display/include']
 sources=[HERE/'overlay.cpp',HERE/'test_overlay.cpp',ROOT/'src/core/lib/image_core.cpp',ROOT/'src/display/lib/display_mask.cpp'];tests={}
 for name,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=build/name;run(common+flags+['-DIQ4_F1_OVERLAY_SYNTHETIC_HOST=1']+sources+['-o',exe]);receipt=run([exe])
  if receipt!='19 F1 own-code groups; 1048576 independent pixels; vendor/device execution zero\n':raise SystemExit('Host receipt changed')
  tests[name]=dict(groups=19,independent_pixels=1048576,exit_code=0,receipt=receipt.strip())
 exe=build/'production';run(common+sources+['-o',exe]);receipt=run([exe])
 if receipt!='production disabled: zero native reads/calls\n':raise SystemExit('Production guard changed')
 tests['production']=dict(groups=1,exit_code=0,receipt=receipt.strip())
 zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';lock=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text())
 if sha(zig)!=lock['zig_binary_sha256'] or run([zig,'version']).strip()!=lock['version']:raise SystemExit('Locked compiler changed')
 sys.path.insert(0,str(ROOT/'tools/firmware/windows_aarch64_toolchain_01'));import probes
 objects=[]
 for name,source in [('overlay',HERE/'overlay.cpp'),('Rectangle24_ABI_probe',HERE/'abi_probe.cpp')]:
  obj=OUT/(name+'.aarch64.o');run([zig,'c++','-target',lock['target'],'-std=c++17','-O2','-fPIC','-fvisibility=hidden','-Wall','-Wextra','-Wpedantic','-Werror','-I',ROOT/'src/core/include','-I',ROOT/'src/display/include','-c',source,'-o',obj])
  target=probes.inspect_elf(obj,1);denied={'kill','raise','ptrace','system','popen','execve','dlopen','dlsym','ioctl','reboot','open','pwrite','write','pthread_create'}
  if set(target['undefined_symbols'])&denied:raise SystemExit('Unexpected target import')
  sections=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','--section-headers',obj])
  if '.init_array' in sections or '.fini_array' in sections:raise SystemExit('No implicit target constructors')
  (OUT/(name+'_sections.txt')).write_text('\n'.join(s.rstrip() for s in sections.splitlines())+'\n');objects.append(target)
  if name=='Rectangle24_ABI_probe':
   dis=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d',obj]);(OUT/'Rectangle24_ABI_probe.disasm.txt').write_text('\n'.join(s.rstrip() for s in dis.splitlines())+'\n')
 report=dict(schema='iq4_f1_native_overlay01_build_v1',tests=tests,target_objects=objects,production_binding_enabled=False,device_accessed=False,vendor_code_executed=False,target_executed=False,actual_native_instance_hook_or_recovery_verified=False,actual_surface_viewport_mapping_and_fresh_repaint_verified=False,actual_RAW_JPEG_video_isolation_verified=False,
 sources={str(p.relative_to(ROOT)):sha(p) for p in sources+[HERE/'overlay.hpp',HERE/'abi_probe.cpp',ROOT/'src/display/include/iq4/display_mask.hpp']})
 (OUT/'build_validation.json').write_text(json.dumps(report,indent=2)+'\n')
 print(json.dumps(dict(host_groups=19,independent_pixels=1048576,production_zero_calls=True,target_objects=[t['sha256'] for t in objects],actual_acceptance=False)))
if __name__=='__main__':main()
