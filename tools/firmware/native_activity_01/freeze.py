#!/usr/bin/env python3
import argparse,hashlib,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];OWN=Path(__file__).resolve().parent
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--verify',action='store_true');ap.add_argument('--build',type=Path);a=ap.parse_args();p=OWN/'SOURCE_SHA256.json'
 if a.verify:
  assert a.build is None;j=json.loads(p.read_text());assert all(row(ROOT/x['path'])==x for x in j['files']);print(len(j['files']),'members PASS',row(p)['sha256']);return
 assert a.build is not None and not p.exists();b=a.build.resolve();assert b.is_relative_to(ROOT);j=json.loads((b/'BUILD.json').read_text());assert len(j['tests'])==3 and len(j['objects'])==1 and not j['objects'][0]['undefined_symbols']
 for x in j['source_inputs']:assert row(ROOT/x['path'])==x
 files=[x for x in OWN.iterdir()if x.is_file()and x.name!='SOURCE_SHA256.json']+[b/'BUILD.json',b/'COMMANDS.json',b/'activity.o']
 p.write_text(json.dumps(dict(schema='iq4_native_activity_source_freeze_01',files=[row(x)for x in sorted(files)],camera_access=False,target_executed=False,production_consumers_integrated=False),indent=2)+'\n');print('source',row(p));print('object',row(b/'activity.o'))
if __name__=='__main__':main()
