#!/usr/bin/env python3
"""Lock the exact linked candidate and its recursively checked local inputs."""
from pathlib import Path
import argparse, hashlib, json, re

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
SEEDS = [
    'tools/firmware/f1_user_elf_append_02/SOURCE_SHA256.json',
    'tools/firmware/f1_stock_menu_04/SOURCE_SHA256.json',
    'tools/firmware/f4_native_source_02/SOURCE_SHA256.json',
    'tools/firmware/f4_native_source_03/SOURCE_SHA256.json',
    'tools/firmware/f4_codec_cleanup_01/SOURCE_SHA256.json',
    'tools/firmware/f4_mkv_software_zero_01/SOURCE_SHA256.json',
    'tools/firmware/f3_native_card_bridge_06/SOURCE_SHA256.json',
    'tools/firmware/movie_card_01/SOURCE_SHA256.json',
    'tools/firmware/f3_native_jpeg8_binding_01/SOURCE_SHA256.json',
    'analysis/firmware/native_mkv_build_01/SOURCE_SHA256.json',
    'tools/firmware/f3_core_native_receipt_01/SOURCE_SHA256.json',
    'tools/firmware/f3_stream_export_03/SOURCE_SHA256.json',
    'tools/firmware/f3_stream_export_04/SOURCE_SHA256.json',
    'tools/firmware/f4_native_source_03/LINK_OVERLAY.json',
    'tools/firmware/f4_codec_cleanup_01/LINK_OVERLAY.json',
    'tools/firmware/f4_mkv_software_zero_01/LINK_OVERLAY.json',
    'analysis/firmware/f1_f4_user_integration_build_02_attempt02/BUILD.json',
    'analysis/firmware/f1_f4_user_integration_build_02_attempt02/COMMANDS.json',
    'analysis/firmware/f1_f4_user_integration_build_02_attempt02/ROOT_INSPECTION.json',
    'analysis/firmware/f1_f4_user_integration_build_02_attempt02/LINKED_UNWIND_STATIC.json',
    'analysis/firmware/f1_f4_user_integration_build_02_repro03/BUILD.json',
    'analysis/firmware/f1_f4_user_integration_build_02_repro03/REPRO_IDENTITY.json',
    'analysis/firmware/f1_f4_inputs_recompiled_03/ARTIFACT_MAP.json',
    'analysis/firmware/f1_f4_inputs_recompiled_03/COMMANDS.json',
    'deploy/f1_f4_card_candidate_02/PLAN.json',
    'deploy/f1_f4_card_candidate_02/ROOT_PACKAGE_INSPECTION.json',
    'deploy/F1_F4_CARD_CANDIDATE_02.md',
    'tools/firmware/native_linked_unwind_01/verify.py',
]


def row(p):
    p = p.resolve()
    assert p.is_relative_to(ROOT)
    b = p.read_bytes()
    return dict(path=str(p.relative_to(ROOT)), bytes=len(b),
                sha256=hashlib.sha256(b).hexdigest())


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--verify', action='store_true')
    a = ap.parse_args()
    target = HERE / 'SOURCE_SHA256.json'
    if a.verify:
        j = json.loads(target.read_text())
        for e in j['files']:
            assert row(ROOT / e['path']) == e, e['path']
        print(f"PASS {len(j['files'])} exact local inputs; target acceptance absent")
        return
    assert not target.exists(), 'frozen manifest already exists'
    files = {}

    def visit(p, expected=None):
        p = p.resolve()
        e = row(p)
        if expected is not None:
            assert e['bytes'] == expected['bytes'] and e['sha256'] == expected['sha256'], e['path']
        if e['path'] in files:
            assert files[e['path']] == e
            return
        files[e['path']] = e
        if p.suffix == '.json':
            walk(json.loads(p.read_text()), p.parent)
        if p.suffix in ('.c', '.h', '.cpp', '.hpp', '.S'):
            for inc in re.findall(r'^\s*#\s*include\s*"([^"]+)"', p.read_text(), re.M):
                q = p.parent / inc
                if q.is_file():
                    visit(q)

    def resolve(rel, base):
        q = ROOT / rel
        return q if q.is_file() else base / rel

    def walk(x, base):
        if isinstance(x, dict):
            if {'path', 'bytes', 'sha256'} <= x.keys():
                q = Path(x['path'])
                # All package inputs are project-relative. Absolute artifact
                # paths in older diagnostic fields are not source identities.
                if not q.is_absolute():
                    visit(resolve(q, base), x)
            for key in ('members', 'files'):
                v = x.get(key)
                if isinstance(v, dict):
                    for rel, item in v.items():
                        if isinstance(item, dict) and {'bytes', 'sha256'} <= item.keys():
                            visit(resolve(rel, base), item)
            for v in x.values():
                walk(v, base)
        elif isinstance(x, list):
            for v in x:
                walk(v, base)

    for rel in SEEDS:
        visit(ROOT / rel)
    for p in HERE.iterdir():
        if p.is_file() and p.name != 'SOURCE_SHA256.json':
            visit(p)
    # lock the actual candidate bytes as well as the embedded User receipt.
    visit(ROOT / 'deploy/f1_f4_card_candidate_02/IQ4-user-only-candidate.fwp')
    result = dict(schema='iq4_F1_F4_candidate02_recursive_lock_01',
                  files=sorted(files.values(), key=lambda e: e['path']),
                  includes_export03_transitive_header_closure=True,
                  target_executed=False, camera_accessed=False,
                  persistent_recovery_verified=False)
    target.write_text(json.dumps(result, indent=2) + '\n')
    print(f"FROZEN {len(files)} exact inputs; not an install acceptance")


if __name__ == '__main__':
    main()
