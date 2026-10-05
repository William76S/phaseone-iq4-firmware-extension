#!/usr/bin/env python3
"""Assemble existing F4 objects with the frozen metadata adapter; never execute target code."""
import argparse
import hashlib
import json
from pathlib import Path
import struct
import subprocess

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def run(argv):
    r = subprocess.run([str(x) for x in argv], cwd=ROOT, text=True,
                       stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    if r.returncode:
        raise SystemExit(r.stdout + '\ncommand failed: ' + str(argv[0]))
    return r.stdout


def inspect_object(p):
    b = p.read_bytes()
    if len(b) < 64 or b[:6] != b'\x7fELF\x02\x01' or struct.unpack_from('<HH', b, 16) != (1, 183):
        raise SystemExit('expected ET_REL AArch64: ' + str(p))
    off, entry, count, strings = (struct.unpack_from('<Q', b, 40)[0],
                                  *struct.unpack_from('<HHH', b, 58))
    if entry != 64 or not count or strings >= count or off + count * entry > len(b):
        raise SystemExit('invalid ELF section table')
    sections = [struct.unpack_from('<IIQQQQIIQQ', b, off + i * entry) for i in range(count)]
    table = sections[strings]
    names = b[table[4]:table[4] + table[5]]
    if len(names) != table[5]:
        raise SystemExit('invalid ELF section name table')
    startup = []
    for s in sections:
        if s[0] >= len(names) or b'\0' not in names[s[0]:]:
            raise SystemExit('invalid ELF section name')
        n = names[s[0]:].split(b'\0', 1)[0].decode('ascii')
        if s[1] != 8 and s[4] + s[5] > len(b):
            raise SystemExit('invalid ELF section data extent')
        if n.startswith(('.init_array', '.preinit_array', '.fini_array')) and s[5]:
            startup.append({'name': n, 'size': s[5]})
    if startup:
        raise SystemExit('unexpected automatic initialization/finalization section: ' + str(startup))
    return {'size': len(b), 'sha256': sha(p), 'format': 'ELF64LE AArch64 ET_REL',
            'nonempty_startup_array_sections': startup, 'executed': False}


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--zig', type=Path, required=True)
    p.add_argument('--output', type=Path, required=True)
    args = p.parse_args()
    manifest_path = HERE / 'SOURCE_LOCK.json'
    manifest = json.loads(manifest_path.read_text())
    for f in manifest['files'] + manifest['dependencies']:
        path = ROOT / f['path']
        if path.stat().st_size != f['size'] or sha(path) != f['sha256']:
            raise SystemExit('source/dependency mismatch: ' + f['path'])
    zig = args.zig.resolve()
    lock = json.loads((ROOT / 'tools/target/toolchain.lock.json').read_text())
    if sha(zig) != lock['zig_binary_sha256'] or run([zig, 'version']).strip() != lock['version']:
        raise SystemExit('compiler does not match the existing toolchain lock')
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    metadata_dir = ROOT / 'build/f4_native_metadata_adapter_host_02'
    proof = json.loads((metadata_dir / 'HOST_VALIDATION.json').read_text())
    if proof['source_lock_sha256'] != sha(ROOT / 'tools/firmware/f4_native_metadata_adapter_01/SOURCE_LOCK.json'):
        raise SystemExit('metadata objects are not bound to the frozen source lock')
    objects, receipts, commands = [], {}, []
    for f in proof['target_objects']:
        source = metadata_dir / f['path']
        if source.stat().st_size != f['size'] or sha(source) != f['sha256']:
            raise SystemExit('metadata object mismatch')
        dest = out / f['path']
        dest.write_bytes(source.read_bytes())
        objects.append(dest)
        receipts[dest.name] = inspect_object(dest)
    sources = [
        'tools/firmware/f4_owned_copy_pool_01/recorder_worker.cpp',
        'src/runtime/recording.cpp', 'src/recording/rgb_jpeg_backend.cpp',
        'src/codec/bounded_jpeg.c', 'src/recording/mjpeg_avi.cpp',
    ]
    common = ['-target', lock['target'], '-O2', '-g0', '-fPIC',
              '-Wall', '-Wextra', '-Werror', '-DIQ4_JPEG_API_VERSION=82',
              '-ffile-prefix-map=' + str(ROOT) + '=.']
    for source in sources:
        c = source.endswith('.c')
        obj = out / (Path(source).stem + '.aarch64.o')
        cmd = [zig, 'cc' if c else 'c++', *common,
               '-std=c11' if c else '-std=c++17', *([] if c else ['-pthread']),
               '-c', source, '-o', obj]
        run(cmd)
        commands.append([str(x) for x in cmd])
        objects.append(obj)
        receipts[obj.name] = inspect_object(obj)
    if len(objects) != 8 or len({x.name for x in objects}) != 8:
        raise SystemExit('expected exactly eight distinct production objects')
    archive = out / 'libiq4_f4_metadata_recording_reuse.a'
    cmd = [zig, 'ar', 'rcsD', archive, *objects]
    run(cmd)
    commands.append([str(x) for x in cmd])
    members = run([zig, 'ar', 't', archive]).splitlines()
    if members != [x.name for x in objects]:
        raise SystemExit('archive member identity/order mismatch')
    symbols = run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump', '-t', archive])
    if 'copy_synthetic' in symbols or 'configure_synthetic' in symbols:
        raise SystemExit('synthetic native bypass retained in production archive')
    (out / 'production_symbols.txt').write_text(symbols)
    report = {
        'schema': 'iq4_f4_metadata_recording_reuse_build_v1',
        'source_lock_sha256': sha(manifest_path), 'compiler_lock': lock,
        'metadata_object_proof_sha256': sha(metadata_dir / 'HOST_VALIDATION.json'),
        'objects': receipts, 'archive': {'size': archive.stat().st_size, 'sha256': sha(archive), 'members': members},
        'commands': commands, 'camera_access': False, 'sdk_loaded': False,
        'vendor_executed': False, 'target_executed': False, 'new_host_tests_executed': False,
        'executable_linked': False, 'shared_library_linked': False, 'device_installer': False,
        'runtime_startup_not_proven_by_object_sections': True,
        'production_pixel_copy_available': False, 'native_jpeg_table_bound': False,
        'card_path_or_storage_lease_bound': False, 'recording_page_or_worker_lifecycle_bound': False,
        'real_60fps_proven': False,
    }
    (out / 'BUILD_EVIDENCE.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({'archive': report['archive'], 'build_evidence_sha256': sha(out / 'BUILD_EVIDENCE.json')}))


if __name__ == '__main__':
    main()
