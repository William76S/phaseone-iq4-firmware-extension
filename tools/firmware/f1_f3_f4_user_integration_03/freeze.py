#!/usr/bin/env python3
"""Freeze active inputs without rewriting identities of historical diagnostics."""
from pathlib import Path
import argparse,hashlib,json,re,zipfile
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
def row(p):
 p=p.resolve();b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--verify',action='store_true');ap.add_argument('--spec',type=Path);ap.add_argument('--build',type=Path);ap.add_argument('--package',type=Path);ap.add_argument('--reproduction',type=Path);ap.add_argument('--guide',type=Path);ap.add_argument('--archive',type=Path);a=ap.parse_args()
 target=HERE/'SOURCE_SHA256.json'
 if a.verify:
  j=json.loads(target.read_text())
  for e in j['files']:assert row(ROOT/e['path'])==e,e['path']
  for e in j['external_inputs']:
   b=Path(e['path']).read_bytes();assert len(b)==e['bytes']and hashlib.sha256(b).hexdigest()==e['sha256']
  print(len(j['files']),'exact current inputs verified; no hardware acceptance');return
 assert all([a.spec,a.build,a.package,a.reproduction,a.guide])and not target.exists()
 if a.archive:
  archive=a.archive.resolve();assert archive.is_relative_to(ROOT)and not archive.exists()
 files={}
 def add(p,expected=None):
  p=p.resolve();assert p.is_relative_to(ROOT);e=row(p)
  if expected:assert(e['bytes'],e['sha256'])==(expected['bytes'],expected['sha256']),e['path']
  if e['path']in files:assert files[e['path']]==e;return
  files[e['path']]=e
  if p.suffix in('.c','.h','.cpp','.hpp','.S','.inc'):
   for inc in re.findall(r'^\s*#\s*include\s*"([^"]+)"',p.read_text(),re.M):
    q=p.parent/inc
    if q.is_file():add(q)
 def manifest(p):
  add(p);j=json.loads(p.read_text())
  for key in ['files','members','dependencies','target_header_closure']:
   entries=j.get(key,[])
   if isinstance(entries,dict):entries=[dict(path=k,**v)for k,v in entries.items()]
   for e in entries:
    if {'path','bytes','sha256'}<=e.keys():add(ROOT/e['path'],e)
  for key in ['build','commands','movie_scanner_consumer_inspected']:
   e=j.get(key)
   if isinstance(e,dict)and {'path','bytes','sha256'}<=e.keys():add(ROOT/e['path'],e)
  def rows(value):
   if isinstance(value,dict):
    if {'path','bytes','sha256'}<=value.keys():add(ROOT/value['path'],value)
    for child in value.values():rows(child)
   elif isinstance(value,list):
    for child in value:rows(child)
  rows(j)
 spec=json.loads(a.spec.read_text());add(a.spec)
 for e in spec['source_manifests']:add(ROOT/e['path'],e);manifest(ROOT/e['path'])
 for e in spec['receipts']+spec['objects']+[spec['stock'],spec['compiler']]:add(ROOT/e['path'],e)
 for e in spec['compile']:add(ROOT/e['source']['path'],e['source'])
 for e in spec['objects']:
  parent=(ROOT/e['path']).parent;p=parent/'COMMANDS.json'
  if not p.is_file():p=parent/'BUILD.json'
  add(p)
 for directory in [HERE,ROOT/'tools/firmware/native_linked_contract_01',ROOT/'tools/firmware/native_linked_unwind_02',ROOT/'tools/firmware/finite_aux_hooks_01',a.build,a.package,a.reproduction]:
  for p in directory.iterdir():
   if p.is_file()and(p.suffix in('.py','.c','.h','.md','.json','.bin','.fwp','.fwr'))and p.name not in('SOURCE_SHA256.json','INPUTS.json','INPUTS_FINAL_01.json'):
    add(p)
 for p in [ROOT/'tools/firmware/user_only_package_01/SOURCE_SHA256.json',ROOT/'tools/firmware/user_only_package_stock_wrapper_02/SOURCE_SHA256.json',ROOT/'tools/firmware/user_only_package_stock_wrapper_03/SOURCE_SHA256.json',ROOT/'tools/firmware/native_copy_rtti_01/SOURCE_SHA256.json',ROOT/'tools/firmware/native_linked_unwind_02/SOURCE_SHA256.json']:
  manifest(p)
 add(a.guide);add(ROOT/'analysis/firmware/vendor_downloads/stock_fwp_01/XFSystem8.02.0.fwp')
 add(ROOT/'tools/firmware/native_copy_rtti_01/ABI_PROOF.json')
 for p in a.reproduction.rglob('*'):
  if p.is_file()and p.suffix in('.json','.d','.bin','.fwp','.fwr','.o'):add(p)
 for p in a.build.rglob('*'):
  if p.is_file()and p.suffix in('.json','.d','.o','.log'):add(p)
 external=ROOT.parent/'Firmware-BP-IQ4-IQ4_6.03.18.fwr';b=external.read_bytes()
 result=dict(schema='iq4_active_F1_F3_F4_source_and_candidate_lock_01',active_spec=row(a.spec),active_build=row(a.build/'BUILD.json'),active_package=row(a.package/'PLAN.json'),files=sorted(files.values(),key=lambda e:e['path']),external_inputs=[dict(path=str(external),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())],historical_diagnostic_source_identities_not_reassigned=True,target_executed=False,camera_accessed=False,persistent_recovery_verified=False)
 target.write_text(json.dumps(result,indent=2)+'\n')
 if a.archive:
  # This local source supplement accompanies the original workspace. Compiler,
  # licensed vendor firmware/libraries and prior object receipts stay local.
  paths=[ROOT/e['path']for e in result['files']if Path(e['path']).suffix in('.py','.c','.h','.cpp','.hpp','.S','.inc','.json','.md','.d')]+[target]
  archive.parent.mkdir(parents=True,exist_ok=True)
  with zipfile.ZipFile(archive,'x',compression=zipfile.ZIP_DEFLATED,compresslevel=9)as z:
   for p in sorted(set(paths)):
    info=zipfile.ZipInfo(str(p.relative_to(ROOT)),(1980,1,1,0,0,0));info.compress_type=zipfile.ZIP_DEFLATED;info.external_attr=0o100600<<16;z.writestr(info,p.read_bytes())
  print('Local source supplement',row(archive))
 print(len(files),'active exact local inputs frozen; no installation acceptance')
if __name__=='__main__':main()
