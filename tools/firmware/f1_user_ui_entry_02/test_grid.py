#!/usr/bin/env python3
"""Owned host memory only; compile actual Binding + exact runtime finder body."""
from pathlib import Path
import subprocess,json
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2];OUT=ROOT/'analysis/firmware/f1_user_ui_entry_02'
def main():
 assert not(HERE/'SOURCE_SHA256.json').exists();OUT.mkdir(parents=True,exist_ok=True)
 t=(HERE/'runtime.cpp').read_text();a=t.index('bool free_placement(');z=t.index('\nbool select(',a)
 (OUT/'runtime_placement_fixture.inc').write_text(t[a:z]+'\n')
 sdk=subprocess.check_output(['xcrun','--show-sdk-path'],text=True).strip()
 sources=[HERE/'test_grid.cpp',HERE/'module.cpp',HERE/'entry_binding_10.cpp',HERE/'inspector.cpp',ROOT/'tools/firmware/f1_native_ui_02/candidates.cpp',ROOT/'tools/firmware/f4_ui_bootstrap_02/bootstrap.cpp',ROOT/'tools/firmware/f4_ui_counter_01/counter.cpp']
 commands=[]
 for label,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  binary=OUT/('owned_grid_'+label)
  cmd=['/usr/bin/clang++','-std=c++17','-O2','-Wall','-Wextra','-Werror','-DIQ4_F1_ENTRY10_OWNED_HOST_FIXTURE','-isystem',sdk+'/usr/include/c++/v1','-I',str(OUT),'-I',str(ROOT/'src/core/include'),'-I',str(ROOT/'src/display/include'),*flags,*map(str,sources),'-o',str(binary)]
  subprocess.run(cmd,cwd=ROOT,check=True);subprocess.run([binary],cwd=ROOT,check=True);commands.append(cmd)
 j={'owned_grid_group':1,'cases':16,'normal':'PASS','asan_ubsan':'PASS','actual_runtime_finder_body':True,'actual_Binding_clearance_body':True,'Grid_on_off_untouched':True,'other_button_overlap_retained':True,'malformed_click_longpress_subtree_rejects_bypass':True,'mode2_not_claimed':True,'target_executed':False,'original_native_calls':0,'commands':commands}
 (OUT/'OWN_GRID_CHECKS.json').write_text(json.dumps(j,indent=2)+'\n');print(json.dumps(j))
if __name__=='__main__':main()
