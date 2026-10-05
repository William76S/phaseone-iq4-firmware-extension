#!/usr/bin/env python3
"""Read-only source/evidence/original alias bytes verification."""
from pathlib import Path
import hashlib,json,struct
ROOT=Path(__file__).resolve().parents[3]
def main():
 s=json.loads((Path(__file__).parent/'SOURCE_SHA256.json').read_text());n=0
 for r in s['members']+s['references']:
  b=(ROOT/r['path']).read_bytes()
  if len(b)!=r['bytes']or hashlib.sha256(b).hexdigest()!=r['sha256']:raise ValueError(r['path'])
  n+=1
 bind=json.loads((Path(__file__).parent/'ORIGINAL_BINDINGS.json').read_text());b=(ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin').read_bytes()
 if hashlib.sha256(b).hexdigest()!=bind['input_sha256']:raise ValueError('wrong original User')
 h=struct.unpack_from('<16sHHIQQQIHHHHHH',b);loads=[]
 for i in range(h[10]):
  t,flags,o,va,pa,fs,ms,al=struct.unpack_from('<IIQQQQQQ',b,h[5]+i*h[9])
  if t==1:loads.append((va,fs,o))
 for a in bind['aliases'].values():
  v=next((x for x in loads if a['va']>=x[0]and a['va']+16<=x[0]+x[1]),None)
  if not v or b[v[2]+a['va']-v[0]:v[2]+a['va']-v[0]+16].hex()!=a['original_bytes']:raise ValueError('PLT bytes')
 print(json.dumps({'hash_rows_verified':n,'original_PLT_windows':2,'target_executed':False,'actual_card_epoch_not_observed':True}))
if __name__=='__main__':main()
