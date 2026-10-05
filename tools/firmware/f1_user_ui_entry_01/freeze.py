#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,shlex
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/f1_user_ui_entry_01'
def rec(p):return {'path':str(p.relative_to(ROOT)),'bytes':p.stat().st_size,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()}
def main():
 manifest=HERE/'SOURCE_SHA256.json';assert not manifest.exists()
 deps={ROOT/'tools/target/toolchain.lock.json',ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig',ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin',ROOT/'analysis/firmware/P1_ramdisk.ext2',ROOT/'tools/firmware/inspect_boot.py',ROOT/'tools/firmware/f1_scaler_hook_install_11/SOURCE_SHA256.json',ROOT/'tools/firmware/f1_user_elf_integration_12/inspect.py'}
 for d in OUT.glob('*.d'):
  text=d.read_text().replace('\\\n',' ');tail=text.split(':',1)[1]
  for name in shlex.split(tail):
   p=Path(name);p=p if p.is_absolute()else ROOT/p
   assert p.is_file(),p
   if p.resolve().is_relative_to(ROOT):deps.add(p.resolve())
 sources=[p for p in sorted(HERE.iterdir())if p.is_file()and p!=manifest]
 for p in sources:deps.discard(p)
 objects=json.loads((OUT/'OBJECTS_AND_BINDINGS.json').read_text());assert objects['unbound_object_symbols_before_final_GC']==['_ZSt9terminatev']
 j={'schema':1,'stage':'offline_real_firmware_UI_ET_REL_source_not_installed','members':[rec(p)for p in sources],'frozen_refs':[rec(p)for p in sorted(deps)],'review_artifacts':[rec(p)for p in sorted(OUT.iterdir())if p.is_file()],'default_requested_mode':0,'shared_state_bytes':64,'UI_installed':False,'target_executed':False,'firmware_generated':False,'five_masks_available':False,'SDK_Windows_network_device_operations':0}
 manifest.write_text(json.dumps(j,indent=2)+'\n')
 for group in ('members','frozen_refs','review_artifacts'):
  for x in j[group]:assert rec(ROOT/x['path'])==x
 print(json.dumps({'source_sha256':rec(manifest)['sha256'],'members':len(j['members']),'refs':len(j['frozen_refs']),'artifacts':len(j['review_artifacts']),'target_executed':False}))
if __name__=='__main__':main()
