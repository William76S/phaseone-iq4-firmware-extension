#!/usr/bin/env python3
"""Exact offline storage-coupling assembly; no camera/deployment operation."""
import argparse,copy,hashlib,importlib.util,json,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
BASE='analysis/firmware/jpeg_restart_54_link_inputs/COMBINED_LINK.json'
DEFAULTS=['analysis/firmware/stock_storage_menu_55_build/LINK.json','analysis/firmware/stock_storage_sd_primary_55_build_final02/LINK.json','tools/firmware/stock_new_raw_receipt_55/LINK_INPUTS.json','analysis/firmware/stock_jpeg_decode_55_memory_build_final/LINK.json','analysis/firmware/stock_jpeg_gallery_exif_55/LINK.json','analysis/firmware/stock_jpeg_half_status_menu_55_build_final02/LINK.json']
REMOVE={'analysis/firmware/stock_half_export_54/runtime.o','analysis/firmware/stock_jpeg_policy_build_01/policy.o','analysis/firmware/stock_jpeg_policy_build_01/ctor_wrapper.o','analysis/firmware/stock_jpeg_menu_build_02/menu.o','analysis/firmware/stock_jpeg_half_menu_build_02/menu.o'}
def row(path,expected=None):
 p=Path(path);p=(ROOT/p).resolve()if not p.is_absolute()else p.resolve();assert p.is_relative_to(ROOT);b=p.read_bytes();r=dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest());
 if expected:assert r['sha256']==expected['sha256']and('bytes'not in expected or r['bytes']==expected['bytes']),r['path']
 return r

def main():
 ap=argparse.ArgumentParser();ap.add_argument('--router-link',required=True);ap.add_argument('--gallery-link',required=True);ap.add_argument('--half-link');ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve();assert out.is_relative_to(ROOT)and not out.exists()
 base=json.loads((ROOT/BASE).read_text());assert base['schema']=='iq4_stock_JPEG_half_combined_54';original=(ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin').read_bytes();assert hashlib.sha256(original).hexdigest()=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
 inputs=[BASE,*DEFAULTS,a.router_link,a.gallery_link,*([a.half_link]if a.half_link else[])];removed=set(REMOVE)
 if a.half_link:removed|={'analysis/firmware/native_half_01/build_02/half_bridge.o','analysis/firmware/native_half_01/build_02/half_wrappers.o'}
 all_inputs=[json.loads((ROOT/p).read_text())for p in inputs];combined=dict(schema='iq4_stock_storage_coupled_55',objects=[],aliases=[],BL_hooks=[],auxiliary_hooks=[],required_functions=[],source_manifests=[],receipts=[]);removed_rows=[]
 hooks={};aux={}
 for path,j in zip(inputs,all_inputs):
  assert not j.get('draft',False),path
  for obj in j['objects']:
   v=row(obj['path'],obj)
   if v['path']in removed:removed_rows.append(v)
   else:combined['objects'].append(v)
  combined['aliases'].extend(copy.deepcopy(j.get('aliases',[])))
  for key,table in [('BL_hooks',hooks),('auxiliary_hooks',aux)]:
   for h in j.get(key,[]):
    if h['va']in table:
     old=table[h['va']];assert old['old_hex']==h['old_hex']and old.get('original_target')==h.get('original_target'),(hex(h['va']),path)
    table[h['va']]=copy.deepcopy(h)
  for k in ['required_functions','new_required_functions']:combined['required_functions'].extend(j.get(k,[]))
  for v in j.get('source_manifests',[]):combined['source_manifests'].append(row(v['path'],v))
  if j.get('source_manifest'):combined['source_manifests'].append(row(j['source_manifest'],dict(sha256=j['source_manifest_sha256'])))
  for v in j.get('receipts',[]):combined['receipts'].append(row(v['path'],v))
  combined['receipts'].append(row(path))
 assert {x['path']for x in removed_rows}==removed
 combined['BL_hooks']=list(hooks.values());combined['auxiliary_hooks']=list(aux.values());assert not(set(hooks)&set(aux))
 # Resolve only actual pre-existing PLT imports. No new dynamic symbol/table,
 # loader COPY cell, invented ABI or default JPEG stderr/exit is introduced.
 imports=json.loads((ROOT/'analysis/firmware/storage_coupling_55/JPEG_PRIVATE_IMPORTS_CANDIDATE.json').read_text());allowed={'malloc','strchr','strncmp','strstr','__isoc99_sscanf','fread','getenv'}
 for name in sorted(allowed):
  r=imports[name];assert r['type']==1026;combined['aliases'].append({k:r[k]for k in ['symbol','va','kind','original_first16_LE']})
 for r in combined['aliases']:
  if 'original_first16_LE'not in r:r['kind']='exact original 55 native continuation';r['original_first16_LE']=original[r['va']-0x400000:r['va']-0x400000+16].hex()
  assert len(r['original_first16_LE'])==32
 table={}
 for r in combined['aliases']:
  if r['symbol']in table:assert(table[r['symbol']]['va'],table[r['symbol']]['original_first16_LE'])==(r['va'],r['original_first16_LE'])
  else:table[r['symbol']]=r
 combined['aliases']=list(table.values());assert not{'exit','stderr','fprintf'}&set(table)
 for key,field in [('objects','path'),('source_manifests','path'),('receipts','path')]:
  uniq={}
  for r in combined[key]:
   if r[field]in uniq:assert uniq[r[field]]==r
   else:uniq[r[field]]=r
  combined[key]=list(uniq.values())
 # Preserve exact required ABI exports shared by old wrappers; reject all
 # unresolved consumers against final real objects and precise aliases.
 nm='/Library/Developer/CommandLineTools/usr/bin/llvm-nm';defs=set();uses=set()
 for obj in combined['objects']:
  text=subprocess.check_output([nm,'--format=posix',str(ROOT/obj['path'])],text=True)
  for line in text.splitlines():
   fields=line.split()
   if len(fields)<2:continue
   if fields[1]=='U':uses.add(fields[0])
   elif fields[1].upper()in{'T','D','B','R','V','W','C','A'}:defs.add(fields[0])
 # The common 32 preserved base objects and initialize/contract are added by
 # the frozen cleanup preparer. Their definitions are audited by that tool.
 # The destination setter belongs to the removed manual Destination menu.
 # This precise retired requirement has no consumer and is replaced by the
 # real format setter; do not silently drop any other missing definition.
 retired='iq4_stock_jpeg_destination_set_01'
 assert retired not in uses and 'iq4_stock_xqd_format_set_55' in defs
 assert {x for x in combined['required_functions']if x not in defs}=={retired}
 combined['retired_unused_requirements']=[dict(symbol=retired,consumer_count=0,replacement='iq4_stock_xqd_format_set_55')]
 combined['required_functions']=list(dict.fromkeys(x for x in combined['required_functions']if x!=retired));combined['removed_54_objects']=removed_rows;combined['component_symbol_audit']=dict(definitions=len(defs),uses=len(uses),uses_resolved_by_preserved_base_or_aliases=sorted(uses-defs));combined['camera_accessed']=False;combined['hardware_accepted']=False;combined['scope']='Native XQD Storage formats with native SD policy routing, original complete RAW-derived 4K/50% encoder, independent JPEG catalog/LCD, checked new RAW-only retirement; JPEG failures keep RAW and finite quiescent pending cleanup.'
 combined['receipts'].append(row(__file__));combined['receipts'].append(row('tools/firmware/stock_storage_release_55/check.py'));combined['receipts'].append(row('analysis/firmware/stock_storage_release_55_check_final/SOURCE_SHA256.json'));combined['receipts'].append(row('analysis/firmware/jpeg_gallery_independent_audit_55/REVIEW.json'));combined['receipts'].append(row('tools/firmware/stock_storage_release_55/assemble.py'));combined['receipts'].append(row('tools/firmware/native_runtime_01/self_read.h'));combined['receipts'].append(row('analysis/firmware/storage_coupling_55/REQUIREMENTS.json'));combined['receipts'].append(row('analysis/firmware/storage_coupling_55/JPEG_PRIVATE_IMPORTS_CANDIDATE.json'))
 out.mkdir(parents=True);p=out/'COMBINED_LINK.json';p.write_text(json.dumps(combined,indent=2)+'\n')
 command=['python3','tools/firmware/jpeg_restart_01/prepare.py','--output',str((out/'inputs').relative_to(ROOT)),'--link-input',str(p.relative_to(ROOT))];q=subprocess.run(command,cwd=ROOT,capture_output=True,text=True);(out/'PREPARE_COMMAND.json').write_text(json.dumps(dict(argv=command,exit=q.returncode,stdout=q.stdout,stderr=q.stderr),indent=2)+'\n');assert q.returncode==0,(q.stdout,q.stderr)
 spec=out/'inputs/INPUTS_CLEANUP_DRAFT.json';j=json.loads(spec.read_text());j['stock_JPEG_XQD_bridge_linked']=True;j['integration_revision']='stock_storage_coupled_55';j['scope']=combined['scope'];spec.write_text(json.dumps(j,indent=2)+'\n');print(json.dumps(dict(spec=row(spec),objects=len(j['objects'])+len(j['compile']),hooks=j['expected_hook_count'],camera_accessed=False)))
if __name__=='__main__':main()
