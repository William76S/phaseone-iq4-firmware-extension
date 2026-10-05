#!/usr/bin/env python3
"""Produce, inspect and hash ET_REL objects only; never execute target code."""
import argparse, hashlib, json, struct, subprocess
from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('--zig',type=Path,default=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig')
    ap.add_argument('--output',type=Path,default=ROOT/'evidence/f3_render_plan_01/target')
    a=ap.parse_args(); a.output.mkdir(parents=True,exist_ok=True)
    source=ROOT/'tools/firmware/f3_render_plan_01'; runs=[]; objects=[]
    version=subprocess.run([str(a.zig),'version'],cwd=ROOT,text=True,capture_output=True)
    runs.append({'argv':[str(a.zig),'version'],'exit':version.returncode,
                 'stdout':version.stdout,'stderr':version.stderr})
    if version.returncode:raise RuntimeError(version.stderr)
    for unit in ['render_plan','native_render_adapter','core_receipt','native_api_bridge']:
        hashes=[]
        for repeat in [1,2]:
            path=a.output/(unit+f'.{repeat}.o')
            is_cpp=unit=='native_api_bridge'
            argv=[str(a.zig),'c++' if is_cpp else 'cc','-target','aarch64-linux-gnu.2.28',
                  '-std=c++17' if is_cpp else '-std=c11',
                  '-Wall','-Wextra','-Werror','-O2','-ffunction-sections','-fdata-sections',
                  '-fPIC','-I',str(source),'-c',str(source/(unit+('.cpp' if is_cpp else '.c'))),'-o',str(path)]
            r=subprocess.run(argv,cwd=ROOT,text=True,capture_output=True)
            runs.append({'argv':argv,'exit':r.returncode,'stdout':r.stdout,'stderr':r.stderr})
            if r.returncode: raise RuntimeError(r.stderr)
            data=path.read_bytes(); ident,kind,machine=struct.unpack_from('<16sHH',data)
            if ident[:7]!=b'\x7fELF\x02\x01\x01' or kind!=1 or machine!=183:
                raise ValueError('not AArch64 little-endian ET_REL')
            hashes.append(sha(path))
        if hashes[0]!=hashes[1]:raise ValueError('fresh ET_REL builds differ')
        argv=['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','--undefined-only',str(path)]
        nm=subprocess.run(argv,cwd=ROOT,text=True,capture_output=True)
        runs.append({'argv':argv,'exit':nm.returncode,'stdout':nm.stdout,'stderr':nm.stderr})
        if nm.returncode:raise RuntimeError(nm.stderr)
        objects.append({'unit':unit,'sha256':hashes[0],'bytes':path.stat().st_size,
                        'undefined_symbols':[line.split()[-1] for line in nm.stdout.splitlines() if line.split()],
                        'elf_type':'ET_REL','elf_machine':'AArch64','fresh_builds_equal':True})
    result={'schema':'iq4_f3_render_plan_target_build_01','target_executed':False,
            'zig_sha256':sha(a.zig),'objects':objects,'runs':runs}
    (a.output/'TARGET.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({'objects':objects,'target_executed':False}))
if __name__=='__main__':main()
