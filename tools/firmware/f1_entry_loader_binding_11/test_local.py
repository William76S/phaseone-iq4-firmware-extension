#!/usr/bin/env python3
"""Six new identity/wire/package checks on owned bytes only."""
import base64,copy,hashlib,json,re,struct
import contract,decode_read,decode_preparation,emit_hook_inputs
from build_prepare import ROOT,HERE,OUT
from generate import bind_stage_identity,blobs_for
from stager import stage_plan
def reject(fn):
 try:fn()
 except(ValueError,AssertionError,TypeError,KeyError):return
 raise AssertionError('Expected refusal')
def envelope(b,preparation=False):
 return {'schema':'iq4_f1_'+('preparation'if preparation else'entry')+'_copied_read_v11','pid':101,'start_ticks':201,'module_sha256':contract.ENTRY_SO,'publication_va':0x10000000+(308552 if preparation else 308056),'publication_bytes':len(b),'sequence':struct.unpack_from('<I',b)[0],'first_hex':b.hex(),'second_hex':b.hex(),'firmware_calls':0,'target_memory_writes':0,'mask_state_not_inferred':True}
def main():
 b=json.loads((OUT/'BUILD_PREPARATION.json').read_text());source=b['entry_observe_so'];checks=[]
 assert b['embedded_controller']and b['prep_only']and not b['actual_loaded'];assert source['sha256']==contract.ENTRY_SO and source['bytes']==118080
 assert bind_stage_identity({},source)['preparation_publication_bytes']==192
 for key,value in [('publication_bytes',104),('publication_va',287208),('sha256','e569a6c391a4e3d37439d32f774f74dede3c1863d751250d2939abfaaa935f99')]:
  bad=copy.deepcopy(source);bad[key]=value;reject(lambda:bind_stage_identity({},bad))
 checks.append('exact_SO_three_publications_old_identity_refused')
 entry=ROOT/b['preview_launcher_path'];module=ROOT/source['path'];blobs=blobs_for(entry,module,False);plan=stage_plan(blobs,True)
 assert len(blobs)==5 and stage_plan(blobs,False)['commands']==[] and plan['controller_embedded_in_entrytool']
 rebuilt={};last=None
 for row in plan['commands']:
  text=row['text'];assert len(text.encode())<=242 and '='not in text and '\n'not in text
  c=text[5:-1]
  m=re.fullmatch(r"printf '' >(.+)",c)
  if m:rebuilt[m[1]]=bytearray();continue
  m=re.fullmatch(r"printf '([^']*)' \| base64 -d >>(.+) && wc -c <(.+)",c)
  if m:
   assert m[2]==m[3];rebuilt[m[2]]+=base64.b64decode(m[1],validate=True);assert len(rebuilt[m[2]])==row['expected_file_bytes'];continue
  m=re.fullmatch(r"printf '((?:\\[0-7]{3})+)' >>(.+) && wc -c <(.+)",c)
  if m:
   assert m[2]==m[3];rebuilt[m[2]]+=bytes(int(v,8)for v in re.findall(r'\\([0-7]{3})',m[1]));assert len(rebuilt[m[2]])==row['expected_file_bytes']
 assert {p.rsplit('/',1)[1]:bytes(data)for p,data in rebuilt.items()}==blobs
 assert [r['role']for r in plan['commands'][-3:]]==['guarded_creation_of_config_bound_marker_no_extra_staged_file','same_fs_link_launcher_no_runner_change','recheck_current_actual_identity_before_runner_change']
 reject(lambda:stage_plan(dict(blobs,controller=b'\x7fELF'),True));checks.append('five_files_complete_reconstruction_242_byte_bound_marker_before_launcher')
 raw=bytearray(496);struct.pack_into('<8I',raw,0,0,496,10,328,0,0,0,0);decoded=decode_read.decode(json.dumps(envelope(raw)).encode(),101,201)
 assert decoded['full_source_mapping_verified']is False and decoded['surface_lease_verified']is False
 bad=envelope(raw);bad['schema']='iq4_f1_entry_copied_read_v8';reject(lambda:decode_read.decode(json.dumps(bad).encode(),101,201))
 bad=envelope(raw);bad['second_hex']='01'+bad['second_hex'][2:];reject(lambda:decode_read.decode(json.dumps(bad).encode(),101,201));checks.append('496B_initial_OFF_copy_no_lease_old_schema_and_unstable_rejected')
 prep=bytearray(192);struct.pack_into('<4I',prep,0,0,192,10,184);decoded=decode_preparation.decode(json.dumps(envelope(prep,True)).encode(),101,201)
 assert decoded['result']=='Disabled'and decoded['attempts']==0 and decoded['target_text_installation_inferred']is False
 struct.pack_into('<10I',prep,0,2,192,10,184,8,1,101,104,0,1);struct.pack_into('<10Q',prep,40,201,0x500000,65536,0x10029238,0x1004c550,0x500010,0xa9057bfdd10403ff,0x1000,3,0x1004bb00);prep[120:185]=b'a'*64+b'\0'
 decoded=decode_preparation.decode(json.dumps(envelope(prep,True)).encode(),101,201);assert decoded['result']=='Prepared'and decoded['actual_surface_lease_verified']is False
 struct.pack_into('<Q',prep,80,0x500000);reject(lambda:decode_preparation.decode(json.dumps(envelope(prep,True)).encode(),101,201));checks.append('192B_source_preparation_relationships_not_a_write_lease')
 provider={'profile':1,'actual_UserSHA':'9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb','owner_review_sha256':'a'*64,'hook_quiescence_receipt_sha256':'b'*64,'owner':dict(zip(('queue','manager','data','lv','popup'),range(4096,4096+5*8,8))),'provider':0x2000,'provider_vtable':0x3000,'getter':0x4000,'present':0x5000,'inline_surface_offset':128,'getter_shape':1}
 params={'near_hint':0x500000,'generation':3,'root_admission_sha':'c'*64,'unwind_review_sha':'d'*64,'provider':provider};wire=emit_hook_inputs.pack_prepare(params)
 assert len(wire)==472 and struct.unpack_from('<II',wire)==(10,472)and struct.unpack_from('<Q',wire,368)[0]==4096 and struct.unpack_from('<3Q',wire,440)==(0,0,0)
 provider['profile']=True;reject(lambda:emit_hook_inputs.pack_prepare(params));provider['profile']=1
 bias=0x10000000;identity=source
 c={'pid':101,'ui_tid':104,'kernel_profile':1,'pid_ticks':201,'user_dev':1,'user_ino':2,'module_dev':3,'module_ino':4,'module_bias':bias,'near_page':0x500000,'near_bytes':65536,'own_bridge':bias+identity['bridge_va'],'trampoline_slot':bias+identity['trampoline_slot_va'],'own_executable':[[bias+p[3],bias+p[3]+p[6]]for p in identity['RX_LOADs']],'prepared_publication':bias+308552,'prepared_generation':3,**{k:'a'*64 for k in('proc_version_sha','root_receipt_sha','provider_receipt_sha','off_clean_receipt_sha','preparation_receipt_sha','prepared_input_sha')}}
 wire=emit_hook_inputs.pack_controller(c,'install');assert len(wire)==960 and struct.unpack_from('<Q',wire,808)[0]==bias+308552 and wire[388:548].split(b'\0')[0]==b'/run/iq4_f1_observe02/hook10.install'
 c['own_bridge']=bias+0x27aac;reject(lambda:emit_hook_inputs.pack_controller(c,'install'));checks.append('472_and_960B_pack_offsets_exact_new_ELF_old_bridge_refused')
 reject(lambda:contract.validate({},b'x'*5105,b'x'*5105,contract.ENTRY_SO,'a'*64));checks.append('missing_actual_recovery_originals_and_gate_proof_refused')
 report={'schema':11,'public_ABI':10,'passed':True,'checks':checks,'groups':6,'owned_stage_fixture_commands':len(plan['commands']),'max_stage_source_bytes':max(len(r['text'].encode())for r in plan['commands']),'preview_total_public_bytes':sum(len(v)for v in blobs.values()),'target_executed':False,'actual_acceptance':False,'frozen_old_suites_repeated':False};(OUT/'LOCAL_CHECKS.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
if __name__=='__main__':main()
