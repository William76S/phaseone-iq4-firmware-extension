#!/usr/bin/env python3
"""Read local ELF bytes only; no memory/target/device interaction."""
from pathlib import Path
import hashlib,json,re,struct
ROOT=Path(__file__).resolve().parents[3]
OUT=ROOT/'analysis/firmware/f4_start_repair_build_05'
USER=ROOT/'analysis/firmware/f1_f3_f4_user_integration_build_03_diag_date_01/P1Linux_RatioMask_JPEG_LVRecording_6.03.32.bin'
STOCK=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
INC=ROOT/'tools/firmware/f3_native_card_bridge_06/signatures.inc'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def reader(p):
 b=p.read_bytes();ph=struct.unpack_from('<Q',b,32)[0];count=struct.unpack_from('<H',b,56)[0];entry=struct.unpack_from('<H',b,54)[0]
 def read(va,n):
  for i in range(count):
   base=ph+i*entry;typ=struct.unpack_from('<I',b,base)[0];off,pva=struct.unpack_from('<QQ',b,base+8);size=struct.unpack_from('<Q',b,base+32)[0]
   if typ==1 and pva<=va and va-pva+n<=size:return b[off+va-pva:off+va-pva+n]
  raise ValueError((va,n))
 return read
s=INC.read_text();arrays={name:bytes(int(x,16)for x in re.findall(r'0x([0-9a-f]+)',body))for name,body in re.findall(r'static const unsigned char (sig_\w+)\[\]=\{([^}]+)\};',s)}
old,new=reader(STOCK),reader(USER);regions=[]
for va,name in re.findall(r'\{(0x[0-9a-f]+),sizeof\((sig_\w+)\),\2\}',s):
 va=int(va,16);expected=arrays[name];a,b=old(va,len(expected)),new(va,len(expected));assert a==b==expected
 regions.append(dict(name=name,va=hex(va),bytes=len(expected),expected_sha256=hashlib.sha256(expected).hexdigest(),actual_matches=True))
assert len(regions)==9
result=dict(schema='iq4_f4_start_repair_card_pins_05',stock=row(STOCK),actual_User=row(USER),signatures=row(INC),regions=regions,all_actual_32_pins_match=True,checked_bytes=sum(x['bytes']for x in regions),device_accessed=False,target_executed=False,does_not_prove_dynamic_FS_or_owner=True)
OUT.mkdir(parents=True,exist_ok=True);(OUT/'ACTUAL_32_CARD_PINS.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(dict(all_actual_32_pins_match=True,regions=len(regions),checked_bytes=result['checked_bytes'],target_executed=False)))
