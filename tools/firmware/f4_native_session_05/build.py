#!/usr/bin/env python3
"""Reproduce pre-start failure regressions and compile the repaired session."""
import argparse
import hashlib
import json
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent


def row(path):
    data = path.read_bytes()
    return dict(path=str(path.relative_to(ROOT)), bytes=len(data),
                sha256=hashlib.sha256(data).hexdigest())


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    output = args.output.resolve()
    assert output.is_relative_to(ROOT) and not output.exists()
    output.mkdir(parents=True)
    commands = []

    def run(argv, expected_success=True):
        result = subprocess.run(list(map(str, argv)), cwd=ROOT, text=True,
                                capture_output=True)
        commands.append(dict(argv=list(map(str, argv)), exit=result.returncode,
                             stdout=result.stdout, stderr=result.stderr))
        (output / 'COMMANDS.json').write_text(json.dumps(commands, indent=2)+'\n')
        assert (result.returncode == 0) == expected_success, commands[-1]
        return result.stdout.strip()

    sdk = run(['/usr/bin/xcrun', '--show-sdk-path'])
    compiler = '/Library/Developer/CommandLineTools/usr/bin/clang'
    base = [compiler, '-isysroot', sdk, '-std=c11', '-O2', '-Wall', '-Wextra', '-Werror']
    old = ROOT / 'tools/firmware/f4_native_session_04/session.c'
    old_exe = output / 'old_session'
    run([*base, old, HERE/'test_session.c', '-o', old_exe])
    for scenario in range(10, 14):
        run([old_exe, scenario], expected_success=False)
    for variant, flags in [('normal', []), ('asan_ubsan', [
            '-fsanitize=address,undefined', '-fno-omit-frame-pointer'])]:
        exe = output / ('session_' + variant)
        run([*base, *flags, HERE/'session.c', HERE/'test_session.c', '-o', exe])
        for scenario in range(14):
            run([exe, scenario])
    zig = ROOT / 'build/toolchains/zig-aarch64-macos-0.15.2/zig'
    assert row(zig)['sha256'] == 'c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
    obj = output/'session.o'
    run([zig, 'cc', '-target', 'aarch64-linux-gnu.2.28', '-std=c11', '-O2',
         '-g0', '-Wall', '-Wextra', '-Werror', '-ffreestanding', '-fPIC',
         '-fno-stack-protector', '-mno-outline-atomics', '-funwind-tables',
         '-fno-asynchronous-unwind-tables', '-fno-omit-frame-pointer',
         '-MMD', '-MF', output/'session.d', '-c', HERE/'session.c', '-o', obj])
    result = dict(schema='iq4_f4_prestart_rejection_repair05', old_source=row(old),
                  sources=[row(HERE/name) for name in ['session.c', 'test_session.c', 'build.py']],
                  object=row(obj), compiler=row(zig), old_regressions_failed=4,
                  normal_passed=14, asan_ubsan_passed=14,
                  native_ports_synthetic=True, target_executed=False,
                  camera_accessed=False, reported_camera_hold_root_cause_proven=False)
    (output/'BUILD.json').write_text(json.dumps(result, indent=2)+'\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
