#!/usr/bin/env python3
"""Restore proven46 Dual behavior, retaining current EXP layout and Ratio menu."""
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
    parser.add_argument('--manifest', required=True)
    parser.add_argument('--manifest-sha256', required=True)
    parser.add_argument('--object', required=True)
    parser.add_argument('--object-sha256', required=True)
    args = parser.parse_args()
    base = 'tools/firmware/f1_f3_f4_user_integration_05/INPUTS_REPAIR_17.json'
    assert row(base)['sha256'] == '12a23437130afbdfe8affae66261e94a86f34d513a282575d22ec6ed0707b4f1'
    manifest, obj = row(args.manifest), row(args.object)
    assert manifest['sha256'] == args.manifest_sha256
    assert obj['sha256'] == args.object_sha256
    menu_manifest = row('analysis/firmware/ratio_quick_menu_build_02/SOURCE_SHA256.json')
    menu_object = row('analysis/firmware/ratio_quick_menu_build_02/f1_menu.o')
    assert menu_manifest['sha256'] == '735d401075ae89a3da82f2c0da344b0e5f77b28b27889d6bf2a921103a44d72e'
    assert menu_object['sha256'] == '443e5fa306f93097f6bf831953ad58e185e48ce279c54ad41733586dfd2675b5'
    inputs = json.loads((ROOT / base).read_text())
    manifests = {
        'tools/firmware/dual_button_layout_01/SOURCE_SHA256.json': manifest,
        'analysis/firmware/ratio_quick_menu_build_01/SOURCE_SHA256.json': menu_manifest,
    }
    objects = {
        'analysis/firmware/dual_button_layout_repair/build_final/dual.o': obj,
        'analysis/firmware/ratio_quick_menu_build_01/f1_menu.o': menu_object,
    }
    assert set(manifests).issubset(x['path'] for x in inputs['source_manifests'])
    assert set(objects).issubset(x['path'] for x in inputs['objects'])
    inputs['source_manifests'] = [manifests.get(x['path'], x) for x in inputs['source_manifests']]
    inputs['objects'] = [objects.get(x['path'], x) for x in inputs['objects']]
    inputs['integration_revision'] = '20_dual_functional_rollback_46_with_EXP_layout'
    inputs['scope'] = ('Restore46 Dual +0.3..+3EV functional behavior; retain EXP horizontal-label width '
                       'and native arrow layout; retain seven Ratio Mask choices/Opacity and LV quick toggle; '
                       'inherited JPEG/recording/tether code unchanged')
    inputs['dual_exposure_max_thirds'] = 9
    inputs['dual_exposure_requested_max_EV'] = 3
    inputs['dual_functional_baseline_commit'] = '775654b'
    inputs['ratio_mask_menu_choices'] = 7
    inputs['dual_functional_rollback_hardware_accepted'] = False
    assert inputs['expected_hook_count'] == 41
    dest = ROOT / 'tools/firmware/f1_f3_f4_user_integration_05/INPUTS_REPAIR_20.json'
    assert not dest.exists()
    dest.write_text(json.dumps(inputs, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps(row(dest), ensure_ascii=False))


if __name__ == '__main__':
    main()
