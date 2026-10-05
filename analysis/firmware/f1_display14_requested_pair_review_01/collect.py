#!/usr/bin/env python3
"""Finite offline proof of the native LV configured-output pair; no execution."""
import hashlib
import json
from pathlib import Path
import struct
import subprocess

ROOT = Path(__file__).resolve().parents[3]
OUT = Path(__file__).resolve().parent
USER = ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA = '9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
LLVM = '/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
RANGES = [
    ('Local_Start_output_pair_and_config',0x520364,0x520410),
    ('Size_pair_construct_complete',0x431760,0x431794),
    ('Access_metadata_getter_complete',0x6b614c,0x6b616c),
    ('Engine_metadata_getter_complete',0x6b6dec,0x6b6e08),
    ('Local_Start_normal_scale',0x520488,0x5204dc),
    ('Access_set_config_complete',0x6b639c,0x6b6460),
    ('Engine_set_config_complete',0x7975d0,0x7977e0),
    ('Engine_ROI_fit_complete',0x7974e8,0x7975d0),
    ('Engine_mode_selection_complete',0x7973c0,0x7974e8),
    ('Mode_descriptor_complete',0x44e9b0,0x44eb0c),
    ('Producer_call_passes_same_config',0x7972c8,0x7972e4),
    ('Producer_config_pointer_capture',0x787578,0x7875e0),
    ('Producer_size_fields_read',0x7876cc,0x78771c),
    ('Producer_size_and_ROI_publish',0x787838,0x787884),
    ('Paint_locked_size_metadata_ROI_and_Image',0x51db50,0x51dc10),
]


def sha(b):
    return hashlib.sha256(b).hexdigest()


def main():
    b=USER.read_bytes()
    assert len(b)==11874544 and sha(b)==SHA
    assert b[:6]==b'\x7fELF\x02\x01' and struct.unpack_from('<H',b,18)[0]==183
    phoff=struct.unpack_from('<Q',b,32)[0]
    es,n=struct.unpack_from('<HH',b,54)
    ph=[struct.unpack_from('<IIQQQQQQ',b,phoff+i*es) for i in range(n)]

    def read(va,count):
        found=[p for p in ph if p[0]==1 and p[3]<=va and va+count<=p[3]+p[5]]
        assert len(found)==1
        p=found[0];off=p[2]+va-p[3]
        return off,b[off:off+count]

    anchors={0x5203a4:0xf9002c01,0x5203f8:0x52800024,
        0x6b6df8:0xd288ec00,0x7972d8:0xd288ec02,
        0x787590:0xaa0203f7,0x787840:0xb9405ee5,
        0x7976fc:0x34000241,0x797740:0x14000009,
        0x797754:0x121e36f7,0x797758:0x121e36b5}
    for va,word in anchors.items():
        assert struct.unpack('<I',read(va,4)[1])[0]==word,hex(va)
    rows=[]
    for name,lo,hi in RANGES:
        off,raw=read(lo,hi-lo)
        s=subprocess.check_output([LLVM,'-d',f'--start-address={lo}',f'--stop-address={hi}',str(USER)],text=True)
        s=s.replace(str(USER),'analysis/firmware/extracted/P1Linux_6.03.21.bin')
        s='EXACT USER SHA256 '+SHA+'\nSTATIC ONLY; no camera access or target execution.\n'+'\n'.join(x.rstrip() for x in s.splitlines())+'\n'
        (OUT/(name+'.txt')).write_text(s)
        rows.append({'name':name,'va':hex(lo),'end_exclusive':hex(hi),
            'file_offset':hex(off),'bytes':len(raw),'sha256':sha(raw),
            'bytes_hex':raw.hex(),'disassembly_file':name+'.txt'})
    ref=[]
    for p in ['tools/firmware/f1_stock_display_payload_14/payload.c',
        'tools/firmware/f1_stock_display_payload_14/payload.h',
        'analysis/firmware/f1_display13_postflash_review_01/manifest.json']:
        x=(ROOT/p).read_bytes();ref.append({'path':p,'bytes':len(x),'sha256':sha(x)})
    out={'schema':'iq4_f1_requested_pair_static_01','original_user_sha256':SHA,
        'target_executed':False,'device_access':False,'ranges':rows,'references':ref,
        'instruction_anchors':[{'va':hex(v),'bytes_le':read(v,4)[1].hex()} for v in anchors],
        'read_contract':{'origin':'actual caller SP+0x168 inline engine+0x4760',
            'requested_width_offset':'0x58','requested_height_offset':'0x5c',
            'requested_pair_span_bytes':8,'minimum_inline_span_end_exclusive':'0x60',
            'borrow_lifetime':'only this original LV paint callback; do not retain pointer',
            'methods_called':False,'source_pixels_read':False,'writes':False},
        'root_reported_geometry_not_independent_device_read':{
            'rgb':[640,480],'config':[14204,10652],'roi':[0,0,14204,10652],
            'rotation':0,'animation':0,'countdown':0,'status':34,
            'cross_product_left':14204*480,'cross_product_right':10652*640,
            'exact_aspect_guard_passes':False}}
    (OUT/'EXACT_BYTES.json').write_text(json.dumps(out,indent=2)+'\n')
    members=[]
    for p in sorted(OUT.iterdir()):
        if p.is_file() and p.name!='manifest.json':
            raw=p.read_bytes();members.append({'path':p.name,'bytes':len(raw),'sha256':sha(raw)})
    (OUT/'manifest.json').write_text(json.dumps({'schema':'iq4_static_evidence_manifest_01',
        'target_execution':False,'device_access':False,'members':members},indent=2)+'\n')
    print(json.dumps({'ranges':len(rows),'anchors':len(anchors),'manifest_sha256':sha((OUT/'manifest.json').read_bytes())}))


if __name__=='__main__':
    main()
