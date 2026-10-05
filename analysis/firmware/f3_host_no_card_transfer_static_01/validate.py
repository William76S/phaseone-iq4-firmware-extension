#!/usr/bin/env python3
"""Verify frozen files and original binary byte windows; never execute binaries."""
from pathlib import Path
import hashlib, json

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[2]
def sha(b): return hashlib.sha256(b).hexdigest()
def main():
    manifest=json.loads((HERE/'manifest.json').read_text())
    for row in manifest['members']:
        b=(HERE/row['path']).read_bytes()
        assert len(b)==row['bytes'] and sha(b)==row['sha256'], row['path']
    x=json.loads((HERE/'EXACT.json').read_text())
    ub=(ROOT/x['User']['path']).read_bytes()
    cb=Path(x['CaptureOne']['path']).read_bytes()
    for key,b in [('User',ub),('CaptureOne',cb)]:
        assert len(b)==x[key]['bytes'] and sha(b)==x[key]['sha256'], key
    count=0
    for key,b in [('user_windows',ub),('user_tables',ub),('captureone_windows',cb),('captureone_data',cb)]:
        for row in x[key]:
            got=b[row['file_offset']:row['file_offset']+row['bytes']]
            assert len(got)==row['bytes'] and got.hex()==row['hex'] and sha(got)==row['sha256'], row['label']
            count+=1
    for row in x['SDK_headers']:
        b=(ROOT/row['path']).read_bytes()
        assert len(b)==row['bytes'] and sha(b)==row['sha256'], row['path']
    assert all(x[k] is False for k in ['firmware_executed','CaptureOne_executed','SDK_loaded','camera_access'])
    print(json.dumps(dict(members=len(manifest['members']),exact_windows_and_data=count,
                         original_binary_bytes_verified=True,executable_run=False)))
if __name__=='__main__':main()
