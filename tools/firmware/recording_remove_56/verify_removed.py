#!/usr/bin/env python3
"""Prove removal, original pop restoration and unchanged55 feature objects."""
import argparse,hashlib,importlib.util,json,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
def row(p):
 p=Path(p);p=(ROOT/p).resolve()if not p.is_absolute()else p.resolve();b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 p=argparse.ArgumentParser();p.add_argument('--build',type=Path,required=True);p.add_argument('--removal',type=Path,required=True);a=p.parse_args();out=a.build.resolve();j=json.loads((out/'BUILD.json').read_text());r=json.loads(a.removal.read_text());s=json.loads((ROOT/j['spec']['path']).read_text());rep=json.loads((ROOT/j['link_report']['path']).read_text());own=set(rep['own_symbols']);ui=set(r['shared_UI_exports'])
 assert {n for n in own if n.startswith(('iq4_f4_','f4_movie_','iq4_mkv_'))}==ui
 assert all(n not in own for n in r['removed_required_exports']);assert len(s['objects'])==42 and j['object_count']==44 and s['expected_hook_count']==54
 assert not any(h['va']==0x4fb454 for h in s['BL_hooks']+s['auxiliary_hooks']);assert all(x not in s['objects']for x in r['removed_objects'])
 assert r['shared_native_JPEG_codec_retained']in s['objects']and r['shared_RTTI_retained']in s['objects']
 loader=importlib.util.spec_from_file_location('removed56_elf',ROOT/'tools/firmware/f1_user_elf_append_03/elf_append.py');m=importlib.util.module_from_spec(loader);sys.modules[loader.name]=m;loader.loader.exec_module(m);u=m.Elf((ROOT/j['User']['path']).read_bytes(),2);o=m.Elf((ROOT/j['stock']['path']).read_bytes(),2)
 assert u.data[u.va_offset(0x4fb454,4):u.va_offset(0x4fb454,4)+4]==bytes.fromhex('14b2ff97')
 hits=[]
 for i,name in enumerate(u.names):
  if name.startswith('.f1.')and b'LV Recording' in u.section_bytes(i):hits.append(name)
 assert not hits,hits
 base=json.loads((ROOT/r['base']['path']).read_text());kept=[v for v in base['objects']if v not in r['removed_objects']];assert len(kept)==40;assert all(v in s['objects']and row(v['path'])==v for v in kept)
 # The new LV wrapper must contain only the one F1 helper call and original
 # SetMenu tail, never the removed recording entry. Check its real relocation.
 import subprocess
 wrapper=next(v for v in s['objects']if v['path'].endswith('/lv_settings_wrapper.o'))
 text=subprocess.check_output(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','--undefined-only','--format=posix',str(ROOT/wrapper['path'])],text=True);uses={line.split()[0]for line in text.splitlines()if line.split()};assert uses=={'iq4_f1_before_native_menu_04','iq4_stock_menu_set_01'},uses
 result=dict(schema='iq4_recording_removed_actual_User_56',User=j['User'],removal=row(a.removal),objects=j['object_count'],hooks=54,removed_object_count=22,unchanged55_feature_objects=40,recording_page_source_session_movie_exports_absent=True,only_four_shared_native_UI_compatibility_names_retained=sorted(ui),original_pop_bytes_restored=True,LV_Recording_text_absent_from_appended_sections=True,Ratio_only_LV_wrapper_actual_undefined_calls=sorted(uses),RTTI_and_native_JPEG_codec_retained=True,camera_accessed=False,hardware_accepted=False)
 (out/'RECORDING_REMOVAL_CHECK.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result))
if __name__=='__main__':main()
