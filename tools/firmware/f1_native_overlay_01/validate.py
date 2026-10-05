#!/usr/bin/env python3
"""Verify frozen F1 hashes, exact byte windows and disabled scope; offline."""
import hashlib
import json
from pathlib import Path
import struct
import zipfile
ROOT=Path(__file__).resolve().parents[3];OUT=ROOT/'analysis/firmware/f1_native_overlay_01'
def digest(b):return hashlib.sha256(b).hexdigest()
def main():
    mp=OUT/'manifest.json';m=json.loads(mp.read_text());count=0
    for group in ['files','frozen_dependencies','ignored_rebuildable_ET_REL']:
        for rel,sha in m[group].items():
            path=(ROOT/rel).resolve()
            if not path.is_relative_to(ROOT) or digest(path.read_bytes())!=sha:raise SystemExit('Hash mismatch: '+rel)
            count+=1
            if group=='files':
                text=path.read_text()
                if not text.endswith('\n') or text.endswith('\n\n') or any(line!=line.rstrip() for line in text.splitlines()):raise SystemExit('Whitespace mismatch: '+rel)
    fields=['production_binding_enabled','device_accessed','vendor_code_executed','target_executed',
      'actual_native_instance_hook_or_recovery_verified','actual_surface_viewport_mapping_and_fresh_repaint_verified',
      'actual_native_selector_and_disable_detach_verified','actual_RAW_JPEG_isolation_verified','installed']
    if any(m[k] is not False for k in fields):raise SystemExit('Target acceptance incorrectly recorded')
    b=json.loads((OUT/'build_validation.json').read_text())
    for name in ['normal','asan_ubsan']:
        if b['tests'][name]['groups']!=19 or b['tests'][name]['independent_pixels']!=1048576 or b['tests'][name]['exit_code']!=0:raise SystemExit('Host receipt mismatch')
    if b['tests']['production']['exit_code'] or len(b['target_objects'])!=2 or any(o['ELF_type']!=1 or o['machine']!=183 for o in b['target_objects']):raise SystemExit('Production/target scope mismatch')
    for k in ['production_binding_enabled','device_accessed','vendor_code_executed','target_executed','actual_native_instance_hook_or_recovery_verified','actual_surface_viewport_mapping_and_fresh_repaint_verified','actual_RAW_JPEG_video_isolation_verified']:
        if b[k] is not False:raise SystemExit('Build acceptance incorrectly recorded')
    for rel,sha in b['sources'].items():
        if digest((ROOT/rel).read_bytes())!=sha:raise SystemExit('Build source mismatch')
    source=m['exact_User_input'];raw=(ROOT/source['path']).read_bytes()
    if len(raw)!=source['bytes'] or digest(raw)!=source['sha256']:raise SystemExit('Exact User input changed')
    exact=json.loads((OUT/'static/exact_bytes.json').read_text())
    if exact['input_sha256']!=source['sha256'] or exact['device_accessed'] is not False or exact['target_executed'] is not False:raise SystemExit('Exact window scope mismatch')
    for r in exact['ranges']:
        a=int(r['start_va'],16);e=int(r['end_va_exclusive'],16);offset=int(r['file_offset'],16)
        chunk=raw[offset:offset+e-a]
        if offset!=a-0x400000 or chunk.hex()!=r['bytes_hex'] or digest(chunk)!=r['bytes_sha256'] or digest((ROOT/r['disassembly']).read_bytes())!=r['disassembly_sha256']:raise SystemExit('Exact function window mismatch')
    for t in exact['tables']:
        offset=int(t['file_offset'],16);chunk=raw[offset:offset+t['size']]
        if offset!=int(t['va'],16)-0x400000 or chunk.hex()!=t['bytes_hex'] or digest(chunk)!=t['sha256'] or [hex(struct.unpack_from('<Q',chunk,i)[0]) for i in range(0,t['size']//8*8,8)]!=t['qwords']:raise SystemExit('Exact table mismatch')
    if len(exact['ranges'])!=15 or len(exact['tables'])!=5:raise SystemExit('Finite window count changed')
    table=exact['tables'][0];boundary=exact['tables'][1]
    if table['size']!=0x1e8 or table['qwords'][0:2]!=['0x0','0xb9ae20'] or table['qwords'][2+0xa0//8]!='0x51da0c' or boundary['qwords']!=['0xffffffffffffff80','0xb9ae20']:raise SystemExit('Primary table/secondary boundary mismatch')
    archive=OUT/'f1_native_overlay_01_source.zip'
    with zipfile.ZipFile(archive) as z:
        expected=set(m['files'])|set(m['frozen_dependencies'])|{str(mp.relative_to(ROOT))}
        if len(z.namelist())!=len(expected) or set(z.namelist())!=expected:raise SystemExit('ZIP finite member mismatch')
        for name in z.namelist():
            if z.read(name)!=(ROOT/name).read_bytes():raise SystemExit('ZIP source content mismatch')
    print(json.dumps(dict(status='PASS',hashes_checked=count,exact_windows=15,exact_tables=5,host_groups_each_normal_and_asan_ubsan=19,independent_pixels=1048576,production_zero_native_reads_calls=True,actual_acceptance=False)))
if __name__=='__main__':main()
