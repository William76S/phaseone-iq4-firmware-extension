#!/usr/bin/env python3
"""Run and record sequential offline static sealing of two actual 63-object ELFs."""
from pathlib import Path
import hashlib
import json
import subprocess

ROOT = Path(__file__).resolve().parents[3]
OUT = Path(__file__).resolve().parent
PYTHON = ROOT / 'build/host-venv/bin/python'


def main():
    assert not (OUT / 'COMMANDS.json').exists()
    commands = []
    common = ['--loader-proof', 'tools/firmware/native_copy_rtti_01/ABI_PROOF.json']
    jobs = [('identity', ['tools/firmware/native_linked_unwind_02/test_identity.py'])]
    for name in ('a', 'b'):
        build = 'analysis/firmware/native_linked_unwind_build_02_validation02/' + name
        jobs.extend((
            (name + '_unsealed', ['tools/firmware/native_linked_unwind_02/verify.py', '--build', build]),
            (name + '_seal', ['tools/firmware/native_linked_contract_01/seal.py', '--build', build] + common),
            (name + '_sealed', ['tools/firmware/native_linked_unwind_02/verify.py', '--build', build]),
            (name + '_readback', ['tools/firmware/native_linked_unwind_02/readback.py', '--build', build,
                                 '--library', 'analysis/firmware/native_linked_contract_User_host_validation_02/contract.dylib']),
        ))
    for name, argv in jobs:
        result = subprocess.run([str(PYTHON)] + argv, cwd=ROOT, capture_output=True)
        stdout, stderr = OUT / (name + '.stdout'), OUT / (name + '.stderr')
        assert not stdout.exists() and not stderr.exists()
        stdout.write_bytes(result.stdout); stderr.write_bytes(result.stderr)
        commands.append(dict(argv=[str(PYTHON)] + argv, cwd=str(ROOT), exit_code=result.returncode,
                             stdout=dict(path=str(stdout.relative_to(ROOT)), bytes=len(result.stdout), sha256=hashlib.sha256(result.stdout).hexdigest()),
                             stderr=dict(path=str(stderr.relative_to(ROOT)), bytes=len(result.stderr), sha256=hashlib.sha256(result.stderr).hexdigest())))
        (OUT / 'COMMANDS.json').write_text(json.dumps(commands, indent=2) + '\n')
        print(name, result.returncode, result.stdout.decode().strip(), flush=True)
        assert result.returncode == 0, result.stderr.decode()


if __name__ == '__main__':
    main()
