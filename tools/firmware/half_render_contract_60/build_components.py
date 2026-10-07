#!/usr/bin/env python3
"""Compile the five Half render repair modules; no device access."""
import argparse, hashlib, json, shlex, subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
BASE='analysis/firmware/half_request_owner_59_inputs_final/INPUTS.json'
BASE_SHA='9d778df6baa0b619c3c1bff2e4cc593bbc3d15a08b9b50b1998549a48c64b850'
def row(p):
 p=Path(p);p=(ROOT/p).resolve() if not p.is_absolute() else p.resolve()
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args()
 out=a.output.resolve();assert out.is_relative_to(ROOT) and not out.exists()
 assert row(BASE)['sha256']==BASE_SHA;s=json.loads((ROOT/BASE).read_text())
 assert row(s['compiler']['path'])==s['compiler'];out.mkdir();commands=[];objects=[];closure={};source_rows=[]
 for src in ['runtime.cpp','bridge.cpp','menu.c','sink.c','rgb24_terminal.cpp']:
  if src.endswith('.cpp'):
   flags=['-target','aarch64-linux-gnu.2.28','-DIQ4_JPEG_API_VERSION=82','-O2','-g0','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror','-std=c++17']
   driver='c++'
  else:flags=s['C_flags'];driver='cc'
  source_before=row(HERE/src)
  obj=out/(Path(src).stem+'.o');dep=out/(Path(src).stem+'.d')
  argv=[s['compiler']['path'],driver,*flags,'-MMD','-MF',str(dep.relative_to(ROOT)),'-c',str((HERE/src).relative_to(ROOT)),'-o',str(obj.relative_to(ROOT))]
  q=subprocess.run(argv,cwd=ROOT,text=True,capture_output=True)
  commands.append(dict(argv=argv,exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
  assert q.returncode==0,q.stderr;assert row(HERE/src)==source_before,'source changed during compilation'
  source_rows.append(source_before);objects.append(row(obj))
  for token in shlex.split(dep.read_text().replace('\\\n',' ').split(':',1)[1]):
   p=Path(token);p=p if p.is_absolute() else ROOT/p
   if p.suffix in ('.h','.inc'):r=row(p);closure[r['path']]=r
 for r in source_rows+list(closure.values()):assert row(r['path'])==r,'input changed before source freeze'
 manifest=dict(schema='iq4_Half_render_contract_source_60',members=source_rows+[row(HERE/'build_components.py')],target_header_closure=list(closure.values()),baseline=row(BASE),compiler=s['compiler'],objects=objects,commands=row(out/'COMMANDS.json'),camera_accessed=False)
 p=out/'SOURCE_SHA256.json';p.write_text(json.dumps(manifest,indent=2)+'\n');print(json.dumps(dict(objects=objects,manifest=row(p))))
if __name__=='__main__':main()
