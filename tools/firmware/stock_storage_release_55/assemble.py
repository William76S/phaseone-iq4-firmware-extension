#!/usr/bin/env python3
"""Reproduce 6.03.55 locally from locked objects. Never access a device."""
import argparse, hashlib, json, subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
HEADERS=[
 'tools/firmware/f4_native_source_05/code_pins.h',
 'tools/firmware/f4_native_menu_03/code_pins.h',
 'tools/firmware/f3_native_card_bridge_06/signatures.inc',
 'tools/firmware/f3_native_jpeg8_binding_01/code_pins.h',
 'src/display/dual_exposure_pins.h',
 'src/display/ratio_mask_quick_button_pins.h',
 'tools/firmware/stock_storage_router_55/router_pins_55.h',
 'tools/firmware/stock_storage_menu_55/pins.h',
 'tools/firmware/stock_storage_router_55/policy_pins_55.h',
 'tools/firmware/f3_stock_half_export_01/half_pins.h',
 'tools/firmware/stock_jpeg_half_status_menu_55/pins.h',
 'analysis/firmware/jpeg_restart_54_link_inputs/native_half_release_pins.h',
 'tools/firmware/stock_new_raw_receipt_55/pins.h',
 'tools/firmware/stock_storage_sd_primary_55/pins.h',
 'tools/firmware/stock_jpeg_gallery_55/pins.h']
def main():
 p=argparse.ArgumentParser();p.add_argument('--gallery-link',required=True);p.add_argument('--inputs',required=True);p.add_argument('--build',required=True);p.add_argument('--package',required=True);a=p.parse_args()
 for h in HEADERS: assert (ROOT/h).is_file(),h
 cmds=[]
 def run(cmd):
  q=subprocess.run(cmd,cwd=ROOT,text=True,capture_output=True);cmds.append(dict(argv=cmd,exit=q.returncode,stdout=q.stdout,stderr=q.stderr))
  out=ROOT/a.inputs
  if out.exists():(out/'ASSEMBLE_COMMANDS.json').write_text(json.dumps(cmds,indent=2)+'\n')
  print(q.stdout,end='',flush=True)
  if q.returncode: raise RuntimeError(q.stderr or q.stdout)
 run(['python3','tools/firmware/stock_storage_release_55/prepare.py','--router-link','analysis/firmware/stock_storage_router_55/LINK.json','--gallery-link',a.gallery_link,'--output',a.inputs])
 spec=ROOT/a.inputs/'inputs/INPUTS_CLEANUP_DRAFT.json';sha=hashlib.sha256(spec.read_bytes()).hexdigest()
 cmd=['python3','tools/firmware/jpeg_restart_release_01/assemble_release.py','--spec',str(spec.relative_to(ROOT)),'--spec-sha256',sha,'--build',a.build,'--package',a.package,'--app-version','6.03.55','--iq-version','6.03.52','--system-version','8.02.34','--release-date','2026-10-07']
 for h in HEADERS:cmd+=['--runtime-pin-header',h]
 run(cmd)
 run(['python3','tools/firmware/stock_storage_release_55/check.py','--build',str(Path(a.build)/'BUILD.json'),'--exclusions','analysis/firmware/jpeg_restart_01_cleanup_final/EXCLUSIONS.json','--output',str(Path(a.build)/'OLD_PIPELINE_EXCLUSION.json')])
if __name__=='__main__':main()
