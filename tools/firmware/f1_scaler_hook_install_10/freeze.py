#!/usr/bin/env python3
import hashlib,json
from build_prepare import ROOT,HERE,OUT
def rec(p):return {'path':str(p.relative_to(ROOT)),'bytes':p.stat().st_size,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()}
def main():
 p=HERE/'SOURCE_SHA256.json';assert not p.exists()
 b=json.loads((OUT/'BUILD_PREPARATION.json').read_text())
 assert b['tests']['transaction_normal']['groups']==b['tests']['transaction_asan_ubsan']['groups']==8
 assert b['tests']['persistent_normal']['groups']==b['tests']['persistent_asan_ubsan']['groups']==1
 assert b['real_live_UI_preparation_caller_linked']and b['persistent_TLS_listener_ports_linked']and b['original_64_observation_cap_preserved']
 assert not any(b[k]for k in('actual_Root_input_received','runtime_kernel_match_verified','target_loaded','UI_installed','target_stopped','target_text_written','actual_provider_lease_verified','actual_full_source_verified','actual_stock_write_verified','mask_enabled','device_SDK_Windows_network_operations'))
 refs=set(b['dependencies'])|{'tools/target/toolchain.lock.json','tools/firmware/f1_entry_loader_binding_07/strip_elf.py','tools/firmware/f4_ui_bootstrap_02/build_validate.py','tools/firmware/f4_ui_bootstrap_02/sha256.h'}
 d={'schema':10,'stage':'offline_production_live_UI_preparer_external_tracer','real_live_UI_preparer_linked':True,'persistent_ports_linked':True,'target_loaded':False,'UI_installed':False,'target_text_written':False,'actual_full_source_verified':False,'actual_stock_write_verified':False,'actual_surface_lease_verified':False,'mask_enabled':False,'frozen_sources_modified':False,'members':[rec(p)for p in sorted(HERE.iterdir())if p.is_file()and p.name!='SOURCE_SHA256.json'],'frozen_refs':[rec(ROOT/r)for r in sorted(refs)],'review_artifacts':[rec(p)for p in sorted(OUT.iterdir())if p.is_file()and p.name!='.gitignore'and not p.name.startswith('host_')]}
 p.write_text(json.dumps(d,indent=2)+'\n');print(json.dumps({'source_sha256':rec(p)['sha256'],'members':len(d['members']),'refs':len(d['frozen_refs']),'artifacts':len(d['review_artifacts'])}))
if __name__=='__main__':main()
