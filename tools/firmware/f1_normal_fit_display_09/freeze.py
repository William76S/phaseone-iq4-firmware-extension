#!/usr/bin/env python3
import hashlib,json
from build_prepare import ROOT,HERE,OUT
def rec(p):return {'path':str(p.relative_to(ROOT)),'bytes':p.stat().st_size,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()}
def main():
 p=HERE/'SOURCE_SHA256.json';assert not p.exists()
 b=json.loads((OUT/'BUILD_PREPARATION.json').read_text());assert b['tests']['normal']['groups']==b['tests']['asan_ubsan']['groups']==11 and b['tests']['geometry_normal']['cases']==b['tests']['geometry_asan_ubsan']['cases']==270
 assert b['production_render_body_in_actual_SO']and b['native_RGB24_return_issuer_in_actual_SO']and not b['target_loaded']and not b['actual_provider_contract_received']and not b['native_text_hook_installed']
 d={'schema':9,'stage':'offline_fixed_array_production_module_link_preparation','production_body_linked':True,'target_loaded':False,'UI_installed':False,'mask_enabled':False,'actual_full_source_verified':False,'actual_fresh_stock_write_verified':False,'actual_surface_lease_verified':False,'frozen_sources_modified':False,'members':[rec(p)for p in sorted(HERE.iterdir())if p.is_file()and p.name!='SOURCE_SHA256.json'],'frozen_refs':[rec(ROOT/r)for r in sorted(b['dependencies'])],'review_artifacts':[rec(p)for p in sorted(OUT.iterdir())if p.is_file()and p.name!='.gitignore'and not p.name.startswith('host_')]};p.write_text(json.dumps(d,indent=2)+'\n');print(json.dumps({'source_sha256':rec(p)['sha256'],'members':len(d['members']),'refs':len(d['frozen_refs']),'artifacts':len(d['review_artifacts'])}))
if __name__=='__main__':main()
