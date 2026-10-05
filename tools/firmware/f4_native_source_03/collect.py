#!/usr/bin/env python3
"""Finite nativeRGB byte transfer/mapping evidence; never target execution."""
import bisect,hashlib,json,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];OWN=Path(__file__).resolve().parent
RAW=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
def main():
 raw=RAW.read_bytes();assert len(raw)==11874544 and hashlib.sha256(raw).hexdigest()==SHA
 out=ROOT/'analysis/firmware/f4_native_source_03/static';out.mkdir(parents=True,exist_ok=False)
 starts=json.loads((ROOT/'analysis/firmware/unwind_functions.json').read_text())['functions'];rows=[]
 funcs=[('native_lv_start',0x5202a0),('access_color_mode',0x6b6528),('video_init',0x793540),('native_color_matrix_mode',0x798508),('pending_configuration_and_matrix_dispatch',0x796658),('hardware_matrix_write',0x783360),('producer_configure',0x7962f8),('producer_hardware_buffer_configure',0x787210),('frame_producer',0x787578),('rgb24_display_dispatch',0x47f910),('rgb24_argb32_row_wrapper',0x47e930),('jpeg_rgb24',0x98d8a8),('jpeg_scanlines',0x98d680)]
 for name,va in funcs:
  i=bisect.bisect_left(starts,va);assert starts[i]==va;end=starts[i+1]
  b=raw[va-0x400000:end-0x400000]
  dis=subprocess.check_output(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d',f'--start-address={va:#x}',f'--stop-address={end:#x}',str(RAW)],text=True)
  (out/(name+'.txt')).write_text('\n'.join(x.rstrip()for x in dis.splitlines())+'\n')
  rows.append(dict(name=name,va=hex(va),end=hex(end),file_offset=hex(va-0x400000),sha256=hashlib.sha256(b).hexdigest(),hex=b.hex()))
 for name,va,end in [('rgb24_argb32_row_leaf',0x9e9598,0x9e9700),('canonical_component_map_literal',0xd732f8,0xd73300)]:
  b=raw[va-0x400000:end-0x400000];rows.append(dict(name=name,va=hex(va),end=hex(end),file_offset=hex(va-0x400000),sha256=hashlib.sha256(b).hexdigest(),hex=b.hex()))
  if name.endswith('leaf'):
   dis=subprocess.check_output(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d',f'--start-address={va:#x}',f'--stop-address={end:#x}',str(RAW)],text=True)
   (out/(name+'.txt')).write_text('\n'.join(x.rstrip()for x in dis.splitlines())+'\n')
 # Original02 pins unchanged in prefix; additional finite static semantics pins.
 h=(ROOT/'tools/firmware/f4_native_source_02/code_pins.h').read_text();needle='static const Iq4F4Pin02 iq4_f4_pins_02[]={';assert h.count(needle)==1
 extra=[('canonical_init',0x79386c,0x7938b8),('canonical_map23',0xd732f8,0xd73300),('rgb_byte_transfer',0x9e9598,0x9e9700),('stock_jpeg_rgb_fields',0x98d780,0x98d798)]
 defs=[];ents=[]
 for i,(name,va,end)in enumerate(extra):
  b=raw[va-0x400000:end-0x400000];defs.append('static const unsigned char source03_pin_%d[]={%s};'%(i,','.join('0x%02x'%x for x in b)));ents.append('{0x%x,%d,source03_pin_%d},/* source03 %s */'%(va,len(b),i,name))
 h=h.replace(needle,'\n'.join(defs)+'\n'+needle+'\n'+'\n'.join(ents));(OWN/'code_pins.h').write_text(h)
 (out/'EXACT.json').write_text(json.dumps(dict(schema='iq4_f4_rgb_admission_static_03',original_sha256=SHA,windows=rows,additional_production_pins=extra,target_executed=False,camera_access=False),indent=2)+'\n')
 print('15 exact evidence windows; old30 + new4 production pins')
if __name__=='__main__':main()
