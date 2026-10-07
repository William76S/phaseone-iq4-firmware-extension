#!/usr/bin/env python3
"""Bind only the owned Dual arrow drawing change to the exact50 release."""
from pathlib import Path
import argparse
import copy
import hashlib
import json

ROOT = Path(__file__).resolve().parents[3]
BASE = 'tools/firmware/f1_f3_f4_user_integration_05/INPUTS_REPAIR_21.json'
BASE_SHA = '5dafa05e3cdf97e8dbd9960fca3904388474617b1666d64551e7b59e5ecea8a1'
OLD_MANIFEST = 'analysis/firmware/dual_5ev_domain_02/SOURCE_SHA256.json'
OLD_OBJECT = 'analysis/firmware/dual_5ev_domain_02/build_sealed/dual.o'


def row(path):
    path = (ROOT / path).resolve()
    assert path.is_relative_to(ROOT)
    data = path.read_bytes()
    return dict(path=str(path.relative_to(ROOT)), bytes=len(data),
                sha256=hashlib.sha256(data).hexdigest())


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--link-inputs', required=True)
    parser.add_argument('--link-inputs-sha256', required=True)
    args = parser.parse_args()
    assert row(BASE)['sha256'] == BASE_SHA
    assert row(args.link_inputs)['sha256'] == args.link_inputs_sha256
    link = json.loads((ROOT / args.link_inputs).read_text())
    manifest = row(link['source_manifest'])
    assert manifest['sha256'] == link['source_manifest_sha256']
    assert len(link['objects']) == 1
    obj = row(link['objects'][0]['path'])
    assert obj['sha256'] == link['objects'][0]['sha256']
    assert row(link['runtime_pin_header'])['sha256'] == link['runtime_pin_header_sha256']
    base = json.loads((ROOT / BASE).read_text())
    inputs = copy.deepcopy(base)
    assert sum(x['path'] == OLD_MANIFEST for x in inputs['source_manifests']) == 1
    assert sum(x['path'] == OLD_OBJECT for x in inputs['objects']) == 1
    inputs['source_manifests'] = [manifest if x['path'] == OLD_MANIFEST else x
                                 for x in inputs['source_manifests']]
    inputs['objects'] = [obj if x['path'] == OLD_OBJECT else x for x in inputs['objects']]
    for key in ['BL_hooks', 'auxiliary_hooks', 'aliases']:
        inputs[key] += link[key]
    inputs['required_functions'] += link['new_required_functions']
    all_hooks = inputs['BL_hooks'] + inputs['auxiliary_hooks']
    assert len({x['va'] for x in all_hooks}) == len(all_hooks)
    assert len({x['symbol'] for x in inputs['aliases']}) == len(inputs['aliases'])
    assert len(set(inputs['required_functions'])) == len(inputs['required_functions'])
    inputs['expected_hook_count'] = len(all_hooks)
    inputs['integration_revision'] = '22_owned_Dual_arrow_glyph_alignment'
    inputs['scope'] = ('Owned Dual EXP plus/minus glyph vertical alignment with original70x70 '
                       'touch rectangles; retain50 +0.3..+5EV/default3/request1s bounds, '
                       'Ratio Mask and all other implementations')
    inputs['dual_base_release'] = '6.03.50'
    inputs['dual_glyph_alignment_hardware_accepted'] = False
    allowed = {'source_manifests', 'objects', 'BL_hooks', 'auxiliary_hooks', 'aliases',
               'required_functions', 'expected_hook_count', 'integration_revision', 'scope',
               'dual_base_release', 'dual_glyph_alignment_hardware_accepted'}
    for key in set(inputs) | set(base):
        assert key in allowed or inputs.get(key) == base.get(key), key
    dest = ROOT / 'tools/firmware/f1_f3_f4_user_integration_05/INPUTS_REPAIR_22.json'
    assert not dest.exists()
    dest.write_text(json.dumps(inputs, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps(row(dest), ensure_ascii=False))


if __name__ == '__main__':
    main()
