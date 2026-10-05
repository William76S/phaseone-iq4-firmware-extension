#!/usr/bin/env python3
"""Only host fixtures and AArch64 link/static inspection; never target execution."""
from pathlib import Path
import difflib,hashlib,importlib.util,json,struct,subprocess,sys
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/f1_normal_fit_display_build_09'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def module(name,p):
 sp=importlib.util.spec_from_file_location(name,p);m=importlib.util.module_from_spec(sp);sp.loader.exec_module(m);return m
def main():
 assert not(HERE/'SOURCE_SHA256.json').exists(),'Frozen source cannot change'
 OUT.mkdir(parents=True,exist_ok=True);(OUT/'.gitignore').write_text('*.o\n*.so\nhost_*\n');refs={};commands=[]
 def run(a):
  a=list(map(str,a));commands.append(a);p=subprocess.run(a,cwd=ROOT,text=True,capture_output=True);assert p.returncode==0,p.stdout+p.stderr;return p.stdout
 for package,wanted in [('f1_normal_fit_display_08','7897491961536a2fe0c65995303beb56cb72627b95e54438d742d712c56bbde0'),('f1_native_entry_observe_08','88000455d0116e075aa6be69476508cc3d1a4b6bb4cefa4365ba034c18652d52')]:
  p=HERE.parent/package/'SOURCE_SHA256.json';assert sha(p)==wanted;refs[str(p.relative_to(ROOT))]=wanted;d=json.loads(p.read_text())
  for g in('members','frozen_refs','review_artifacts'):
   for r in d[g]:p=ROOT/r['path'];assert sha(p)==r['sha256']and p.stat().st_size==r['bytes'];refs[r['path']]=r['sha256']
 diff=[]
 for p in sorted(HERE.iterdir()):
  old=HERE.parent/'f1_normal_fit_display_08'/p.name
  if p.name=='runtime_linux.cpp':old=HERE.parent/'f1_native_entry_observe_08/runtime_linux.cpp'
  if p.is_file()and old.is_file()and p.suffix in('.hpp','.cpp','.S'):
   diff.extend(difflib.unified_diff(old.read_text().splitlines(True),p.read_text().splitlines(True),fromfile='frozen08/'+p.name,tofile='new09/'+p.name))
 (HERE/'SOURCE_DIFF.txt').write_text(''.join(diff))
 sdk=run(['xcrun','--show-sdk-path']).strip();inc=['-I',ROOT/'src/core/include','-I',ROOT/'src/display/include']
 production=[HERE/(n+'.cpp')for n in('normal_fit','fixed_plan','provider')]
 frozen=[HERE.parent/'f1_native_entry_binding_07/binding.cpp',HERE.parent/'f1_native_ui_02/ui.cpp',HERE.parent/'f1_native_ui_02/candidates.cpp',HERE.parent/'f1_module_entry_01/module.cpp',HERE.parent/'f4_ui_bootstrap_02/bootstrap.cpp',HERE.parent/'f4_ui_counter_01/counter.cpp',HERE.parent/'f1_native_overlay_01/overlay.cpp',ROOT/'src/core/lib/image_core.cpp',ROOT/'src/display/lib/display_mask.cpp']
 tests={}
 for name,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=OUT/('host_'+name);run(['/usr/bin/clang++','-std=c++17','-O2','-Wall','-Wextra','-Wpedantic','-Werror','-DIQ4_F1_NORMAL09_OWNED_HOST_FIXTURE','-isystem',sdk+'/usr/include/c++/v1',*flags,*inc,*production,HERE/'test_normal.cpp',*frozen,'-o',exe]);receipt=run([exe]);assert receipt=='11 owned normal-fit/production-ingress/OFF/zoom/owner fault groups PASS; target execution zero\n';tests[name]={'groups':11,'receipt':receipt.strip()}
  geometry=OUT/('host_geometry_'+name);run(['/usr/bin/clang++','-std=c++17','-O2','-Wall','-Wextra','-Wpedantic','-Werror','-isystem',sdk+'/usr/include/c++/v1',*flags,*inc,*production,HERE/'test_geometry.cpp',*frozen,'-o',geometry]);receipt=run([geometry]);assert receipt=='270 owned fixed-array plans match frozen vector geometry; no target execution\n';tests['geometry_'+name]={'cases':270,'receipt':receipt.strip()}
 lock=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text());zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';assert sha(zig)==lock['zig_binary_sha256'];assert run([zig,'version']).strip()==lock['version']
 cc=[zig,'c++','-target',lock['target'],'-std=c++17','-O2','-fPIC','-fvisibility=hidden','-ffunction-sections','-fdata-sections','-fno-omit-frame-pointer','-fno-optimize-sibling-calls','-Wall','-Wextra','-Wpedantic','-Werror',*inc]
 objects=[]
 for name in('normal_fit','fixed_plan','provider','hook_capture','integration','runtime_linux'):
  p=OUT/(name+'.o');flags=['-mcpu=generic-neon-fp_armv8']if name=='runtime_linux'else[];run([*cc,*flags,'-c',HERE/(name+'.cpp'),'-o',p]);objects.append(p)
 asm=OUT/'scaler_bridge.o';run([zig,'cc','-target',lock['target'],'-fPIC','-c',HERE/'scaler_bridge.S','-o',asm]);objects.append(asm)
 base=ROOT/'analysis/firmware/f1_display_loader_build_06';oldobjects=[p for p in sorted(base.glob('display_*.o'))if p.name!='display_9_runtime_linux.o'];assert len(oldobjects)==9
 oldobjects.append(ROOT/'analysis/firmware/f1_native_entry_binding_build_07/binding.o')
 for p in oldobjects:assert sha(p)==refs[str(p.relative_to(ROOT))]
 elf=module('frozenELF09',HERE.parent/'f4_ui_bootstrap_02/build_validate.py').elf;strip=module('frozenStrip09',HERE.parent/'f1_entry_loader_binding_07/strip_elf.py').strip
 outputs={};symbol='iq4_f1_normal_fit_ingress_observed_09';dump='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump';nm='/Library/Developer/CommandLineTools/usr/bin/llvm-nm'
 for name,extra in [('default_off',[ROOT/'analysis/firmware/f1_display_observe_build_06/role_ctor_default_off.o']),('authenticated_candidate',[base/'authenticated_ctor.o',base/'readonly_stat_parser.o'])]:
  for p in extra:assert sha(p)==refs[str(p.relative_to(ROOT))]
  configure_port='_Z45iq4_f1_ui09_bind_actual_provider_before_patchRN3iq42f18normal0910UI09BridgeENS0_14native_overlay6MemoryERNS0_7entry016ModuleERKNS1_22ActualProviderContractE'
  so=OUT/('libiq4_f1_normal_fit_display_09_'+name+'.so');run([zig,'c++','-target',lock['target'],'-nostdlib++','-shared',*oldobjects,*objects,*extra,'-Wl,--gc-sections','-Wl,-u,iq4_f1_scaler_bridge_09','-Wl,-u,'+configure_port,'-Wl,-Bsymbolic','-Wl,-z,now','-Wl,-z,relro','-o',so]);raw=so.read_bytes();h,sections,exports,undefined=elf(raw);assert h[1]==3 and h[2]==183
  oldexp=set(json.loads((ROOT/'analysis/firmware/f1_native_entry_binding_build_07/BUILD_VALIDATION.json').read_text())['outputs']['authenticated_entry_only_candidate']['exports']);assert set(exports)==oldexp|{symbol}
  assert not any('bad_array'in n or n.startswith('_ZN3iq4')or n.startswith('_ZNK3iq4')for n in undefined)
  assert not(set(undefined)&{'kill','raise','ptrace','system','popen','execve','dlopen','dlsym','ioctl','reboot','pwrite','write','pthread_create','mmap','mprotect','lround'})
  sym=sections['.dynsym'];sh=[struct.unpack_from('<IIQQQQIIQQ',raw,h[6]+i*h[11])for i in range(h[12])];st=sh[sym[6]];strings=raw[st[4]:st[4]+st[5]];pub=None
  for off in range(sym[4],sym[4]+sym[5],sym[9]):
   n,info,other,index,va,size=struct.unpack_from('<IBBHQQ',raw,off)
   if n and index and strings[n:strings.index(0,n)].decode()==symbol:pub=va,size
  assert pub and pub[1]==496
  ph=[struct.unpack_from('<IIQQQQQQ',raw,h[5]+i*h[9])for i in range(h[10])];cover=[p for p in ph if p[0]==1 and p[1]==6 and p[3]<=pub[0]and pub[0]+496<=p[3]+p[5]];assert len(cover)==1
  small,proof=strip(raw);load=OUT/('libiq4_f1_normal_fit_display_09_'+name+'_load_only.so');load.write_bytes(small);(OUT/(name+'_STRIP_PROOF.json')).write_text(json.dumps(proof,indent=2)+'\n')
  outputs[name]={'path':str(load.relative_to(ROOT)),'bytes':load.stat().st_size,'sha256':sha(load),'unstripped_path':str(so.relative_to(ROOT)),'unstripped_sha256':sha(so),'exports':exports,'undefined':undefined,'publication_symbol':symbol,'publication_va':pub[0],'publication_bytes':496,'publication_load':cover[0],'init_array_bytes':sections['.init_array'][5],'target_loaded':False,'mask_enabled':False}
 names=run([nm,'--defined-only',OUT/'libiq4_f1_normal_fit_display_09_authenticated_candidate.so']);(OUT/'DEFINED.txt').write_text(names)
 for n in('fixed_normal_plan','dispatch_scaler_return_on_ui','after_native_write_on_ui','iq4_f1_scaler_bridge_09','sample_boundary_scalars_on_actual_ui','configure_on_actual_ui','iq4_f1_ui09_bind_actual_provider_before_patch'):assert n in names
 for obj in objects:(OUT/(obj.stem+'_COMPLETE.disasm.txt')).write_text(run([dump,'-dr',obj]))
 fixed=(OUT/'fixed_plan_COMPLETE.disasm.txt').read_text();assert 'frintp'in fixed and 'lround'not in fixed and 'bad_array'not in fixed
 (OUT/'DYNAMIC.txt').write_text(run([dump,'-p',OUT/'libiq4_f1_normal_fit_display_09_authenticated_candidate.so']))
 sys.path.insert(0,str(HERE.parent));from inspect_boot import Ext2
 available=set();providers=[];required=set(outputs['authenticated_candidate']['undefined'])
 for node,body in Ext2((ROOT/'analysis/firmware/P1_ramdisk.ext2').read_bytes()).walk():
  if not node['path'].startswith(('/lib/libc-','/lib/libpthread-','/usr/lib/libstdc++.so.6.','/lib/libgcc_s.so','/lib/libm-'))or body[:7]!=b'\x7fELF\x02\x01\x01':continue
  _,_,e,_=elf(body);available.update(e);providers.append({'path':node['path'],'sha256':hashlib.sha256(body).hexdigest(),'required_exports':sorted(required&set(e))})
 assert required<=available,(required-available)
 prior=set(json.loads((ROOT/'analysis/firmware/f1_native_entry_observe_build_08/BUILD_PREPARATION.json').read_text())['outputs']['authenticated_observe_only_candidate']['undefined'])
 result={'schema':'iq4_f1_normal_fit_display_source_preparation_v9','tests':tests,'production_render_body_in_actual_SO':True,'native_RGB24_return_issuer_in_actual_SO':True,'runtime_UI_boundary_caller_present':True,'new_dynamic_imports':sorted(required-prior),'fixed_plan_uses_vectors_or_heap':False,'fixed_alpha':166,'zero_rotation_only':True,'ceil_lowered_to_AArch64_FRINTP':True,'lround_imported':False,'original_static_import_providers':providers,'runtime_loader_acceptance':False,'outputs':outputs,'target_loaded':False,'UI_installed':False,'mask_enabled':False,'actual_provider_contract_received':False,'native_text_hook_installed':False,'actual_full_source_verified':False,'actual_fresh_stock_write_verified':False,'actual_surface_lease_verified':False,'old_frozen_modified':False,'device_or_SDK_or_Windows_or_network_used':False,'dependencies':refs,'commands':commands}
 (OUT/'BUILD_PREPARATION.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps({'tests':tests,'outputs':outputs,'new_dynamic_imports':result['new_dynamic_imports']},indent=2))
if __name__=='__main__':main()
