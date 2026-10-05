#!/usr/bin/env python3
import hashlib,json
from derive_runtime import ROOT,HERE
OUT=ROOT/'analysis/firmware/f1_native_entry_observe_build_08'
def rec(p):return {'path':str(p.relative_to(ROOT)),'bytes':p.stat().st_size,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()}
def main():
 p=HERE/'SOURCE_SHA256.json';assert not p.exists()
 b=json.loads((OUT/'BUILD_PREPARATION.json').read_text());assert b['runtime_actual_boundary_caller_present']and b['own_module_linked']and not b['actual_module_loaded']and not b['native_text_hook_installed']
 d={'schema':8,'stage':'offline_actual_module_link_source_preparation','actual_module_loaded':False,'UI_installed':False,'mask_enabled':False,'full_source_mapping_verified':False,'fresh_stock_blit_verified':False,'surface_lease_verified':False,'frozen_sources_modified':False,'members':[rec(p)for p in sorted(HERE.iterdir())if p.is_file()and p.name!='SOURCE_SHA256.json'],'frozen_refs':[rec(ROOT/r)for r in sorted(b['dependencies'])],'review_artifacts':[rec(p)for p in sorted(OUT.iterdir())if p.is_file()and p.name!='.gitignore']};p.write_text(json.dumps(d,indent=2)+'\n');print(json.dumps({'source_sha256':rec(p)['sha256'],'members':len(d['members']),'refs':len(d['frozen_refs']),'artifacts':len(d['review_artifacts'])}))
if __name__=='__main__':main()
