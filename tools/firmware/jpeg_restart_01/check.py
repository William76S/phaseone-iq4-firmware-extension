#!/usr/bin/env python3
"""Bounded offline check of cleanup link; no seal, package or device."""
from pathlib import Path
import argparse
import importlib.util
import json
import struct
import sys

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(Path(__file__).resolve().parent))
from prepare import row, symbols


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--build', type=Path, required=True)
    ap.add_argument('--exclusions', type=Path, required=True)
    ap.add_argument('--output', type=Path, required=True)
    a = ap.parse_args()
    assert not a.output.exists()
    build = json.loads(a.build.read_text())
    excluded = json.loads(a.exclusions.read_text())
    spec_path = ROOT / row(build['spec']['path'], build['spec'])['path']
    spec = json.loads(spec_path.read_text())
    user_path = ROOT / row(build['User']['path'], build['User'])['path']
    stock_path = ROOT / row(build['stock']['path'], build['stock'])['path']
    report_path = ROOT / row(build['link_report']['path'], build['link_report'])['path']
    report = json.loads(report_path.read_text())
    loader = importlib.util.spec_from_file_location('cleanup_elf',
        ROOT / 'tools/firmware/f1_user_elf_append_03/elf_append.py')
    m = importlib.util.module_from_spec(loader)
    sys.modules[loader.name] = m
    loader.loader.exec_module(m)
    stock = m.Elf(stock_path.read_bytes(), 2, 'original User')
    user = m.Elf(user_path.read_bytes(), 2, 'cleanup User')
    registered = {}
    for key, default_kind in [('BL_hooks','BL'),('auxiliary_hooks',None)]:
        for h in spec[key]:
            assert h['va'] not in registered, h['va']
            registered[h['va']] = (h,default_kind or h['branch_kind'])
    actual = {}
    for key, default_kind in [('hooks','BL'),('auxiliary_hooks',None)]:
        for h in report[key]:
            assert h['va'] not in actual, h['va']
            actual[h['va']] = (h,default_kind or h['branch_kind'])
    assert set(registered) == set(actual)
    restored, reclaimed = [], []
    for h in excluded['BL_hooks'] + excluded['auxiliary_hooks']:
        expected = bytes.fromhex(h['old_hex'])
        original_offset = stock.va_offset(h['va'], len(expected))
        output_offset = user.va_offset(h['va'], len(expected))
        before = stock.data[original_offset:original_offset + len(expected)]
        after = user.data[output_offset:output_offset + len(expected)]
        assert before == expected, h['target_symbol']
        if h['va'] not in registered:
            assert after == expected, h['target_symbol']
            restored.append(dict(va=h['va'], bytes=len(expected), hex=after.hex(),
                                 former_target=h['target_symbol']))
            continue
        new, kind = registered[h['va']]
        linked, linked_kind = actual[h['va']]
        assert len(expected)==4 and bytes.fromhex(new['old_hex'])==expected
        assert new['target_symbol'] not in spec['removed_legacy_hook_symbols']
        assert new['target_symbol']==linked['symbol'] and kind==linked_kind
        assert linked['file_offset']==output_offset
        assert bytes.fromhex(linked['old_bytes'])==expected
        assert bytes.fromhex(linked['new_bytes'])==after
        assert linked['new_target']==report['own_symbols'][new['target_symbol']]
        target=linked['new_target']
        assert target in {pc for pc,_ in report['own_fde_pairs']}
        assert any(p[0]==1 and p[1]&1 and p[3]<=target<p[3]+p[5] for p in user.ph)
        instruction=struct.unpack('<I',after)[0]
        assert kind in ['B','BL']
        assert instruction&0xfc000000==(0x14000000 if kind=='B' else 0x94000000)
        immediate=instruction&0x3ffffff
        if immediate&(1<<25): immediate-=1<<26
        assert h['va']+immediate*4==target
        reclaimed.append(dict(va=h['va'],bytes=4,stock_hex=before.hex(),
            candidate_hex=after.hex(),former_target=h['target_symbol'],
            registered_target=new['target_symbol'],actual_target_va=target,
            branch_kind=kind,exact_registered_branch_verified=True))
    assert len(restored)+len(reclaimed)==31
    # All original differences must belong to backend's explicit ELF metadata,
    # version, init-array or registered hook spans; reject unrecorded changes.
    allowed=report['allowed_original_spans']
    for offset,(before,after) in enumerate(zip(stock.data,user.data)):
        if before!=after:
            assert any(start<=offset<start+n for start,n,_ in allowed),offset
    raw_ranges=[('Main_original_RAW_groups',0x41a730,0x41a8e8),
                ('RAW_save_fanout_completion_retirement',0x8dafa0,0x8dc740),
                ('IFM_original_RAW_expected_stored_bridge',0x496668,0x4968f0)]
    raw_preserved=[]
    for name,start,end in raw_ranges:
        assert not any(start<=va<end for va in registered),name
        oldoff=stock.va_offset(start,end-start);newoff=user.va_offset(start,end-start)
        assert stock.data[oldoff:oldoff+end-start]==user.data[newoff:newoff+end-start],name
        raw_preserved.append(dict(name=name,start_va=start,end_va=end,
            bytes=end-start,stock_bytes_preserved=True,no_registered_hook=True))
    kept_defs = set().union(*(symbols(r)[0] for r in spec['objects']))
    removed_defs = set().union(*(symbols(r)[0] for r in excluded['objects']))
    forbidden = removed_defs - kept_defs
    own = set(report['own_symbols'])
    assert not own & forbidden, sorted(own & forbidden)
    assert not any(n.startswith('f3_coordinator_') for n in own)
    assert not own & set(excluded['required_functions'])
    assert all(n not in own for n in excluded['required_functions'])
    assert report['original_body_preservation_verified'] is True
    assert report['supplemental_original_body_preservation_verified'] is True
    assert report['original_init_entries_preserved'] == 340
    assert report['new_init_entries'] == 1
    assert len(report['hooks']) + len(report['auxiliary_hooks']) == spec['expected_hook_count']
    assert build['custom_F3_pipeline_removed'] is True
    assert build['stock_JPEG_reused'] is True
    for key in ['F3_manual_full_RAW_implementation_linked',
                'F3_SD_automatic_implementation_linked',
                'F3_XQD_automatic_implementation_linked', 'stock_JPEG_XQD_accepted',
                'target_executed', 'camera_accessed', 'persistent_installation_safe']:
        assert build[key] is False, key
    result = dict(schema='iq4_jpeg_restart_cleanup_check_01',
        build=row(a.build), exclusions=row(a.exclusions), spec=row(spec_path),
        User=row(user_path), restored_original_sites=restored,
        reclaimed_sites=reclaimed,unknown_original_differences_rejected=True,
        original_RAW_save_chain_windows=raw_preserved,
        RAW_save_fanout_completion_retirement_hooks_added=False,
        removed_unique_definition_count=len(forbidden),
        removed_unique_definitions_absent=True, coordinator_absent=True,
        removed_required_exports_absent=True,
        retained_precompiled_object_count=len(spec['objects']),
        actual_total_object_count=build['object_count'],
        actual_hook_count=spec['expected_hook_count'],
        original_340_initializers_preserved=True, own_initializer_added=True,
        old_F3_removed_or_explicitly_reclaimed_sites_verified=True,
        camera_accessed=False, stock_JPEG_XQD_accepted=False,
        persistent_installation_safe=False)
    a.output.write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(dict(restored_sites=len(restored),
        reclaimed_sites=len(reclaimed),
        absent_removed_unique_definitions=len(forbidden),
        objects=build['object_count'], hooks=spec['expected_hook_count'],
        receipt=row(a.output))))


if __name__ == '__main__':
    main()
