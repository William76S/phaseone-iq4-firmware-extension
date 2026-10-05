#!/usr/bin/env python3
import argparse,hashlib,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];OWN=Path(__file__).resolve().parent
OLD=ROOT/'tools/firmware/f4_native_source_02'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--verify',action='store_true');ap.add_argument('--build',type=Path);a=ap.parse_args();lock=OWN/'SOURCE_SHA256.json'
 if a.verify:
  assert a.build is None;j=json.loads(lock.read_text());assert all(row(ROOT/x['path'])==x for x in j['files']);print(len(j['files']),'members PASS',row(lock)['sha256']);return
 assert a.build is not None and not lock.exists()and not(OWN/'LINK_OVERLAY.json').exists();build=a.build.resolve();assert build.is_relative_to(ROOT)
 j=json.loads((build/'BUILD.json').read_text());assert j['schema']=='iq4_f4_native_source_build_03'and len(j['objects'])==1 and len(j['tests'])==3
 assert all('28 synthetic fault groups PASS'in x['stdout']for x in j['tests'])
 for x in j['source_inputs']+j['frozen_compatibility_inputs']:assert row(ROOT/x['path'])==x
 obj=j['objects'][0];assert not obj['executed']and row(ROOT/obj['path'])=={k:obj[k]for k in ['path','bytes','sha256']}
 baseline=json.loads((OLD/'LINK_INPUT.json').read_text());replacement=[x for x in baseline['objects']if Path(x['path']).name=='source.o'];assert len(replacement)==1
 overlay=dict(schema='iq4_f4_source03_single_object_overlay',frozen_source02=row(OLD/'SOURCE_SHA256.json'),frozen_link02=row(OLD/'LINK_INPUT.json'),replace_only=replacement[0],replacement=obj,other_eight_objects_unchanged=True,ABI02_unchanged=True,additional_aliases=[],actual_color_tested=False,actual_recording_tested=False,target_executed=False,camera_access=False)
 (OWN/'LINK_OVERLAY.json').write_text(json.dumps(overlay,indent=2)+'\n')
 files=[p for p in OWN.iterdir()if p.is_file()and p.name!='SOURCE_SHA256.json']+list((ROOT/'analysis/firmware/f4_native_source_03/static').iterdir())+[build/x for x in ['BUILD.json','COMMANDS.json','SOURCE_DIFF.patch','source.o','source.o.asm','source.o.d']]+[ROOT/x['path']for x in j['frozen_compatibility_inputs']]
 lock.write_text(json.dumps(dict(schema='iq4_f4_native_source_freeze_03',files=[row(p)for p in sorted(set(files))],host_test_variants=3,host_groups_each=28,aarch64_objects=1,camera_access=False,target_executed=False,actual_color_tested=False),indent=2)+'\n');print('freeze',row(lock));print('overlay',row(OWN/'LINK_OVERLAY.json'));print('object',row(ROOT/obj['path']))
if __name__=='__main__':main()
