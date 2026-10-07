#!/usr/bin/env python3
"""55 cleanup check: only two frozen receipt BLs may alter RAW windows."""
from pathlib import Path
import argparse
import importlib.util
import json
import struct
import sys
from types import SimpleNamespace

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT / 'tools/firmware/jpeg_restart_01'))
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
    # Derive actual own FDE starts from this candidate's bytes, not only the
    # linker report. Full CFI/LSDA identity has its separate frozen verifier.
    executable = [(h[3], h[3]+h[5]) for h in user.sh if h[2]&2 and h[2]&4]
    own_fdes = []
    for index, h in enumerate(user.sh):
        if user.names[index].startswith('.f1.') and user.names[index].endswith('.eh_frame'):
            own_fdes += m.fde_entries(SimpleNamespace(data=user.section_bytes(index), va=h[3]), executable)
    assert sorted(own_fdes) == sorted(map(tuple, report['own_fde_pairs']))
    fde_starts = {pc for pc, _ in own_fdes}
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
    # These are the only accepted differences in the original three RAW
    # windows. They must be the exact frozen receipt55 definitions as well as
    # registered, linked BLs with actual candidate FDE/execute coverage.
    receipt_path = ROOT / 'tools/firmware/stock_new_raw_receipt_55/LINK_INPUTS.json'
    receipt_record = row(receipt_path, dict(sha256=
        'ca41b69e9c005980f8b131b4990d229f421b98d96387a64a8ad194d6fdc345ed'))
    receipt = json.loads(receipt_path.read_text())
    receipt_source = row(receipt['source_manifest'], dict(sha256=
        receipt['source_manifest_sha256']))
    frozen_hooks = {h['va']:h for h in receipt['BL_hooks']}
    frozen_defs = set()
    spec_objects = {o['path']:o for o in spec['objects']}
    for obj in receipt['objects']:
        row(obj['path'], obj)
        assert spec_objects.get(obj['path']) == obj, obj['path']
        frozen_defs.update(symbols(obj)[0])
    permitted = {
        0x8dc634: ('iq4_new_raw_refs_55', 'aaa5ff97', 0x8c5cdc),
        0x49686c: ('iq4_new_raw_backup_enqueue_55', '55080094', 0x4989c0),
    }
    raw_preserved=[]
    raw_registered=[]
    seen=set()
    for name,start,end in raw_ranges:
        sites={va for va in registered if start<=va<end}
        expected_sites={va for va in permitted if start<=va<end}
        assert sites == expected_sites, (name, sites, expected_sites)
        oldoff=stock.va_offset(start,end-start);newoff=user.va_offset(start,end-start)
        before=stock.data[oldoff:oldoff+end-start]
        after=user.data[newoff:newoff+end-start]
        allowed_bytes=set()
        records=[]
        for va in sorted(sites):
            symbol, oldhex, original_target = permitted[va]
            h,kind=registered[va];linked,linked_kind=actual[va]
            frozen=frozen_hooks[va]
            assert kind==linked_kind=='BL'
            assert h['target_symbol']==linked['symbol']==frozen['target_symbol']==symbol
            assert h['old_hex']==frozen['old_hex']==oldhex
            assert h['original_target']==frozen['original_target']==original_target
            assert symbol in frozen_defs
            relative=va-start
            oldbytes=before[relative:relative+4];newbytes=after[relative:relative+4]
            assert oldbytes==bytes.fromhex(oldhex)==bytes.fromhex(linked['old_bytes'])
            assert newbytes==bytes.fromhex(linked['new_bytes'])
            assert linked['file_offset']==user.va_offset(va,4)
            assert linked['old_target']==original_target
            oldinsn=struct.unpack('<I',oldbytes)[0]
            assert oldinsn&0xfc000000==0x94000000
            immediate=oldinsn&0x3ffffff
            if immediate&(1<<25):immediate-=1<<26
            assert va+immediate*4==original_target
            target=linked['new_target']
            assert target==report['own_symbols'][symbol] and target in fde_starts
            assert any(p[0]==1 and p[1]&1 and p[3]<=target<p[3]+p[5] for p in user.ph)
            insn=struct.unpack('<I',newbytes)[0]
            assert insn&0xfc000000==0x94000000
            immediate=insn&0x3ffffff
            if immediate&(1<<25):immediate-=1<<26
            assert va+immediate*4==target
            allowed_bytes.update(range(relative,relative+4));seen.add(va)
            record=dict(va=va,bytes=4,stock_hex=oldbytes.hex(),candidate_hex=newbytes.hex(),
                original_target_va=original_target,registered_target=symbol,
                actual_target_va=target,branch_kind='BL',exact_frozen_receipt_definition=True,
                actual_candidate_FDE_start_verified=True,actual_registered_branch_verified=True)
            records.append(record);raw_registered.append(record)
        assert all(x==y or index in allowed_bytes for index,(x,y) in enumerate(zip(before,after))),name
        assert len(before)==len(after)==end-start
        raw_preserved.append(dict(name=name,start_va=start,end_va=end,bytes=end-start,
            stock_bytes_preserved_except_exact_registered_sites=True,
            unmodified_bytes=end-start-len(allowed_bytes),no_registered_hook=not bool(sites),
            exact_registered_receipt_sites=records))
    assert seen==set(permitted) and sum(r['bytes'] for r in raw_registered)==8
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
    result = dict(schema='iq4_stock_storage_release_cleanup_check_55',
        build=row(a.build), exclusions=row(a.exclusions), spec=row(spec_path),
        User=row(user_path), restored_original_sites=restored,
        reclaimed_sites=reclaimed,unknown_original_differences_rejected=True,
        original_RAW_save_chain_windows=raw_preserved,
        RAW_save_fanout_completion_retirement_hooks_added=True,
        exact_receipt_RAW_hooks=raw_registered, receipt55_link=receipt_record,
        receipt55_source=receipt_source, actual_candidate_own_FDE_pairs_verified=True,
        original_RAW_bytes_except_exact_eight_hook_bytes_preserved=True,
        baseline_checker=row(ROOT / 'tools/firmware/jpeg_restart_01/check.py'),
        checker=row(Path(__file__)),
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
