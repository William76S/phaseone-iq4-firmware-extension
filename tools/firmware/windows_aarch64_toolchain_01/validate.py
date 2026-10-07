#!/usr/bin/env python3
"""Hash/scope validation only; no acquisition or target execution."""
import hashlib
import json
from pathlib import Path

ROOT=Path(__file__).resolve().parents[3];OUT=ROOT/'analysis/firmware/windows_aarch64_toolchain_01'
def main():
    m=json.loads((OUT/'manifest.json').read_text());count=0
    for group in ['files','frozen_dependencies','ignored_rebuildable_public_artifacts']:
        for rel,digest in m[group].items():
            p=(ROOT/rel).resolve()
            if not p.is_relative_to(ROOT) or hashlib.sha256(p.read_bytes()).hexdigest()!=digest:raise SystemExit('Hash mismatch: '+rel)
            count+=1
            if group=='files':
                text=p.read_text()
                if not text.endswith('\n') or text.endswith('\n\n') or any(line!=line.rstrip() for line in text.splitlines()):raise SystemExit('Whitespace mismatch: '+rel)
    for k in ['Windows_archive_downloaded','Windows_compiler_executed','private_originals_read','actual_private_profile_emitted','device_accessed','target_executed']:
        if m[k] is not False:raise SystemExit('Windows/device acceptance incorrectly recorded')
    t=json.loads((OUT/'host_validation.json').read_text());b=json.loads((OUT/'Mac_host_public_compile/build.json').read_text())
    if t['host_tests_run']!=16 or t['host_tests_passed'] is not True or b['Windows_compiler_actual'] is not False:raise SystemExit('Host scope mismatch')
    if b['EN0']['ELF_type']!=3 or b['EN0']['machine']!=183 or b['synthetic_ET_REL']['ELF_type']!=1:raise SystemExit('Compile scope mismatch')
    print(json.dumps({'status':'PASS','hashes_checked':count,'host_tests':t['host_tests_run'],'Windows_actual':False,'device_accessed':False}))

if __name__=='__main__':main()
