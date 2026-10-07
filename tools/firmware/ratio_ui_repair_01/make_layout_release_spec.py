#!/usr/bin/env python3
"""Freeze the EXP horizontal-label correction over exact 6.03.47."""
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
    parser.add_argument('--layout-manifest', required=True)
    parser.add_argument('--layout-manifest-sha256', required=True)
    parser.add_argument('--layout-object', required=True)
    parser.add_argument('--layout-object-sha256', required=True)
    args = parser.parse_args()
    old = 'tools/firmware/f1_f3_f4_user_integration_05/INPUTS_REPAIR_18.json'
    assert row(old)['sha256'] == '496efe5675a5222c6bb905505169c1183c2c7de49f25bfee21a7a165620d8108'
    manifest, obj = row(args.layout_manifest), row(args.layout_object)
    assert manifest['sha256'] == args.layout_manifest_sha256
    assert obj['sha256'] == args.layout_object_sha256
    inputs = json.loads((ROOT / old).read_text())
    removed = 'analysis/firmware/dual_exposure_five_ev_01/SOURCE_SHA256.json'
    assert removed in {x['path'] for x in inputs['source_manifests']}
    inputs['source_manifests'] = [x for x in inputs['source_manifests'] if x['path'] != removed] + [manifest]
    old_object = 'analysis/firmware/dual_exposure_five_ev_01/build_sealed/dual.o'
    assert old_object in {x['path'] for x in inputs['objects']}
    inputs['objects'] = [obj if x['path'] == old_object else x for x in inputs['objects']]
    inputs['integration_revision'] = '19_dual_EXP_label_horizontal_width'
    inputs['scope'] += '; EXP native label uses full center horizontal width, original arrows/font/vertical placement retained'
    inputs['dual_EXP_label_hardware_accepted'] = False
    dest = ROOT / 'tools/firmware/f1_f3_f4_user_integration_05/INPUTS_REPAIR_19.json'
    assert not dest.exists()
    dest.write_text(json.dumps(inputs, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps(row(dest), ensure_ascii=False))


if __name__ == '__main__':
    main()
