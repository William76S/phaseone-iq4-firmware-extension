#!/usr/bin/env python3
"""Frozen hashes/disabled scope only. No target/native code or device."""
import hashlib
import json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];OUT=ROOT/'analysis/firmware/f4_native_page_bridge_01'
def main():
    m=json.loads((OUT/'manifest.json').read_text());count=0
    for group in ['files','frozen_dependencies','ignored_rebuildable_ET_REL']:
        for rel,digest in m[group].items():
            p=(ROOT/rel).resolve()
            if not p.is_relative_to(ROOT) or hashlib.sha256(p.read_bytes()).hexdigest()!=digest:raise SystemExit('Hash mismatch: '+rel)
            count+=1
            if group=='files':
                text=p.read_text()
                if not text.endswith('\n') or text.endswith('\n\n') or any(line!=line.rstrip() for line in text.splitlines()):raise SystemExit('Whitespace mismatch: '+rel)
    for k in ['production_native_binding_enabled','device_accessed','vendor_code_executed','target_executed','actual_native_page_verified','actual_card_lease_worker_mode_verified','actual_1080p60_verified','installed']:
        if m[k] is not False:raise SystemExit('Actual acceptance incorrectly recorded')
    b=json.loads((OUT/'build_validation.json').read_text())
    if any(b['tests'][k]['groups']!=22 or b['tests'][k]['exit_code'] for k in ['normal','asan_ubsan','tsan']):raise SystemExit('Host test receipt changed')
    if b['tests']['production']['exit_code'] or b['target']['ELF_type']!=1 or b['target']['machine']!=183:raise SystemExit('Production/target scope changed')
    print(json.dumps({'hashes_checked':count,'host_groups_each_normal_asan_tsan':22,'production_zero_calls':True,'status':'PASS','actual_acceptance':False}))
if __name__=='__main__':main()
