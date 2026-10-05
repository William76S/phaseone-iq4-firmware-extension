#!/usr/bin/env python3
import argparse,hashlib,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OLD=ROOT/'tools/firmware/f4_native_source_02'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--verify',action='store_true');ap.add_argument('--build',type=Path);a=ap.parse_args();p=HERE/'SOURCE_SHA256.json'
 if a.verify:
  assert a.build is None;j=json.loads(p.read_text());assert all(row(ROOT/x['path'])==x for x in j['files']);print(len(j['files']),'members PASS',row(p)['sha256']);return
 assert a.build is not None and not p.exists()and not(HERE/'LINK_OVERLAY.json').exists();b=a.build.resolve();assert b.is_relative_to(ROOT);j=json.loads((b/'BUILD.json').read_text());assert j['schema']=='iq4_f4_native_entry_build_03'and len(j['tests'])==33 and len(j['objects'])==1 and j['ABI02_preserved']
 for x in j['source_inputs']+j['frozen_compatibility_inputs']:assert row(ROOT/x['path'])==x
 base=json.loads((OLD/'LINK_INPUT.json').read_text());old=[x for x in base['objects']if Path(x['path']).name=='entry.o'];assert len(old)==1
 overlay=dict(schema='iq4_f4_entry03_single_object_overlay',frozen_source02=row(OLD/'SOURCE_SHA256.json'),frozen_link02=row(OLD/'LINK_INPUT.json'),replace_only=old[0],replacement=j['objects'][0],other_eight_objects_unchanged=True,ABI02_unchanged=True,required_additional_object='native_activity_01/activity.o (exactly one shared instance)',additional_aliases=[],new_BL=[],actual_combined_activity_tested=False,camera_access=False,target_executed=False)
 (HERE/'LINK_OVERLAY.json').write_text(json.dumps(overlay,indent=2)+'\n')
 files=[x for x in HERE.iterdir()if x.is_file()and x.name!='SOURCE_SHA256.json']+[b/x for x in ['BUILD.json','COMMANDS.json','SOURCE_DIFF.patch','entry.o','entry.o.asm','entry.o.d']]+[ROOT/x['path']for x in j['frozen_compatibility_inputs']]
 p.write_text(json.dumps(dict(schema='iq4_f4_entry03_freeze',files=[row(x)for x in sorted(set(files))],host_variants=3,host_groups_each=11,camera_access=False,target_executed=False),indent=2)+'\n');print('source',row(p));print('overlay',row(HERE/'LINK_OVERLAY.json'));print('object',row(b/'entry.o'))
if __name__=='__main__':main()
