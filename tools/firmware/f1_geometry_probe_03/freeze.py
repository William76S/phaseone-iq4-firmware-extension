#!/usr/bin/env python3
"""Freeze finite F1 read-only observation source; no device or target execution."""
from pathlib import Path
import hashlib,json,subprocess,sys,zipfile
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2];OUT=ROOT/'analysis/firmware/f1_geometry_probe_03'
DOC=ROOT/'analysis/firmware/F1_GEOMETRY_PAINT_OBSERVATION_03.md'
DEPENDENCIES=[
 'tools/target/toolchain.lock.json','tools/firmware/windows_aarch64_toolchain_01/probes.py',
 'src/core/include/iq4/image_core.hpp','src/core/lib/image_core.cpp',
 'src/display/include/iq4/display_mask.hpp','src/display/lib/display_mask.cpp',
 'tools/firmware/f1_native_ui_02/ui.hpp','tools/firmware/f1_native_ui_02/ui.cpp',
 'analysis/firmware/f1_native_ui_02/manifest.json','analysis/firmware/f1_native_ui_02/static/exact_bytes.json',
 'analysis/firmware/F1_NATIVE_UI_ADAPTER_02.md',
 'tools/firmware/f1_native_overlay_01/overlay.hpp','tools/firmware/f1_native_overlay_01/overlay.cpp',
 'analysis/firmware/f1_native_overlay_01/manifest.json','analysis/firmware/F1_NATIVE_OVERLAY_IMPLEMENTATION_01.md']
FALSE_FIELDS=['production_overlay_enabled','device_accessed','vendor_code_executed','target_executed',
 'actual_runtime_User_verified','actual_geometry_mapping_verified','actual_fresh_blit_verified','actual_surface_lease_verified','installed']
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 subprocess.run([sys.executable,'-B',str(HERE/'collect_static.py')],check=True)
 subprocess.run([sys.executable,'-B',str(HERE/'build_validate.py')],check=True)
 own=sorted(p for p in HERE.iterdir()if p.is_file())+[DOC]
 evidence=[OUT/'.gitignore',OUT/'build_validation.json',OUT/'probe_sections.txt']+sorted(p for p in (OUT/'static').iterdir()if p.is_file())
 deps=[ROOT/p for p in DEPENDENCIES];objects=[OUT/'probe.aarch64.o',OUT/'probe_link_only.aarch64.so']+sorted(OUT.glob('*_dependency.aarch64.o'))
 m=dict(schema='iq4_f1_geometry_paint03_freeze_v1',evidence_level='static_own_host_and_compile_only',
  files={str(p.relative_to(ROOT)):sha(p)for p in sorted(own+evidence)},
  frozen_dependencies={str(p.relative_to(ROOT)):sha(p)for p in deps},
  ignored_rebuildable_target_artifacts={str(p.relative_to(ROOT)):sha(p)for p in objects},
  exact_User_input=dict(path='analysis/firmware/extracted/P1Linux_6.03.21.bin',bytes=11874544,sha256='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'),
  entry_scope='bounded read-only own port; no native calls, interpose, installer or enabled geometry/fresh port',
  **{k:False for k in FALSE_FIELDS})
 mp=OUT/'manifest.json';mp.write_text(json.dumps(m,indent=2)+'\n');archive=OUT/'f1_geometry_probe_03_source.zip'
 with zipfile.ZipFile(archive,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9)as z:
  for p in sorted(own+evidence+deps+[mp]):
   zi=zipfile.ZipInfo(str(p.relative_to(ROOT)),date_time=(2026,10,4,0,0,0));zi.compress_type=zipfile.ZIP_DEFLATED;zi.external_attr=0o100644<<16;z.writestr(zi,p.read_bytes())
 print(json.dumps(dict(manifest_sha256=sha(mp),source_zip_sha256=sha(archive),production_overlay_enabled=False,actual_acceptance=False)))
if __name__=='__main__':main()
