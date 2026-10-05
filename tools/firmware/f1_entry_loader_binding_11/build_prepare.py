#!/usr/bin/env python3
"""Exact new SO + embedded external tracer; target artifacts never execute."""
from pathlib import Path
import hashlib,importlib.util,json,re,struct,subprocess,sys
import contract
ROOT=contract.ROOT;HERE=contract.HERE;OUT=ROOT/'analysis/firmware/f1_entry_loader_build_11';INSTALLER=HERE.parent/'f1_scaler_hook_install_11'
def sha(p):return contract.sha(p.read_bytes())
def load(name,path):
 s=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
def compile_entry(config,package,run,zig,target):
 package.mkdir(parents=True,exist_ok=True);(package/'config.h').write_text(config)
 for name in('entry.c','entry_read.inc'):(package/name).write_bytes((HERE/name).read_bytes())
 (package/'status.h').write_bytes((HERE.parent/'f1_observe_role_02/status.h').read_bytes())
 c=[zig,'cc','-target',target,'-std=c11','-O2','-fPIE','-ffunction-sections','-fdata-sections','-Wall','-Wextra','-Werror','-DF4_MONITOR_PARSER_ONLY','-I',package,'-I',HERE.parent/'f4_ram_entry_02']
 objects=[]
 for name,source in [('entry',package/'entry.c'),('monitor',HERE.parent/'f4_ram_entry_01/readonly_monitor.c')]:
  obj=package/(name+'.o');run([*c,'-c',source,'-o',obj]);objects.append(obj)
 cpp=[zig,'c++','-target',target,'-std=c++17','-O2','-fPIE','-ffunction-sections','-fdata-sections','-fno-exceptions','-fno-rtti','-Wall','-Wextra','-Wpedantic','-Werror','-DIQ4_F1_HOOK10_NO_MAIN','-I',ROOT/'src/core/include','-I',ROOT/'src/display/include']
 for name in('transaction','linux_controller'):
  obj=package/(name+'.o');run([*cpp,'-c',HERE/(name+'.cpp'),'-o',obj]);objects.append(obj)
 entry=package/'entrytool';run([zig,'c++','-target',target,'-nostdlib++','-fPIE','-pie',*objects,'-Wl,--build-id=sha1','-Wl,--gc-sections','-Wl,-u,iq4_f1_hook10_fixed_file_operation','-o',entry])
 raw=entry.read_bytes();strip=load('frozen10strip',HERE/'strip_elf.py').strip;small,proof=strip(raw)
 (package/'entrytool.unstripped').write_bytes(raw);entry.write_bytes(small);(package/'ENTRY_STRIP_PROOF.json').write_text(json.dumps(proof,indent=2)+'\n')
 return entry
def main():
 assert not(HERE/'SOURCE_SHA256.json').exists(),'Frozen outputs cannot be rewritten'
 OUT.mkdir(parents=True,exist_ok=True);(OUT/'.gitignore').write_text('*.o\n*.elf\npreview_package/*.o\nenabled_branch/*.o\n')
 refs={};commands=[]
 def run(a):
  a=list(map(str,a));commands.append(a);p=subprocess.run(a,cwd=ROOT,text=True,capture_output=True);assert p.returncode==0,p.stdout+p.stderr;return p.stdout
 for package,wanted in [('f1_entry_loader_binding_10','f0b90fa7675462bebc75a3f9a04f6bf82eb6240ab2db3bc00d595da15c44fcca'),('f1_scaler_hook_install_11',contract.ENTRY_SOURCE)]:
  p=HERE.parent/package/'SOURCE_SHA256.json'
  assert sha(p)==wanted
  d=json.loads(p.read_text());refs[str(p.relative_to(ROOT))]=sha(p)
  for group in('members','frozen_refs','review_artifacts'):
   for r in d[group]:p=ROOT/r['path'];assert sha(p)==r['sha256']and p.stat().st_size==r['bytes'];refs[r['path']]=r['sha256']
 build=json.loads((ROOT/'analysis/firmware/f1_scaler_hook_install_build_11/BUILD_PREPARATION.json').read_text());source=build['module'];so=ROOT/source['path'];assert sha(so)==contract.ENTRY_SO and so.stat().st_size==118080
 assert source['normal_publication']==[308056,496]and source['preparation_publication']==[308552,192]and source['entry_publication']==[308744,104]
 assert source['publication_loads']['normal']==[1,6,111440,308048,308048,4648,16468,65536]
 source=dict(source,publication_symbol='iq4_f1_normal_fit_ingress_observed_10',publication_va=308056,publication_bytes=496,publication_load=source['publication_loads']['normal'])
 lock=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text());zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';assert sha(zig)==lock['zig_binary_sha256'];assert run([zig,'version']).strip()==lock['version']
 layout=OUT/'decoder_layout_target.o';run([zig,'c++','-target',lock['target'],'-std=c++17','-O2','-fPIC','-Wall','-Wextra','-Wpedantic','-Werror','-I',ROOT/'src/core/include','-I',ROOT/'src/display/include','-c',HERE/'publication_layout.cpp','-o',layout])
 (OUT/'DECODER_TARGET_LAYOUT.json').write_text(json.dumps({'schema':11,'public_ABI':10,'normal_publication_bytes':496,'preparation_publication_bytes':192,'preparation_input_bytes':472,'controller_contract_bytes':960,'all_decoded_and_packed_offsets_target_static_asserted':True,'object_sha256':sha(layout),'object_executed':False},indent=2)+'\n')
 config=(HERE/'config.preview.h').read_text();assert '#define F4_ENABLED 0'in config
 entry=compile_entry(config,OUT/'preview_package',run,zig,lock['target'])
 nm='/Library/Developer/CommandLineTools/usr/bin/llvm-nm';dump='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
 (OUT/'ENTRY_DEFINED.txt').write_text(run([nm,'--defined-only',OUT/'preview_package/entrytool.unstripped']))
 names=(OUT/'ENTRY_DEFINED.txt').read_text();assert 'iq4_f1_hook10_fixed_file_operation'in names and 'iq4_f1_root_trace_transaction_10'in names
 (OUT/'ENTRY_DYNAMIC.txt').write_text(run([dump,'-p',OUT/'preview_package/entrytool.unstripped']))
 elf=load('exact10elf',HERE.parent/'f4_ui_bootstrap_02/build_validate.py').elf;_,_,_,undefined=elf((OUT/'preview_package/entrytool.unstripped').read_bytes())
 assert not any(n.startswith('_Z')or'bad_array'in n for n in undefined)
 # The actual old-library export closure is reused, with every new entrytool
 # import independently checked. No libc++ or libstdc++ is linked by the tool.
 sys.path.insert(0,str(HERE.parent));from inspect_boot import Ext2
 available=set();providers=[];provider_symbols={}
 for node,body in Ext2((ROOT/'analysis/firmware/P1_ramdisk.ext2').read_bytes()).walk():
  if not node['path'].startswith(('/lib/libc-','/lib/libpthread-','/lib/libgcc_s.so'))or body[:7]!=b'\x7fELF\x02\x01\x01':continue
  _,_,exports,_=elf(body);available.update(exports);provider_symbols[node['path']]=set(exports);providers.append({'path':node['path'],'sha256':contract.sha(body),'required_exports':sorted(set(undefined)&set(exports))})
 assert set(undefined)<=available,set(undefined)-available
 summary=load('exact10summary',HERE.parent/'f4_ram_entry_02/generate.py').elf_summary(entry)
 from generate import blobs_for
 blobs=blobs_for(entry,so,False)
 for name,body in blobs.items():(OUT/'preview_package'/name).write_bytes(body)
 result={'schema':'iq4_f1_entry_loader_source_preparation_v11','prep_only':True,'deployment_commands':[],'entry_source_sha256':contract.ENTRY_SOURCE,'normal_fit_source_sha256':contract.NORMAL_SOURCE,'entry_observe_so':source,'preview_launcher':summary,'preview_launcher_path':str(entry.relative_to(ROOT)),'embedded_controller':True,'public_artifact_names':['entrytool','observe.so','entry.sha256','install.sh','disable.sh'],'preview_artifacts':{name:{'bytes':len(body),'sha256':contract.sha(body)}for name,body in blobs.items()},'ui_marker_creator_body_from_frozen_source':True,'enabled_target_built_in_this_stage':False,'installable':False,'undefined':undefined,'original_import_providers':providers,'actual_gate_names':contract.load_contract().REQUIRED,'actual_loaded':False,'UI_entry_installed':False,'mask_enabled':False,'native_text_hook_installed':False,'actual_hook_input_received':False,'device_or_SDK_or_network_or_Windows_used':False,'dependencies':refs,'commands':commands}
 (OUT/'BUILD_PREPARATION.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps({'prep_only':True,'preview_launcher':summary,'embedded_controller':True,'public_files':result['public_artifact_names']}))
if __name__=='__main__':main()
