#!/usr/bin/env python3
"""Validate the narrow independent UI02 derivation; never rewrite UI01."""
from pathlib import Path
import difflib,hashlib,json
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
def main():
 assert not(HERE/'SOURCE_SHA256.json').exists()
 old=ROOT/'tools/firmware/f1_user_ui_entry_01'
 manifest=old/'SOURCE_SHA256.json'
 assert hashlib.sha256(manifest.read_bytes()).hexdigest()=='268d5de07a114092531a69fd7afb4ae59b90815a0eda91f95e15feecfb5bca3a'
 j=json.loads(manifest.read_text())
 for group in ('members','frozen_refs','review_artifacts'):
  for r in j[group]:
   b=(ROOT/r['path']).read_bytes();assert len(b)==r['bytes'] and hashlib.sha256(b).hexdigest()==r['sha256']
 peer=ROOT/'analysis/sdk_reference/f1_user_ui_entry_01_independent_review/manifest.json'
 assert hashlib.sha256(peer.read_bytes()).hexdigest()=='ba3799f3832561affd776b0965685b4be8f6d2ca2546a508c451589de8f21406'
 for name in ('module.hpp','module.cpp','entry_binding_10.hpp','inspector.cpp','stock_windows.hpp','native_helpers.inc','ctor_wrapper.S','compare.c','state.h'):
  assert (HERE/name).read_bytes()==(old/name).read_bytes(),name
 assert hashlib.sha256((HERE/'state.h').read_bytes()).hexdigest()=='5219328b04dd33c4e455830d196eb9fd0e55964a284bf22591e0aa752285188a'
 diff=[]
 for name in ('runtime.cpp','entry_binding_10.cpp'):
  a=old/name;b=HERE/name
  diff.extend(difflib.unified_diff(a.read_text().splitlines(True),b.read_text().splitlines(True),fromfile=str(a.relative_to(ROOT)),tofile=str(b.relative_to(ROOT))))
 (HERE/'SOURCE_DIFF.txt').write_text(''.join(diff))
 print(json.dumps({'UI01_all_frozen_rows_readback':True,'UI02_delta':'exact Grid click/longpress occupancy only','shared_ABI_bytes':64,'target_executed':False}))
if __name__=='__main__':main()
