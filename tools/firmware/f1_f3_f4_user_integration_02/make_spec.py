#!/usr/bin/env python3
"""Extend the sealed SD candidate using exact XQD overlay identities only."""
from pathlib import Path
import argparse,hashlib,importlib.util,json,sys
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
BASE=ROOT/'tools/firmware/f1_f3_f4_user_integration_01/INPUTS_FINAL_02.json'
BASE_SHA='b43bea885d090504b4f9057df31e086d392469ae036f4a3ccf4cf6d24db75e0b'
def row(p):
 p=p.resolve();assert p.is_relative_to(ROOT);b=p.read_bytes()
 return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def checked(e):
 p=Path(e['path']);p=p if p.is_absolute()else ROOT/p
 actual=row(p);assert(actual['bytes'],actual['sha256'])==(e['bytes'],e['sha256']),e['path'];return actual

def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True)
 ap.add_argument('--overlay',type=Path,action='append',required=True)
 ap.add_argument('--bindings',type=Path,required=True);a=ap.parse_args()
 assert row(BASE)['sha256']==BASE_SHA
 j=json.loads(BASE.read_text());objects=j['objects'];receipts=j['receipts'];manifests=j['source_manifests']
 receipts.append(row(BASE));overlay_rows=[]
 for path in a.overlay:
  path=path.resolve();overlay_rows.append(row(path));ov=json.loads(path.read_text());receipts.append(row(path))
  source=path.with_name('SOURCE_SHA256.json');assert source.is_file();manifests.append(row(source))
  changes=ov.get('replacements',[ov]if 'replace_only'in ov else [])
  assert changes,path
  for change in changes:
   before=checked(change['replace_only']);after=checked(change['replacement'])
   at=[i for i,e in enumerate(objects)if(e['bytes'],e['sha256'])==(before['bytes'],before['sha256'])]
   assert len(at)==1,(path,before,at);objects[at[0]]=after
  for e in ov.get('additional_objects',[]):objects.append(checked(e))
  for name in ov.get('required_functions',[]):
   if name not in j['required_functions']:j['required_functions'].append(name)
 assert len(objects)+len(j['compile'])<=64 and len({e['path']for e in objects})==len(objects)
 loader=importlib.util.spec_from_file_location('xqd_original_contract',ROOT/'tools/firmware/f1_user_elf_append_02/elf_append.py')
 m=importlib.util.module_from_spec(loader);sys.modules[loader.name]=m;loader.loader.exec_module(m)
 stock=m.original_contract((ROOT/j['stock']['path']).read_bytes())
 bindings=json.loads(a.bindings.read_text());receipts.append(row(a.bindings))
 assert bindings['input_sha256']==j['stock']['sha256'] and bindings['input_bytes']==j['stock']['bytes']
 for e in bindings['bindings']:
  va=e['va'];offset=stock.va_offset(va,e['bytes']);b=stock.data[offset:offset+e['bytes']]
  assert hashlib.sha256(b).hexdigest()==e['sha256'] and b.hex()==e['hex']
  value=dict(symbol=e['symbol'],va=va,kind='exact_original_XQD_capture_03',original_first16_LE=stock.data[stock.va_offset(va,16):stock.va_offset(va,16)+16].hex())
  at=[i for i,v in enumerate(j['aliases'])if v['symbol']==e['symbol']]
  assert len(at)<=1
  if at:assert j['aliases'][at[0]]['va']==va;j['aliases'][at[0]]=value
  else:j['aliases'].append(value)
 for h in bindings['hooks']:
  va=h['va'];offset=stock.va_offset(va,4);assert stock.data[offset:offset+4].hex()==h['old_hex']
  for field in ['BL_hooks','auxiliary_hooks']:j[field]=[v for v in j[field]if v['va']!=va]
  kind=h.get('branch_kind',h.get('kind'));assert kind in ('B','BL')
  if 'original_target'in h:
   assert kind=='BL'
   j['BL_hooks'].append(dict(va=va,old_hex=h['old_hex'],original_target=h['original_target'],target_symbol=h['target_symbol']))
  else:j['auxiliary_hooks'].append(dict(va=va,branch_kind=kind,target_symbol=h['target_symbol'],old_hex=h['old_hex']))
 all_hooks=j['BL_hooks']+j['auxiliary_hooks'];assert len({e['va']for e in all_hooks})==len(all_hooks)
 j['aliases'].sort(key=lambda e:e['symbol'])
 for field in ['receipts','source_manifests']:
  rows={e['path']:checked(e)for e in j[field]};j[field]=[rows[p]for p in sorted(rows)]
 for e in j['compile']:
  if e['object_name']=='initialize.o':e['source']=row(HERE/'initialize.c')
 j.update(integration_revision=2,SD_automatic_only=False,SD_automatic_implementation=True,XQD_automatic_implementation=True,
  expected_hook_count=len(all_hooks),overlay_inputs=overlay_rows,target_executed=False,camera_accessed=False)
 output=a.output.resolve();assert output.is_relative_to(ROOT) and not output.exists()
 output.write_text(json.dumps(j,indent=2)+'\n')
 print(len(objects)+len(j['compile']),'exact objects;',len(all_hooks),'hooks; spec',row(output)['sha256'])
if __name__=='__main__':main()
