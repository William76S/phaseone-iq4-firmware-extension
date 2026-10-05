#!/usr/bin/env python3
"""Validate local frozen hashes/types/limits; never run target artifacts."""
import hashlib
import json
from pathlib import Path

ROOT=Path(__file__).resolve().parents[3]
OUT=ROOT/'analysis/firmware/f4_ram_entry_02'

def main():
    manifest=json.loads((OUT/'manifest.json').read_text());count=0
    for group in ['files','frozen_dependencies','ignored_rebuildable_binary_artifacts']:
        for rel,digest in manifest[group].items():
            p=(ROOT/rel).resolve()
            if not p.is_relative_to(ROOT) or hashlib.sha256(p.read_bytes()).hexdigest()!=digest:raise SystemExit('Hash mismatch: '+rel)
            count+=1
            if group=='files':
                text=p.read_text()
                if not text.endswith('\n') or text.endswith('\n\n') or any(line!=line.rstrip() for line in text.splitlines()):raise SystemExit('Whitespace mismatch: '+rel)
    build=json.loads((OUT/'preview_package/build.json').read_text())
    stage=json.loads((OUT/'preview_package/stage_commands.json').read_text())
    tests=json.loads((OUT/'host_validation.json').read_text())
    if build['preview_only'] is not True or build['enabled_device_profile_emitted'] is not False or stage['commands']!=[]:raise SystemExit('Preview scope changed')
    if tests['host_tests_passed'] is not True or tests['host_tests_run']!=20 or tests['actual_mount_User_exit_module_or_recovery_acceptance'] is not False:raise SystemExit('Validation scope changed')
    if any(manifest[k] is not False for k in ['enabled_device_profile_emitted','device_accessed','target_executed']):raise SystemExit('Actual acceptance incorrectly recorded')
    print(json.dumps({'hashes_checked':count,'host_tests':tests['host_tests_run'],'actual_acceptance':False,'status':'PASS'}))

if __name__=='__main__':main()
