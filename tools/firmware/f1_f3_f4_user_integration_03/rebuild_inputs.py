#!/usr/bin/env python3
"""Replay only recorded successful target compiles for the exact object set."""
from pathlib import Path
import argparse,hashlib,importlib.util,json,subprocess
ROOT=Path(__file__).resolve().parents[3]
def row(p):
 p=p.resolve();assert p.is_relative_to(ROOT);b=p.read_bytes()
 return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--spec',type=Path,required=True);ap.add_argument('--spec-sha256',required=True);ap.add_argument('--output',type=Path,required=True);a=ap.parse_args()
 spec=a.spec.resolve();assert row(spec)['sha256']==a.spec_sha256;j=json.loads(spec.read_text());wanted={e['path']:e for e in j['objects']}
 loader=importlib.util.spec_from_file_location('exact_recompile_source_locks',Path(__file__).with_name('build.py'))
 verifier=importlib.util.module_from_spec(loader);loader.loader.exec_module(verifier)
 for e in j['source_manifests']:verifier.lock(e)
 for e in j['receipts']:verifier.verify(e)
 verifier.verify(j['compiler'])
 # Read each current object's own build record. Historical validation JSONs
 # preserve old script identities and target virtual filenames; they are not
 # current compiler inputs. Every replayed result still must match the exact
 # frozen object bytes and hash, and every current source lock is checked.
 commands=set()
 for rel in wanted:
  parent=(ROOT/rel).parent
  commands.add(parent/'COMMANDS.json'if(parent/'COMMANDS.json').is_file()else parent/'BUILD.json')
 assert all(p.is_file()for p in commands)
 plans={};zig_suffix='build/toolchains/zig-aarch64-macos-0.15.2/zig'
 for p in sorted(commands):
  records=json.loads(p.read_text());records=records['commands']if isinstance(records,dict)else records
  for record in records:
   argv=record.get('argv',[])
   if '-c'not in argv or '-target'not in argv or '-o'not in argv or not argv[0].endswith(zig_suffix):continue
   if argv[argv.index('-target')+1]!='aarch64-linux-gnu.2.28':continue
   prefix=argv[0][:-len(zig_suffix)];target=argv[argv.index('-o')+1]
   rel=target[len(prefix):]if target.startswith(prefix)else target
   if rel not in wanted:continue
   assert record.get('exit',record.get('exit_code'))==0
   if rel in plans:assert plans[rel]['argv']==argv,rel
   plans[rel]=dict(argv=argv,record=row(p),prefix=prefix)
 assert set(plans)==set(wanted),sorted(set(wanted)-set(plans))
 out=a.output.resolve();assert out.is_relative_to(ROOT)and not out.exists();out.mkdir(parents=True)
 actual=[];executed=[];remap={}
 for i,(rel,plan)in enumerate(plans.items()):
  obj=out/(str(i+1).zfill(2)+'_'+Path(rel).name)
  argv=[str(ROOT/v[len(plan['prefix']):])if v.startswith(plan['prefix'])else v for v in plan['argv']]
  argv[argv.index('-o')+1]=str(obj)
  if '-MF'in argv:argv[argv.index('-MF')+1]=str(obj)+'.d'
  q=subprocess.run(argv,cwd=ROOT,capture_output=True,text=True)
  executed.append(dict(argv=argv,exit=q.returncode,stdout=q.stdout,stderr=q.stderr,original_command_record=plan['record']))
  (out/'COMMANDS.json').write_text(json.dumps(executed,indent=2)+'\n');assert q.returncode==0,q.stderr
  e=row(obj);assert e['bytes']==wanted[rel]['bytes']and e['sha256']==wanted[rel]['sha256'],rel
  actual.append(dict(original=wanted[rel],fresh=e));remap[rel]=e['path']
 result=dict(schema='iq4_frozen_target_objects_fresh_recompile_01',spec=row(spec),remap=remap,objects=actual,
  fresh_matching_object_count=len(actual),all_fresh_objects_match_frozen_bytes=True,target_executed=False,camera_accessed=False)
 (out/'ARTIFACT_MAP.json').write_text(json.dumps(result,indent=2)+'\n');print(len(actual),'fresh target objects from exact recorded source compiles; no target execution')
if __name__=='__main__':main()
