#!/usr/bin/env python3
"""Run the existing real-ELF RTTI relocation model against an internal User.

The C verifiers execute on the host; this does not emulate the camera loader or
establish its actual ASLR bias. Original and replacement source stay untouched.
"""
from pathlib import Path
import argparse, hashlib, importlib.util, json, subprocess, sys

ROOT = Path(__file__).resolve().parents[3]


def row(path):
    data = path.read_bytes()
    return dict(path=str(path.relative_to(ROOT)), bytes=len(data),
                sha256=hashlib.sha256(data).hexdigest())


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--build', type=Path, required=True)
    args = parser.parse_args()
    build = args.build.resolve()
    record = json.loads((build / 'BUILD.json').read_text())
    user = ROOT / record['User']['path']
    assert row(user) == record['User'] and record['linked_contract_sealed']
    out = build / 'loaded_rtti'
    assert out.is_relative_to(ROOT) and not out.exists()
    repair = ROOT / 'tools/firmware/f3_init_repair_01'
    manifest = json.loads((repair / 'SOURCE_SHA256.json').read_text())
    for item in manifest.get('members', manifest.get('files', [])):
        assert row(ROOT / item['path']) == item, item['path']
    out.mkdir()
    sdk = subprocess.check_output(
        ['/usr/bin/xcrun', '--sdk', 'macosx', '--show-sdk-path'], text=True).strip()
    commands = []
    for name, source in [('old', ROOT / 'tools/firmware/native_copy_rtti_01/rtti.cpp'),
                         ('new', repair / 'rtti.cpp')]:
        argv = ['/usr/bin/clang++', '-std=c++17', '-isysroot', sdk,
                '-isystem', str(Path(sdk) / 'usr/include/c++/v1'), '-O1',
                '-Wall', '-Wextra', '-Werror', '-dynamiclib', str(source),
                '-o', str(out / (name + '.dylib'))]
        result = subprocess.run(argv, cwd=ROOT, text=True, capture_output=True)
        commands.append(dict(argv=argv, exit=result.returncode,
                             stdout=result.stdout, stderr=result.stderr))
        (out / 'COMMANDS.json').write_text(json.dumps(commands, indent=2) + '\n')
        assert result.returncode == 0, result.stderr
    loader = importlib.util.spec_from_file_location(
        'current_user_rtti_model', repair / 'verify_loaded.py')
    model = importlib.util.module_from_spec(loader)
    loader.loader.exec_module(model)
    model.USER = user
    sys.argv = [str(repair / 'verify_loaded.py'), str(out)]
    model.main()
    (out / 'INPUTS.json').write_text(json.dumps(dict(
        User=row(user), verifier=row(repair / 'verify_loaded.py'),
        library=row(model.LIB),
        sources=[row(ROOT / 'tools/firmware/native_copy_rtti_01/rtti.cpp'),
                 row(repair / 'rtti.cpp')],
        host_libraries=[row(out / 'old.dylib'), row(out / 'new.dylib')],
        target_executed=False), indent=2) + '\n')


if __name__ == '__main__':
    main()
