#!/usr/bin/env python3
"""Compile only shared native UI adapters and Ratio-only LV menu wrapper."""
import argparse,hashlib,json,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
BASE='analysis/firmware/stock_storage_release_55_inputs_final02/inputs/INPUTS_CLEANUP_DRAFT.json'
BASE_SHA='c4f178155ea608d11e1fa2e5a78207e71f97f5afa326484410c92b7151aca410'
def row(p,expected=None):
 p=Path(p);p=(ROOT/p).resolve()if not p.is_absolute()else p.resolve();b=p.read_bytes();r=dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
 if expected:assert r==expected,r['path']
 return r
def main():
 p=argparse.ArgumentParser();p.add_argument('--output',type=Path,required=True);a=p.parse_args();out=a.output.resolve();assert out.is_relative_to(ROOT)and not out.exists();assert row(BASE)['sha256']==BASE_SHA;j=json.loads((ROOT/BASE).read_text());row(j['compiler']['path'],j['compiler']);row(j['stock']['path'],j['stock']);out.mkdir();commands=[];objects=[]
 for source,name in [('native_ui.cpp','native_ui.o'),('lv_settings_wrapper.S','lv_settings_wrapper.o')]:
  flags=[f for f in j['C_flags']if f!='-std=c11']
  if source.endswith('.cpp'):flags+=['-std=c++17']
  argv=[j['compiler']['path'],'cc',*flags,'-c',str((HERE/source).relative_to(ROOT)),'-o',str((out/name).relative_to(ROOT))];q=subprocess.run(argv,cwd=ROOT,text=True,capture_output=True);commands.append(dict(argv=argv,exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert q.returncode==0,q.stderr;objects.append(row(out/name))
 manifest=dict(schema='iq4_recording_removed_shared_UI_source_56',members=[row(HERE/n)for n in ['native_ui.cpp','lv_settings_wrapper.S','pins.h','build_components.py']],base=row(BASE),stock=j['stock'],compiler=j['compiler'],commands=row(out/'COMMANDS.json'),objects=objects,camera_accessed=False)
 sp=out/'SOURCE_SHA256.json';sp.write_text(json.dumps(manifest,indent=2)+'\n');print(json.dumps(dict(objects=objects,source_manifest=row(sp))))
if __name__=='__main__':main()
