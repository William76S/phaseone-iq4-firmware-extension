#!/usr/bin/env python3
from pathlib import Path
import hashlib,json
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f1_display_observe_build_06'
def rec(p):return {'path':str(p.relative_to(ROOT)),'bytes':p.stat().st_size,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()}
def main():
    target=HERE/'SOURCE_SHA256.json';assert not target.exists(),'frozen source cannot be rewritten'
    build=json.loads((OUT/'BUILD_VALIDATION.json').read_text());assert build['tests']['normal']['groups']==build['tests']['asan_ubsan']['groups']==21
    assert build['publication_layout_proof']['all_target_sizeof_offsets_equal_host'] and build['actual_original_forward_blr_count']==1
    assert not any(build[k]for k in ('production_mask_enabled','full_source_mapping_verified','fresh_blit_verified','surface_lease_verified','device_or_SDK_or_Windows_or_network_used'))
    refs=set(build['dependencies'])|{'analysis/sdk_reference/f1_observe_stack_build_05/BUILD_VALIDATION.json','analysis/firmware/f1_native_overlay_01/static/exact_bytes.json','analysis/firmware/f1_geometry_probe_03/static/exact_bytes.json','tools/target/toolchain.lock.json'}
    members=[p for p in HERE.iterdir()if p.is_file()and p.name!='SOURCE_SHA256.json'];artifacts=[p for p in OUT.iterdir()if p.is_file()and p.suffix in('.json','.txt','.so','.o')]
    doc={'schema':6,'stage':'offline_source_host_owned_tests_target_compile_only','camera_access':False,'SDK_started':False,'Windows_or_network_used':False,'target_loaded':False,'paint_installed':False,'mask_enabled':False,'full_source_mapping_verified':False,'fresh_blit_verified':False,'surface_lease_verified':False,'frozen_sources_modified':False,'members':[rec(p)for p in sorted(members)],'frozen_refs':[rec(ROOT/p)for p in sorted(refs)],'review_artifacts':[rec(p)for p in sorted(artifacts)]}
    target.write_text(json.dumps(doc,ensure_ascii=False,indent=2)+'\n');print(json.dumps({'source_sha256':rec(target)['sha256'],'members':len(members),'frozen_refs':len(refs),'artifacts':len(artifacts)}))
if __name__=='__main__':main()
