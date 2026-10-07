#!/usr/bin/env python3
"""Replace four locked59 JPEG objects; add one Half-only RGB24 terminal hook."""
import argparse,copy,json
from pathlib import Path
from build_components import ROOT,HERE,BASE,BASE_SHA,row
REPLACEMENTS={
 'runtime.o':'analysis/firmware/half_request_owner_59_components_final/runtime.o',
 'bridge.o':'analysis/firmware/half_request_owner_59_components_final/bridge.o',
 'menu.o':'analysis/firmware/half_entry_trace_58_components_final/menu.o',
 'sink.o':'analysis/firmware/f3_stock_half_export_build_01/sink.o'}
NEW_HOOK=dict(va=0x917f58,old_hex='7cc5ff97',original_target=0x909548,target_symbol='iq4_half_rgb24_construct_60')
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--components',type=Path,required=True);ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve();assert out.is_relative_to(ROOT) and not out.exists()
 assert row(BASE)['sha256']==BASE_SHA;base=json.loads((ROOT/BASE).read_text());s=copy.deepcopy(base)
 comp=a.components.resolve();manifest=comp/'SOURCE_SHA256.json';m=json.loads(manifest.read_text());objects=m['objects'];assert len(objects)==5
 by_name={Path(v['path']).name:v for v in objects};assert set(by_name)==set(REPLACEMENTS)|{'rgb24_terminal.o'}
 for r in m['members']+m['target_header_closure']+objects:assert row(r['path'])==r,r['path']
 pairs=[]
 for name,old in REPLACEMENTS.items():
  new=by_name[name];matches=[i for i,o in enumerate(s['objects'])if o['path']==old];assert len(matches)==1;i=matches[0];before=s['objects'][i];assert row(old)==before;s['objects'][i]=new;pairs.append(dict(before=before,after=new))
 s['objects'].append(by_name['rgb24_terminal.o'])
 assert len(base['objects'])==42 and len(s['objects'])==43 and s['expected_hook_count']==54
 assert NEW_HOOK['va'] not in {h['va']for h in s['BL_hooks']+s['auxiliary_hooks']}
 s['BL_hooks'].append(NEW_HOOK);s['expected_hook_count']=55
 s['source_manifests'].append(row(manifest));s['receipts']+=[row(BASE),row(HERE/'prepare.py'),row(HERE/'assemble.py'),row(HERE/'verify_delta.py')]
 s.update(integration_revision='Half_render_contract_RGB24_60',scope='Half-only native RGB16-to-RGB24 terminal packing, dynamic completed stage counts, RGB JPEG sink and finite render status. Complete RAW and original card route retained. Device Half output not accepted. Ratio/Dual unchanged; recording absent.')
 out.mkdir();(out/'INPUTS.json').write_text(json.dumps(s,indent=2)+'\n');(out/'REPLACEMENTS.json').write_text(json.dumps(dict(base=row(BASE),replacements=pairs,added_objects=[by_name['rgb24_terminal.o']],added_hooks=[NEW_HOOK],unchanged_precompiled_objects=38,camera_accessed=False),indent=2)+'\n');print(json.dumps(row(out/'INPUTS.json')))
if __name__=='__main__':main()
