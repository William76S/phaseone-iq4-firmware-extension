#!/usr/bin/env python3
"""Local public package generation after explicit actual new-version proof."""
from pathlib import Path
import argparse,json,subprocess,sys
import contract
from build_prepare import OUT,load,sha
ROOT=contract.ROOT;HERE=contract.HERE
def bind_stage_identity(plan,source):
 if source['sha256']!=contract.ENTRY_SO or source['bytes']!=97000 or source['publication_symbol']!='iq4_f1_normal_fit_ingress_observed_08' or source['publication_va']!=287208 or source['publication_bytes']!=496:raise ValueError('Exact UI08 plan/publication identity required')
 config=(HERE/'config.preview.h').read_text()
 if '#define F1_ENTRY_BYTES 496U'not in config or '#define F1_ENTRY_VA 287208ULL'not in config:raise ValueError('Reader config/actual SO publication mismatch')
 plan.update(entry_publication_bytes=source['publication_bytes'],entry_publication_relative_va=source['publication_va'],entry_publication_symbol=source['publication_symbol'],new_so_sha256=source['sha256'],new_so_bytes=source['bytes'],UI_entry_installation_authorized=True,UI_objects_registry_mutation_authorized=True,entry_boundary_observation_only=True,native_pixel_write_authorized=False,native_text_hook_installation_authorized=False,provider_lease_authorized=False,paint_table_installation_authorized=False,mask_enabled=False)
 return plan
def main():
 a=argparse.ArgumentParser();a.add_argument('--emit-enabled',action='store_true');a.add_argument('--proof',type=Path);a.add_argument('--runner-a',type=Path);a.add_argument('--runner-b',type=Path);args=a.parse_args()
 manifest=HERE/'SOURCE_SHA256.json';doc=json.loads(manifest.read_text())
 for group in ('members','frozen_refs','review_artifacts'):
  for r in doc[group]:p=ROOT/r['path'];assert sha(p)==r['sha256']and p.stat().st_size==r['bytes'],r['path']
 build=json.loads((OUT/'BUILD_PREPARATION.json').read_text());module=ROOT/build['entry_observe_so']['path'];assert sha(module)==build['entry_observe_so']['sha256']
 if not args.emit_enabled:
  print(json.dumps({'schema':'iq4_f1_entry_loader_source_preparation_v8','prep_only':True,'commands':[],'target_loaded':False,'mask_enabled':False}));return
 if not all((args.proof,args.runner_a,args.runner_b)):raise SystemExit('Actual new proof and two independent runner files required')
 for p in (args.runner_a,args.runner_b):
  if p.is_symlink()or not p.is_file()or p.stat().st_size!=5105:raise ValueError('Runner originals extent/symlink')
 if args.runner_a.resolve()==args.runner_b.resolve()or(args.runner_a.stat().st_dev,args.runner_a.stat().st_ino)==(args.runner_b.stat().st_dev,args.runner_b.stat().st_ino):raise ValueError('Independent original files required')
 proof=contract.strict_json(args.proof.read_bytes());contract.validate(proof,args.runner_a.read_bytes(),args.runner_b.read_bytes(),sha(module),sha(manifest))
 package=OUT/('actual_package_'+sha(args.proof)[:16]);package.mkdir(exist_ok=False)
 old=load('frozen_recovery_public_packager',HERE.parent/'f4_ram_entry_02/generate.py');lock=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text());zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';assert sha(zig)==lock['zig_binary_sha256']
 # Actual fields bind a new config directly, after this new proof validates.
 placement=proof['entry_placement'];marker=('IQ4_F1_UI08_ENTRY_OBSERVE_ONLY '+str(placement['x'])+' '+str(placement['y'])+'\n').encode();assert len(marker)<96
 config=(HERE/'config.preview.h').read_text();values={'F4_ENABLED':'1','F1_UI_MARKER_BYTES':str(len(marker))+'ULL','F1_UI_MARKER_SHA':'\"'+contract.sha(marker)+'\"','F4_RUNNER_INODE':str(proof['runner']['inode'])+'ULL','F4_ROOT_MOUNT_ID':str(proof['mount']['root_mount_id'])+'U','F4_RUN_MOUNT_ID':str(proof['mount']['run_mount_id'])+'U','F4_RUN_MINOR':str(proof['mount']['run_minor'])+'U','F4_OLD_PID':str(proof['user']['pid'])+'ULL','F4_OLD_TICKS':str(proof['user']['start_ticks'])+'ULL','F4_USER_UMASK':'0'+format(proof['user']['umask'],'o')+'U'}
 import re
 for k,v in values.items():config,n=re.subn(r'^#define '+k+r' .+$','#define '+k+' '+v,config,flags=re.M);assert n==1
 (package/'config.h').write_text(config)
 for name in('entry.c','entry_read.inc'):(package/name).write_bytes((HERE/name).read_bytes())
 (package/'status.h').write_bytes((HERE.parent/'f1_observe_role_02/status.h').read_bytes());entry=package/'entrytool'
 cmd=list(map(str,[zig,'cc','-target',lock['target'],'-std=c11','-O2','-Wall','-Wextra','-Werror','-Wl,--build-id=sha1','-fPIE','-pie','-DF4_MONITOR_PARSER_ONLY','-I',package,'-I',HERE.parent/'f4_ram_entry_02',package/'entry.c',HERE.parent/'f4_ram_entry_01/readonly_monitor.c','-o',entry]));subprocess.run(cmd,check=True,cwd=ROOT)
 from strip_elf import strip
 original=entry.read_bytes();stripped,proof_strip=strip(original);(package/'entrytool.unstripped').write_bytes(original);entry.write_bytes(stripped);(package/'ENTRY_STRIP_PROOF.json').write_text(json.dumps(proof_strip,indent=2)+'\n')
 blobs={'entrytool':entry.read_bytes(),'observe.so':module.read_bytes(),'entry.sha256':(sha(entry)+'\n').encode(),'ui08.entry':marker}
 for action in('install','disable'):blobs[action+'.sh']=old.wrapper(action,True).replace('/run/iq4_f4_entry02','/run/iq4_f1_observe02').encode()
 from stager import stage_plan
 plan=stage_plan(blobs,True)
 for name,b in blobs.items():(package/name).write_bytes(b)
 plan['schema']='iq4_f1_entry_loader_public_stage_v8';plan['expected_artifacts']={n:{'bytes':len(b),'sha256':contract.sha(b)}for n,b in blobs.items()};plan['proof_sha256']=sha(args.proof);plan['loader_source_sha256']=sha(manifest);plan['entry_source_sha256']=contract.ENTRY_SOURCE;plan['normal_fit_source_sha256']=contract.NORMAL_SOURCE;plan['entry_boundary_observation_only']=True;plan['native_text_hook_installation_authorized']=False;plan['provider_lease_authorized']=False;plan['entry_publication_bytes']=496;plan['UI_entry_installation_authorized']=True;plan['paint_table_installation_authorized']=False;plan['new_so_sha256']=sha(module);plan['entry_read_command']='"Sys /run/iq4_f1_observe02/entrytool --entry-read 2>&1"';plan['target_executed']=False;plan['mask_enabled']=False;plan['actual_hardware_facts_created_by_build']=False
 bind_stage_identity(plan,build['entry_observe_so'])
 (package/'stage_commands.json').write_text(json.dumps(plan,indent=2)+'\n');print(json.dumps({'local_package':str(package),'commands':len(plan['commands']),'target_executed':False,'mask_enabled':False}))
if __name__=='__main__':main()
