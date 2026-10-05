#!/usr/bin/env python3
from pathlib import Path
import hashlib,json
from build_prepare import ROOT,HERE,OUT
def rec(p):return {'path':str(p.relative_to(ROOT)),'bytes':p.stat().st_size,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()}
def main():
 p=HERE/'SOURCE_SHA256.json';assert not p.exists()
 b=json.loads((OUT/'BUILD_PREPARATION.json').read_text());t=json.loads((OUT/'LOCAL_CHECKS.json').read_text());assert t['passed']and t['groups']==6 and b['prep_only']and b['deployment_commands']==[]and b['embedded_controller']
 f=json.loads((OUT/'FORMATTER_CHECKS.json').read_text());assert len(f['golden_vectors'])==9 and f['python_cpp_equal']and not f['SDK_loaded']and not b['enabled_target_built_in_this_stage']and not b['installable']
 refs=set(b['dependencies'])|set(f['source_closure'])|{'tools/target/toolchain.lock.json','tools/firmware/f4_ram_entry_02/generate.py','tools/firmware/f4_ram_entry_02/sha256.h','tools/firmware/f4_ram_entry_01/readonly_monitor.c','tools/firmware/inspect_boot.py'}
 artifacts=[p for p in sorted(OUT.rglob('*'))if p.is_file()and p.name!='.gitignore'and p.suffix!='.o'and not p.name.startswith('host_')]
 d={'schema':11,'public_ABI':10,'stage':'offline_default_disabled_embedded_tracer_loader11_source_preparation','BindingHold_fixed_in_new_module':True,'final_device_candidate':False,'installable':False,'target_executed':False,'target_loaded':False,'UI_entry_installed':False,'mask_enabled':False,'native_text_hook_installed':False,'frozen_sources_modified':False,'members':[rec(p)for p in sorted(HERE.iterdir())if p.is_file()and p.name!='SOURCE_SHA256.json'],'frozen_refs':[rec(ROOT/r)for r in sorted(refs)],'review_artifacts':[rec(p)for p in artifacts]}
 p.write_text(json.dumps(d,indent=2)+'\n');print(json.dumps({'source_sha256':rec(p)['sha256'],'members':len(d['members']),'refs':len(d['frozen_refs']),'artifacts':len(d['review_artifacts'])}))
if __name__=='__main__':main()
