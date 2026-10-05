#!/usr/bin/env python3
"""Link the exact new OFF module. Do not load/execute any target artifact."""
from pathlib import Path
import hashlib,importlib.util,json,struct,subprocess,sys
from derive_runtime import ROOT,HERE,derive
OUT=ROOT/'analysis/firmware/f1_native_entry_observe_build_08'
ENTRY_SOURCE='48a0a5589a3ac290d58057f2502aa6104a58649090344dfee60e8e89aadb47f6'
NORMAL_SOURCE='7897491961536a2fe0c65995303beb56cb72627b95e54438d742d712c56bbde0'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 assert not(HERE/'SOURCE_SHA256.json').exists(),'Frozen outputs cannot be rewritten'
 OUT.mkdir(parents=True,exist_ok=True);(OUT/'.gitignore').write_text('*.o\n*.so\n')
 commands=[];refs={}
 def run(a):
  a=list(map(str,a));commands.append(a);p=subprocess.run(a,cwd=ROOT,text=True,capture_output=True);assert p.returncode==0,p.stdout+p.stderr;return p.stdout
 for package,wanted in [('f1_native_entry_binding_07',ENTRY_SOURCE),('f1_normal_fit_display_08',NORMAL_SOURCE)]:
  p=HERE.parent/package/'SOURCE_SHA256.json';assert sha(p)==wanted;d=json.loads(p.read_text());refs[str(p.relative_to(ROOT))]=sha(p)
  for group in('members','frozen_refs','review_artifacts'):
   for r in d[group]:p=ROOT/r['path'];assert sha(p)==r['sha256']and p.stat().st_size==r['bytes'];refs[r['path']]=r['sha256']
 run([sys.executable,HERE/'derive_runtime.py']);original,s=derive();assert (HERE/'runtime_linux.cpp').read_text()==s
 assert s.count(')(mutex); // EXACTLY ONCE, first.')==1 and s.count('errno=saved;return result;')==1
 assert s.count('ui08_bridge->after_original_boundary_on_ui(')==1
 assert 'configure_on_actual_ui('not in s and 'bind_actual_provider_before_patch_on_ui('not in s
 assert 'mprotect('not in s and 'mmap('not in s and 'install_capture'not in s
 for preserved in ['const int result=reinterpret_cast<int(*)(void*)>(address)(mutex); // EXACTLY ONCE, first.',
  'module->after_unlock(input);','entry07_bridge->after_original_unlock_on_ui(',
  'errno=incoming;','errno=saved;return result;']:
  assert s.count(preserved)==original.count(preserved)==1
 lock=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text());zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';assert sha(zig)==lock['zig_binary_sha256'];assert run([zig,'version']).strip()==lock['version']
 runtime=OUT/'runtime.o';run([zig,'c++','-target',lock['target'],'-std=c++17','-O2','-fPIC','-fvisibility=hidden','-ffunction-sections','-fdata-sections','-fno-omit-frame-pointer','-fno-optimize-sibling-calls','-mcpu=generic-neon-fp_armv8','-Wall','-Wextra','-Wpedantic','-Werror','-I',ROOT/'src/core/include','-I',ROOT/'src/display/include','-c',HERE/'runtime_linux.cpp','-o',runtime])
 base=ROOT/'analysis/firmware/f1_display_loader_build_06';objects=[p for p in sorted(base.glob('display_*.o'))if p.name!='display_9_runtime_linux.o'];assert len(objects)==9
 objects.append(ROOT/'analysis/firmware/f1_native_entry_binding_build_07/binding.o')
 normal=ROOT/'analysis/firmware/f1_normal_fit_display_build_08'
 for p in objects:assert str(p.relative_to(ROOT))in refs and sha(p)==refs[str(p.relative_to(ROOT))]
 # New compile options separate each function so this observation-only link
 # can drop unused rendering/callbacks. Frozen ET_REL bytes stay unchanged.
 for name in('normal_fit','provider','hook_capture','integration'):
  p=HERE.parent/'f1_normal_fit_display_08'/(name+'.cpp');assert sha(p)==refs[str(p.relative_to(ROOT))]
  obj=OUT/(name+'_function_sections.o');run([zig,'c++','-target',lock['target'],'-std=c++17','-O2','-fPIC','-fvisibility=hidden','-ffunction-sections','-fdata-sections','-fno-omit-frame-pointer','-fno-optimize-sibling-calls','-Wall','-Wextra','-Wpedantic','-Werror','-I',ROOT/'src/core/include','-I',ROOT/'src/display/include','-c',p,'-o',obj]);objects.append(obj)
 p=normal/'scaler_bridge.o';assert sha(p)==refs[str(p.relative_to(ROOT))];objects.append(p)
 from importlib.util import spec_from_file_location,module_from_spec
 def module(name,p):
  sp=spec_from_file_location(name,p);m=module_from_spec(sp);sp.loader.exec_module(m);return m
 elf=module('frozen_elf_reader08',HERE.parent/'f4_ui_bootstrap_02/build_validate.py').elf
 strip=module('frozen_strip_reader08',HERE.parent/'f1_entry_loader_binding_07/strip_elf.py').strip
 outputs={};pubsymbol='iq4_f1_normal_fit_ingress_observed_08'
 for name,extra in [('default_off',[ROOT/'analysis/firmware/f1_display_observe_build_06/role_ctor_default_off.o']),
  ('authenticated_observe_only_candidate',[base/'authenticated_ctor.o',base/'readonly_stat_parser.o'])]:
  for p in extra:assert sha(p)==refs[str(p.relative_to(ROOT))]
  so=OUT/('libiq4_f1_entry_observe_08_'+name+'.so')
  # No text callback has a caller in this OFF observation runtime. Permit
  # garbage collection of that unused prototype/issuer/render body; its exact
  # frozen ET_REL evidence remains separate and is not claimed as loaded code.
  run([zig,'c++','-target',lock['target'],'-nostdlib++','-shared',*objects,runtime,*extra,'-Wl,--gc-sections','-Wl,-Bsymbolic','-Wl,-z,now','-Wl,-z,relro','-o',so])
  raw=so.read_bytes();h,sections,exports,undefined=elf(raw);assert h[1]==3 and h[2]==183
  old_exports=set(json.loads((ROOT/'analysis/firmware/f1_native_entry_binding_build_07/BUILD_VALIDATION.json').read_text())['outputs']['authenticated_entry_only_candidate']['exports'])
  assert set(exports)==old_exports|{pubsymbol}
  denied={'kill','raise','ptrace','system','popen','execve','dlopen','dlsym','ioctl','reboot','pwrite','write','pthread_create','mmap','mprotect'};assert not(set(undefined)&denied)
  sym=sections['.dynsym'];sh=[struct.unpack_from('<IIQQQQIIQQ',raw,h[6]+i*h[11])for i in range(h[12])];st=sh[sym[6]];names=raw[st[4]:st[4]+st[5]];pub=None
  for off in range(sym[4],sym[4]+sym[5],sym[9]):
   n,info,other,index,va,size=struct.unpack_from('<IBBHQQ',raw,off)
   if n and index and names[n:names.index(0,n)].decode()==pubsymbol:pub=(va,size)
  assert pub and pub[1]==496
  loads=[struct.unpack_from('<IIQQQQQQ',raw,h[5]+i*h[9])for i in range(h[10])];cover=[p for p in loads if p[0]==1 and p[1]==6 and p[3]<=pub[0]and pub[0]+pub[1]<=p[3]+p[5]];assert len(cover)==1
  small,proof=strip(raw);load=OUT/('libiq4_f1_entry_observe_08_'+name+'_load_only.so');load.write_bytes(small);(OUT/(name+'_STRIP_PROOF.json')).write_text(json.dumps(proof,indent=2)+'\n')
  outputs[name]={'unstripped_path':str(so.relative_to(ROOT)),'unstripped_sha256':sha(so),'path':str(load.relative_to(ROOT)),'bytes':load.stat().st_size,'sha256':sha(load),'exports':exports,'undefined':undefined,'publication_symbol':pubsymbol,'publication_va':pub[0],'publication_bytes':pub[1],'publication_load':cover[0],'init_array_bytes':sections['.init_array'][5],'target_loaded':False,'UI_installed':False,'mask_enabled':False,'provider_contract_received':False,'text_hook_installed':False}
 dump='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump';nm='/Library/Developer/CommandLineTools/usr/bin/llvm-nm'
 d=run([dump,'-dr',runtime]);(OUT/'RUNTIME_COMPLETE.disasm.txt').write_text(d)
 assert 'after_original_boundary_on_ui'in d and 'sample_boundary_scalars_on_actual_ui'in d
 names=run([nm,'--defined-only',OUT/'libiq4_f1_entry_observe_08_authenticated_observe_only_candidate.so']);(OUT/'DEFINED.txt').write_text(names)
 assert 'sample_boundary_scalars_on_actual_ui'in names and 'install_selection_once_on_ui'in names
 assert 'dispatch_scaler_return_on_ui'not in names and 'after_native_write_on_ui'not in names and 'iq4_f1_scaler_bridge_08'not in names
 (OUT/'DYNAMIC.txt').write_text(run([dump,'-p',OUT/'libiq4_f1_entry_observe_08_authenticated_observe_only_candidate.so']))
 # Reuse the frozen positive provider list, reject any new unresolved name.
 old=json.loads((ROOT/'analysis/firmware/f1_native_entry_binding_build_07/BUILD_VALIDATION.json').read_text());prior=set(old['outputs']['authenticated_entry_only_candidate']['undefined']);new=set(outputs['authenticated_observe_only_candidate']['undefined']);added=new-prior
 sys.path.insert(0,str(HERE.parent));from inspect_boot import Ext2
 available=set();providers=[]
 for node,body in Ext2((ROOT/'analysis/firmware/P1_ramdisk.ext2').read_bytes()).walk():
  if not node['path'].startswith(('/lib/libc-','/lib/libpthread-','/usr/lib/libstdc++.so.6.','/lib/libgcc_s.so'))or body[:7]!=b'\x7fELF\x02\x01\x01':continue
  _,_,exports,_=elf(body);available.update(exports);providers.append({'path':node['path'],'sha256':hashlib.sha256(body).hexdigest(),'new_required_exports':sorted(added&set(exports))})
 assert new<=available,(new-available)
 assert not any(n.startswith('_ZN3iq4')or n.startswith('_ZNK3iq4')for n in new),'Own implementation must resolve in the new SO'
 result={'schema':'iq4_f1_native_entry_observe_source_preparation_v8','runtime_identity':'UI08_default_OFF_entry_and_boundary_candidates_only','entry_source_sha256':ENTRY_SOURCE,'normal_source_sha256':NORMAL_SOURCE,'runtime_actual_boundary_caller_present':True,'original_unlock_once_errno_body_preserved':True,'outputs':outputs,'new_dynamic_imports':sorted(added),'static_import_providers':providers,'runtime_loader_acceptance':False,'publication_layout':json.loads((normal/'PUBLICATION_LAYOUT.json').read_text()),'own_module_linked':True,'unused_production_draw_and_scaler_collected':True,'production_render_module_link_accepted':False,'actual_module_loaded':False,'actual_UI_installed':False,'mask_enabled':False,'full_source_mapping_verified':False,'fresh_stock_blit_verified':False,'surface_lease_verified':False,'native_text_hook_installed':False,'provider_contract_received':False,'old_frozen_modified':False,'device_or_SDK_or_Windows_or_network_used':False,'dependencies':refs,'commands':commands}
 (OUT/'BUILD_PREPARATION.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps({'outputs':outputs,'boundary_actual_source_caller':True},indent=2))
if __name__=='__main__':main()
