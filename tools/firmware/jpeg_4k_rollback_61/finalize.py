#!/usr/bin/env python3
"""Freeze exact offline delivery61; no device execution is implied."""
import hashlib,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
BUILD=ROOT/'analysis/firmware/jpeg_4k_rollback_61_build_final'
def row(path):
 p=Path(path);p=p if p.is_absolute() else ROOT/p;b=p.read_bytes()
 return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def check_refs(value,seen):
 if isinstance(value,dict):
  if {'path','bytes','sha256'}<=value.keys():
   expected={k:value[k]for k in ('path','bytes','sha256')}
   assert row(value['path'])==expected,value['path'];seen.add(value['path'])
  for v in value.values():check_refs(v,seen)
 elif isinstance(value,list):
  for v in value:check_refs(v,seen)
def main():
 b=json.loads((BUILD/'BUILD.json').read_text());d=json.loads((BUILD/'DELIVERY.json').read_text())
 spec=json.loads((ROOT/b['spec']['path']).read_text());seen=set()
 assert row(b['User']['path'])==b['User'];assert row(b['spec']['path'])==b['spec']
 for obj in spec['objects']:assert row(obj['path'])==obj
 # Check new source locks only; older receipts may describe deliberately removed duplicate containers.
 locks=[r for r in spec['source_manifests']if '61' in r['path']]
 assert locks
 for r in locks:
  assert row(r['path'])==r;check_refs(json.loads((ROOT/r['path']).read_text()),seen)
 fwp=row('deploy/iq4_6.03.61/IQ4_6.03.61.fwp')
 assert fwp['sha256']==d['fwp_sha256'] and fwp['bytes']==d['fwp_bytes']
 checks=['BUILD.json','DELTA_CHECK.json','ROOT_INSPECTION.json','ORIGINAL_PIN_CHECK.json','CONTRACT_SEAL.json','LINKED_UNWIND_SEMANTIC_IDENTITY.json','OLD_PIPELINE_EXCLUSION.json','PRODUCTION_PINS.json']
 proofs=[]
 proof_paths=[
  'analysis/firmware/jpeg_4k_rollback_61_audit/HOST61.json',
  'analysis/firmware/jpeg_4k_rollback_61_audit/PAIR61_REVIEW.json',
  'analysis/firmware/jpeg_4k_rollback_61_audit/PAIR61_A64_ABI.json',
  'analysis/firmware/jpeg_4k_rollback_61_audit/PAIR61_REAL_FILES.json',
  'analysis/firmware/jpeg_pair_delete_61/A64_ORIGINAL_GAP.json',
  'analysis/firmware/jpeg_pair_delete_61/LIMITATIONS.json']
 for n in ['HOST61_SOURCE_SHA256.json','PAIR61_SOURCE_SHA256.json','PAIR61_REAL_FILES_SHA256.json']:
  path='analysis/firmware/jpeg_4k_rollback_61_audit/'+n
  check_refs(json.loads((ROOT/path).read_text()),seen);proof_paths.append(path)
 proofs=[row(p)for p in proof_paths]
 result=dict(schema='iq4_JPEG_4K_rollback_61_final_verification',versions=d,FWP=fwp,User=b['User'],spec=b['spec'],
  source_locks=locks,sources_checked=len(seen),evidence=[row(BUILD/p)for p in checks],proofs=proofs,
  guide=row('deploy/iq4_6.03.61/README.md'),cleanup=row('deploy/iq4_6.03.61/CLEANUP.json'),finalizer=row(Path(__file__).resolve()),
  object_count=b['object_count'],hook_count=spec['expected_hook_count'],
  JPEG_sizes=['4K'],half_implementation_linked=False,sensorplus_trial_cancelled=True,
  XQD_JPEG_retained=True,storage_formats_and_sd_policy_retained=True,RatioMask_DualEXP_retained=True,
  static_and_host_passed=True,full_runtime_binding_proved=False,temporary_device_executed=False,
  persistent_acceptance=False,recovery_verified=False,device_actions=False,
  limits=['Device file save, paired delete and shutdown still require actual61 acceptance.','File deletions are sequential and not atomic across files or cards.'])
 (BUILD/'FINAL_VERIFICATION.json').write_text(json.dumps(result,indent=2)+'\n')
 print(json.dumps(dict(final=row(BUILD/'FINAL_VERIFICATION.json'),FWP=fwp)))
if __name__=='__main__':main()
