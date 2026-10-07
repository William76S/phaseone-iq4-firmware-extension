#!/usr/bin/env python3
"""Build exact 4K-only61 and package it. No device control or install."""
import argparse,hashlib,json,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
HEADERS=[
 'src/display/dual_exposure_pins.h',
 'src/display/ratio_mask_quick_button_pins.h',
 'tools/firmware/stock_storage_router_55/router_pins_55.h',
 'tools/firmware/jpeg_binding_fix_57/stock_pins_57.h',
 'tools/firmware/stock_storage_menu_55/pins.h',
 'tools/firmware/stock_storage_router_55/policy_pins_55.h',
 'tools/firmware/stock_jpeg_half_status_menu_55/pins.h',
 'tools/firmware/stock_new_raw_receipt_55/pins.h',
 'tools/firmware/stock_storage_sd_primary_55/pins.h',
 'tools/firmware/stock_jpeg_gallery_55/pins.h',
 'tools/firmware/recording_remove_56/pins.h']
def main():
 p=argparse.ArgumentParser();p.add_argument('--components',required=True);p.add_argument('--inputs',required=True);p.add_argument('--build',required=True);p.add_argument('--package',required=True);p.add_argument('--delete-module');a=p.parse_args()
 for h in HEADERS:assert(ROOT/h).is_file(),h
 cmds=[]
 def run(cmd):
  q=subprocess.run(cmd,cwd=ROOT,text=True,capture_output=True);cmds.append(dict(argv=cmd,exit=q.returncode,stdout=q.stdout,stderr=q.stderr));out=ROOT/a.inputs
  if out.exists():(out/'ASSEMBLE_COMMANDS.json').write_text(json.dumps(cmds,indent=2)+'\n')
  print(q.stdout,end='',flush=True)
  if q.returncode:raise RuntimeError(q.stderr or q.stdout)
 inputs=ROOT/a.inputs
 if not inputs.exists():
  cmd=['python3','tools/firmware/jpeg_4k_rollback_61/prepare.py','--components',a.components,'--output',a.inputs]
  if a.delete_module:cmd+=['--delete-module',a.delete_module]
  run(cmd)
 else:
  spec=json.loads((inputs/'INPUTS.json').read_text());manifest=ROOT/a.components/'SOURCE_SHA256.json'
  matches=[r for r in spec['source_manifests']if r['path']==str(manifest.relative_to(ROOT))];assert len(matches)==1
  assert matches[0]['sha256']==hashlib.sha256(manifest.read_bytes()).hexdigest()
  if a.delete_module:
   d=ROOT/a.delete_module;assert spec['paired_delete_module']['path']==str(d.relative_to(ROOT)) and spec['paired_delete_module']['sha256']==hashlib.sha256(d.read_bytes()).hexdigest()
 spec=inputs/'INPUTS.json';sha=hashlib.sha256(spec.read_bytes()).hexdigest()
 headers=HEADERS+json.loads(spec.read_text()).get('paired_delete_pin_headers',[])
 for h in headers:assert(ROOT/h).is_file(),h
 run(['python3','tools/firmware/recording_remove_56/build.py','--spec',str(spec.relative_to(ROOT)),'--spec-sha256',sha,'--output',a.build,'--app-version','6.03.61'])
 run(['python3','tools/firmware/native_linked_unwind_03/verify.py','--build',a.build])
 run(['python3','tools/firmware/native_linked_contract_02/seal.py','--build',a.build,'--loader-proof','tools/firmware/f3_init_repair_01/ABI_PROOF.json'])
 run(['python3','tools/firmware/recording_remove_56/verify_user.py','--build',a.build])
 cmd=['python3','tools/firmware/jpeg_restart_release_01/verify_pins.py','--build',a.build]
 for h in headers:cmd+=['--header',h]
 run(cmd)
 run(['python3','tools/firmware/stock_storage_release_55/check.py','--build',str(Path(a.build)/'BUILD.json'),'--exclusions','analysis/firmware/jpeg_restart_01_cleanup_final/EXCLUSIONS.json','--output',str(Path(a.build)/'OLD_PIPELINE_EXCLUSION.json')])
 run(['python3','tools/firmware/jpeg_4k_rollback_61/verify_delta.py','--build',a.build])
 user=ROOT/a.build/'P1Linux_RatioMask_JPEG_6.03.61.bin';digest=hashlib.sha256(user.read_bytes()).hexdigest()
 run(['python3','tools/firmware/user_only_package_stock_wrapper_03/package.py','--user-payload',str(user.relative_to(ROOT)),'--expected-user-sha256',digest,'--release-version','6.03.58','--app-version','6.03.61','--system-version','8.02.40','--release-date','2026-10-07','--emit-candidate-directory',a.package])
 run(['python3','tools/firmware/f1_f3_f4_user_integration_05/inspect_package.py','--build',a.build,'--package',a.package])
 import os
 package=ROOT/a.package;source=package/'IQ4-user-only-candidate.fwp';os.link(source,package/'IQ4_6.03.61.fwp');b=source.read_bytes()
 result=dict(version='6.03.61',IQ='6.03.58',System='8.02.40',date='2026-10-07',fwp_bytes=len(b),fwp_sha256=hashlib.sha256(b).hexdigest(),Half_implementation_linked=False,SensorPlus_implementation_linked=False,JPEG_size_choices=['4K'],recording_implementation_linked=False,camera_accessed=False,hardware_acceptance=False,recovery_verified=False)
 (ROOT/a.build/'DELIVERY.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result))
if __name__=='__main__':main()
