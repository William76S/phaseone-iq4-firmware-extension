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
 assert a.build is not None and not lock.exists()and not(HERE/'LINK_INPUT.json').exists();build=a.build.resolve();assert build.is_relative_to(ROOT)
 j=json.loads((build/'BUILD.json').read_text());assert len(j['objects'])==3 and len(j['tests'])==3
 assert all('PASS 17 native-thread mailbox/exception/fence fault groups'in x['stdout']for x in j['tests'])
 for x in j['source_inputs']:assert row(ROOT/x['path'])==x
 objs=[row(build/x)for x in ['executor.o','native_calls.o','wait_wrapper.o']]
 link=dict(schema='iq4_f3_native_executor_link_01',objects=objs,hook=dict(va='0x49d9d0',old_LE='9fd70994',original_target='0x71384c',return_pc='0x49d9d4',entry='iq4_f3_ifm_wait_wrapper_01'),aliases={'iq4_f3_original_ifm_wait_01':'0x71384c','iq4_native_original_syscall_01':'0x40ae40'},required_dependencies=['native_activity_01/activity.o','native_runtime_01/self_read.o','f3_save_coordinator_06'],native_executor='actual ImageFileBackgroundThread b805c0',target_executed=False,camera_access=False,actual_native_thread_tested=False)
 (HERE/'LINK_INPUT.json').write_text(json.dumps(link,indent=2)+'\n')
 members=[p for p in HERE.iterdir()if p.is_file()and p.name!='SOURCE_SHA256.json']+list((ROOT/'analysis/firmware/f3_native_executor_static_01').iterdir())+[build/p for p in ['BUILD.json','COMMANDS.json','executor.o','native_calls.o','wait_wrapper.o','executor.o.asm','native_calls.o.asm','wait_wrapper.o.asm','executor.o.d','native_calls.o.d','wait_wrapper.o.d']]
 lock.write_text(json.dumps(dict(schema='iq4_f3_native_executor_freeze_01',files=[row(p)for p in sorted(set(members))],host_variants=3,host_groups_each=17,camera_access=False,target_executed=False,actual_native_thread_tested=False),indent=2)+'\n');print('source',row(lock));print('link',row(HERE/'LINK_INPUT.json'));print('objects',objs)
if __name__=='__main__':main()
