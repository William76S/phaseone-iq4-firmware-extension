#!/usr/bin/env python3
"""Prepare an exact UI08 boundary-only reader/restorer without execution."""
from pathlib import Path
import hashlib,importlib.util,json,struct,subprocess,sys
import contract
ROOT=contract.ROOT;HERE=contract.HERE;OUT=ROOT/'analysis/firmware/f1_entry_loader_build_08'
def sha(p):return contract.sha(p.read_bytes())
def load(name,path):
 s=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
def main():
 assert not(HERE/'SOURCE_SHA256.json').exists(),'Frozen outputs cannot be rewritten'
 OUT.mkdir(parents=True,exist_ok=True);(OUT/'.gitignore').write_text('*.o\nentrytool\n')
 refs={};commands=[]
 def run(a):
  a=list(map(str,a));commands.append(a);p=subprocess.run(a,cwd=ROOT,text=True,capture_output=True);assert p.returncode==0,p.stdout+p.stderr;return p.stdout
 for package,wanted in [('f1_entry_loader_binding_07','2b0ae76a0c3cae3c3ad5a12b38d2d0a6e98a9e2e7be8876859f0c0f3dd933187'),('f1_native_entry_observe_08',contract.ENTRY_SOURCE)]:
  p=HERE.parent/package/'SOURCE_SHA256.json';assert sha(p)==wanted;d=json.loads(p.read_text());refs[str(p.relative_to(ROOT))]=sha(p)
  for group in('members','frozen_refs','review_artifacts'):
   for r in d[group]:p=ROOT/r['path'];assert sha(p)==r['sha256']and p.stat().st_size==r['bytes'];refs[r['path']]=r['sha256']
 build=json.loads((ROOT/'analysis/firmware/f1_native_entry_observe_build_08/BUILD_PREPARATION.json').read_text());source=build['outputs']['authenticated_observe_only_candidate'];so=ROOT/source['path'];assert sha(so)==contract.ENTRY_SO and so.stat().st_size==97000
 assert source['publication_bytes']==496 and source['publication_va']==287208
 pub=source['publication_va'],source['publication_bytes'];pubload=source['publication_load'];assert pubload==[1,6,90592,287200,287200,4444,15996,65536]
 from importlib.util import spec_from_file_location,module_from_spec
 p=HERE.parent/'f1_entry_loader_binding_07/strip_elf.py';sp=spec_from_file_location('frozen08strip',p);st=module_from_spec(sp);sp.loader.exec_module(st)
 original=ROOT/source['unstripped_path'];assert sha(original)==source['unstripped_sha256'];small,proof=st.strip(original.read_bytes());assert small==so.read_bytes();(OUT/'EXACT_UI08_STRIP_BINDING.json').write_text(json.dumps(proof,indent=2)+'\n')
 lock=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text());zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';assert sha(zig)==lock['zig_binary_sha256'];assert run([zig,'version']).strip()==lock['version']
 layout=OUT/'decoder_layout_target.o';run([zig,'c++','-target',lock['target'],'-std=c++17','-O2','-fPIC','-Wall','-Wextra','-Wpedantic','-Werror','-I',ROOT/'src/core/include','-I',ROOT/'src/display/include','-c',HERE/'publication_layout.cpp','-o',layout])
 (OUT/'DECODER_TARGET_LAYOUT.json').write_text(json.dumps({'schema':'iq4_f1_loader08_exact_field_layout_compile_v8','target':'aarch64-linux-gnu','publication_bytes':496,'metadata_offset':8,'WriteFacts_offset':40,'Geometry_offset':120,'RawWriteObservation_offset':336,'all_decoded_field_offsets_target_static_asserted':True,'object_sha256':sha(layout),'object_executed':False},indent=2)+'\n')
 config=(HERE/'config.preview.h').read_text();assert '#define F4_ENABLED 0'in config
 (OUT/'config.h').write_text(config)
 for name in('entry.c','entry_read.inc'):(OUT/name).write_bytes((HERE/name).read_bytes())
 (OUT/'status.h').write_bytes((HERE.parent/'f1_observe_role_02/status.h').read_bytes())
 base=[zig,'cc','-target',lock['target'],'-std=c11','-O2','-Wall','-Wextra','-Werror','-Wl,--build-id=sha1','-fPIE','-pie','-DF4_MONITOR_PARSER_ONLY','-I',OUT,'-I',HERE.parent/'f4_ram_entry_02',OUT/'entry.c',HERE.parent/'f4_ram_entry_01/readonly_monitor.c']
 entry=OUT/'entrytool';run([*base,'-o',entry]);old=load('frozen_recovery_packager08',HERE.parent/'f4_ram_entry_02/generate.py');preview=old.elf_summary(entry)
 branch=OUT/'enabled_branch';branch.mkdir(exist_ok=True);(branch/'config.h').write_text(config.replace('F4_ENABLED 0','F4_ENABLED 1'))
 for name in('entry.c','entry_read.inc','status.h'):(branch/name).write_bytes((OUT/name).read_bytes())
 obj=OUT/'launcher_enabled_branches_ET_REL_only.o';run([zig,'cc','-target',lock['target'],'-std=c11','-O0','-Wall','-Wextra','-Werror','-DF4_MONITOR_PARSER_ONLY','-I',branch,'-I',HERE.parent/'f4_ram_entry_02','-c',branch/'entry.c','-o',obj])
 result={'schema':'iq4_f1_entry_loader_source_preparation_v8','prep_only':True,'deployment_commands':[],
  'entry_source_sha256':contract.ENTRY_SOURCE,'normal_fit_source_sha256':contract.NORMAL_SOURCE,'entry_observe_so':source,
  'publication_layout':build['publication_layout'],'preview_launcher':preview,'enabled_branch_object_sha256':sha(obj),'actual_gate_names':contract.load_contract().REQUIRED,
  'candidate_runner_sha256':'cf3ceeab75da0684384f4d1b8dc3702579d44f8ea39d7403b7c4b81593cc8446',
  'actual_loaded':False,'UI_entry_installed':False,'mask_enabled':False,'paint_installer':False,'native_text_hook_installer':False,
  'device_or_SDK_or_network_or_Windows_used':False,'dependencies':refs,'commands':commands}
 (OUT/'BUILD_PREPARATION.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps({'prep_only':True,'new_observe_so_sha256':sha(so),'publication':pub,'preview_launcher':preview}))
if __name__=='__main__':main()
