#!/usr/bin/env python3
"""Bounded exact-User geometry/draw evidence; no target access or calls."""
from pathlib import Path
import hashlib,json,re,struct,subprocess
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2];OUT=ROOT/'analysis/firmware/f1_geometry_probe_03/static'
ELF=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin';SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
OBJDUMP='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
RANGES=[
 ('LV_paint_complete',0x51da0c,0x51df64),('LV_source_point_complete',0x51f50c,0x51f690),
 ('Recursive_bounds_complete',0x4ab9d8,0x4abac8),('Parent_alignment_transform_complete',0x4abac8,0x4abc9c),
 ('Rectangle_add_point_complete',0x4ad02c,0x4ad098),('Parent_field_getter_complete',0x70c4c0,0x70c4d8),
 ('Pan_getter_updates_cache_complete',0x4c4a54,0x4c4ab4),('Pan_animation_bool_complete',0x4c4fa8,0x4c4fc0),
 ('Source_point_divide_complete',0x4ded40,0x4ded9c),('Point_add_complete',0x464578,0x4645cc),
 ('Rectangle_minus_draw_origin_complete',0x4dec34,0x4ded40),
 ('Blit_fit_complete',0x476e6c,0x477038),('Float_min_complete',0x47e450,0x47e488),
 ('Blit_quarterturn_dispatch_complete',0x477038,0x477384),('Blit_zero_clip_and_return_complete',0x47552c,0x475a7c),
 ('Scaler_dispatch_complete',0x47f910,0x47fd60),('Default_multirow_complete',0x47e9d0,0x47ebc8),
 ('RGB24_row_wrapper_complete',0x47e930,0x47e9d0),('RGB24_row_leaf_complete',0x9e9598,0x9e9700),
 ('Surface_constructor_complete',0x46cc8c,0x46cd34),
 ('Control_draw_scope_complete',0x4abd24,0x4ac06c),('Manager_draw_scope_complete',0x4e32d4,0x4e36b8),
 ('Access_size_crop_metadata_complete',0x6b612c,0x6b6250),('Engine_size_crop_metadata_complete',0x6b6d44,0x6b6e08),
 ('Locked_size_crop_ID_complete',0x6b6b70,0x6b6cd0),
 ('LV_fit_scale_start_call_window',0x520488,0x5204dc),('LV_zoom_scale_compare_window',0x51e418,0x51e458),
 ('Producer_copy_slot_ROI_window',0x787838,0x787888)]
TABLES=[('LV_primary_vtable',0xb9a9d8,0x1d8),('Access_vtable',0xc07da8,0x10),('Rectangle_vtable',0xb73b98,0x18),
        ('Surface_vtable',0xb7b780,0x18),('Draw_vtable',0xb7b7d8,0x20)]
def sha(d):return hashlib.sha256(d).hexdigest()
def main():
 raw=ELF.read_bytes()
 if len(raw)!=11874544 or sha(raw)!=SHA:raise SystemExit('Exact User mismatch')
 OUT.mkdir(parents=True,exist_ok=True);rows=[]
 for name,start,end in RANGES:
  data=raw[start-0x400000:end-0x400000]
  s=subprocess.check_output([OBJDUMP,'-d',f'--start-address={start:#x}',f'--stop-address={end:#x}',str(ELF.relative_to(ROOT))],cwd=ROOT,text=True)
  lines=[x.split(' <')[0].split(' //')[0].rstrip()for x in s.splitlines()if re.match(r'  [0-9a-f]+:',x)]
  p=OUT/(name+'.txt');p.write_text('EXACT USER SHA256 '+SHA+'\nSTATIC ONLY; no actual owner/lease/fresh/mapping proof.\n'+'\n'.join(lines)+'\n')
  rows.append(dict(name=name,start_va=hex(start),end_va_exclusive=hex(end),file_offset=hex(start-0x400000),bytes_hex=data.hex(),sha256=sha(data),disassembly=str(p.relative_to(ROOT)),disassembly_sha256=sha(p.read_bytes()),scope='exact_local_call_window'if name.endswith('_window')else'complete_instruction_function_group'if name.startswith(('Access_','Engine_','Locked_'))else'complete_instruction_function'))
 tables=[]
 for name,va,n in TABLES:
  data=raw[va-0x400000:va-0x400000+n]
  tables.append(dict(name=name,va=hex(va),file_offset=hex(va-0x400000),size=n,bytes_hex=data.hex(),sha256=sha(data),qwords=[hex(struct.unpack_from('<Q',data,i)[0])for i in range(0,n,8)]))
 (OUT/'exact_bytes.json').write_text(json.dumps(dict(schema='iq4_f1_geometry03_exact_v1',input_sha256=SHA,input_size=len(raw),address_model='captured AArch64 User linked VA-0x400000',ranges=rows,tables=tables,device_accessed=False,target_executed=False),indent=2)+'\n')
 print(f'{len(rows)} exact windows; {len(tables)} tables')
if __name__=='__main__':main()
