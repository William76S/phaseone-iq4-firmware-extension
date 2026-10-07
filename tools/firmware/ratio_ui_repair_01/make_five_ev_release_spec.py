#!/usr/bin/env python3
"""Bind the repaired +5EV component to the exact49 baseline; no camera access."""
from pathlib import Path
import argparse
import copy
import hashlib
import json

ROOT = Path(__file__).resolve().parents[3]
BASE = 'tools/firmware/f1_f3_f4_user_integration_05/INPUTS_REPAIR_20.json'
BASE_SHA = 'dc3a6daf5c9f3a7b081857bc6c9ba2e918f1afaf5c5f0fc405deaf9addc808be'
OLD_MANIFEST = 'analysis/firmware/dual_46_rollback_layout_01/SOURCE_SHA256.json'
OLD_OBJECT = 'analysis/firmware/dual_46_rollback_layout_01/build/dual.o'


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
    pin = row(link['runtime_pin_header'])
    assert pin['sha256'] == link['runtime_pin_header_sha256']

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
    assert {x['va'] for x in link['BL_hooks'] + link['auxiliary_hooks']} == {0x53865c, 0x538810}
    assert len(inputs['BL_hooks']) + len(inputs['auxiliary_hooks']) == 43
    assert len({x['va'] for x in inputs['BL_hooks'] + inputs['auxiliary_hooks']}) == 43
    for key in ['BL_hooks', 'auxiliary_hooks']:
        assert len({x['va'] for x in inputs[key]}) == len(inputs[key])
    assert len({x['symbol'] for x in inputs['aliases']}) == len(inputs['aliases'])
    assert len(set(inputs['required_functions'])) == len(inputs['required_functions'])
    inputs['expected_hook_count'] = 43
    inputs['integration_revision'] = '21_dual_plus_5EV_real_native_domain'
    inputs['scope'] = ('Dual +0.3..+5EV in thirds, default+3, repaired native169 configuration '
                       'admission and guarded factory seconds domain; native-second exposure '
                       'request cap/readout bounds and final native Status setter clamp; '
                       'retain49 EXP label/arrow layout and Ratio Mask; inherited JPEG, '
                       'recording and tether implementations unchanged')
    inputs['dual_exposure_max_thirds'] = 15
    inputs['dual_exposure_requested_max_EV'] = 5
    inputs['dual_exposure_plus_5EV_hardware_accepted'] = False
    inputs['dual_configuration_original_maximum'] = 169
    inputs['dual_seconds_normal_lookup_exclusive_maximum'] = 168
    inputs['dual_request_seconds_cap'] = 1.0
    inputs['dual_base_release'] = '6.03.49'
    inputs.pop('dual_functional_baseline_commit', None)
    inputs.pop('dual_functional_rollback_hardware_accepted', None)

    # Every unrelated field and every non-Dual component stays on49.
    allowed = {'source_manifests', 'objects', 'BL_hooks', 'auxiliary_hooks', 'aliases',
               'required_functions', 'expected_hook_count', 'integration_revision', 'scope',
               'dual_exposure_max_thirds', 'dual_exposure_requested_max_EV',
               'dual_exposure_plus_5EV_hardware_accepted', 'dual_configuration_original_maximum',
               'dual_seconds_normal_lookup_exclusive_maximum', 'dual_request_seconds_cap',
               'dual_base_release', 'dual_functional_baseline_commit',
               'dual_functional_rollback_hardware_accepted'}
    for key in set(inputs) | set(base):
        assert key in allowed or inputs.get(key) == base.get(key), key
    dest = ROOT / 'tools/firmware/f1_f3_f4_user_integration_05/INPUTS_REPAIR_21.json'
    assert not dest.exists()
    dest.write_text(json.dumps(inputs, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps(row(dest), ensure_ascii=False))


if __name__ == '__main__':
    main()
