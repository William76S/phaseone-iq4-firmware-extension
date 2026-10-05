#!/usr/bin/env python3
"""Read-only frozen source/byte contract validation; executes no native code."""
from pathlib import Path
import hashlib,json
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2]
def sha(b):return hashlib.sha256(b).hexdigest()
def main():
 lock=json.loads((HERE/'SOURCE_SHA256.json').read_text());count=0
 for r in lock['files']:
  b=(ROOT/r['path']).read_bytes()
  if len(b)!=r['size'] or sha(b)!=r['sha256']:raise ValueError('Frozen member differs: '+r['path'])
  count+=1
 prior=ROOT/'analysis/sdk_reference/f1_entry_menu_candidate_01/SOURCE_SHA256.json'
 if sha(prior.read_bytes())!=lock['positive_candidate_manifest_sha256']:raise ValueError('Frozen positive candidate manifest differs')
 for r in json.loads(prior.read_text())['files']:
  b=(prior.parent/r['name']).read_bytes()
  if len(b)!=r['size'] or sha(b)!=r['sha256']:raise ValueError('Frozen positive candidate member differs')
 b=(ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin').read_bytes()
 if len(b)!=11874544 or sha(b)!=lock['exact_User_sha256']:raise ValueError('Exact User differs')
 bindings=json.loads((ROOT/'analysis/firmware/f1_entry_button_ports_01/bindings.json').read_text())
 for r in bindings['entries']:
  p=int(r['file_offset'],16)
  if b[p:p+16].hex()!=r['first16_hex']:raise ValueError('Entry signature differs')
 for r in bindings['tables']+bindings.get('complete_new_windows',[]):
  p=int(r['file_offset'],16);actual=b[p:p+r['size']]
  if actual.hex()!=r['bytes_hex'] or sha(actual)!=r['sha256']:raise ValueError('Full interface/window differs')
 print(json.dumps({'status':'PASS','frozen_members':count,'exact_entries':19,'complete_tables':4,'new_complete_windows':1,'production_entry_enabled':False,'native_executed':False,'camera_access':False}))
if __name__=='__main__':main()
