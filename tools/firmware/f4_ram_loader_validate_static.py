#!/usr/bin/env python3
"""Offline frozen hash/exact window revalidation; no target or SDK execution."""
from pathlib import Path
import hashlib
import json
import stat
import sys
from inspect_boot import Ext2
from save_setup_security_collect_static import ROOT, sections, span

OUT = ROOT / 'analysis/firmware/f4_ram_loader_static'


def sha(b):
    return hashlib.sha256(b).hexdigest()


def main():
    manifest = json.loads((OUT / 'manifest.json').read_text())
    checks = 0
    for group in ['sources_and_report', 'members', 'derived_local_only_ELFs']:
        for rel, expected in manifest[group].items():
            assert sha((ROOT / rel).read_bytes()) == expected, rel
            checks += 1
    for entry in manifest['inputs'].values():
        path = ROOT / entry['path']
        assert sha(path.read_bytes()) == entry['sha256']
        assert path.stat().st_size == entry['bytes']
        checks += 1
    files = {n['path']: (n, c) for n, c in Ext2(
             (ROOT / manifest['inputs']['ramdisk']['path']).read_bytes()).walk()}
    sources = {'ld': files['/lib/ld-2.28.so'][1],
               'busybox': files['/bin/busybox.nosuid'][1]}
    layouts = {name: sections(raw) for name, raw in sources.items()}
    exact = json.loads((OUT / 'exact_bytes.json').read_text())
    windows = 0
    for kind, rows in [('ld', exact['ld_windows']), ('busybox', exact['busybox_windows'])]:
        for record in rows:
            offset, blob, section = span(sources[kind], layouts[kind],
                        int(record['va'], 16), int(record['end_va_exclusive'], 16))
            assert offset == int(record['file_offset'], 16) and section == record['section']
            assert blob.hex() == record['bytes_hex'] and sha(blob) == record['bytes_sha256']
            assert sha((ROOT / record['disassembly']).read_bytes()) == record['disassembly_sha256']
            windows += 1
    for record in exact['data_records']:
        blob = bytes.fromhex(record['bytes_hex'])
        offset, original, section = span(sources[record['source']], layouts[record['source']],
                         int(record['va'], 16), int(record['va'], 16) + len(blob))
        assert original == blob and sha(blob) == record['bytes_sha256']
        assert offset == int(record['file_offset'], 16) and section == record['section']
        windows += 1
    rootfs = json.loads((OUT / 'rootfs_records.json').read_text())
    for record in rootfs['records']:
        path = record['path']
        if not record['present_in_exact_ramdisk']:
            assert path not in files
            continue
        meta, blob = files[path]
        assert all(record[k] == v for k, v in meta.items()), path
        if 'content_hex' in record:
            assert blob.hex() == record['content_hex']
        if 'target_bytes_hex' in record:
            assert blob.hex() == record['target_bytes_hex']
    build = json.loads((OUT / 'readonly_probe_build.json').read_text())
    target = ROOT / build['artifact']['path']
    assert sha(target.read_bytes()) == build['artifact']['sha256']
    assert target.stat().st_size == build['artifact']['bytes']
    for rel in [*manifest['members'], *manifest['sources_and_report']]:
        path = ROOT / rel
        if path.suffix in ['.json', '.md', '.py', '.c', '.txt']:
            text = path.read_text()
            assert text.endswith('\n') and not text.endswith('\n\n'), rel
            assert all(line == line.rstrip() for line in text.splitlines()), rel
    print(json.dumps({'frozen_hash_checks': checks, 'exact_binary_windows_and_data': windows,
                      'rootfs_records': len(rootfs['records']), 'target_build_sha_match': True,
                      'whitespace_checks': 'passed', 'device_accessed': False,
                      'target_executed': False}))


if __name__ == '__main__':
    main()
