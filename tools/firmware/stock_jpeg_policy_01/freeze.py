#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,sys
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/stock_jpeg_policy_build_01'
PROOF=ROOT/'analysis/firmware/stock_jpeg_mode_reset_audit_01'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def emit(p,x):p.write_text(json.dumps(x,indent=2)+'\n')
def main():
 if '--verify'in sys.argv:
  src=json.loads((OUT/'SOURCE_SHA256.json').read_text())
  assert all(row(ROOT/q['path'])==q for q in src['files'])
  link=json.loads((OUT/'LINK.json').read_text())
  assert row(ROOT/link['source_manifest'])['sha256']==link['source_manifest_sha256']
  assert all(row(ROOT/q['path'])==q for q in link['objects'])
  print('PASS frozen policy source, exact windows, proof and two objects');return
 draft='--draft'in sys.argv
 build=json.loads((OUT/'BUILD.json').read_text())
 assert all(q['exit']==0 for q in json.loads((OUT/'COMMANDS.json').read_text()))
 objects=build['objects'];assert all(row(ROOT/q['path'])==q for q in objects)
 exact=json.loads((OUT/'EXACT.json').read_text())
 files={p for p in HERE.iterdir()if p.is_file()}
 files|={OUT/'BUILD.json',OUT/'COMMANDS.json',OUT/'EXACT.json',OUT/'LINKER_ATTEMPT_01.json'}
 files|={OUT/'policy.o',OUT/'ctor_wrapper.o',OUT/'policy.o.asm',OUT/'ctor_wrapper.o.asm'}
 files|={ROOT/'tools/firmware/native_runtime_01/self_read.h',
   ROOT/'tools/firmware/f3_stock_jpeg_xqd_01/stock.h',
   ROOT/'tools/firmware/f3_stock_jpeg_xqd_01/SOURCE_SHA256.json',
   PROOF/'EXACT_WINDOWS.json',PROOF/'prove.py',PROOF/'A64_MODE_RESET.json'}
 if not draft:
  receipt=PROOF/'A64_POLICY_FIX.json';assert receipt.exists()
  proof=json.loads(receipt.read_text())
  assert proof['objects']==objects and proof['actual_new_objects_executed']
  assert proof['actual_original_consumer_executed']and proof['cases_count']==18
  assert proof['constructor_original_calls_once']and proof['constructor_MainSP_captured']
  assert proof['constructor_original_x0_preserved']and proof['explicit_UI_changes_not_intercepted']
  assert proof['after_bound_API_transient_false_does_not_reset_Mode']
  assert row(ROOT/proof['source']['path'])==proof['source']
  assert row(ROOT/proof['relocator']['path'])==proof['relocator']
  files|={receipt,ROOT/proof['source']['path'],ROOT/proof['relocator']['path']}
 source=OUT/('SOURCE_DRAFT.json'if draft else'SOURCE_SHA256.json')
 emit(source,dict(schema='iq4_stock_jpeg_policy_source_01',files=[row(p)for p in sorted(files)],
    camera_accessed=False,target_device_executed=False))
 sr=row(source)
 link=dict(schema='iq4_stock_jpeg_policy_link_01',objects=objects,aliases=[],
   BL_hooks=[exact['ctor_hook']],auxiliary_hooks=exact['setter_hooks'],
   required_functions=['iq4_stock_jpeg_policy_bind_01','iq4_stock_jpeg_policy_set_01',
                       'iq4_stock_jpeg_policy_ctor_wrapper_01'],
   source_manifest=sr['path'],source_manifest_sha256=sr['sha256'],
   replacement={'va':0x424bcc,'prior_target_symbol':'iq4_stock_jpeg_ctor_wrapper_01',
                'target_symbol':'iq4_stock_jpeg_policy_ctor_wrapper_01',
                'required_action':'replace retained 52 ctor hook; never apply both'},
   retained_52_objects_unmodified=True,stock_quality=90,stock_sizes=['Thumbnail','4K'],
   corrected_boundary='owned XQD JPEG Mode is independent of original SD-composite policy',
   policy_runtime_pin_header='tools/firmware/stock_jpeg_policy_01/pins.h',
   camera_accessed=False,target_device_executed=False,draft=draft)
 target=OUT/('LINK_DRAFT.json'if draft else'LINK.json');emit(target,link)
 print(json.dumps(dict(link=row(target),source=sr,objects=objects)))
if __name__=='__main__':main()
