#!/usr/bin/env python3
"""Verify only frozen local source references; no SDK, target execution or IO."""
import argparse
import hashlib
import json
from pathlib import Path
import struct

ROOT = Path(__file__).resolve().parents[3]
REFERENCES = ROOT / 'analysis/firmware/no_lock_post_volatile_review_01/SOURCE_REFERENCES.json'


def digest(data):
    return hashlib.sha256(data).hexdigest()


def local(relative):
    p = Path(relative)
    if p.is_absolute() or '..' in p.parts:
        raise ValueError('only project-relative frozen references')
    result = (ROOT / p).resolve(strict=True)
    if ROOT not in result.parents or not result.is_file():
        raise ValueError('reference outside project or not a regular file')
    return result


def read_pinned(relative, expected):
    raw = local(relative).read_bytes()
    if digest(raw) != expected:
        raise ValueError('frozen source changed: ' + relative)
    return raw


def elf_sections(raw):
    if raw[:7] != b'\x7fELF\x02\x01\x01' or struct.unpack_from('<HH', raw, 16) != (2, 183):
        raise ValueError('expected bound AArch64 ET_EXEC')
    shoff = struct.unpack_from('<Q', raw, 40)[0]
    entsize, count, names_index = struct.unpack_from('<HHH', raw, 58)
    if entsize != 64 or not 0 < count < 1024 or names_index >= count or shoff + count * 64 > len(raw):
        raise ValueError('invalid ELF section bounds')
    rows = [struct.unpack_from('<IIQQQQIIQQ', raw, shoff + i * 64) for i in range(count)]
    names = raw[rows[names_index][4]:rows[names_index][4] + rows[names_index][5]]
    result = {}
    for row in rows:
        offset = row[0]
        if offset >= len(names):
            raise ValueError('invalid section name')
        end = names.find(b'\0', offset)
        if end < 0:
            raise ValueError('unterminated section name')
        name = names[offset:end].decode('ascii')
        result[name] = {'va': row[3], 'offset': row[4], 'size': row[5], 'type': row[1]}
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    if args.output.exists():
        raise ValueError('fresh output required; frozen evidence is never overwritten')
    refs = json.loads(REFERENCES.read_text())
    source = refs['input']
    raw = read_pinned(source['path'], source['sha256'])
    if len(raw) != source['bytes']:
        raise ValueError('input length changed')
    sections = elf_sections(raw)
    note = sections['.note.gnu.build-id']
    note_raw = raw[note['offset']:note['offset'] + note['size']]
    namesz, descsz, typ = struct.unpack_from('<III', note_raw, 0)
    desc_offset = 12 + ((namesz + 3) & ~3)
    if typ != 3 or note_raw[12:12 + namesz] != b'GNU\0' or note_raw[desc_offset:desc_offset + descsz].hex() != source['build_id']:
        raise ValueError('input BuildID changed')
    hashes = {}
    exacts = {}
    for pin in refs['manifests']:
        manifest = json.loads(read_pinned(pin['path'], pin['sha256']))
        for relative, expected in manifest['files'].items():
            if relative in hashes and hashes[relative] != expected:
                raise ValueError('inherited manifests disagree')
            read_pinned(relative, expected)
            hashes[relative] = expected
        exact_path = pin['exact_path']
        if exact_path not in manifest['files']:
            raise ValueError('exact windows not in frozen manifest')
        exacts[exact_path] = json.loads(local(exact_path).read_text())
    for pin in refs['source_files']:
        read_pinned(pin['path'], pin['sha256'])
        hashes[pin['path']] = pin['sha256']
    checked = []
    for selection in refs['selected_records']:
        records = exacts[selection['exact_path']].get(selection['collection'], [])
        matching = [x for x in records if x['name'] == selection['name']]
        if len(matching) != 1:
            raise ValueError('ambiguous frozen record')
        record = matching[0]
        data = bytes.fromhex(record['bytes_hex'])
        offset = int(record['file_offset'], 16)
        if not data or offset < 0 or offset + len(data) > len(raw) or raw[offset:offset + len(data)] != data or digest(data) != record['bytes_sha256']:
            raise ValueError('exact bytes differ: ' + record['name'])
        if 'bytes' in record and record['bytes'] != len(data):
            raise ValueError('record length differs')
        va = record.get('start_va', record.get('va'))
        if va is not None:
            address = int(va, 16)
            if 'section' in record:
                section = sections[record['section']]
                if section['type'] == 8 or not section['va'] <= address <= section['va'] + section['size'] - len(data) or offset != section['offset'] + address - section['va']:
                    raise ValueError('section/file mapping differs')
            if 'end_va_exclusive' in record and int(record['end_va_exclusive'], 16) != address + len(data):
                raise ValueError('exclusive end differs')
        checked.append({'exact_path': selection['exact_path'], 'name': record['name'], 'file_offset': record['file_offset'], 'bytes': len(data), 'bytes_sha256': record['bytes_sha256']})
    report = {
        'schema': 'iq4_no_lock_post_volatile_source_review_v1',
        'pass': True, 'evidence_level': 'offline_source_and_static_bytes_only',
        'input': source, 'source_references_sha256': digest(REFERENCES.read_bytes()),
        'verified_frozen_manifests': len(refs['manifests']),
        'verified_unique_source_file_hashes': len(hashes),
        'verified_selected_exact_records': len(checked), 'selected_records': checked,
        'actual_User_or_unique_event_owner_verified': False,
        'actual_backup_or_configuration_value_observed': False,
        'SDK_or_target_code_executed': False, 'camera_accessed': False,
        'configuration_write_requested': False, 'persistent_recovery_verified': False,
        'NoLock_implies_Unlocked_true': False,
        'NoLock_scope': 'four operation permissions after native recompute; Locked retained',
        'existing_Stage3_accepts_SecurityLevel': False,
        'ordinary_connection_auto_unlock_positive_chain_closed': False,
        'global_negative_callgraph_proof_claimed': False,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({k: report[k] for k in ('pass', 'verified_frozen_manifests', 'verified_unique_source_file_hashes', 'verified_selected_exact_records', 'configuration_write_requested', 'persistent_recovery_verified')}, sort_keys=True))


if __name__ == '__main__':
    main()
