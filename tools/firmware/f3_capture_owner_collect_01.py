#!/usr/bin/env python3
"""Read only finite original RAW resource-reference windows. No target calls."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[2]
ELF = ROOT / 'tools/firmware/f1_user_elf_append_02/elf_append.py'
STOCK = ROOT / 'analysis/firmware/extracted/P1Linux_6.03.21.bin'
EXPECTED = '9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
WINDOWS = {
    'node_test_acquire': (0x8c25c0, 0x8c2668),
    'node_test_decrement': (0x8c2668, 0x8c26d8),
    'node_frame_acquire': (0x8c2750, 0x8c27e0),
    'node_frame_decrement': (0x8c27e0, 0x8c2850),
    'node_frame_dispose': (0x8c2850, 0x8c28c8),
    'test_pool_acquire': (0x6f07cc, 0x6f0988),
    'test_pool_decrement': (0x6f0988, 0x6f0a9c),
    'test_pool_dispose': (0x6f0a9c, 0x6f0b9c),
    'frame_pool_acquire': (0x8c36c0, 0x8c387c),
    'frame_pool_decrement': (0x8c387c, 0x8c3990),
    'frame_pool_dispose': (0x8c3990, 0x8c3a90),
    'retire_bridge': (0x8c5990, 0x8c5a18),
    'test_reference_wait': (0x8c5a18, 0x8c5c38),
    'jpeg_payload_and_meta_borrow': (0x7b77e0, 0x7b7908),
}
LITERALS = {'node_source_file': 0xdb3ea8, 'test_resource_name': 0xdb3f98,
            'frame_resource_name': 0xdb3fa8, 'preview_resource_name': 0xdb3fb8,
            'frame_manager_source_file': 0xdb4098}


def digest(data):
    return hashlib.sha256(data).hexdigest()


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output', type=Path, required=True)
    out = p.parse_args().output.resolve()
    assert out.is_relative_to(ROOT) and not out.exists()
    assert digest(ELF.read_bytes()) == '3c6b4ccaafa1a524f39bac98f91058791526cef0289dd33b89967dd3f50d3fd9'
    stock = STOCK.read_bytes()
    assert len(stock) == 11874544 and digest(stock) == EXPECTED
    spec = importlib.util.spec_from_file_location('f3_capture_owner_original_elf', ELF)
    m = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = m
    spec.loader.exec_module(m)
    elf = m.Elf(stock, 2)
    out.mkdir(parents=True)
    records = []
    for label, (start, stop) in WINDOWS.items():
        off = elf.va_offset(start, stop - start)
        raw = stock[off:off + stop - start]
        command = ['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump', '-d',
                   f'--start-address={start}', f'--stop-address={stop}', str(STOCK)]
        result = subprocess.run(command, check=True, text=True, capture_output=True)
        asm = '\n'.join(line.rstrip() for line in result.stdout.splitlines()
                        if line.startswith('  ')) + '\n'
        (out / (label + '.asm')).write_text(asm)
        records.append({'label': label, 'va': start, 'end': stop, 'file_offset': off,
                        'bytes': len(raw), 'hex': raw.hex(), 'sha256': digest(raw),
                        'disasm_sha256': digest(asm.encode()), 'command': command,
                        'returncode': result.returncode})
    literals = []
    for label, va in LITERALS.items():
        off = elf.va_offset(va, 1)
        end = stock.index(b'\0', off, off + 256) + 1
        raw = stock[off:end]
        literals.append({'label': label, 'va': va, 'file_offset': off,
                         'bytes': len(raw), 'hex': raw.hex(), 'sha256': digest(raw),
                         'text': raw[:-1].decode('ascii')})
    record = {'schema': 'iq4_f3_capture_owner_finite_static_01',
              'input_sha256': EXPECTED, 'windows': records, 'literals': literals,
              'collector_sha256': digest(Path(__file__).read_bytes()),
              'target_or_SDK_or_camera_executed': False,
              'name_does_not_prove_or_disprove_complete_RAW': True,
              'capture_source_builder_or_retention_installed': False}
    (out / 'EXACT.json').write_text(json.dumps(record, indent=2) + '\n')
    print(json.dumps({'windows': len(records), 'literals': len(literals),
                      'sha256': digest((out / 'EXACT.json').read_bytes()),
                      'target_executed': False}))


if __name__ == '__main__':
    main()
