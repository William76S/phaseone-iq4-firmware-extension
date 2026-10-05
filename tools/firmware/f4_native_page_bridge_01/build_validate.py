#!/usr/bin/env python3
"""Own-code host tests and AArch64 ET_REL compilation; no device/native calls."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2];OUT=ROOT/'analysis/firmware/f4_native_page_bridge_01'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def run(cmd):
    r=subprocess.run(list(map(str,cmd)),cwd=ROOT,text=True,capture_output=True)
    if r.returncode:raise SystemExit(r.stdout+r.stderr)
    return r.stdout
def main():
    OUT.mkdir(exist_ok=True);(OUT/'.gitignore').write_text('*.o\n*.elf\n*.zip\n')
    build=ROOT/'build/f4_native_page_bridge01_host';build.mkdir(exist_ok=True)
    sdk=run(['xcrun','--show-sdk-path']).strip()
    common=['/usr/bin/clang++','-std=c++17','-O2','-Wall','-Wextra','-Wpedantic','-Werror','-isystem',sdk+'/usr/include/c++/v1']
    source=[HERE/'page_bridge.cpp',ROOT/'src/runtime/recording.cpp',HERE/'test_page.cpp'];results={}
    for name,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer']),('tsan',['-fsanitize=thread','-fno-omit-frame-pointer'])]:
        exe=build/name;run(common+flags+['-DIQ4_F4_PAGE_SYNTHETIC_HOST=1']+source+['-o',exe]);receipt=run([exe])
        if receipt!='22 own-code page groups passed; no vendor/UI/device calls\n':raise SystemExit('Host receipt changed')
        results[name]={'groups':22,'exit_code':0,'receipt':receipt.strip()}
    exe=build/'production_reject';run(common+source+['-o',exe]);receipt=run([exe])
    if receipt!='production reject: zero ports/backend/native calls\n':raise SystemExit('Production guard changed')
    results['production']={'groups':1,'exit_code':0,'receipt':receipt.strip()}
    zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';lock=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text())
    if sha(zig)!=lock['zig_binary_sha256'] or run([zig,'version']).strip()!=lock['version']:raise SystemExit('Locked compiler changed')
    obj=OUT/'page_bridge.aarch64.o'
    run([zig,'c++','-target',lock['target'],'-std=c++17','-O2','-fPIC','-fvisibility=hidden','-Wall','-Wextra','-Wpedantic','-Werror','-c',HERE/'page_bridge.cpp','-o',obj])
    sys.path.insert(0,str(ROOT/'tools/firmware/windows_aarch64_toolchain_01'));import probes
    target=probes.inspect_elf(obj,1)
    denied={'kill','raise','ptrace','system','popen','execve','dlopen','dlsym','ioctl','reboot','open','pwrite','write','pthread_create'}
    if set(target['undefined_symbols'])&denied:raise SystemExit('Unexpected target import')
    sections=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','--section-headers',obj])
    if '.init_array' in sections or '.fini_array' in sections:raise SystemExit('ET_REL must not have constructors')
    (OUT/'target_sections.txt').write_text('\n'.join(s.rstrip() for s in sections.splitlines())+'\n')
    report={'schema':'iq4_f4_native_page_bridge01_host_v1','tests':results,'target':target,
      'production_native_binding_enabled':False,'vendor_code_executed':False,'device_accessed':False,'target_executed':False,
      'actual_page_enter_touch_keys_return_or_undo_verified':False,'actual_worker_card_source_verified':False,
      'actual_mode_or_1080p60_verified':False,'sources':{str(p.relative_to(ROOT)):sha(p) for p in source+[HERE/'page_bridge.hpp',HERE/'native_abi.hpp']}}
    (OUT/'build_validation.json').write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps({'host_groups_normal_asan_tsan':22,'production_zero_calls':True,'target_ET_REL_sha256':target['sha256'],'actual_acceptance':False}))
if __name__=='__main__':main()
