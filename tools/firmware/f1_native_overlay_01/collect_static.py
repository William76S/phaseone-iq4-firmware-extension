#!/usr/bin/env python3
"""Finite hash-bound F1 post-paint, cleanup and coordinate evidence; offline."""
from pathlib import Path
import hashlib
import json
import re
import struct
import subprocess
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2]
OUT=ROOT/'analysis/firmware/f1_native_overlay_01/static'
ELF=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
EXPECTED='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
OBJDUMP='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
RANGES=[('complete_original_LV_paint',0x51da0c,0x51df64),
 ('LV_enter_exit',0x51d884,0x51da0c),('source_point_to_display',0x51f50c,0x51f690),
 ('LV_source_metadata_accessors',0x6b614c,0x6b62e0),
 ('source_metadata_backend_accessors',0x6b6d44,0x6b6e08),
 ('control_draw_parent_before_children',0x4abd24,0x4ac06c),
 ('dialog_draw',0x4e1360,0x4e14bc),
 ('control_invalidate',0x4ac06c,0x4ac0f4),
 ('LV_dialog_invalidate_close_condition',0x4e1270,0x4e12c8),
 ('surface_dirty_rectangle_union_not_clear',0x46ce24,0x46cea4),
 ('native_fill_wrapper',0x46f370,0x46f430),('native_fill_rectangle',0x46f430,0x46f5e4),
 ('Rectangle_constructor_copy_dtor',0x457ca4,0x457dc4),
 ('Surface_ctor',0x46cc8c,0x46cd4c),
 ('display_pitch_and_scanline',0x46d524,0x46d754)]
TABLES=[('LV_primary_with_ABI_RTTI_header',0xb9a9c8,0x1e8),
 ('LV_next_secondary_vtable_boundary',0xb9abb0,0x10),
 ('Rectangle_primary',0xb73b98,0x30),('Surface_primary',0xb7b780,0x58),('Draw_fill_and_blend',0xb7b7d8,0x20)]
def sha(data):return hashlib.sha256(data).hexdigest()
def main():
 raw=ELF.read_bytes()
 if sha(raw)!=EXPECTED:raise SystemExit('Exact User mismatch')
 OUT.mkdir(parents=True,exist_ok=True);ranges=[];tables=[]
 for name,start,end in RANGES:
  data=raw[start-0x400000:end-0x400000]
  text=subprocess.check_output([OBJDUMP,'-d',f'--start-address={start:#x}',f'--stop-address={end:#x}',str(ELF.relative_to(ROOT))],cwd=ROOT,text=True)
  lines=[line.split(' <')[0].split(' //')[0].rstrip() for line in text.splitlines() if re.match(r'  [0-9a-f]+:',line)]
  path=OUT/(name+'.disasm.txt');path.write_text('EXACT USER SHA256 '+EXPECTED+'\nSTATIC ONLY; no callable target binding.\n'+'\n'.join(lines)+'\n')
  ranges.append(dict(name=name,start_va=hex(start),end_va_exclusive=hex(end),file_offset=hex(start-0x400000),bytes_hex=data.hex(),bytes_sha256=sha(data),disassembly=str(path.relative_to(ROOT)),disassembly_sha256=sha(path.read_bytes())))
 for name,va,size in TABLES:
  data=raw[va-0x400000:va-0x400000+size]
  tables.append(dict(name=name,va=hex(va),file_offset=hex(va-0x400000),size=size,bytes_hex=data.hex(),sha256=sha(data),qwords=[hex(struct.unpack_from('<Q',data,i)[0]) for i in range(0,size//8*8,8)]))
 (OUT/'exact_bytes.json').write_text(json.dumps(dict(schema='iq4_f1_native_overlay01_exact_v1',input_sha256=EXPECTED,address_model='AArch64 ET_EXEC VA-0x400000 file mapping for captured code/rodata',evidence_level='static_bytes_and_instructions',device_accessed=False,target_executed=False,ranges=ranges,tables=tables),indent=2)+'\n')
 print(f'{len(ranges)} windows and {len(tables)} byte tables captured')
if __name__=='__main__':main()
