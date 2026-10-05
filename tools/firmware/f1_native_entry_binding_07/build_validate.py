#!/usr/bin/env python3
"""Own native-port fixtures + AArch64 compile/link/inspect. No target loading."""
from pathlib import Path
import hashlib,json,struct,subprocess,sys
from derive_runtime import ROOT,HERE
OUT=ROOT/'analysis/firmware/f1_native_entry_binding_build_07'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 assert not(HERE/'SOURCE_SHA256.json').exists(),'Frozen outputs cannot be rewritten'
 OUT.mkdir(parents=True,exist_ok=True);(OUT/'.gitignore').write_text('*.o\n*.so\nhost_*\n');commands=[];refs={}
 def run(args):
  a=list(map(str,args));commands.append(a);p=subprocess.run(a,cwd=ROOT,text=True,capture_output=True);assert p.returncode==0,p.stdout+p.stderr;return p.stdout
 for package in('f1_display_observe_06','f1_display_loader_binding_06','f1_module_entry_01','f1_entry_button_ports_01'):
  p=HERE.parent/package/'SOURCE_SHA256.json';d=json.loads(p.read_text());refs[str(p.relative_to(ROOT))]=sha(p)
  for group in('members','frozen_refs','review_artifacts','target_review_artifacts'):
   for r in d.get(group,[]):p=ROOT/r['path'];assert sha(p)==r['sha256']and p.stat().st_size==r['bytes'];refs[r['path']]=r['sha256']
 run([sys.executable,HERE/'derive_runtime.py'])
 sdk=run(['xcrun','--show-sdk-path']).strip();inc=['-I',ROOT/'src/core/include','-I',ROOT/'src/display/include']
 host=[HERE/'binding.cpp',HERE/'test_binding.cpp',HERE.parent/'f1_native_ui_02/ui.cpp',HERE.parent/'f1_native_ui_02/candidates.cpp',HERE.parent/'f1_module_entry_01/module.cpp',HERE.parent/'f4_ui_bootstrap_02/bootstrap.cpp',HERE.parent/'f4_ui_counter_01/counter.cpp',HERE.parent/'f1_native_overlay_01/overlay.cpp',ROOT/'src/core/lib/image_core.cpp',ROOT/'src/display/lib/display_mask.cpp']
 tests={}
 for name,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=OUT/('host_'+name);run(['/usr/bin/clang++','-std=c++17','-O2','-Wall','-Wextra','-Wpedantic','-Werror','-DIQ4_F1_ENTRY07_OWNED_HOST_FIXTURE','-ffunction-sections','-fdata-sections','-isystem',sdk+'/usr/include/c++/v1',*flags,*inc,*host,'-o',exe]);receipt=run([exe]);assert receipt=='10 owned entry07 native-port/queue/restore fault groups PASS; vendor/target execution zero\n';tests[name]={'groups':10,'receipt':receipt.strip()}
 decoder=json.loads(run([sys.executable,HERE/'test_decode.py']));assert decoder['passed']and decoder['checks']==15
 tool=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text());zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';assert sha(zig)==tool['zig_binary_sha256']and run([zig,'version']).strip()==tool['version']
 cc=[zig,'c++','-target',tool['target'],'-std=c++17','-O2','-fPIC','-fvisibility=hidden','-ffunction-sections','-fdata-sections','-Wall','-Wextra','-Wpedantic','-Werror',*inc]
 binding=OUT/'binding.o';runtime=OUT/'runtime.o';run([*cc,'-c',HERE/'binding.cpp','-o',binding]);run([*cc,'-fno-omit-frame-pointer','-fno-optimize-sibling-calls','-mcpu=generic-neon-fp_armv8','-c',HERE/'runtime_linux.cpp','-o',runtime])
 base=ROOT/'analysis/firmware/f1_display_loader_build_06';objs=[]
 for p in sorted(base.glob('display_*.o')):
  if p.name=='display_9_runtime_linux.o':continue
  assert str(p.relative_to(ROOT))in refs and sha(p)==refs[str(p.relative_to(ROOT))];objs.append(p)
 assert len(objs)==9
 default_ctor=ROOT/'analysis/firmware/f1_display_observe_build_06/role_ctor_default_off.o';assert sha(default_ctor)==refs[str(default_ctor.relative_to(ROOT))]
 auth_ctor=base/'authenticated_ctor.o';parser=base/'readonly_stat_parser.o';assert all(sha(p)==refs[str(p.relative_to(ROOT))]for p in(auth_ctor,parser))
 sys.path.insert(0,str(HERE.parent/'f4_ui_bootstrap_02'));from build_validate import elf
 sys.path.insert(0,str(HERE.parent/'f1_display_loader_binding_06'));from strip_elf import strip
 outputs={}
 for name,extra in [('default_off',[default_ctor]),('authenticated_entry_only_candidate',[auth_ctor,parser])]:
  so=OUT/('libiq4_f1_entry_binding_07_'+name+'.so');run([zig,'c++','-target',tool['target'],'-nostdlib++','-shared',*objs,binding,runtime,*extra,'-Wl,--gc-sections','-Wl,-Bsymbolic','-Wl,-z,now','-Wl,-z,relro','-o',so]);raw=so.read_bytes();h,sections,exports,undefined=elf(raw);assert h[1]==3 and h[2]==183
  assert set(exports)=={'pthread_mutex_unlock','iq4_f1_entry_observed','iq4_f1_geometry_observed_04','iq4_f1_stack_observed_05','iq4_f1_role_ctor_status','iq4_f1_display_observed_06','iq4_f1_display_paint_callback_06','iq4_f1_entry_binding_observed_07'}
  denied={'kill','raise','ptrace','system','popen','execve','dlopen','dlsym','ioctl','reboot','pwrite','write','pthread_create'};assert not set(undefined)&denied
  stripped,proof=strip(raw);load=OUT/('libiq4_f1_entry_binding_07_'+name+'_load_only.so');load.write_bytes(stripped);(OUT/(name+'_STRIP_PROOF.json')).write_text(json.dumps(proof,indent=2)+'\n')
  outputs[name]={'unstripped_path':str(so.relative_to(ROOT)),'unstripped_sha256':sha(so),'path':str(load.relative_to(ROOT)),'bytes':load.stat().st_size,'sha256':sha(load),'exports':exports,'undefined':undefined,'init_array_bytes':sections['.init_array'][5],'target_loaded':False,'ui_installed':False,'mask_enabled':False}
 dump='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump';nm='/Library/Developer/CommandLineTools/usr/bin/llvm-nm'
 d=run([dump,'-dr',binding]);(OUT/'BINDING_COMPLETE.disasm.txt').write_text(d);assert 'control_notification'in d and 'queue_notification'in d and 'build_on_ui'in d and 'detach_on_ui'in d
 names=run([nm,'--defined-only',OUT/'libiq4_f1_entry_binding_07_authenticated_entry_only_candidate.so']);(OUT/'DEFINED.txt').write_text(names)
 assert 'control_notification'in names and 'queue_notification'in names and 'Binding11build_on_ui'in names and 'native_triple'in names
 dynamic=run([dump,'-p',OUT/'libiq4_f1_entry_binding_07_authenticated_entry_only_candidate.so']);(OUT/'DYNAMIC.txt').write_text(dynamic)
 previous=json.loads((base/'BUILD_PREPARATION.json').read_text());added=set(outputs['authenticated_entry_only_candidate']['undefined'])-set(previous['authenticated_candidate']['undefined'])
 # Exact positive static provider existence, never actual resolution.
 sys.path.insert(0,str(HERE.parent));from inspect_boot import Ext2
 disk=ROOT/'analysis/firmware/P1_ramdisk.ext2';available=set();providers=[]
 for node,b in Ext2(disk.read_bytes()).walk():
  if not node['path'].startswith(('/lib/libc-','/lib/libpthread-','/usr/lib/libstdc++.so.6.','/lib/libgcc_s.so'))or b[:7]!=b'\x7fELF\x02\x01\x01':continue
  _,_,e,_=elf(b);available.update(e);providers.append({'path':node['path'],'sha256':hashlib.sha256(b).hexdigest(),'added_symbols':sorted(added&set(e))})
 assert set(outputs['authenticated_entry_only_candidate']['undefined'])<=available
 result={'schema':'iq4_f1_native_entry_binding_source_preparation_v7','tests':tests,'decoder':decoder,'outputs':outputs,'added_undefined_symbols':sorted(added),'static_providers':providers,'runtime_loader_acceptance':False,'dependencies':refs,'actual_UI_or_module_installed':False,'full_source_mapping_verified':False,'fresh_stock_blit_verified':False,'surface_lease_verified':False,'default_selection_port':None,'stock_toolbar_1_8_changed':False,'embedded_stock_popup_changed':False,'device_or_SDK_or_Windows_or_network_used':False,'commands':commands};(OUT/'BUILD_VALIDATION.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps({'tests':tests,'outputs':outputs,'added_undefined_symbols':sorted(added)},indent=2))
if __name__=='__main__':main()
