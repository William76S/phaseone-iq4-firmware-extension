#!/usr/bin/env python3
from pathlib import Path
import hashlib,json
from build_prepare import ROOT,HERE,OUT
def rec(p):return {'path':str(p.relative_to(ROOT)),'bytes':p.stat().st_size,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()}
def main():
 p=HERE/'SOURCE_SHA256.json';assert not p.exists(),'Frozen source cannot be rewritten'
 b=json.loads((OUT/'BUILD_PREPARATION.json').read_text());t=json.loads((OUT/'LOCAL_CHECKS.json').read_text());assert t['passed']and len(t['checks'])==18 and b['prep_only']and b['deployment_commands']==[]
 refs=set(b['dependencies'])|{'tools/target/toolchain.lock.json','tools/firmware/f4_ram_entry_02/generate.py','tools/firmware/f4_ram_entry_02/config.preview.h','tools/firmware/f4_ram_entry_02/sha256.h','tools/firmware/f4_ram_entry_01/readonly_monitor.c','analysis/firmware/P1_ramdisk.ext2','analysis/firmware/f1_display_observe_build_06/host_normal_fixture.bin'}
 artifacts=[p for p in OUT.iterdir()if p.is_file()and p.name!='.gitignore'and p.stat().st_size>0]
 d={'schema':6,'stage':'offline_display_loader_source_preparation','device_or_SDK_or_Windows_or_network_used':False,'target_executed':False,'mask_enabled':False,'paint_installed':False,'UI_entry_installed':False,'frozen_sources_modified':False,'members':[rec(p)for p in sorted(HERE.iterdir())if p.is_file()and p.name!='SOURCE_SHA256.json'],'frozen_refs':[rec(ROOT/p)for p in sorted(refs)],'review_artifacts':[rec(p)for p in sorted(artifacts)]};p.write_text(json.dumps(d,indent=2)+'\n');print(json.dumps({'source_sha256':rec(p)['sha256'],'members':len(d['members']),'frozen_refs':len(d['frozen_refs']),'artifacts':len(d['review_artifacts'])}))
if __name__=='__main__':main()
