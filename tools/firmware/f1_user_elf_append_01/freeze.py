#!/usr/bin/env python3
"""Freeze local append backend/evidence; firmware/library bytes are references."""
from pathlib import Path
import argparse,hashlib,json,zipfile
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f1_user_elf_append_static_01';SOURCE=HERE/'SOURCE_SHA256.json'
def sha(data):return hashlib.sha256(data).hexdigest()
def row(p):data=p.read_bytes();return {'bytes':len(data),'sha256':sha(data)}
def inventory():
    files={}
    for directory in (HERE,OUT):
        for p in sorted(directory.iterdir()):
            if not p.is_file() or p==SOURCE or p.suffix in ('.o','.bin','.elf','.pyc'):continue
            files[str(p.relative_to(ROOT))]=row(p)
    references={}
    paths=['tools/target/toolchain.lock.json',
      'tools/firmware/f1_user_ui_entry_01/SOURCE_SHA256.json','tools/firmware/f1_user_ui_entry_02/SOURCE_SHA256.json',
      'tools/firmware/f1_stock_display_payload_12/SOURCE_SHA256.json','tools/firmware/user_only_package_stock_wrapper_02/SOURCE_SHA256.json',
      'analysis/firmware/extracted/P1Linux_6.03.21.bin','analysis/firmware/extracted/Boot_4.00.13.bin',
      'analysis/firmware/f1_user_ui_entry_01/libstdcxx_original_ANALYSIS_ONLY.elf',
      'build/f1_user_elf_candidate_01/P1Linux_IQ4_F1_6.03.22.bin','build/f1_user_elf_candidate_02/P1Linux_IQ4_F1_6.03.22.bin',
      'deploy/f1_card_candidate_01/IQ4_F1_Mask_6.03.19_CANDIDATE.fwp','deploy/f1_card_candidate_01/IQ4-user-only.fwr','deploy/f1_card_candidate_01/PLAN.json']
    for name in paths:references[name]=row(ROOT/name)
    for name in ('ACTUAL_INPUT_LOCK.json','ACTUAL_INPUT_LOCK_UI02.json'):
        lock=json.loads((OUT/name).read_text())
        for r in lock['objects']+lock['support_evidence']:references[r['path']]=row(ROOT/r['path'])
    return {'schema':'iq4_f1_user_elf_append_source_01','files':files,'references_not_in_source_zip':references,
      'own_host_tests':21,'candidate_revision':'UI02 + display12','target_executed':False,'camera_access':False,
      'package_installed':False,'recovery_verified':False}
def verify():
    r=json.loads(SOURCE.read_text());count=0
    for group in ('files','references_not_in_source_zip'):
        for name,want in r[group].items():
            actual=row(ROOT/name)
            if actual!=want:raise ValueError('frozen identity differs '+name)
            count+=1
    print(json.dumps({'verified_rows':count,'source_sha256':sha(SOURCE.read_bytes()),'target_executed':False}))
def main():
    a=argparse.ArgumentParser(description=__doc__);a.add_argument('--validate',action='store_true');a.add_argument('--zip',type=Path);x=a.parse_args()
    if not SOURCE.exists():SOURCE.write_text(json.dumps(inventory(),indent=2,sort_keys=True)+'\n')
    verify()
    if x.zip:
        if x.zip.exists():raise ValueError('fresh source ZIP required')
        x.zip.parent.mkdir(parents=True,exist_ok=True);r=json.loads(SOURCE.read_text())
        with zipfile.ZipFile(x.zip,'x',compression=zipfile.ZIP_DEFLATED,compresslevel=9)as z:
            for name in sorted(list(r['files'])+[str(SOURCE.relative_to(ROOT))]):
                info=zipfile.ZipInfo(name,(2026,10,5,0,0,0));info.compress_type=zipfile.ZIP_DEFLATED;info.external_attr=0o100644<<16;z.writestr(info,(ROOT/name).read_bytes())
        print(json.dumps({'zip':str(x.zip),'bytes':x.zip.stat().st_size,'sha256':sha(x.zip.read_bytes())}))
if __name__=='__main__':main()
