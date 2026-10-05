#!/usr/bin/env python3
"""Validate only frozen files and static identity; no firmware execution."""
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]

def main():
    own = Path(__file__).resolve().parent
    lock = json.loads((own/'SOURCE_SHA256.json').read_text())
    for row in lock['members']:
        f = ROOT/row['path']
        b = f.read_bytes()
        assert len(b) == row['bytes'] and hashlib.sha256(b).hexdigest() == row['sha256'], row['path']
    evidence = ROOT/'analysis/firmware/f3_native_save_settings_static_01'
    source = json.loads((evidence/'exact_bytes.json').read_text())
    assert source['input_sha256'] == '9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
    table = json.loads((evidence/'tables.json').read_text())
    by = {r['label']:r for r in table if r['label'] != 'resource_pair'}
    assert [r['value'] for r in by['jpeg_size']['records']] == [0,1]
    assert [r['value'] for r in by['jpeg_mode']['records']] == [0,1,2]
    assert by['directory_sd_policy']['records'][2] == dict(mode=2,b4=1,b5=1,b6=1,b7=0)
    assert by['mode_dto']['slots']['0x100'] == '0x5bd0ec'
    assert by['size_dto']['slots']['0x100'] == '0x5bc210'
    incoming = json.loads((evidence/'incoming_calls.json').read_text())
    assert incoming['direct_BL_only']['498994'] == [0x496888]
    assert incoming['indirect_alias_complete'] is False
    assert [r['va'] for r in incoming['direct_byte_imm_fb5_only']] == [0x495c88,0x496874,0x8e263c]
    print(json.dumps(dict(frozen_members=len(lock['members']), exact_windows=len(source['windows']),
                         contract_checks=9, target_executed=False, device_access=False)))

if __name__ == '__main__':
    main()
