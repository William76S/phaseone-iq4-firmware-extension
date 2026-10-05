#!/usr/bin/env python3
import argparse,hashlib,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent

def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--verify',action='store_true');ap.add_argument('--build',type=Path);a=ap.parse_args();lock=HERE/'SOURCE_SHA256.json'
 if a.verify:
  assert a.build is None;j=json.loads(lock.read_text());assert all(row(ROOT/x['path'])==x for x in j['files']);print(len(j['files']),'members PASS',row(lock)['sha256']);return
 assert a.build is not None and not lock.exists()and not(HERE/'LINK_INPUT.json').exists();b=a.build.resolve();assert b.is_relative_to(ROOT)
 j=json.loads((b/'BUILD.json').read_text());assert j['schema']=='iq4_f3_capture_menu_build_04'and len(j['objects'])==3 and len(j['tests'])==81 and not j['default_production_EN0']
 for x in j['source_inputs']+j['dependencies']:assert row(ROOT/x['path'])==x
 objects=[row(b/x)for x in ['policy.o','menu.o','wrapper.o']]
 link=dict(schema='iq4_f3_capture_menu_link_04',objects=objects,hook=dict(va='0x4f0d34',old_LE='e1d2ff97',original_target='0x4e58b8',return_pc='0x4f0d38',entry='iq4_f3_file_settings_append_wrapper_04'),aliases=[],required_dependencies=['f3_native_executor_01','f3_save_coordinator_06','native_activity_01','native_runtime_01/self_read.o','f4_native_menu_03/native_calls.o','f4_native_source_02/native_calls.o','src/codec/export_geometry.o'],replace_not_duplicate='all menu03/policy.o symbols; sole own packed settings',direct_coordinator_consumer=True,actual_factory_before_hook_required=True,actual_native_capture_or_manual_tested=False,target_executed=False,camera_access=False)
 (HERE/'LINK_INPUT.json').write_text(json.dumps(link,indent=2)+'\n')
 files=[p for p in HERE.iterdir()if p.is_file()and p.name!='SOURCE_SHA256.json']+[b/p for p in ['BUILD.json','COMMANDS.json','policy.o','menu.o','wrapper.o','policy.o.d','menu.o.d','wrapper.o.d','policy.o.asm','menu.o.asm','wrapper.o.asm']]+[ROOT/x['path']for x in j['dependencies']]
 lock.write_text(json.dumps(dict(schema='iq4_f3_capture_menu_freeze_04',files=[row(p)for p in sorted(set(files))],host_variants=3,host_runs_each=27,target_executed=False,camera_access=False,actual_capture_tested=False,actual_manual_export_tested=False),indent=2)+'\n');print('source',row(lock));print('link',row(HERE/'LINK_INPUT.json'));print('objects',objects)
if __name__=='__main__':main()
