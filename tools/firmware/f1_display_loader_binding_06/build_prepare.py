#!/usr/bin/env python3
"""Offline independent Display06 loader preparation. Never loads target code."""
from pathlib import Path
import argparse,hashlib,importlib.util,json,re,struct,subprocess,sys
import contract
ROOT=contract.ROOT;HERE=contract.HERE;OUT=ROOT/'analysis/firmware/f1_display_loader_build_06'
def sha(p):return contract.sha(p.read_bytes())
def load(name,path):
 s=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
def main():
 assert not(HERE/'SOURCE_SHA256.json').exists(),'frozen build outputs may not be overwritten'
 OUT.mkdir(parents=True,exist_ok=True);(OUT/'.gitignore').write_text('*.o\n*.so\nentrytool\n')
 refs={};commands=[]
 def run(args):
  a=list(map(str,args));commands.append(a);p=subprocess.run(a,cwd=ROOT,capture_output=True,text=True);assert p.returncode==0,p.stdout+p.stderr;return p.stdout
 for package in ('f1_display_observe_06','f1_observe_role_02','f1_restore_baseline_03','f1_scratch_restore_probe_01'):
  p=HERE.parent/package/'SOURCE_SHA256.json';d=json.loads(p.read_text());refs[str(p.relative_to(ROOT))]=sha(p)
  for r in d.get('members',d.get('files',[]))+d.get('frozen_refs',[])+d.get('review_artifacts',[]):
   p=(ROOT/r['path'])if 'path'in r else (HERE.parent/package/r['name']).resolve();assert sha(p)==r['sha256'] and p.stat().st_size==r.get('bytes',r.get('size'));refs[str(p.relative_to(ROOT))]=r['sha256']
 assert refs['tools/firmware/f1_display_observe_06/SOURCE_SHA256.json']==contract.DISPLAY_SOURCE
 original=ROOT/'analysis/sdk_reference/f1_observe_role_build_02/proof_contract.py'
 s=original.read_text();assert contract.sha(s.encode())==refs[str(original.relative_to(ROOT))]
 s=s.replace('iq4_f1_observe_role_gate_v2',contract.SCHEMA).replace('RAM_F1_observe_once',contract.PROFILE)
 end=s.index('\n]',s.index('REQUIRED=['));s=s[:end]+''.join('\n '+repr(k)+','for k in contract.ADDITIONAL)+s[end:]
 (HERE/'recovery_contract.py').write_text('# Own new-identity mechanical validator; frozen recovery source unchanged.\n'+s)
 report=json.loads((ROOT/'analysis/firmware/f1_display_observe_build_06/BUILD_VALIDATION.json').read_text())
 lock=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text());zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';assert sha(zig)==lock['zig_binary_sha256'];assert run([zig,'version']).strip()==lock['version']
 objs=[]
 for cmd in report['commands']:
  if '-c'not in cmd or not cmd[-1].endswith('.o')or 'layout_target.cpp'in ' '.join(cmd)or 'ctor_status.cpp'in ' '.join(cmd):continue
  a=list(cmd);p=OUT/('display_'+Path(a[-1]).name);a[-1]=str(p);run(a);objs.append(p)
 assert len(objs)==10
 (OUT/'role_config.h').write_text('#define F1_ROLE_ENABLED 1\n#define F1_ROLE_STATE "/run/iq4_f1_observe02"\n#define F1_ROLE_TOOL F1_ROLE_STATE "/entrytool"\n')
 cc=[zig,'c++','-target',lock['target'],'-std=c++17','-O2','-fPIC','-fvisibility=hidden','-ffunction-sections','-fdata-sections','-Wall','-Wextra','-Werror','-Wno-macro-redefined','-I',ROOT/'src/core/include','-I',ROOT/'src/display/include','-I',OUT]
 ctor=OUT/'authenticated_ctor.o';run([*cc,'-c',HERE.parent/'f1_observe_role_02/ctor_status.cpp','-o',ctor])
 parser=OUT/'readonly_stat_parser.o';run([zig,'cc','-target',lock['target'],'-std=c11','-O2','-fPIC','-fvisibility=hidden','-ffunction-sections','-fdata-sections','-DF4_MONITOR_PARSER_ONLY','-c',HERE.parent/'f4_ram_entry_01/readonly_monitor.c','-o',parser])
 so=OUT/'libiq4_f1_display_observe_06_authenticated_candidate.so';run([zig,'c++','-target',lock['target'],'-nostdlib++','-shared',*objs,ctor,parser,'-Wl,--gc-sections','-Wl,-Bsymbolic','-Wl,-z,now','-Wl,-z,relro','-o',so])
 sys.path.insert(0,str(HERE.parent/'f4_ui_bootstrap_02'));from build_validate import elf
 b=so.read_bytes();h,sections,exports,undefined=elf(b);assert h[1]==3 and h[2]==183 and so.stat().st_size<=1048576
 assert set(exports)==set(report['target']['exports'])
 init=sections['.init_array'];rela=sections['.rela.dyn'];assert init[5]==16;initptr={}
 for p in range(rela[4],rela[4]+rela[5],24):
  va,info,addend=struct.unpack_from('<QQq',b,p)
  if init[3]<=va<init[3]+16:assert info==1027;initptr[va]=addend
 sh=[struct.unpack_from('<IIQQQQIIQQ',b,h[6]+i*h[11])for i in range(h[12])];sym=sections['.symtab'];strings=sh[sym[6]];names=b[strings[4]:strings[4]+strings[5]];labels={};display=None
 for p in range(sym[4],sym[4]+sym[5],sym[9]):
  n,info,other,index,va,size=struct.unpack_from('<IBBHQQ',b,p)
  if n and index:
   name=names[n:names.index(0,n)].decode()
   if info&15==2:labels[va]=name
   if name=='iq4_f1_display_observed_06':assert size==1440;display=va
 order=[labels[initptr[init[3]+8*i]]for i in range(2)];assert 'prepare'in order[0]and'role_constructor'in order[1],order
 loads=[struct.unpack_from('<IIQQQQQQ',b,h[5]+i*h[9])for i in range(h[10])];loads=[p for p in loads if p[0]==1]
 assert loads[0][2]==loads[0][3]==0 and display
 pubload=next(p for p in loads if p[3]<=display and display+1440<=p[3]+p[5]);assert pubload[1]==6,'publication must be file-backed own RW LOAD'
 from strip_elf import strip
 original_so=so;stripped,strip_proof=strip(b);so=OUT/'libiq4_f1_display_observe_06_authenticated_load_only.so';so.write_bytes(stripped)
 (OUT/'AUTHENTICATED_STRIP_PROOF.json').write_text(json.dumps(strip_proof,indent=2)+'\n')
 default=ROOT/'analysis/firmware/f1_display_observe_build_06/libiq4_f1_display_observe_06_default_off.so';stripped,default_strip=strip(default.read_bytes());(OUT/'libiq4_f1_display_observe_06_default_off_load_only.so').write_bytes(stripped);(OUT/'DEFAULT_STRIP_PROOF.json').write_text(json.dumps(default_strip,indent=2)+'\n')
 original_entry=ROOT/'analysis/sdk_reference/f1_observe_role_build_02/entry.c';s=original_entry.read_text();assert sha(original_entry)==refs[str(original_entry.relative_to(ROOT))]
 s=s.replace('iq4_f1_ctor_status_v2','iq4_f1_display_ctor_status_v6')
 marker='#ifndef F4_NO_MAIN';assert s.count(marker)==1;s=s.replace(marker,'#include "observe_read.inc"\n'+marker)
 needle=' if(argc==2&&!strcmp(argv[1],"--arm"))';assert s.count(needle)==1;s=s.replace(needle,' if(argc==2&&!strcmp(argv[1],"--observe-read"))return f1_observe_read();\n'+needle)
 (HERE/'entry.c').write_text(s)
 old=load('frozen_recovery_packaging',HERE.parent/'f4_ram_entry_02/generate.py')
 sys.path.insert(0,str(HERE.parent));from inspect_boot import Ext2
 disk=ROOT/'analysis/firmware/P1_ramdisk.ext2';assert sha(disk)=='2ca2a497fb22cb3b16009f5dab2aad1f744982aaafb6c928ac688c0a3f9dbccb'
 runner={n['path']:raw for n,raw in Ext2(disk.read_bytes()).walk()}['/p1/scripts/boot_run_p1linux.sh'];replacement=b'    /run/f1launch   ${P1LINUX_ARGS}\n';assert len(old.OLD)==len(replacement)and runner.count(old.OLD)==1
 candidate=contract.sha(runner.replace(old.OLD,replacement))
 config=old.c_config(True,None,sha(so),candidate).replace('/run/iq4_f4_entry02','/run/iq4_f1_observe02').replace('/run/f4launch','/run/f1launch').replace('/marker.so','/observe.so').replace('.iq4_f4_original02','.iq4_f1_original02').replace('.iq4_f4_candidate02','.iq4_f1_candidate02')
 config+='\n#define F1_DISPLAY_VA '+str(display)+'ULL\n#define F1_DISPLAY_BYTES 1440U\n#define F1_DISPLAY_LOAD_FILE_PAGE '+str(pubload[2]&~4095)+'ULL\n#define F1_DISPLAY_LOAD_VA_PAGE '+str(pubload[3]&~4095)+'ULL\n'
 (HERE/'config.preview.h').write_text(config);(OUT/'config.h').write_text(config)
 (OUT/'entry.c').write_bytes((HERE/'entry.c').read_bytes());(OUT/'observe_read.inc').write_bytes((HERE/'observe_read.inc').read_bytes());(OUT/'status.h').write_bytes((HERE.parent/'f1_observe_role_02/status.h').read_bytes())
 base=[zig,'cc','-target',lock['target'],'-std=c11','-O2','-Wall','-Wextra','-Werror','-Wl,--build-id=sha1','-fPIE','-pie','-DF4_MONITOR_PARSER_ONLY','-I',OUT,'-I',HERE.parent/'f4_ram_entry_02',OUT/'entry.c',HERE.parent/'f4_ram_entry_01/readonly_monitor.c']
 entry=OUT/'entrytool';run([*base,'-o',entry])
 # Preserve all enabled reader/restore bodies without creating an enabled
 # runnable launcher or installer. Default launcher refuses every operation.
 branch=OUT/'enabled_branch';branch.mkdir(exist_ok=True);(branch/'config.h').write_text(config.replace('F4_ENABLED 0','F4_ENABLED 1'));(branch/'entry.c').write_bytes((HERE/'entry.c').read_bytes());(branch/'status.h').write_bytes((OUT/'status.h').read_bytes());(branch/'observe_read.inc').write_bytes((HERE/'observe_read.inc').read_bytes())
 obj=OUT/'launcher_enabled_branches_ET_REL_only.o';run([zig,'cc','-target',lock['target'],'-std=c11','-O0','-Wall','-Wextra','-Werror','-DF4_MONITOR_PARSER_ONLY','-I',branch,'-I',HERE.parent/'f4_ram_entry_02','-c',branch/'entry.c','-o',obj])
 result={'schema':'iq4_f1_display_loader_source_preparation_v6','prep_only':True,'deployment_commands':[],
  'display_source_sha256':contract.DISPLAY_SOURCE,'default_off_so_sha256':contract.DEFAULT_SO,
  'authenticated_candidate':{'path':str(so.relative_to(ROOT)),'sha256':sha(so),'bytes':so.stat().st_size,'unstripped_path':str(original_so.relative_to(ROOT)),'unstripped_sha256':sha(original_so),'strip_proof_sha256':sha(OUT/'AUTHENTICATED_STRIP_PROOF.json'),'exports':exports,'undefined':undefined,'init_order':order,'publication_va':display,'publication_bytes':1440,'publication_load':pubload},
  'preview_launcher':old.elf_summary(entry),'candidate_runner_sha256':candidate,'enabled_branch_object_sha256':sha(obj),
  'actual_gate_names':contract.load_contract().REQUIRED,'actual_loaded':False,'mask_enabled':False,'paint_installer':False,'UI_installer':False,'device_or_SDK_or_network_or_Windows_used':False,'dependencies':refs,'commands':commands}
 (OUT/'BUILD_PREPARATION.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps({k:result[k]for k in('prep_only','deployment_commands','authenticated_candidate','preview_launcher')},indent=2))
if __name__=='__main__':main()
