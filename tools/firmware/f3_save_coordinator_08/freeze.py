#!/usr/bin/env python3
"""Freeze one own-object replacement and its exact header/evidence closure."""
import argparse, hashlib, json, shlex, struct, zipfile
from pathlib import Path
ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
EXECUTOR = HERE.name == 'f3_native_executor_03'
STEM = 'executor' if EXECUTOR else 'coordinator'
OLD_DIR = 'f3_native_executor_02' if EXECUTOR else 'f3_save_coordinator_07'
BUILD_DIR = 'f3_native_executor_build_03_attempt04' if EXECUTOR else 'f3_save_coordinator_build_08_attempt04'
OLD_BUILD = 'f3_native_executor_build_02' if EXECUTOR else 'f3_save_coordinator_build_07'

def row(path):
    data = path.read_bytes()
    return dict(path=str(path.relative_to(ROOT)), bytes=len(data), sha256=hashlib.sha256(data).hexdigest())

def info(path):
    data = path.read_bytes()
    assert data[:6] == b'\x7fELF\x02\x01'
    elf = struct.unpack_from('<16sHHIQQQIHHHHHH', data)
    assert elf[1] == 1 and elf[2] == 183
    sections = [struct.unpack_from('<IIQQQQIIQQ', data, elf[6] + n * elf[11]) for n in range(elf[12])]
    strs = sections[elf[13]]
    names = data[strs[4]:strs[4] + strs[5]]
    def name(table, off):
        return table[off:table.index(0, off)].decode()
    alloc, relocs, undefined, defined = [], set(), set(), set()
    for section in sections:
        if section[2] & 2:
            alloc.append(dict(name=name(names, section[0]), type=section[1], flags=section[2], bytes=section[5]))
        if section[1] in (4, 9):
            for off in range(section[4], section[4] + section[5], section[9]):
                relocs.add(struct.unpack_from('<Q', data, off + 8)[0] & 0xffffffff)
        if section[1] == 2:
            string = sections[section[6]]
            table = data[string[4]:string[4] + string[5]]
            for off in range(section[4], section[4] + section[5], section[9]):
                n, binding, _, idx, _, _ = struct.unpack_from('<IBBHQQ', data, off)
                if not n:
                    continue
                symbol = name(table, n)
                if idx == 0:
                    undefined.add(symbol)
                elif binding >> 4 == 1:
                    defined.add(symbol)
    return dict(**row(path), type='ET_REL', machine=183, alloc_sections=alloc,
                relocation_types=sorted(relocs), undefined_symbols=sorted(undefined),
                defined_global_symbols=sorted(defined), executed=False)

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--verify', action='store_true')
    args = parser.parse_args()
    lock = HERE / 'SOURCE_SHA256.json'
    if args.verify:
        source = json.loads(lock.read_text())
        assert all(row(ROOT / entry['path']) == entry for entry in source['files'])
        print(json.dumps(dict(hash_rows=len(source['files']), passed=True, source_sha256=row(lock)['sha256'])))
        return
    assert not lock.exists() and not (HERE / 'LINK_OVERLAY.json').exists()
    build = ROOT / 'analysis/firmware' / BUILD_DIR
    commands = json.loads((build / 'COMMANDS.json').read_text())
    assert commands and all(command['exit_code'] == 0 for command in commands)
    for command in commands:
        if command['label'].startswith('run_actual_'):
            assert command['stderr'] == ''
    report = json.loads((build / 'BUILD.json').read_text())
    assert report['target_repeated_bytes_equal'] and not report['target_executed']
    assert (build / (STEM + '.o')).read_bytes() == (build / (STEM + '_repeat.o')).read_bytes()
    previous_path = ROOT / 'analysis/firmware' / OLD_BUILD / (STEM + '.o')
    previous, replacement = info(previous_path), info(build / (STEM + '.o'))
    expected_new = {'iq4_f3_executor_' + name + '_03' for name in (
        'begin_saved_on_native', 'cancel_saved_on_native', 'invoke_reserved_saved_on_native')} if EXECUTOR else set()
    assert set(replacement['defined_global_symbols']) == set(previous['defined_global_symbols']) | expected_new
    added_undefined = set(replacement['undefined_symbols']) - set(previous['undefined_symbols'])
    assert added_undefined == ({'f3_capture_saved_proof_03'} if EXECUTOR else {
        'f3_capture_dependencies_03', 'iq4_f3_executor_begin_saved_on_native_03',
        'iq4_f3_executor_cancel_saved_on_native_03', 'iq4_f3_executor_hold_01',
        'iq4_f3_executor_invoke_reserved_saved_on_native_03'})
    refs = [ROOT / 'tools/firmware' / OLD_DIR / name for name in ('SOURCE_SHA256.json', 'LINK_OVERLAY.json')]
    refs += [ROOT / 'tools/firmware/f3_saved_raw_capture_03/SOURCE_SHA256.json',
             ROOT / 'tools/firmware/f3_saved_raw_capture_03/LINK_OVERLAY.json',
             ROOT / 'tools/firmware/f3_capture_menu_06/SOURCE_SHA256.json']
    overlay = dict(schema='iq4_f3_executor03_single_object_overlay' if EXECUTOR else 'iq4_f3_coordinator08_single_object_overlay',
                   replace_only=previous, replacement=replacement, original_references=[row(path) for path in refs],
                   existing_public_symbol_names_unchanged=True, added_owned_symbols=sorted(expected_new),
                   added_owned_dependencies=sorted(added_undefined), no_new_original_aliases=True,
                   new_BL=[], additional_aliases=[], source_manifest_path=str(lock.relative_to(ROOT)),
                   target_executed=False, SDK_invoked=False, camera_access=False)
    (HERE / 'LINK_OVERLAY.json').write_text(json.dumps(overlay, indent=2) + '\n')
    dependency_text = (build / (STEM + '.d')).read_text().replace('\\\n', ' ')
    dependencies = [Path(path).resolve() for path in shlex.split(dependency_text.split(':', 1)[1])]
    assert all(path.is_relative_to(ROOT) for path in dependencies)
    files = [path for path in HERE.iterdir() if path.is_file() and path.name not in ('SOURCE_SHA256.json', 'PACKAGE.json')]
    files += [build / name for name in ('BUILD.json', 'COMMANDS.json', 'DELTA.diff', STEM + '.o', STEM + '.d', STEM + '_repeat.o', STEM + '_repeat.d')]
    files += dependencies + refs + [previous_path, ROOT / 'tools/firmware' / OLD_DIR / (STEM + '.cpp')]
    if EXECUTOR:
        files += [ROOT / 'tools/firmware/f3_native_executor_01/test_executor.cpp', ROOT / 'tools/firmware/native_activity_01/activity.c']
    else:
        files += [ROOT / 'tools/firmware/f3_save_coordinator_07/test_no_enqueue.cpp', ROOT / 'tools/firmware/f3_save_coordinator_06/test_lifecycle.cpp']
    rows = [row(path) for path in sorted(set(files))]
    source = dict(schema='iq4_f3_executor03_frozen_source' if EXECUTOR else 'iq4_f3_coordinator08_frozen_source',
                  files=rows, source_scope='MMD compile headers, exact actual tests/evidence and upstream manifest references; Root recursively validates the current referenced manifests',
                  host_focused_groups=18, inherited_groups=17 if EXECUTOR else 11,
                  actual_cleanup_sink_groups=0 if EXECUTOR else 16,
                  actual_saved_prepare_groups=0 if EXECUTOR else 5,
                  host_variants=['normal', 'asan_ubsan', 'tsan'] if EXECUTOR else ['normal', 'asan_ubsan'],
                  target_repeated_bytes_equal=True, target_executed=False, SDK_invoked=False, camera_access=False)
    lock.write_text(json.dumps(source, indent=2) + '\n')
    out = ROOT / 'build' / (HERE.name + '_source_01')
    assert not out.exists()
    out.mkdir(parents=True)
    archive = out / ('IQ4_F3_Executor_03_Source_01.zip' if EXECUTOR else 'IQ4_F3_Coordinator_08_Source_01.zip')
    members = [ROOT / entry['path'] for entry in rows] + [lock]
    with zipfile.ZipFile(archive, 'w', compression=zipfile.ZIP_DEFLATED, compresslevel=9) as zipped:
        for path in sorted(members):
            item = zipfile.ZipInfo(str(path.relative_to(ROOT)), date_time=(2026, 10, 5, 0, 0, 0))
            item.external_attr = 0o100644 << 16
            item.compress_type = zipfile.ZIP_DEFLATED
            zipped.writestr(item, path.read_bytes())
    package = dict(source=row(lock), link=row(HERE / 'LINK_OVERLAY.json'), archive=row(archive),
                   members=len(members), archive_kind='source_supplement_not_standalone_toolchain',
                   target_executed=False, SDK_invoked=False, camera_access=False)
    (HERE / 'PACKAGE.json').write_text(json.dumps(package, indent=2) + '\n')
    print(json.dumps(package))

if __name__ == '__main__':
    main()
