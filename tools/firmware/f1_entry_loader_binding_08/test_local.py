#!/usr/bin/env python3
"""New identity, marker and 496B boundary-candidate fault fixtures. No target run."""
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
 p={k:True for k in c.REQUIRED};p.update(schema=contract.SCHEMA,profile=contract.PROFILE,camera_operator='root_windows_unique_executor',runner={'sha256':c.RUNNER_SHA,'size':5105,'uid':0,'gid':0,'mode':493,'major':1,'minor':0,'inode':109,'nlink':1,'xattrs':[]},user={'sha256':c.USER_SHA,'size':11874544,'uid':0,'gid':0,'mode':493,'canonical_path':'/mnt/qspi/User/p1linux','argv0':'/run/media/storage/User/p1linux','argv_tail':[],'pid':1001,'start_ticks':1002,'umask':18,'parent_ppid':1,'parent_exe':'/bin/busybox.nosuid','parent_argv':['/bin/sh','/p1/scripts/boot_run_p1linux.sh']},mount={'root_source':'/dev/ram0','root_fstype':'ext2','root_major':1,'root_minor':0,'cmdline_root':'/dev/ram0','run_fstype':'tmpfs','run_major':0,'run_minor':27,'root_mount_id':1,'run_mount_id':2},actual_absent_paths=['/run/f1launch','/run/iq4_f1_observe02','/p1/scripts/.iq4_f1_original02','/p1/scripts/.iq4_f1_candidate02'],display_source_sha256=contract.DISPLAY_SOURCE,display_default_off_so_sha256=contract.DEFAULT_SO,entry_source_sha256=contract.ENTRY_SOURCE,entry_observe_so_sha256=contract.ENTRY_SO,normal_fit_source_sha256=contract.NORMAL_SOURCE,entry_boundary_observation_only=True,native_text_hook_installation_authorized=False,provider_lease_authorized=False,loader_source_sha256='a'*64,observe_env='IQ4_F1_MODULE_ENTRY_01=OBSERVE',mask_enabled=False,paint_table_installation_authorized=False,UI_entry_installation_authorized=True,stager_codec='busybox_base64_no_padding_octal_tail_v1',entry_placement={'x':10,'y':20},scratch_parent={k:rows[2][k]for k in('dev_major','dev_minor','inode')},receipts={k:{'path':k,'sha256':contract.sha(v)}for k,v in blobs.items()})
 validate=lambda q:contract.validate(q,runner,runner,contract.ENTRY_SO,'a'*64,lambda k:blobs[k]);validate(p);tests.append('new_UI08_identity_synthetic_only')
 for name,changes in [('Loader07_schema',{'schema':'iq4_f1_entry_loader_gate_v7'}),('Loader07_profile',{'profile':'RAM_F1_entry_only_07'}),('wrong_UI08_source',{'entry_source_sha256':'b'*64}),('old_SO_identity',{'entry_observe_so_sha256':'a21b38e552377c9f93f69b01f52a7ebc70f6c89eff25c3a4a316af559f535b81'}),('native_text_scope',{'native_text_hook_installation_authorized':True}),('provider_lease_scope',{'provider_lease_authorized':True}),('normal_source_identity',{'normal_fit_source_sha256':'b'*64}),('no_native_UI_admission',{'UI_entry_installation_authorized':False}),('paint_scope_widening',{'paint_table_installation_authorized':True}),('mask_scope_widening',{'mask_enabled':True}),('no_constructor_registry_gate',{'ui08_native_entry_source_and_constructor_registry_reviewed':False}),('no_placement_input_lifetime_gate',{'ui08_actual_button_placement_input_route_and_retained_lifetime_verified':False}),('coordinate_bool',{'entry_placement':{'x':True,'y':0}}),('coordinate_negative',{'entry_placement':{'x':-1,'y':0}}),('coordinate_unbounded',{'entry_placement':{'x':4097,'y':0}}),('coordinate_extra',{'entry_placement':{'x':0,'y':0,'raw_command':'no'}})]:
  q=copy.deepcopy(p);q.update(changes);reject(name,lambda q=q:validate(q))
 # Own fresh data-only publication. This is not copied from a running User.
 fixture=bytearray(496);struct.pack_into('<8IQ',fixture,0,0,496,8,328,0,0,0,0,0)
 wire={'schema':'iq4_f1_entry_copied_read_v8','pid':1001,'start_ticks':1002,'module_sha256':contract.ENTRY_SO,'publication_va':0x100000+287208,'publication_bytes':496,'sequence':0,'first_hex':fixture.hex(),'second_hex':fixture.hex(),'firmware_calls':0,'target_memory_writes':0,'mask_enabled':False}
 decode(json.dumps(wire).encode(),1001,1002);tests.append('fixed_UI08_496B_disabled_fixture')
 boundary=bytearray(fixture);struct.pack_into('<I',boundary,16,14)
 struct.pack_into('<8Q',boundary,40,0x10000,0x20000,0x30008,0x40000,0x30000,0x50000,0x60000,0)
 struct.pack_into('<4i',boundary,180,0,0,1280,720);struct.pack_into('<2f',boundary,212,.5,.5)
 struct.pack_into('<Q',boundary,280,0x70000);struct.pack_into('<6I',boundary,288,0x91002000,0xd65f03c0,0,0,0,0);struct.pack_into('<2I',boundary,328,2,0)
 good={**wire,'first_hex':boundary.hex(),'second_hex':boundary.hex()};answer=decode(json.dumps(good).encode(),1001,1002);assert answer['result']=='BoundaryObserved'and not answer['surface_lease_verified'];tests.append('BoundaryObserved_inline_candidate_without_token')
 for name,off,fmt,value in [('claimed_paint',104,'Q',1),('claimed_full_source',120,'i',640),('claimed_write',264,'i',1),('claimed_raw_native_return',480,'I',1),('claimed_emitted',20,'I',1),('callback_result',16,'I',13),('unsupported_getter',288,'I',0xf9400000),('wrong_Surface_alias',56,'Q',0x30010),('unread_word_count',328,'I',3)]:
  bad=bytearray(boundary);struct.pack_into('<'+fmt,bad,off,value);q={**good,'first_hex':bad.hex(),'second_hex':bad.hex()};reject(name,lambda q=q:decode(json.dumps(q).encode(),1001,1002))

 for name,changes in [('old_display_schema',{'schema':'iq4_f1_display_copied_read_v6'}),('old_104B_extent',{'publication_bytes':104}),('PID_reused',{'start_ticks':1003}),('old_SO_copy',{'module_sha256':'e8636541a1b81be6cdfe4e1f2832a372f17a3f62d5b0536f033534e708cab306'}),('truncated_copy',{'first_hex':'00'}),('sequence_odd',{'sequence':1}),('claimed_mask',{'mask_enabled':True})]:
  q={**wire,**changes};reject(name,lambda q=q:decode(json.dumps(q).encode(),1001,1002))
 module=contract.ROOT/json.loads((OUT/'BUILD_PREPARATION.json').read_text())['entry_observe_so']['path'];entry=bytes(range(256))*2
 marker=b'IQ4_F1_UI08_ENTRY_OBSERVE_ONLY 10 20\n';b={'entrytool':entry,'observe.so':module.read_bytes(),'entry.sha256':(contract.sha(entry)+'\n').encode(),'install.sh':b'OWNED TEST ONLY\n','disable.sh':b'OWNED TEST ONLY\n','ui08.entry':marker}
 plan=stage_plan(b,True);assert stage_plan(b,False)['commands']==[]and all(len(r['text'].encode())<=242 and '='not in r['text']for r in plan['commands']);assert any('chmod 600 /run/iq4_f1_observe02/ui08.entry'in r['text']for r in plan['commands']);tests.append('fixed_six_file_marker_mode_and_242B_plan')
 q=dict(b);del q['ui08.entry'];reject('missing_UI_marker_file',lambda:stage_plan(q,True))
 from generate import bind_stage_identity
 source=json.loads((OUT/'BUILD_PREPARATION.json').read_text())['entry_observe_so'];metadata=bind_stage_identity({},source)
 assert metadata['entry_publication_bytes']==source['publication_bytes']==496 and metadata['entry_publication_relative_va']==source['publication_va']==287208 and metadata['UI_objects_registry_mutation_authorized']and not metadata['native_pixel_write_authorized'];tests.append('plan_reader_actual_SO_publication_scope_exact')
 for name,changes in [('plan_old_104_extent',{'publication_bytes':104}),('plan_old_SO_SHA',{'sha256':'a21b38e552377c9f93f69b01f52a7ebc70f6c89eff25c3a4a316af559f535b81'}),('plan_old_publication_VA',{'publication_va':281200})]:
  q={**source,**changes};reject(name,lambda q=q:bind_stage_identity({},q))
 result={'schema':'iq4_f1_entry_loader_owned_checks_v8','passed':True,'checks':tests,'actual_proof_created':False,'actual_UI_or_module_loaded':False,'mask_enabled':False,'device_or_SDK_or_Windows_or_network_used':False,'actual_SO_bytes':module.stat().st_size,'SO_append_commands':sum(r['role'].startswith('append')and'/observe.so'in r['text']for r in plan['commands'])}
 (OUT/'LOCAL_CHECKS.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result))
if __name__=='__main__':main()
