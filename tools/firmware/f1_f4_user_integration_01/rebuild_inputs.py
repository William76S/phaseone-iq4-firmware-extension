#!/usr/bin/env python3
"""Fresh source recompilation of exact frozen ET_REL inputs; no target execution."""
from pathlib import Path
import argparse,hashlib,json,subprocess
ROOT=Path(__file__).resolve().parents[3]
GROUPS=[('tools/firmware/f4_native_source_02/SOURCE_SHA256.json','analysis/firmware/f4_native_source_build_02_release_complete/COMMANDS.json'),('tools/firmware/f4_native_source_03/SOURCE_SHA256.json','analysis/firmware/f4_native_source_build_03/COMMANDS.json'),('tools/firmware/f3_native_jpeg8_binding_01/SOURCE_SHA256.json','analysis/firmware/f3_native_jpeg8_binding_build_01/COMMANDS.json')]
OVERLAYS=[('tools/firmware/f4_codec_cleanup_01/LINK_OVERLAY.json','analysis/firmware/f4_codec_cleanup_build_01/COMMANDS.json'),('tools/firmware/f4_mkv_software_zero_01/LINK_OVERLAY.json','analysis/firmware/f4_mkv_software_zero_build_01/COMMANDS.json')]
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def members(p):
 j=json.loads(p.read_text());j=j.get('files',j.get('members'));return [dict(path=k,**v)for k,v in j.items()]if isinstance(j,dict)else j
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve();assert out.is_relative_to(ROOT)and not out.exists()
 zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';assert row(zig)['sha256']=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
 objects={};commands=[];groups=[]
 for overlay,saved in OVERLAYS:
  j=json.loads((ROOT/overlay).read_text());s=j['source'];assert row(ROOT/s['path'])==s
  entries=j.get('replacements',[j]);entries=[r['replacement']for r in entries]
  for r in entries:objects[r['path']]=r
  GROUPS.append((s['path'],saved))
 for manifest,saved in GROUPS:
  rows=members(ROOT/manifest)
  for r in rows:
   if Path(r['path']).suffix=='.o':objects[r['path']]=r
   else:assert row(ROOT/r['path'])==r,r['path']
  records=json.loads((ROOT/saved).read_text());groups.append(dict(source_manifest=row(ROOT/manifest),saved_commands=row(ROOT/saved)))
  for record in records:
   argv=record['argv']
   if '-c'not in argv or '-target'not in argv or argv[argv.index('-target')+1]!='aarch64-linux-gnu.2.28':continue
   suffix='build/toolchains/zig-aarch64-macos-0.15.2/zig';assert argv[0].endswith(suffix);prefix=argv[0][:-len(suffix)]
   original=argv[argv.index('-o')+1];assert original.startswith(prefix);original=original[len(prefix):]
   if original not in objects:continue
   assert record['exit']==0;argv=[str(ROOT/v[len(prefix):])if v.startswith(prefix)else v for v in argv];commands.append((original,argv))
 assert len(commands)==len(objects)==15 and len({r for r,_ in commands})==15
 out.mkdir(parents=True);remap={};actual=[];receipts=[]
 for original,argv in commands:
  obj=out/(str(len(actual)+1).zfill(2)+'_'+Path(original).name);argv[argv.index('-o')+1]=str(obj)
  if '-MF'in argv:argv[argv.index('-MF')+1]=str(obj)+'.d'
  q=subprocess.run(argv,cwd=ROOT,capture_output=True,text=True);receipts.append(dict(argv=argv,exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(out/'COMMANDS.json').write_text(json.dumps(receipts,indent=2)+'\n');assert q.returncode==0,q.stderr
  r=row(obj);expected=objects[original];assert r['bytes']==expected['bytes']and r['sha256']==expected['sha256'],original
  remap[original]=r['path'];actual.append(dict(original=expected,fresh=r))
 result=dict(schema='iq4_frozen_target_objects_fresh_recompile_01',groups=groups,compiler=row(zig),remap=remap,objects=actual,fresh_matching_object_count=len(actual),all_fresh_objects_match_frozen_bytes=True,target_executed=False,camera_accessed=False)
 (out/'ARTIFACT_MAP.json').write_text(json.dumps(result,indent=2)+'\n');print('15 fresh source recompiles match frozen ET_REL bytes; no target execution')
if __name__=='__main__':main()
