#!/usr/bin/env python3
"""Freeze own code/compile header closure/results; never target or vendor execution."""
from pathlib import Path
import hashlib,json,zipfile,shlex
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
CONFIG={'art': 'analysis/firmware/f3_source_dependencies_build_02', 'objects': ['dependencies'], 'refs': ['tools/firmware/f3_source_dependencies_01/SOURCE_SHA256.json', 'tools/firmware/f3_source_dependencies_01/dependencies.hpp', 'tools/firmware/f3_saved_raw_capture_01/ORIGINAL_BINDINGS.json'], 'overlay': 'replace SourceDeps01 dependencies.o only; exact actual B target required'}
NAME=HERE.name
def row(p):
 b=p.read_bytes();return dict(path=p.relative_to(ROOT).as_posix(),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 owned={p for p in HERE.iterdir()if p.is_file()and p.name not in('SOURCE_SHA256.json','LINK_INPUT.json')}
 artdir=ROOT/CONFIG['art'];arts={p for p in artdir.iterdir()if p.is_file()}
 if CONFIG.get('static'):arts|={p for p in(ROOT/CONFIG['static']).iterdir()if p.is_file()}
 refs={ROOT/p for p in CONFIG['refs']}
 for p in artdir.glob('*.d'):
  text=p.read_text().replace('\\\n',' ');rest=text.split(':',1)[1]
  for name in shlex.split(rest):
   q=Path(name);q=(q if q.is_absolute()else ROOT/q).resolve()
   if q.is_file()and q.is_relative_to(ROOT)and q not in owned:refs.add(q)
 # Preserve Export03's full27-member closure, not only the two overlay objects.
 if NAME=='f3_save_coordinator_06':
  for revision in('03','04'):
   lock=ROOT/f'tools/firmware/f3_stream_export_{revision}/SOURCE_SHA256.json';j=json.loads(lock.read_text())
   for r in j.get('members',j.get('files',[])):
    p=ROOT/r['path'];assert row(p)==r,r['path'];refs.add(p)
 lock=dict(schema='iq4_'+NAME+'_source',files=[row(p)for p in sorted(owned)],references=[row(p)for p in sorted(refs)],artifacts=[row(p)for p in sorted(arts)],own_compile_header_closure=True,external_dependency_manifests_require_existing_frozen_project=True,target_executed=False,sdk_loaded=False,device_connected=False)
 (HERE/'SOURCE_SHA256.json').write_text(json.dumps(lock,indent=2)+'\n')
 objects=[ROOT/CONFIG['art']/(n+'.o')for n in CONFIG['objects']]
 link=dict(schema='iq4_'+NAME+'_link',source=row(HERE/'SOURCE_SHA256.json'),objects=[row(p)for p in objects],reference_manifests=[row(p)for p in sorted(refs)if p.name in('SOURCE_SHA256.json','SOURCE.json','LINK_INPUT.json','LINK_OVERLAY.json')],integration=CONFIG['overlay'],target_executed=False)
 if CONFIG.get('bindings'):link['original_bindings']=row(HERE/CONFIG['bindings'])
 (HERE/'LINK_INPUT.json').write_text(json.dumps(link,indent=2)+'\n')
 dest=ROOT/('build/'+NAME+'_source_01')/('IQ4_'+NAME+'_Source_01.zip');dest.parent.mkdir(parents=True,exist_ok=True)
 members=owned|refs|arts|{HERE/'SOURCE_SHA256.json',HERE/'LINK_INPUT.json'}
 with zipfile.ZipFile(dest,'w',compression=zipfile.ZIP_DEFLATED)as z:
  for p in sorted(members):z.write(p,p.relative_to(ROOT).as_posix())
 print(json.dumps(dict(source=row(HERE/'SOURCE_SHA256.json'),link=row(HERE/'LINK_INPUT.json'),zip=row(dest),hash_rows=len(owned|refs|arts),target_executed=False)))
if __name__=='__main__':main()
