#!/usr/bin/env python3
"""Rebuild the native-LV-menu candidate from exact local inputs; no target run."""
from pathlib import Path
import argparse
import hashlib
import importlib.util
import json
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
BACKEND = ROOT / 'tools/firmware/f1_user_elf_append_02/elf_append.py'
BACKEND_SHA = '3c6b4ccaafa1a524f39bac98f91058791526cef0289dd33b89967dd3f50d3fd9'
ZIG_SHA = 'c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def row(p):
    p = p.resolve()
    label = str(p.relative_to(ROOT)) if p.is_relative_to(ROOT) else str(p)
    return dict(path=label, bytes=p.stat().st_size, sha256=sha(p))


def load_backend(spec):
    if sha(BACKEND) != BACKEND_SHA:
        raise ValueError('Frozen ELF backend changed')
    s = importlib.util.spec_from_file_location('iq4_native_menu_elf_backend', BACKEND)
    m = importlib.util.module_from_spec(s)
    sys.modules[s.name] = m
    s.loader.exec_module(m)
    permitted = {0x4eea58: '43320094', 0x4ee780: 'f9320094'}
    hook_rows = spec['menu_call_sites']
    if len(hook_rows) != 2 or {int(x['va'], 16) for x in hook_rows} != set(permitted):
        raise ValueError('Finite native LV SetMenu call sites required')
    sites = []
    for h in hook_rows:
        va = int(h['va'], 16)
        if h['old_bytes'] != permitted.get(va):
            raise ValueError('Unknown native menu call site')
        sites.append((va, bytes.fromhex(h['old_bytes']), 0x4fb364,
                      'iq4_f1_native_menu_wrapper_01'))
    m.HOOKS = ((0x51ddcc, bytes.fromhex('9b64fd97'), 0x477038,
                'iq4_f1_lv_draw_wrapper_13'), *sites)
    m.ALIASES = {'iq4_stock_menu_set_01': (0x4fb364, 'native_SetMenu')}
    m.INITIALIZER = 'iq4_f1_menu_initialize_01'
    m.REQUIRED_SYMBOLS = tuple(x[3] for x in m.HOOKS) + (
        m.INITIALIZER, 'iq4_f1_mode_get_01', 'iq4_f1_mode_set_on_ui_01')
    return m


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output', type=Path, required=True)
    ap.add_argument('--zig', type=Path, required=True)
    ap.add_argument('--stock', type=Path, required=True)
    ap.add_argument('--original-fwr', type=Path, required=True)
    ap.add_argument('--original-fwp', type=Path, required=True)
    a = ap.parse_args()
    sources_lock = json.loads((HERE / 'SOURCE_SHA256.json').read_text())
    for name, expected in sources_lock['files'].items():
        source = ROOT / name
        if source.stat().st_size != expected['bytes'] or sha(source) != expected['sha256']:
            raise ValueError('Source/dependency differs: ' + name)
    out = a.output.resolve()
    if out.exists() or not out.is_relative_to(ROOT):
        raise ValueError('Fresh project-local output directory required')
    if sha(a.zig) != ZIG_SHA:
        raise ValueError('Exact Zig 0.15.2 compiler required')
    spec = json.loads((HERE / 'NATIVE_CONTRACT.json').read_text())
    backend = load_backend(spec)
    stock = a.stock.read_bytes()
    original = backend.original_contract(stock)
    for r in spec['original_regions']:
        blob = stock[original.va_offset(int(r['va'], 16), r['bytes']):][:r['bytes']]
        if hashlib.sha256(blob).hexdigest() != r['sha256']:
            raise ValueError('Native menu ABI region changed: ' + r['name'])
    out.mkdir(parents=True)
    commands = []

    def run(args):
        args = [str(x) for x in args]
        p = subprocess.run(args, cwd=ROOT, capture_output=True, text=True)
        commands.append(dict(argv=args, exit=p.returncode, stdout=p.stdout, stderr=p.stderr))
        (out / 'COMMANDS.json').write_text(json.dumps(commands, indent=2) + '\n')
        if p.returncode:
            raise RuntimeError(p.stdout + p.stderr)
        return p.stdout

    if run([a.zig, 'version']).strip() != '0.15.2':
        raise ValueError('Compiler version mismatch')
    cflags = ['-target', 'aarch64-linux-gnu.2.28', '-std=c11', '-O2', '-g0',
              '-ffp-contract=off', '-fno-strict-aliasing', '-ffreestanding',
              '-fno-stack-protector', '-mno-outline-atomics', '-funwind-tables',
              '-fno-asynchronous-unwind-tables', '-fno-omit-frame-pointer',
              '-fno-optimize-sibling-calls', '-ffunction-sections', '-fdata-sections',
              '-fPIC', '-Wall', '-Wextra', '-Werror']
    display = ROOT / 'tools/firmware/f1_stock_display_payload_13'
    sources = [(HERE / 'runtime.c', 'menu.o'), (HERE / 'wrapper.S', 'menu_wrapper.o'),
               (display / 'payload.c', 'display.o'), (display / 'wrapper.S', 'display_wrapper.o')]
    objects = []
    for source, name in sources:
        obj = out / name
        flags = cflags if source.suffix == '.c' else ['-target', 'aarch64-linux-gnu.2.28', '-g0', '-fPIC']
        run([a.zig, 'cc', *flags, '-MMD', '-MF', out / (name + '.d'), '-c', source, '-o', obj])
        objects.append((str(obj.relative_to(ROOT)), obj.read_bytes()))
    candidate, report = backend.Linker(stock, objects).build((6, 3, 24))
    user = out / 'P1Linux_F1_NativeMenu_6.03.24.bin'
    user.write_bytes(candidate)
    report['native_menu_contract'] = row(HERE / 'NATIVE_CONTRACT.json')
    report['old_independent_button_and_queue_hooks_removed'] = True
    report['build_commands'] = commands[:]
    (out / 'LINK_REPORT.json').write_text(json.dumps(report, indent=2) + '\n')
    run([sys.executable, '-B', ROOT / 'tools/firmware/user_only_package_stock_wrapper_02/package.py',
         '--original-fwr', a.original_fwr, '--original-fwp', a.original_fwp,
         '--user-payload', user, '--expected-user-sha256', sha(user),
         '--app-version', '6.03.24', '--release-version', '6.03.21', '--system-version', '8.02.3',
         '--emit-candidate-directory', out / 'package'])
    result = dict(schema='iq4_F1_native_menu_build_01', input_User=row(a.stock),
                  actual_four_cross_compiles=True, original_menu_contract=row(HERE / 'NATIVE_CONTRACT.json'),
                  User=row(user), FWR=row(out / 'package/IQ4-user-only.fwr'),
                  FWP=row(out / 'package/IQ4-user-only-candidate.fwp'),
                  target_or_camera_or_SDK_executed=False, in_camera_acceptance=False)
    (out / 'BUILD.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
