#!/usr/bin/env python3
"""Offline exact printf/xargs evidence and fixed host sink tests; no device."""
from pathlib import Path
import json
import stat
import struct
import subprocess
import sys

from inspect_boot import Ext2
from save_setup_security_collect_static import ROOT, sha, sections, span, dump

OUT = ROOT / 'analysis/firmware/sys_exact16_argv_static'
REPORT = ROOT / 'analysis/firmware/SYS_EXACT16_ARGV_STATIC.md'
RAMDISK = ROOT / 'analysis/firmware/P1_ramdisk.ext2'
RAMDISK_SHA = '2ca2a497fb22cb3b16009f5dab2aad1f744982aaafb6c928ac688c0a3f9dbccb'
BUSYBOX_SHA = 'bf695c8a770fc3fb0d47b3daf46b5c5841e538b3df17054e73660399d221597d'
TEST = ROOT / 'tools/firmware/sys_exact16_argv_increment_01/test_fixed_argv_fixture.py'
WINDOWS = [
    ('printf_main_complete', 0x69ef4, 0x6a444),
    ('printf_escape_helper', 0x8f354, 0x8f428),
    ('putchar_byte_output', 0xdb4c, 0xdb88),
    ('xargs_main_complete', 0x84968, 0x84c6c),
    ('xargs_ordinary_whitespace_reader_complete', 0x845bc, 0x84740),
    ('xargs_append_argv', 0x843e4, 0x84438),
    ('xargs_launch_wait_complete', 0x84740, 0x84968),
    ('spawn_execvp_complete', 0x93fdc, 0x94064),
    ('spawn_and_wait_wrapper', 0x94064, 0x94078),
]
REFERENCES = [
    'analysis/firmware/SHELL_INPUT_GUARD_STATIC.md',
    'analysis/firmware/shell_input_guard_static/manifest.json',
    'analysis/firmware/SYS_EEPROM_RANGE_RESTORE_STATIC.md',
    'analysis/firmware/sys_eeprom_range_restore_static/manifest.json',
    'analysis/firmware/boot_inventory.json',
    'analysis/firmware/sys_eeprom_range_restore_static/busybox_applets.json',
    'tools/firmware/sys_exact16_argv_01/native_lexer_model.py',
]


def main():
    disk = RAMDISK.read_bytes()
    assert sha(disk) == RAMDISK_SHA
    inventory = json.loads((ROOT / 'analysis/firmware/boot_inventory.json').read_text())['ramdisk']['files']
    bypath = {f['path']: f for f in inventory}
    record = bypath['/bin/busybox.nosuid']
    bb, blocks = Ext2(disk).contents(Ext2(disk).inode(record['inode']))
    assert len(bb) == 719432 and sha(bb) == BUSYBOX_SHA == record['sha256']
    OUT.mkdir(exist_ok=True)
    (OUT / '.gitignore').write_text('busybox.analysis.elf\n')
    derived = OUT / 'busybox.analysis.elf'
    derived.write_bytes(bb)
    layout = sections(bb)
    exact = {'evidence_level': 'offline_exact_binary', 'ramdisk_sha256': RAMDISK_SHA,
             'busybox_sha256': BUSYBOX_SHA, 'windows': [], 'data_records': [],
             'device_accessed': False, 'target_executed': False,
             'actual_eeprom_offset_or_value_or_write_payload_generated': False}
    for name, start, end in WINDOWS:
        off, data, section = span(bb, layout, start, end)
        output = subprocess.check_output([
            '/Library/Developer/CommandLineTools/usr/bin/llvm-objdump', '-d',
            f'--start-address={start:#x}', f'--stop-address={end:#x}',
            str(derived.relative_to(ROOT))], cwd=ROOT, text=True)
        p = OUT / (name + '.disasm.txt')
        output = 'STATIC ONLY; exported proximity is not a private function identity.\n' + output
        p.write_text('\n'.join(s.rstrip() for s in output.splitlines()).rstrip() + '\n')
        exact['windows'].append({'name': name, 'start_va': hex(start),
                                'end_va_exclusive': hex(end), 'file_offset': hex(off),
                                'section': section, 'bytes_hex': data.hex(),
                                'bytes_sha256': sha(data), 'disassembly': str(p.relative_to(ROOT))})
    for name, va, end in [('xargs_getopt_option_string', 0xa2ff0, 0xa3007)]:
        off, data, section = span(bb, layout, va, end)
        assert data == b'+trn:s:e::E:I:i::P:+a:\0'
        exact['data_records'].append({'name': name, 'start_va': hex(va),
                                     'end_va_exclusive': hex(end), 'file_offset': hex(off),
                                     'section': section, 'bytes_hex': data.hex(), 'bytes_sha256': sha(data)})
    dump(OUT / 'exact_bytes.json', exact)
    tools = []
    for path in ['/bin/sh', '/bin/dd', '/usr/bin/printf', '/usr/bin/xargs']:
        f = bypath[path]
        assert stat.S_ISLNK(f['mode']) and f['symlink_target'] == '/bin/busybox.nosuid'
        data, ignored_blocks = Ext2(disk).contents(Ext2(disk).inode(f['inode']))
        assert sha(data) == f['sha256'] and data == b'/bin/busybox.nosuid'
        tools.append(f)
    applets = json.loads((ROOT / 'analysis/firmware/sys_eeprom_range_restore_static/busybox_applets.json').read_text())
    subset = [a for a in applets['applets'] if a['name'] in ('ash', 'sh', 'printf', 'xargs')]
    assert {a['name']: a['function_va'] for a in subset} == {
        'ash': '0x49344', 'sh': '0x49344', 'printf': '0x69ef4', 'xargs': '0x84968'}
    dump(OUT / 'tool_records.json', {'rootfs_symlinks': tools, 'applets': subset,
                                    'busybox_data_blocks': blocks, 'runtime_tools_verified': False})
    result = subprocess.run([sys.executable, '-B', str(TEST)], cwd=ROOT,
                            capture_output=True, text=True, check=True)
    assert 'Ran 10 tests' in result.stderr and result.stderr.rstrip().endswith('OK')
    dump(OUT / 'synthetic_checks.json', {'tests': 10, 'passed': True,
        'command': 'python3 -B tools/firmware/sys_exact16_argv_increment_01/test_fixed_argv_fixture.py',
        'target_executed': False, 'camera_payload_generated': False,
        'host_execution_only_constant_printf_sink': True,
        'actual_eeprom_destination_original16_or_offsets_present': False,
        'actual_line_256_model_applied': True, 'literal_equal_in_input': False,
        'target_has_no_xargs_zero_or_custom_delimiter_option': True})
    files = sorted(p for p in OUT.iterdir() if p.is_file() and p.name != 'manifest.json' and p.suffix != '.elf')
    files += [Path(__file__).resolve(), REPORT, TEST,
              ROOT / 'tools/firmware/save_setup_security_collect_static.py',
              ROOT / 'tools/firmware/inspect_boot.py']
    dump(OUT / 'manifest.json', {
        'evidence_level': 'static_plus_host_synthetic', 'device_operations': 0,
        'files': {str(p.relative_to(ROOT)): sha(p.read_bytes()) for p in files},
        'frozen_references': {p: sha((ROOT / p).read_bytes()) for p in REFERENCES},
        'derived_ignored_binary': {'path': str(derived.relative_to(ROOT)), 'sha256': sha(bb)}})
    print(json.dumps({'windows': len(WINDOWS), 'data_records': 1, 'host_tests': 10,
                      'manifest_sha256': sha((OUT / 'manifest.json').read_bytes()),
                      'report_sha256': sha(REPORT.read_bytes())}, sort_keys=True))


if __name__ == '__main__':
    main()
