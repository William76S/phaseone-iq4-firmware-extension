#!/usr/bin/env python3
"""Owned synthetic contracts only. No target process or target code invoked."""
import copy,hashlib,json,struct
from pathlib import Path
import contract
from build_prepare import OUT
from decode_read import decode
from stager import stage_plan
from strip_elf import strip,tables
def main():
 build=json.loads((OUT/'BUILD_PREPARATION.json').read_text());candidate=build['authenticated_candidate'];tests=[]
 def reject(name,fn):
  try:fn()
  except (ValueError,AssertionError,KeyError):tests.append(name);return
  raise AssertionError('Fault accepted: '+name)
 original=Path(contract.ROOT/candidate['unstripped_path']).read_bytes();a,proof=strip(original);assert hashlib.sha256(a).hexdigest()==candidate['sha256']and proof['program_headers_identical'];tests.append('actual_strip_payload_and_header_exception')
 h,ph,sh=tables(original);bad=bytearray(original);struct.pack_into('<H',bad,18,62);reject('strip_wrong_machine',lambda:strip(bytes(bad)))
 bad=bytearray(original);struct.pack_into('<Q',bad,h[6]+64+8,0);reject('strip_nonalloc_gap',lambda:strip(bytes(bad)))
 c=contract.load_contract();sysroot=contract.ROOT
 import sys;sys.path.insert(0,str(contract.HERE.parent));from inspect_boot import Ext2
 runner={n['path']:b for n,b in Ext2((sysroot/'analysis/firmware/P1_ramdisk.ext2').read_bytes()).walk()}['/p1/scripts/boot_run_p1linux.sh']
 from f1_restore_baseline_03 import facts
 rows=[]
 for i in range(26):
  r={k:0 for k in facts.FIELDS};r.update(index=i,follow=False,rc=0,stable=True,dev_major=1,dev_minor=0,inode=100+i,mode=16877,nlink=1)
  if i>=14:r.update(rc=-1,errno=2,stable=False)
  rows.append(r)
 rows[3].update(dev_major=0,dev_minor=27);rows[8].update(inode=109,mode=33261,size=5105);rows[10].update(mode=33261,size=11874544)
 baseline={'schema':'iq4_f1_fixed_syscall_facts_v3','uid':0,'euid':0,'file_write_calls':0,'device_control_calls':0,'nodes':rows,'followed_alias_parents':[{**rows[i],'follow':True}for i in(4,5)],'runner_xattrs':{'fd_opened':True,'name_bytes':0,'errno':0,'stable':True,'attribute_values_read':False}}
 scratch={'action':'F1_scratch_inode_restore_probe','phase':'complete','errno':0,'scratch_created':True,'same_fs_restore_exact_inode_and_bytes':True,'cleanup_complete':True,'scratch_original_inode':501,'scratch_candidate_inode':502,'runner_modified':False,'User_modified':False,'EEP_access':False,'cold_recovery_verified':False}
 blobs={k:b'owned synthetic fixture only\n'for k in c.REQUIRED};blobs[contract.ADDITIONAL[0]]=(json.dumps(baseline)+'\n').encode();blobs[contract.ADDITIONAL[1]]=(json.dumps(scratch)+'\n').encode()
 p={k:True for k in c.REQUIRED};p.update(schema=contract.SCHEMA,profile=contract.PROFILE,camera_operator='root_windows_unique_executor',runner={'sha256':c.RUNNER_SHA,'size':5105,'uid':0,'gid':0,'mode':493,'major':1,'minor':0,'inode':109,'nlink':1,'xattrs':[]},user={'sha256':c.USER_SHA,'size':11874544,'uid':0,'gid':0,'mode':493,'canonical_path':'/mnt/qspi/User/p1linux','argv0':'/run/media/storage/User/p1linux','argv_tail':[],'pid':1001,'start_ticks':1002,'umask':18,'parent_ppid':1,'parent_exe':'/bin/busybox.nosuid','parent_argv':['/bin/sh','/p1/scripts/boot_run_p1linux.sh']},mount={'root_source':'/dev/ram0','root_fstype':'ext2','root_major':1,'root_minor':0,'cmdline_root':'/dev/ram0','run_fstype':'tmpfs','run_major':0,'run_minor':27,'root_mount_id':1,'run_mount_id':2},actual_absent_paths=['/run/f1launch','/run/iq4_f1_observe02','/p1/scripts/.iq4_f1_original02','/p1/scripts/.iq4_f1_candidate02'],display_source_sha256=contract.DISPLAY_SOURCE,display_default_off_so_sha256=contract.DEFAULT_SO,display_ctor_candidate_so_sha256=candidate['sha256'],loader_source_sha256='a'*64,observe_env='IQ4_F1_MODULE_ENTRY_01=OBSERVE',mask_enabled=False,paint_table_installation_authorized=False,UI_entry_installation_authorized=False,stager_codec='busybox_base64_no_padding_octal_tail_v1',scratch_parent={k:rows[2][k]for k in('dev_major','dev_minor','inode')},receipts={k:{'path':k,'sha256':contract.sha(v)}for k,v in blobs.items()})
 validate=lambda q:contract.validate(q,runner,runner,candidate['sha256'],'a'*64,lambda k:blobs[k]);validate(p);tests.append('new_identity_synthetic_contract_accepts_no_actual_claim')
 for name,changes in [('old_schema',{'schema':'iq4_f1_observe_role_gate_v2'}),('old_module',{'display_ctor_candidate_so_sha256':'7bae86db174637bfa0f88d8de7740d9811fee84dda23cc5e0d474be8036768ab'}),('UI_scope_widening',{'UI_entry_installation_authorized':True}),('no_stager_actual_gate',{'actual_base64_decoder_roundtrip_verified':False})]:
  q=copy.deepcopy(p);q.update(changes);reject(name,lambda q=q:validate(q))
 q=copy.deepcopy(p);q['receipts'][c.REQUIRED[0]]['sha256']='b'*64;reject('receipt_changed',lambda:validate(q))
 orig=blobs[contract.ADDITIONAL[0]];baseline['nodes'][22]['errno']=13;blobs[contract.ADDITIONAL[0]]=(json.dumps(baseline)+'\n').encode();q=copy.deepcopy(p);q['receipts'][contract.ADDITIONAL[0]]['sha256']=contract.sha(blobs[contract.ADDITIONAL[0]]);reject('EACCES_not_absence',lambda:validate(q));blobs[contract.ADDITIONAL[0]]=orig
 fixture=(sysroot/'analysis/firmware/f1_display_observe_build_06/host_normal_fixture.bin').read_bytes();sequence=struct.unpack_from('<I',fixture)[0]
 wire={'schema':'iq4_f1_display_copied_read_v6','pid':1001,'start_ticks':1002,'module_sha256':candidate['sha256'],'publication_va':0x100000+candidate['publication_va'],'publication_bytes':1440,'sequence':sequence,'first_hex':fixture.hex(),'second_hex':fixture.hex(),'firmware_calls':0,'target_memory_writes':0,'mask_enabled':False}
 decode(json.dumps(wire).encode(),candidate['sha256'],1001,1002);tests.append('exact_copied_record_decodes')
 for name,changes in [('pid_reused',{'start_ticks':1003}),('copied_extent',{'first_hex':'00'}),('odd_sequence',{'sequence':sequence|1}),('mask_flag',{'mask_enabled':True}),('old_SO_receipt',{'module_sha256':contract.DEFAULT_SO})]:
  q={**wire,**changes};reject(name,lambda q=q:decode(json.dumps(q).encode(),candidate['sha256'],1001,1002))
 b={'entrytool':bytes(range(256))*2,'observe.so':a,'entry.sha256':(hashlib.sha256(bytes(range(256))*2).hexdigest()+'\n').encode(),'install.sh':b'owned test install\n','disable.sh':b'owned test disable\n'};plan=stage_plan(b,True);assert all(len(r['text'].encode())<=242 and '='not in r['text']for r in plan['commands']);assert stage_plan(b,False)['commands']==[];tests.append('fixed_stager_limits_and_default_zero')
 q=dict(b);q['arbitrary.sh']=b'no';reject('arbitrary_stager_name',lambda:stage_plan(q,True))
 result={'schema':'iq4_f1_display_loader_owned_checks_v6','checks':tests,'passed':True,'actual_hardware_proofs_synthetic':False,'actual_target_executed':False,'SDK_or_camera_or_Windows_or_network_used':False,'stripped_SO_bytes':len(a),'stager_actual_SO_append_commands':sum(r['role'].startswith('append')and'/observe.so'in r['text']for r in plan['commands'])}
 (OUT/'LOCAL_CHECKS.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result))
if __name__=='__main__':main()
