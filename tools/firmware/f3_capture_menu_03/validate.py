#!/usr/bin/env python3
"""Frozen source/object/ABI receipt validation only; no test/target/SDK execution."""
import hashlib
import json
import struct
from pathlib import Path

ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent

def symbol_bytes(path,name):
    b=path.read_bytes();h=struct.unpack_from('<16sHHIQQQIHHHHHH',b)
    sections=[struct.unpack_from('<IIQQQQIIQQ',b,h[6]+i*h[11]) for i in range(h[12])]
    for s in sections:
        if s[1]!=2:continue
        st=sections[s[6]];strings=b[st[4]:st[4]+st[5]]
        for off in range(s[4],s[4]+s[5],s[9]):
            n,info,other,index,value,size=struct.unpack_from('<IBBHQQ',b,off)
            if n and strings[n:strings.index(b'\0',n)].decode()==name:
                sec=sections[index];return b[sec[4]+value:sec[4]+value+size]
    raise ValueError('Symbol absent: '+name)

def main():
    source=json.loads((HERE/'SOURCE_SHA256.json').read_text())
    for r in source['members']:
        f=ROOT/r['path'];b=f.read_bytes()
        assert len(b)==r['bytes'] and hashlib.sha256(b).hexdigest()==r['sha256'],r['path']
    abi=json.loads((HERE/'NATIVE_CONTRACT.json').read_text())
    assert abi['leaf_format_mode_order']==[0,2,1]
    assert abi['scale_percent_order']==[100,75,50,25,0,0]
    assert abi['scale_index_order']==list(range(6))
    assert abi['jpeg_quality']['default']==95
    assert abi['RAW_only_output_geometry']==[0,0]
    assert abi['preserve_SubMenu_VT70']=='0x4e6004' and abi['preserve_EventItem_VT70']=='0x4ea2fc'
    build=ROOT/'analysis/firmware/f3_capture_menu_build_03_final'
    receipt=json.loads((build/'BUILD.json').read_text())
    assert len(receipt['host_tests'])==36 and all(r['result'].startswith('PASS:') for r in receipt['host_tests'])
    assert all(not receipt[k] for k in ('firmware_candidate_produced','target_executed','sdk_loaded','device_access','native_complete_RAW_consumer_bound','native_source_lease_bound'))
    assert receipt['production_default_EN0']
    assert symbol_bytes(build/'menu_EN0.o','iq4_f3_after_file_settings_append_01')==bytes.fromhex('c0035fd6')
    assert receipt['objects'][0]['undefined_symbols']==['iq4_export_geometry']
    for r in receipt['objects']+[receipt['native_contract']]:
        f=ROOT/r['path'];b=f.read_bytes()
        assert len(b)==r['bytes'] and hashlib.sha256(b).hexdigest()==r['sha256'],r['path']
    commands=json.loads((build/'COMMANDS.json').read_text())
    assert all(c['exit']==0 for c in commands)
    print(json.dumps(dict(frozen_members=len(source['members']),host_receipts=36,
                         AArch64_ET_REL=5,EN0_actual_function='ret only',
                         firmware_candidate_produced=False,device_access=False)))

if __name__=='__main__':main()
