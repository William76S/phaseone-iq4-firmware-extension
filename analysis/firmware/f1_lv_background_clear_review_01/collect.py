#!/usr/bin/env python3
"""Finite original-LV prepaint background audit; never executes target code."""
import hashlib
import json
from pathlib import Path
import struct
import subprocess

ROOT = Path(__file__).resolve().parents[3]
OUT = Path(__file__).resolve().parent
USER = ROOT / 'analysis/firmware/extracted/P1Linux_6.03.21.bin'
USER_SHA = '9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
LLVM = '/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
WINDOWS = [
    ('UiControl_Draw_wrapper_complete', 0x4e1360, 0x4e14bc),
    ('UiControl_ctor_complete', 0x4e10c4, 0x4e11c0),
    ('LV_ctor_base_and_vtable', 0x5175b8, 0x517680),
    ('Surface_rectangle_fill_complete', 0x46f184, 0x46f370),
    ('Control_Draw_complete', 0x4abd24, 0x4ac06c),
    ('Optional_outline_surface_wrapper_complete', 0x45ac38, 0x45acb4),
    ('Outline_rectangle_wrapper_complete', 0x46f0c4, 0x46f184),
    ('Outline_edges_complete', 0x46ed20, 0x46f0c4),
    ('Surface_dirty_union_complete', 0x46ce24, 0x46cea4),
    ('Manager_Draw_complete', 0x4e32d4, 0x4e36b8),
    ('LV_paint_complete', 0x51da0c, 0x51df64),
    ('Surface_image_Draw_complete', 0x477038, 0x477384),
]
ANCHORS = {
    0x4e13c0: '00e04239',  # LDRB LV+0xb8 gate
    0x4e1418: '5b37fe97',  # fill precedes Control::Draw
    0x4e145c: '322aff97',
    0x4e1154: '01e00239',  # base ctor initializes +0xb8=true
    0x517600: 'b126ff97',  # LV ctor uses that base ctor
    0x46f2e4: '011c40f9',  # destination Surface+0x38
    0x46f34c: '60023fd6',  # fill row calls actual backend
    0x46ef30: '7df9ff97',
    0x46ef74: '6cf9ff97',
    0x46efe0: 'a6f8ff97',
    0x46f024: '95f8ff97',
}


def digest(raw):
    return hashlib.sha256(raw).hexdigest()


def main():
    raw = USER.read_bytes()
    assert len(raw) == 11874544 and digest(raw) == USER_SHA
    assert raw[:6] == b'\x7fELF\x02\x01'
    assert struct.unpack_from('<H', raw, 18)[0] == 183
    phoff = struct.unpack_from('<Q', raw, 32)[0]
    phsize, phnum = struct.unpack_from('<HH', raw, 54)
    phdrs = [struct.unpack_from('<IIQQQQQQ', raw, phoff + i * phsize)
             for i in range(phnum)]

    def read(va, count):
        matches = [p for p in phdrs if p[0] == 1 and p[3] <= va
                   and va + count <= p[3] + p[5]]
        assert len(matches) == 1
        p = matches[0]
        off = p[2] + va - p[3]
        return off, raw[off:off + count]

    for va, expected in ANCHORS.items():
        assert read(va, 4)[1].hex() == expected, hex(va)
    ranges = []
    for name, lo, hi in WINDOWS:
        off, data = read(lo, hi - lo)
        listing = subprocess.check_output([
            LLVM, '-d', '--start-address=' + str(lo),
            '--stop-address=' + str(hi), str(USER)], text=True)
        listing = listing.replace(str(USER),
                                  'analysis/firmware/extracted/P1Linux_6.03.21.bin')
        listing = ('EXACT USER SHA256 ' + USER_SHA + '\n'
                   'STATIC ONLY; no target execution or camera access.\n'
                   + '\n'.join(line.rstrip() for line in listing.splitlines()) + '\n')
        (OUT / (name + '.txt')).write_text(listing)
        ranges.append({'name': name, 'va': hex(lo), 'end_exclusive': hex(hi),
                       'file_offset': hex(off), 'bytes': len(data),
                       'sha256': digest(data), 'bytes_hex': data.hex(),
                       'disassembly_file': name + '.txt'})
    table_rows = []
    for name, va, offsets in [
            ('LV_primary_vtable', 0xb9a9d8, [0x98, 0xa0, 0xb0]),
            ('Manager_primary_vtable', 0xb8f358, [0xb0])]:
        entries = []
        for delta in offsets:
            off, data = read(va + delta, 8)
            entries.append({'slot': hex(delta), 'va': hex(va + delta),
                            'file_offset': hex(off), 'bytes_le': data.hex(),
                            'target': hex(struct.unpack('<Q', data)[0])})
        table_rows.append({'name': name, 'vtable_va': hex(va), 'entries': entries})
    assert table_rows[0]['entries'][0]['target'] == '0x4e1360'
    assert table_rows[0]['entries'][1]['target'] == '0x51da0c'
    assert table_rows[1]['entries'][0]['target'] == '0x4e32d4'
    refs = []
    for rel in ['analysis/firmware/f1_display14_requested_pair_review_01/manifest.json',
                'analysis/firmware/f1_display13_postflash_review_01/manifest.json']:
        data = (ROOT / rel).read_bytes()
        refs.append({'path': rel, 'bytes': len(data), 'sha256': digest(data)})
    evidence = {
        'schema': 'iq4_f1_lv_conditional_prepaint_fill_static_01',
        'original_user_sha256': USER_SHA,
        'target_execution': False, 'camera_access': False,
        'production_sources_modified': False,
        'ranges': ranges, 'vtable_entries': table_rows,
        'instruction_anchors': [{'va': hex(va), 'bytes_le': data}
                                for va, data in ANCHORS.items()],
        'references_unchanged': refs,
        'conclusion': {
            'conditional_rectangle_fill_before_lv_paint_exists': True,
            'fill_condition': '(original dirty predicate OR force argument) AND LV byte+0xb8',
            'base_ctor_sets_byte_b8_to_one': True,
            'runtime_byte_b8_observed': False,
            'runtime_clear_color_observed': False,
            'runtime_fill_bounds_or_complete_lcd_clear_proven': False,
            'surface_dirty_union_is_pixel_clear': False,
            'optional_control_byte_6c_primitive_is_solid_fill': False,
            'clip_write_proof_owner': 'sdk_reference; not rederived in this review',
        },
        'parent_reported_geometry_not_an_independent_device_read': {
            'projected_xywh': [77, 0, 645, 483],
            'clip_xywh': [0, 0, 800, 480], 'lcd_wh': [800, 480],
            'rotation': 0, 'format': 0,
            'arithmetic_intersection_xywh': [77, 0, 645, 480],
            'intersection_not_a_native_row_write_receipt': True,
        },
    }
    (OUT / 'EXACT_BYTES.json').write_text(json.dumps(evidence, indent=2) + '\n')
    members = []
    for p in sorted(OUT.iterdir()):
        if p.is_file() and p.name != 'manifest.json':
            data = p.read_bytes()
            members.append({'path': p.name, 'bytes': len(data), 'sha256': digest(data)})
    manifest = {'schema': 'iq4_static_evidence_manifest_01',
                'target_execution': False, 'camera_access': False, 'members': members}
    (OUT / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    print(json.dumps({'ranges': len(ranges), 'anchors': len(ANCHORS),
                      'vtable_tables': len(table_rows), 'members': len(members),
                      'manifest_sha256': digest((OUT / 'manifest.json').read_bytes())}))


if __name__ == '__main__':
    main()
