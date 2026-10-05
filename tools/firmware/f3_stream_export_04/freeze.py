#!/usr/bin/env python3
"""Freeze/verify actual export04 sources and two-object overlay; no firmware run."""
from pathlib import Path
import argparse,hashlib,json
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--build',type=Path);ap.add_argument('--verify',action='store_true');a=ap.parse_args();manifest=HERE/'SOURCE_SHA256.json';link=HERE/'LINK_OVERLAY.json'
 if a.verify:
  assert a.build is None
  rows=json.loads(manifest.read_text())['files']
  for r in rows:assert row(ROOT/r['path'])==r,r['path']
  print(len(rows),'members PASS',row(manifest)['sha256']);return
 assert a.build and not manifest.exists()and not link.exists();build=a.build.resolve();new=json.loads((build/'BUILD.json').read_text());assert new['schema']=='iq4_stream_export_04_cleanup_hold'and not new['camera_executed']and not new['actual_RAW_decoded']
 olddir=ROOT/'analysis/firmware/f3_stream_export_build_03_final01';old=json.loads((olddir/'BUILD.json').read_text());oldobj={Path(r['path']).name:r for r in old['objects']};newobj={Path(r['path']).name:r for r in new['objects']}
 for host in new['host']:assert host['output']['groups']==62 and host['output']['passed']and host['output']['real_host_entropy_decoded_geometry_cases']==24
 for name in ['export_pixels.o','export_geometry.o']:assert newobj[name]['bytes']==oldobj[name]['bytes']and newobj[name]['sha256']==oldobj[name]['sha256']
 overlay=dict(schema='iq4_stream_export04_ABI03_cleanup_hold_overlay',replace_only=[oldobj[n]for n in ['jpeg_export.o','stream_export.o']],replacement=[newobj[n]for n in ['jpeg_export.o','stream_export.o']],other_geometry_objects_byte_identical=True,ABI03_unchanged=True,do_not_link_both_revisions=True,unknown_cleanup_retains_context_and_transaction=True,target_executed=False,camera_accessed=False)
 link.write_text(json.dumps(overlay,indent=2)+'\n')
 paths=[p for p in HERE.iterdir()if p.is_file()and p!=manifest]
 paths+=[ROOT/r['path']for r in new['source']];paths+=[build/'BUILD.json',build/'COMMANDS.json']+list(build.glob('*.asm'))+[ROOT/r['path']for r in new['objects']]
 paths+=[ROOT/'tools/firmware/f3_stream_export_03/SOURCE_SHA256.json',olddir/'BUILD.json']
 manifest.write_text(json.dumps(dict(schema='iq4_stream_export04_source_freeze',files=[row(p)for p in sorted(set(paths))],camera_accessed=False,target_executed=False),indent=2)+'\n');print(row(manifest))
if __name__=='__main__':main()
