#!/usr/bin/env python3
"""New identity, marker and 104B copied-status fault fixtures. No target run."""
import copy,json,struct,sys
import contract
from build_prepare import OUT
from decode_read import decode
from stager import stage_plan
def main():
 tests=[]
 def reject(name,fn):
  try:fn()
  except(ValueError,AssertionError,KeyError):tests.append(name);return
  raise AssertionError('Fault accepted: '+name)
 c=contract.load_contract();sys.path.insert(0,str(contract.HERE.parent));from inspect_boot import Ext2
 from f1_restore_baseline_03 import facts
 runner={n['path']:b for n,b in Ext2((contract.ROOT/'analysis/firmware/P1_ramdisk.ext2').read_bytes()).walk()}['/p1/scripts/boot_run_p1linux.sh']
 rows=[]
 for i in range(26):
  r={k:0 for k in facts.FIELDS};r.update(index=i,follow=False,rc=0,stable=True,dev_major=1,dev_minor=0,inode=100+i,mode=16877,nlink=1)
  if i>=14:r.update(rc=-1,errno=2,stable=False)
  rows.append(r)
 rows[3].update(dev_major=0,dev_minor=27);rows[8].update(inode=109,mode=33261,size=5105);rows[10].update(mode=33261,size=11874544)
 baseline={'schema':'iq4_f1_fixed_syscall_facts_v3','uid':0,'euid':0,'file_write_calls':0,'device_control_calls':0,'nodes':rows,'followed_alias_parents':[{**rows[i],'follow':True}for i in(4,5)],'runner_xattrs':{'fd_opened':True,'name_bytes':0,'errno':0,'stable':True,'attribute_values_read':False}}
 scratch={'action':'F1_scratch_inode_restore_probe','phase':'complete','errno':0,'scratch_created':True,'same_fs_restore_exact_inode_and_bytes':True,'cleanup_complete':True,'scratch_original_inode':501,'scratch_candidate_inode':502,'runner_modified':False,'User_modified':False,'EEP_access':False,'cold_recovery_verified':False}
 blobs={k:b'OWNED SYNTHETIC ONLY; no actual gate evidence\n'for k in c.REQUIRED};blobs[contract.ADDITIONAL[0]]=(json.dumps(baseline)+'\n').encode();blobs[contract.ADDITIONAL[1]]=(json.dumps(scratch)+'\n').encode()
 p={k:True for k in c.REQUIRED};p.update(schema=contract.SCHEMA,profile=contract.PROFILE,camera_operator='root_windows_unique_executor',runner={'sha256':c.RUNNER_SHA,'size':5105,'uid':0,'gid':0,'mode':493,'major':1,'minor':0,'inode':109,'nlink':1,'xattrs':[]},user={'sha256':c.USER_SHA,'size':11874544,'uid':0,'gid':0,'mode':493,'canonical_path':'/mnt/qspi/User/p1linux','argv0':'/run/media/storage/User/p1linux','argv_tail':[],'pid':1001,'start_ticks':1002,'umask':18,'parent_ppid':1,'parent_exe':'/bin/busybox.nosuid','parent_argv':['/bin/sh','/p1/scripts/boot_run_p1linux.sh']},mount={'root_source':'/dev/ram0','root_fstype':'ext2','root_major':1,'root_minor':0,'cmdline_root':'/dev/ram0','run_fstype':'tmpfs','run_major':0,'run_minor':27,'root_mount_id':1,'run_mount_id':2},actual_absent_paths=['/run/f1launch','/run/iq4_f1_observe02','/p1/scripts/.iq4_f1_original02','/p1/scripts/.iq4_f1_candidate02'],display_source_sha256=contract.DISPLAY_SOURCE,display_default_off_so_sha256=contract.DEFAULT_SO,entry_source_sha256=contract.ENTRY_SOURCE,entry_only_so_sha256=contract.ENTRY_SO,loader_source_sha256='a'*64,observe_env='IQ4_F1_MODULE_ENTRY_01=OBSERVE',mask_enabled=False,paint_table_installation_authorized=False,UI_entry_installation_authorized=True,stager_codec='busybox_base64_no_padding_octal_tail_v1',entry_placement={'x':10,'y':20},scratch_parent={k:rows[2][k]for k in('dev_major','dev_minor','inode')},receipts={k:{'path':k,'sha256':contract.sha(v)}for k,v in blobs.items()})
 validate=lambda q:contract.validate(q,runner,runner,contract.ENTRY_SO,'a'*64,lambda k:blobs[k]);validate(p);tests.append('new_UI07_identity_synthetic_only')
 for name,changes in [('Loader06_schema',{'schema':'iq4_f1_display_loader_gate_v6'}),('Loader06_profile',{'profile':'RAM_F1_display_observe_once'}),('wrong_UI07_source',{'entry_source_sha256':'b'*64}),('old_SO_identity',{'entry_only_so_sha256':'e8636541a1b81be6cdfe4e1f2832a372f17a3f62d5b0536f033534e708cab306'}),('no_native_UI_admission',{'UI_entry_installation_authorized':False}),('paint_scope_widening',{'paint_table_installation_authorized':True}),('mask_scope_widening',{'mask_enabled':True}),('no_constructor_registry_gate',{'ui07_native_entry_source_and_constructor_registry_reviewed':False}),('no_placement_input_lifetime_gate',{'ui07_actual_button_placement_input_route_and_retained_lifetime_verified':False}),('coordinate_bool',{'entry_placement':{'x':True,'y':0}}),('coordinate_negative',{'entry_placement':{'x':-1,'y':0}}),('coordinate_unbounded',{'entry_placement':{'x':4097,'y':0}}),('coordinate_extra',{'entry_placement':{'x':0,'y':0,'raw_command':'no'}})]:
  q=copy.deepcopy(p);q.update(changes);reject(name,lambda q=q:validate(q))
 # Own fresh data-only publication. This is not copied from a running User.
 values=(7,96,3,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0);fixture=struct.pack('<II6I6Q6I',0,104,*values)
 wire={'schema':'iq4_f1_entry_copied_read_v7','pid':1001,'start_ticks':1002,'module_sha256':contract.ENTRY_SO,'publication_va':0x100000+281200,'publication_bytes':104,'sequence':0,'first_hex':fixture.hex(),'second_hex':fixture.hex(),'firmware_calls':0,'target_memory_writes':0,'mask_enabled':False}
 decode(json.dumps(wire).encode(),1001,1002);tests.append('fixed_UI07_104B_copied_fixture')
 for name,changes in [('old_display_schema',{'schema':'iq4_f1_display_copied_read_v6'}),('old_1440B_extent',{'publication_bytes':1440}),('PID_reused',{'start_ticks':1003}),('old_SO_copy',{'module_sha256':'e8636541a1b81be6cdfe4e1f2832a372f17a3f62d5b0536f033534e708cab306'}),('truncated_copy',{'first_hex':'00'}),('sequence_odd',{'sequence':1}),('claimed_mask',{'mask_enabled':True})]:
  q={**wire,**changes};reject(name,lambda q=q:decode(json.dumps(q).encode(),1001,1002))
 module=contract.ROOT/json.loads((OUT/'BUILD_PREPARATION.json').read_text())['entry_only_so']['path'];entry=bytes(range(256))*2
 marker=b'IQ4_F1_UI07_ENTRY_ONLY 10 20\n';b={'entrytool':entry,'observe.so':module.read_bytes(),'entry.sha256':(contract.sha(entry)+'\n').encode(),'install.sh':b'OWNED TEST ONLY\n','disable.sh':b'OWNED TEST ONLY\n','ui07.entry':marker}
 plan=stage_plan(b,True);assert stage_plan(b,False)['commands']==[]and all(len(r['text'].encode())<=242 and '='not in r['text']for r in plan['commands']);assert any('chmod 600 /run/iq4_f1_observe02/ui07.entry'in r['text']for r in plan['commands']);tests.append('fixed_six_file_marker_mode_and_242B_plan')
 q=dict(b);del q['ui07.entry'];reject('missing_UI_marker_file',lambda:stage_plan(q,True))
 result={'schema':'iq4_f1_entry_loader_owned_checks_v7','passed':True,'checks':tests,'actual_proof_created':False,'actual_UI_or_module_loaded':False,'mask_enabled':False,'device_or_SDK_or_Windows_or_network_used':False,'actual_SO_bytes':module.stat().st_size,'SO_append_commands':sum(r['role'].startswith('append')and'/observe.so'in r['text']for r in plan['commands'])}
 (OUT/'LOCAL_CHECKS.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result))
if __name__=='__main__':main()
