#!/usr/bin/env python3
"""Finite read-only exact-User UI/storage collector; never executes target code."""
import argparse
import hashlib
import json
import struct
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
USER = ROOT / 'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA = '9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
OBJ = '/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
WINDOWS = {
    'file_settings_construction': (0x4f0ac0, 0x4f0d38),
    'storage_setup_construction': (0x4f0364, 0x4f0530),
    'file_format_selector_binding': (0x4eeae8, 0x4eeb28),
    'file_format_dto_binding': (0x595bf0, 0x595d30),
    'storage_dto_constructor': (0x5b7d60, 0x5b7fdc),
    'native_submenu_constructor': (0x4e5744, 0x4e58a4),
    'native_submenu_append': (0x4e58b8, 0x4e5990),
    'native_enum_constructor': (0x4e6504, 0x4e6780),
    'native_enum_leaf_activate': (0x4e6dc0, 0x4e6e08),
    'mode_dto_activate': (0x5bca5c, 0x5bcb20),
    'mode_dto_event_get_set': (0x5bd0ec, 0x5bd174),
    'size_dto_activate': (0x5bbb80, 0x5bbc44),
    'size_dto_event_get_set': (0x5bc210, 0x5bc298),
    'main_storage_groups': (0x41a730, 0x41a7dc),
    'main_storage_viewmodel': (0x41a82c, 0x41a8a8),
    'main_storage_dto': (0x41af48, 0x41af6c),
    'main_jpeg_same_sd_binding': (0x424b80, 0x424bd4),
    'main_storage_observer_binding': (0x428400, 0x428494),
    'storage_viewmodel_constructor': (0x5b50d0, 0x5b5220),
    'sd_composite_event_constructor': (0x5b5478, 0x5b5540),
    'sd_composite_event_get': (0x495448, 0x4954a0),
    'sd_composite_event_set': (0x5b66bc, 0x5b6774),
    'storage_group_constructor': (0x5e36f0, 0x5e3b3c),
    'jpeg_mode_event_get_set': (0x5e8c20, 0x5e8cd4),
    'jpeg_size_event_get_set': (0x5e7350, 0x5e7404),
    'sd_composite_observer_constructor': (0x6a9614, 0x6a9814),
    'sd_composite_observer_dispatch': (0x6a9814, 0x6a9aa4),
    'sd_composite_policy': (0x6a9aa4, 0x6aa120),
    'sd_xqd_raw_set_helpers': (0x6aa120, 0x6aa1d0),
    'ifm_stored_event_initialization': (0x495afc, 0x495b54),
    'ifm_jpeg_pending_default': (0x495c70, 0x495c90),
    'ifm_expected_flags_and_retire': (0x496668, 0x496784),
    'ifm_stored_flags_and_pending': (0x496784, 0x4968f8),
    'ifm_pending_add': (0x498994, 0x498a40),
    'ifm_file_flag_set': (0x49752c, 0x4975c8),
    'jpeg_constructor': (0x8e0928, 0x8e0aa8),
    'jpeg_worker': (0x8e0b18, 0x8e1180),
    'jpeg_pending_helpers': (0x8e2590, 0x8e264c),
    'directory_ifm_owner_binding': (0x4921fc, 0x4924a0),
    'directory_ifm_event_dispatch': (0x4924a0, 0x492540),
    'directory_sd_composite_policy': (0x492a38, 0x492da8),
    'directory_iiq_scan': (0x492fd4, 0x493598),
    'directory_jpeg_scan': (0x493598, 0x493994),
    'directory_jpeg_remove': (0x493994, 0x493a9c),
    'raw_group_reschedule': (0x8db860, 0x8db9e0),
    'raw_group_status': (0x8dbbac, 0x8dbd20),
    'raw_completion': (0x8dbf58, 0x8dc13c),
    'raw_transaction_retire': (0x8dc13c, 0x8dc214),
    'raw_transaction_acquire_fanout': (0x8dc478, 0x8dc70c),
    'raw_node_retire_bridge': (0x8c5990, 0x8c5a18),
    'raw_expected_and_stored_bridge': (0x8c5cdc, 0x8c5de8),
    'manual_pending_flag8': (0x50fa94, 0x50fabc),
}
TABLES = {
    'iiq_file_format': (0xf52108, 6, 24),
    'sd_storage_mode': (0xf528d0, 6, 24),
    'jpeg_mode': (0xf52960, 3, 24),
    'jpeg_size': (0xf529a8, 2, 24),
    'backup_mode': (0xf529d8, 3, 24),
    'directory_sd_policy': (0xb7e8d0, 6, 8),
}
VTABLES = {'submenu': (0xb8f9b8, 0xa8), 'mode_dto': (0xbbf588, 0x138),
           'size_dto': (0xbbf3f8, 0x138), 'jpeg_mode_event': (0xbcaa68, 0x78),
           'jpeg_size_event': (0xbca728, 0x78)}
PAIRS = [0xc0f7a0, 0xc0f7b0, 0xc0f7c0, 0xc0e770, 0xc10f90, 0xc12a90]
CALL_TARGETS = [0x496784, 0x498994, 0x49752c, 0x8c5d98, 0x8c5cdc,
                0x8c5990, 0x8dbf58, 0x8dc478, 0x8e2628]

def sha(b):
    return hashlib.sha256(b).hexdigest()

def main():
    p = argparse.ArgumentParser()
    p.add_argument('--output', type=Path, default=ROOT/'analysis/firmware/f3_native_save_settings_static_01')
    a = p.parse_args()
    data = USER.read_bytes()
    if len(data) != 11874544 or sha(data) != SHA:
        raise ValueError('exact original User identity mismatch')
    h = struct.unpack_from('<16sHHIQQQIHHHHHH', data)
    if h[0][:6] != b'\x7fELF\x02\x01' or h[2] != 183:
        raise ValueError('ELF64LE AArch64 required')
    loads = []
    for i in range(h[10]):
        t, flags, off, va, pa, fs, ms, al = struct.unpack_from('<IIQQQQQQ', data, h[5]+i*h[9])
        if t == 1:
            loads.append((va, fs, off, flags))
    def get(va, n):
        for v, fs, o, flags in loads:
            if va >= v and va+n <= v+fs:
                return o+va-v, data[o+va-v:o+va-v+n]
        raise ValueError(f'VA not wholly file backed: {va:x}+{n:x}')
    def string(va):
        off, _ = get(va, 1)
        end = data.find(b'\0', off, off+256)
        if end < 0:
            raise ValueError('unterminated literal')
        return data[off:end].decode('ascii')
    a.output.mkdir(parents=True, exist_ok=True)
    exact = []
    for label, (start, end) in WINDOWS.items():
        off, raw = get(start, end-start)
        name = label+'.asm'
        text = subprocess.check_output([OBJ, '-d', f'--start-address={start}', f'--stop-address={end}', str(USER)], text=True)
        text = '\n'.join(line.rstrip() for line in text.splitlines() if line.startswith('  '))+'\n'
        (a.output/name).write_text(text)
        exact.append(dict(label=label, va=start, end=end, file_offset=off, bytes=len(raw),
                          sha256=sha(raw), hex=raw.hex(), disasm=name, disasm_sha256=sha(text.encode()),
                          claim='finite window; function-completeness not inferred from label'))
    incoming = {f'{t:x}': [] for t in CALL_TARGETS}
    direct_fb5 = []
    for va, fs, off, flags in loads:
        if not flags & 1:
            continue
        for delta in range(0, fs-3, 4):
            w = struct.unpack_from('<I', data, off+delta)[0]
            if w >> 26 == 0b100101:
                imm = w & 0x3ffffff
                if imm & (1<<25):
                    imm -= 1<<26
                target = va+delta+imm*4
                if target in CALL_TARGETS:
                    incoming[f'{target:x}'].append(va+delta)
            # Only direct unsigned-byte LDRB/STRB immediates; not all aliases/indirect paths.
            if w & 0xffc00000 in (0x39000000, 0x39400000) and (w >> 10) & 0xfff == 0xfb5:
                direct_fb5.append(dict(va=va+delta, instruction_le=struct.pack('<I', w).hex()))
    (a.output/'exact_bytes.json').write_text(json.dumps({'input_sha256':SHA,'windows':exact}, indent=2)+'\n')
    (a.output/'incoming_calls.json').write_text(json.dumps({'direct_BL_only':incoming,
        'direct_byte_imm_fb5_only':direct_fb5,'indirect_alias_complete':False}, indent=2)+'\n')
    tables = []
    for label, (va, count, stride) in TABLES.items():
        off, raw = get(va, count*stride)
        item = dict(label=label, va=va, file_offset=off, bytes=len(raw), sha256=sha(raw), hex=raw.hex())
        records = []
        for i in range(count):
            if stride == 24:
                ident, pad, ptr, value, visible, enabled, reserved = struct.unpack_from('<IIQIBBH', raw, i*stride)
                records.append(dict(index=i, title_id=ident, literal=string(ptr) if ptr else None,
                                    value=value, visible=visible, enabled=enabled))
            else:
                mode, b4, b5, b6, b7 = struct.unpack_from('<IBBBB', raw, i*stride)
                records.append(dict(mode=mode, b4=b4, b5=b5, b6=b6, b7=b7))
        item['records'] = records
        tables.append(item)
    for label, (va, n) in VTABLES.items():
        off, raw = get(va, n)
        tables.append(dict(label=label, va=va, file_offset=off, bytes=n, hex=raw.hex(), sha256=sha(raw),
            slots={hex(i):hex(struct.unpack_from('<Q', raw, i)[0]) for i in range(0, n, 8)}))
    for va in PAIRS:
        off, raw = get(va, 16)
        ident, ptr = struct.unpack('<QQ', raw)
        tables.append(dict(label='resource_pair', va=va, file_offset=off, bytes=16, hex=raw.hex(),
                           sha256=sha(raw), title_id=ident, string_va=ptr, text=string(ptr)))
    (a.output/'tables.json').write_text(json.dumps(tables, indent=2)+'\n')
    sites = []
    for va in (0x4f0d34, 0x8dc4c0, 0x8dc570, 0x8dc1a4, 0x8dc6a4):
        off, b = get(va, 4)
        sites.append(dict(va=va, file_offset=off, old_le=b.hex()))
    (a.output/'sites.json').write_text(json.dumps(sites, indent=2)+'\n')
    files = sorted(f for f in a.output.iterdir() if f.is_file() and f.name not in ('manifest.json','REVIEW.md','CONTRACT.json'))
    manifest = dict(schema='iq4_f3_native_save_settings_static_01', input_sha256=SHA,
        input_bytes=len(data), target_executed=False, device_access=False, sdk_loaded=False,
        members=[dict(path=f.name, bytes=f.stat().st_size, sha256=sha(f.read_bytes())) for f in files])
    (a.output/'manifest.json').write_text(json.dumps(manifest, indent=2)+'\n')
    print(json.dumps(dict(windows=len(exact), table_groups=len(tables),
                         manifest_sha256=sha((a.output/'manifest.json').read_bytes()))))

if __name__ == '__main__':
    main()
