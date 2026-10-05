#!/usr/bin/env python3
from pathlib import Path
import hashlib,json
from derive_runtime import ROOT,HERE
OUT=ROOT/'analysis/firmware/f1_native_entry_binding_build_07'
def rec(p):return {'path':str(p.relative_to(ROOT)),'bytes':p.stat().st_size,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()}
def main():
 p=HERE/'SOURCE_SHA256.json';assert not p.exists(),'Frozen source cannot be rewritten'
 b=json.loads((OUT/'BUILD_VALIDATION.json').read_text());assert b['tests']['normal']['groups']==b['tests']['asan_ubsan']['groups']==10 and b['decoder']['checks']==15
 refs=set(b['dependencies'])|{'tools/target/toolchain.lock.json','analysis/firmware/P1_ramdisk.ext2','analysis/firmware/f4_ui_static/event_kind_pointer.disasm.txt','analysis/firmware/f4_ui_static/control_pointer_down_up.disasm.txt','analysis/sdk_reference/f1_entry_menu_candidate_01/SOURCE_SHA256.json','analysis/firmware/f1_native_ui_02/static/Selector_ctor_complete.txt','analysis/firmware/f1_native_ui_02/static/Navigator_ctor.txt','analysis/firmware/f1_native_ui_02/static/Navigator_setmenu.txt'}
 d={'schema':7,'stage':'offline_native_entry_source_preparation','device_or_SDK_or_Windows_or_network_used':False,'target_loaded':False,'UI_installed':False,'mask_enabled':False,'full_source_mapping_verified':False,'fresh_stock_blit_verified':False,'surface_lease_verified':False,'frozen_sources_modified':False,'members':[rec(p)for p in sorted(HERE.iterdir())if p.is_file()and p.name!='SOURCE_SHA256.json'],'frozen_refs':[rec(ROOT/p)for p in sorted(refs)],'review_artifacts':[rec(p)for p in sorted(OUT.iterdir())if p.is_file()and p.name!='.gitignore'and not p.name.startswith('host_')]};p.write_text(json.dumps(d,indent=2)+'\n');print(json.dumps({'source_sha256':rec(p)['sha256'],'members':len(d['members']),'frozen_refs':len(d['frozen_refs']),'artifacts':len(d['review_artifacts'])}))
if __name__=='__main__':main()
