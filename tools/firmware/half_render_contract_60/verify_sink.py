#!/usr/bin/env python3
"""Execute RGB24 sink through the real host JPEG library; no native pixel claim."""
import argparse, hashlib, json, subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
def row(p):
    b=p.read_bytes()
    return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
    ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args()
    out=a.output.resolve();assert out.is_relative_to(ROOT) and not out.exists();out.mkdir()
    lib=ROOT/'evidence/codec/build/libjpeg8/.libs/libjpeg.a'
    sdk=subprocess.check_output(['xcrun','--show-sdk-path'],text=True).strip()
    commands=[]
    for argv in [
        ['/usr/bin/clang','-isysroot',sdk,'-std=c11','-O2','-Wall','-Wextra','-Werror',str(HERE/'sink.c'),str(HERE/'test_sink.c'),str(lib),'-o',str(out/'test_sink')],
        [str(out/'test_sink')]
    ]:
        q=subprocess.run(argv,cwd=ROOT,capture_output=True,text=True)
        commands.append(dict(argv=argv,exit=q.returncode,stdout=q.stdout,stderr=q.stderr))
        (out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
        assert q.returncode==0,(q.stdout,q.stderr)
    result=dict(schema='iq4_half_RGB24_sink_host_60',sources=[row(HERE/n) for n in ['sink.c','test_sink.c','verify_sink.py']],
        codec=row(lib),host_result=json.loads(q.stdout.splitlines()[-1]),commands=row(out/'COMMANDS.json'),
        actual_native_codec_executed=False,camera_accessed=False,full_RAW_render=False)
    (out/'RESULT.json').write_text(json.dumps(result,indent=2)+'\n');print(q.stdout)
if __name__=='__main__':main()
