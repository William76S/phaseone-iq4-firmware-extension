#!/usr/bin/env python3
"""Freeze this finite source/static/build increment; excludes original firmware."""
import hashlib,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
def row(p):return dict(path=str(p.relative_to(ROOT)),bytes=p.stat().st_size,sha256=hashlib.sha256(p.read_bytes()).hexdigest())
def main():
    manifest=HERE/'SOURCE_SHA256.json'
    if manifest.exists():raise ValueError('Frozen source already exists')
    own=[p for p in HERE.iterdir()if p.is_file()]
    deps=[ROOT/'src/codec'/x for x in ['bounded_jpeg.h','stream_rgb32.c','stream_rgb32.h']]
    deps+=[ROOT/'src/codec/vendor/libjpeg-turbo-1.5.3'/x for x in ['jpeglib.h','jmorecfg.h','jconfig.h','jerror.h','LICENSE.md','README.ijg']]
    outputs=[]
    for name in ['f3_native_jpeg8_binding_static_01','f3_native_jpeg8_binding_build_01']:
        outputs.extend(p for p in (ROOT/'analysis/firmware'/name).iterdir()if p.is_file()and p.suffix not in ['.d']and not p.name.startswith(('synthetic','unadmitted_host')))
    report=dict(schema='iq4_f3_native_jpeg82_binding_source_01',files=[row(p)for p in sorted(set(own+deps+outputs))],
        original_User_sha256='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb',
        original_User_included=False,native_functions_executed=False,target_executed=False,sdk_loaded=False,
        device_access=False,firmware_produced=False)
    manifest.write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps(dict(manifest=row(manifest),members=len(report['files']))))
if __name__=='__main__':main()
