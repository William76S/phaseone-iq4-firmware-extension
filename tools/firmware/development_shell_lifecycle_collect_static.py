#!/usr/bin/env python3
"""Collect hash-bound native development shell lifecycle; offline only."""
from pathlib import Path
import subprocess
from save_setup_security_collect_static import ROOT, INPUTS, sha, sections, span, dump

OUT = ROOT / 'analysis/firmware/development_shell_lifecycle_static'
REPORT = ROOT / 'analysis/firmware/DEVELOPMENT_SHELL_LIFECYCLE_STATIC.md'
WINDOWS = [
    ('development_handler_ctor_queues_busy_character_owner', 0x862b40, 0x862c60),
    ('native_receive_dispatch_disconnect_event_reset', 0x862d5c, 0x863028),
    ('single_fragment_raw_command_accept_and_busy', 0x863028, 0x863204),
    ('character_device_ctor_input_state', 0x871d40, 0x871e24),
    ('character_device_borrow_input_and_start', 0x871e24, 0x872080),
    ('character_device_poll_and_getc_complete', 0x872080, 0x872314),
    ('character_device_output_string_copy_full_fragment', 0x872314, 0x872528),
    ('character_device_complete_end_fragment_and_busy_clear', 0x8725a4, 0x8726b0),
    ('shell_handler_ctor_command_owner', 0x872828, 0x8728c8),
    ('shell_handler_dispatch_and_completion', 0x8728c8, 0x872a38),
    ('shell_reply_allocate_copy_queue_and_busy_clear', 0x863618, 0x8637e0),
    ('shell_reply_payload_constructor', 0x863aa0, 0x863b3c),
    ('main_character_device_shell_prefix_register', 0x424688, 0x424740),
    ('event_reset_wrapper', 0x85a29c, 0x85a2cc),
    ('event_reset_allocator_and_other_owner_release', 0x853320, 0x8534b4),
    ('buffer_allocator_release_virtual', 0x842b38, 0x842b78),
    ('character_device_binary_methods_not_implemented', 0x872708, 0x872828),
]
TABLES = [
    ('fixed_shell_prefix', 0x9f5c20, 0x9f5c2c),
    ('character_device_vtable', 0xda7b18, 0xda7b90),
    ('development_shell_handler_vtable', 0xda7d48, 0xda7da0),
    ('unsupported_split_request_log', 0xda3e38, 0xda3e80),
    ('disconnect_busy_log', 0xda3dc0, 0xda3e18),
    ('character_device_rtti_name', 0xda7ba8, 0xda7bc8),
    ('shell_handler_rtti_name', 0xda7db8, 0xda7ddd),
]


def main():
    rel, expected = INPUTS['user_candidate']
    raw = (ROOT / rel).read_bytes()
    assert sha(raw) == expected
    layout = sections(raw)
    assert span(raw, layout, 0x9f5c20, 0x9f5c2c)[1] == b'IqpDevelRaw\0'
    OUT.mkdir(exist_ok=True)
    exact = {'input': {'path': rel, 'sha256': expected}, 'evidence_level': 'static_only',
             'candidate_is_live_user_verified': False, 'device_accessed': False,
             'sdk_loaded': False, 'shell_payload_or_packet_generated': False,
             'actual_security_code_or_token_or_eeprom_read': False,
             'ranges': [], 'tables': []}
    for name, start, end in WINDOWS:
        off, data, section = span(raw, layout, start, end)
        output = subprocess.check_output([
            '/Library/Developer/CommandLineTools/usr/bin/llvm-objdump', '-d',
            '--section=.text', f'--start-address={start:#x}', f'--stop-address={end:#x}', rel],
            cwd=ROOT, text=True)
        p = OUT / (name + '.disasm.txt')
        output = 'STATIC ONLY; nearest exported labels are not private function names.\n' + output
        p.write_text('\n'.join(s.rstrip() for s in output.splitlines()).rstrip() + '\n')
        exact['ranges'].append({'name': name, 'start_va': hex(start), 'end_va_exclusive': hex(end),
                                'file_offset': hex(off), 'section': section,
                                'bytes_sha256': sha(data), 'bytes_hex': data.hex(),
                                'disassembly': str(p.relative_to(ROOT))})
    for name, start, end in TABLES:
        off, data, section = span(raw, layout, start, end)
        exact['tables'].append({'name': name, 'start_va': hex(start), 'end_va_exclusive': hex(end),
                                'file_offset': hex(off), 'section': section,
                                'bytes_sha256': sha(data), 'bytes_hex': data.hex()})
    dump(OUT / 'exact_bytes.json', exact)
    files = sorted(p for p in OUT.iterdir() if p.is_file() and p.name != 'manifest.json')
    files += [Path(__file__).resolve(), REPORT, ROOT / 'tools/firmware/save_setup_security_collect_static.py']
    dump(OUT / 'manifest.json', {'input_sha256': expected, 'evidence_level': 'static_only',
                               'files': {str(p.relative_to(ROOT)): sha(p.read_bytes()) for p in files}})
    print(f'{len(WINDOWS)} windows; {len(TABLES)} tables; manifest {sha((OUT/"manifest.json").read_bytes())}')


if __name__ == '__main__':
    main()
