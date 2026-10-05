#!/usr/bin/env python3
"""Run only native host-owned fixtures, never the AArch64 User or camera SDK."""
from pathlib import Path
import argparse
import hashlib
import json
import subprocess

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output', type=Path, required=True)
    a = p.parse_args()
    out = a.output.resolve()
    if out.exists() or not out.is_relative_to(ROOT):
        raise ValueError('new project-local output directory required')
    out.mkdir(parents=True)
    commands = []

    def run(args):
        args = [str(x) for x in args]
        r = subprocess.run(args, cwd=ROOT, text=True, capture_output=True)
        commands.append(dict(argv=args, exit=r.returncode, stdout=r.stdout, stderr=r.stderr))
        (out / 'COMMANDS.json').write_text(json.dumps(commands, indent=2) + '\n')
        if r.returncode:
            raise RuntimeError(r.stdout + r.stderr)

    for sanitizer in (False, True):
        name = 'sanitized' if sanitizer else 'normal'
        flags = ['-std=c11', '-O1', '-Wall', '-Wextra', '-Werror']
        if sanitizer:
            flags += ['-g', '-fsanitize=address,undefined', '-fno-omit-frame-pointer']
        target = out / ('menu_' + name)
        display = ROOT / 'tools/firmware/f1_stock_display_payload_13'
        run(['clang', *flags, '-ffp-contract=off', '-DIQ4_F1_DISPLAY13_HOST',
             HERE / 'test_runtime.c', display / 'payload.c', '-o', target])
        run([target])
        target = out / ('display_' + name)
        run(['clang', *flags, '-ffp-contract=off', '-DIQ4_F1_DISPLAY13_HOST',
             display / 'payload.c', display / 'test_payload.c', '-o', target])
        run([target])
    result = dict(schema='iq4_F1_native_menu_host_validation_01',
                  all_eight_commands_exit_zero=True, host_owned_memory_only=True,
                  command_log_sha256=hashlib.sha256((out / 'COMMANDS.json').read_bytes()).hexdigest(),
                  source_runtime_sha256=hashlib.sha256((HERE / 'runtime.c').read_bytes()).hexdigest(),
                  camera_or_SDK_access=False, AArch64_execution=False)
    (out / 'RESULT.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
