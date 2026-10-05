#!/usr/bin/env python3
from pathlib import Path
import hashlib,json
HERE=Path(__file__).resolve().parent
def sha(b):return hashlib.sha256(b).hexdigest()
def main():
    x=json.loads((HERE/'EXACT.json').read_text())
    names=['collect.py','validate.py','freeze.py','REVIEW.md','EXACT.json']
    names += [r['asm'] for k in ['user_windows','captureone_windows'] for r in x[k]]
    rows=[]
    for n in sorted(set(names)):
        b=(HERE/n).read_bytes();rows.append(dict(path=n,bytes=len(b),sha256=sha(b)))
    result=dict(schema='iq4_native_host_CaptureOne_static_freeze_01',members=rows,
                User_sha256=x['User']['sha256'],CaptureOne_sha256=x['CaptureOne']['sha256'],
                member_scope='Only finite collector outputs; earlier unreferenced C1_*.asm are draft material',
                firmware_executed=False,CaptureOne_executed=False,SDK_loaded=False,camera_access=False)
    (HERE/'manifest.json').write_text(json.dumps(result,indent=2,sort_keys=True)+'\n')
    print(json.dumps(dict(members=len(rows),manifest_sha256=sha((HERE/'manifest.json').read_bytes()))))
if __name__=='__main__':main()
