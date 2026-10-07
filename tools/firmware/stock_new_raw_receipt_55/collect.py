#!/usr/bin/env python3
from pathlib import Path
import json,struct,hashlib,subprocess
R=Path(__file__).resolve().parents[3];D=Path(__file__).resolve().parent;O=R/'analysis/firmware/stock_new_raw_receipt_55';O.mkdir(exist_ok=True)
U=R/'analysis/firmware/extracted/P1Linux_6.03.21.bin';b=U.read_bytes();SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb';assert hashlib.sha256(b).hexdigest()==SHA
ph=struct.unpack_from('<Q',b,32)[0];esz,n=struct.unpack_from('<HH',b,54);loads=[]
for i in range(n):
 t,fl,o,v,pa,fs,ms,al=struct.unpack_from('<IIQQQQQQ',b,ph+i*esz)
 if t==1:loads.append((v,o,fs))
def data(v,n):
 for va,o,z in loads:
  if va<=v and v+n<=va+z:return b[o+v-va:o+v-va+n],o+v-va
 raise ValueError(hex(v))
H=[(0x79d300,0x8c58e8,'iq4_new_raw_enqueue_thunk_55','BL'),(0x8c5844,0x8c32d8,'iq4_new_raw_node_event_55','BL'),(0x8c5c54,0x8c32d8,'iq4_new_raw_node_event_55','BL'),(0x8df038,0x8df19c,'iq4_new_raw_xqd_store_55','BL'),(0x8e0618,0x8dcf98,'iq4_new_raw_sd_store_55','BLR'),(0x825fcc,0x40a4d0,'iq4_new_raw_open_55','BL'),(0x8dd440,0x7d8a38,'iq4_new_raw_sd_close_55','BL'),(0x8df8e8,0x8257b4,'iq4_new_raw_xqd_dtor_55','BL'),(0x8df8f0,0x8257b4,'iq4_new_raw_xqd_dtor_55','BL'),(0x8dc634,0x8c5cdc,'iq4_new_raw_refs_55','BL'),(0x49686c,0x4989c0,'iq4_new_raw_backup_enqueue_55','BL')]
EXCLUDED=[0x496f28]
W=[('backup_enqueue_route',0x496784,0x4968ec),('backup_pending',0x49752c,0x4975c8),('backup_wrappers',0x498994,0x4989ec),('backup_lifetime',0x8e2f50,0x8e3184),('backup_close_retire',0x8e3598,0x8e36dc),('ordinary_native',0x79cd98,0x79d304),('reserve',0x8c57f0,0x8c5850),('dispose',0x8c5c1c,0x8c5c68),('xqd_outer',0x8df008,0x8df064),('xqd_full',0x8df19c,0x8df9ac),('sd_dispatch',0x8e05c4,0x8e0648),('sd_full',0x8dcf98,0x8dd524),('native_open',0x825ed4,0x82600c),('file_close',0x825770,0x82586c),('writer_close',0x7d8a38,0x7d8a70),('fanout_refs',0x8dc4cc,0x8dc63c),('UI_catalog_identity',0x492598,0x4926f8),('catalog_clear',0x496e90,0x496f64),('fs_vtable',0xd91450,0xd91580),('sd_storage_vtable',0xdbc6b8,0xdbc718),('xqd_storage_vtable',0xdbc280,0xdbc2e0)]
rows=[];h=[]
for va,target,symbol,kind in H:
 x,o=data(va,4);w=int.from_bytes(x,'little')
 if kind=='BL':
  assert w>>26==37;im=w&0x3ffffff
  if im&(1<<25):im-=1<<26
  assert va+im*4==target
 else:assert w==0xd63f00e0
 h.append(dict(va=va,old_hex=x.hex(),original_target=target,target_symbol=symbol,branch_kind='BL',original_kind=kind))
for label,a,z in W:
 x,o=data(a,z-a);rows.append(dict(label=label,va=a,file_offset=o,bytes=len(x),sha256=hashlib.sha256(x).hexdigest(),hex=x.hex()))
 if 'vtable' not in label:
  subprocess.run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','--no-show-raw-insn','--disassemble',f'--start-address={a}',f'--stop-address={z}',str(U)],stdout=(O/(label+'.asm')).open('w'),check=True)
p=[]
for row in rows:
 a=row['va'];z=a+row['bytes'];cuts=[a]+[v for v in [q[0] for q in H]+EXCLUDED if a<=v<z]+[z];cuts.sort()
 start=a
 for end in cuts[1:]:
  while start<end:
   size=min(256,end-start);x,_=data(start,size);p.append((start,x));start+=size
  if end!=z:start=end+4
header='#pragma once\n#include <stddef.h>\n#include <stdint.h>\nstruct NewRawPin55 {uintptr_t va;size_t bytes;const unsigned char*data;};\n'
for i,(a,x) in enumerate(p):header+=f'static const unsigned char NewRawBytes55_{i}[]={{'+','.join(f'0x{k:02x}' for k in x)+'};\n'
header+='static const NewRawPin55 NewRawPins55[]={\n'+''.join(f'{{0x{a:x},sizeof(NewRawBytes55_{i}),NewRawBytes55_{i}}},\n' for i,(a,x) in enumerate(p))+'};\n'
(D/'pins.h').write_text(header)
aliases={'iq4_new_raw_syscall_55':0x40ae40,'iq4_new_raw_errno_55':0x40a4e0,'iq4_new_raw_original_open_55':0x40a4d0,'iq4_new_raw_original_enqueue_55':0x8c58e8,'iq4_new_raw_original_node_event_55':0x8c32d8,'iq4_new_raw_original_xqd_store_55':0x8df19c,'iq4_new_raw_original_sd_store_55':0x8dcf98,'iq4_new_raw_original_writer_close_55':0x7d8a38,'iq4_new_raw_original_file_close_55':0x82580c,'iq4_new_raw_original_file_dtor_55':0x8257b4,'iq4_new_raw_original_refs_55':0x8c5cdc,'iq4_new_raw_original_backup_enqueue_55':0x4989c0}
(O/'EXACT.json').write_text(json.dumps(dict(stock_sha256=SHA,windows=rows,hooks=h,aliases=aliases,pin_rows=len(p),pin_bytes=sum(len(x)for a,x in p),excluded_hook_bytes=4*len(H),externally_consumed_patch_sites=EXCLUDED),indent=2)+'\n')
print('PASS exact11 hooks, helperwindows; pins',len(p),sum(len(x)for a,x in p))
