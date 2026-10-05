#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,sys
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/f3_native_storage_bridge_01';BUILD=OUT/'build'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def emit(p,v):p.write_text(json.dumps(v,indent=2)+'\n')
def main():
 if '--verify' in sys.argv:
  lock=json.loads((HERE/'SOURCE_SHA256.json').read_text());assert all(row(ROOT/r['path'])==r for r in lock['files']);link=json.loads((HERE/'LINK_INPUT.json').read_text());assert row(ROOT/link['source']['path'])==link['source'];assert all(row(ROOT/r['path'])==r for r in link['objects']);print(len(lock['files']),'frozen rows and four objects verified');return
 build=json.loads((BUILD/'BUILD.json').read_text());assert build['normal_process_cases']==build['san_process_cases']==25 and build['pthread_interleavings_each']==300 and build['actual_A64_wrapper_cases']==108 and build['reproducible'];assert all(c['exit']==0 for c in json.loads((BUILD/'COMMANDS.json').read_text()))
 files={p for p in HERE.iterdir()if p.is_file()and p.name not in ['SOURCE_SHA256.json','LINK_INPUT.json']}
 files|={p for p in OUT.iterdir()if p.suffix in ['.json','.asm','.md']}
 files|={BUILD/'BUILD.json',BUILD/'COMMANDS.json',BUILD/'storage_wrappers.eh_frame.txt'}
 for obj in build['objects']:
  p=ROOT/obj['path'];files|={p,Path(str(p)+'.repeat'),Path(str(p)+'.d'),Path(str(p)+'.repeat.d'),Path(str(p)+'.asm')}
  for t in Path(str(p)+'.d').read_text().replace('\\\n',' ').split()[1:]:
   f=Path(t).resolve()
   if f.is_file()and f.is_relative_to(ROOT):files.add(f)
 files|={ROOT/'tools/firmware'/x for x in ['f3_capture_menu_08/policy.c','native_activity_01/activity.c','inspect_boot.py']}
 files|={ROOT/'src/codec'/x for x in ['export_geometry.c','export_geometry.h']}
 emit(HERE/'SOURCE_SHA256.json',dict(schema='iq4_native_storage_bridge_source_01',files=[row(p)for p in sorted(files)],target_executed=False,camera_accessed=False))
 exact=json.loads((OUT/'EXACT.json').read_text())
 emit(HERE/'LINK_INPUT.json',dict(schema='iq4_native_storage_bridge_link_01',source=row(HERE/'SOURCE_SHA256.json'),objects=build['objects'],BL_hooks=[x for x in exact['hooks']if x['branch_kind']=='BL'],auxiliary_hooks=[x for x in exact['hooks']if x['branch_kind']=='B'],required_functions=['iq4_f3_native_mode_set_on_ui_01','iq4_f3_native_storage_mutex_initialize_01','iq4_f3_storage_output_child_01','iq4_f3_legacy_jpeg_disabled_01','iq4_f3_storage_ui_set_return_01','iq4_f3_storage_enter_01','iq4_f3_storage_leave_01'],aliases=[],initialization_success_stage=100,initializer_required_stage45=True,requires_native_size_menu_02=True,target_executed=False))
 print(json.dumps(dict(source=row(HERE/'SOURCE_SHA256.json'),link=row(HERE/'LINK_INPUT.json'),objects=build['objects'])))
if __name__=='__main__':main()
