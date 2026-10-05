#!/usr/bin/env python3
"""Pure-file/host validation of this source freeze; never executes vendor code."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
BASE=ROOT/'analysis/firmware/firmware_package_acceptance_static_01'
def sha(b):return hashlib.sha256(b).hexdigest()

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--recollect',action='store_true')
    args=parser.parse_args()
    manifest=json.loads((HERE/'SOURCE_SHA256.json').read_text())
    for rel,row in manifest['files'].items():
        p=ROOT/rel
        if len(p.read_bytes())!=row['bytes'] or sha(p.read_bytes())!=row['sha256']:
            raise ValueError('source member differs: '+rel)
    sys.path.insert(0,str(ROOT/'tools/firmware'))
    from save_setup_security_collect_static import sections,span
    exact=json.loads((BASE/'evidence/exact_bytes.json').read_text())
    user=(ROOT/exact['User']['path']).read_bytes()
    if sha(user)!=exact['User']['sha256']:raise ValueError('User differs')
    layout=sections(user)
    functions=json.loads((ROOT/'analysis/firmware/unwind_functions.json').read_text())['functions']
    for row in exact['functions']:
        a,b=int(row['start_va'],16),int(row['end_va_exclusive'],16)
        off,body,_=span(user,layout,a,b)
        if b!=functions[functions.index(a)+1] or off!=int(row['file_offset'],16) or body.hex()!=row['bytes_hex'] or sha(body)!=row['bytes_sha256']:
            raise ValueError('function window differs')
    for row in exact['data']:
        a=int(row['va'],16);off,body,_=span(user,layout,a,a+row['bytes'])
        if off!=int(row['file_offset'],16) or body.hex()!=row['bytes_hex'] or sha(body)!=row['bytes_sha256']:
            raise ValueError('data window differs')
    result=subprocess.run([sys.executable,'-B',str(HERE/'test_package.py')],cwd=ROOT,capture_output=True,text=True)
    if result.returncode or 'Ran 13 tests' not in result.stderr:
        raise ValueError('host fixture tests failed: '+result.stderr)
    recollected=False
    if args.recollect:
        with tempfile.TemporaryDirectory(prefix='updater_static_recollect_',dir=ROOT/'build') as tmp:
            command=[sys.executable,'-B',str(ROOT/'tools/firmware/firmware_package_acceptance_collect_static_01.py'),'--output-directory',tmp]
            subprocess.run(command,cwd=ROOT,capture_output=True,text=True,check=True)
            expected=json.loads((BASE/'evidence/manifest.json').read_text())
            actual=json.loads((Path(tmp)/'manifest.json').read_text())
            if actual!=expected:raise ValueError('recollected manifest differs')
            for rel,digest in expected['files'].items():
                if sha((Path(tmp)/rel).read_bytes())!=digest:raise ValueError('recollection bytes differ')
            recollected=True
    print(json.dumps({'source_members_verified':len(manifest['files']),
        'full_function_windows_verified':len(exact['functions']),'data_windows_verified':len(exact['data']),
        'host_tests':13,'independent_recollection_verified':recollected,
        'source_manifest_sha256':sha((HERE/'SOURCE_SHA256.json').read_bytes()),
        'vendor_firmware_or_SDK_executed':False,'camera_accessed':False,
        'device_acceptance_or_recovery_verified':False},indent=2))
if __name__=='__main__':main()
