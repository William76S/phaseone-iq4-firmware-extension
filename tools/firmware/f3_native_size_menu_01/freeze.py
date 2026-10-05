#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,sys
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/f3_native_size_menu_01';BUILD=OUT/'build'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def emit(p,j):p.write_text(json.dumps(j,indent=2)+'\n')
def main():
 if '--verify' in sys.argv:
  j=json.loads((HERE/'SOURCE_SHA256.json').read_text());assert all(row(ROOT/r['path'])==r for r in j['files']);print(len(j['files']),'verified');return
 b=json.loads((BUILD/'BUILD.json').read_text());assert b['normal_cases']==b['san_cases']==28 and b['same_target_recompiled'];assert all(c['exit']==0 for c in json.loads((BUILD/'COMMANDS.json').read_text()))
 files={p for p in HERE.iterdir() if p.is_file() and p.name not in ['SOURCE_SHA256.json','LINK_INPUT.json']}
 files|={BUILD/n for n in ['BUILD.json','COMMANDS.json','size_menu.o','size_menu_repeat.o','size_menu.o.d','size_menu_repeat.o.d','size_menu.asm']}
 files|={OUT/'EXACT.json'}
 files|={ROOT/'tools/firmware'/n for n in ['f3_capture_menu_06/policy.c','f3_capture_menu_06/policy.h','f3_capture_menu_04/policy.h','native_activity_01/activity.h','f4_native_menu_03/native_calls.h','f4_native_source_02/native_calls.h','native_runtime_01/self_read.h']}
 files|={ROOT/'src/codec'/n for n in ['export_geometry.c','export_geometry.h']}
 files|={ROOT/'analysis/firmware/f3_native_save_settings_static_01'/n for n in ['REVIEW.md','storage_setup_construction.asm','size_dto_activate.asm','jpeg_size_event_get_set.asm','tables.json']}
 emit(HERE/'SOURCE_SHA256.json',dict(schema='iq4_native_storage_size_menu_source_01',files=[row(p)for p in sorted(files)],target_executed=False,camera_accessed=False))
 exact=json.loads((OUT/'EXACT.json').read_text());emit(HERE/'LINK_INPUT.json',dict(schema='iq4_native_storage_size_menu_link_01',source=row(HERE/'SOURCE_SHA256.json'),objects=[b['object']],BL_hooks=[exact['BL_hook']],required_functions=['iq4_f3_storage_size_child_01'],aliases=[],original_JPEG_worker_unification_required=True,target_executed=False))
 print(json.dumps(dict(source=row(HERE/'SOURCE_SHA256.json'),link=row(HERE/'LINK_INPUT.json'),object=b['object'])))
if __name__=='__main__':main()
