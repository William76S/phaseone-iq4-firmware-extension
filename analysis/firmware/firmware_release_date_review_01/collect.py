#!/usr/bin/env python3
"""Read only the fixed original ELF; emit/check bounded release-Date byte evidence."""
from pathlib import Path
import argparse, hashlib, json, struct, subprocess
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[2]
INPUT=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
OBJDUMP='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
CODE=[
 ('Main_FirmwareManager_construction',0x41c5d0,0x41c658),
 ('FirmwareInfoUI_Date_row',0x504620,0x504650),
 ('FirmwareManager_ctor_arguments',0x751b2c,0x751b70),
 ('FirmwareManager_active_manifest_selection',0x751cb4,0x751d1c),
 ('FirmwareManager_load_User_Factory_manifest',0x751e24,0x751efc),
 ('FirmwareManager_format_active_release_date',0x751fd4,0x752030),
 ('FirmwareManager_Date_getter',0x752368,0x752388),
 ('FirmwareManager_load_installed_XML',0x753464,0x75365c),
 ('ManifestParser_installed_release_XML',0x764b6c,0x764d1c),
 ('ManifestParser_installed_release_record',0x765368,0x765604),
 ('ManifestParser_ISO_date_parser',0x7661bc,0x7663a8),
 ('ManifestParser_outer_package_date',0x765c5c,0x765e58),
]
STRINGS=[('Date_label',0xb96090),('Date_format',0xc37830),
 ('Release_node_selector',0xc3dd40),('release_date_attribute',0xc3de90),
 ('Outer_date_attribute',0xc3df28),('Installed_manifest_basename',0xc35650)]
def digest(b):return hashlib.sha256(b).hexdigest()
def produce():
 b=INPUT.read_bytes()
 assert len(b)==11874544 and digest(b)==SHA
 assert b[:6]==b'\x7fELF\x02\x01' and struct.unpack_from('<H',b,18)[0]==183
 phoff=struct.unpack_from('<Q',b,32)[0];esz,n=struct.unpack_from('<HH',b,54)
 assert esz==56 and phoff+n*esz<=len(b)
 ph=[struct.unpack_from('<IIQQQQQQ',b,phoff+i*esz) for i in range(n)]
 def get(va,length):
  candidates=[o+va-v for t,f,o,v,pa,fs,ms,al in ph if t==1 and v<=va and va+length<=v+fs]
  assert len(candidates)==1
  off=candidates[0];body=b[off:off+length];assert len(body)==length
  return off,body
 rows=[]
 for name,start,end in CODE:
  off,body=get(start,end-start)
  rows.append(dict(name=name,va=hex(start),end_va_exclusive=hex(end),file_offset=hex(off),
                   bytes=len(body),sha256=digest(body),hex=body.hex()))
 strings=[]
 for name,va in STRINGS:
  off,probe=get(va,96);body=probe[:probe.index(0)+1]
  strings.append(dict(name=name,va=hex(va),file_offset=hex(off),bytes=len(body),
   sha256=digest(body),hex=body.hex(),ascii=body[:-1].decode('ascii')))
 records=[]
 for name,va in [('User_manifest_FileId4',0xf55fe0),('Factory_manifest_FileId14',0xf56238)]:
  off,body=get(va,40)
  records.append(dict(name=name,va=hex(va),file_offset=hex(off),bytes=40,sha256=digest(body),hex=body.hex(),
    file_id=struct.unpack_from('<I',body)[0],basename_va=hex(struct.unpack_from('<Q',body,8)[0]),
    flags=struct.unpack_from('<I',body,16)[0],folder_id=struct.unpack_from('<I',body,24)[0]))
 result=dict(schema='iq4_firmware_release_date_exact_static_01',input=dict(path=str(INPUT.relative_to(ROOT)),bytes=len(b),sha256=SHA),
  code=rows,strings=strings,file_records=records,execution_scope='host_file_and_disassembly_only',target_executed=False)
 return (json.dumps(result,indent=2)+'\n').encode()
def main():
 a=argparse.ArgumentParser();a.add_argument('--emit',action='store_true');x=a.parse_args();out=produce()
 if x.emit:
  (HERE/'EXACT.json').write_bytes(out)
  receipts=[]
  for name,start,end in CODE:
   cmd=[OBJDUMP,'-d','--start-address='+hex(start),'--stop-address='+hex(end),str(INPUT)]
   r=subprocess.run(cmd,check=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
   assert not r.stderr
   dest=HERE/(name+'.asm');dest.write_bytes(r.stdout)
   receipts.append(dict(name=name,argv=cmd,exit_code=r.returncode,path=str(dest.relative_to(ROOT)),bytes=len(r.stdout),sha256=digest(r.stdout)))
  (HERE/'DISASSEMBLY_COMMANDS.json').write_text(json.dumps(dict(schema='iq4_release_date_disassembly_commands_01',commands=receipts,target_executed=False),indent=2)+'\n')
 else:
  assert (HERE/'EXACT.json').read_bytes()==out
 print(json.dumps(dict(exact_bytes_deterministic=True,code_windows=len(CODE),strings=len(STRINGS),records=2,target_executed=False)))
if __name__=='__main__':main()
