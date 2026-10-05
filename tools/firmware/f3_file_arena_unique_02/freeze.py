#!/usr/bin/env python3
"""Freeze a finite replacement and inspect ELF metadata without executing ELF."""
import argparse,hashlib,json,shlex,struct
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
FS=HERE.name=='f3_native_fs_unique_06'
OLD=ROOT/('analysis/firmware/f3_native_card_bridge_build_06/fs05.o'if FS else'analysis/firmware/f3_file_arena_build_01/arena.o')
NAME='fs06'if FS else'arena02'
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
 ap=argparse.ArgumentParser();ap.add_argument('--verify',action='store_true');ap.add_argument('--build',type=Path);a=ap.parse_args();lock=HERE/'SOURCE_SHA256.json'
 if a.verify:
  assert a.build is None;j=json.loads(lock.read_text());assert all(row(ROOT/x['path'])==x for x in j['files']);print(json.dumps(dict(hash_rows=len(j['files']),passed=True,source_sha256=row(lock)['sha256'])));return
 assert a.build is not None and not lock.exists() and not(HERE/'LINK_OVERLAY.json').exists()
 build=a.build.resolve();assert build.is_relative_to(ROOT)
 report=json.loads((build/'BUILD.json').read_text());assert len(report['objects'])==1 and len(report['host'])==2
 for x in report['source']+report['original_inputs']['files']:assert row(ROOT/x['path'])==x
 for test in report['host']:assert test['result'].get('groups',test['result'].get('actual_host_file_groups'))==(14 if FS else 17)
 commands=json.loads((build/'COMMANDS.json').read_text());assert commands and all(c['exit']==0 for c in commands)
 previous=info(OLD);replacement=info(build/(NAME+'.o'))
 assert previous['defined_global_symbols']==replacement['defined_global_symbols']
 assert set(replacement['undefined_symbols']).issubset(set(previous['undefined_symbols']))
 overlay=dict(schema='iq4_f3_fs06_single_object_overlay'if FS else'iq4_f3_arena02_single_object_overlay',replace_only=previous,replacement=replacement,ABI_layout_unchanged=True,public_symbol_names_unchanged=True,no_new_aliases=True,new_BL=[],additional_aliases=[],max_name_candidates=4096,prior_files_never_adopted_or_deleted=True,SDK_invoked=False,camera_access=False,target_executed=False)
 (HERE/'LINK_OVERLAY.json').write_text(json.dumps(overlay,indent=2)+'\n')
 dep=(build/(NAME+'.d')).read_text().replace('\\\n',' ');dependencies=[Path(p).resolve()for p in shlex.split(dep.split(':',1)[1])];assert all(p.is_relative_to(ROOT)for p in dependencies)
 files=[p for p in HERE.iterdir()if p.is_file()and p.name!='SOURCE_SHA256.json']+[build/x for x in ('BUILD.json','COMMANDS.json','DELTA.diff',NAME+'.o',NAME+'.d')]+[ROOT/x['path']for x in report['original_inputs']['files']]+dependencies+[OLD]
 lock.write_text(json.dumps(dict(schema='iq4_f3_unique_name_source_freeze_01',files=[row(p)for p in sorted(set(files))],host_variants=2,host_groups_each=14 if FS else 17,target_executed=False,camera_access=False,SDK_invoked=False),indent=2)+'\n')
 print(json.dumps(dict(source=row(lock),overlay=row(HERE/'LINK_OVERLAY.json'),replacement=replacement)))
if __name__=='__main__':main()
