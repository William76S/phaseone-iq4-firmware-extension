#!/usr/bin/env python3
"""Reproduce the narrow display13 caller/coordinate-domain audit, offline only."""
import hashlib
import json
from pathlib import Path
import struct
import subprocess

ROOT = Path(__file__).resolve().parents[3]
OUT = Path(__file__).resolve().parent
USER = ROOT / 'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA = '9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
LLVM = '/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
RANGES = [
    ('LV_paint_complete', 0x51da0c, 0x51df64),
    ('LV_ctor_pan_and_fit_fields', 0x5176b0, 0x517710),
    ('LV_local_start_complete', 0x5202a0, 0x520588),
    ('LV_SetScale_complete', 0x520814, 0x5208cc),
    ('Pan_active_getter_complete', 0x4c4cc4, 0x4c4ce8),
    ('Animation_active_leaf_complete', 0x4c4fa8, 0x4c4fc0),
    ('Pan_getter_cache_update_complete', 0x4c4a54, 0x4c4ab4),
    ('Control_draw_complete', 0x4abd24, 0x4ac040),
    ('Access_metadata_complete', 0x6b614c, 0x6b616c),
    ('Access_locked_size_and_roi_complete', 0x6b61fc, 0x6b6250),
    ('Engine_locked_size_roi_and_metadata_complete', 0x6b6d44, 0x6b6e08),
    ('VideoBuffer_locked_size_and_roi_complete', 0x6b6b70, 0x6b6c80),
    ('LV_source_point_metadata_fields', 0x51f57c, 0x51f5ec),
    ('Access_set_config_complete', 0x6b639c, 0x6b6460),
    ('Engine_fit_helper_complete', 0x7974e8, 0x7975d0),
    ('Engine_set_config_complete', 0x7975d0, 0x7977e0),
    ('Engine_metadata_dimension_initialization', 0x7995e0, 0x799680),
    ('Producer_FPGA_size_field_calls', 0x7876cc, 0x78771c),
    ('Producer_locked_size_and_roi', 0x787838, 0x787884),
    ('Stock_projection_complete', 0x476e6c, 0x477038),
    ('Stock_image_draw_complete', 0x477038, 0x477384),
]
REFERENCES = [
    'tools/firmware/f1_stock_display_payload_13/payload.c',
    'tools/firmware/f1_stock_display_payload_13/payload.h',
    'tools/firmware/f1_stock_display_payload_13/wrapper.S',
    'tools/firmware/f1_stock_display_payload_13/SOURCE_SHA256.json',
    'tools/firmware/f1_stock_display_payload_13/LINK_INPUT.json',
    'analysis/firmware/f1_display13_no_effect_static_review_01/REVIEW.md',
    'analysis/firmware/f1_display13_no_effect_static_review_01/REVIEW.json',
    'analysis/firmware/f1_display13_no_effect_static_review_01/SHA256.json',
]


def digest(b):
    return hashlib.sha256(b).hexdigest()


def main():
    b = USER.read_bytes()
    assert len(b) == 11874544 and digest(b) == SHA
    assert b[:6] == b'\x7fELF\x02\x01'
    assert struct.unpack_from('<H', b, 16)[0] == 2
    assert struct.unpack_from('<H', b, 18)[0] == 183
    phoff, = struct.unpack_from('<Q', b, 32)
    phsize, phcount = struct.unpack_from('<HH', b, 54)
    ph = [struct.unpack_from('<IIQQQQQQ', b, phoff+i*phsize) for i in range(phcount)]

    def window(va, n):
        found = [p for p in ph if p[0] == 1 and p[3] <= va and va+n <= p[3]+p[5]]
        assert len(found) == 1
        p = found[0]
        off = p[2]+va-p[3]
        return off, b[off:off+n]

    anchors = {
        0x51da0c: 0xa9a97bfd, 0x51da10: 0x910003fd,
        0x51ddcc: 0x97fd649b,
        0x4c4cd4: 0x91008000, 0x4c4fb4: 0x39402000,
        0x6b6df8: 0xd288ec00,
        0x799600: 0xfc44c043, 0x79960c: 0xfc164363,
        0x799674: 0xfd23c260, 0x799678: 0xfd23ce60,
    }
    for va, word in anchors.items():
        assert struct.unpack('<I', window(va, 4)[1])[0] == word, hex(va)

    rows = []
    for name, lo, hi in RANGES:
        off, raw = window(lo, hi-lo)
        listing = subprocess.check_output([LLVM, '-d', f'--start-address={lo}',
            f'--stop-address={hi}', str(USER)], text=True)
        listing = listing.replace(str(USER), 'analysis/firmware/extracted/P1Linux_6.03.21.bin')
        listing = 'EXACT USER SHA256 '+SHA+'\nSTATIC ONLY; no target execution or actual field read.\n'+\
            '\n'.join(line.rstrip() for line in listing.splitlines())+'\n'
        (OUT/(name+'.txt')).write_text(listing)
        rows.append({'name': name, 'va': hex(lo), 'end_exclusive': hex(hi),
            'file_offset': hex(off), 'bytes': len(raw), 'sha256': digest(raw),
            'bytes_hex': raw.hex(), 'disassembly_file': name+'.txt'})
    tables = []
    for name, va, count in [('LCD_primary_and_IScreen',0xb7cf80,12),('Draw_table',0xb7b7c8,6)]:
        off, raw = window(va, count*8)
        tables.append({'name': name, 'va': hex(va), 'file_offset': hex(off),
            'bytes_hex': raw.hex(), 'sha256': digest(raw),
            'qwords_hex': [hex(x) for x in struct.unpack('<'+'Q'*count, raw)]})
    refs = []
    for path in REFERENCES:
        raw = (ROOT/path).read_bytes()
        refs.append({'path':path,'bytes':len(raw),'sha256':digest(raw)})
    exact = {'schema':'iq4_f1_display13_postflash_static_01','original_user_sha256':SHA,
        'original_user_bytes':len(b),'target_executed':False,'device_access':False,
        'evidence_level':'static_only','ranges':rows,'tables':tables,'references':refs,
        'anchors':[{'va':hex(va),'word_le':window(va,4)[1].hex()} for va in anchors]}
    (OUT/'EXACT_BYTES.json').write_text(json.dumps(exact, indent=2)+'\n')
    members = []
    for p in sorted(OUT.iterdir()):
        if p.is_file() and p.name != 'manifest.json':
            raw = p.read_bytes()
            members.append({'path':p.name,'bytes':len(raw),'sha256':digest(raw)})
    (OUT/'manifest.json').write_text(json.dumps({'schema':'iq4_static_evidence_manifest_01',
        'target_execution':False,'device_access':False,'original_user_sha256':SHA,
        'members':members},indent=2)+'\n')
    print(json.dumps({'ranges':len(rows),'tables':len(tables),'anchors':len(anchors),
        'manifest_sha256':digest((OUT/'manifest.json').read_bytes())}))


if __name__ == '__main__':
    main()
