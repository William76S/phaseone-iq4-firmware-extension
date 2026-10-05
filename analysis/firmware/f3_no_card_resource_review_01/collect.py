#!/usr/bin/env python3
"""Finite offline RAM-source/arena ABI evidence. No native call or device IO."""
import hashlib,json,re,struct,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];OUT=Path(__file__).resolve().parent
USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
BOOT=ROOT/'analysis/firmware/extracted/Boot_4.00.13.bin'
SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
BSHA='7a3a3d6f62c61e7d627a9f55d844d74be9111b26eb7a7fa42f5bdd7be7dabe9e'
raw=USER.read_bytes();boot=BOOT.read_bytes()
assert len(raw)==11874544 and hashlib.sha256(raw).hexdigest()==SHA
assert len(boot)==71874288 and hashlib.sha256(boot).hexdigest()==BSHA
windows=[('Original_RAM_worker_input',0x7b77f8,0x7b7a18),('Original_RAM_BuildTags',0x7baadc,0x7bb224),
 ('Generator_external_base_capacity',0x962058,0x9622a8),('Whole_decoded_capacity_subtract',0x963d28,0x963d88),
 ('Core_output_capacity',0x919e10,0x919f50),('Core_two_RGB16_capacity',0x91ae48,0x91af24),
 ('Raw_input_constructor',0x7bbac0,0x7bbafc),('Raw_format_mapping',0x7b6314,0x7b6424),
 ('Pool_payload_getters',0x495094,0x4950c4),('CIB_attach_bytes',0x903f70,0x904010)]
rows=[]
for name,start,end in windows:
 b=raw[start-0x400000:end-0x400000]
 dis=subprocess.check_output(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d',f'--start-address={start:#x}',f'--stop-address={end:#x}',str(USER)],text=True)
 lines=[x.split(' <')[0].split(' //')[0].rstrip() for x in dis.splitlines() if re.match(r'  [0-9a-f]+:',x)]
 for x in lines:
  m=re.match(r'  ([0-9a-f]+): ([0-9a-f]{8})',x);assert m
  assert struct.unpack_from('<I',raw,int(m[1],16)-0x400000)[0]==int(m[2],16)
 p=OUT/(name+'.asm');p.write_text('Original User SHA256 '+SHA+'\nSTATIC ONLY\n'+'\n'.join(lines)+'\n')
 rows.append(dict(name=name,va=hex(start),end=hex(end),bytes_hex=b.hex(),bytes_sha256=hashlib.sha256(b).hexdigest(),disassembly=str(p.relative_to(ROOT)),disassembly_sha256=hashlib.sha256(p.read_bytes()).hexdigest()))
trees=[]
dtjson=ROOT/'analysis/firmware/device_trees.json'
for d in json.loads(dtjson.read_text()):
 block=boot[d['boot_file_offset']:d['boot_file_offset']+d['size']]
 assert hashlib.sha256(block).hexdigest()==d['sha256']
 props=[]
 for prop in d['properties']:
  if prop['name']=='reg' and (prop['path']=='/memory' or prop['path'].startswith('/reserved-memory/')):
   b=bytes.fromhex(prop['hex']);assert block[prop['offset_in_dtb']:prop['offset_in_dtb']+len(b)]==b
   assert len(b)%16==0
   regions=[dict(base=hex(a),bytes=n) for a,n in struct.iter_unpack('>QQ',b)]
   props.append(dict(path=prop['path'],property='reg',boot_file_offset=d['boot_file_offset']+prop['offset_in_dtb'],bytes_hex=b.hex(),regions=regions))
 trees.append(dict(boot_file_offset=d['boot_file_offset'],dtb_sha256=d['sha256'],properties=props,declared_memory_bytes=sum(x['bytes'] for p in props if p['path']=='/memory' for x in p['regions'])))
def frame(w,h,bpp):return ((w*bpp+31)&~31)*h
geometry=dict(total_width=14308,total_height=10760,valid_width=14204,valid_height=10652,left=102,top=106)
budget=dict(generator_prefix_bytes=80*1024*1024,decoded_bytes=frame(14308,10760,2),rgb32_bytes=frame(14204,10652,4),planar_bytes=frame(14204,10652,1),rgb16_pair_bytes=2*frame(14204,10652,6),sample_encoded_bytes=159899952,padding_bytes=64384,row_offsets_bytes=4*10760)
budget['arena_lower_bound_bytes']=sum(budget[k] for k in ('generator_prefix_bytes','decoded_bytes','rgb32_bytes','planar_bytes','rgb16_pair_bytes'))
budget['arena_plus_encoded_padding_rows_lower_bound_bytes']=budget['arena_lower_bound_bytes']+sum(budget[k] for k in ('sample_encoded_bytes','padding_bytes','row_offsets_bytes'))
budget['sufficient_working_set_or_camera_available_budget']=False
(OUT/'EXACT.json').write_text(json.dumps(dict(schema='iq4_f3_no_card_RAM_static_resource_review_01',input_sha256=SHA,boot_sha256=BSHA,camera_access=False,native_functions_executed=False,windows=rows,device_trees=trees,sample_geometry=geometry,budget=budget),indent=2)+'\n')
print(json.dumps(dict(windows=len(rows),trees=len(trees),budget=budget,exact_sha256=hashlib.sha256((OUT/'EXACT.json').read_bytes()).hexdigest())))
