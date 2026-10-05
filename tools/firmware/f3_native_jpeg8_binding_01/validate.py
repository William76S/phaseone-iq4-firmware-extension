#!/usr/bin/env python3
"""Read-only source hashes and exact byte contracts; never executes target."""
import hashlib,json,struct
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
def main():
    source=json.loads((HERE/'SOURCE_SHA256.json').read_text())
    for r in source['files']:
        p=ROOT/r['path'];b=p.read_bytes()
        if len(b)!=r['bytes']or hashlib.sha256(b).hexdigest()!=r['sha256']:raise ValueError('Frozen member mismatch: '+r['path'])
    d=(ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin').read_bytes()
    if hashlib.sha256(d).hexdigest()!=source['original_User_sha256']:raise ValueError('Original User changed')
    static=json.loads((ROOT/'analysis/firmware/f3_native_jpeg8_binding_static_01/EXACT.json').read_text())
    for r in static['ranges']:
        off=int(r['file_offset'],16);b=d[off:off+r['bytes']]
        if b.hex()!=r['exact_hex']or hashlib.sha256(b).hexdigest()!=r['sha256']:raise ValueError('Exact byte window mismatch')
    assert static['functions']==dict(std_error='0x9a20f0',create_compress='0x9a2148',destroy_compress='0x9a2248',
        set_defaults='0x9a34b8',set_quality='0x9a2fc8',start_compress='0x9a39e0',write_scanlines='0x9a3a88',finish_compress='0x9a22f0')
    assert d[0x5a214c:0x5a2150].hex()=='3f480171'and d[0x5a218c:0x5a2190].hex()=='bf2209f1'
    assert struct.unpack_from('<Q',d,0x9ce128)[0]==0x98d950
    build=json.loads((ROOT/'analysis/firmware/f3_native_jpeg8_binding_build_01/BUILD.json').read_text())
    assert [r['result']['host_synthetic_groups']for r in build['host_results']]==[4,22,22]
    assert build['objects'][0]['undefined_symbols']==[]
    assert build['objects'][1]['undefined_symbols']==['_setjmp','calloc','free','longjmp','malloc','memset']
    for flag in ['native_functions_executed','target_encoder_executed','sdk_loaded','device_access','firmware_produced']:assert build[flag]is False
    assert static['code_pin_bytes']==1932 and static['runtime_binding_verified']is False
    print(json.dumps(dict(frozen_members=len(source['files']),exact_windows=len(static['ranges']),code_guard_bytes=1932,
        actual_host_groups=[4,22,22],actual_target_execution=False,passed=True)))
if __name__=='__main__':main()
