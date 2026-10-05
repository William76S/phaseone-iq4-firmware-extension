#!/usr/bin/env python3
"""Freeze finite F1 source/static evidence; no native/device or target execution."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import zipfile
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2]
OUT=ROOT/'analysis/firmware/f1_native_overlay_01'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    subprocess.run([sys.executable,str(HERE/'collect_static.py')],check=True)
    subprocess.run([sys.executable,str(HERE/'build_validate.py')],check=True)
    report=ROOT/'analysis/firmware/F1_NATIVE_OVERLAY_IMPLEMENTATION_01.md'
    own=sorted(p for p in HERE.iterdir() if p.is_file())+[report]
    evidence=[OUT/'.gitignore',OUT/'build_validation.json',OUT/'overlay_sections.txt',
      OUT/'Rectangle24_ABI_probe_sections.txt',OUT/'Rectangle24_ABI_probe.disasm.txt']+sorted(p for p in (OUT/'static').iterdir() if p.is_file())
    deps=[ROOT/rel for rel in ['src/core/include/iq4/image_core.hpp','src/core/lib/image_core.cpp',
      'src/display/include/iq4/display_mask.hpp','src/display/lib/display_mask.cpp','src/display/README.md',
      'tools/target/toolchain.lock.json','tools/firmware/windows_aarch64_toolchain_01/probes.py',
      'analysis/firmware/F1_DISPLAY_ADAPTER.md','analysis/firmware/F1_STATIC_EVIDENCE_SHA256.json',
      'analysis/sdk_reference/F4_UI_SUPERVISION_03.md','analysis/sdk_reference/f4_ui_supervision_host_03/manifest.json',
      'tools/firmware/f4_ui_supervision_03/bootstrap.hpp']]
    objects=[OUT/'overlay.aarch64.o',OUT/'Rectangle24_ABI_probe.aarch64.o']
    manifest=dict(schema='iq4_f1_native_overlay01_freeze_v1',evidence_level='static_own_host_and_compile_only',
      files={str(p.relative_to(ROOT)):sha(p) for p in sorted(own+evidence)},
      frozen_dependencies={str(p.relative_to(ROOT)):sha(p) for p in deps},
      ignored_rebuildable_ET_REL={str(p.relative_to(ROOT)):sha(p) for p in objects},
      exact_User_input=dict(path='analysis/firmware/extracted/P1Linux_6.03.21.bin',bytes=11874544,
       sha256='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'),
      production_binding_enabled=False,device_accessed=False,vendor_code_executed=False,target_executed=False,
      actual_native_instance_hook_or_recovery_verified=False,actual_surface_viewport_mapping_and_fresh_repaint_verified=False,
      actual_native_selector_and_disable_detach_verified=False,actual_RAW_JPEG_isolation_verified=False,installed=False)
    mp=OUT/'manifest.json';mp.write_text(json.dumps(manifest,indent=2)+'\n')
    archive=OUT/'f1_native_overlay_01_source.zip'
    with zipfile.ZipFile(archive,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9) as z:
        for p in sorted(own+evidence+deps+[mp]):
            item=zipfile.ZipInfo(str(p.relative_to(ROOT)),date_time=(2026,10,4,0,0,0))
            item.compress_type=zipfile.ZIP_DEFLATED;item.external_attr=0o100644<<16
            z.writestr(item,p.read_bytes())
    print(json.dumps(dict(manifest_sha256=sha(mp),source_zip_sha256=sha(archive),production_binding_enabled=False,actual_acceptance=False)))
if __name__=='__main__':main()
