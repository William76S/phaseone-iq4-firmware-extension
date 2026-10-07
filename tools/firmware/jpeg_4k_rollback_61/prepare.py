#!/usr/bin/env python3
"""Remove exact60 Half modules/hooks; replace runtime/menu, retain storage semantics."""
import argparse,copy,json
from pathlib import Path
from build_components import ROOT,HERE,BASE,BASE_SHA,row
REPLACEMENTS={
 'runtime.o':'analysis/firmware/half_render_contract_60_components_final/runtime.o',
 'menu.o':'analysis/firmware/half_render_contract_60_components_final/menu.o',
 'gallery.o':'analysis/firmware/stock_jpeg_gallery_55_build_final/gallery.o'}
GALLERY_FUNCTIONS=['iq4_stock_jpeg_gallery_delete_card_61','iq4_stock_jpeg_gallery_forget_deleted_61','iq4_stock_jpeg_gallery_delete_path_61']
REMOVED_OBJECTS={
 'analysis/firmware/f1_f4_user_integration_build_02_attempt02/native_jpeg82.o',
 'analysis/firmware/stock_half_export_54/half_settings.o',
 'analysis/firmware/half_render_contract_60_components_final/sink.o',
 'analysis/firmware/half_render_contract_60_components_final/bridge.o',
 'analysis/firmware/native_half_01/build_02/half_wrappers.o',
 'analysis/firmware/stock_storage_router_55/inner_wait.o',
 'analysis/firmware/half_render_contract_60_components_final/rgb24_terminal.o'}
REMOVED_SITES={0x8e1980,0x48c98c,0x7b7ed0,0x91a78c,0x91a964,0x917f58}
REMOVED_ALIASES={'iq4_stock_half_pool_join_01','iq4_stock_half_clock_01'}
FORBIDDEN_PREFIXES=('iq4_half_','iq4_stock_half_','iq4_native_jpeg82_')
DELETE_SITES={0x4944b4,0x494610,0x4942c4}
def delete_module(path):
 p=Path(path).resolve();assert p.is_relative_to(ROOT)
 d=json.loads(p.read_text())
 assert len(d['objects'])==2 and len(d['BL_hooks'])==3 and not d.get('auxiliary_hooks',[])
 assert {h['va']for h in d['BL_hooks']}==DELETE_SITES
 for r in d['objects']+d.get('source_manifests',[])+d.get('receipts',[]):assert row(r['path'])==r,r['path']
 for r in d.get('source_manifests',[]):
  m=json.loads((ROOT/r['path']).read_text())
  for v in m.get('members',[])+m.get('target_header_closure',[]):assert row(v['path'])==v,v['path']
 assert len(d.get('source_manifests',[]))>=1 and d.get('pin_headers')
 return d,row(p)
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--components',type=Path,required=True);ap.add_argument('--output',type=Path,required=True);ap.add_argument('--delete-module',type=Path);a=ap.parse_args();out=a.output.resolve();assert out.is_relative_to(ROOT) and not out.exists()
 assert row(BASE)['sha256']==BASE_SHA;base=json.loads((ROOT/BASE).read_text());s=copy.deepcopy(base)
 comp=a.components.resolve();manifest=comp/'SOURCE_SHA256.json';m=json.loads(manifest.read_text());objects=m['objects'];assert len(objects)==3
 by_name={Path(v['path']).name:v for v in objects};assert set(by_name)==set(REPLACEMENTS)
 for r in m['members']+m['target_header_closure']+objects:assert row(r['path'])==r,r['path']
 removed_objects=[o for o in s['objects']if o['path']in REMOVED_OBJECTS];assert len(removed_objects)==7
 s['objects']=[o for o in s['objects']if o['path']not in REMOVED_OBJECTS];pairs=[]
 for name,old in REPLACEMENTS.items():
  new=by_name[name];matches=[i for i,o in enumerate(s['objects'])if o['path']==old];assert len(matches)==1;i=matches[0];before=s['objects'][i];assert row(old)==before;s['objects'][i]=new;pairs.append(dict(before=before,after=new))
 assert len(base['objects'])==43 and len(s['objects'])==36
 removed_hooks=[h for h in s['BL_hooks']if h['va']in REMOVED_SITES];assert len(removed_hooks)==6
 assert not REMOVED_SITES.intersection(h['va']for h in s['auxiliary_hooks'])
 s['BL_hooks']=[h for h in s['BL_hooks']if h['va']not in REMOVED_SITES]
 removed_aliases=[v for v in s['aliases']if v['symbol']in REMOVED_ALIASES];assert len(removed_aliases)==2
 s['aliases']=[v for v in s['aliases']if v['symbol']not in REMOVED_ALIASES]
 removed_required=[v for v in s['required_functions']if v.startswith(FORBIDDEN_PREFIXES)]
 s['required_functions']=[v for v in s['required_functions']if not v.startswith(FORBIDDEN_PREFIXES)]
 s['required_functions']+=GALLERY_FUNCTIONS
 assert len(s['BL_hooks'])+len(s['auxiliary_hooks'])==49;s['expected_hook_count']=49
 s['source_manifests'].append(row(manifest));s['receipts']+=[row(BASE),row(HERE/'prepare.py'),row(HERE/'assemble.py'),row(HERE/'verify_delta.py')]
 added_objects=[];added_hooks=[]
 if a.delete_module:
  d,dr=delete_module(a.delete_module)
  assert not DELETE_SITES.intersection(h['va']for h in s['BL_hooks']+s['auxiliary_hooks'])
  assert not {o['path']for o in d['objects']}.intersection(o['path']for o in s['objects'])
  assert not {v['symbol']for v in d.get('aliases',[])}.intersection(v['symbol']for v in s['aliases'])
  added_objects=d['objects'];added_hooks=d['BL_hooks'];s['objects']+=added_objects;s['BL_hooks']+=added_hooks
  s['aliases']+=d.get('aliases',[]);s['required_functions']+=d.get('required_functions',[])
  s['source_manifests']+=d['source_manifests'];s['receipts']+=[dr]+d.get('receipts',[])
  s['paired_delete_module']=dr;s['paired_delete_pin_headers']=d['pin_headers'];s['expected_hook_count']=52
 s.update(integration_revision='JPEG_stock_4K_only_61',scope='Only original 4K JPEG render and original encoder; remove Half render/codec/observer/waits/RGB24/settings paths. Preserve XQD formats, SD policies, JPEG-only receipt/gallery, Ratio Mask, Dual Exposure and recording removal.',Half_implementation_linked=False,SensorPlus_implementation_linked=False,JPEG_size_choices=['4K'],native_JPEG_size_enum=1)
 out.mkdir();(out/'INPUTS.json').write_text(json.dumps(s,indent=2)+'\n');(out/'REPLACEMENTS.json').write_text(json.dumps(dict(base=row(BASE),replacements=pairs,removed_objects=removed_objects,removed_hooks=removed_hooks,removed_aliases=removed_aliases,removed_required_functions=removed_required,added_objects=added_objects,added_hooks=added_hooks,unchanged_precompiled_objects=33,camera_accessed=False),indent=2)+'\n');print(json.dumps(row(out/'INPUTS.json')))
if __name__=='__main__':main()
