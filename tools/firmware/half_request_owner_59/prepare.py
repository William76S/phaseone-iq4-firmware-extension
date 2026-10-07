#!/usr/bin/env python3
"""Replace exactly the frozen58 runtime and producer bridge objects."""
import argparse,copy,json
from pathlib import Path
from build_components import ROOT,HERE,BASE,BASE_SHA,row
OLD_RUNTIME='analysis/firmware/half_entry_trace_58_components_final/runtime.o'
OLD_BRIDGE='analysis/firmware/half_entry_trace_58_components_final/bridge.o'
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--components',type=Path,required=True);ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve();assert out.is_relative_to(ROOT) and not out.exists()
 assert row(BASE)['sha256']==BASE_SHA;base=json.loads((ROOT/BASE).read_text());s=copy.deepcopy(base)
 comp=a.components.resolve();manifest=comp/'SOURCE_SHA256.json';m=json.loads(manifest.read_text());objects=m['objects'];assert len(objects)==2
 pairs=[]
 for old,new in zip([OLD_RUNTIME,OLD_BRIDGE],objects):
  assert row(new['path'])==new;matches=[i for i,o in enumerate(s['objects']) if o['path']==old];assert len(matches)==1;i=matches[0];before=s['objects'][i];assert row(old)==before;s['objects'][i]=new;pairs.append(dict(before=before,after=new))
 assert len(s['objects'])==42 and s['expected_hook_count']==54
 s['source_manifests'].append(row(manifest));s['receipts']+=[row(BASE),row(HERE/'prepare.py'),row(HERE/'assemble.py'),row(HERE/'verify_delta.py')]
 s.update(integration_revision='Half_request_ownership_59',scope='Match original JPEG request cancellation marker and both IFM output targets before Half entry or diagnostics. No pixel/render change. Actual 50% device acceptance pending. Ratio/Dual unchanged; recording absent.')
 out.mkdir();(out/'INPUTS.json').write_text(json.dumps(s,indent=2)+'\n');(out/'REPLACEMENTS.json').write_text(json.dumps(dict(base=row(BASE),replacements=pairs,unchanged_precompiled_objects=40,camera_accessed=False),indent=2)+'\n');print(json.dumps(row(out/'INPUTS.json')))
if __name__=='__main__':main()
