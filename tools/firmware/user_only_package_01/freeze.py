#!/usr/bin/env python3
"""Freeze public derivative source/evidence only; no original or candidate ELF."""
import hashlib
import io
import json
from pathlib import Path
import zipfile

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
def sha(b): return hashlib.sha256(b).hexdigest()

def members():
    paths = list(HERE.glob('*.py')) + [HERE/'README.md',
        ROOT/'tools/firmware/firmware_package_acceptance_collect_static_01.py',
        ROOT/'analysis/firmware/FIRMWARE_PACKAGE_ACCEPTANCE_STATIC_01.md',
        ROOT/'analysis/firmware/firmware_package_acceptance_static_01/targets.txt',
        ROOT/'analysis/firmware/firmware_package_acceptance_static_01/README.md']
    paths += list((ROOT/'analysis/firmware/firmware_package_acceptance_static_01/evidence').glob('*'))
    return sorted(set(paths))

def main():
    files = {str(p.relative_to(ROOT)): {'bytes':p.stat().st_size,'sha256':sha(p.read_bytes())}
             for p in members() if p.is_file()}
    value={'schema':'iq4_user_only_package_source_manifest_v1','evidence_level':'offline_static_and_host_only',
        'files':files,'candidate_or_original_payload_included':False,
        'firmware_or_SDK_executed':False,'camera_accessed':False,'device_changed':False,
        'device_acceptance_or_recovery_verified':False,'F1_binary_implemented_here':False}
    manifest=HERE/'SOURCE_SHA256.json'
    manifest.write_text(json.dumps(value,indent=2)+'\n')
    out=io.BytesIO()
    with zipfile.ZipFile(out,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9) as z:
        for rel in sorted([*files,str(manifest.relative_to(ROOT))]):
            p=ROOT/rel
            if p.suffix not in ('.py','.md','.json','.txt','.xml'):
                raise ValueError('unexpected source member extension')
            info=zipfile.ZipInfo(rel,(1980,1,1,0,0,0));info.compress_type=zipfile.ZIP_DEFLATED
            info.external_attr=0o100644<<16
            z.writestr(info,p.read_bytes(),compress_type=zipfile.ZIP_DEFLATED,compresslevel=9)
    directory=ROOT/'build/user_only_package_source_01';directory.mkdir(parents=True,exist_ok=True)
    archive=directory/'IQ4_User_Only_Package_Source_01.zip';archive.write_bytes(out.getvalue())
    receipt={'schema':'iq4_offline_package_source_zip_v1','source_manifest_sha256':sha(manifest.read_bytes()),
        'zip_name':archive.name,'zip_bytes':archive.stat().st_size,'zip_sha256':sha(archive.read_bytes()),
        'members':len(files)+1,'candidate_or_original_payload_included':False,
        'device_or_SDK_accessed':False}
    (directory/'SOURCE_ZIP.json').write_text(json.dumps(receipt,indent=2)+'\n')
    print(json.dumps(receipt,indent=2))
if __name__=='__main__':main()
