#!/usr/bin/env python3
"""Pure host cross-build of the finite read-only probe. Never execute target ELF."""
from pathlib import Path
import hashlib
import json
import os
import re
import struct
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT / 'tools/firmware'))
from save_setup_security_collect_static import sections

ZIG_REL = 'build/toolchains/zig-aarch64-macos-0.15.2/zig'
ZIG_SHA = 'c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
OUT = ROOT / 'analysis/firmware/f4_ram_loader_static'


def sha(b):
    return hashlib.sha256(b).hexdigest()


def main():
    zig = ROOT / ZIG_REL
    assert sha(zig.read_bytes()) == ZIG_SHA
    version = subprocess.check_output([str(zig), 'version'], text=True).strip()
    assert version == '0.15.2'
    OUT.mkdir(exist_ok=True)
    source = Path(__file__).with_name('readonly_monitor.c')
    target = OUT / 'readonly_monitor.target.elf'
    env = dict(os.environ)
    env['ZIG_GLOBAL_CACHE_DIR'] = str(OUT / '.zig-cache/global')
    env['ZIG_LOCAL_CACHE_DIR'] = str(OUT / '.zig-cache/local')
    command = [ZIG_REL, 'cc', '-target', 'aarch64-linux-gnu.2.17', '-std=c11', '-O2',
               '-Wall', '-Wextra', '-Werror', '-fPIE', '-pie', '-Wl,--build-id=sha1',
               str(source.relative_to(ROOT)), '-o', str(target.relative_to(ROOT))]
    subprocess.run([str(zig), *command[1:]], check=True, cwd=ROOT, env=env)
    raw = target.read_bytes()
    assert raw[:6] == b'\x7fELF\x02\x01'
    elf_type, machine = struct.unpack_from('<HH', raw, 16)
    assert (elf_type, machine) == (3, 183)
    layout = sections(raw)
    dynsym = next(s for s in layout if s['name'] == '.dynsym')
    dynstr = next(s for s in layout if s['name'] == '.dynstr')
    strings = raw[dynstr['offset']:dynstr['offset'] + dynstr['size']]
    imports = []
    for offset in range(dynsym['offset'], dynsym['offset'] + dynsym['size'], 24):
        name, info, other, index, value, size = struct.unpack_from('<IBBHQQ', raw, offset)
        if name and index == 0:
            imports.append(strings[name:strings.index(0, name)].decode())
    forbidden = {'kill', 'raise', 'system', 'popen', 'execve', 'execvp', 'dlopen',
                 'ptrace', 'pwrite', 'ioctl', 'socket', 'connect', 'unlink', 'rename',
                 'chmod', 'chown', 'mkdir', 'truncate', 'ftruncate', 'reboot'}
    assert not set(imports) & forbidden
    glibc_versions = sorted(set(re.findall(rb'GLIBC_[0-9.]+', raw)))
    assert glibc_versions == [b'GLIBC_2.17']
    summary = {'evidence_level': 'host_cross_build_only', 'tool': {'path': ZIG_REL,
         'sha256': ZIG_SHA, 'version': version}, 'command': command,
         'source': {'path': str(source.relative_to(ROOT)), 'sha256': sha(source.read_bytes())},
         'artifact': {'path': str(target.relative_to(ROOT)), 'sha256': sha(raw),
                      'bytes': len(raw), 'ELF_type': elf_type, 'machine': machine,
                      'glibc_versions': [v.decode() for v in glibc_versions],
                      'undefined_dynsym': sorted(imports)},
         'forbidden_imports_absent': sorted(forbidden),
         'target_executed': False, 'camera_control_or_staging': False,
         'firmware_entry_binding': False, 'recovery_writer': False,
         'does_not_prove_user_AT_SECURE_or_dynamic_loader_runtime': True}
    (OUT / 'readonly_probe_build.json').write_text(json.dumps(summary, indent=2) + '\n')
    print(json.dumps({'artifact_sha256': sha(raw), 'bytes': len(raw),
                      'target_executed': False, 'glibc_versions': summary['artifact']['glibc_versions']}))


if __name__ == '__main__':
    main()
