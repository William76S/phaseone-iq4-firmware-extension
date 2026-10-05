#!/usr/bin/env python3
"""Finite, read-only classification evidence for the exact stock User ELF."""
from pathlib import Path
import hashlib, importlib.util, json, struct, subprocess, sys
ROOT=Path(__file__).resolve().parents[3]
OUT=ROOT/'analysis/firmware/f3_capture_kind_01'
s=importlib.util.spec_from_file_location('stock',ROOT/'analysis/firmware/f3_host_no_card_transfer_static_01/collect.py');m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
WINDOWS={
 'native_save_gate':(0x79cd88,0x79cee8),
 'native_save_gate_alternate':(0x79cf94,0x79cfa8),
 'native_black_control_five_gate':(0x79d13c,0x79d154),
 'native_ordinary_enqueue':(0x79d2a0,0x79d3a8),
 'timelapse_first_black':(0x7a19fc,0x7a1fe4),
 'parameterized_black_start':(0x7a2dec,0x7a32b0),
 'production_defaults':(0x5d721c,0x5d7ff0),
 'parameters_copy':(0x829af4,0x829b8c),
 'parameters_black_control':(0x82a408,0x82a494),
 'black_control_settings':(0x6a94ac,0x6a95b8),
 'node_reset':(0x8c32d8,0x8c33e4),
 'reserve_and_recycle':(0x8c5770,0x8c5ce0),
 'capture_compare_only':(0x7979d8,0x797d30),
 'diagnostic_queue_override':(0x6eea1c,0x6ef190),
 'raw_fanout':(0x8dc278,0x8dc734),
 'queue_push_under_mutex':(0x8c709c,0x8c71b0),
 'queue_actual_link':(0x8c7804,0x8c78f0),
 'queue_mutex_guard':(0x411bc0,0x411c18),
 'queue_consumer':(0x8c82c0,0x8c8380),
 'ice_same_node_to_ui':(0x7b8410,0x7b9b00),
 'ui_same_node_to_store':(0x492598,0x492cb0),
 'raw_metadata_lease':(0x4950e8,0x4952d0),
 'node_resource_get_release':(0x8c253c,0x8c28c8),
 'raw_existing_resource_retain':(0x6f07cc,0x6f0988),
 'metadata_existing_resource_retain':(0x8c36c0,0x8c387c),
 'node_link_constructor':(0x8c35c0,0x8c3610),
 'capture_mode_black_registration':(0x422a14,0x422ab4),
}
def main():
 b=m.USER.read_bytes();assert m.sha(b)==m.USER_SHA;g=m.elf_getter(b);OUT.mkdir(exist_ok=True)
 rows=[]
 for name,(a,z) in WINDOWS.items():
  off,raw=g(a,z-a);cmd=[m.OBJDUMP,'-d','--start-address='+hex(a),'--stop-address='+hex(z),str(m.USER)]
  p=OUT/(name+'.asm');p.write_text(subprocess.check_output(cmd,text=True))
  rows.append(dict(name=name,va=a,bytes=z-a,file_offset=off,sha256=m.sha(raw),disassembly=p.relative_to(ROOT).as_posix(),command=cmd))
 sys.path.insert(0,str(ROOT/'tools/firmware'));from inspect_firmware import elf_metadata
 t=next(x for x in elf_metadata(b)['sections']if x['name']=='.text');branches=[];byte_accesses=[]
 for i in range(t['offset'],t['offset']+t['size'],4):
  w=struct.unpack_from('<I',b,i)[0];pc=t['addr']+i-t['offset']
  if w&0x7c000000==0x14000000:
   imm=w&0x3ffffff;imm=imm-(1<<26)if imm&(1<<25)else imm;dest=pc+4*imm
   if dest in (0x8c58e8,0x8c5920,0x8c5958,0x8c32d8):branches.append(dict(pc=pc,target=dest,instruction='BL'if w&0x80000000 else'B'))
  if w&0xffc00000 in(0x39000000,0x39400000)and (w>>10)&4095 in(0x490,0x4a8,0x708):byte_accesses.append(dict(pc=pc,word=w,offset=(w>>10)&4095))
 manifest=dict(schema='iq4_capture_kind_static_01',source_sha256=m.USER_SHA,source_bytes=len(b),level='static_analysis',ranges=rows,direct_queue_and_reset_branches=branches,byte_offset_candidates=byte_accesses,warning='Direct branch/offset scans are not whole-program pointer/control-flow proof. No device execution.')
 (OUT/'COLLECTION.json').write_text(json.dumps(manifest,indent=2)+'\n');print(len(rows),'verified disassembly regions')
if __name__=='__main__':main()
