#!/usr/bin/env python3
import json,struct
from hook_plan import branch,destination,plan,FIRST,ENTRY
def main():
 checks=0
 for delta in (-(1<<27),-4,0,4,(1<<27)-4):
  source=0x10000000;word=branch(source,source+delta);assert destination(source,word)==source+delta;checks+=1
 for source,target in ((4,2),(0,1<<27),((1<<27)+4,0),(-4,0),(True,4)):
  try:branch(source,target)
  except ValueError:checks+=1
  else:assert False
 a=plan(0x500000,0x500100,0x7ffff0000000);p=bytes.fromhex(a['original_trampoline_hex']);assert struct.unpack('<I',p[:4])[0]==FIRST and destination(0x500104,struct.unpack('<I',p[4:])[0])==ENTRY+4;assert destination(ENTRY,struct.unpack('<I',bytes.fromhex(a['patch_hex']))[0])==0x500000;checks+=1
 assert bytes.fromhex(a['near_veneer_hex'])==struct.pack('<IIQ',0x58000050,0xd61f0200,0x7ffff0000000);checks+=1
 for args in ((0x500000,0x500008,0x800000),(0x500000,0x500100,0x800000,FIRST+4)):
  try:plan(*args)
  except ValueError:checks+=1
  else:assert False
 assert not a['ready_to_install']and not a['target_loaded']and not a['target_text_written'];checks+=1
 print(json.dumps({'checks':checks,'passed':True,'synthetic_addresses_only':True,'target_executed':False}))
if __name__=='__main__':main()
