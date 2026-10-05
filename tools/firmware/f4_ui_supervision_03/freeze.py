#!/usr/bin/env python3
"""Own-source snapshot/verify only. Never deploy, start target, SDK or camera."""
import argparse,difflib,hashlib,json,zipfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;ENTRY=HERE.parent/'f4_ram_counter_entry_03';OUT=ROOT/'analysis/sdk_reference/f4_ui_supervision_host_03'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def item(p):return {'bytes':p.stat().st_size,'sha256':sha(p)}
def write(p,x):p.write_text(json.dumps(x,indent=2)+'\n')
def verify(files):
 for name,record in files.items():
  p=ROOT/name;wanted=record if isinstance(record,str) else record['sha256']
  if sha(p)!=wanted:raise ValueError('snapshot mismatch: '+name)
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--verify',action='store_true');args=ap.parse_args();manifest=OUT/'manifest.json';source=HERE/'SOURCE_SHA256.json'
 if args.verify:
  m=json.loads(manifest.read_text());verify(m['files']);verify(m['frozen_references']);verify(m['ignored_rebuildable_binary_artifacts']);print('supervision03 snapshot verified; zero target execution');return
 if source.exists() or manifest.exists():raise SystemExit('Existing frozen snapshot: use --verify; do not replace')
 oldb=ROOT/'tools/firmware/f4_ui_bootstrap_02/SOURCE_SHA256.json';oldr=ROOT/'analysis/firmware/f4_ram_entry_02/manifest.json'
 bm=json.loads(oldb.read_text());rm=json.loads(oldr.read_text());verify(bm['files']);verify(bm['frozen_references']);verify(rm['files']);verify(rm['frozen_dependencies'])
 refs=[oldb,oldr,ROOT/'tools/firmware/f4_ui_counter_01/SOURCE_SHA256.json',ROOT/'tools/firmware/f4_ui_counter_01/counter.cpp',ROOT/'tools/firmware/f4_ui_counter_01/counter.hpp',ROOT/'tools/target/toolchain.lock.json',ROOT/'analysis/sdk_reference/F4_UI_BOOTSTRAP_02.md',ROOT/'analysis/sdk_reference/f4_ui_bootstrap_static_02/manifest.json',ROOT/'analysis/firmware/F4_RAM_ENTRY_IMPLEMENTATION_02.md',ROOT/'analysis/firmware/F4_RAM_ONE_SHOT_ENTRY_STATIC.md',ROOT/'analysis/sdk_reference/NATIVE_USER_EXIT_STATIC.md']
 pairs=[(ROOT/'tools/firmware/f4_ui_bootstrap_02'/n,HERE/n) for n in ['bootstrap.cpp','bootstrap.hpp','runtime_linux.cpp','test_bootstrap.cpp','test_production_reject.cpp','sha256.h']]+[(ROOT/'tools/firmware/f4_ram_entry_02'/n,ENTRY/n) for n in ['entry.c','config.preview.h','sha256.h','test_entry.py']]
 delta={}
 for old,new in pairs:
  name=new.parent.name+'_'+new.name+'.diff';p=OUT/name;p.write_text(''.join(difflib.unified_diff(old.read_text().splitlines(True),new.read_text().splitlines(True),fromfile=str(old.relative_to(ROOT)),tofile=str(new.relative_to(ROOT)))))
  refs.append(old);delta[str(new.relative_to(ROOT))]={'original':str(old.relative_to(ROOT)),'original_sha256':sha(old),'new_sha256':sha(new),'diff':str(p.relative_to(ROOT)),'diff_sha256':sha(p),'identical':old.read_bytes()==new.read_bytes()}
 sources=[p for parent in [HERE,ENTRY] for p in sorted(parent.iterdir()) if p.is_file() and p.name!='SOURCE_SHA256.json']
 report=ROOT/'analysis/sdk_reference/F4_UI_SUPERVISION_03.md';sources.append(report)
 s={'schema':'iq4_f4_ui_ram_supervision_source03','camera_operations':False,'target_executed':False,'default_enabled':False,'enabled_generator_or_staging_plan_present':False,'files':{str(p.relative_to(ROOT)):item(p) for p in sources},'frozen_references':{str(p.relative_to(ROOT)):item(p) for p in sorted(set(refs))},'mechanical_original_delta':delta};write(source,s)
 binaries=[p for p in OUT.iterdir() if p.is_file() and (p.suffix in ['.o','.so'] or p.name.startswith('host_'))]
 evidence=[p for p in OUT.iterdir() if p.is_file() and p not in binaries and p.name!='manifest.json']
 files=sources+[source]+evidence
 m={'schema':'iq4_f4_ui_ram_supervision_freeze03','evidence_level':'own_host_and_cross_compile_only','device_accessed':False,'sdk_loaded':False,'vendor_code_executed':False,'target_executed':False,'runtime_or_recovery_accepted':False,'files':{str(p.relative_to(ROOT)):item(p) for p in sorted(set(files))},'frozen_references':s['frozen_references'],'ignored_rebuildable_binary_artifacts':{str(p.relative_to(ROOT)):item(p) for p in sorted(binaries)}};write(manifest,m)
 package=ROOT/'build/f4_ui_supervision_source_03/IQ4_F4_UI_Supervision_Source_03.zip';package.parent.mkdir(parents=True,exist_ok=True)
 members=sources+[source,manifest,ROOT/'tools/firmware/f4_ui_counter_01/counter.cpp',ROOT/'tools/firmware/f4_ui_counter_01/counter.hpp',ROOT/'tools/target/toolchain.lock.json']+evidence
 with zipfile.ZipFile(package,'w',zipfile.ZIP_DEFLATED,compresslevel=9) as z:
  for p in sorted(set(members)):
   zi=zipfile.ZipInfo(str(p.relative_to(ROOT)),date_time=(2026,10,4,0,0,0));zi.compress_type=zipfile.ZIP_DEFLATED;zi.external_attr=0o100644<<16;z.writestr(zi,p.read_bytes())
 print(json.dumps({'source_manifest':item(source),'evidence_manifest':item(manifest),'source_zip':item(package),'source_zip_path':str(package.relative_to(ROOT)),'zip_members':len(set(members)),'frozen_old_sources_verified':True}))
if __name__=='__main__':main()
