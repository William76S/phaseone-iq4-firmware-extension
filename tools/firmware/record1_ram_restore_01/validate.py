#!/usr/bin/env python3
"""Validate frozen source/receipt hashes without executing target artifacts."""
import hashlib
import json
from pathlib import Path

ROOT=Path(__file__).resolve().parents[3];OUT=ROOT/'analysis/firmware/record1_ram_restore_01'

def main():
    m=json.loads((OUT/'manifest.json').read_text());count=0
    for group in ['files','frozen_dependencies','ignored_rebuildable_inert_or_ET_REL_artifacts']:
        for rel,digest in m[group].items():
            p=(ROOT/rel).resolve()
            if not p.is_relative_to(ROOT) or hashlib.sha256(p.read_bytes()).hexdigest()!=digest:raise SystemExit('Hash mismatch: '+rel)
            count+=1
            if group=='files':
                text=p.read_text()
                if not text.endswith('\n') or text.endswith('\n\n') or any(line!=line.rstrip() for line in text.splitlines()):raise SystemExit('Whitespace mismatch: '+rel)
    for k in ['actual_private_profile_emitted','device_accessed','target_executed','changed_then_restored_coldboot_verified','persistent_unlock_verified']:
        if m[k] is not False:raise SystemExit('Actual acceptance incorrectly recorded')
    t=json.loads((OUT/'host_validation.json').read_text());b=json.loads((OUT/'preview/build.json').read_text());a=json.loads((OUT/'compile_audit/build.json').read_text())
    if t['host_tests_run']!=20 or t['host_tests_passed'] is not True or t['persistent_unlock_verified'] is not False:raise SystemExit('Host scope mismatch')
    if any(b[k] is not False for k in ['bound_read','bound_write','private_profile_emitted','actual_source_extent_proven','device_accessed','target_executed']):raise SystemExit('Preview scope mismatch')
    if a['ELF_type']!=1 or a['machine']!=183 or a['synthetic_fixture_only'] is not True or a['not_installable_object_no_main_no_constructor'] is not True:raise SystemExit('Compile audit scope mismatch')
    print(json.dumps({'hashes_checked':count,'host_tests':t['host_tests_run'],'actual_acceptance':False,'status':'PASS'}))

if __name__=='__main__':main()
