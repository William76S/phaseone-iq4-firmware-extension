#!/usr/bin/env python3
"""Lock only this new revision after explicit local build; never deploy."""
from pathlib import Path
import hashlib,json
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/sdk_reference/f1_module_entry_build_01'
def row(p):
    b=p.read_bytes();return {'path':str(p.relative_to(ROOT)),'bytes':len(b),'sha256':hashlib.sha256(b).hexdigest()}
def main():
    lock=HERE/'SOURCE_SHA256.json'
    if lock.exists():raise SystemExit('already frozen; do not rewrite')
    refs=[]
    for rel in ('f4_ui_bootstrap_02','f4_ui_counter_01','f1_native_ui_02','f1_native_overlay_01','f1_entry_button_ports_01'):
        refs+=sorted(p for p in (HERE.parent/rel).iterdir() if p.suffix in ('.cpp','.hpp','.h') or p.name=='SOURCE_SHA256.json')
    refs+=[ROOT/'tools/firmware/f4_ram_entry_02/entry.c',ROOT/'tools/firmware/f4_ram_entry_02/marker.c',ROOT/'tools/firmware/f4_ram_entry_02/generate.py',ROOT/'tools/firmware/f4_ram_entry_02/config.preview.h',ROOT/'tools/target/toolchain.lock.json',ROOT/'analysis/sdk_reference/f1_entry_menu_candidate_01/SOURCE_SHA256.json']
    for rel in ('src/core','src/display'):refs+=sorted(p for p in (ROOT/rel).rglob('*') if p.is_file() and p.suffix in ('.h','.hpp','.cpp'))
    members=sorted(p for p in HERE.iterdir() if p.is_file() and p.name!='SOURCE_SHA256.json')
    members+=[ROOT/'analysis/sdk_reference/F1_MODULE_ENTRY_IMPLEMENTATION_01.md']
    members+=sorted(p for p in OUT.iterdir() if p.suffix in ('.json','.txt'))
    so=OUT/'libiq4_f1_entry_observe_01.so';report=json.loads((OUT/'BUILD_VALIDATION.json').read_text());assert report['target_SO']['sha256']==row(so)['sha256']
    m={'schema':'iq4_f1_module_entry_source_lock_01','stage':'observe_only','camera_access':False,'SDK_started':False,'target_loaded':False,'installer_emitted':False,'members':[row(p) for p in members],'frozen_refs':[row(p) for p in sorted(set(refs))],'target_SO':row(so)}
    lock.write_text(json.dumps(m,indent=2)+'\n');print(json.dumps(row(lock)))
if __name__=='__main__':main()
