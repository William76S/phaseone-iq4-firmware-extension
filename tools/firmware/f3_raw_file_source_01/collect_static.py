#!/usr/bin/env python3
"""Finite original-word collection. Does not execute the original binary."""
import argparse
import hashlib
import importlib.util
import json
import re
import struct
import subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
DEPENDENCY=ROOT/'tools/firmware/f3_render_plan_01/collect_static.py'
WINDOWS={
 'Reader_construct_and_nondelete_destroy':(0x7d92b8,0x7d94a0),
 'Reader_size_alloc_caller':(0x424948,0x424978),
 'Reader_open_state_and_fs':(0x7d95c0,0x7d9630),
 'Reader_raw_payload_and_codec':(0x7d9630,0x7d9790),
 'Reader_path_open_and_close':(0x7d9988,0x7d9b10),
 'Capture_parser_entry_and_header':(0x7c712c,0x7c7a98),
 'Capture_row_table_complete':(0x7c7a98,0x7c8198),
 'Capture_metadata_complete':(0x7c9000,0x7ca6a8),
 'Reader_profile_forward':(0x7d9278,0x7d92b8),
 'Capture_profile_complete':(0x7ca6a8,0x7ca73c),
 'Worker_profile_before_RAW':(0x7b74ec,0x7b76b8),
 'Capture_RAW_section_seek':(0x7cc180,0x7cc2c0),
 'Capture_calibration_tag_read':(0x7cd2d0,0x7cd3c8),
 'Directory_read_complete':(0x7da788,0x7dabc4),
 'Directory_offset_length_and_blob':(0x7dadb0,0x7db29c),
 'Directory_base_getter':(0x7d8464,0x7d847c),
 'BuildTagsFile_complete':(0x7ba364,0x7baadc),
 'Tag_value_ownership_complete':(0x7bb8e0,0x7bb980),
 'Owned_map_raw_input_complete':(0x7bb9ec,0x7bbb24),
 'Owned_map_destructor_tree':(0x7bc334,0x7bc3bc),
 'Owned_map_destructor_leaf':(0x7bd21c,0x7bd294),
 'Native_vector_push':(0x7bc7e4,0x7bc864),
 'Native_codec_map':(0x7b6314,0x7b6424),
 'ICE_tagmap_ctor_and_unwind':(0x7b54f8,0x7b5670),
 'Worker_file_raw_input_build':(0x7b76b8,0x7b77bc),
 'Native_File_ctor_bind_and_destruct':(0x825724,0x82586c),
 'Native_File_read':(0x82586c,0x8258b8),
 'Native_File_fd_getter':(0x46b15c,0x46b174),
 'Native_LinuxFS_open':(0x825ed4,0x826010),
 'Native_LinuxFS_close_and_read':(0x826ca8,0x826e04),
 'Raw_decoder_real_row_job':(0x922640,0x9227b0),
}
CALLS={0x424974:0x7d92b8,0x7d9300:0x7c6f3c,0x7d9308:0x825770,
 0x7d967c:0x7cc180,0x7d9a40:0x7c712c,0x7d9ad0:0x82580c,
 0x7c98c4:0x7daee8,0x7c8088:0x7daf50,0x7b5504:0x7bba0c,
 0x7b566c:0x7bba2c,0x7b7718:0x7ba364,0x7b77a8:0x7bc7e4,
 0x825fcc:0x40a4d0,0x826d10:0x40aa90,0x826dc4:0x40a560}

def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,default=ROOT/'analysis/firmware/f3_raw_file_source_01/static');a=ap.parse_args()
 spec=importlib.util.spec_from_file_location('frozen_exact_image',DEPENDENCY);m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
 image=m.ExactImage(m.ORIGINAL)
 total=sum(end-start for start,end in WINDOWS.values())
 if total>65536:raise ValueError('fixed collection exceeded64KiB')
 a.output.mkdir(parents=True,exist_ok=True);rows=[];runs=[]
 for label,(start,end) in WINDOWS.items():
  off,raw=image.get(start,end-start)
  argv=[m.OBJDUMP,'-d',f'--start-address={start}',f'--stop-address={end}',str(m.ORIGINAL)]
  p=subprocess.run(argv,capture_output=True,text=True,check=True)
  text='\n'.join(re.sub(r'\s+<[^>]*>','',line) for line in p.stdout.splitlines() if line.startswith('  '))+'\n'
  count=0
  for line in text.splitlines():
   match=re.match(r'\s*([0-9a-f]+):\s+([0-9a-f]{8})\s',line)
   if match:
    va,word=(int(x,16) for x in match.groups())
    if not start<=va<end or struct.unpack('<I',image.get(va,4)[1])[0]!=word:raise ValueError('raw word mismatch')
    count+=1
  if count!=(end-start)//4:raise ValueError('incomplete window')
  path=a.output/(label+'.asm');path.write_text(text)
  rows.append({'label':label,'start_va':start,'end_va':end,'file_offset':off,'bytes':len(raw),'instructions':count,'raw_sha256':m.sha(raw),'raw_hex':raw.hex(),'disasm':path.name,'disasm_sha256':m.sha(path.read_bytes())})
  runs.append({'argv':argv,'exit':p.returncode,'stderr':p.stderr})
 calls=[]
 for va,target in CALLS.items():
  raw=image.get(va,4)[1]
  if m.bl_target(va,struct.unpack('<I',raw)[0])!=target:raise ValueError('wrong original direct call')
  calls.append({'call_va':va,'target_va':target,'raw':raw.hex()})
 table={}
 for name,va,n in [('capture_codec_table',0xd86718,28),('file_vtable',0xd90410,96),('linux_fs_vtable',0xd91450,0x100)]:
  off,raw=image.get(va,n);table[name]={'va':va,'file_offset':off,'bytes':n,'raw_hex':raw.hex(),'sha256':m.sha(raw)}
 if struct.unpack('<7I',image.get(0xd86718,28)[1])!=(1,0,2,3,4,5,6):raise ValueError('codec table changed')
 result={'schema':'iq4_f3_raw_file_source_static_01','original_sha256':m.SHA,'original_bytes':m.SIZE,
 'target_executed':False,'device_accessed':False,'exact_reader_dependency_sha256':m.sha(DEPENDENCY.read_bytes()),
 'finite_window_bytes':total,'windows':rows,'direct_calls':calls,'tables':table}
 (a.output/'EXACT.json').write_text(json.dumps(result,indent=2)+'\n');(a.output/'RUN.json').write_text(json.dumps(runs,indent=2)+'\n')
 print(json.dumps({'windows':len(rows),'instructions':sum(r['instructions'] for r in rows),'bytes':total,'direct_calls':len(calls),'exact_sha256':m.sha((a.output/'EXACT.json').read_bytes()),'native_executed':False}))
if __name__=='__main__':main()
