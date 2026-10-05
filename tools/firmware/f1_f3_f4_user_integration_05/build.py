#!/usr/bin/env python3
"""Link the exact frozen native F1/F3/F4 implementation; no device control."""
from pathlib import Path
import argparse, hashlib, importlib.util, json, subprocess, sys
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
BACKEND=ROOT/'tools/firmware/f1_user_elf_append_03/elf_append.py'

def row(p):
 p=p.resolve();assert p.is_relative_to(ROOT);b=p.read_bytes()
 return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())

def verify(e):
 p=ROOT/e['path'];actual=row(p)
 assert actual['bytes']==e['bytes'] and actual['sha256']==e['sha256'],e['path']
 return p

def lock(e):
 p=verify(e);j=json.loads(p.read_text());members=j.get('members',j.get('files'))
 assert members,p
 if isinstance(members,dict):members=[dict(path=k,**v)for k,v in members.items()]
 for item in members:verify(item)
 for name in ['dependencies','target_header_closure']:
  for item in j.get(name,[]):verify(item)
 for name in ['build','commands','movie_scanner_consumer_inspected']:
  v=j.get(name)
  if isinstance(v,dict) and {'path','bytes','sha256'}<=v.keys():verify(v)
 # Consume exact rows explicitly recorded by this current source manifest,
 # including compiler receipts and external inputs. Do not recursively read
 # arbitrary historical diagnostic JSONs or replace their source identities.
 def rows(value):
  if isinstance(value,dict):
   if {'path','bytes','sha256'}<=value.keys():verify(value)
   for child in value.values():rows(child)
  elif isinstance(value,list):
   for child in value:rows(child)
 rows(j)

def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True)
 ap.add_argument('--spec',type=Path,required=True);ap.add_argument('--spec-sha256',required=True)
 ap.add_argument('--object-map',type=Path);ap.add_argument('--app-version',default='6.03.34');a=ap.parse_args()
 specpath=a.spec.resolve();assert row(specpath)['sha256']==a.spec_sha256
 spec=json.loads(specpath.read_text());assert spec['schema']=='iq4_F1_F3_F4_exact_native_inputs_01'
 out=a.output.resolve();assert out.is_relative_to(ROOT) and not out.exists()
 assert row(BACKEND)['sha256']=='05c7bb3eabcd471d7ef2fbe8a53c014abcc62e212a9234810521e0ec91557b6d'
 for manifest in spec['source_manifests']:lock(manifest)
 for receipt in spec['receipts']:verify(receipt)
 remap={}
 if a.object_map:
  j=json.loads(a.object_map.read_text());assert j['schema']=='iq4_frozen_target_objects_fresh_recompile_01';remap=j['remap']
  assert all(Path(k).suffix==Path(v).suffix=='.o'for k,v in remap.items())
 objects=[]
 for item in spec['objects']:
  p=ROOT/remap.get(item['path'],item['path']);v=row(p)
  assert v['bytes']==item['bytes']and v['sha256']==item['sha256'],item['path']
  objects.append((item['path'],p.read_bytes()))
 assert len({p for p,_ in objects})==len(objects)
 zig=verify(spec['compiler']);out.mkdir(parents=True);commands=[];compiled=[]
 for source in spec['compile']:
  p=verify(source['source']);obj=out/source['object_name']
  argv=[str(zig),'cc',*spec['C_flags'],'-c',str(p),'-o',str(obj)]
  q=subprocess.run(argv,cwd=ROOT,capture_output=True,text=True)
  commands.append(dict(argv=argv,exit=q.returncode,stdout=q.stdout,stderr=q.stderr))
  (out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert q.returncode==0,q.stderr
  objects.append((str(obj.relative_to(ROOT)),obj.read_bytes()));compiled.append(dict(source=source['source'],object=row(obj)))
 assert len(objects)<=96
 loader=importlib.util.spec_from_file_location('exact_F1_F3_F4_backend',BACKEND)
 m=importlib.util.module_from_spec(loader);sys.modules[loader.name]=m;loader.loader.exec_module(m)
 stock=verify(spec['stock']);original=m.original_contract(stock.read_bytes())
 m.ALIASES={}
 for binding in spec['aliases']:
  va=binding['va'];before=original.data[original.va_offset(va,16):original.va_offset(va,16)+16]
  assert before.hex()==binding['original_first16_LE'],binding['symbol']
  assert binding['symbol']not in m.ALIASES;m.ALIASES[binding['symbol']]=(va,binding['kind'])
 m.HOOKS=tuple((h['va'],bytes.fromhex(h['old_hex']),h['original_target'],h['target_symbol'])for h in spec['BL_hooks'])
 m.INITIALIZER='iq4_extensions_initialize_01'
 m.REQUIRED_SYMBOLS=tuple(h[3]for h in m.HOOKS)+(m.INITIALIZER,*spec['required_functions'])
 version=tuple(map(int,a.app_version.split('.')));assert len(version)==3
 try:
  payload,report=m.Linker(stock.read_bytes(),objects).build(version)
  patchspec=importlib.util.spec_from_file_location('exact_auxiliary_hook_patch',ROOT/'tools/firmware/finite_aux_hooks_01/patch.py')
  aux=importlib.util.module_from_spec(patchspec);patchspec.loader.exec_module(aux)
  payload=aux.apply_exact_auxiliary_hooks(stock.read_bytes(),payload,report,spec['auxiliary_hooks'],m.Elf)
 except Exception as error:
  (out/'LINK_FAILURE.json').write_text(json.dumps(dict(error_type=type(error).__name__,reason=str(error),target_executed=False),indent=2)+'\n');raise
 user=out/f'P1Linux_RatioMask_JPEG_LVRecording_{a.app_version}.bin';user.write_bytes(payload)
 (out/'LINK_REPORT.json').write_text(json.dumps(report,indent=2)+'\n')
 result=dict(schema='iq4_actual_F1_F3_F4_User_link_01',spec=row(specpath),stock=row(stock),compiler=row(zig),compiled=compiled,
  User=row(user),link_report=row(out/'LINK_REPORT.json'),object_count=len(objects),linked_contract_sealed=False,
  F3_manual_full_RAW_implementation_linked=True,F3_SD_automatic_implementation_linked=True,F3_XQD_automatic_implementation_linked=spec['XQD_automatic_implementation'],F3_XQD_automatic_accepted=False,
  target_executed=False,camera_accessed=False,full_RAW_native_execution_accepted=False,
  in_camera_recording_accepted=False,persistent_recovery_verified=False,persistent_installation_safe=False)
 (out/'BUILD.json').write_text(json.dumps(result,indent=2)+'\n');print(len(payload),'actual linked User bytes,',len(objects),'objects; seal and review still required')

if __name__=='__main__':main()
