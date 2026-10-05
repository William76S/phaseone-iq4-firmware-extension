#!/usr/bin/env python3
"""Bounded original SD RAW completion evidence; no vendor code is executed."""
import argparse, hashlib, json, struct, subprocess
from pathlib import Path

ROOT=Path(__file__).resolve().parents[3]
USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
OBJ='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
WINDOWS={
 'raw_actual_node_before_fanout':(0x8dc478,0x8dc640),
 'sd_store_constructor':(0x8dfc7c,0x8dfdcc),
 'sd_real_seven_arg_store_call':(0x8e05c4,0x8e066c),
 'sd_native_name_selection':(0x8e0310,0x8e05c4),
 'raw_generic_writer_open':(0x8dd118,0x8dd1c8),
 'raw_generic_writer_finalize_close_return':(0x8dd398,0x8dd524),
 'file_writer_open':(0x7d8928,0x7d8a38),
 'file_writer_checked_close':(0x7d8a38,0x7d8a78),
 'file_writer_actual_file_constructor':(0x7d8e30,0x7d8f58),
 'file_native_bind_ctor_close':(0x825724,0x82586c),
 'filesystem_open_and_file_bind':(0x825ed4,0x826010),
 'filesystem_close_sync':(0x826ca8,0x826d6c),
 'filesystem_fsync':(0x82721c,0x82728c),
 'filesystem_full_path_resolver':(0x827348,0x827800),
 'xqd_full_writer_close_call':(0x8df568,0x8df694),
}
TABLES={'sd_storage_vtable':(0xdbc6b8,0x60),
 'native_file_vtable':(0xd90410,0x60),'native_filesystem_vtable':(0xd91450,0x130)}
STRINGS={'sd_concrete_name':0xdbc630,'sd_format_name':0xdbc688,
 'root_absolute_pattern':0xd91048,'root_relative_pattern':0xd910e0}
def sha(b):return hashlib.sha256(b).hexdigest()
def main():
 p=argparse.ArgumentParser();p.add_argument('--output',type=Path,default=ROOT/'analysis/firmware/f3_saved_raw_capture_static_01');a=p.parse_args()
 data=USER.read_bytes()
 if len(data)!=11874544 or sha(data)!=SHA:raise ValueError('original User identity')
 h=struct.unpack_from('<16sHHIQQQIHHHHHH',data)
 if h[0][:7]!=b'\x7fELF\x02\x01\x01' or h[1]!=2 or h[2]!=183:raise ValueError('ELF64 LE AArch64')
 loads=[struct.unpack_from('<IIQQQQQQ',data,h[5]+i*h[9])for i in range(h[10])]
 def get(v,n):
  matches=[(o+v-a,data[o+v-a:o+v-a+n])for t,f,o,a,pa,fs,ms,al in loads if t==1 and a<=v and v+n<=a+fs]
  if len(matches)!=1:raise ValueError('filebacked VA')
  return matches[0]
 a.output.mkdir(parents=True,exist_ok=True);windows=[];tables=[];strings=[]
 for label,(start,end)in WINDOWS.items():
  off,raw=get(start,end-start);txt=subprocess.check_output([OBJ,'-d',f'--start-address={start}',f'--stop-address={end}',str(USER)],text=True)
  txt='\n'.join(s for s in txt.splitlines()if s.startswith('  '))+'\n';name=label+'.asm';(a.output/name).write_text(txt)
  windows.append(dict(label=label,va=start,end=end,file_offset=off,bytes=len(raw),sha256=sha(raw),hex=raw.hex(),disasm=name,disasm_sha256=sha(txt.encode())))
 for label,(v,n)in TABLES.items():
  off,raw=get(v,n);tables.append(dict(label=label,va=v,file_offset=off,bytes=n,sha256=sha(raw),hex=raw.hex(),slots={hex(i):hex(struct.unpack_from('<Q',raw,i)[0])for i in range(0,n,8)}))
 for label,v in STRINGS.items():
  off,raw=get(v,128);n=raw.find(b'\0')
  if n<0:raise ValueError('bounded string')
  raw=raw[:n+1];strings.append(dict(label=label,va=v,file_offset=off,bytes=len(raw),sha256=sha(raw),hex=raw.hex(),ascii=raw[:-1].decode('ascii')))
 # Do not silently infer runtime table values from addends. These named slots
 # have exact file bytes; assert no dynamic relocation targets their ranges.
 sh=[struct.unpack_from('<IIQQQQIIQQ',data,h[6]+i*h[11])for i in range(h[12])]
 table_relocations=[]
 for s in sh:
  if s[1]!=4:continue
  if s[9]!=24:raise ValueError('RELA entry width')
  for at in range(s[4],s[4]+s[5],24):
   target,info,addend=struct.unpack_from('<QQq',data,at)
   if any(v<=target<v+n for v,n in TABLES.values()):table_relocations.append(dict(target=target,info=info,addend=addend))
 if table_relocations:raise ValueError('named vtable needs dynamic relocation resolution')
 evidence=dict(schema='iq4_f3_saved_raw_capture_static_01',input_sha256=SHA,input_bytes=len(data),windows=windows,tables=tables,strings=strings,named_table_dynamic_relocations=table_relocations,target_executed=False,sdk_loaded=False,device_connected=False)
 (a.output/'EXACT.json').write_text(json.dumps(evidence,indent=2)+'\n')
 members=[dict(path=p.name,bytes=p.stat().st_size,sha256=sha(p.read_bytes()))for p in sorted(a.output.iterdir())if p.is_file()and p.name!='manifest.json']
 (a.output/'manifest.json').write_text(json.dumps(dict(schema='iq4_f3_saved_raw_capture_manifest_01',input_sha256=SHA,members=members,target_executed=False),indent=2)+'\n')
 print(json.dumps(dict(windows=len(windows),tables=len(tables),strings=len(strings),named_table_dynamic_relocations=0,manifest_sha256=sha((a.output/'manifest.json').read_bytes()),target_executed=False)))
if __name__=='__main__':main()
