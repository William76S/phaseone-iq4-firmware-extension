#!/usr/bin/env python3
"""Build version-locked AArch64 components. Never connects to or installs on IQ4."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import struct
import subprocess

ROOT = Path(__file__).resolve().parents[2]


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def run(argv):
    return subprocess.run([str(x) for x in argv], cwd=ROOT, check=True,
                          text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT).stdout


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--zig', type=Path, required=True)
    p.add_argument('--output', type=Path, default=Path('build/target'))
    a = p.parse_args()
    zig = a.zig.resolve()
    lock = json.loads((Path(__file__).parent / 'toolchain.lock.json').read_text())
    if digest(zig) != lock['zig_binary_sha256'] or run([zig, 'version']).strip() != lock['version']:
        raise SystemExit('compiler does not match toolchain.lock.json')
    out = a.output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    include = ['-I', 'src/runtime', '-I', 'src/core/include', '-I', 'src/display/include']
    common = [zig, 'c++', '-target', lock['target'], '-std=c++17', '-O2',
              '-Wall', '-Wextra', '-Werror', '-fPIC',
              '-ffile-prefix-map=' + str(ROOT) + '=.', *include]
    sources = ['src/runtime/recording.cpp', 'src/core/lib/image_core.cpp',
               'src/display/lib/display_mask.cpp']
    # Optional codec/container implementation is built only when source exists.
    container = ROOT / 'src/recording/mjpeg_avi.cpp'
    if container.is_file():
        sources.append(str(container.relative_to(ROOT)))
        common += ['-I', 'src/recording']
    codec = ROOT / 'src/codec/bounded_jpeg.c'
    c_common = [zig, 'cc', '-target', lock['target'], '-std=c11', '-O2',
                '-Wall', '-Wextra', '-Werror', '-fPIC',
                '-ffile-prefix-map=' + str(ROOT) + '=.',
                '-DIQ4_JPEG_API_VERSION=82', '-I', 'src/codec']
    if codec.is_file():
        sources.append(str(codec.relative_to(ROOT)))
    rgb_backend = ROOT / 'src/recording/rgb_jpeg_backend.cpp'
    if codec.is_file() and container.is_file() and rgb_backend.is_file():
        sources.append(str(rgb_backend.relative_to(ROOT)))
        common += ['-I', 'src/codec', '-DIQ4_JPEG_API_VERSION=82']
    objects, commands = [], []
    for source in sources:
        obj = out / (source.replace('/', '_') + '.o')
        flags = c_common if source.endswith('.c') else common
        cmd = [*flags, '-c', source, '-o', obj]
        run(cmd)
        raw = obj.read_bytes()
        if raw[:6] != b'\x7fELF\x02\x01' or struct.unpack_from('<H', raw, 18)[0] != 183:
            raise SystemExit('unexpected object architecture: ' + str(obj))
        objects.append(obj)
        commands.append([str(x) for x in cmd])
    archive = out / 'libiq4_extension_components.a'
    if archive.exists():
        archive.unlink()  # Build product only; prevents stale archive members.
    cmd = [zig, 'ar', 'rcsD', archive, *objects]
    run(cmd)
    commands.append([str(x) for x in cmd])
    # Compile/link validation executable; deliberately never execute it here.
    validation = out / 'iq4_runtime_validation'
    cmd = [*common, '-UNDEBUG', 'src/runtime/recording.cpp',
           'tests/runtime/test_recording.cpp', '-o', validation]
    run(cmd)
    commands.append([str(x) for x in cmd])
    binary = validation.read_bytes()
    glibc = sorted(set(x.decode() for x in re.findall(rb'GLIBC_\d+\.\d+', binary)),
                   key=lambda v: tuple(map(int, v.split('_')[1].split('.'))))
    if not glibc or any(tuple(map(int, v.split('_')[1].split('.'))) > (2, 28) for v in glibc):
        raise SystemExit('linked validation executable exceeds glibc 2.28 contract')
    inputs = sources + ['tests/runtime/test_recording.cpp', 'src/runtime/recording.hpp',
                        'src/core/include/iq4/image_core.hpp', 'src/display/include/iq4/display_mask.hpp',
                        'tools/target/build_target.py', 'tools/target/toolchain.lock.json']
    if container.is_file():
        inputs.append('src/recording/mjpeg_avi.hpp')
    if codec.is_file():
        inputs += ['src/codec/bounded_jpeg.h']
        inputs += [str(p.relative_to(ROOT)) for p in
                   sorted((ROOT / 'src/codec/vendor').rglob('*.h'))]
    if str(rgb_backend.relative_to(ROOT)) in sources:
        inputs.append('src/recording/rgb_jpeg_backend.hpp')
    manifest = {
        'schema_version': 1, 'evidence_level': 'host_cross_compile_and_elf_inspection',
        'target': lock['target'], 'compiler': lock,
        'source_sha256': {s: digest(ROOT / s) for s in inputs},
        'artifacts': {x.name: {'sha256': digest(x), 'bytes': x.stat().st_size}
                      for x in [archive, validation, *objects]},
        'validation_binary_glibc_versions': glibc, 'commands': commands,
        'camera_operations_performed': False, 'executed_on_target': False,
        'device_installer': False, 'native_frame_encoder_ui_adapters_verified': False,
        'limitations': ['No device readback, loader or ABI validation',
                        'Target validation executable was not run',
                        'No firmware modification or install procedure is implemented']}
    (out / 'target_build.json').write_text(json.dumps(manifest, indent=2) + '\n')
    print(json.dumps({'target': lock['target'], 'archive_sha256': digest(archive),
                      'validation_sha256': digest(validation), 'manifest': str(out / 'target_build.json'),
                      'device_installer': False}))


if __name__ == '__main__':
    main()
