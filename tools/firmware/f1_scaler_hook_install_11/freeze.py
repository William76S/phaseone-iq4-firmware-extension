#!/usr/bin/env python3
"""Freeze new11 only. Parent10 and all previous records remain unchanged."""
import hashlib,json
from build_prepare import ROOT,HERE,OUT
def rec(p):return {'path':str(p.relative_to(ROOT)),'bytes':p.stat().st_size,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()}
def main():
 p=HERE/'SOURCE_SHA256.json';assert not p.exists()
 b=json.loads((OUT/'BUILD_PREPARATION.json').read_bytes())
 assert b['schema']==11 and b['public_ABI']==10
 assert b['parent_source_sha256']=='5793c044638b7f88a8fabae547b2b56b5c6ce17ac02c1ff23551a9048ed68b1e'
 assert set(b['tests'])=={'persistent_normal','persistent_asan_ubsan'}
 assert all(r['groups']==3 for r in b['tests'].values())
 assert b['captured_Hold_and_DetachedRetained_rejected']and b['old_transaction_tests_reused_not_rerun']
 assert b['real_live_UI_preparation_caller_linked']and b['persistent_TLS_listener_ports_linked']and b['original_64_observation_cap_preserved']
 assert not any(b[k]for k in('actual_Root_input_received','runtime_kernel_match_verified','target_loaded','UI_installed','target_stopped','target_text_written','actual_provider_lease_verified','actual_full_source_verified','actual_stock_write_verified','mask_enabled','device_SDK_Windows_network_operations'))
 refs=set(b['dependencies'])|{'tools/target/toolchain.lock.json','tools/firmware/f1_entry_loader_binding_07/strip_elf.py','tools/firmware/f4_ui_bootstrap_02/build_validate.py','tools/firmware/f4_ui_bootstrap_02/sha256.h','analysis/firmware/f1_entry_observe_independent_review_08/collect.py'}
 d={'schema':11,'public_ABI':10,'stage':'offline_captured_persistent_Hold_state_fix',
    'parent_source_sha256':b['parent_source_sha256'],'captured_Hold_and_DetachedRetained_rejected':True,
    'original_64_observation_cap_preserved':True,'target_loaded':False,'UI_installed':False,
    'target_text_written':False,'actual_full_source_verified':False,'actual_stock_write_verified':False,
    'actual_surface_lease_verified':False,'mask_enabled':False,'frozen_sources_modified':False,
    'members':[rec(f)for f in sorted(HERE.iterdir())if f.is_file()and f.name!='SOURCE_SHA256.json'],
    'frozen_refs':[rec(ROOT/r)for r in sorted(refs)],
    'review_artifacts':[rec(f)for f in sorted(OUT.iterdir())if f.is_file()and f.name!='.gitignore'and not f.name.startswith('host_')]}
 p.write_text(json.dumps(d,indent=2)+'\n');print(json.dumps({'source':rec(p),'rows':sum(len(d[k])for k in('members','frozen_refs','review_artifacts'))}))
if __name__=='__main__':main()
