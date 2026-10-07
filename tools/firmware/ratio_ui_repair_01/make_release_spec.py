#!/usr/bin/env python3
"""Freeze the seven-ratio menu and Dual +5EV over exact 6.03.46."""
from pathlib import Path
import argparse
import hashlib
import json

ROOT = Path(__file__).resolve().parents[3]


def row(path):
    path = (ROOT / path).resolve()
    assert path.is_relative_to(ROOT)
    data = path.read_bytes()
    return dict(path=str(path.relative_to(ROOT)), bytes=len(data),
                sha256=hashlib.sha256(data).hexdigest())


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--dual-manifest', required=True)
    parser.add_argument('--dual-manifest-sha256', required=True)
    parser.add_argument('--dual-object', required=True)
    parser.add_argument('--dual-object-sha256', required=True)
    parser.add_argument('--dual-link-inputs', required=True)
    parser.add_argument('--dual-link-inputs-sha256', required=True)
    args = parser.parse_args()
    old = 'tools/firmware/f1_f3_f4_user_integration_05/INPUTS_REPAIR_17.json'
    assert row(old)['sha256'] == '12a23437130afbdfe8affae66261e94a86f34d513a282575d22ec6ed0707b4f1'
    manifest = row(args.dual_manifest)
    dual = row(args.dual_object)
    assert manifest['sha256'] == args.dual_manifest_sha256
    assert dual['sha256'] == args.dual_object_sha256
    assert row(args.dual_link_inputs)['sha256'] == args.dual_link_inputs_sha256
    additions = json.loads((ROOT / args.dual_link_inputs).read_text())
    inputs = json.loads((ROOT / old).read_text())
    removed = {
        'tools/firmware/dual_button_layout_01/SOURCE_SHA256.json',
        'analysis/firmware/ratio_quick_menu_build_01/SOURCE_SHA256.json'}
    assert removed <= {x['path'] for x in inputs['source_manifests']}
    inputs['source_manifests'] = [x for x in inputs['source_manifests']
                                 if x['path'] not in removed]
    inputs['source_manifests'] += [manifest, row('analysis/firmware/ratio_quick_menu_build_02/SOURCE_SHA256.json')]
    replacements = {
        'analysis/firmware/dual_button_layout_repair/build_final/dual.o': args.dual_object,
        'analysis/firmware/ratio_quick_menu_build_01/f1_menu.o':
            'analysis/firmware/ratio_quick_menu_build_02/f1_menu.o'}
    assert set(replacements) <= {x['path'] for x in inputs['objects']}
    inputs['objects'] = [row(replacements.get(x['path'], x['path']))
                         for x in inputs['objects']]
    for key in ('aliases', 'BL_hooks', 'auxiliary_hooks'):
        inputs[key] += additions.get(key, [])
    inputs['required_functions'] += additions.get('new_required_functions', additions.get('required_functions', []))
    inputs['expected_hook_count'] += len(additions.get('BL_hooks', [])) + len(additions.get('auxiliary_hooks', []))
    assert len({x['va'] for x in inputs['BL_hooks'] + inputs['auxiliary_hooks']}) == inputs['expected_hook_count']
    assert len({x['symbol'] for x in inputs['aliases']}) == len(inputs['aliases'])
    assert len(set(inputs['required_functions'])) == len(inputs['required_functions'])
    inputs['integration_revision'] = '18_dual_5EV_seven_ratio_choices'
    inputs['scope'] = ('Dual Exposure +1/3..+5EV in exact thirds via native ratio/setter, actual-second long cap, final bare-status clamp and native long-shutter quantization; '
                       'remove Off/Native ratio menu choice, preserve dedicated LV toggle and saved IDs')
    inputs['release_date'] = '2026-10-07'
    inputs['dual_exposure_max_thirds'] = 15
    inputs['dual_exposure_plus_5EV_hardware_accepted'] = False
    inputs['ratio_mask_menu_choices'] = 7
    dest = ROOT / 'tools/firmware/f1_f3_f4_user_integration_05/INPUTS_REPAIR_18.json'
    assert not dest.exists()
    dest.write_text(json.dumps(inputs, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps(row(dest), ensure_ascii=False))


if __name__ == '__main__':
    main()
