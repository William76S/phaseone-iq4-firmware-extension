"""New finite OFF-display loader identity. Local provenance checks only."""
from pathlib import Path
import hashlib,importlib.util,json,re,sys
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
DISPLAY_SOURCE='72bec19cc692bbfd520034837f3713e3660612b331b1ede2690514efec924bcf'
DEFAULT_SO='8429db1c5f98fe8c693e1c3cba009426d574854c871a1c2919c504dcbcc001ff'
ENTRY_SOURCE='eb4f73531c23942b192156bdef986bad3d8ebf282b24e9d2ca1c0e84d2acfde6'
NORMAL_SOURCE=ENTRY_SOURCE
ENTRY_SO='3d8ca1c3bfa74f2f3a5c71aa0ace97cc7dd774cb57f26589992a39a0df6f65ff'
SCHEMA='iq4_f1_entry_loader_gate_v11';PROFILE='RAM_F1_production_default_off_11'
ADDITIONAL=('current_baseline03_syscall_identity_verified','scratch_restore_probe_actual_roundtrip_verified',
 'public_artifact_stager_and_cleanup_route_verified','display06_complete_source_and_exceptions_reviewed',
 'current_single_controller_lease_and_backup_handles_held','actual_base64_decoder_roundtrip_verified',
 'ui10_native_entry_source_and_constructor_registry_reviewed',
 'ui10_actual_button_placement_input_route_and_retained_lifetime_verified',
 'ui10_full_production_preparer_and_combined_tracer_source_reviewed')
def sha(b):return hashlib.sha256(b).hexdigest()
def strict_json(data):
 def pairs(rows):
  out={}
  for k,v in rows:
   if k in out:raise ValueError('Duplicate JSON field')
   out[k]=v
  return out
 if not 0<len(data)<=1048576:raise ValueError('JSON extent')
 return json.loads(data,object_pairs_hook=pairs,parse_constant=lambda _:(_ for _ in ()).throw(ValueError('Nonfinite JSON')))
def load_contract():
 # Own materialized validator accepts this new schema directly. No old proof
 # is renamed, no old module is substituted, and frozen globals are not edited.
 p=HERE/'recovery_contract.py';s=importlib.util.spec_from_file_location('display06_recovery',p);m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
def receipt(rel):
 if type(rel)is not str:raise ValueError('Receipt path')
 p=ROOT/rel
 if p.is_symlink()or not p.resolve().is_relative_to(ROOT)or not p.is_file()or not 0<p.stat().st_size<=1048576:raise ValueError('Receipt must be bounded nonsymlink local file')
 return p.read_bytes()
def validate(proof,runner_a,runner_b,candidate_sha,loader_source_sha,read_receipt=receipt):
 if candidate_sha!=ENTRY_SO:raise ValueError('Exact UI10 entry-only module required')
 c=load_contract();c.validate_proof(proof,runner_a,runner_b,read_receipt)
 expected={'schema':SCHEMA,'profile':PROFILE,'display_source_sha256':DISPLAY_SOURCE,
  'display_default_off_so_sha256':DEFAULT_SO,'entry_source_sha256':ENTRY_SOURCE,'entry_observe_so_sha256':ENTRY_SO,
  'normal_fit_source_sha256':NORMAL_SOURCE,'entry_boundary_observation_only':True,
  'native_text_hook_installation_authorized':False,'provider_lease_authorized':False,
  'loader_source_sha256':loader_source_sha,'observe_env':'IQ4_F1_MODULE_ENTRY_01=OBSERVE',
  'mask_enabled':False,'paint_table_installation_authorized':False,'UI_entry_installation_authorized':True,
  'stager_codec':'busybox_base64_no_padding_octal_tail_v1'}
 if not all(type(proof.get(k))is type(v)and proof[k]==v for k,v in expected.items()):raise ValueError('New loader/display identity or OFF scope mismatch')
 placement=proof.get('entry_placement')
 if type(placement)is not dict or set(placement)!={'x','y'} or any(type(placement[k])is not int or not 0<=placement[k]<=4096 for k in ('x','y')):raise ValueError('Actual finite UI placement required')
 for name in ADDITIONAL:
  if proof.get(name)is not True:raise ValueError('Actual additional gate absent: '+name)
 sys.path.insert(0,str(HERE.parent));from f1_restore_baseline_03 import facts
 baseline=facts.parse_body(read_receipt(proof['receipts'][ADDITIONAL[0]]['path']).decode('ascii'))
 if baseline['uid']!=0 or baseline['euid']!=0:raise ValueError('Actual root syscall identity required')
 rows=baseline['nodes']
 for i in (0,2,3,8,10,12,13):
  if rows[i]['rc']!=0 or not rows[i]['stable']or rows[i]['uid']!=0 or rows[i]['gid']!=0:raise ValueError('Actual stable node absent')
 if (rows[0]['dev_major'],rows[0]['dev_minor'])!=(1,0)or(rows[3]['dev_major'],rows[3]['dev_minor'])!=(0,proof['mount']['run_minor']):raise ValueError('Actual RAM/tmpfs node identity changed')
 r=rows[8]
 if (r['dev_major'],r['dev_minor'],r['inode'],r['mode']&4095,r['size'],r['nlink'])!=(1,0,proof['runner']['inode'],493,5105,1):raise ValueError('Actual runner node binding')
 u=rows[10]
 if (u['mode']&4095,u['size'])!=(493,11874544):raise ValueError('Actual User node metadata')
 for i in range(14,26):
  if rows[i]['rc']!=-1 or rows[i]['errno']!=2:raise ValueError('Actual foreign flag/new-path absence requires ENOENT')
 x=baseline['runner_xattrs']
 if not(x['fd_opened']and x['stable']and x['name_bytes']==0 and x['errno']==0):raise ValueError('Actual runner xattr absence')
 parent=proof.get('scratch_parent')
 if not isinstance(parent,dict)or any(parent.get(k)!=rows[2][k]for k in('dev_major','dev_minor','inode')):raise ValueError('Actual scratch parent not current scripts inode')
 scratch=strict_json(read_receipt(proof['receipts'][ADDITIONAL[1]]['path']))
 expected_scratch={'action':'F1_scratch_inode_restore_probe','phase':'complete','errno':0,
  'scratch_created':True,'same_fs_restore_exact_inode_and_bytes':True,'cleanup_complete':True,
  'runner_modified':False,'User_modified':False,'EEP_access':False,'cold_recovery_verified':False}
 if not all(type(scratch.get(k))is type(v)and scratch[k]==v for k,v in expected_scratch.items()):raise ValueError('Actual scratch restore/cleanup receipt incomplete')
 if not c.integer(scratch.get('scratch_original_inode'),1,2**64-1)or not c.integer(scratch.get('scratch_candidate_inode'),1,2**64-1)or scratch['scratch_original_inode']==scratch['scratch_candidate_inode']:raise ValueError('Scratch inodes invalid')
 # The generator does not authenticate hardware meaning, receipt origin,
 # current handles or foreign-root exclusion. Root rechecks those with its sole
 # controller immediately before staging, arming, exit and each copied read.
 return proof
