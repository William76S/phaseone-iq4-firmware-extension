#!/usr/bin/env python3
import argparse,hashlib,json,re,shlex,zipfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];OWN=Path(__file__).resolve().parent
DIRS=[OWN,ROOT/'tools/firmware/f4_native_source_04',ROOT/'tools/firmware/f4_native_session_04',ROOT/'tools/firmware/f4_native_entry_04',ROOT/'tools/firmware/f4_native_menu_04']
def row(p):b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def closure(seeds):
 done=set();pending=list(seeds)
 while pending:
  p=pending.pop().resolve()
  if p in done:continue
  assert p.is_relative_to(ROOT)and p.is_file(),p;done.add(p)
  if p.suffix in {'.c','.cpp','.h'}:
   for inc in re.findall(r'^\s*#\s*include\s*"([^"]+)"',p.read_text(),re.M):pending.append(p.parent/inc)
 return done

def main():
 p=argparse.ArgumentParser();p.add_argument('--build',type=Path,required=True);a=p.parse_args();out=a.build.resolve();assert out.is_relative_to(ROOT);b=json.loads((out/'BUILD.json').read_text());assert b['target_executed']is False and all(q['exit']==0 for q in json.loads((out/'COMMANDS.json').read_text()))
 source=OWN/'SOURCE_SHA256.json';link=OWN/'LINK_OVERLAY.json';assert not source.exists()and not link.exists()
 previous=[ROOT/'analysis/firmware/f4_native_source_build_03/source.o',ROOT/'analysis/firmware/f4_native_source_build_02_release_complete/session.o',ROOT/'analysis/firmware/f4_native_entry_build_03/entry.o',ROOT/'analysis/firmware/f4_native_source_build_02_release_complete/menu.o']
 # Precise previous final rows: never object-name-only replacement.
 for p in previous:assert p.is_file(),p
 overlay=dict(schema='iq4_f4_native_diagnostics04_overlay',replacements=[dict(replace_only=row(old),replacement=row(out/(name+'.o')))for old,name in zip(previous,['source','session','entry','menu'])],additional_objects=[],public_ABI02_03_unchanged=True,native_start_added=False,original_native_bindings_unchanged=True,target_executed=False)
 link.write_text(json.dumps(overlay,indent=2)+'\n')
 files=sorted({p for d in DIRS for p in d.iterdir()if p.is_file()and p.name not in {'SOURCE_SHA256.json'}})
 refs=set()
 # Real preprocessed compilation closure, not inactive JPEG_INTERNALS includes.
 for dep in out.glob('*.d'):
  fields=shlex.split(dep.read_text().replace('\\\n',' '));assert fields[0].endswith(':')
  for raw in fields[1:]:
   q=Path(raw).resolve()
   if q.is_relative_to(ROOT)and not q.is_relative_to(ROOT/'build/toolchains'):refs.add(q)
 refs.add(ROOT/'tools/firmware/native_activity_01/activity.c');refs-=set(files)
 for q in refs:assert q.is_file(),q
 for d in ['f4_native_source_02','f4_native_source_03','f4_native_entry_03','f4_native_menu_03']:
  for name in ['SOURCE_SHA256.json','LINK_OVERLAY.json','LINK_INPUT.json']:
   p=ROOT/'tools/firmware'/d/name
   if p.exists():refs.add(p)
 artifacts=sorted(p for p in out.iterdir()if p.is_file()and not p.name.endswith(('normal','asan_ubsan')))
 data=dict(schema='iq4_f4_native_diagnostics04_source',files=[row(p)for p in files],references=[row(p)for p in sorted(refs)],artifacts=[row(p)for p in artifacts],target_executed=False,sdk_loaded=False,camera_access=False)
 source.write_text(json.dumps(data,indent=2)+'\n')
 zipout=ROOT/'build/f4_native_diagnostics_source_04/IQ4_F4_Native_Diagnostics_04_Source.zip';zipout.parent.mkdir(parents=True,exist_ok=True);assert not zipout.exists()
 with zipfile.ZipFile(zipout,'w',zipfile.ZIP_DEFLATED,compresslevel=9)as z:
  for p in sorted(set(files)|refs|set(artifacts)|{source}):
   i=zipfile.ZipInfo(str(p.relative_to(ROOT)),(2026,10,5,0,0,0));i.external_attr=0o100644<<16;i.compress_type=zipfile.ZIP_DEFLATED;z.writestr(i,p.read_bytes())
 receipt=dict(schema='iq4_f4_native_diagnostics04_freeze',source=row(source),overlay=row(link),zip=row(zipout),hash_rows=len(files)+len(refs)+len(artifacts),host_runs=len(b['tests']),target_executed=False,camera_access=False)
 (out/'FREEZE_RECEIPT.json').write_text(json.dumps(receipt,indent=2)+'\n');print(json.dumps(receipt,indent=2))
if __name__=='__main__':main()
