#!/usr/bin/env python3
"""Freeze owned F1 UI02 source and finite static evidence; zero device use."""
from pathlib import Path
import hashlib,json,subprocess,sys,zipfile
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2];OUT=ROOT/'analysis/firmware/f1_native_ui_02'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 subprocess.run([sys.executable,str(HERE/'collect_static.py')],check=True)
 subprocess.run([sys.executable,str(HERE/'build_validate.py')],check=True)
 own=sorted(p for p in HERE.iterdir()if p.is_file())+[ROOT/'analysis/firmware/F1_NATIVE_UI_ADAPTER_02.md']
 evidence=[OUT/'.gitignore',OUT/'build_validation.json',OUT/'ui_sections.txt',OUT/'candidates_sections.txt']+sorted(p for p in (OUT/'static').iterdir()if p.is_file())
 deps=[ROOT/r for r in ['tools/target/toolchain.lock.json','tools/firmware/windows_aarch64_toolchain_01/probes.py',
  'src/core/include/iq4/image_core.hpp','src/core/lib/image_core.cpp','src/display/include/iq4/display_mask.hpp','src/display/lib/display_mask.cpp',
  'tools/firmware/f1_native_overlay_01/overlay.hpp','tools/firmware/f1_native_overlay_01/overlay.cpp','analysis/firmware/f1_native_overlay_01/manifest.json',
  'analysis/firmware/F1_NATIVE_OVERLAY_IMPLEMENTATION_01.md','analysis/firmware/F1_DISPLAY_ADAPTER.md',
  'analysis/sdk_reference/F4_UI_BOOTSTRAP_02.md','analysis/sdk_reference/f4_ui_bootstrap_static_02/exact_bytes.json','analysis/sdk_reference/f4_ui_bootstrap_static_02/manifest.json',
  'analysis/sdk_reference/F4_UI_SUPERVISION_03.md','analysis/sdk_reference/f4_ui_supervision_host_03/manifest.json','tools/firmware/f4_ui_supervision_03/bootstrap.hpp','tools/firmware/f4_ui_supervision_03/bootstrap.cpp']]
 objects=[OUT/'ui.aarch64.o',OUT/'candidates.aarch64.o']
 m=dict(schema='iq4_f1_native_ui02_freeze_v1',evidence_level='static_own_host_and_compile_only',files={str(p.relative_to(ROOT)):sha(p)for p in sorted(own+evidence)},frozen_dependencies={str(p.relative_to(ROOT)):sha(p)for p in deps},ignored_rebuildable_ET_REL={str(p.relative_to(ROOT)):sha(p)for p in objects},exact_User_input=dict(path='analysis/firmware/extracted/P1Linux_6.03.21.bin',bytes=11874544,sha256='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'),production_binding_enabled=False,device_accessed=False,vendor_code_executed=False,target_executed=False,actual_owner_and_native_menu_verified=False,actual_user_action_entry_verified=False,actual_fresh_repaint_and_disable_restore_verified=False,actual_surface_geometry_and_RAW_JPEG_isolation_verified=False,installed=False)
 mp=OUT/'manifest.json';mp.write_text(json.dumps(m,indent=2)+'\n');archive=OUT/'f1_native_ui_02_source.zip'
 with zipfile.ZipFile(archive,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9)as z:
  for p in sorted(own+evidence+deps+[mp]):
   entry=zipfile.ZipInfo(str(p.relative_to(ROOT)),date_time=(2026,10,4,0,0,0));entry.compress_type=zipfile.ZIP_DEFLATED;entry.external_attr=0o100644<<16;z.writestr(entry,p.read_bytes())
 print(json.dumps(dict(manifest_sha256=sha(mp),source_zip_sha256=sha(archive),production_binding_enabled=False,actual_acceptance=False)))
if __name__=='__main__':main()
