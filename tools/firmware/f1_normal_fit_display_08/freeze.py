#!/usr/bin/env python3
from pathlib import Path
import hashlib,json
from hook_plan import ROOT,HERE
OUT=ROOT/'analysis/firmware/f1_normal_fit_display_build_08'
def rec(p):return {'path':str(p.relative_to(ROOT)),'bytes':p.stat().st_size,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()}
def main():
 p=HERE/'SOURCE_SHA256.json';assert not p.exists(),'Frozen source cannot be rewritten'
 b=json.loads((OUT/'BUILD_VALIDATION.json').read_text());assert b['tests']['normal']['groups']==b['tests']['asan_ubsan']['groups']==11 and b['plan_tests']['checks']==15
 assert b['production_PaintToken_issuer']=='ProvenProviderAdapter::dispatch_scaler_return_on_ui'and not b['actual_provider_contract_received'] and not b['new_enabled_SO_generated']and not b['actual_UI_or_module_loaded']
 d={'schema':8,'stage':'offline_normal_fit_source_and_static_ABI_preparation','target_loaded':False,'mask_enabled':False,'actual_full_source_verified':False,'actual_fresh_stock_write_verified':False,'actual_surface_lease_verified':False,'frozen_sources_modified':False,'members':[rec(p)for p in sorted(HERE.iterdir())if p.is_file()and p.name!='SOURCE_SHA256.json'],'frozen_refs':[rec(ROOT/r)for r in sorted(b['dependencies'])],'review_artifacts':[rec(p)for p in sorted(OUT.iterdir())if p.is_file()and p.name!='.gitignore'and not p.name.startswith('host_')]};p.write_text(json.dumps(d,indent=2)+'\n');print(json.dumps({'source_sha256':rec(p)['sha256'],'members':len(d['members']),'refs':len(d['frozen_refs']),'artifacts':len(d['review_artifacts'])}))
if __name__=='__main__':main()
