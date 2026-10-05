#!/usr/bin/env python3
"""Freeze bounded native Locked roundtrip source/static and synthetic evidence."""
from pathlib import Path
import json
import subprocess
from save_setup_security_collect_static import ROOT, INPUTS, sha, sections, span, dump

OUT = ROOT / 'analysis/firmware/volatile_lock_roundtrip_static'
REPORT = ROOT / 'analysis/firmware/VOLATILE_LOCK_ROUNDTRIP_HOST_CONTRACT.md'
SOURCE = ROOT / 'tools/firmware/volatile_lock_roundtrip_host.py'
TESTS = ROOT / 'tools/firmware/test_volatile_lock_roundtrip_host.py'
DEPS = {
    'analysis/firmware/VOLATILE_LOCK_COMMAND_STATIC.md': '6d7435514c2ddcb08f631802cf3671384fa8772572bcfb30bde284ba1ab6bea0',
    'analysis/firmware/volatile_lock_command_static/manifest.json': 'df13f2222abb25c6c2e31835b1fc862fa44d9fd0df5bd9741ff6a17a029fdf50',
    'analysis/firmware/volatile_permission_read_static/manifest.json': '347592e7b84955e42812556081a9ef4b1082e0903684a804ad3fe6b99e43a08f',
    'analysis/firmware/DEVELOPMENT_SHELL_LIFECYCLE_STATIC.md': 'af9f35349835b14c566dc959d7157e9bf3bb06ed429fa7b3398f2974043afafb',
    'analysis/firmware/development_shell_lifecycle_static/manifest.json': '4047f45b70dbcb82fbf97f423b3305fcfd2054ab01aebb44d7ea7221f632fcf6',
    'tools/firmware/sys_read_backup_host.py': '840ea3b3fb589bfe50f65445a53f72261a01581106db24aad627b40e45cd9d5d',
    'tools/firmware/os_event_locked_host.py': '8eef927b93ecf1926876889b9ef2a3476c4153b47026e83b284e7ad6a268fdb1',
    'tools/firmware/os_event_permissions_host.py': '399fad01cada9ab2cbbfb98fde8fb7ab2531086073314fffba7d52c4e8d558fe',
    'analysis/sdk_reference/DEVELOPMENT_SHELL_SINGLE_V2_CONTRACT.md': '453743fe1dd9211ec6d57e9230c0aeaed9495aa5a6b6eebff2547312661fde17',
    'analysis/sdk_reference/DEVELOPMENT_SHELL_SINGLE_V2_SHA256.json': 'cf0616bd8e051a2ffdfda64fce5225b5dde8c64eaa062cb1af1ebbbc3cc0bb64',
}
WINDOWS = [
    ('OsEvent_set_complete_exact_name_notify_formatter', 0x6bbbf0, 0x6bbf0c),
    ('OsEvent_formatter_complete', 0x6bdfb0, 0x6be390),
    ('OsEvent_list_complete', 0x6bc5cc, 0x6bc7d4),
    ('Bool_decoder_complete', 0x418768, 0x418bdc),
    ('Native_notify_listener_dispatch_complete', 0x70f2f8, 0x70f4e4),
    ('Queued_listener_notify_complete', 0x710820, 0x710864),
    ('Original_thread_handler_event_dispatch', 0x70ff84, 0x710060),
    ('SecurityHandler_subscribe_and_event_recompute', 0x6aab5c, 0x6aac70),
    ('SecurityHandler_all_permissions_complete', 0x6aac70, 0x6ab23c),
    ('Original_shell_directory_return_then_complete', 0x8728c8, 0x872a38),
    ('Original_shell_final_fragment_and_busy_clear', 0x8725a4, 0x8726b0),
]


def main():
    for rel, expected in DEPS.items():
        assert sha((ROOT / rel).read_bytes()) == expected, rel
        if rel.endswith('/manifest.json') or rel.endswith('_SHA256.json'):
            members = json.loads((ROOT / rel).read_bytes())['files']
            if isinstance(members, dict):
                entries = members.items()
            else:
                entries = ((x['path'], x['sha256']) for x in members)
            for p, h in entries:
                assert sha((ROOT / p).read_bytes()) == h, p
    rel, expected = INPUTS['user_candidate']
    raw = (ROOT / rel).read_bytes()
    assert sha(raw) == expected
    layout = sections(raw)
    OUT.mkdir(exist_ok=True)
    exact = {'input': {'path': rel, 'sha256': expected, 'bytes': len(raw)},
        'evidence_level': 'static_and_synthetic_host_only', 'device_accessed': False,
        'sdk_loaded': False, 'network_accessed': False, 'actual_Pincode_read_or_attempted': False,
        'actual_Locked_changed': False, 'actual_full_EEPROM_backed_up': False,
        'outgoing_wire_generated_or_sent': False, 'frozen_dependencies': DEPS, 'ranges': []}
    for name, start, end in WINDOWS:
        off, chunk, sec = span(raw, layout, start, end)
        output = subprocess.check_output([
            '/Library/Developer/CommandLineTools/usr/bin/llvm-objdump', '-d', '--section=.text',
            f'--start-address={start:#x}', f'--stop-address={end:#x}', rel], cwd=ROOT, text=True)
        dest = OUT / (name + '.disasm.txt')
        text = 'STATIC ONLY; linked VAs; nearest exported labels are not recovered private names.\n' + output
        dest.write_text('\n'.join(line.rstrip() for line in text.splitlines()).rstrip() + '\n')
        exact['ranges'].append({'name': name, 'start_va': hex(start), 'end_va_exclusive': hex(end),
            'file_offset': hex(off), 'section': sec, 'bytes_hex': chunk.hex(),
            'bytes_sha256': sha(chunk), 'disassembly': str(dest.relative_to(ROOT))})
    dump(OUT / 'exact_bytes.json', exact)
    result = subprocess.run(['python3', '-B', str(TESTS)], cwd=ROOT, capture_output=True, text=True)
    assert result.returncode == 0, 'synthetic roundtrip tests failed'
    assert 'Ran 15 tests' in result.stderr and result.stderr.rstrip().endswith('OK')
    dump(OUT / 'host_tests.json', {'evidence_level': 'synthetic_host_only', 'tests': 15,
        'returncode': 0, 'result': 'all_passed', 'sdk_loaded': False, 'device_accessed': False,
        'actual_state_changed': False, 'variable_runtime_text_not_saved': True})
    members = sorted(p for p in OUT.iterdir() if p.is_file() and p.name != 'manifest.json')
    members += [Path(__file__).resolve(), REPORT, SOURCE, TESTS,
                ROOT / 'tools/firmware/save_setup_security_collect_static.py']
    members += [ROOT / p for p in DEPS]
    dump(OUT / 'manifest.json', {'input_sha256': expected,
        'evidence_level': 'static_and_synthetic_host_only',
        'files': {str(p.relative_to(ROOT)): sha(p.read_bytes()) for p in members}})
    print(f'{len(WINDOWS)} exact windows; 15 synthetic tests; {len(members)} manifest members; '
          f'manifest {sha((OUT / "manifest.json").read_bytes())}')


if __name__ == '__main__':
    main()
