#!/usr/bin/env python3
"""Freeze public source/file evidence only; never original/candidate firmware bytes."""
import argparse,hashlib,json,zipfile
from pathlib import Path
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2];E=ROOT/'analysis/firmware/stock_fwp_sample_review_01';BASE=HERE.parent/'user_only_package_01'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def paths():
 own={p for p in HERE.iterdir()if p.is_file()and p.name!='SOURCE_SHA256.json'}
 refs={BASE/'package.py',BASE/'SOURCE_SHA256.json',ROOT/'analysis/firmware/FIRMWARE_PACKAGE_ACCEPTANCE_STATIC_01.md'}
 public={E/'SAMPLE_REVIEW.json',E/'REVIEW.md',E/'manifest.json',E/'stock_manifest.xml',E/'User_private_headers.txt',E/'User_DT_INIT.txt',E/'repro_01/INSPECTION.json'}
 return sorted(own|refs|public)
def manifest():return dict(schema='iq4_actual_stock_wrapper_source_manifest_v2',evidence_level='offline_static_file_and_host_only',original_or_candidate_firmware_included=False,firmware_or_SDK_executed=False,camera_access=False,device_acceptance_or_recovery_verified=False,F1_payload_implemented_here=False,files={p.relative_to(ROOT).as_posix():dict(bytes=p.stat().st_size,sha256=sha(p))for p in paths()})
def verify():
 m=json.loads((HERE/'SOURCE_SHA256.json').read_text());assert m==manifest()
 for name,r in m['files'].items():p=ROOT/name;assert p.stat().st_size==r['bytes']and sha(p)==r['sha256']
 return m

def main():
 a=argparse.ArgumentParser(description=__doc__);a.add_argument('--freeze',action='store_true');a.add_argument('--verify',action='store_true');a.add_argument('--source-zip',type=Path);x=a.parse_args()
 if x.freeze:
  if (HERE/'SOURCE_SHA256.json').exists():raise ValueError('never overwrite frozen source')
  (HERE/'SOURCE_SHA256.json').write_text(json.dumps(manifest(),indent=2)+'\n')
 if not(x.freeze or x.verify):a.error('explicit freeze or verify')
 m=verify();out=dict(source_manifest_sha256=sha(HERE/'SOURCE_SHA256.json'),source_rows=len(m['files']),camera_access=False,target_executed=False)
 if x.source_zip:
  x.source_zip.parent.mkdir(parents=True,exist_ok=True);names=sorted([*m['files'],(HERE/'SOURCE_SHA256.json').relative_to(ROOT).as_posix()])
  with zipfile.ZipFile(x.source_zip,'x',compression=zipfile.ZIP_DEFLATED,compresslevel=9)as z:
   for n in names:
    if Path(n).suffix not in('.py','.md','.txt','.xml','.json'):raise ValueError('source-only extension')
    i=zipfile.ZipInfo(n,(1980,1,1,0,0,0));i.compress_type=zipfile.ZIP_DEFLATED;i.external_attr=0o100644<<16;z.writestr(i,(ROOT/n).read_bytes())
  with zipfile.ZipFile(x.source_zip)as z:assert z.namelist()==names and z.testzip()is None
  out.update(ZIP_members=len(names),ZIP_bytes=x.source_zip.stat().st_size,ZIP_sha256=sha(x.source_zip))
 print(json.dumps(out))
if __name__=='__main__':main()
