#!/usr/bin/env python3
"""Prepare exact offline cleanup inputs; no target, SDK, camera or FWP.

Only frozen Input22 object/alias/hook records are filtered. New stock-JPEG LINK
inputs may append their locked objects, native hooks, manifests and exports.
Historical artifacts are retained for exact version rollback.
"""
from pathlib import Path
import argparse
import hashlib
import json
import subprocess

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
BASE = ROOT / 'tools/firmware/f1_f3_f4_user_integration_05/INPUTS_REPAIR_22.json'
BASE_SHA = '89e55e72db5f8746ba41f0fa9bb5c01012ab9cceeaddc06ba437950217fb1cfd'
NM = '/Library/Developer/CommandLineTools/usr/bin/llvm-nm'
KEEP_OBJECTS = set(range(26)) | {43, 60, 61, 68, 69, 70}
KEEP_MANIFESTS = {0, 1, 12, 24, 25, 26, 27, 28, 29, 30, 33, 37,
                  44, 45, 46, 52, 53, 54, 55, 56}


def row(path, expected=None):
    p = Path(path)
    p = (ROOT / p).resolve() if not p.is_absolute() else p.resolve()
    assert p.is_relative_to(ROOT), p
    b = p.read_bytes()
    item = dict(path=str(p.relative_to(ROOT)), bytes=len(b),
                sha256=hashlib.sha256(b).hexdigest())
    if expected:
        assert item['sha256'] == expected['sha256'], item['path']
        if 'bytes' in expected:
            assert item['bytes'] == expected['bytes'], item['path']
    return item


def symbols(item):
    r = row(item['path'], item)
    p = subprocess.run([NM, '--format=posix', str(ROOT / r['path'])],
                       check=True, capture_output=True, text=True)
    definitions, uses = set(), set()
    for line in p.stdout.splitlines():
        fields = line.split()
        if len(fields) < 2:
            continue
        if fields[1] == 'U':
            uses.add(fields[0])
        elif fields[1].upper() in {'T', 'D', 'B', 'R', 'V', 'W', 'C', 'A'}:
            definitions.add(fields[0])
    return definitions, uses


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--output', type=Path, required=True)
    ap.add_argument('--link-input', action='append', type=Path, default=[])
    a = ap.parse_args()
    assert row(BASE)['sha256'] == BASE_SHA
    base = json.loads(BASE.read_text())
    assert len(base['objects']) == 71 and len(base['BL_hooks']) == 33
    assert len(base['auxiliary_hooks']) == 10
    out = a.output.resolve()
    assert out.is_relative_to(ROOT) and not out.exists(), out

    definitions, uses = {}, {}
    for i, obj in enumerate(base['objects']):
        d, u = symbols(obj)
        uses[i] = u
        for name in d:
            definitions.setdefault(name, []).append(i)
    cross = []
    for i in sorted(KEEP_OBJECTS):
        for name in uses[i]:
            if name in definitions and not set(definitions[name]) & KEEP_OBJECTS:
                cross.append(dict(object=base['objects'][i]['path'], symbol=name,
                                  removed_definers=definitions[name]))
    assert not cross, cross
    wanted_aliases = set().union(*(uses[i] for i in KEEP_OBJECTS))

    def f3_hook(h):
        return h['target_symbol'].startswith('iq4_f3_')

    removed_objects = [v for i, v in enumerate(base['objects']) if i not in KEEP_OBJECTS]
    removed_bl = [h for h in base['BL_hooks'] if f3_hook(h)]
    removed_aux = [h for h in base['auxiliary_hooks'] if f3_hook(h)]
    removed_exports = [n for n in base['required_functions']
                       if n.startswith(('iq4_f3_', 'f3_coordinator_'))]
    spec = {k: v for k, v in base.items() if k.startswith(('ratio_', 'dual_'))}
    spec.update(schema=base['schema'], stock=base['stock'], compiler=base['compiler'],
                loader_abi_proof=base['loader_abi_proof'], C_flags=base['C_flags'],
                objects=[v for i, v in enumerate(base['objects']) if i in KEEP_OBJECTS],
                aliases=[v for v in base['aliases'] if v['symbol'] in wanted_aliases],
                BL_hooks=[h for h in base['BL_hooks'] if not f3_hook(h)],
                auxiliary_hooks=[h for h in base['auxiliary_hooks'] if not f3_hook(h)],
                source_manifests=[v for i, v in enumerate(base['source_manifests'])
                                  if i in KEEP_MANIFESTS],
                receipts=[row(BASE), base['loader_abi_proof']], overlay_inputs=[],
                compile=[dict(source=row(HERE / 'initialize.c'), object_name='initialize.o'),
                         base['compile'][1]],
                required_functions=[n for n in base['required_functions']
                                    if n not in removed_exports],
                target_executed=False, camera_accessed=False,
                custom_F3_pipeline_removed=True, stock_JPEG_reused=True,
                removed_legacy_hook_symbols=sorted({h['target_symbol']
                    for h in removed_bl + removed_aux}),
                stock_JPEG_XQD_bridge_linked=False,
                F3_manual_full_RAW_implementation_linked=False,
                SD_automatic_only=False, XQD_automatic_implementation=False,
                SD_automatic_implementation=False,
                recording_default_fs_id=base['recording_default_fs_id'],
                integration_revision='jpeg_restart_cleanup_01',
                scope='Restore stock JPEG task/Off-New-All/size; exclude old F3 '
                      'renderer/export/storage overrides, preserve Ratio/Dual/F4; '
                      'optional new stock-JPEG destination checked-write bridge')
    for name in ['iq4_extensions_installation_stage_02', 'iq4_f1_menu_initialize_04']:
        if name not in spec['required_functions']:
            spec['required_functions'].append(name)

    link_rows = []
    for input_path in a.link_input:
        link_row = row(input_path)
        j = json.loads((ROOT / link_row['path']).read_text())
        assert j.get('objects'), link_row['path']
        for v in j['objects']:
            spec['objects'].append(row(v['path'], v))
        for key in ['aliases', 'BL_hooks', 'auxiliary_hooks', 'compile']:
            spec[key].extend(j.get(key, []))
        for key in ['required_functions', 'new_required_functions']:
            spec['required_functions'].extend(j.get(key, []))
        for v in j.get('source_manifests', []):
            spec['source_manifests'].append(row(v['path'], v))
        if j.get('source_manifest'):
            spec['source_manifests'].append(row(j['source_manifest'],
                dict(sha256=j['source_manifest_sha256'])))
        for v in j.get('receipts', []):
            spec['receipts'].append(row(v['path'], v))
        spec['receipts'].append(link_row)
        link_rows.append(link_row)
        if any('stock_jpeg_xqd' in v['path'] for v in j['objects']):
            spec['stock_JPEG_XQD_bridge_linked'] = True

    # Independent stock-JPEG code shares the exact existing syscall/errno
    # aliases with Ratio settings. Reuse an identical native binding, reject
    # any address/expected-byte conflict; descriptive kind labels may differ.
    alias_table = {}
    for binding in spec['aliases']:
        name = binding['symbol']
        if name in alias_table:
            previous = alias_table[name]
            assert (previous['va'], previous['original_first16_LE']) == (
                binding['va'], binding['original_first16_LE']), name
        else:
            alias_table[name] = binding
    spec['aliases'] = list(alias_table.values())
    for key, field in [('objects', 'path'), ('aliases', 'symbol'),
                       ('BL_hooks', 'va'), ('auxiliary_hooks', 'va')]:
        ids = [v[field] for v in spec[key]]
        assert len(ids) == len(set(ids)), (key, ids)
    assert not ({h['va'] for h in spec['BL_hooks']} &
                {h['va'] for h in spec['auxiliary_hooks']})
    spec['required_functions'] = list(dict.fromkeys(spec['required_functions']))
    spec['expected_hook_count'] = len(spec['BL_hooks']) + len(spec['auxiliary_hooks'])

    stock = (ROOT / row(base['stock']['path'], base['stock'])['path']).read_bytes()
    for h in removed_bl + removed_aux:
        old = bytes.fromhex(h['old_hex'])
        assert stock[h['va'] - 0x400000:h['va'] - 0x400000 + len(old)] == old
    excluded = dict(schema='iq4_jpeg_restart_active_exclusions_01', baseline=row(BASE),
                    objects=removed_objects, BL_hooks=removed_bl, auxiliary_hooks=removed_aux,
                    required_functions=removed_exports,
                    aliases=[v for v in base['aliases'] if v['symbol'] not in wanted_aliases],
                    source_manifests=[v for i, v in enumerate(base['source_manifests'])
                                      if i not in KEEP_MANIFESTS],
                    obsolete_initializer=base['compile'][0],
                    kept_precompiled_objects_before_new_link=len(KEEP_OBJECTS),
                    kept_hook_count_before_new_link=12,
                    retained_to_removed_symbol_edges=cross,
                    removed_hook_original_bytes_match=True,
                    native_JPEG_task_and_size_restored_by_absent_hooks=True,
                    historical_files_removed=False, camera_accessed=False)
    out.mkdir(parents=True)
    (out / 'EXCLUSIONS.json').write_text(json.dumps(excluded, indent=2) + '\n')
    own = [row(HERE / name) for name in
           ['initialize.c', 'prepare.py', 'build.py', 'test_initialize.c',
            'check.py', 'README.md']]
    own.extend([row(ROOT / base['compile'][1]['source']['path'],
                    base['compile'][1]['source']),
                row(ROOT / 'tools/firmware/native_linked_contract_01/contract.h'),
                row(ROOT / 'tools/firmware/native_copy_rtti_01/rtti.h'),
                row(ROOT / 'tools/firmware/native_runtime_01/self_read.h'),
                row(ROOT / 'tools/firmware/f3_stream_transaction_02/sha256.h')])
    own_manifest = out / 'SOURCE_SHA256.json'
    own_manifest.write_text(json.dumps(dict(schema='iq4_jpeg_restart_sources_01',
        members=own, baseline=row(BASE), retained_objects=spec['objects'],
        new_link_inputs=link_rows, device_accessed=False), indent=2) + '\n')
    spec['source_manifests'].append(row(own_manifest))
    (out / 'INPUTS_CLEANUP_DRAFT.json').write_text(json.dumps(spec, indent=2) + '\n')
    print(json.dumps(dict(output=str(out.relative_to(ROOT)),
        precompiled_objects=len(spec['objects']), hooks=spec['expected_hook_count'],
        removed_objects=len(removed_objects), new_links=len(link_rows),
        spec_sha256=row(out / 'INPUTS_CLEANUP_DRAFT.json')['sha256'])))


if __name__ == '__main__':
    main()
