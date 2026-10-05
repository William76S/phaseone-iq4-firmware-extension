#!/usr/bin/env python3
import argparse,hashlib,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OLD=ROOT/'tools/firmware/f3_capture_menu_04'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--verify',action='store_true');ap.add_argument('--build',type=Path);a=ap.parse_args();lock=HERE/'SOURCE_SHA256.json'
 if a.verify:
  assert a.build is None;j=json.loads(lock.read_text());assert all(row(ROOT/x['path'])==x for x in j['files']);print(len(j['files']),'members PASS',row(lock)['sha256']);return
 assert a.build is not None and not lock.exists()and not(HERE/'LINK_OVERLAY.json').exists();b=a.build.resolve();assert b.is_relative_to(ROOT)
 j=json.loads((b/'BUILD.json').read_text());assert j['schema']=='iq4_f3_menu05_build'and len(j['objects'])==1 and len(j['tests'])==2 and j['normalized_runtime_identical']and j['undefined_symbols_identical']
 assert all('PASS8' in x['stdout'] for x in j['tests'])
 for x in j['source_inputs']+j['frozen_inputs']:assert row(ROOT/x['path'])==x
 base=json.loads((OLD/'LINK_INPUT.json').read_text());old=[x for x in base['objects']if Path(x['path']).name=='menu.o'];assert len(old)==1
 overlay=dict(schema='iq4_f3_menu05_single_object_overlay',frozen_source04=row(OLD/'SOURCE_SHA256.json'),frozen_link04=row(OLD/'LINK_INPUT.json'),replace_only=old[0],replacement=j['objects'][0],policy_and_wrapper04_unchanged=True,ABI04_unchanged=True,new_BL=[],additional_aliases=[],automatic_JPEG_scope='SD only; XQD unsupported',manual_existing_RAW_always_retained=True,target_executed=False,camera_access=False)
 (HERE/'LINK_OVERLAY.json').write_text(json.dumps(overlay,indent=2)+'\n')
 files=[p for p in HERE.iterdir()if p.is_file()and p.name!='SOURCE_SHA256.json']+[b/x for x in ['BUILD.json','COMMANDS.json','SOURCE_DIFF.patch','menu.o','menu.o.asm','menu.o.d']]+[ROOT/x['path']for x in j['frozen_inputs']]
 lock.write_text(json.dumps(dict(schema='iq4_f3_menu05_freeze',files=[row(p)for p in sorted(set(files))],host_variants=2,host_groups_each=8,camera_access=False,target_executed=False),indent=2)+'\n');print('source',row(lock));print('overlay',row(HERE/'LINK_OVERLAY.json'));print('object',row(b/'menu.o'))
if __name__=='__main__':main()
