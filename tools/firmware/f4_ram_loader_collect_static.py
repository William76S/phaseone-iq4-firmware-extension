#!/usr/bin/env python3
"""Hash-bound local rootfs/ld.so/init/download evidence; no target execution."""
from pathlib import Path
import hashlib
import json
import stat
import struct
import subprocess
import sys
from inspect_boot import Ext2
from save_setup_security_collect_static import ROOT, sections, span

OUT = ROOT / 'analysis/firmware/f4_ram_loader_static'
INPUTS = {
    'boot': ('analysis/firmware/extracted/Boot_4.00.13.bin',
             '7a3a3d6f62c61e7d627a9f55d844d74be9111b26eb7a7fa42f5bdd7be7dabe9e'),
    'user': ('analysis/firmware/extracted/P1Linux_6.03.21.bin',
             '9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'),
    'ramdisk': ('analysis/firmware/P1_ramdisk.ext2',
                '2ca2a497fb22cb3b16009f5dab2aad1f744982aaafb6c928ac688c0a3f9dbccb'),
    'inventory': ('analysis/firmware/boot_inventory.json',
                  'd75acf1247e82b20c867a5d9affd15e514a5f143ef8a260d0fd40f0141c0aace'),
    'kernel_config': ('analysis/firmware/kernel.config.txt',
                      'da0ad7799b5836a54d4790af89e0215f35aba31821e779d5aaa199b5dbe7fc34'),
    'prior_module': ('analysis/sdk_reference/F4_TEMPORARY_MODULE_ENTRY_STATIC.md',
                     'a4f7235d6ed9a057aab07be9ca62d0d8e813756e61e889414c03b92294b344ed'),
    'prior_bootstrap': ('analysis/firmware/BOOTSTRAP_RECOVERY_INCREMENT.md',
                        'ea1cf5f39fc5c70fba7648ef3a7247852b40de2eb1ad3774e37317a3dc60cb25'),
    'shell_input_guard': ('analysis/firmware/SHELL_INPUT_GUARD_STATIC.md',
                          '05595f74ff3094de56c9de897f917e3f87d21ec82308e295b11802740e5eca94'),
}

# Only ld.so rows called complete_unwind are independently checked against the
# actual .eh_frame_hdr start table. All other rows explicitly bounded windows.
LD_WINDOWS = [
    ('preload_map_wrapper', 0x1230, 0x12c8, 'complete_unwind'),
    ('preload_map_callback', 0x12c8, 0x1308, 'complete_unwind'),
    ('preload_name_secure_gate', 0x1570, 0x15d0, 'complete_unwind'),
    ('preload_token_list', 0x1fe8, 0x20d0, 'complete_unwind'),
    ('startup_secure_and_environment_dispatch', 0x20fc, 0x2210, 'bounded_partial'),
    ('startup_post_environment_secure_branch', 0x2248, 0x2268, 'bounded_partial'),
    ('PREL_compare', 0x3278, 0x32a4, 'bounded_partial'),
    ('preload_pointer_consumer', 0x3580, 0x359c, 'bounded_partial'),
    ('OAD_compare_and_store', 0x3714, 0x3744, 'bounded_partial'),
    ('preload_token_list_caller', 0x5070, 0x5084, 'bounded_partial'),
    ('call_one_map_init', 0xd770, 0xd8a8, 'complete_unwind'),
    ('call_maps_init', 0xd8a8, 0xda00, 'complete_unwind'),
    ('LD_prefix_environment_iterator', 0x14af0, 0x14b40, 'complete_unwind'),
]
BB_WINDOWS = [
    ('init_clear_exited_pid', 0x84f78, 0x84fd8),
    ('init_parse_inittab', 0x851a8, 0x853ac),
    ('init_exec_command', 0x8541c, 0x85594),
    ('init_spawn_child', 0x85594, 0x856e8),
    ('init_run_actions', 0x856e8, 0x857b4),
    ('init_respawn_wait_loop', 0x85c4c, 0x85cbc),
    ('wget_options', 0x259f0, 0x25ab8),
    ('wget_output_flags_and_options', 0x25b58, 0x25bc8),
    ('wget_open_output', 0x25f08, 0x25f24),
    ('wget_proxy_environment', 0x2663c, 0x2667c),
    ('wget_transfer_timeout_counter', 0x25700, 0x25878),
    ('tftp_applet', 0x24cd8, 0x24df8),
]


def sha(b):
    return hashlib.sha256(b).hexdigest()


def dump(name, value):
    (OUT / name).write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')


def elf_unwind_starts(raw, layout):
    row = next(s for s in layout if s['name'] == '.eh_frame_hdr')
    b = raw[row['offset']:row['offset'] + row['size']]
    assert b[:4] == bytes.fromhex('011b033b')
    count = struct.unpack_from('<I', b, 8)[0]
    assert count == 207 and len(b) == 12 + count * 8
    starts = [row['va'] + struct.unpack_from('<i', b, 12 + i * 8)[0] for i in range(count)]
    assert starts == sorted(set(starts))
    return starts


def main():
    data = {}
    inputs = {}
    for name, (rel, expected) in INPUTS.items():
        raw = (ROOT / rel).read_bytes()
        assert sha(raw) == expected, name
        data[name] = raw
        inputs[name] = {'path': rel, 'sha256': expected, 'bytes': len(raw)}
    OUT.mkdir(exist_ok=True)
    (OUT / '.gitignore').write_text('*.analysis.elf\n*.target.elf\n.zig-cache/\n')
    disk = Ext2(data['ramdisk'])
    files = {n['path']: (n, c) for n, c in disk.walk()}
    linker_meta, linker = files['/lib/ld-2.28.so']
    bb_meta, bb = files['/bin/busybox.nosuid']
    assert sha(linker) == '9be1d9704ad489d8d573f6a9fb851d4522f92481de5795d9defee99ba96dce8f'
    assert sha(bb) == 'bf695c8a770fc3fb0d47b3daf46b5c5841e538b3df17054e73660399d221597d'
    ld_path = OUT / 'ld-2.28.analysis.elf'
    bb_path = OUT / 'busybox.analysis.elf'
    ld_path.write_bytes(linker)
    bb_path.write_bytes(bb)
    ld_sections, bb_sections = sections(linker), sections(bb)
    starts = elf_unwind_starts(linker, ld_sections)
    unwind_ends = dict(zip(starts, starts[1:]))
    exact = {'evidence_level': 'offline_exact_binary', 'device_accessed': False,
             'target_executed': False, 'ld_windows': [], 'busybox_windows': [],
             'data_records': [], 'user_interp': {}}
    objdump = '/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
    for kind, raw, rows, binary, layout in [
        ('ld', linker, LD_WINDOWS, ld_path, ld_sections),
        ('busybox', bb, [(n, a, z, 'bounded_window') for n, a, z in BB_WINDOWS], bb_path, bb_sections),
    ]:
        for name, start, end, extent in rows:
            if extent == 'complete_unwind':
                assert unwind_ends[start] == end, name
            offset, blob, section = span(raw, layout, start, end)
            output = subprocess.check_output([objdump, '-d', '--no-show-raw-insn',
                       f'--start-address={start:#x}', f'--stop-address={end:#x}', str(binary)], text=True)
            # Stable output path and no trailing spaces, preserving instructions.
            output = output.replace(str(ROOT) + '/', '')
            output = '\n'.join(line.rstrip() for line in output.splitlines()).strip() + '\n'
            path = OUT / f'{name}.{kind}.disasm.txt'
            path.write_text(output)
            exact[kind + '_windows'].append({
                'name': name, 'va': hex(start), 'end_va_exclusive': hex(end),
                'file_offset': hex(offset), 'section': section, 'extent': extent,
                'bytes_hex': blob.hex(), 'bytes_sha256': sha(blob),
                'disassembly': str(path.relative_to(ROOT)),
                'disassembly_sha256': sha(path.read_bytes())})
    for kind, raw, layout, name, va, length in [
        ('ld', linker, ld_sections, 'LD_PRELOAD_unsafe_name', 0x17dfa, 11),
        ('ld', linker, ld_sections, 'preload_delimiters', 0x18728, 3),
        ('ld', linker, ld_sections, 'preload_label', 0x18730, 11),
        ('ld', linker, ld_sections, 'calling_init_label', 0x1a3c0, 20),
        ('busybox', bb, bb_sections, 'wget_short_options', 0x99808, 28),
        ('busybox', bb, bb_sections, 'wget_long_options', 0xa9e8a, 199),
        ('busybox', bb, bb_sections, 'tftp_options', 0x99760, 23),
        ('busybox', bb, bb_sections, 'init_action_names', 0xab7ce, 64),
        ('busybox', bb, bb_sections, 'inittab_path', 0xa3218, 13),
    ]:
        offset, blob, section = span(raw, layout, va, va + length)
        exact['data_records'].append({'source': kind, 'name': name, 'va': hex(va),
                    'file_offset': hex(offset), 'section': section,
                    'bytes_hex': blob.hex(), 'bytes_sha256': sha(blob)})
    assert span(linker, ld_sections, 0x18728, 0x1872b)[1] == b' :\0'
    assert span(linker, ld_sections, 0x18730, 0x1873b)[1] == b'LD_PRELOAD\0'
    symtab = next(s for s in ld_sections if s['name'] == '.dynsym')
    symstrings = next(s for s in ld_sections if s['name'] == '.dynstr')
    strdata = linker[symstrings['offset']:symstrings['offset'] + symstrings['size']]
    secure = []
    for offset in range(symtab['offset'], symtab['offset'] + symtab['size'], 24):
        record = linker[offset:offset + 24]
        nameoff, info, other, index, value, size = struct.unpack('<IBBHQQ', record)
        if strdata[nameoff:strdata.index(0, nameoff)] == b'__libc_enable_secure':
            assert value == 0x2fdc8 and size == 4 and index != 0
            secure.append({'name': '__libc_enable_secure', 'dynsym_file_offset': hex(offset),
                           'dynsym_bytes_hex': record.hex(), 'va': hex(value), 'bytes': size,
                           'symbol_name_file_offset': hex(symstrings['offset'] + nameoff),
                           'actual_runtime_value_verified': False})
    assert len(secure) == 1
    exact['ld_secure_symbol'] = secure[0]
    user = data['user']
    phoff = struct.unpack_from('<Q', user, 32)[0]
    stride, count = struct.unpack_from('<HH', user, 54)
    interp = []
    for i in range(count):
        row = struct.unpack_from('<IIQQQQQQ', user, phoff + i * stride)
        if row[0] == 3:
            blob = user[row[2]:row[2] + row[5]]
            interp.append({'ph_index': i, 'file_offset': hex(row[2]),
                           'bytes_hex': blob.hex(), 'bytes_sha256': sha(blob)})
    assert len(interp) == 1 and bytes.fromhex(interp[0]['bytes_hex']) == b'/lib/ld-linux-aarch64.so.1\0'
    exact['user_interp'] = interp[0]
    dump('exact_bytes.json', exact)
    wanted = ['/', '/p1', '/p1/scripts', '/run', '/etc/inittab', '/etc/fstab',
              '/sbin/init', '/bin/sh', '/p1/scripts/boot_run_p1linux.sh',
              '/etc/init.d/p1-mount-squashfs.sh', '/etc/init.d/p1-rcS', '/etc/init.d/rcS',
              '/lib/ld-linux-aarch64.so.1', '/lib/ld-2.28.so', '/bin/busybox.nosuid',
              '/usr/bin/wget', '/usr/bin/tftp', '/usr/bin/ftpget', '/usr/bin/nc',
              '/usr/bin/curl', '/usr/bin/sha256sum', '/usr/bin/setsid', '/usr/bin/nohup']
    records = []
    for path in wanted:
        if path not in files:
            records.append({'path': path, 'present_in_exact_ramdisk': False})
            continue
        meta, blob = files[path]
        r = {**meta, 'present_in_exact_ramdisk': True}
        if stat.S_ISREG(meta['mode']) and meta['size'] < 10000:
            r['content_hex'] = blob.hex()
            r['text_lines'] = blob.decode().splitlines()
        if stat.S_ISLNK(meta['mode']):
            r['target_bytes_hex'] = blob.hex()
        records.append(r)
    name_offset = 0xa4d26
    main_offset = 0xadbd8
    names, pos = [], name_offset
    for _ in range(197):
        end = bb.index(0, pos)
        names.append(bb[pos:end].decode('ascii'))
        pos = end + 1
    assert names == sorted(names) and names[189] == 'wget' and names[166] == 'tftp'
    # PIE applet slots populated by R_AARCH64_RELATIVE addends, not file QWords.
    relas = next(s for s in bb_sections if s['name'] == '.rela.dyn')
    relative = {}
    for pos in range(relas['offset'], relas['offset'] + relas['size'], 24):
        dest, info, addend = struct.unpack_from('<QQq', bb, pos)
        if info & 0xffffffff == 1027:
            relative[dest] = addend
    needed = ['wget', 'tftp', 'ftpget', 'nc', 'sha256sum', 'setsid', 'nohup', 'init', 'ln', 'mv']
    applets = [{'name': n, 'index': names.index(n),
                'slot_va': hex(0xbdbd8 + names.index(n) * 8),
                'slot_file_offset': hex(main_offset + names.index(n) * 8),
                'function_va': hex(relative[0xbdbd8 + names.index(n) * 8])} for n in needed]
    dump('rootfs_records.json', {'ramdisk_sha256': inputs['ramdisk']['sha256'],
        'records': records, 'applets': applets, 'applet_count': 197,
        'applet_names_table_offset': hex(name_offset), 'curl_applet_present': 'curl' in names,
        'actual_runtime_tools_mounts_or_permissions_verified': False})
    sys.path.insert(0, str(ROOT / 'tools/firmware/f4_ram_entry_01'))
    from one_shot_model import describe_equal_length
    runner = files['/p1/scripts/boot_run_p1linux.sh'][1]
    assert sha(runner) == 'fe57b899f3a583e1058e4e856cf80704d902d6989b802154d02e77bc93305e88'
    call = describe_equal_length(runner)
    assert call['call_line_offset'] == 4809
    assert call['changed_offsets'] == list(range(4813, 4828))
    dump('equal_length_call_inspection.json', {'runner_sha256': sha(runner),
           'original_script_size': len(runner), 'line_number_1based': 157, **call,
           'no_installation_script_or_device_command_generated': True})
    env = data['boot'][0x44891c0:0x448986b]
    assert sha(env) == '1291372f254498774b68cc66bcb0a094958e448cb70cabc33a71d34ac74556f7'
    config = data['kernel_config'].decode().splitlines()
    selected = [line for line in config if any(line.startswith(k) for k in [
        'CONFIG_BLK_DEV_INITRD=', 'CONFIG_BLK_DEV_RAM=', 'CONFIG_BLK_DEV_RAM_COUNT=',
        'CONFIG_BLK_DEV_RAM_SIZE=', 'CONFIG_INITRAMFS_SOURCE=', 'CONFIG_EXT4_FS=',
        'CONFIG_EXT4_USE_FOR_EXT2=', 'CONFIG_TMPFS=', 'CONFIG_SQUASHFS=', '# CONFIG_EXT2_FS'])]
    dump('boot_ram_root_static.json', {'boot_environment_file_start': '0x44891c0',
        'boot_environment_file_end_exclusive': '0x448986b', 'bytes_hex': env.hex(),
        'bytes_sha256': sha(env), 'text_lines': env.decode().splitlines(),
        'kernel_config_sha256': inputs['kernel_config']['sha256'], 'selected_config': selected,
        'actual_cmdline_root_mount_or_cold_boot_verified': False})
    members = {}
    for path in sorted(OUT.iterdir()):
        if path.is_file() and path.name != 'manifest.json' and not path.name.endswith('.elf'):
            members[str(path.relative_to(ROOT))] = sha(path.read_bytes())
    source_refs = {}
    for path in [Path(__file__), ROOT / 'tools/firmware/f4_ram_loader_validate_static.py',
                 ROOT / 'tools/firmware/f4_ram_entry_01/README.md',
                 ROOT / 'tools/firmware/inspect_boot.py',
                 ROOT / 'tools/firmware/save_setup_security_collect_static.py',
                 *sorted((ROOT / 'tools/firmware/f4_ram_entry_01').glob('*.py')),
                 ROOT / 'tools/firmware/f4_ram_entry_01/readonly_monitor.c',
                 ROOT / 'analysis/firmware/F4_RAM_ONE_SHOT_ENTRY_STATIC.md']:
        assert path.is_file(), path
        source_refs[str(path.relative_to(ROOT))] = sha(path.read_bytes())
    dump('manifest.json', {'inputs': inputs, 'sources_and_report': source_refs,
        'members': members, 'derived_local_only_ELFs': {
            str(ld_path.relative_to(ROOT)): sha(linker), str(bb_path.relative_to(ROOT)): sha(bb)},
        'counts': {'ld_windows': len(LD_WINDOWS), 'busybox_windows': len(BB_WINDOWS),
                   'data_records': len(exact['data_records'])},
        'device_accessed': False, 'target_executed': False,
        'actual_recovery_or_loading_verified': False})
    print(json.dumps({'members': len(members), 'exact_windows': len(LD_WINDOWS) + len(BB_WINDOWS),
                      'manifest_sha256': sha((OUT / 'manifest.json').read_bytes())}))


if __name__ == '__main__':
    main()
