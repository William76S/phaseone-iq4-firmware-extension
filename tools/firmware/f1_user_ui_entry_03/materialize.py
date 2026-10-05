#!/usr/bin/env python3
"""Finite UI03 lineage and original-code check; read-only, never materialize."""
from pathlib import Path
import hashlib,json,re
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OLD_SOURCE_SHA='19d1eaf86e36a4bc9a35eee6c70b25222b7a9900aa823b0e8618f281009767a0'
STOCK_SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
EXCLUDED=((0x9ef0bc,0x9ef0c4),(0x9ef0c8,0x9ef0d0))
WORDS=((0x9ef0bc,'942a00f0'),(0x9ef0c0,'94022191'),(0x9ef0c8,'952a00d0'),(0x9ef0cc,'b5823691'))
UNCHANGED=('runtime.cpp','native_helpers.inc','module.hpp','module.cpp','entry_binding_10.hpp','entry_binding_10.cpp','inspector.cpp','display_grid.hpp','ctor_wrapper.S','compare.c','state.h','test_grid.cpp','test_grid.py')
def sha(b):return hashlib.sha256(b).hexdigest()
def code_windows(stock):
 # VA=file+0x400000 in the original RX LOAD. All other UI02 exclusions stay.
 omitted=((0,0x270),(0x4eef2c-0x400000,0x4eef30-0x400000),(0x51ddcc-0x400000,0x51ddd0-0x400000),(0x6be8a8-0x400000,0x6be8ac-0x400000),(0x9da880,0x9da884),*((a-0x400000,b-0x400000)for a,b in EXCLUDED))
 result=[];pos=0
 for start,end in sorted(omitted):
  assert pos<=start<end<=0xb31752
  if pos<start:result.append((pos+0x400000,start-pos,sha(stock[pos:start])))
  pos=end
 if pos<0xb31752:result.append((pos+0x400000,0xb31752-pos,sha(stock[pos:0xb31752])))
 return result
def validate():
 old=ROOT/'tools/firmware/f1_user_ui_entry_02';manifest=old/'SOURCE_SHA256.json'
 assert sha(manifest.read_bytes())==OLD_SOURCE_SHA
 j=json.loads(manifest.read_text())
 for r in j['members']:
  b=(ROOT/r['path']).read_bytes();assert len(b)==r['bytes']and sha(b)==r['sha256'],r['path']
 for name in UNCHANGED:assert(HERE/name).read_bytes()==(old/name).read_bytes(),name
 assert sha((HERE/'state.h').read_bytes())=='5219328b04dd33c4e455830d196eb9fd0e55964a284bf22591e0aa752285188a'
 stock=(ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin').read_bytes()
 assert len(stock)==11874544 and sha(stock)==STOCK_SHA
 for va,hexbytes in WORDS:assert stock[va-0x400000:va-0x400000+4].hex()==hexbytes,hex(va)
 actual=[(int(v),int(n),h)for v,n,h in re.findall(r'\{(\d+)ULL,(\d+)ULL,"([0-9a-f]{64})"\}',(HERE/'stock_windows.hpp').read_text())]
 expected=code_windows(stock);assert actual==expected and len(actual)==7
 assert any(v<=0x9ef0c4 and v+n>=0x9ef0c8 for v,n,h in actual)
 return {'schema':1,'UI_revision':'03','UI02_source_SHA256':OLD_SOURCE_SHA,'stock_SHA256':STOCK_SHA,'unchanged_runtime_files':list(UNCHANGED),'CSU_original_words':[{'va':va,'original_LE_hex':b}for va,b in WORDS],'new_excluded_VA_spans':[{'start':a,'end_exclusive':b}for a,b in EXCLUDED],'preserved_between_spans':{'start':0x9ef0c4,'end_exclusive':0x9ef0c8},'original_RX_windows':[{'va':v,'bytes':n,'sha256':h}for v,n,h in actual],'initializer_new_array_VA':None,'new_array_address_owner':'actual backend02 link, not UI03','target_executed':False,'SDK_Windows_network_device_operations':0}
def main():print(json.dumps(validate(),indent=2))
if __name__=='__main__':main()
