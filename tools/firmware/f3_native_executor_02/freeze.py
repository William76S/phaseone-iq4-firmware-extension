#!/usr/bin/env python3
"""Freeze/verify this own-source single-object overlay; never execute target."""
import argparse,hashlib,json,shlex,struct,zipfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
EXECUTOR=HERE.name=='f3_native_executor_02'
STEM='executor'if EXECUTOR else'coordinator'
OLD_DIR='f3_native_executor_01'if EXECUTOR else'f3_save_coordinator_06'
BUILD_DIR='f3_native_executor_build_02'if EXECUTOR else'f3_save_coordinator_build_07'
OLD=ROOT/('analysis/firmware/f3_native_executor_build_01_final/executor.o'if EXECUTOR else'analysis/firmware/f3_save_coordinator_build_06/coordinator.o')
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def info(p):
 b=p.read_bytes();assert b[:6]==b'\x7fELF\x02\x01'
 e=struct.unpack_from('<16sHHIQQQIHHHHHH',b);assert e[1]==1 and e[2]==183
 sections=[struct.unpack_from('<IIQQQQIIQQ',b,e[6]+i*e[11])for i in range(e[12])]
 strs=sections[e[13]];names=b[strs[4]:strs[4]+strs[5]]
 def name(t,o):return t[o:t.index(0,o)].decode()
 alloc=[];relocs=set();undefined=set();defined=set()
 for s in sections:
  if s[2]&2:alloc.append(dict(name=name(names,s[0]),type=s[1],flags=s[2],bytes=s[5]))
  if s[1]in(4,9):
   for off in range(s[4],s[4]+s[5],s[9]):relocs.add(struct.unpack_from('<Q',b,off+8)[0]&0xffffffff)
  if s[1]==2:
   string=sections[s[6]];t=b[string[4]:string[4]+string[5]]
   for off in range(s[4],s[4]+s[5],s[9]):
    n,st,other,idx,val,size=struct.unpack_from('<IBBHQQ',b,off)
    if not n:continue
    text=name(t,n)
    if idx==0:undefined.add(text)
    elif st>>4==1:defined.add(text)
 return dict(**row(p),type='ET_REL',machine=183,alloc_sections=alloc,relocation_types=sorted(relocs),undefined_symbols=sorted(undefined),defined_global_symbols=sorted(defined),executed=False)
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--verify',action='store_true');a=ap.parse_args();lock=HERE/'SOURCE_SHA256.json'
 if a.verify:
  j=json.loads(lock.read_text());assert all(row(ROOT/x['path'])==x for x in j['files']);print(json.dumps(dict(hash_rows=len(j['files']),passed=True,source_sha256=row(lock)['sha256'])));return
 assert not lock.exists()and not(HERE/'LINK_OVERLAY.json').exists()
 build=ROOT/'analysis/firmware'/BUILD_DIR;commands=json.loads((build/'COMMANDS.json').read_text());assert all(c['exit_code']==0 for c in commands)
 labels=[c['label']for c in commands];assert 'target_compile_only'in labels
 for variant in(['normal','san','tsan']if EXECUTOR else['normal','san']):assert any(c['label'].endswith(variant)and c['label'].startswith('run_actual_')for c in commands)
 previous=info(OLD);replacement=info(build/(STEM+'.o'));assert previous['defined_global_symbols']==replacement['defined_global_symbols'];assert set(replacement['undefined_symbols']).issubset(set(previous['undefined_symbols']))
 refs=[ROOT/'tools/firmware'/OLD_DIR/x for x in('SOURCE_SHA256.json','LINK_INPUT.json')]
 overlay=dict(schema='iq4_f3_executor02_single_object_overlay'if EXECUTOR else'iq4_f3_coordinator07_single_object_overlay',replace_only=previous,replacement=replacement,original_references=[row(p)for p in refs],ABI_layout_unchanged=True,public_symbol_names_unchanged=True,no_new_aliases=True,new_BL=[],additional_aliases=[],source_manifest_path=str(lock.relative_to(ROOT)),target_executed=False,SDK_invoked=False,camera_access=False)
 (HERE/'LINK_OVERLAY.json').write_text(json.dumps(overlay,indent=2)+'\n')
 dep=(build/(STEM+'.d')).read_text().replace('\\\n',' ');dependencies=[Path(p).resolve()for p in shlex.split(dep.split(':',1)[1])];assert all(p.is_relative_to(ROOT)for p in dependencies)
 files=[p for p in HERE.iterdir()if p.is_file()and p.name not in('SOURCE_SHA256.json','PACKAGE.json')]+[build/x for x in('BUILD.json','COMMANDS.json','DELTA.diff',STEM+'.o',STEM+'.d')]+dependencies+refs+[OLD,ROOT/'tools/firmware'/OLD_DIR/(STEM+'.cpp')]
 if EXECUTOR:
  old_fixture=ROOT/'tools/firmware/f3_native_executor_01/test_executor.cpp';expected=old_fixture.read_text()
  for h in('executor.h','native_calls.h','pins.h'):expected=expected.replace('#include "'+h+'"','#include "../f3_native_executor_01/'+h+'"')
  expected=expected.replace('int main()','int inherited_executor_regressions()');expected=expected[:-3]+'\n return 0;\n}\n';assert expected==(HERE/'inherited_fixture_02.inc').read_text()
  files+=[old_fixture,ROOT/'tools/firmware/native_activity_01/activity.c']
 rows=[row(p)for p in sorted(set(files))]
 lock.write_text(json.dumps(dict(schema='iq4_f3_executor02_frozen_source'if EXECUTOR else'iq4_f3_coordinator07_frozen_source',files=rows,source_scope='MMD compile closure plus focused host fixture and reference records; upstream reference manifests are not recursively revalidated',host_variants=3 if EXECUTOR else 2,host_focused_groups=8 if EXECUTOR else 11,inherited_groups=17 if EXECUTOR else 0,target_executed=False,SDK_invoked=False,camera_access=False),indent=2)+'\n')
 out=ROOT/'build'/(HERE.name+'_source_01');assert not out.exists();out.mkdir(parents=True)
 archive=out/('IQ4_F3_Executor_02_Source_01.zip'if EXECUTOR else'IQ4_F3_Coordinator_07_Source_01.zip')
 members=[ROOT/x['path']for x in rows]+[lock]
 with zipfile.ZipFile(archive,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9)as z:
  for p in sorted(members):
   item=zipfile.ZipInfo(str(p.relative_to(ROOT)),date_time=(2026,10,5,0,0,0));item.external_attr=0o100644<<16;item.compress_type=zipfile.ZIP_DEFLATED;z.writestr(item,p.read_bytes())
 package=dict(source=row(lock),link=row(HERE/'LINK_OVERLAY.json'),archive=row(archive),members=len(members),target_executed=False,SDK_invoked=False,camera_access=False)
 (HERE/'PACKAGE.json').write_text(json.dumps(package,indent=2)+'\n');print(json.dumps(package))
if __name__=='__main__':main()
