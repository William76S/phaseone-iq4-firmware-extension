#!/usr/bin/env python3
"""Finite original UI-stack evidence. Reads User/old sources; never runs target."""
from pathlib import Path
import argparse
import hashlib
import json
import re
import struct
import subprocess

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
INPUT = ROOT / 'analysis/firmware/extracted/P1Linux_6.03.21.bin'
USER_SHA = '9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
OBJDUMP = Path('/Library/Developer/CommandLineTools/usr/bin/llvm-objdump')
RANGES = [
    ('Dialog_base_ctor_complete', 0x4e10c4, 0x4e11c0),
    ('Dialog_show_close_complete', 0x4e12c8, 0x4e1360),
    ('Dialog_queued_request_and_current', 0x4e14bc, 0x4e15e8),
    ('Dialog_default_callbacks', 0x4e18a4, 0x4e1974),
    ('Manager_push_complete', 0x4e27bc, 0x4e28f8),
    ('Manager_normal_priority_push_complete', 0x4e28f8, 0x4e29b0),
    ('Manager_current_complete', 0x4e29b0, 0x4e2bdc),
    ('Manager_close_complete', 0x4e2bdc, 0x4e2dc8),
    ('Manager_event_dispatch_complete', 0x4e2f18, 0x4e32d4),
    ('Manager_force_draw_complete', 0x4e32d4, 0x4e36b8),
    ('Dialog_stack_tail_accessor_complete', 0x4e4de8, 0x4e4e6c),
    ('Dialog_stack_empty_complete', 0x4e4ec0, 0x4e4ee4),
    ('Original_UI_queue_loop_window', 0x4ef97c, 0x4ef988),
    ('Home_ctor_base_and_table_prefix', 0x500064, 0x5000f4),
    ('Home_dtor_and_adjusting_thunks', 0x500780, 0x500844),
    ('LV_enter_exit_complete', 0x51d884, 0x51da0c),
    ('Node_next_previous_complete', 0x46037c, 0x4603ac),
    ('Native_list_append_complete', 0x70bb78, 0x70bc44),
    ('Native_list_tail_complete', 0x70bcc0, 0x70bd10),
    ('Native_list_empty_complete', 0x70bd10, 0x70bd4c),
]
TABLES = [
    ('Manager_primary', 0xb8f358, 0xb8),
    ('Stack_wrapper', 0xb8f4e8, 0x40),
    ('Native_list', 0xc22908, 0x40),
    ('Native_sentinel_node', 0xc22960, 0x30),
    ('Home_primary_header_and_58_slots', 0xb94fd8, 0x1e0),
    ('Home_node_header_and_10_slots', 0xb951f0, 0x60),
    ('Home_typeinfo', 0xb95278, 0x38),
    ('LV_primary_header_and_59_slots', 0xb9a9c8, 0x1e8),
    ('LV_node_header_and_10_slots', 0xb9abe8, 0x60),
]
STRINGS = [('Home_title', 0xb94f40, 5),
           ('Home_source_identity', 0xb94f70, 44),
           ('Home_RTTI_name', 0xb952b0, 17)]
REFERENCES = [
    'tools/firmware/f1_native_ui_02/ui.cpp',
    'tools/firmware/f1_module_entry_01/module.cpp',
    'tools/firmware/f1_module_entry_01/module.hpp',
    'tools/firmware/f1_geometry_probe_03/probe.cpp',
    'tools/firmware/f1_observe_geometry_04/observe.cpp',
    'tools/firmware/f1_observe_geometry_04/runtime_linux.cpp',
    'analysis/firmware/F1_NATIVE_UI_ADAPTER_02.md',
    'analysis/sdk_reference/F1_OBSERVE_GEOMETRY_04.md',
]

def sha(data):
    return hashlib.sha256(data).hexdigest()

def input_bytes():
    raw = INPUT.read_bytes()
    if len(raw) != 11874544 or sha(raw) != USER_SHA:
        raise ValueError('exact User input mismatch')
    if raw[:7] != b'\x7fELF\x02\x01\x01' or struct.unpack_from('<H', raw, 18)[0] != 183:
        raise ValueError('expected AArch64 ELF64 little endian')
    return raw

def text_section(raw):
    offset = struct.unpack_from('<Q', raw, 40)[0]
    entry_size, count, names_index = struct.unpack_from('<HHH', raw, 58)
    if entry_size != 64 or not 0 < names_index < count or offset + count * entry_size > len(raw):
        raise ValueError('invalid ELF section table')
    sections = [struct.unpack_from('<IIQQQQIIQQ', raw, offset + n * entry_size) for n in range(count)]
    s = sections[names_index]
    names = raw[s[4]:s[4] + s[5]]
    found = [s for s in sections if names[s[0]:].split(b'\0', 1)[0] == b'.text']
    if len(found) != 1:
        raise ValueError('unique .text required')
    va, file_offset, length = found[0][3:6]
    if file_offset + length > len(raw) or length % 4 or va - file_offset != 0x400000:
        raise ValueError('.text bounds/address model mismatch')
    return va, file_offset, length

def branch_refs(raw):
    start, offset, length = text_section(raw)
    targets = {0x500064: [], 0x500780: []}
    for i in range(0, length, 4):
        word = struct.unpack_from('<I', raw, offset + i)[0]
        if word & 0x7c000000 != 0x14000000:
            continue
        immediate = word & 0x03ffffff
        if immediate & 0x02000000:
            immediate -= 0x04000000
        target = start + i + 4 * immediate
        if target in targets:
            targets[target].append({'va': hex(start + i), 'instruction_hex': raw[offset + i:offset + i + 4].hex(),
                                    'kind': 'BL' if word & 0x80000000 else 'B'})
    return {'scope': 'only direct AArch64 B/BL in complete .text; no indirect reachability claim',
            'text_va': hex(start), 'text_file_offset': hex(offset), 'text_bytes': length,
            'text_sha256': sha(raw[offset:offset + length]),
            'targets': {hex(target): values for target, values in targets.items()}}

def make(out):
    raw = input_bytes()
    out.mkdir(parents=True, exist_ok=False)
    rows = []
    for label, begin, end in RANGES:
        data = raw[begin - 0x400000:end - 0x400000]
        result = subprocess.check_output([str(OBJDUMP), '-d', f'--start-address={begin:#x}',
                                          f'--stop-address={end:#x}', str(INPUT.relative_to(ROOT))], cwd=ROOT, text=True)
        instructions = [line.split(' <')[0].split(' //')[0].rstrip() for line in result.splitlines()
                        if re.match(r'  [0-9a-f]+:', line)]
        if len(instructions) != (end - begin) // 4:
            raise ValueError(f'incomplete static disassembly {label}')
        name = label + '.txt'
        (out / name).write_text('Exact User SHA256 ' + USER_SHA + '\nSTATIC ONLY; no target execution.\n' + '\n'.join(instructions) + '\n')
        rows.append({'label': label, 'va': hex(begin), 'end_exclusive': hex(end), 'file_offset': begin - 0x400000,
                     'bytes': len(data), 'hex': data.hex(), 'sha256': sha(data),
                     'disassembly': name, 'disassembly_sha256': sha((out / name).read_bytes())})
    tables = []
    for label, va, length in TABLES + STRINGS:
        data = raw[va - 0x400000:va - 0x400000 + length]
        row = {'label': label, 'va': hex(va), 'file_offset': va - 0x400000, 'bytes': length,
               'hex': data.hex(), 'sha256': sha(data)}
        if (label, va, length) in TABLES:
            row['qwords'] = [hex(x[0]) for x in struct.iter_unpack('<Q', data)]
        else:
            row['utf8'] = data.rstrip(b'\0').decode('utf8')
        tables.append(row)
    references = [{'path': p, 'bytes': (ROOT / p).stat().st_size, 'sha256': sha((ROOT / p).read_bytes())} for p in REFERENCES]
    evidence = {'schema': 'iq4_f1_stack_current_static_05', 'input': {'path': str(INPUT.relative_to(ROOT)), 'bytes': len(raw), 'sha256': USER_SHA},
                'address_model': 'exact AArch64 ET_EXEC VA=file+0x400000; runtime bias not observed',
                'device_accessed': False, 'sdk_loaded': False, 'target_executed': False,
                'ranges': rows, 'tables_and_strings': tables, 'home_direct_branch_refs': branch_refs(raw),
                'frozen_references': references}
    (out / 'exact_bytes.json').write_text(json.dumps(evidence, indent=2) + '\n')

def verify(out):
    raw = input_bytes()
    evidence = json.loads((out / 'exact_bytes.json').read_text())
    if evidence['input']['sha256'] != USER_SHA or evidence['schema'] != 'iq4_f1_stack_current_static_05':
        raise ValueError('wrong evidence')
    for row in evidence['ranges'] + evidence['tables_and_strings']:
        data = raw[row['file_offset']:row['file_offset'] + row['bytes']]
        if data.hex() != row['hex'] or sha(data) != row['sha256']:
            raise ValueError('raw window mismatch')
        if 'disassembly' in row and sha((out / row['disassembly']).read_bytes()) != row['disassembly_sha256']:
            raise ValueError('disassembly changed')
    if branch_refs(raw) != evidence['home_direct_branch_refs']:
        raise ValueError('direct branch scope changed')
    for row in evidence['frozen_references']:
        data = (ROOT / row['path']).read_bytes()
        if len(data) != row['bytes'] or sha(data) != row['sha256']:
            raise ValueError('frozen reference changed')
    print(json.dumps({'static_window_verification': 'PASS', 'windows': len(evidence['ranges']),
                      'tables_and_strings': len(evidence['tables_and_strings']), 'frozen_references': len(evidence['frozen_references']),
                      'device_accessed': False, 'sdk_loaded': False, 'target_executed': False}, sort_keys=True))

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--out', required=True, type=Path, help='new evidence directory; collect never overwrites')
    parser.add_argument('--verify', action='store_true')
    args = parser.parse_args()
    out = args.out.resolve()
    verify(out) if args.verify else make(out)

if __name__ == '__main__':
    main()
