#!/usr/bin/env python3
from pathlib import Path
import subprocess,json
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2];OUT=ROOT/'analysis/firmware/f1_user_ui_entry_01'
def main():
 OUT.mkdir(parents=True,exist_ok=True);sdk=subprocess.check_output(['xcrun','--show-sdk-path'],text=True).strip();binary=OUT/'owned_cap_fixture'
 sources=[HERE/'test_cap.cpp',HERE/'module.cpp',HERE/'entry_binding_10.cpp',HERE/'inspector.cpp',ROOT/'tools/firmware/f1_native_ui_02/candidates.cpp',ROOT/'tools/firmware/f4_ui_bootstrap_02/bootstrap.cpp',ROOT/'tools/firmware/f4_ui_counter_01/counter.cpp']
 cmd=['/usr/bin/clang++','-std=c++17','-O2','-Wall','-Wextra','-Werror','-DIQ4_F1_ENTRY10_OWNED_HOST_FIXTURE','-isystem',sdk+'/usr/include/c++/v1','-I',str(ROOT/'src/core/include'),'-I',str(ROOT/'src/display/include'),*map(str,sources),'-o',str(binary)]
 subprocess.run(cmd,cwd=ROOT,check=True);subprocess.run([binary],cwd=ROOT,check=True)
 out={'owned_host_cap_group':1,'new_firmware_Module_and_Binding_compiled':True,'cap_stopped_Module_port_zero':True,'captured_Binding_port_after_cap_valid':True,'captured_Hold_and_DetachedRetained_reject':True,'wrong_TLS_reject':True,'target_executed':False,'original_native_calls':0,'compile':cmd}
 (OUT/'OWN_CAP_CHECKS.json').write_text(json.dumps(out,indent=2)+'\n');print(json.dumps(out))
if __name__=='__main__':main()
