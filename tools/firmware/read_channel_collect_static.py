#!/usr/bin/env python3
"""Capture offline original bytes/instructions; never sends device packets."""
from pathlib import Path
import hashlib
import json
import subprocess

ROOT = Path(__file__).resolve().parents[2]
ELF = ROOT / 'analysis/firmware/extracted/P1Linux_6.03.21.bin'
EXPECTED = '9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
RANGES = [
    ('usb_mux_rx', 0x87483c, 0x874b9c),
    ('usb_channel_lookup', 0x875300, 0x8754c0),
    ('usb_endpoint_names_use', 0x40fba8, 0x40fc38),
    ('data_header_constructor', 0x84bb0c, 0x84bb7c),
    ('common_header_constructor', 0x84b73c, 0x84b7a4),
    ('common_pointer_marker', 0x856b00, 0x856b44),
    ('common_pointer_getter', 0x84c178, 0x84c1a0),
    ('open_state_gate', 0x851c3c, 0x8522e8),
    ('programming_channel_factory', 0x85d108, 0x85d3bc),
    ('programming_event_dispatch', 0x8700f0, 0x870418),
    ('file_read_open_start', 0x870418, 0x8707a0),
    ('file_outgoing_provider', 0x870a2c, 0x870ca0),
    ('file_open_response_send', 0x870ca0, 0x870e74),
    ('file_open_response_header', 0x87172c, 0x8717a4),
    ('file_client_open', 0x750f9c, 0x751218),
    ('linux_fs_open_flags', 0x825ed4, 0x826010),
]

def sha(data):
    return hashlib.sha256(data).hexdigest()

def main():
    raw = ELF.read_bytes()
    if sha(raw) != EXPECTED:
        raise SystemExit('Unknown firmware SHA-256; refusing static capture')
    out = ROOT / 'analysis/firmware/read_channel_static'
    out.mkdir(exist_ok=True)
    records = []
    for name, start, end in RANGES:
        data = raw[start-0x400000:end-0x400000]
        result = subprocess.check_output([
            '/Library/Developer/CommandLineTools/usr/bin/llvm-objdump', '-d',
            f'--start-address={start:#x}', f'--stop-address={end:#x}',
            str(ELF.relative_to(ROOT)),
        ], cwd=ROOT, text=True)
        p = out / (name + '.disasm.txt')
        p.write_text('INPUT SHA256 '+EXPECTED+'\nSTATIC ONLY; private nearest-symbol labels are not authoritative.\n'+result)
        records.append({'name': name, 'start_va': hex(start), 'end_va_exclusive': hex(end),
                        'file_offset': hex(start-0x400000), 'bytes_hex': data.hex(),
                        'bytes_sha256': sha(data), 'disassembly': str(p.relative_to(ROOT)),
                        'disassembly_sha256': sha(p.read_bytes())})
    (out/'exact_bytes.json').write_text(json.dumps({
        'input_sha256': EXPECTED, 'evidence_level': 'static_only',
        'device_accessed': False, 'packet_generated_or_sent': False, 'ranges': records,
    }, indent=2)+'\n')
    paths = sorted(out.glob('*'))
    paths += sorted((ROOT/'analysis/firmware/decompiled_read_channel').glob('*.c'))
    paths += [Path(__file__).resolve(), ROOT/'analysis/firmware/FILE_READ_TRANSPORT.md',
              ROOT/'analysis/firmware/read_channel_decompile_targets.txt']
    manifest = {'input_sha256': EXPECTED, 'evidence_level': 'static_only',
                'files': {str(p.relative_to(ROOT)): sha(p.read_bytes()) for p in paths}}
    dest = ROOT/'analysis/firmware/FILE_READ_TRANSPORT_SHA256.json'
    dest.write_text(json.dumps(manifest, indent=2)+'\n')
    print(f'Captured {len(records)} instruction windows; manifest sha256 {sha(dest.read_bytes())}')

if __name__ == '__main__':
    main()
