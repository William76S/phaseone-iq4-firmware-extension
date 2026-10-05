"""Freeze source/references with no SDK/target execution; thereafter verify only."""
from pathlib import Path
import argparse,hashlib,json,os,zipfile
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2];NATIVE=ROOT/'tools/sdk/f1_restore_baseline_native_03';OUT=ROOT/'analysis/sdk_reference/f1_restore_baseline03_host';DOC=ROOT/'analysis/sdk_reference/F1_RESTORE_BASELINE_03.md'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def row(p,base):return {'name':os.path.relpath(p,base),'size':p.stat().st_size,'sha256':sha(p)}
def check(p,m):
 for key in ('files','external_compile_dependencies','frozen_refs'):
  for r in m.get(key,[]):
   f=p.parent/r['name'];assert f.is_file()and f.stat().st_size==r['size']and sha(f)==r['sha256'],str(f)
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--verify',action='store_true');a=ap.parse_args();locks=[NATIVE/'SOURCE_SHA256.json',HERE/'SOURCE_SHA256.json']
 if a.verify:
  for p in locks:check(p,json.loads(p.read_text()))
  print('Frozen baseline03 source/reference identities PASS; SDK/target/device starts 0');return
 assert not any(p.exists()for p in locks),'Frozen; use verify or a new increment'
 old=NATIVE.parent/'readonly_octets_native_01';oldlock=old/'SOURCE_SHA256.json';assert sha(oldlock)=='f0ba84571dc2274d07f42a1ea69e3dfc1d24d9e88cfc427336cd1bed729729bc';oldm=json.loads(oldlock.read_text());check(oldlock,oldm)
 # The original byte closure is reused for one compile, including exact fixed
 # SDK package identity. New source/header paths are added, not overwritten.
 deps={old/r['name']for r in oldm['external_compile_dependencies']};deps|={old/'profiles.hpp',old/'readonly_once.cpp',old/'BuildDriver.ps1',oldlock};deps|={p for p in HERE.iterdir()if p.is_file()and p.name!='SOURCE_SHA256.json'}
 nm={'schema_version':1,'state':'frozen_source_only_pending_Root_controller_derive_Windows_build_actual_PE_review','files':[row(p,NATIVE)for p in sorted(NATIVE.iterdir())if p.is_file()], 'external_compile_dependencies':[row(p,NATIVE)for p in sorted(deps)],'original_octets_manifest_sha256':sha(oldlock),'readiness_v3_source_manifest_sha256':'51d5340f0558c8cbab9b5ece4b4122dc5d203e76bd3128d60744221457397ee8','vendor_static_library_sha256':'7947704d50d6c2797d9ade2e0977a12102c5af41a67f37611d8116c5ff5395fb','native_changed_lines':3,'new_SDK_ABI':False,'Read_only':True,'Windows_native_built':False,'SDK_or_camera_started':False}
 locks[0].write_text(json.dumps(nm,indent=2)+'\n')
 refs={NATIVE/r['name']for r in nm['files']+nm['external_compile_dependencies']};refs|={locks[0],DOC};refs|={p for p in OUT.iterdir()if p.is_file()and p.suffix in ('.json','.txt')}
 refs-=set(HERE.iterdir());fm={'schema_version':1,'state':'frozen_host_and_static_only','files':[row(p,HERE)for p in sorted(HERE.iterdir())if p.is_file()and p.name!='SOURCE_SHA256.json'],'frozen_refs':[row(p,HERE)for p in sorted(refs)],'actual_data_generated':False,'target_helper_staged_or_executed':False,'native_SDK_started':False,'camera_control_commands':0,'camera_write_commands':0,'cold_recovery_verified':False,'stock_respawn_verified':False,'UI_owner_or_geometry_verified':False,'mask_enabled':False}
 locks[1].write_text(json.dumps(fm,indent=2)+'\n')
 for p in locks:check(p,json.loads(p.read_text()))
 package=ROOT/'build/f1_restore_baseline03_source_01';package.mkdir(parents=True,exist_ok=True);archive=package/'IQ4_F1_Restore_Baseline03_Source_01.zip'
 allpaths={HERE/r['name']for r in fm['files']+fm['frozen_refs']};allpaths|={locks[1]}
 with zipfile.ZipFile(archive,'w',zipfile.ZIP_DEFLATED)as z:
  for p in sorted(allpaths):z.write(p,str(p.relative_to(ROOT)))
 with zipfile.ZipFile(archive)as z:
  for p in allpaths:assert z.read(str(p.relative_to(ROOT)))==p.read_bytes()
 info={'baseline_source_sha256':sha(locks[1]),'native_source_sha256':sha(locks[0]),'archive':str(archive.relative_to(ROOT)),'bytes':archive.stat().st_size,'sha256':sha(archive),'members':len(allpaths),'members_byte_verified':True,'SDK_or_camera_access':False,'target_executed':False,'native_Windows_build':False}
 (package/'PACKAGE.json').write_text(json.dumps(info,indent=2)+'\n');print(json.dumps(info,indent=2))
if __name__=='__main__':main()
