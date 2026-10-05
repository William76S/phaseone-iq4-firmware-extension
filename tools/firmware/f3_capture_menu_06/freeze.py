#!/usr/bin/env python3
import argparse,hashlib,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--verify',action='store_true');ap.add_argument('--build',type=Path);a=ap.parse_args();lock=HERE/'SOURCE_SHA256.json'
 if a.verify:
  assert a.build is None;j=json.loads(lock.read_text());assert all(row(ROOT/x['path'])==x for x in j['files']);print(len(j['files']),'members PASS',row(lock)['sha256']);return
 assert a.build is not None and not lock.exists()and not(HERE/'LINK_OVERLAY.json').exists();b=a.build.resolve();assert b.is_relative_to(ROOT)
 j=json.loads((b/'BUILD.json').read_text());assert j['schema']=='iq4_f3_dual_card_menu06_build'and len(j['objects'])==2 and j['menu_runs_each']==35 and len(j['tests'])==72
 assert j['sole_atomic_state']and j['new_BL']==[]and j['additional_aliases']==[]and not j['target_executed']and not j['camera_access']and not j['sdk_loaded']
 for x in j['source_inputs']+j['frozen_inputs']+j['dependencies']:assert row(ROOT/x['path'])==x
 prior_menu=json.loads((ROOT/'tools/firmware/f3_capture_menu_05/LINK_OVERLAY.json').read_text())['replacement']
 prior_policy=[x for x in json.loads((ROOT/'tools/firmware/f3_capture_menu_04/LINK_INPUT.json').read_text())['objects']if Path(x['path']).name=='policy.o'];assert len(prior_policy)==1
 replacements=[]
 for name,old in [('menu',prior_menu),('policy',prior_policy[0])]:
  assert row(ROOT/old['path'])=={k:old[k]for k in ['path','bytes','sha256']};actual=[x for x in j['objects']if Path(x['path']).name==name+'.o'];assert len(actual)==1 and row(ROOT/actual[0]['path'])=={k:actual[0][k]for k in ['path','bytes','sha256']}
  replacements.append(dict(replace_only={k:old[k]for k in ['path','bytes','sha256']},replacement=actual[0]))
 overlay=dict(schema='iq4_f3_menu06_two_object_overlay',replacements=replacements,wrapper04_unchanged=row(ROOT/'analysis/firmware/f3_capture_menu_build_04/wrapper.o'),new_BL=[],additional_aliases=[],additional_objects=[],required_actual_consumers=['f3_saved_raw_capture_03:single snapshot06 at actual acquisition and actual native fanout','f3_save_coordinator_08:original _06 C ABI and complete per-card file lifecycle','f3_native_executor_03:serialized actual native IFM worker and shared group lifetime'],new_external_function='f3_capture_backend_capabilities_03',capability_bits={'1':'SD installed/codepins valid, not card presence','2':'XQD installed/codepins valid, not card presence'},legacy_04_snapshot_SD_only=True,boot_settings=dict(SD_mode=0,XQD_mode=0,size=0,quality=95),manual_existing_RAW_always_retained=True,actual_capture_tested=False,target_executed=False,camera_access=False)
 (HERE/'LINK_OVERLAY.json').write_text(json.dumps(overlay,indent=2)+'\n')
 artifacts=[b/x for x in ['BUILD.json','COMMANDS.json','SOURCE_DIFF.patch','policy.o','menu.o','policy.o.d','menu.o.d','policy.o.asm','menu.o.asm']]
 evidence=ROOT/'analysis/firmware/f3_native_fanout_mask_review_01';ev=json.loads((evidence/'manifest.json').read_text());assert all(row(ROOT/x['path'])==x for x in ev['files'])
 files=[p for p in HERE.iterdir()if p.is_file()and p.name!='SOURCE_SHA256.json']+artifacts+[ROOT/x['path']for x in j['frozen_inputs']+j['dependencies']]+[evidence/'manifest.json']+[ROOT/x['path']for x in ev['files']]
 lock.write_text(json.dumps(dict(schema='iq4_f3_native_dual_card_menu06_freeze',files=[row(p)for p in sorted(set(files))],host_variants=2,host_menu_cases_each=35,host_policy_groups_each=59,actual_capture_tested=False,camera_access=False,target_executed=False,sdk_loaded=False),indent=2)+'\n')
 print('SOURCE',row(lock));print('LINK',row(HERE/'LINK_OVERLAY.json'));print('objects',[row(b/x)for x in ['policy.o','menu.o']])
if __name__=='__main__':main()
