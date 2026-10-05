#!/usr/bin/env python3
"""Validate frozen source/artifact bytes only. No compiler, SDK or target load."""
from pathlib import Path
import hashlib,json
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
def main():
    m=json.loads((HERE/'SOURCE_SHA256.json').read_text())
    assert m['camera_access'] is False and m['target_loaded'] is False and m['stage']=='observe_only'
    for r in m['members']+m['frozen_refs']:
        p=ROOT/r['path'];b=p.read_bytes();assert len(b)==r['bytes'] and hashlib.sha256(b).hexdigest()==r['sha256'],r['path']
    r=m['target_SO'];b=(ROOT/r['path']).read_bytes();assert len(b)==r['bytes'] and hashlib.sha256(b).hexdigest()==r['sha256']
    v=json.loads((ROOT/'analysis/sdk_reference/f1_module_entry_build_01/BUILD_VALIDATION.json').read_text())
    assert v['target_SO']['sha256']==r['sha256'] and not v['target_SO_loaded'] and not v['vendor_code_executed']
    assert v['target_stage']=='observe_only' and not v['production_mask_enabled'] and not v['native_subscriptions'] and not v['native_vptr_writes']
    assert all(x['groups']==13 for x in v['tests'].values())
    print(json.dumps({'frozen_members':len(m['members']),'frozen_refs':len(m['frozen_refs']),'target_SO_exact':True,'camera_access':False}))
if __name__=='__main__':main()
