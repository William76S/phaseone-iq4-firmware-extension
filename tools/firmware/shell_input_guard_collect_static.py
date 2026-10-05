#!/usr/bin/env python3
"""Freeze the exact offline FF character-device -> Shell input ownership chain."""
from pathlib import Path
import json
import struct
import subprocess
import sys

from save_setup_security_collect_static import ROOT, INPUTS, sha, sections, span, dump

OUT = ROOT / 'analysis/firmware/shell_input_guard_static'
REPORT = ROOT / 'analysis/firmware/SHELL_INPUT_GUARD_STATIC.md'
MODEL = ROOT / 'tools/firmware/sys_exact16_argv_01/native_lexer_model.py'
TEST = ROOT / 'tools/firmware/sys_exact16_argv_01/test_native_lexer_model.py'
WINDOWS = [
    ('main_same_character_owner_shell_handler_thread', 0x424688, 0x4247b0),
    ('member_callback_ctor', 0x415774, 0x4157c4),
    ('member_callback_virtual_dispatch', 0x4162d4, 0x416360),
    ('Shell_ctor_device_owner', 0x741628, 0x7416e0),
    ('Shell_worker_line_capacity_read_parse', 0x742dcc, 0x742ed4),
    ('Readline_entry_poll_and_getc', 0x743298, 0x743414),
    ('Readline_CR_terminator', 0x743bf4, 0x743c44),
    ('Readline_printable_store_and_terminator', 0x7441bc, 0x744204),
    ('Readline_each_completion_tail_zero', 0x7442d4, 0x7443b0),
    ('context_ctor_parser_vtable', 0x73f6e4, 0x73f738),
    ('context_parse_forward', 0x73fb60, 0x73fba8),
    ('parser_set_pointer_length', 0x7400ac, 0x740144),
    ('parser_load_before_length_and_quote_advance', 0x740144, 0x740388),
    ('quote_plain_separator_helpers', 0x740700, 0x740888),
    ('development_reparse_actual_remaining', 0x8728c8, 0x872a38),
    ('context_source_buffer_getter', 0x6f6b8c, 0x6f6ba4),
    ('context_token_pointer_getter', 0x4641fc, 0x464250),
    ('context_length_getter', 0x872a68, 0x872a80),
    ('character_default_append_newline', 0x871d40, 0x871e24),
    ('character_borrow_input_strnlen', 0x871edc, 0x871f68),
    ('character_getc_prefix_space_text_newline', 0x8720ec, 0x872314),
]
TABLES = [
    ('prefix_11_characters', 0x9f5c20, 0x9f5c2c),
    ('member_callback_vtable', 0x9f12f0, 0x9f1308),
    ('Shell_vtable', 0xc33130, 0xc33198),
    ('context_vtable', 0xc329c8, 0xc329e8),
]
REFERENCES = [
    'analysis/firmware/DEVELOPMENT_SHELL_LIFECYCLE_STATIC.md',
    'analysis/firmware/development_shell_lifecycle_static/manifest.json',
    'analysis/firmware/SYS_EEPROM_RANGE_RESTORE_STATIC.md',
    'analysis/firmware/sys_eeprom_range_restore_static/manifest.json',
]


def main():
    rel, expected = INPUTS['user_candidate']
    raw = (ROOT / rel).read_bytes()
    assert sha(raw) == expected
    layout = sections(raw)
    assert span(raw, layout, 0x9f5c20, 0x9f5c2c)[1] == b'IqpDevelRaw\0'
    assert struct.unpack('<Q', span(raw, layout, 0xc33188, 0xc33190)[1])[0] == 0x742dcc
    assert struct.unpack('<Q', span(raw, layout, 0x9f1300, 0x9f1308)[1])[0] == 0x4162d4
    assert struct.unpack('<Q', span(raw, layout, 0xc329d8, 0xc329e0)[1])[0] == 0x73fb60
    OUT.mkdir(exist_ok=True)
    exact = {'input': {'path': rel, 'sha256': expected}, 'evidence_level': 'static_only',
             'candidate_is_live_user_verified': False, 'device_accessed': False,
             'sdk_loaded': False, 'camera_packet_generated_or_sent': False,
             'eeprom_or_credential_read': False, 'ranges': [], 'tables': []}
    for name, start, end in WINDOWS:
        off, data, section = span(raw, layout, start, end)
        output = subprocess.check_output([
            '/Library/Developer/CommandLineTools/usr/bin/llvm-objdump', '-d',
            '--section=.text', f'--start-address={start:#x}', f'--stop-address={end:#x}', rel],
            cwd=ROOT, text=True)
        p = OUT / (name + '.disasm.txt')
        output = 'STATIC ONLY; nearest exported labels are not private function names.\n' + output
        p.write_text('\n'.join(s.rstrip() for s in output.splitlines()).rstrip() + '\n')
        exact['ranges'].append({'name': name, 'start_va': hex(start),
                               'end_va_exclusive': hex(end), 'file_offset': hex(off),
                               'section': section, 'bytes_sha256': sha(data),
                               'bytes_hex': data.hex(), 'disassembly': str(p.relative_to(ROOT))})
    for name, start, end in TABLES:
        off, data, section = span(raw, layout, start, end)
        exact['tables'].append({'name': name, 'start_va': hex(start),
                               'end_va_exclusive': hex(end), 'file_offset': hex(off),
                               'section': section, 'bytes_sha256': sha(data), 'bytes_hex': data.hex()})
    dump(OUT / 'exact_bytes.json', exact)
    result = subprocess.run([sys.executable, '-B', str(TEST)], cwd=ROOT,
                            text=True, capture_output=True, check=True)
    assert 'Ran 26 tests' in result.stderr and result.stderr.rstrip().endswith('OK')
    dump(OUT / 'synthetic_checks.json', {
        'level': 'host_synthetic_only', 'tests': 26, 'passed': True,
        'command': 'python3 -B tools/firmware/sys_exact16_argv_01/test_native_lexer_model.py',
        'no_device_no_sdk_no_camera_packet': True,
        'fixtures_have_no_actual_eeprom_or_credential': True,
        'guard': {'prefix_length': 11, 'separator_length': 1,
                  'max_text_bytes_excluding_appended_NUL': 242,
                  'max_completed_line_bytes': 254, 'line_capacity': 256,
                  'max_owned_index_read_at_boundary': 255,
                  'per_readline_stale_nonzero_tail_fixture': True,
                  'tested_payload_counts_0_through_231': True,
                  'text_243_rejected_before_parse': True},
        'minimal_owned_fixture_counterexample_is_not_actual_Shell_allocation': True,
        'host_printf_sink_checks_do_not_validate_target_printf_or_write_route': True})
    files = sorted(p for p in OUT.iterdir() if p.is_file() and p.name != 'manifest.json')
    files += [Path(__file__).resolve(), REPORT, MODEL, TEST,
              ROOT / 'tools/firmware/save_setup_security_collect_static.py']
    dump(OUT / 'manifest.json', {
        'input_sha256': expected, 'evidence_level': 'static_plus_host_synthetic',
        'files': {str(p.relative_to(ROOT)): sha(p.read_bytes()) for p in files},
        'frozen_references': {p: sha((ROOT / p).read_bytes()) for p in REFERENCES}})
    print(json.dumps({'windows': len(WINDOWS), 'tables': len(TABLES), 'host_tests': 26,
                      'manifest_sha256': sha((OUT / 'manifest.json').read_bytes()),
                      'report_sha256': sha(REPORT.read_bytes())}, sort_keys=True))


if __name__ == '__main__':
    main()
