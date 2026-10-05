#!/usr/bin/env python3
"""Prepare an independent fixed UI07 reader/loader, without loading it."""
from pathlib import Path
import hashlib,importlib.util,json,struct,subprocess,sys
import contract
ROOT=contract.ROOT;HERE=contract.HERE;OUT=ROOT/'analysis/firmware/f1_entry_loader_build_07'
def sha(p):return contract.sha(p.read_bytes())
def load(name,path):
 s=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
def main():
 assert not(HERE/'SOURCE_SHA256.json').exists(),'Frozen outputs cannot be rewritten'
 OUT.mkdir(parents=True,exist_ok=True);(OUT/'.gitignore').write_text('*.o\nentrytool\n')
 refs={};commands=[]
 def run(args):
  a=list(map(str,args));commands.append(a);p=subprocess.run(a,cwd=ROOT,text=True,capture_output=True);assert p.returncode==0,p.stdout+p.stderr;return p.stdout
 for package in('f1_display_loader_binding_06','f1_native_entry_binding_07'):
  p=HERE.parent/package/'SOURCE_SHA256.json';d=json.loads(p.read_text());refs[str(p.relative_to(ROOT))]=sha(p)
  for group in('members','frozen_refs','review_artifacts'):
   for r in d[group]:p=ROOT/r['path'];assert sha(p)==r['sha256']and p.stat().st_size==r['bytes'];refs[r['path']]=r['sha256']
 assert refs['tools/firmware/f1_native_entry_binding_07/SOURCE_SHA256.json']==contract.ENTRY_SOURCE
 old=load('frozen_entry_public_packager',HERE.parent/'f4_ram_entry_02/generate.py')
 ui=json.loads((ROOT/'analysis/firmware/f1_native_entry_binding_build_07/BUILD_VALIDATION.json').read_text())
 source=ui['outputs']['authenticated_entry_only_candidate'];so=ROOT/source['path'];assert sha(so)==contract.ENTRY_SO and so.stat().st_size==90480
 unstripped=ROOT/source['unstripped_path'];assert sha(unstripped)==source['unstripped_sha256']
 sys.path.insert(0,str(HERE.parent/'f4_ui_bootstrap_02'));from build_validate import elf
 b=unstripped.read_bytes();h,sections,exports,undefined=elf(b);assert h[1]==3 and h[2]==183 and len(exports)==8
 sym=sections['.dynsym'];sh=[struct.unpack_from('<IIQQQQIIQQ',b,h[6]+i*h[11])for i in range(h[12])];strings=sh[sym[6]];names=b[strings[4]:strings[4]+strings[5]];pub=None
 for p in range(sym[4],sym[4]+sym[5],sym[9]):
  n,info,other,index,va,size=struct.unpack_from('<IBBHQQ',b,p)
  if n and index and names[n:names.index(0,n)]==b'iq4_f1_entry_binding_observed_07':pub=(va,size)
 assert pub==(281200,104),'Exact new UI07 own export required'
 loads=[struct.unpack_from('<IIQQQQQQ',b,h[5]+i*h[9])for i in range(h[10])];loads=[p for p in loads if p[0]==1]
 cover=[p for p in loads if p[3]<=pub[0]and pub[0]+pub[1]<=p[3]+p[5]];assert len(cover)==1 and cover[0][1]==6
 pubload=cover[0];assert (pubload[2]&~4095,pubload[3]&~4095)==(81920,278528)
 # The frozen stripped SO is reused byte-for-byte, never relinked or renamed as
 # a Display06 SO. Its explicit existing strip/header exception is retained.
 from strip_elf import strip
 stripped,proof=strip(b);assert stripped==so.read_bytes()
 (OUT/'EXACT_UI07_STRIP_BINDING.json').write_text(json.dumps(proof,indent=2)+'\n')
 lock=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text());zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';assert sha(zig)==lock['zig_binary_sha256'];assert run([zig,'version']).strip()==lock['version']
 config=(HERE/'config.preview.h').read_text();(OUT/'config.h').write_text(config)
 for name in('entry.c','entry_read.inc'):(OUT/name).write_bytes((HERE/name).read_bytes())
 (OUT/'status.h').write_bytes((HERE.parent/'f1_observe_role_02/status.h').read_bytes())
 base=[zig,'cc','-target',lock['target'],'-std=c11','-O2','-Wall','-Wextra','-Werror','-Wl,--build-id=sha1','-fPIE','-pie','-DF4_MONITOR_PARSER_ONLY','-I',OUT,'-I',HERE.parent/'f4_ram_entry_02',OUT/'entry.c',HERE.parent/'f4_ram_entry_01/readonly_monitor.c']
 entry=OUT/'entrytool';run([*base,'-o',entry]);preview=old.elf_summary(entry)
 branch=OUT/'enabled_branch';branch.mkdir(exist_ok=True);(branch/'config.h').write_text(config.replace('F4_ENABLED 0','F4_ENABLED 1'))
 for name in('entry.c','entry_read.inc','status.h'):(branch/name).write_bytes((OUT/name).read_bytes())
 obj=OUT/'launcher_enabled_branches_ET_REL_only.o';run([zig,'cc','-target',lock['target'],'-std=c11','-O0','-Wall','-Wextra','-Werror','-DF4_MONITOR_PARSER_ONLY','-I',branch,'-I',HERE.parent/'f4_ram_entry_02','-c',branch/'entry.c','-o',obj])
 result={'schema':'iq4_f1_entry_loader_source_preparation_v7','prep_only':True,'deployment_commands':[],
  'entry_source_sha256':contract.ENTRY_SOURCE,'entry_only_so':{**source,'publication_va':pub[0],'publication_bytes':pub[1],'publication_load':pubload},
  'preview_launcher':preview,'enabled_branch_object_sha256':sha(obj),'actual_gate_names':contract.load_contract().REQUIRED,
  'candidate_runner_sha256':'cf3ceeab75da0684384f4d1b8dc3702579d44f8ea39d7403b7c4b81593cc8446',
  'actual_loaded':False,'UI_entry_installed':False,'mask_enabled':False,'paint_installer':False,
  'device_or_SDK_or_network_or_Windows_used':False,'dependencies':refs,'commands':commands}
 (OUT/'BUILD_PREPARATION.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps({'prep_only':True,'entry_only_so_sha256':sha(so),'publication':pub,'preview_launcher':preview}))
if __name__=='__main__':main()
