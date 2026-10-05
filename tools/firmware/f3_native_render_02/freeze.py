#!/usr/bin/env python3
"""Freeze only owned source and finite evidence; never install or touch a device."""
import argparse
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
TEST = ROOT / 'tests/f3_native_render_02'
ANALYSIS = ROOT / 'analysis/firmware/f3_native_render_02'
EXCLUDED = {'SOURCE_SHA256.json', 'MANIFEST.json', 'LINK_INPUT.json'}


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def row(path):
    return {'path': str(path.relative_to(ROOT)), 'bytes': path.stat().st_size,
            'sha256': digest(path)}


def save(path, value):
    path.write_text(json.dumps(value, indent=2) + '\n')


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--validation', type=Path, required=True)
    args = parser.parse_args()
    validation = args.validation.resolve()
    assert validation.is_relative_to(ROOT) and validation.name == 'VALIDATION.json'
    v = json.loads(validation.read_text())
    assert not v['target_executed'] and not v['camera_accessed']
    assert v['aarch64_wrapper_stack_contract_checked']
    assert len(v['target_objects']) == 7 and all(o['byte_identical'] for o in v['target_objects'])
    sources = sorted(p for folder in (HERE, TEST) for p in folder.iterdir()
                     if p.is_file() and p.name not in EXCLUDED)
    save(HERE / 'SOURCE_SHA256.json', {
        'schema': 'iq4_f3_native_render_02_source', 'files': [row(p) for p in sources],
        'dependencies': v['dependencies'], 'original_user_sha256':
        '9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb',
        'camera_accessed': False, 'native_acceptance': False})
    source_sha = digest(HERE / 'SOURCE_SHA256.json')
    hooks = [
        (0x963d28, 0x9227b0, 'iq4_f3_decode_native_reader_wrapper_02'),
        (0x9226c0, 0x921fe8, 'iq4_f3_decode_native_row_wrapper_02'),
        (0x9226d8, 0x921fe8, 'iq4_f3_decode_native_row_wrapper_02'),
        (0x922a1c, 0x716e60, 'iq4_f3_decode_native_join_wrapper_02')]
    save(HERE / 'LINK_INPUT.json', {
        'schema': 'iq4_f3_native_render_02_link', 'source_sha256': source_sha,
        'validation': row(validation), 'objects': v['target_objects'],
        'original_aliases': {'iq4_f3_original_raw_reader_02': 0x9227b0,
                             'iq4_f3_original_row_decode_02': 0x921fe8,
                             'iq4_f3_original_decode_pool_join_02': 0x716e60,
                             'iq4_native_original_syscall_01': 0x40ae40},
        'hook_replacements': [{'va': pc, 'original_target': to, 'wrapper': symbol}
                              for pc, to, symbol in hooks],
        'required_external_source': [
            'tools/firmware/f3_raw_file_source_01/reader_stage.cpp',
            'tools/firmware/f3_raw_file_source_01/source_builder.cpp',
            'tools/firmware/f3_source_dependencies_01/dependencies.cpp',
            'tools/firmware/f3_core_native_receipt_01/receipt.c',
            'tools/firmware/f3_core_native_receipt_01/wrappers.S',
            'tools/firmware/native_runtime_01/self_read.c'],
        'required_core_hook_slots': [0x964860, 0x91a78c, 0x91a964],
        'cpp_unwind_target_accepted': False, 'target_executed': False,
        'firmware_produced': False})
    save(ANALYSIS / 'RESULT.json', {
        'schema': 'iq4_f3_native_render_02_result', 'source_sha256': source_sha,
        'link': row(HERE / 'LINK_INPUT.json'), 'validation': row(validation),
        'host_groups_normal': sum(x['groups'] for x in v['host'] if x['mode'] == 'normal'),
        'host_groups_sanitized': sum(x['groups'] for x in v['host'] if x['mode'] == 'sanitized'),
        'target_units_twice_identical': 7, 'abi_fixes': [
            'format getter 9043a0 (904398 returns0)',
            'reader stack2 top/Y, stack3 left/X',
            'receipt frame from native-call SP after wrapper allocation'],
        'decoded_sample_bytes': 308166400, 'sample_arena_lower_bound': 2964893952,
        'sample_arena_upper_bound_proved': False,
        'full_valid_plane': [14204, 10652], 'bayer_storage': [14308, 10760],
        'output_color': 'original JPEG output enum5; no fabricated ICC or sRGB assertion',
        'remaining_acceptance': ['native C++ unwind/runtime integration',
            'ordinary pthread versus original native caller TLS contract',
            'complete on-camera Saved-IIQ decode/render',
            'actual card mmap performance and actual JPEG color appearance',
            'nonzero embedded profile parser'],
        'native_bitstream_semantic_validity_proved': False,
        'metadata_orientation_available': False,
        'explicit_AsStored_R0_policy_supported': True,
        'device_accessed': False, 'firmware_produced': False})
    evidence = sorted(p for p in ANALYSIS.rglob('*') if p.is_file())
    evidence += [validation, validation.with_name('COMMANDS.json')]
    evidence += sorted(validation.parent.glob('*.asm'))
    save(HERE / 'MANIFEST.json', {'source_sha256': source_sha,
        'files': [row(p) for p in sorted(set(sources + evidence + [
            HERE / 'SOURCE_SHA256.json', HERE / 'LINK_INPUT.json']))]})
    print(json.dumps({'source': source_sha, 'link': digest(HERE / 'LINK_INPUT.json'),
                      'manifest': digest(HERE / 'MANIFEST.json')}))


if __name__ == '__main__':
    main()
