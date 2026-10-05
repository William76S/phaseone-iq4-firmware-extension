#!/usr/bin/env python3
"""Local package generator, default inert. Never transport/load/execute camera.

Enabled RAM marker output needs exact original runner copies plus the Root's
actual identity/read/recovery receipts. User is not modified; its full-file
hash/execution baseline is required, full User originals are optional here.
Persistent User modification remains a separate disabled scope.
"""
from pathlib import Path
import argparse
import hashlib
import json
import os
import re
import shutil
import struct
import subprocess
import sys

ROOT=Path(__file__).resolve().parents[3]
SOURCE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f4_ram_entry_02'
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
ZIG_SHA='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
RUNNER_SHA='fe57b899f3a583e1058e4e856cf80704d902d6989b802154d02e77bc93305e88'
USER_SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
OLD=b'    ${P1LINUX_PATH} ${P1LINUX_ARGS}\n'
NEW=b'    /run/f4launch   ${P1LINUX_ARGS}\n'
REQUIRED=[
 'root_review_completed','readonly_sys_transport_complete','eeprom_double_original_complete',
 'actual_user_hash_and_executable_verified','runner_double_original_complete','private_backup_acl_verified',
 'actual_ram_root_verified','no_persistent_covering_mount','tmpfs_exec_verified',
 'actual_tools_hashes_and_supported_options_verified','native_user_exit_stock_respawn_verified',
 'cold_boot_original_runner_verified','independent_probe_after_sdk_close_verified',
 'original_argv_environment_and_umask_restart_baseline_verified','runner_no_xattrs_verified',
 'foreign_debug_upgrade_respawn_flags_absent','constructor_marker_source_reviewed',
 'same_fs_hardlink_atomic_rename_fsync_probe_verified',
]

def sha(b): return hashlib.sha256(b).hexdigest()
def dump(path,j): path.write_text(json.dumps(j,ensure_ascii=False,indent=2)+'\n')
def integer(v,low,high): return type(v) is int and low<=v<=high
def hexsha(v): return type(v) is str and re.fullmatch('[0-9a-f]{64}',v) and v!='0'*64
def exact_fields(value,expected):
 return isinstance(value,dict) and all(type(value.get(k)) is type(v) and value[k]==v for k,v in expected.items())

def validate_proof(proof,runner_a,runner_b,receipt_loader):
 if not isinstance(proof,dict) or proof.get('schema')!='iq4_f4_ram_gate_v2':raise ValueError('Unknown proof schema')
 if proof.get('profile')!='RAM_marker_once':raise ValueError('Only RAM marker one-shot is implemented')
 if any(type(proof.get(k)) is not bool or not proof[k] for k in REQUIRED):raise ValueError('Actual gate evidence incomplete; enabled output refused')
 if proof.get('camera_operator')!='root_windows_unique_executor':raise ValueError('Single executor identity absent')
 runner=proof.get('runner',{}); user=proof.get('user',{}); mount=proof.get('mount',{})
 if runner_a!=runner_b or sha(runner_a)!=RUNNER_SHA or len(runner_a)!=5105:raise ValueError('Exact original runner copies differ')
 if not exact_fields(runner,{'sha256':RUNNER_SHA,'size':5105,'uid':0,'gid':0,'mode':493,'major':1,'minor':0,'xattrs':[]}):raise ValueError('Runner metadata/hash not exact')
 if not integer(runner.get('inode'),1,2**64-1) or not integer(runner.get('nlink'),1,1):raise ValueError('Runner inode/nlink invalid')
 if not exact_fields(user,{'sha256':USER_SHA,'size':11874544,'uid':0,'gid':0,'mode':493}):raise ValueError('User metadata/hash not exact')
 if user.get('canonical_path')!='/mnt/qspi/User/p1linux' or user.get('argv0')!='/run/media/storage/User/p1linux' or user.get('argv_tail')!=[]:raise ValueError('Original User argv/path unsupported')
 if not integer(user.get('pid'),2,10000000) or not integer(user.get('start_ticks'),1,2**64-1) or not integer(user.get('umask'),0,511):raise ValueError('Actual User PID/start ticks/umask invalid')
 if user.get('parent_ppid')!=1 or user.get('parent_exe')!='/bin/busybox.nosuid' or user.get('parent_argv')!=['/bin/sh','/p1/scripts/boot_run_p1linux.sh']:raise ValueError('Stock init runner parent contract unverified')
 if mount.get('root_source') not in ['/dev/ram0','/dev/root'] or mount.get('root_fstype') not in ['ext2','ext4'] or not exact_fields(mount,{'root_major':1,'root_minor':0,'cmdline_root':'/dev/ram0'}):raise ValueError('Actual RAM root not supported')
 if mount.get('run_fstype')!='tmpfs' or mount.get('run_major')!=0 or not integer(mount.get('run_minor'),1,2**20):raise ValueError('Actual tmpfs identity absent')
 for k in ['root_mount_id','run_mount_id']:
  if not integer(mount.get(k),1,2**31-1):raise ValueError('Actual mount IDs absent')
 expected=['/run/f4launch','/run/iq4_f4_entry02','/p1/scripts/.iq4_f4_original02','/p1/scripts/.iq4_f4_candidate02']
 paths=proof.get('actual_absent_paths')
 if type(paths) is not list or any(type(v) is not str for v in paths) or sorted(paths)!=sorted(expected):raise ValueError('Owned new paths not proven absent')
 receipts=proof.get('receipts')
 if not isinstance(receipts,dict) or set(receipts)!=set(REQUIRED):raise ValueError('Every actual gate needs an independent receipt')
 for name,r in receipts.items():
  if not isinstance(r,dict) or not hexsha(r.get('sha256')) or not isinstance(r.get('path'),str):raise ValueError('Receipt descriptor invalid')
  b=receipt_loader(r['path'])
  if sha(b)!=r['sha256']:raise ValueError('Receipt bytes changed: '+name)
  # Generator validates provenance bytes; Root must establish their actual
  # device meaning. It does not make host-authored booleans into hardware facts.
 return proof

def c_config(preview,proof,module_hash,candidate_hash):
 text=(SOURCE/'config.preview.h').read_text()
 text=text.replace('F4_MODULE_SHA "'+'0'*64+'"','F4_MODULE_SHA "'+module_hash+'"')
 text=text.replace('F4_CANDIDATE_SHA "'+'0'*64+'"','F4_CANDIDATE_SHA "'+candidate_hash+'"')
 if not preview:
  user=proof['user'];runner=proof['runner'];mount=proof['mount']
  values={'F4_ENABLED':1,'F4_RUNNER_INODE':str(runner['inode'])+'ULL',
   'F4_ROOT_MOUNT_ID':str(mount['root_mount_id'])+'U','F4_RUN_MOUNT_ID':str(mount['run_mount_id'])+'U',
   'F4_RUN_MINOR':str(mount['run_minor'])+'U','F4_OLD_PID':str(user['pid'])+'ULL',
   'F4_OLD_TICKS':str(user['start_ticks'])+'ULL','F4_USER_UMASK':'0'+format(user['umask'],'o')+'U'}
  for k,v in values.items():text=re.sub(r'^#define '+k+r' .+$','#define '+k+' '+str(v),text,flags=re.M)
 return text

def elf_summary(path):
 b=path.read_bytes()
 if b[:6]!=b'\x7fELF\x02\x01' or struct.unpack_from('<H',b,18)[0]!=183:raise ValueError('Not AArch64 ELF64 little')
 return {'bytes':len(b),'sha256':sha(b),'ELF_type':struct.unpack_from('<H',b,16)[0],
         'machine':183,'target_executed':False}

def stage_plan(blobs,enabled):
 # This is a finite artifact-only plan. No arbitrary command parameter, URL,
 # firmware/property/EEPROM path or live payload is accepted. Actual execution
 # must separately revalidate Root's lease/identity/mounts and actual ACK+EOF.
 if not enabled:return {'enabled':False,'commands':[],'reason':'actual device and recovery gates incomplete'}
 if set(blobs)!={'entrytool','marker.so','entry.sha256','install.sh','disable.sh'}:raise ValueError('Only five fixed public artifacts are accepted')
 for name,b in blobs.items():
  if not isinstance(b,bytes) or not b or len(b)>1048576:raise ValueError('Public artifact extent invalid')
 if not re.fullmatch(b'[0-9a-f]{64}\n',blobs['entry.sha256']) or blobs['entry.sha256'][:-1]!=sha(blobs['entrytool']).encode():raise ValueError('Public entry digest must match actual ELF')
 commands=[]
 def add(command,role):
  text='"Sys '+command+'"'
  if len(text.encode())>242 or '\n' in text or '\x00' in text or '=' in text:raise ValueError('Native lexer bound/equals invariant')
  commands.append({'text':text,'role':role,'max_source_bytes':242})
 add('mkdir -m 700 /run/iq4_f4_entry02','create_owned_tmpfs_directory_no_p')
 for name,b in blobs.items():
  if not re.fullmatch('[a-z0-9_.]+',name):raise ValueError('Unowned artifact name')
  path='/run/iq4_f4_entry02/'+name
  add("printf '' >"+path,'create_new_public_artifact_after_empty_dir_verification')
  for off in range(0,len(b),32):
   octal=''.join('\\%03o'%v for v in b[off:off+32])
   add("printf '"+octal+"' >>"+path,'append_fixed_owned_public_artifact')
  add('sha256sum '+path,'read_actual_whole_sha_after_complete_EOF')
  add('chmod '+('600' if name=='entry.sha256' else '500')+' '+path,'set_fixed_owned_artifact_mode')
 add('/run/iq4_f4_entry02/entrytool --stage-launcher','link_new_launcher_atomic_no_runner_change')
 add('/run/iq4_f4_entry02/entrytool --preflight','all_actual_runtime_gates_again_no_runner_change')
 return {'enabled':True,'commands':commands,'expected_artifacts':{n:{'bytes':len(b),'sha256':sha(b)} for n,b in blobs.items()},
         'numeric_exit_is_not_assumed':True,'each_private_directory_file_metadata_and_final_hash_must_be_verified':True,
         'only_public_build_artifacts_no_device_credentials':True,'network_staging':'not generated; no proven total-timeout bootstrap driver'}

def wrapper(mode,enabled):
 if mode not in ['install','disable']:raise ValueError('Unknown wrapper')
 action='--arm' if mode=='install' else '--disable'
 return '#!/bin/sh\nset -eu\n# Default is preflight. Never stops/signals User.\nENABLED='+('1' if enabled else '0')+'\ncase "${1:---preflight}" in\n  --preflight) exec /run/iq4_f4_entry02/entrytool --preflight ;;\n  '+action+') [ "$ENABLED" -eq 1 ] || { echo preview-only; exit 2; }; exec /run/iq4_f4_entry02/entrytool '+action+' ;;\n  *) echo unsupported-mode; exit 2 ;;\nesac\n'

def main():
 a=argparse.ArgumentParser();a.add_argument('--emit-enabled',action='store_true');a.add_argument('--proof',type=Path);a.add_argument('--runner-a',type=Path);a.add_argument('--runner-b',type=Path);a.add_argument('--user-a',type=Path);a.add_argument('--user-b',type=Path);args=a.parse_args()
 if sha(ZIG.read_bytes())!=ZIG_SHA:raise SystemExit('Unknown toolchain; no build')
 if subprocess.check_output([str(ZIG),'version'],text=True).strip()!='0.15.2':raise SystemExit('Unknown toolchain version')
 preview=not args.emit_enabled;proof=None
 sys.path.insert(0,str(ROOT/'tools/firmware'));from inspect_boot import Ext2
 disk=ROOT/'analysis/firmware/P1_ramdisk.ext2'
 if sha(disk.read_bytes())!='2ca2a497fb22cb3b16009f5dab2aad1f744982aaafb6c928ac688c0a3f9dbccb':raise SystemExit('Unknown static ramdisk')
 runner={n['path']:b for n,b in Ext2(disk.read_bytes()).walk()}['/p1/scripts/boot_run_p1linux.sh']
 if not preview:
  if not all([args.proof,args.runner_a,args.runner_b]):raise SystemExit('Enabled RAM output needs actual proof and two complete runner original files')
  paths=[p.resolve() for p in [args.runner_a,args.runner_b]]
  if len(set(paths))!=2 or args.runner_a.stat().st_ino==args.runner_b.stat().st_ino:raise SystemExit('Independent runner originals required')
  if bool(args.user_a)!=bool(args.user_b):raise SystemExit('Optional User originals must be two complete independent files')
  if args.user_a:
   if args.user_a.resolve()==args.user_b.resolve() or args.user_a.stat().st_ino==args.user_b.stat().st_ino:raise SystemExit('Optional User originals are not independent')
   ua=args.user_a.read_bytes();ub=args.user_b.read_bytes()
   if ua!=ub or len(ua)!=11874544 or sha(ua)!=USER_SHA:raise SystemExit('Optional complete User originals differ/unknown')
  proof=json.loads(args.proof.read_text());runner=args.runner_a.read_bytes()
  def receipt(rel):
   p=(ROOT/rel).resolve()
   if not p.is_relative_to(ROOT) or not p.is_file() or p.stat().st_size>1048576:raise ValueError('Receipt outside project/overlong')
   return p.read_bytes()
  validate_proof(proof,runner,args.runner_b.read_bytes(),receipt)
 if sha(runner)!=RUNNER_SHA or runner.count(OLD)!=1 or len(OLD)!=len(NEW):raise SystemExit('Exact runner unsupported')
 candidate=runner.replace(OLD,NEW);candidate_hash=sha(candidate)
 OUT.mkdir(exist_ok=True);(OUT/'.gitignore').write_text('*.elf\n*.o\n.zig-cache/\nenabled_package/\n')
 package=OUT/('preview_package' if preview else 'enabled_package');package.mkdir(exist_ok=True)
 env=dict(os.environ);env['ZIG_GLOBAL_CACHE_DIR']=str(OUT/'.zig-cache/global');env['ZIG_LOCAL_CACHE_DIR']=str(OUT/'.zig-cache/local')
 base=[str(ZIG),'cc','-target','aarch64-linux-gnu.2.17','-std=c11','-O2','-Wall','-Wextra','-Werror','-Wl,--build-id=sha1']
 module=package/'marker.elf';subprocess.run([*base,'-shared','-fPIC',str(SOURCE/'marker.c'),'-o',str(module)],check=True,env=env)
 module_summary=elf_summary(module)
 config=c_config(preview,proof,module_summary['sha256'],candidate_hash);(package/'config.h').write_text(config)
 entry=package/'entry.elf';parser=ROOT/'tools/firmware/f4_ram_entry_01/readonly_monitor.c'
 subprocess.run([*base,'-fPIE','-pie','-DF4_MONITOR_PARSER_ONLY','-I'+str(package),str(SOURCE/'entry.c'),str(parser),'-o',str(entry)],check=True,env=env)
 entry_summary=elf_summary(entry)
 facts=package/'readonly_facts.elf'
 subprocess.run([*base,'-Wno-unused-function','-fPIE','-pie','-I'+str(package),str(SOURCE/'readonly_facts.c'),'-o',str(facts)],check=True,env=env)
 facts_summary=elf_summary(facts)
 (package/'install.sh').write_text(wrapper('install',not preview));(package/'disable.sh').write_text(wrapper('disable',not preview))
 blobs={'entrytool':entry.read_bytes(),'marker.so':module.read_bytes(),'entry.sha256':(entry_summary['sha256']+'\n').encode(),
        'install.sh':(package/'install.sh').read_bytes(),'disable.sh':(package/'disable.sh').read_bytes()}
 dump(package/'stage_commands.json',stage_plan(blobs,not preview))
 dump(package/'profile_requirements.json',{
  'schema':'iq4_f4_modified_scope_gates_v2','actual_booleans_default':False,
  'readonly_monitor':{'enabled':False,'modifies':['new_private_RAM_probe_and_bounded_output'],
   'required':['actual_User_full_file_hash_and_PID_start_ticks','actual_private_RAM_mount_and_paths','source_and_target_hash','bounded_readonly_process_and_inherited_fds','actual_SDK_close_independence_and_finite_exit'],'User_full_original_required':False},
  'RAM_marker_once':{'enabled':not preview,'modifies':['RAM_runner_equal_length_line','new_private_RAM_files_and_IPC'],
   'required':REQUIRED,'User_full_original_required':False,'runner_complete_double_original_required':True,
   'User_identity_full_file_hash_required':True,'User_file_modified':False},
  'persistent_deployment':{'enabled':False,'implementation':'not provided by this package',
   'required':['all_actual_RAM_acceptance','complete_device_originals_of_every_modified_User_or_config','independent_restore_outside_modified_User','verified_disable_coldboot_restore','exact_version_installable_package'],'User_full_original_required_if_modified':True}})
 receipt={'schema':'iq4_f4_ram_build_v2','preview_only':preview,'enabled_device_profile_emitted':not preview,
  'sources':{str(p.relative_to(ROOT)):sha(p.read_bytes()) for p in sorted(SOURCE.iterdir()) if p.is_file()},
  'frozen_parser_reference':{'path':str(parser.relative_to(ROOT)),'sha256':sha(parser.read_bytes())},
  'toolchain_sha256':ZIG_SHA,'module':module_summary,'entry':entry_summary,
  'independent_readonly_facts':facts_summary,'readonly_facts_not_in_mutation_stage_plan':True,
  'config_sha256':sha(config.encode()),'runner_original_sha256':RUNNER_SHA,'candidate_sha256':candidate_hash,
  'candidate_full_script_generated':False,'stage_command_count':len(json.loads((package/'stage_commands.json').read_text())['commands']),
  'device_accessed':False,'target_executed':False,'native_user_exit_or_recovery_verified_by_this_build':False,
  'user_signal_or_automatic_restart_command_generated':False}
 receipt['User_full_originals_optional_provided']=bool(args.user_a and args.user_b)
 dump(package/'build.json',receipt);print(json.dumps({'preview_only':preview,'entry_sha256':entry_summary['sha256'],'marker_sha256':module_summary['sha256'],'stage_commands':receipt['stage_command_count']}))

if __name__=='__main__':main()
