#!/usr/bin/env python3
"""Reproduce own host tests/ET_REL, freeze finite public source and evidence."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import zipfile
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2];OUT=ROOT/'analysis/firmware/f4_native_page_bridge_01'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def dump(p,j):p.write_text(json.dumps(j,indent=2)+'\n')
def main():
    subprocess.run([sys.executable,str(HERE/'build_validate.py')],check=True)
    report=ROOT/'analysis/firmware/F4_NATIVE_PAGE_BRIDGE_IMPLEMENTATION_01.md'
    sources=[p for p in HERE.iterdir() if p.is_file()]+[report]
    evidence=[OUT/'.gitignore',OUT/'build_validation.json',OUT/'target_sections.txt']
    deps=[ROOT/'src/runtime/recording.hpp',ROOT/'src/runtime/recording.cpp',ROOT/'src/runtime/README.md',
      ROOT/'tools/target/toolchain.lock.json',ROOT/'tools/firmware/windows_aarch64_toolchain_01/probes.py',
      ROOT/'analysis/firmware/F4_NATIVE_UI.md',ROOT/'analysis/firmware/F4_UI_STATIC_EVIDENCE_SHA256.json',ROOT/'analysis/firmware/f4_ui_static/exact_bytes.json',
      ROOT/'analysis/firmware/F1_DISPLAY_ADAPTER.md',ROOT/'analysis/sdk_reference/F4_UI_SUPERVISION_03.md',
      ROOT/'analysis/sdk_reference/f4_ui_supervision_host_03/manifest.json',ROOT/'tools/firmware/f4_ui_supervision_03/bootstrap.hpp',
      ROOT/'analysis/firmware/f4_owned_copy_pool_01/build_validation.json']
    m={'schema':'iq4_f4_native_page_bridge01_freeze_v1','evidence_level':'static_reuse_own_host_and_cross_compile_only',
      'files':{str(p.relative_to(ROOT)):sha(p) for p in sorted(sources+evidence)},
      'frozen_dependencies':{str(p.relative_to(ROOT)):sha(p) for p in deps},
      'ignored_rebuildable_ET_REL':{str((OUT/'page_bridge.aarch64.o').relative_to(ROOT)):sha(OUT/'page_bridge.aarch64.o')},
      'production_native_binding_enabled':False,'device_accessed':False,'vendor_code_executed':False,'target_executed':False,
      'actual_native_page_verified':False,'actual_card_lease_worker_mode_verified':False,'actual_1080p60_verified':False,'installed':False}
    dump(OUT/'manifest.json',m)
    package=OUT/'f4_native_page_bridge_01_source.zip'
    with zipfile.ZipFile(package,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9) as z:
        for p in sorted(sources+evidence+[OUT/'manifest.json',ROOT/'src/runtime/recording.hpp',ROOT/'src/runtime/recording.cpp']):
            info=zipfile.ZipInfo(str(p.relative_to(ROOT)),date_time=(2026,10,4,0,0,0));info.compress_type=zipfile.ZIP_DEFLATED;info.external_attr=0o100644<<16;z.writestr(info,p.read_bytes())
    print(json.dumps({'manifest_sha256':sha(OUT/'manifest.json'),'source_zip_sha256':sha(package),'actual_acceptance':False}))
if __name__=='__main__':main()
