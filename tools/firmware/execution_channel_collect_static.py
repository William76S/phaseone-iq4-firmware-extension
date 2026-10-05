#!/usr/bin/env python3
"""Reproduce execution-channel evidence from local vendor files only.

Does not load an SDK library, initialise a transport, access hardware, or build
packets. Archive members remain private local binary intermediates, not source.
"""
from pathlib import Path
import hashlib
import json
import re
import struct
import subprocess

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / 'analysis/firmware/execution_channel_static'
LLVM = Path('/Library/Developer/CommandLineTools/usr/bin')
INPUTS = {
    'firmware': ('analysis/firmware/extracted/P1Linux_6.03.21.bin',
                 '9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'),
    'archive': ('analysis/sdk_reference/vendor_downloads/dest/lib/libCameraSdkCppStatic.a',
                '3754ed25d9d98b8da8a7648d011d2904be82f824144c9ae366af1aa98692dde2'),
    'shared': ('analysis/sdk_reference/vendor_downloads/dest/lib/libCameraSdkCpp.so.3.2.5',
               'fc94f19ed5bebfd4db61906dce529c1c57e360d9cc6eb02f3da33dcbf708c3e4'),
    'windows_cpp': ('analysis/sdk_reference/vendor_downloads/windows/lib/CameraSdkCpp.dll',
                    'f395aa33ee5a44626d8050c63953efb9f113970330aa3a3ad5670176868c3891'),
    'windows_cs_bridge': ('analysis/sdk_reference/vendor_downloads/windows/Cs/CameraSdkCppBindingsForCs.dll',
                          '5c6c4dee07f145ea68f573a72027690fadd5f10ad1e60b33d3fb42e34d4e00c2'),
}
# Archive member offsets are host x86-64 section-relative addresses. Firmware
# addresses are AArch64 link VAs. They are deliberately separate domains.
SDK_RANGES = [
    ('camera_development_methods', 'IQPCamera.cpp.o', 0x5570, 0x5920),
    ('camera_development_auth', 'IQPCamera.cpp.o', 0x1880, 0x19b0),
    ('camera_open_development_create', 'IQPCamera.cpp.o', 0x73b6, 0x75e2),
    ('camera_open_development_tail', 'IQPCamera.cpp.o', 0x75a0, 0x76e0),
    ('development_constructor', 'IQPDevelopment.cpp.o', 0x660, 0x890),
    ('development_send', 'IQPDevelopment.cpp.o', 0x950, 0xbb0),
    ('development_send_copy', 'IQPDevelopment.cpp.o', 0xbc0, 0xbd5),
    ('development_send_sync', 'IQPDevelopment.cpp.o', 0xcb0, 0xd60),
    ('development_receive', 'IQPDevelopment.cpp.o', 0x340, 0x660),
    ('development_start_channel', 'IQPDevelopment.cpp.o', 0x1ab0, 0x1cc0),
    ('channel_auth_generate', 'IQPChannel.cpp.o', 0x170, 0x220),
    ('channel_send_open', 'IQPChannel.cpp.o', 0x990, 0xab0),
    ('channel_open_reply', 'IQPChannel.cpp.o', 0xd50, 0xef0),
    ('base_agent_auth', 'IQPAgentBase.cpp.o', 0, 0xa0),
    ('transport_camera_open', 'IqpLibTransport.cpp.o', 0x91d0, 0x97b0),
    ('transport_get_iqp_camera', 'IqpLibTransport.cpp.o', 0x1d60, 0x263d),
]
SHARED_RANGES = [
    ('linux_export_get_iqp_camera', 0x94c10, 0x94cb0),
    ('linux_export_capi_test', 0x825f0, 0x82630),
    ('linux_export_camera_id_helper', 0xa9720, 0xa9740),
]
FIRMWARE_RANGES = [
    ('firmware_development_factory', 0x85d108, 0x85d184),
    ('firmware_development_factory_tail', 0x85db34, 0x85dc48),
    ('firmware_channel_lookup', 0x875300, 0x8754c0),
    ('firmware_channel_creation_loop', 0x85d074, 0x85d0c4),
    ('firmware_simple_factory_ctor', 0x85cb64, 0x85cd68),
    ('firmware_channel_manager_ctor', 0x85bd0c, 0x85c004),
    ('firmware_channel_state_ctor', 0x8510f4, 0x851410),
    ('firmware_auth_group_sources', 0x41a570, 0x41a5f0),
    ('firmware_factory_config_eth', 0x424ca0, 0x424d7c),
    ('firmware_factory_config_usb', 0x424f88, 0x425068),
    ('firmware_auth_group_ctor', 0x663fc8, 0x664118),
    ('firmware_development_auth_gate', 0x851fac, 0x8520c0),
    ('firmware_development_receive', 0x862eac, 0x863100),
    ('firmware_development_dispatch', 0x8637f4, 0x863854),
    ('firmware_native_linux_sys', 0x778244, 0x7783d4),
]
NAMES = ('IsDevelopmentSupported', 'StartDevelopment', 'StopDevelopment',
         'SendDevelopmentMessage', 'SetDevelopmentReceiver',
         'SetDevelopmentAuthenticationPassword', 'DevelopmentAgent',
         'DevelopmentShell', 'ExecuteCommand', 'ReadMetadata', 'GetFileStat',
         'GetMountInfo')


def sha(data):
    return hashlib.sha256(data).hexdigest()


def write_text(path, value):
    path.write_text('\n'.join(line.rstrip() for line in value.splitlines()).rstrip() + '\n')


def dump_json(path, value):
    write_text(path, json.dumps(value, indent=2))


def ar_members(raw):
    assert raw[:8] == b'!<arch>\n'
    result, strings, cursor = {}, b'', 8
    while cursor < len(raw):
        h = raw[cursor:cursor + 60]
        assert len(h) == 60 and h[-2:] == b'`\n'
        name, size, offset = h[:16].decode().strip(), int(h[48:58]), cursor + 60
        data = raw[offset:offset + size]
        assert len(data) == size
        if name == '//':
            strings = data
        elif name.startswith('/') and name[1:].isdigit():
            name = strings[int(name[1:]):].split(b'/\n', 1)[0].decode()
        else:
            name = name.rstrip('/')
        result[name] = (offset, data)
        cursor = offset + size + size % 2
    return result


def elf_sections(raw):
    assert raw[:6] == b'\x7fELF\x02\x01'
    shoff = struct.unpack_from('<Q', raw, 40)[0]
    entsize, count, strindex = struct.unpack_from('<HHH', raw, 58)
    sh = [struct.unpack_from('<IIQQQQIIQQ', raw, shoff + i * entsize) for i in range(count)]
    strings = raw[sh[strindex][4]:sh[strindex][4] + sh[strindex][5]]
    return {strings[s[0]:strings.index(0, s[0])].decode():
            {'address': s[3], 'offset': s[4], 'size': s[5]} for s in sh}


def elf_span(raw, start, end):
    for section in elf_sections(raw).values():
        a, n, offset = section['address'], section['size'], section['offset']
        if a <= start < end <= a + n:
            off = offset + start - a
            return off, raw[off:off + end - start]
    raise ValueError(f'Range outside one ELF section: {start:#x}..{end:#x}')


def pe_exports(raw):
    pe = struct.unpack_from('<I', raw, 0x3c)[0]
    assert raw[pe:pe + 4] == b'PE\0\0'
    count, optional_size = struct.unpack_from('<H', raw, pe + 6)[0], struct.unpack_from('<H', raw, pe + 20)[0]
    optional = pe + 24
    magic = struct.unpack_from('<H', raw, optional)[0]
    assert magic in (0x10b, 0x20b)
    directory = optional + (112 if magic == 0x20b else 96)
    export_rva, export_size = struct.unpack_from('<II', raw, directory)
    sections = []
    for i in range(count):
        s = optional + optional_size + 40 * i
        vsz, va, rsz, ptr = struct.unpack_from('<IIII', raw, s + 8)
        sections.append((va, max(vsz, rsz), ptr))

    def offset(rva):
        for va, size, ptr in sections:
            if va <= rva < va + size:
                return ptr + rva - va
        raise ValueError(rva)

    if not export_rva:
        return []
    table = offset(export_rva)
    base, nfunc, nnames, funcs, names, ordinals = struct.unpack_from('<IIIIII', raw, table + 16)
    result = []
    for i in range(nnames):
        nrva = struct.unpack_from('<I', raw, offset(names) + 4 * i)[0]
        noff = offset(nrva)
        name = raw[noff:raw.index(0, noff)].decode()
        index = struct.unpack_from('<H', raw, offset(ordinals) + 2 * i)[0]
        assert index < nfunc
        frva = struct.unpack_from('<I', raw, offset(funcs) + 4 * index)[0]
        result.append({'name': name, 'ordinal': base + index, 'rva': hex(frva),
                       'forwarder': export_rva <= frva < export_rva + export_size})
    return result


def disassemble(name, path, start, end, relocations=False):
    args = [str(LLVM / 'llvm-objdump'), '-dr' if relocations else '-d', '--demangle', '--section=.text',
            f'--start-address={start:#x}', f'--stop-address={end:#x}', str(path.relative_to(ROOT))]
    text = subprocess.check_output(args, cwd=ROOT, text=True)
    dest = OUT / (name + '.disasm.txt')
    write_text(dest, 'STATIC ONLY; offsets belong to the explicitly named input/section.\n' + text)
    return dest


def main():
    OUT.mkdir(exist_ok=True)
    data, input_records = {}, {}
    for key, (rel, expected) in INPUTS.items():
        raw = (ROOT / rel).read_bytes()
        if sha(raw) != expected:
            raise SystemExit(f'Unknown {key} SHA-256; refusing capture')
        data[key] = raw
        input_records[key] = {'path': rel, 'sha256': expected, 'bytes': len(raw)}
    members = ar_members(data['archive'])
    member_records, spans, produced = {}, [], []
    for name in sorted({r[1] for r in SDK_RANGES}):
        archive_offset, raw = members[name]
        (OUT / name).write_bytes(raw)
        section = elf_sections(raw)['.text']
        member_records[name] = {'archive_data_offset': hex(archive_offset), 'bytes': len(raw),
                                'sha256': sha(raw), 'text_section_file_offset': hex(section['offset'])}
    for name, member, start, end in SDK_RANGES:
        archive_offset, raw = members[member]
        off, chunk = elf_span(raw, start, end)
        p = disassemble(name, OUT / member, start, end, True)
        produced.append(p)
        spans.append({'name': name, 'domain': 'sdk_x86_64_archive_member_text', 'member': member,
                      'section_offset': hex(start), 'end_offset_exclusive': hex(end),
                      'member_file_offset': hex(off), 'archive_file_offset': hex(archive_offset + off),
                      'bytes_hex': chunk.hex(), 'bytes_sha256': sha(chunk), 'disassembly': str(p.relative_to(ROOT))})
    for key, ranges in [('shared', SHARED_RANGES), ('firmware', FIRMWARE_RANGES)]:
        for name, start, end in ranges:
            off, chunk = elf_span(data[key], start, end)
            p = disassemble(name, ROOT / INPUTS[key][0], start, end)
            produced.append(p)
            spans.append({'name': name, 'domain': 'sdk_shared_link_va' if key == 'shared' else 'firmware_link_va',
                          'input': key, 'start_va': hex(start), 'end_va_exclusive': hex(end), 'file_offset': hex(off),
                          'bytes_hex': chunk.hex(), 'bytes_sha256': sha(chunk), 'disassembly': str(p.relative_to(ROOT))})
    # Delete only stale collectors' disassembly in our exclusive output directory.
    for p in OUT.glob('*.disasm.txt'):
        if p not in produced:
            p.unlink()
    for key, options in [('shared', ['--dynamic']), ('archive', ['--print-file-name'])]:
        text = subprocess.check_output([str(LLVM / 'llvm-nm'), *options, '--demangle', '--defined-only',
                                        INPUTS[key][0]], cwd=ROOT, text=True)
        dest = OUT / ('linux_dynamic_symbols.txt' if key == 'shared' else 'linux_static_symbols.txt')
        write_text(dest, text)
    coverage = {'searched_exact_names': list(NAMES), 'headers': [], 'dynamic_symbol_matches': {}, 'windows_export_matches': {}}
    for rel in ['analysis/sdk_reference/vendor_downloads/dest/include', 'analysis/sdk_reference/vendor_downloads/windows/include']:
        for p in sorted((ROOT / rel).rglob('*')):
            if not p.is_file() or p.suffix not in ('.h', '.hpp'):
                continue
            raw = p.read_bytes()
            lines = raw.decode().splitlines()
            hits = [{'line': i, 'text': line.strip()} for i, line in enumerate(lines, 1) if any(n in line for n in NAMES)]
            coverage['headers'].append({'path': str(p.relative_to(ROOT)), 'sha256': sha(raw), 'bytes': len(raw), 'matches': hits})
    dynamic_lines = (OUT / 'linux_dynamic_symbols.txt').read_text().splitlines()
    coverage['dynamic_symbol_matches'] = {n: [l for l in dynamic_lines if re.search(r'\b[Tt]\b', l) and n in l] for n in NAMES}
    for key in ['windows_cpp', 'windows_cs_bridge']:
        exports = pe_exports(data[key])
        dump_json(OUT / (key + '_exports.json'), {'input': input_records[key], 'exports': exports})
        coverage['windows_export_matches'][key] = {n: [x['name'] for x in exports if n in x['name']] for n in NAMES}
    strings = []
    for va in [0x9f45a0, 0x9f45b0, 0x9f45c0, 0x9f45d0]:
        off, _ = elf_span(data['firmware'], va, va + 1)
        end = data['firmware'].index(0, off) + 1
        chunk = data['firmware'][off:end]
        strings.append({'va': hex(va), 'file_offset': hex(off), 'text': chunk[:-1].decode(), 'bytes_hex': chunk.hex()})
    dump_json(OUT / 'archive_members.json', {'archive_input': input_records['archive'], 'members': member_records})
    dump_json(OUT / 'public_api_coverage.json', coverage)
    dump_json(OUT / 'exact_bytes.json', {'inputs': input_records, 'evidence_level': 'static_only',
                                        'hardware_accessed': False, 'sdk_loaded': False, 'packets_built_or_sent': False,
                                        'ranges': spans, 'strings': strings})
    # Keep original binary intermediates out of evidence/source publication.
    paths = sorted(p for p in OUT.iterdir() if p.is_file() and p.suffix != '.o')
    paths += [Path(__file__).resolve(), ROOT / 'analysis/firmware/EXECUTION_CHANNEL_STATIC.md',
              ROOT / 'analysis/firmware/execution_decompile_targets.txt']
    manifest = {'inputs': input_records, 'evidence_level': 'static_only',
                'files': {str(p.relative_to(ROOT)): sha(p.read_bytes()) for p in paths}}
    dest = ROOT / 'analysis/firmware/EXECUTION_CHANNEL_SHA256.json'
    dump_json(dest, manifest)
    print(f'{len(spans)} instruction windows; {len(coverage["headers"])} public headers; {len(paths)} evidence files; manifest SHA-256 {sha(dest.read_bytes())}')


if __name__ == '__main__':
    main()
