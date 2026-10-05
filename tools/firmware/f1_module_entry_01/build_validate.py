#!/usr/bin/env python3
"""Own host guard tests and actual target SO link/inspect; never load target."""
from pathlib import Path
import difflib,hashlib,json,subprocess,sys
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2];OUT=ROOT/'analysis/sdk_reference/f1_module_entry_build_01'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    OUT.mkdir(parents=True,exist_ok=True);(OUT/'.gitignore').write_text('*.o\n*.so\nhost_*\n');commands=[]
    (HERE/'runtime_derived.diff.txt').write_text(''.join(difflib.unified_diff(
      (HERE.parent/'f4_ui_bootstrap_02/runtime_linux.cpp').read_text().splitlines(True),
      (HERE/'runtime_linux.cpp').read_text().splitlines(True),fromfile='frozen/f4_ui_bootstrap_02/runtime_linux.cpp',tofile='new/f1_module_entry_01/runtime_linux.cpp')))
    def run(args):
        args=list(map(str,args));commands.append(args);p=subprocess.run(args,cwd=ROOT,text=True,capture_output=True)
        if p.returncode:raise SystemExit(p.stdout+p.stderr)
        return p.stdout
    sdk=run(['xcrun','--show-sdk-path']).strip()
    sources=[HERE/'module.cpp',HERE.parent/'f1_native_ui_02/ui.cpp',HERE.parent/'f1_native_ui_02/candidates.cpp',HERE.parent/'f4_ui_bootstrap_02/bootstrap.cpp',HERE.parent/'f4_ui_counter_01/counter.cpp']
    common=['/usr/bin/clang++','-std=c++17','-O2','-Wall','-Wextra','-Wpedantic','-Werror','-ffunction-sections','-fdata-sections','-isystem',sdk+'/usr/include/c++/v1','-I',ROOT/'src/core/include','-I',ROOT/'src/display/include']
    # Frozen UI functions use overlay methods. Own host link includes those
    # unchanged objects; production test calls only disabled metadata ports.
    host=sources+[HERE/'test_module.cpp',HERE.parent/'f1_native_overlay_01/overlay.cpp',ROOT/'src/core/lib/image_core.cpp',ROOT/'src/display/lib/display_mask.cpp']
    tests={}
    for name,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
        exe=OUT/('host_'+name);run(common+flags+host+['-o',exe]);receipt=run([exe]);assert receipt=='13 own module gate/stack/forward-port groups PASS; zero vendor/target execution\n';(OUT/(name+'.txt')).write_text(receipt);tests[name]={'groups':13,'sha256':sha(exe),'receipt':receipt.strip()}
    zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';lock=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text());assert sha(zig)==lock['zig_binary_sha256'] and run([zig,'version']).strip()==lock['version']
    target=[]
    for i,src in enumerate(sources+[HERE/'runtime_linux.cpp']):
        obj=OUT/(str(i)+'_'+src.stem+'.aarch64.o');run([zig,'c++','-target',lock['target'],'-std=c++17','-O2','-fPIC','-fno-omit-frame-pointer','-fvisibility=hidden','-ffunction-sections','-fdata-sections','-Wall','-Wextra','-Wpedantic','-Werror','-I',ROOT/'src/core/include','-I',ROOT/'src/display/include','-c',src,'-o',obj]);target.append(obj)
    so=OUT/'libiq4_f1_entry_observe_01.so'
    run([zig,'c++','-target',lock['target'],'-nostdlib++','-shared',*target,'-Wl,--gc-sections','-Wl,-z,now','-Wl,-z,relro','-o',so])
    sys.path.insert(0,str(HERE.parent/'f4_ui_bootstrap_02'));from build_validate import elf
    h,sections,exports,undefined=elf(so.read_bytes());assert h[1]==3
    assert set(exports)=={'pthread_mutex_unlock','iq4_f1_entry_read_metadata','iq4_f1_entry_concrete_ports','iq4_f1_entry_button_ports','iq4_f1_entry_observed'}
    # No unresolved private User method or incompatible libc++ container call.
    assert not any(n.startswith('_ZNSt3__1') for n in undefined),undefined
    denied={'kill','raise','ptrace','system','popen','execve','dlopen','dlsym','ioctl','reboot','pwrite','write','pthread_create'};assert not set(undefined)&denied
    assert sections['.init_array'][5]==8
    dynamic=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-p',so]);(OUT/'TARGET_DYNAMIC.txt').write_text(dynamic);assert 'libc++.so'not in dynamic and 'libstdc++.so'not in dynamic
    wrapper=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d','--disassemble-symbols=pthread_mutex_unlock',so]);(OUT/'TARGET_UNLOCK.disasm.txt').write_text(wrapper)
    assert '<pthread_mutex_unlock>:' in wrapper and 'blr' in wrapper
    # Package symbol availability is a static witness, not runtime ld.so proof.
    sys.path.insert(0,str(HERE.parent));from inspect_boot import Ext2
    disk_path=ROOT/'analysis/firmware/P1_ramdisk.ext2';assert sha(disk_path)=='2ca2a497fb22cb3b16009f5dab2aad1f744982aaafb6c928ac688c0a3f9dbccb'
    providers=[];available=set()
    for n,b in Ext2(disk_path.read_bytes()).walk():
        if n['path'].startswith(('/lib/libc-','/lib/libpthread-','/usr/lib/libstdc++.so.6.')) and b[:7]==b'\x7fELF\x02\x01\x01':
            _,_,names,_=elf(b);available.update(names);providers.append({'path':n['path'],'bytes':len(b),'sha256':hashlib.sha256(b).hexdigest(),'matched_required_exports':sorted(set(undefined)&set(names))})
    assert set(undefined)<=available,(set(undefined)-available)
    symbol_witness={'runtime_resolution_proven':False,'rootfs_sha256':sha(disk_path),'providers':providers,'all_13_undefined_symbols_present':len(undefined)==13 and set(undefined)<=available}
    (OUT/'PACKAGE_SYMBOLS.json').write_text(json.dumps(symbol_witness,indent=2)+'\n')
    report={'schema':'f1_module_entry_target_link_01','camera_access':False,'sdk_started':False,'vendor_code_executed':False,'target_SO_loaded':False,
      'target_stage':'observe_only','production_mask_enabled':False,'native_subscriptions':False,'native_vptr_writes':False,'tests':tests,
      'target_SO':{'bytes':so.stat().st_size,'sha256':sha(so),'exports':exports,'undefined_symbols':undefined,'init_array_bytes':8,'runtime_abi_validated':False,'original_global_GNU_CPP_runtime_required':True},
      'static_symbol_witness':symbol_witness,
      'commands':commands,'sources':{str(p.relative_to(ROOT)):sha(p) for p in sources+[HERE/'module.hpp',HERE/'runtime_linux.cpp',HERE/'runtime_derived.diff.txt',HERE/'test_module.cpp',Path(__file__).resolve()]}}
    (OUT/'BUILD_VALIDATION.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report['target_SO'],indent=2))
if __name__=='__main__':main()
