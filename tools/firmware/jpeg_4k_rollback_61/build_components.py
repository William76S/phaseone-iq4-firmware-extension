#!/usr/bin/env python3
"""Compile the 4K runtime/menu and gallery deletion identity adapter; no device."""
import argparse, hashlib, json, shlex, subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
BASE='analysis/firmware/half_render_contract_60_inputs_final/INPUTS.json'
BASE_SHA='7037533c75b15fd818d5cf879cfba6e1a3e06335497dc9c92688a6fbe372fb50'
def row(p):
 p=Path(p);p=(ROOT/p).resolve() if not p.is_absolute() else p.resolve()
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args()
 out=a.output.resolve();assert out.is_relative_to(ROOT) and not out.exists()
 assert row(BASE)['sha256']==BASE_SHA;s=json.loads((ROOT/BASE).read_text())
 assert row(s['compiler']['path'])==s['compiler'];out.mkdir();commands=[];objects=[];closure={};source_rows=[]
 for src in ['runtime.cpp','menu.c','gallery.cpp']:
  if src=='gallery.cpp':
   flags=list(s['C_flags']);flags[flags.index('-std=c11')]='-std=c++17';driver='cc'
  elif src.endswith('.cpp'):
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
   if p.suffix in ('.h','.inc','.cpp') and p.resolve()!=(HERE/src).resolve():r=row(p);closure[r['path']]=r
 for r in source_rows+list(closure.values()):assert row(r['path'])==r,'input changed before source freeze'
 manifest=dict(schema='iq4_JPEG_4K_rollback_source_61',members=source_rows+[row(HERE/'build_components.py')],target_header_closure=list(closure.values()),baseline=row(BASE),compiler=s['compiler'],objects=objects,commands=row(out/'COMMANDS.json'),camera_accessed=False)
 p=out/'SOURCE_SHA256.json';p.write_text(json.dumps(manifest,indent=2)+'\n');print(json.dumps(dict(objects=objects,manifest=row(p))))
if __name__=='__main__':main()
