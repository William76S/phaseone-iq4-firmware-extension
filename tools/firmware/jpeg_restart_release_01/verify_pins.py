#!/usr/bin/env python3
"""Check only pin tables consumed by the simplified release, against linked User."""
from pathlib import Path
import argparse
import hashlib
import importlib.util
import json
import sys

ROOT = Path(__file__).resolve().parents[3]


def load_module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    sys.modules[name] = module
    spec.loader.exec_module(module)
    return module


def row(path):
    data = path.read_bytes()
    return dict(path=str(path.relative_to(ROOT)), bytes=len(data),
                sha256=hashlib.sha256(data).hexdigest())


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--build', type=Path, required=True)
    parser.add_argument('--header', action='append', required=True)
    args = parser.parse_args()
    out = args.build.resolve()
    build = json.loads((out / 'BUILD.json').read_text())
    user = ROOT / build['User']['path']
    assert row(user) == build['User']
    backend_path = ROOT / 'tools/firmware/f1_user_elf_append_03/elf_append.py'
    assert row(backend_path)['sha256'] == '05c7bb3eabcd471d7ef2fbe8a53c014abcc62e212a9234810521e0ec91557b6d'
    backend = load_module('jpeg_restart_pin_elf', backend_path)
    parser_module = load_module('jpeg_restart_pin_parser', ROOT /
        'tools/firmware/f1_f3_f4_user_integration_05/verify_runtime_pins.py')
    elf = backend.Elf(user.read_bytes(), 2)
    groups = []
    for header in args.header:
        path = ROOT / header
        windows = []
        for address, expected in parser_module.parse(path):
            offset = elf.va_offset(address, len(expected))
            windows.append(dict(va=hex(address), bytes=len(expected),
                                matches=elf.data[offset:offset + len(expected)] == expected))
        groups.append(dict(header=row(path), windows=windows))
    report = dict(User=row(user), groups=groups,
                  total_windows=sum(len(g['windows']) for g in groups),
                  all_match=all(w['matches'] for g in groups for w in g['windows']),
                  static_only=True, target_executed=False)
    (out / 'ORIGINAL_PIN_CHECK.json').write_text(json.dumps(report, indent=2) + '\n')
    assert report['all_match']
    print(report['total_windows'], 'consumed original-byte windows match')


if __name__ == '__main__':
    main()
