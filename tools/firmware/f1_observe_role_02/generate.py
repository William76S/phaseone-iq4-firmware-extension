#!/usr/bin/env python3
"""Local fixed-role build/package only. No target loading, transport or execution."""
from pathlib import Path
import argparse,hashlib,importlib.util,json,os,subprocess,sys
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/sdk_reference/f1_observe_role_build_02'
def sha(b):return hashlib.sha256(b).hexdigest()
def load(name,path):
 s=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
def strict_json(data):
 def pairs(rows):
  out={}
  for k,v in rows:
   if k in out:raise ValueError('Duplicate proof field')
   out[k]=v
  return out
 if not 0<len(data)<=1048576:raise ValueError('Proof extent invalid')
 return json.loads(data,object_pairs_hook=pairs,parse_constant=lambda _:(_ for _ in ()).throw(ValueError('Non-finite proof number')))
def main():
 a=argparse.ArgumentParser();a.add_argument('--emit-enabled',action='store_true');a.add_argument('--proof',type=Path);a.add_argument('--runner-a',type=Path);a.add_argument('--runner-b',type=Path);args=a.parse_args()
 # Recompile pinned frozen source inputs, never execute either target output.
 subprocess.run([sys.executable,HERE/'build_validate.py'],check=True,cwd=ROOT)
 old=load('frozen_entry02_generator',ROOT/'tools/firmware/f4_ram_entry_02/generate.py')
 contract=load('fixed_f1_role_contract',OUT/'proof_contract.py');preview=not args.emit_enabled;proof=None
 if not preview:
  if not all((args.proof,args.runner_a,args.runner_b)):raise SystemExit('Actual proof and independent complete runner originals required')
  if args.runner_a.resolve()==args.runner_b.resolve() or args.runner_a.stat().st_ino==args.runner_b.stat().st_ino:raise SystemExit('Independent runner originals required')
  proof=strict_json(args.proof.read_bytes())
  def receipt(rel):
   p=ROOT/rel
   if p.is_symlink() or not p.resolve().is_relative_to(ROOT) or not p.is_file() or not 0<p.stat().st_size<=1048576:raise ValueError('Invalid private actual receipt reference')
   # Exact content checks are provenance only; Root separately establishes
   # device meaning, held handles/ACL, and current lease before any deployment.
   return p.read_bytes()
  contract.validate_proof(proof,args.runner_a.read_bytes(),args.runner_b.read_bytes(),receipt)
 package=OUT/('preview_package' if preview else 'enabled_package');package.mkdir(exist_ok=True)
 module=OUT/('libiq4_f1_observe_role02_default_off.so' if preview else 'libiq4_f1_observe_role02_ctor_candidate.so')
 report=json.loads((OUT/'BUILD_VALIDATION.json').read_text());r=report['composed_default_off_SO' if preview else 'ctor_candidate_SO']
 if sha(module.read_bytes())!=r['sha256'] or module.stat().st_size!=r['bytes']:raise SystemExit('Composed module receipt changed')
 if not preview and (r['init_order']!=['_ZN12_GLOBAL__N_17prepareEv','_ZN12_GLOBAL__N_116role_constructorEv'] or r['init_array_bytes']!=16):raise SystemExit('Actual two constructor order not exact')
 sys.path.insert(0,str(ROOT/'tools/firmware'));from inspect_boot import Ext2
 disk=ROOT/'analysis/firmware/P1_ramdisk.ext2';assert sha(disk.read_bytes())=='2ca2a497fb22cb3b16009f5dab2aad1f744982aaafb6c928ac688c0a3f9dbccb'
 runner={n['path']:b for n,b in Ext2(disk.read_bytes()).walk()}['/p1/scripts/boot_run_p1linux.sh']
 if not preview:runner=args.runner_a.read_bytes()
 replacement=b'    /run/f1launch   ${P1LINUX_ARGS}\n';assert len(old.OLD)==len(replacement) and runner.count(old.OLD)==1 and sha(runner)==old.RUNNER_SHA
 candidate_hash=sha(runner.replace(old.OLD,replacement))
 config=old.c_config(preview,proof,sha(module.read_bytes()),candidate_hash).replace('/run/iq4_f4_entry02','/run/iq4_f1_observe02').replace('/run/f4launch','/run/f1launch').replace('/marker.so','/observe.so').replace('.iq4_f4_original02','.iq4_f1_original02').replace('.iq4_f4_candidate02','.iq4_f1_candidate02')
 (package/'config.h').write_text(config)
 zig=old.ZIG;assert sha(zig.read_bytes())==old.ZIG_SHA
 # The new source keeps config include adjacent; a copy binds this build to
 # this package's actual module/runner identity, not the EN0 preview config.
 (package/'entry.c').write_bytes((OUT/'entry.c').read_bytes());(package/'status.h').write_bytes((HERE/'status.h').read_bytes())
 entry=package/'entrytool';parser=ROOT/'tools/firmware/f4_ram_entry_01/readonly_monitor.c'
 command=[str(zig),'cc','-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-Wall','-Wextra','-Werror','-Wl,--build-id=sha1','-fPIE','-pie','-DF4_MONITOR_PARSER_ONLY','-I'+str(package),'-I'+str(ROOT/'tools/firmware/f4_ram_entry_02'),str(package/'entry.c'),str(parser),'-o',str(entry)]
 subprocess.run(command,check=True,cwd=ROOT)
 blobs={'entrytool':entry.read_bytes(),'observe.so':module.read_bytes(),'entry.sha256':(sha(entry.read_bytes())+'\n').encode()}
 for action in ('install','disable'):
  text=old.wrapper(action,not preview).replace('/run/iq4_f4_entry02','/run/iq4_f1_observe02');blobs[action+'.sh']=text.encode()
 # Only fixed public artifact staging strings are rewritten. Proof pathname
 # evidence is validated directly against new role paths by its own contract.
 stage_input=dict(blobs);stage_input['marker.so']=stage_input.pop('observe.so')
 plan=old.stage_plan(stage_input,not preview)
 for row in plan['commands']:row['text']=row['text'].replace('/run/iq4_f4_entry02','/run/iq4_f1_observe02').replace('/marker.so','/observe.so')
 if not preview:plan['expected_artifacts']= {n:{'bytes':len(b),'sha256':sha(b)}for n,b in blobs.items()}
 for name,b in blobs.items():(package/name).write_bytes(b)
 (package/'stage_commands.json').write_text(json.dumps(plan,indent=2)+'\n')
 receipt={'schema':'iq4_f1_observe_role_build_v2','preview_only':preview,'enabled_device_profile_emitted':not preview,'device_accessed':False,'target_executed':False,'User_modified':False,'persistent_profile':False,'hardware_recovery_verified_by_build':False,'UI_ready':False,'mask_enabled':False,'core_source_lock_sha256':'955a4cd2293031970bd41133217de435e5019aa843b5ab98d250ebd6a9505d10','module':r,'entrytool':old.elf_summary(entry),'candidate_runner_sha256':candidate_hash,'proof_sha256':None if preview else sha(args.proof.read_bytes()),'build_command':command,'actual_required_receipt_names':contract.REQUIRED,'public_artifacts':{n:{'bytes':len(b),'sha256':sha(b)}for n,b in blobs.items()},'stage_commands_count':len(plan['commands']),'no_signal_or_native_restart_command':True}
 (package/'build.json').write_text(json.dumps(receipt,indent=2)+'\n');print(json.dumps({'preview_only':preview,'entrytool_sha256':sha(entry.read_bytes()),'module_sha256':sha(module.read_bytes()),'stage_commands':len(plan['commands']),'target_executed':False}))
if __name__=='__main__':main()
