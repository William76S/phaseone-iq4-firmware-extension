#!/usr/bin/env python3
"""Compile host-owned tests and a target ET_REL only; never launch target/vendor code."""
import hashlib,json,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f3_save_transaction_build_01'
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
def sha(b):return hashlib.sha256(b).hexdigest()
def main():
    OUT.mkdir(parents=True,exist_ok=True);commands=[];results=[]
    def run(argv):
        commands.append([str(x) for x in argv]);p=subprocess.run(commands[-1],capture_output=True,text=True)
        results.append({'command':len(commands)-1,'returncode':p.returncode,'stdout':p.stdout,'stderr':p.stderr})
        if p.returncode:raise RuntimeError(p.stderr)
    for tag,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
        exe=OUT/('test_'+tag)
        run(['/usr/bin/clang','-std=c11','-O1','-Wall','-Wextra','-Werror',*flags,
             HERE/'transaction.c',HERE/'test_transaction.c','-o',exe])
        run([exe])
    run([ZIG,'cc','-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-ffreestanding',
         '-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables',
         '-fno-omit-frame-pointer','-ffunction-sections','-fdata-sections','-Wall','-Wextra','-Werror',
         '-MMD','-MF',OUT/'transaction.d','-c',HERE/'transaction.c','-o',OUT/'transaction.o'])
    run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',OUT/'transaction.o'])
    run(['/usr/bin/file',OUT/'transaction.o'])
    inputs=[HERE/'transaction.h',HERE/'transaction.c',HERE/'test_transaction.c',Path(__file__),ZIG]
    outputs=[p for p in sorted(OUT.iterdir()) if p.name!='BUILD.json']
    report={'schema':'iq4_f3_transaction_build_01','commands':commands,'results':results,
            'inputs':[{'path':str(p.relative_to(ROOT)),'bytes':p.stat().st_size,'sha256':sha(p.read_bytes())} for p in inputs],
            'outputs':[{'path':str(p.relative_to(ROOT)),'bytes':p.stat().st_size,'sha256':sha(p.read_bytes())} for p in outputs],
            'target_executed':False,'sdk_executed':False,'device_accessed':False,'native_ports_bound':False}
    (OUT/'BUILD.json').write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps({'host_runs':[r['stdout'].strip() for r in results if r['stdout'].startswith('{')],
                      'target_object_sha256':sha((OUT/'transaction.o').read_bytes()),'native_ports_bound':False}))
if __name__=='__main__':main()
