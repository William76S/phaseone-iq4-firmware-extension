#!/usr/bin/env python3
"""Compile and run only our host contracts; no original firmware execution."""
import argparse
import hashlib
import json
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SDK = '/Library/Developer/CommandLineTools/SDKs/MacOSX15.4.sdk'

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def main():
    p = argparse.ArgumentParser()
    p.add_argument('--output', type=Path, default=ROOT/'evidence/f3_render_plan_01')
    a = p.parse_args()
    a.output.mkdir(parents=True, exist_ok=True)
    source = ROOT/'tools/firmware/f3_render_plan_01'
    runs = []; outputs = []
    def run(argv):
        r = subprocess.run([str(x) for x in argv], cwd=ROOT, text=True,
                           capture_output=True)
        runs.append({'argv': [str(x) for x in argv], 'exit': r.returncode,
                     'stdout': r.stdout, 'stderr': r.stderr})
        if r.returncode:
            raise RuntimeError(r.stderr or r.stdout)
        return r.stdout
    try:
        run(['/usr/bin/clang', '--version'])
        for label, options in [('normal', ['-O2']), ('asan_ubsan',
                ['-O1','-g','-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
            folder = a.output/label; folder.mkdir(exist_ok=True)
            objects = []
            for unit in ['render_plan', 'native_render_adapter', 'core_receipt']:
                obj = folder/(unit+'.o'); objects.append(obj)
                run(['/usr/bin/clang','-std=c11','-Wall','-Wextra','-Werror','-pedantic',
                     *options,'-I',source,'-c',source/(unit+'.c'),'-o',obj])
            obj = folder/'native_api_bridge.o'; objects.append(obj)
            run(['/usr/bin/clang++','-std=c++17','-Wall','-Wextra','-Werror','-pedantic',
                 *options,'-isysroot',SDK,'-isystem',SDK+'/usr/include/c++/v1',
                 '-I',source,'-c',source/'native_api_bridge.cpp','-o',obj])
            for test in ['test_plan','test_native_adapter','test_receipt','test_api_bridge']:
                exe = folder/test
                run(['/usr/bin/clang++','-std=c++17','-Wall','-Wextra','-Werror','-pedantic',
                     *options,'-isysroot',SDK,'-isystem',SDK+'/usr/include/c++/v1',
                     '-I',source,ROOT/'tests/f3_render_plan_01'/(test+'.cpp'),
                     *objects,'-o',exe])
                report = json.loads(run([exe]))
                (folder/(test+'.json')).write_text(json.dumps(report,indent=2)+'\n')
                outputs.append({'mode':label,'test':test,'binary_sha256':sha(exe),
                                'report':report})
        result = {'schema':'iq4_f3_render_plan_verification_01','target_executed':False,
                  'raw_decoded':False,'camera_accessed':False,'runs':runs,'tests':outputs,
                  'passed_normal':sum(x['report']['passed'] for x in outputs if x['mode']=='normal'),
                  'passed_sanitized':sum(x['report']['passed'] for x in outputs if x['mode']=='asan_ubsan')}
        (a.output/'HOST.json').write_text(json.dumps(result,indent=2)+'\n')
        print(json.dumps({k:result[k] for k in ['passed_normal','passed_sanitized','target_executed','raw_decoded']}))
    finally:
        (a.output/'COMMANDS.json').write_text(json.dumps(runs,indent=2)+'\n')

if __name__=='__main__': main()
