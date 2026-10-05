#!/usr/bin/env python3
"""Host-owned new fixtures + pinned target compile/link/static inspection only."""
from pathlib import Path
import difflib,hashlib,importlib.util,json,struct,subprocess,sys
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/f1_scaler_hook_install_build_11'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def load(name,p):
 s=importlib.util.spec_from_file_location(name,p);m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
def main():
 assert not(HERE/'SOURCE_SHA256.json').exists()
 OUT.mkdir(parents=True,exist_ok=True);commands=[];refs={}
 def run(a):
  a=list(map(str,a));commands.append(a);p=subprocess.run(a,cwd=ROOT,text=True,capture_output=True);assert p.returncode==0,p.stdout+p.stderr;return p.stdout
 source=HERE.parent/'f1_scaler_hook_install_10/SOURCE_SHA256.json';assert sha(source)=='5793c044638b7f88a8fabae547b2b56b5c6ce17ac02c1ff23551a9048ed68b1e';refs[str(source.relative_to(ROOT))]=sha(source)
 for group in('members','frozen_refs','review_artifacts'):
  for r in json.loads(source.read_text())[group]:
   p=ROOT/r['path'];assert p.stat().st_size==r['bytes']and sha(p)==r['sha256'];refs[r['path']]=r['sha256']
 lock=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text());zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';assert sha(zig)==lock['zig_binary_sha256'];assert run([zig,'version']).strip()==lock['version']
 inc=['-I',ROOT/'src/core/include','-I',ROOT/'src/display/include'];cc=[zig,'c++','-target',lock['target'],'-std=c++17','-O2','-fPIC','-fvisibility=hidden','-ffunction-sections','-fdata-sections','-fno-omit-frame-pointer','-fno-optimize-sibling-calls','-Wall','-Wextra','-Wpedantic','-Werror',*inc]
 objects=[]
 for name in('normal_fit','fixed_plan','provider','hook_capture','integration','entry_binding_10','prepare_linux','runtime_prepare_10'):
  p=OUT/(name+'.o');run([*cc,*(['-mcpu=generic-neon-fp_armv8']if name=='runtime_prepare_10'else[]),'-c',HERE/(name+'.cpp'),'-o',p]);objects.append(p)
 asm=OUT/'scaler_bridge.o';run([zig,'cc','-target',lock['target'],'-fPIC','-c',HERE/'scaler_bridge.S','-o',asm]);objects.append(asm)
 base=ROOT/'analysis/firmware/f1_display_loader_build_06';old=[p for p in sorted(base.glob('display_*.o'))if p.name!='display_9_runtime_linux.o'];assert len(old)==9
 extra=[base/'authenticated_ctor.o',base/'readonly_stat_parser.o']
 for p in old+extra:assert sha(p)==refs[str(p.relative_to(ROOT))]
 full=OUT/'libiq4_f1_normal_fit_hook_11_authenticated_candidate.so'
 run([zig,'c++','-target',lock['target'],'-nostdlib++','-shared',*old,*objects,*extra,'-Wl,--gc-sections','-Wl,-u,iq4_f1_scaler_bridge_10','-Wl,-Bsymbolic','-Wl,-z,now','-Wl,-z,relro','-o',full])
 raw=full.read_bytes();elf=load('ELF10',HERE.parent/'f4_ui_bootstrap_02/build_validate.py').elf;h,sections,exports,undefined=elf(raw);assert h[1]==3 and h[2]==183
 assert not any(n.startswith(('_ZN3iq4','_ZNK3iq4'))or'bad_array'in n or'lround'in n for n in undefined)
 assert not(set(undefined)&{'ptrace','kill','raise','system','popen','execve','dlopen','dlsym','ioctl','reboot','pthread_create','pwrite','write'})
 sh=[struct.unpack_from('<IIQQQQIIQQ',raw,h[6]+i*h[11])for i in range(h[12])];sy=sections['.dynsym'];st=sh[sy[6]];strings=raw[st[4]:st[4]+st[5]];publications={}
 for off in range(sy[4],sy[4]+sy[5],sy[9]):
  n,info,other,index,va,size=struct.unpack_from('<IBBHQQ',raw,off)
  if n and index:publications[strings[n:strings.index(0,n)].decode()]=(va,size)
 normal=publications['iq4_f1_normal_fit_ingress_observed_10'];prepared=publications['iq4_f1_hook_preparation_observed_10'];entry=publications['iq4_f1_entry_binding_observed_10'];assert normal[1]==496 and prepared[1]==192 and entry[1]==104
 nm='/Library/Developer/CommandLineTools/usr/bin/llvm-nm';dump='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump';names=run([nm,'--defined-only',full]);(OUT/'DEFINED.txt').write_text(names)
 symbols={line.split()[-1]:int(line.split()[0],16)for line in names.splitlines()if len(line.split())==3}
 sizes={line.split()[-1]:(int(line.split()[0],16),int(line.split()[1],16))for line in run([nm,'--print-size',full]).splitlines()if len(line.split())==4}
 for wanted in('prepare_once_at_live_ui','bind_actual_provider_before_patch_on_ui','configure_on_actual_ui','after_native_write_on_ui','dispatch_scaler_return_on_ui','fixed_normal_plan','native_current'):assert wanted in names
 bridge=symbols['iq4_f1_scaler_bridge_10'];slot=symbols['iq4_f1_scaler_trampoline_10']
 strip=load('strip10',HERE.parent/'f1_entry_loader_binding_07/strip_elf.py').strip;small,proof=strip(raw);compact=OUT/'libiq4_f1_normal_fit_hook_11_authenticated_candidate_load_only.so';compact.write_bytes(small);(OUT/'STRIP_PROOF.json').write_text(json.dumps(proof,indent=2)+'\n')
 (HERE/'module_identity.hpp').write_text('#pragma once\n// New11 artifact; public/schema10 ABI unchanged. Not runtime acceptance.\nnamespace iq4::f1::hook10 {\n'+f'inline constexpr unsigned long long module_bytes={len(small)};\ninline constexpr char module_sha256[]="{sha(compact)}";\ninline constexpr unsigned long long module_bridge_offset={bridge};\ninline constexpr unsigned long long module_trampoline_offset={slot};\ninline constexpr unsigned long long module_preparation_offset={prepared[0]};\n'+'}\n')
 ph=[struct.unpack_from('<IIQQQQQQ',raw,h[5]+i*h[9])for i in range(h[10])]
 pub_loads={}
 for name,(va,size)in [('normal',normal),('preparation',prepared),('entry',entry)]:
  p=[p for p in ph if p[0]==1 and p[1]==6 and p[3]<=va and va+size<=p[3]+p[5]];assert len(p)==1;pub_loads[name]=p[0]
 for p in objects:(OUT/(p.stem+'_COMPLETE.disasm.txt')).write_text(run([dump,'-dr',p]))
 cache_va,cache_size=sizes['__clear_cache'];assert 0<cache_size<1024
 (OUT/'OWN_CLEAR_CACHE_COMPLETE.txt').write_text(run([dump,'-d',f'--start-address={cache_va:#x}',f'--stop-address={cache_va+cache_size:#x}',full]))
 refs['build/toolchains/zig-aarch64-macos-0.15.2/lib/compiler_rt/clear_cache.zig']=sha(ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/lib/compiler_rt/clear_cache.zig')
 prep=(OUT/'prepare_linux_COMPLETE.disasm.txt').read_text();assert 'dsb\tish'in prep and 'isb'in prep
 (OUT/'DYNAMIC.txt').write_text(run([dump,'-p',full]))
 # No frozen suites/transaction faults are repeated. Only captured-phase and cap regressions run.
 sdk=run(['xcrun','--show-sdk-path']).strip();hc=['/usr/bin/clang++','-std=c++17','-O2','-Wall','-Wextra','-Wpedantic','-Werror','-isystem',sdk+'/usr/include/c++/v1',*inc]
 frozen=[HERE.parent/'f1_native_ui_02/ui.cpp',HERE.parent/'f1_native_ui_02/candidates.cpp',HERE.parent/'f1_module_entry_01/module.cpp',HERE.parent/'f4_ui_bootstrap_02/bootstrap.cpp',HERE.parent/'f4_ui_counter_01/counter.cpp',HERE.parent/'f1_native_overlay_01/overlay.cpp',ROOT/'src/core/lib/image_core.cpp',ROOT/'src/display/lib/display_mask.cpp']
 tests={}
 for kind,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  target=OUT/('host_persistent_'+kind);run([*hc,*flags,'-DIQ4_F1_ENTRY10_OWNED_HOST_FIXTURE','-DIQ4_F1_NORMAL10_OWNED_HOST_FIXTURE',HERE/'normal_fit.cpp',HERE/'fixed_plan.cpp',HERE/'provider.cpp',HERE/'entry_binding_10.cpp',HERE/'test_persistent.cpp',*frozen,'-o',target]);receipt=run([target]);assert receipt.startswith('3 owned ');tests['persistent_'+kind]={'groups':3,'receipt':receipt.strip()}
 layout=OUT/'host_layout';run([*hc,'-DIQ4_F1_HOOK10_LAYOUT_HOST',HERE/'layout.cpp','-o',layout]);layout_values=json.loads(run([layout]));target=OUT/'layout.o';run([*cc,'-c',HERE/'layout.cpp','-o',target]);data=target.read_bytes();lh=struct.unpack_from('<16sHHIQQQIHHHHHH',data);ls=[struct.unpack_from('<IIQQQQIIQQ',data,lh[6]+i*lh[11])for i in range(lh[12])];ln=ls[lh[13]];strings=data[ln[4]:ln[4]+ln[5]];ss={strings[s[0]:strings.index(0,s[0])].decode():s for s in ls};sec=ss['.rodata.f1_hook10_layout'];values=list(struct.unpack_from('<'+'Q'*(sec[5]//8),data,sec[4]));assert values==layout_values;(OUT/'LAYOUT.json').write_text(json.dumps({'fields':['InputBytes','InputProviderOffset','ProviderContractBytes','ProviderOwnerOffset','ProviderPointerOffset','ProviderInlineOffset','PublicationBytes','MetadataBytes','MetadataPIDTicks','MetadataRendererStatus','MetadataInputSHA','RendererStatusBytes','ControllerContractBytes','ControllerPreparedPublicationOffset','JournalBytes','RegistersBytes','RegistersPCOffset'],'actual_AArch64_values':values,'host_values':layout_values},indent=2)+'\n')
 # Compile two source-pinned backend objects for Loader11; no extra controller ELF and no execution.
 controller_objects=[]
 for name in('transaction','linux_controller'):
  obj=OUT/(name+'_controller.o');run([*cc,'-fno-exceptions','-fno-rtti','-DIQ4_F1_HOOK10_NO_MAIN','-c',HERE/(name+'.cpp'),'-o',obj]);controller_objects.append(obj)
 # Same imports: reuse exact parent import-provider evidence, no library extraction rerun.
 parent_build=json.loads((ROOT/'analysis/firmware/f1_scaler_hook_install_build_10/BUILD_PREPARATION.json').read_text())
 assert sorted(exports)==sorted(parent_build['module']['exports'])and sorted(undefined)==sorted(parent_build['module']['undefined'])
 providers=parent_build['original_import_providers']
 oldimports=set(parent_build['module']['undefined'])
 diff=[]
 for name in('entry_binding_10.cpp','test_persistent.cpp','module_identity.hpp'):
  old=HERE.parent/'f1_scaler_hook_install_10'/name;p=HERE/name;diff.extend(difflib.unified_diff(old.read_text().splitlines(True),p.read_text().splitlines(True),fromfile=str(old.relative_to(ROOT)),tofile=str(p.relative_to(ROOT))))
 (HERE/'SOURCE_DIFF.txt').write_text(''.join(diff))
 result={'schema':11,'public_ABI':10,'parent_source_sha256':'5793c044638b7f88a8fabae547b2b56b5c6ce17ac02c1ff23551a9048ed68b1e','stage':'offline_captured_Hold_port_fix_production_module','tests':tests,'module':{'path':str(compact.relative_to(ROOT)),'bytes':len(small),'sha256':sha(compact),'unstripped_sha256':sha(full),'exports':exports,'undefined':undefined,'new_imports':sorted(set(undefined)-oldimports),'bridge_va':bridge,'trampoline_slot_va':slot,'normal_publication':normal,'preparation_publication':prepared,'entry_publication':entry,'publication_loads':pub_loads,'RX_LOADs':[p for p in ph if p[0]==1 and p[1]&1]},'controller_objects':[{'path':str(p.relative_to(ROOT)),'bytes':p.stat().st_size,'sha256':sha(p)}for p in controller_objects],'original_import_providers':providers,'real_live_UI_preparation_caller_linked':True,'persistent_TLS_listener_ports_linked':True,'original_64_observation_cap_preserved':True,'near_mmap_uses_MAP_FIXED':False,'allocation_attempts_max':1,'allocation_bytes_max':65536,'preparation_publication_bytes':192,'native_renderer_body_linked':True,'captured_Hold_and_DetachedRetained_rejected':True,'old_transaction_tests_reused_not_rerun':True,'actual_Root_input_received':False,'runtime_kernel_match_verified':False,'target_loaded':False,'UI_installed':False,'target_stopped':False,'target_text_written':False,'actual_provider_lease_verified':False,'actual_full_source_verified':False,'actual_stock_write_verified':False,'mask_enabled':False,'device_SDK_Windows_network_operations':0,'dependencies':refs,'commands':commands}
 (OUT/'BUILD_PREPARATION.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps({'module':result['module'],'controller_objects':result['controller_objects'],'tests':tests},indent=2))
if __name__=='__main__':main()
