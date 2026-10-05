#!/usr/bin/env python3
"""Freeze this reviewed local increment. It never builds or executes targets."""
from pathlib import Path
import hashlib,json
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/sdk_reference/f1_observe_role_build_02'
def row(p):
 b=p.read_bytes();return {'path':str(p.relative_to(ROOT)),'bytes':len(b),'sha256':hashlib.sha256(b).hexdigest()}
def main():
 lock=HERE/'SOURCE_SHA256.json'
 if lock.exists():raise SystemExit('Already frozen; preserve original revision')
 previous=json.loads((HERE.parent/'f1_module_entry_01/SOURCE_SHA256.json').read_text())
 refs={r['path']:r for r in previous['members']+previous['frozen_refs']}
 additional=['tools/firmware/f1_module_entry_01/SOURCE_SHA256.json','tools/firmware/f4_ram_entry_02/sha256.h','tools/firmware/f4_ram_entry_02/test_entry.py','tools/firmware/f4_ram_entry_01/readonly_monitor.c','tools/firmware/inspect_boot.py','analysis/firmware/f4_ram_entry_02/manifest.json']
 for name in additional:refs[name]=row(ROOT/name)
 for name,r in refs.items():assert row(ROOT/name)==r
 members=sorted(p for p in HERE.iterdir() if p.is_file() and p.name!='SOURCE_SHA256.json')
 members += [ROOT/'analysis/sdk_reference/F1_OBSERVE_ROLE_INTEGRATION_02.md']
 members += sorted(p for p in OUT.rglob('*') if p.is_file() and p.suffix in ('.json','.txt','.h','.c','.py') and 'enabled_package' not in p.parts)
 report=json.loads((OUT/'BUILD_VALIDATION.json').read_text());preview=json.loads((OUT/'preview_package/build.json').read_text())
 assert preview['preview_only'] and not preview['enabled_device_profile_emitted'] and preview['stage_commands_count']==0
 targets=[OUT/'libiq4_f1_observe_role02_default_off.so',OUT/'libiq4_f1_observe_role02_ctor_candidate.so',OUT/'preview_package/entrytool']
 assert row(targets[0])['sha256']==report['composed_default_off_SO']['sha256'] and row(targets[1])['sha256']==report['ctor_candidate_SO']['sha256'] and row(targets[2])['sha256']==preview['entrytool']['sha256']
 data={'schema':'iq4_f1_observe_role_source_lock_02','stage':'observe_only','camera_access':False,'SDK_started':False,'target_loaded':False,'actual_installation':False,'enabled_package_emitted':False,'members':[row(p)for p in sorted(set(members))],'frozen_refs':[refs[n]for n in sorted(refs)],'target_review_artifacts':[row(p)for p in targets]}
 lock.write_text(json.dumps(data,indent=2)+'\n');print(json.dumps(row(lock)))
if __name__=='__main__':main()
