#!/usr/bin/env python3
"""Own host fault tests; pinned AArch64 ET_REL only; no firmware execution."""
from pathlib import Path
import hashlib,json,subprocess,sys
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2];OUT=ROOT/'analysis/firmware/f1_native_ui_02'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def run(cmd):
 r=subprocess.run(list(map(str,cmd)),cwd=ROOT,text=True,capture_output=True)
 if r.returncode:raise SystemExit(r.stdout+r.stderr)
 return r.stdout
def main():
 OUT.mkdir(exist_ok=True);(OUT/'.gitignore').write_text('*.o\n*.elf\n*.zip\nprivate/\n')
 build=ROOT/'build/f1_native_ui02_host';build.mkdir(exist_ok=True)
 sdk=run(['xcrun','--show-sdk-path']).strip()
 common=['/usr/bin/clang++','-std=c++17','-O2','-Wall','-Wextra','-Wpedantic','-Werror','-isystem',sdk+'/usr/include/c++/v1','-I',ROOT/'src/core/include','-I',ROOT/'src/display/include']
 sources=[HERE/'ui.cpp',HERE/'candidates.cpp',HERE/'test_ui.cpp',ROOT/'tools/firmware/f1_native_overlay_01/overlay.cpp',ROOT/'src/core/lib/image_core.cpp',ROOT/'src/display/lib/display_mask.cpp'];tests={}
 for name,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=build/name;run(common+flags+['-DIQ4_F1_UI02_SYNTHETIC_HOST=1']+sources+['-o',exe]);receipt=run([exe])
  if receipt!='30 F1 UI02 finite own-code groups; native/device execution zero\n':raise SystemExit('Host receipt changed')
  tests[name]=dict(groups=30,exit_code=0,receipt=receipt.strip())
 exe=build/'production';run(common+sources+['-o',exe]);receipt=run([exe])
 if receipt!='production EN0: zero native reads/calls\n':raise SystemExit('Production guard changed')
 tests['production']=dict(groups=1,exit_code=0,receipt=receipt.strip())
 zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';lock=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text())
 if sha(zig)!=lock['zig_binary_sha256']or run([zig,'version']).strip()!=lock['version']:raise SystemExit('Pinned compiler changed')
 sys.path.insert(0,str(ROOT/'tools/firmware/windows_aarch64_toolchain_01'));import probes
 objects=[]
 for name,source in [('ui',HERE/'ui.cpp'),('candidates',HERE/'candidates.cpp')]:
  obj=OUT/(name+'.aarch64.o');run([zig,'c++','-target',lock['target'],'-std=c++17','-O2','-fPIC','-fvisibility=hidden','-Wall','-Wextra','-Wpedantic','-Werror','-I',ROOT/'src/core/include','-I',ROOT/'src/display/include','-c',source,'-o',obj])
  target=probes.inspect_elf(obj,1)
  denied={'kill','raise','ptrace','system','popen','execve','dlopen','dlsym','ioctl','reboot','open','pwrite','write','pthread_create'}
  if set(target['undefined_symbols'])&denied:raise SystemExit('Unexpected target import')
  sections=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','--section-headers',obj])
  if '.init_array'in sections or '.fini_array'in sections:raise SystemExit('Unexpected implicit target constructor')
  (OUT/(name+'_sections.txt')).write_text('\n'.join(x.rstrip()for x in sections.splitlines())+'\n');objects.append(target)
 report=dict(schema='iq4_f1_native_ui02_build_v1',tests=tests,target_objects=objects,production_binding_enabled=False,device_accessed=False,vendor_code_executed=False,target_executed=False,actual_owner_and_native_menu_verified=False,actual_fresh_repaint_and_disable_restore_verified=False,actual_surface_geometry_and_RAW_JPEG_isolation_verified=False,sources={str(p.relative_to(ROOT)):sha(p)for p in sources+[HERE/'ui.hpp',HERE/'entry_bytes.hpp']})
 (OUT/'build_validation.json').write_text(json.dumps(report,indent=2)+'\n')
 print(json.dumps(dict(host_groups_each=30,production_zero_calls=True,target_ET_REL=[o['sha256']for o in objects],actual_acceptance=False)))
if __name__=='__main__':main()
