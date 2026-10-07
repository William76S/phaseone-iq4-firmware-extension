#!/usr/bin/env python3
"""Build and package the factory-JPEG route; never access a camera."""
from pathlib import Path
import argparse
import hashlib
import json
import os
import subprocess

ROOT = Path(__file__).resolve().parents[3]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--spec', type=Path, required=True)
    parser.add_argument('--spec-sha256', required=True)
    parser.add_argument('--build', type=Path, required=True)
    parser.add_argument('--package', type=Path, required=True)
    parser.add_argument('--app-version', default='6.03.52')
    parser.add_argument('--iq-version', default='6.03.49')
    parser.add_argument('--system-version', default='8.02.31')
    parser.add_argument('--release-date', default='2026-10-07')
    parser.add_argument('--runtime-pin-header', action='append', required=True)
    args = parser.parse_args()
    out = (ROOT / args.build).resolve()
    package = (ROOT / args.package).resolve()
    assert out.is_relative_to(ROOT) and package.is_relative_to(ROOT)
    assert not out.exists() and not package.exists()
    commands = []

    def run(argv):
        argv = list(map(str, argv))
        result = subprocess.run(argv, cwd=ROOT, capture_output=True, text=True)
        commands.append(dict(argv=argv, exit=result.returncode,
                             stdout=result.stdout, stderr=result.stderr))
        if out.exists():
            (out / 'RELEASE_CHECK_COMMANDS.json').write_text(
                json.dumps(commands, indent=2) + '\n')
        if result.returncode:
            raise RuntimeError(result.stderr or result.stdout)
        print(Path(argv[1]).name + ': PASS', flush=True)

    run(['python3', 'tools/firmware/jpeg_restart_01/build.py', '--spec', args.spec,
         '--spec-sha256', args.spec_sha256, '--output', out,
         '--app-version', args.app_version])
    run(['python3', 'tools/firmware/native_linked_unwind_03/verify.py', '--build', out])
    run(['python3', 'tools/firmware/native_linked_contract_02/seal.py', '--build', out,
         '--loader-proof', 'tools/firmware/f3_init_repair_01/ABI_PROOF.json'])
    run(['python3', 'tools/firmware/f1_f3_f4_user_integration_05/verify_user.py', '--build', out])
    argv = ['python3', 'tools/firmware/jpeg_restart_release_01/verify_pins.py', '--build', out]
    for header in args.runtime_pin_header:
        argv += ['--header', header]
    run(argv)
    user = out / f'P1Linux_RatioMask_JPEG_LVRecording_{args.app_version}.bin'
    digest = hashlib.sha256(user.read_bytes()).hexdigest()
    run(['python3', 'tools/firmware/user_only_package_stock_wrapper_03/package.py',
         '--user-payload', user.relative_to(ROOT), '--expected-user-sha256', digest,
         '--release-version', args.iq_version, '--app-version', args.app_version,
         '--system-version', args.system_version, '--release-date', args.release_date,
         '--emit-candidate-directory', package.relative_to(ROOT)])
    run(['python3', 'tools/firmware/f1_f3_f4_user_integration_05/inspect_package.py',
         '--build', out, '--package', package.relative_to(ROOT)])
    source = package / 'IQ4-user-only-candidate.fwp'
    os.link(source, package / f'IQ4_{args.app_version}.fwp')
    data = source.read_bytes()
    result = dict(version=args.app_version, IQ=args.iq_version,
                  System=args.system_version, date=args.release_date,
                  fwp_bytes=len(data), fwp_sha256=hashlib.sha256(data).hexdigest(),
                  camera_accessed=False, hardware_acceptance=False,
                  recovery_verified=False, full_size_JPEG_accepted=False)
    (out / 'DELIVERY.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result), flush=True)


if __name__ == '__main__':
    main()
